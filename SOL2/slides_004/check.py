"""Run: uv run --with pymupdf python SOL2/slides_004/check.py"""
import re
import subprocess
from pathlib import Path

import pymupdf

folder = Path(__file__).resolve().parent
source = (folder / "main.typ").read_text()
drawings = (folder / "diagrams.typ").read_text()
assert not re.search(r"\b(image|quotation|quote)\s*\(", source + drawings)
assert '@preview/cetz:' in drawings
assert 'y: .22em' in source, "Code row spacing regressed"
subprocess.run(["typst", "compile", "--root", str(folder.parent),
                str(folder / "main.typ"), str(folder / "main.pdf")], check=True)

pdf = pymupdf.open(folder / "main.pdf")
assert len(pdf) == 80, "Inspect slide breaks and reveals"
icon_sizes = {
    (pix.width, pix.height)
    for path in (folder.parent / "hestia").glob("*.png")
    for pix in [pymupdf.Pixmap(str(path))]
}
numbers, tasks, code_rows = [], [], 0
for page in pdf:
    text = page.get_text()
    assert not re.search(r"pin\d|\ufffd", text), (page.number + 1, "Unresolved marker or glyph")
    spans = [s for b in page.get_text("dict")["blocks"] if "lines" in b
             for line in b["lines"] for s in line["spans"]]
    for span in spans:
        bounds = pymupdf.Rect(span["bbox"])
        assert page.rect.contains(bounds), (page.number + 1, "Clipped text", span["text"])
        if page.number and span["size"] > 12:
            assert bounds.y1 < page.rect.height - 43, (page.number + 1, "Footer collision")
    for image in page.get_image_info():
        assert (image["width"], image["height"]) in icon_sizes, "Unexpected raster diagram"
        assert image["bbox"][3] < page.rect.height - 43, "Clipped icon"
    rows = [s for s in spans if "JetBrainsMono" in s["font"] and s["text"].isdigit()]
    for a, b in zip(rows, rows[1:]):
        if int(b["text"]) == int(a["text"]) + 1 and abs(a["bbox"][0] - b["bbox"][0]) < 1:
            assert b["origin"][1] - a["origin"][1] >= 1.3 * a["size"], "Cramped code rows"
            code_rows += 1
    if page.number:
        footer_text = page.get_text(clip=pymupdf.Rect(
            page.rect.width * .75, page.rect.height - 43, page.rect.width, page.rect.height))
        footer = re.fullmatch(r"(\d+)/78", "".join(footer_text.split()))
        assert footer, (page.number + 1, "Broken footer", footer_text)
        numbers.append(int(footer[1]))
    tasks.extend(map(int, re.findall(r"^Task (\d+)$", text, re.M)))

assert numbers[0] == 1 and numbers[-1] == 78
assert all(b - a in (0, 1) for a, b in zip(numbers, numbers[1:]))
assert len(numbers) - len(set(numbers)) == source.count("#pause"), "Lost answer reveal"
assert tasks == list(range(1, 6)), "Task numbering changed"
assert code_rows > 90, "Code spacing check did not cover the examples"
text = " ".join(" ".join(page.get_text().split()) for page in pdf)
for label in ("Two references, one immutable object", "Zero padding", "21,45 km/h",
              "ArrayIndexOutOfBoundsException", "Copied value", "int[] rows",
              "NumberFormatException", "NullPointerException"):
    assert label in text, ("Missing diagram content", label)
print(f"PASS: {len(pdf)} pages, 78 slides, 5 tasks, {code_rows} code-row gaps; bounds and vector diagrams checked")
