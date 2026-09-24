"""Run: uv run --with pymupdf python SOL2/slides_007/check.py"""
import re
import subprocess
from pathlib import Path

import pymupdf

folder = Path(__file__).resolve().parent
source = (folder / "main.typ").read_text()
drawings = (folder / "diagrams.typ").read_text()
assert not re.search(r"\bimage\s*\(", source + drawings), "Raster illustration in source"
assert '@preview/cetz:' in drawings
assert '[+ ' not in drawings, "Escape UML + signs to avoid numbered lists"
assert 'y: .22em' in source, "Code row spacing regressed"
subprocess.run(["typst", "compile", "--root", str(folder.parent),
                str(folder / "main.typ"), str(folder / "main.pdf")], check=True)

pdf = pymupdf.open(folder / "main.pdf")
assert len(pdf) == 54, "Inspect unexpected slide breaks"
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
        assert (image["width"], image["height"]) in icon_sizes, "Unexpected raster illustration"
        assert image["bbox"][3] < page.rect.height - 43, "Clipped theme icon"
    rows = [s for s in spans if "JetBrainsMono" in s["font"] and s["text"].isdigit()]
    for a, b in zip(rows, rows[1:]):
        if int(b["text"]) == int(a["text"]) + 1 and abs(a["bbox"][0] - b["bbox"][0]) < 1:
            assert b["origin"][1] - a["origin"][1] >= 1.3 * a["size"], "Cramped code rows"
            assert a["size"] >= 14, "Code shrunk too far"
            code_rows += 1
    if page.number:
        footer = page.get_text(clip=pymupdf.Rect(
            page.rect.width * .75, page.rect.height - 43, page.rect.width, page.rect.height))
        match = re.fullmatch(r"(\d+)/53", "".join(footer.split()))
        assert match, (page.number + 1, "Broken footer", footer)
        numbers.append(int(match[1]))
    tasks.extend(map(int, re.findall(r"^Task (\d+)$", text, re.M)))

assert numbers == list(range(1, 54)), "Slide numbering changed"
assert tasks == [1, 2, 3, 4, 5], "Task numbering changed"
assert code_rows >= 100, "Code spacing check did not cover the examples"
text = " ".join(" ".join(page.get_text().split()) for page in pdf)
for label in ("Content pane", "setJMenuBar()", "GridLayout(2, 2)",
              "List<Observer>", "+ update(): void", "+ actionPerformed(ActionEvent): void",
              "MouseMotionListener", "MouseWheelListener", "time flows downward",
              "does not call", "SwingUtilities.invokeLater(HelloWorld::new)", "CC BY-NC-SA 4.0"):
    assert label in text, ("Missing content", label)
print(f"PASS: {len(pdf)} pages, 5 tasks, {code_rows} code-row gaps; bounds and vector illustrations checked")
