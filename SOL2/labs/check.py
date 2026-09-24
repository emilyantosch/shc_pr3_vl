"""Check the 16 lab PDFs from compile_labs. Requires PyMuPDF."""
import sys
from pathlib import Path

import pymupdf

paths = [Path(arg) for arg in sys.argv[1:]]
assert len(paths) == 16, "Usage: check.py labs/lab*/*_rev03.pdf (one complete revision)"
seen = set()
for path in paths:
    lab = int(path.parent.name.removeprefix("lab"))
    solution = "_solution_" in path.name
    printer = "_print_" in path.name
    key = (lab, solution, printer)
    assert key not in seen, (path, "duplicate edition")
    seen.add(key)
    doc = pymupdf.open(path)
    headings = [title for _, title, _ in doc.get_toc()]
    assert sum(title == "Solution" for title in headings) == (6 if solution else 0), path
    assert sum(title.startswith("Task ") for title in headings) == 6, path
    text = "\n".join(page.get_text() for page in doc)
    marker = ("class NameManagement", "class EnhancedNameManagement",
              "class VehicleManagementDemo", "void solveAndDisplay")[lab - 1]
    assert (marker in text) == solution, (path, "solution visibility")
    assert "Submission Deadline" in doc[0].get_text() and "Lab Execution" in doc[-1].get_text(), path
    assert len(doc[0].get_links()) >= 7, (path, "task navigation")
    assert "\ufffd" not in text, (path, "missing glyph")
    for page in doc:
        assert abs(page.rect.width - 595.28) < .1 and abs(page.rect.height - 841.89) < .1, path
        corner = page.get_pixmap(clip=pymupdf.Rect(0, 0, 32, 32))
        colors = {corner.pixel(x, y) for x in range(32) for y in range(32)}
        if printer:
            assert colors == {(255, 255, 255)}, (path, "print background")
            for drawing in page.get_drawings():
                if drawing["rect"].width > 5 and drawing["rect"].height > 5:
                    assert drawing["fill"] in (None, (1, 1, 1)), (path, "shaded print panel")
        else:
            assert len(colors) > 1 and (255, 255, 255) not in colors, (path, "digital dot grid")
        assert len(page.get_text().split()) > 10, (path, page.number + 1, "nearly empty page")
        footer = page.get_text(clip=pymupdf.Rect(page.rect.width - 100, page.rect.height - 40,
                                               page.rect.width, page.rect.height))
        assert "".join(footer.split()) == f"{page.number + 1}/{len(doc)}", (path, "footer")
        for block in page.get_text("dict")["blocks"]:
            for line in block.get("lines", []):
                for span in line["spans"]:
                    x0, y0, x1, y1 = span["bbox"]
                    # Allow glyph overhang while retaining printable margins and footer clearance.
                    assert 51 < x0 < x1 < page.rect.width - 50, (path, page.number + 1, span)
                    assert 20 < y0 < y1 < page.rect.height - 18, (path, page.number + 1, span)
                    if span["size"] > 9.1:
                        assert y1 < page.rect.height - 56, (path, "footer collision", span)
        for image in page.get_image_info():
            assert page.rect.contains(pymupdf.Rect(image["bbox"])), (path, "image bounds")
        for font in page.get_fonts():
            assert any(name in font[3] for name in ("SourceSans3", "LibertinusSerif", "JetBrainsMono")), (path, font)
            assert doc.extract_font(font[0])[3], (path, "unembedded font")
    if printer:
        with pymupdf.open(path.with_name(path.name.replace("_print_", "_digital_"))) as digital:
            assert len(doc) == len(digital), (path, "pagination differs")
            for a, b in zip(doc, digital):
                assert a.get_text("words") == b.get_text("words"), (path, "content/layout differs")
    print(f"PASS {path.name}: {len(doc)} pages")
assert seen == {(lab, solution, printer) for lab in range(1, 5)
                for solution in (False, True) for printer in (False, True)}
