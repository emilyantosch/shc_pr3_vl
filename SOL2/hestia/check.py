"""Check Lecture 1, light/dark smoke PDFs, and optionally Lectures 2–10. Requires PyMuPDF."""
import plistlib
import re
import sys
from pathlib import Path

import pymupdf


def contrast(foreground, background):
    def luminance(rgb):
        channels = [(rgb >> shift & 255) / 255 for shift in (16, 8, 0)]
        linear = [c / 12.92 if c <= 0.04045 else ((c + .055) / 1.055) ** 2.4 for c in channels]
        return sum(c * w for c, w in zip(linear, (.2126, .7152, .0722)))

    a, b = sorted((luminance(foreground), luminance(background)))
    return (b + .05) / (a + .05)


assert len(sys.argv) in (4, 13), "Usage: check.py LECTURE-1.pdf SMOKE-LIGHT.pdf SMOKE-DARK.pdf [LECTURES-2-TO-10.pdf...]"
for path, pages, slides in zip(sys.argv[1:4], (55, 11, 11), (49, 9, 9)):
    doc = pymupdf.open(path)
    assert len(doc) == pages, (path, "unexpected page count", len(doc))
    numbers = []
    for page in doc:
        assert abs(page.rect.width / page.rect.height - 16 / 9) < .001
        corner = page.get_pixmap(clip=pymupdf.Rect(0, 0, 20, 20))
        assert corner.pixel(16, 16) != corner.pixel(8, 8), (path, page.number + 1, "missing background dots")
        spans = [s for b in page.get_text("dict")["blocks"] if "lines" in b
                 for line in b["lines"] for s in line["spans"]]
        for span in spans:
            assert page.rect.contains(pymupdf.Rect(span["bbox"])), (path, page.number + 1, span)
            if page.number and span["size"] > 12:  # The title page has no footer.
                assert span["bbox"][3] < page.rect.height - 43, (path, page.number + 1, "footer collision", span)
        for font in page.get_fonts():
            assert any(name in font[3] for name in ("SourceSans3", "LibertinusSerif", "JetBrainsMono")), (path, font)
            assert doc.extract_font(font[0])[3], (path, "unembedded font", font)
        text = page.get_text()
        assert not re.search(r"^(?:Idea|Tip|Example)$", text, re.M), (path, page.number + 1, "legacy admonition")
        images = page.get_image_info(xrefs=True)
        # Questions omit their header; include both reveal steps explicitly.
        question_pages = (17, 18, 25, 26, 39, 40) if pages == 55 else (3, 4)
        expected_images = len(re.findall(r"^(?:Info|Memorize|Warning|Task \d+)$", text, re.M))
        expected_images += page.number + 1 in question_pages
        assert len(images) == expected_images, (path, page.number + 1, "admonition artwork")
        for image in images:
            bounds = pymupdf.Rect(image["bbox"])
            assert page.rect.contains(bounds) and bounds.y1 < page.rect.height - 43
            assert doc.extract_image(image["xref"])["smask"], (path, "missing artwork transparency")
        assert not re.search(r"pin\d|\ufffd", text), (path, "unresolved pin or missing glyph")
        assert "HAW Hamburg" not in text
        if page.number:
            footer = re.search(r"(\d+) / (\d+)\s*$", text)
            assert footer and int(footer[2]) == slides, (path, page.number + 1, "footer")
            numbers.append(int(footer[1]))
    assert numbers[0] == 1 and numbers[-1] == slides
    assert all(b - a in (0, 1) for a, b in zip(numbers, numbers[1:])), numbers
    if pages == 55:
        assert [i + 3 for i, (a, b) in enumerate(zip(numbers, numbers[1:])) if a == b] == [18, 26, 40, 50, 51]
        assert "This name is freely selectable." not in doc[48].get_text()
        assert "This name is freely selectable." in doc[49].get_text()
        assert "This method must always be called main." in " ".join(doc[50].get_text().split())
        # The QR code and the diagrams below remain vectors.
        assert not doc[42].get_image_info()
        assert any(link.get("uri", "").startswith("https://www.jetbrains.com/idea/download/")
                   for link in doc[42].get_links()), "missing IDE download link"
        for number, labels in {
            16: ("A car", "Manufacturer", "Color", "Fuel consumption"),
            20: ("Person Class", "Ines", "Max"),
            22: ("-firstName: String", "+ getSurname(): String"),
            23: ("Private attributes", "Franziska", "getSurname()", "setFirstName()"),
            27: ("Animal Class", "Dog Class", "Cat Class", "Cow Class"),
            28: ("Association", "Aggregation", "Composition"),
            30: ("Entry point", "Object A", "Object B", "Object C"),
            33: ("C++", "Smalltalk", "Java", "Syntax", "Semantics"),
            35: ("Compiler", "(javac)", "JVM", "Arch A", "Arch B", "Arch C"),
            37: ("Interpreter", "Execution of interpreted languages"),
            38: ("Compiler", "Program A", "Program B", "Execution of compiled languages"),
            44: ("Java Development Kit", "Java Runtime Environment", "Class libraries"),
        }.items():
            page = doc[number - 1]
            # The car slide also contains a Memorize illustration.
            assert len(page.get_image_info()) == int(number == 16), (number, "raster diagram")
            assert not any(d["fill"] == (1, 1, 1) and d["rect"].width > page.rect.width * .8
                           and d["rect"].height > 100 for d in page.get_drawings()), (number, "white diagram panel")
            assert all(label in page.get_text() for label in labels), (number, "missing diagram labels")
    else:
        diagram = doc[7].get_pixmap()
        paper = doc[0].get_pixmap().pixel(8, 8)
        assert (diagram.pixel(70, 130) == paper) == (path != sys.argv[3]), (path, "diagram surface")
        assert "Overlay revealed" not in doc[2].get_text()
        assert "Overlay revealed" in doc[3].get_text()
        assert "Task 1" in doc[9].get_text()
        inline = [s for b in doc[2].get_text("dict")["blocks"] if "lines" in b
                  for line in b["lines"] for s in line["spans"] if s["text"] == "Java"]
        assert inline, (path, "missing inline code")
        background = 0x1f2924 if path == sys.argv[3] else 0xfbfaf7
        assert all(contrast(s["color"], background) >= 4.5 for s in inline)
    print(f"PASS {path}: {pages} pages, {slides} numbered slides, bounds/fonts/overlays")

# Compact decks: no accidental page breaks, clipped images, or lost reveal pages.
for number, path, slides in zip(range(2, 11), sys.argv[4:], (72, 92, 72, 75, 35, 50, 42, 36, 42)):
    source = Path(__file__).parent.parent / f"slides_{number:03}" / "main.typ"
    content = source.read_text()
    assert '#import "../hestia/theme.typ": *' in content and "#show: hestia-theme.with(" in content
    doc = pymupdf.open(path)
    assert len(doc) == slides + 1 + content.count("#pause"), (path, "page/reveal count", len(doc))
    assert f"Lecture {number} -" in doc[0].get_text(), (path, "wrong lecture")
    numbers = []
    for page in doc:
        assert abs(page.rect.width / page.rect.height - 16 / 9) < .001
        color = page.get_pixmap(clip=pymupdf.Rect(8, 8, 9, 9)).pixel(0, 0)
        assert any(all(abs(a - b) <= 2 for a, b in zip(color, expected))
                   for expected in ((251, 250, 247), (239, 242, 237))), (path, "background palette", color)
        spans = [s for b in page.get_text("dict")["blocks"] if "lines" in b
                 for line in b["lines"] for s in line["spans"]]
        for span in spans:
            assert page.rect.contains(pymupdf.Rect(span["bbox"])), (path, page.number + 1, span)
            if page.number and span["size"] > 12:
                assert span["bbox"][3] < page.rect.height - 43, (path, page.number + 1, "footer collision", span)
        for image in page.get_image_info():
            bounds = pymupdf.Rect(image["bbox"])
            assert page.rect.contains(bounds) and bounds.y1 < page.rect.height - 43, (path, page.number + 1, "image bounds")
            for span in spans:
                rect = pymupdf.Rect(span["bbox"])
                if len(span["text"].strip()) > 2:
                    assert (bounds & rect).get_area() < rect.get_area() / 2, (path, page.number + 1, "image over text", span)
        fonts = [font[3] for font in page.get_fonts()]
        assert any("SourceSans3" in font for font in fonts), (path, "missing Hestia font")
        assert not any("Roboto" in font for font in fonts), (path, "legacy font")
        text = page.get_text()
        assert not re.search(r"pin\d|\ufffd", text), (path, "unresolved pin or missing glyph")
        if page.number:
            assert f"Java · Lecture {number}" in text
            footer = re.search(r"(\d+) / (\d+)\s*$", text)
            assert footer and int(footer[2]) == slides, (path, page.number + 1, "footer")
            numbers.append(int(footer[1]))
    assert numbers[0] == 1 and numbers[-1] == slides
    assert all(b - a in (0, 1) for a, b in zip(numbers, numbers[1:])), (path, numbers)
    print(f"PASS {path}: {len(doc)} pages, {slides} numbered slides, bounds/images/fonts/reveals")

# Text colors on their actual light/dark surfaces, including diagram labels.
for foreground, background in ((0x272e2b, 0xfbfaf7), (0x5d6961, 0xfbfaf7),
                               (0xf5f4ef, 0x2b3730), (0xbcc9be, 0x1f2924),
                               (0x45685a, 0xfbfaf7), (0xb8cebd, 0x2b3730),
                               (0x315e4e, 0xffffff), (0x914a38, 0xffffff)):
    assert contrast(foreground, background) >= 4.5
syntax = plistlib.loads(Path(__file__).with_name("syntax.tmTheme").read_bytes())
for rule in syntax["settings"]:
    foreground = int(rule["settings"]["foreground"].lstrip("#"), 16)
    for background in (0xffffff, 0xeff2ed):
        assert contrast(foreground, background) >= 4.5, ("syntax contrast", rule)
print("PASS light/dark text and syntax contrast >= 4.5:1; visual inspection still required")
