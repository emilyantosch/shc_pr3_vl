"""Compile and check all course slides. Requires Typst and PyMuPDF."""
import re
import subprocess
import tempfile
from pathlib import Path

import pymupdf

ROOT = Path(__file__).resolve().parents[2]
SLIDES = {
    "SOL2": (49, 75, 86, 78, 64, 40, 53, 47, 42, 50),
    "databases": (68, 106, 90, 67, 92, 71, 95, 70, 56, 63),
    "SHC_PR3": (45, 66, 92, 71, 75, 35, 50, 43, 35, 43),
}

with tempfile.TemporaryDirectory(prefix="hestia-check-") as output:
    for course, counts in SLIDES.items():
        sources = sorted((ROOT / course).glob("slides_*/main.typ"),
                         key=lambda path: int(path.parent.name.split("_")[1]))
        assert len(sources) == len(counts), (course, "update the slide-count baseline")
        for source, slides in zip(sources, counts):
            content = source.read_text()
            assert 'hestia/theme.typ": *' in content and "#show: hestia-theme.with(" in content, source
            assert "university-theme" not in content, source
            pdf = Path(output) / f"{course}-{source.parent.name}.pdf"
            result = subprocess.run(
                ["typst", "compile", "--root", str(ROOT), str(source), str(pdf)],
                capture_output=True, text=True,
            )
            assert result.returncode == 0, result.stderr
            assert "unknown font family" not in result.stderr, result.stderr
            assert "did not converge" not in result.stderr, result.stderr
            with pymupdf.open(pdf) as doc:
                assert len(doc) == slides + 1 + content.count("#pause"), (source, "page/reveal count", len(doc))
                numbers = []
                for page in doc:
                    where = (source.relative_to(ROOT), page.number + 1)
                    assert abs(page.rect.width / page.rect.height - 16 / 9) < .001, where
                    corner = page.get_pixmap(clip=pymupdf.Rect(0, 0, 20, 20))
                    assert corner.pixel(16, 16) != corner.pixel(8, 8), (where, "missing dots")
                    assert any(all(abs(a - b) <= 2 for a, b in zip(corner.pixel(8, 8), color))
                               for color in ((251, 250, 247), (239, 242, 237))), (where, "palette")
                    fonts = [font[3] for font in page.get_fonts()]
                    assert any("SourceSans3" in font for font in fonts), (where, "missing Hestia font")
                    assert not any("Roboto" in font for font in fonts), (where, "legacy font")
                    spans = [s for b in page.get_text("dict")["blocks"]
                             for line in b.get("lines", []) for s in line["spans"]]
                    for span in spans:
                        bounds = pymupdf.Rect(span["bbox"])
                        assert page.rect.contains(bounds), (where, span)
                        # Footnotes sit below the body, but above the footer rule.
                        if page.number and span["size"] > 12:
                            assert bounds.y1 < page.rect.height - 30, (where, "footer collision", span)
                    for image in page.get_image_info():
                        bounds = pymupdf.Rect(image["bbox"])
                        assert page.rect.contains(bounds) and bounds.y1 < page.rect.height - 43, (where, "image bounds")
                        for span in spans:
                            text_bounds = pymupdf.Rect(span["bbox"])
                            if len(span["text"].strip()) > 2:
                                assert (bounds & text_bounds).get_area() < text_bounds.get_area() / 2, (where, "image over text", span)
                    text = page.get_text()
                    assert not re.search(r"pin\d|\ufffd", text), (where, "unresolved annotation or glyph")
                    if page.number:
                        footer_text = page.get_text(clip=pymupdf.Rect(
                            page.rect.width - 140, page.rect.height - 30,
                            page.rect.width, page.rect.height,
                        ))
                        footer = re.fullmatch(r"(\d+)/(\d+)", "".join(footer_text.split()))
                        assert footer and int(footer[2]) == slides, (where, "footer")
                        numbers.append(int(footer[1]))
                assert numbers[0] == 1 and numbers[-1] == slides, source
                assert all(b - a in (0, 1) for a, b in zip(numbers, numbers[1:])), (source, numbers)
                assert sum(a == b for a, b in zip(numbers, numbers[1:])) == content.count("#pause"), source
                print(f"PASS {source.relative_to(ROOT)}: {len(doc)} pages, {slides} slides", flush=True)
