"""Run: uv run --with pymupdf python SOL2/slides_009/check.py (requires JDK 11+)."""
import re
import subprocess
import tempfile
import textwrap
from pathlib import Path

import pymupdf

folder = Path(__file__).resolve().parent
source = (folder / "main.typ").read_text()
drawings = (folder / "diagrams.typ").read_text()
assert not re.search(r"\bimage\s*\(", source + drawings), "Raster diagram in source"
assert '@preview/cetz:' in drawings
assert 'y: .22em' in source, "Code row spacing regressed"
assert len(set(re.findall(r'#diagram\("([^"]+)"', source))) == 20
subprocess.run(["typst", "compile", "--root", str(folder.parent),
                str(folder / "main.typ"), str(folder / "main.pdf")], check=True)
pdf = pymupdf.open(folder / "main.pdf")
assert len(pdf) == 43, "Inspect unexpected slide breaks"
icon_sizes = {
    (pix.width, pix.height)
    for path in (folder.parent / "hestia").glob("*.png")
    for pix in [pymupdf.Pixmap(str(path))]
}
code_rows, tasks = 0, []
for page in pdf:
    text = page.get_text()
    assert not re.search(r"pin\d|\ufffd", text), (page.number + 1, "Unresolved glyph")
    spans = [s for b in page.get_text("dict")["blocks"] if "lines" in b
             for line in b["lines"] for s in line["spans"]]
    for span in spans:
        assert page.rect.contains(pymupdf.Rect(span["bbox"])), (page.number + 1, span["text"])
        if page.number and span["size"] > 12:
            assert span["bbox"][3] < page.rect.height - 43, (page.number + 1, "Footer collision")
    for image in page.get_image_info():
        assert (image["width"], image["height"]) in icon_sizes, "Unexpected raster illustration"
    rows = [s for s in spans if "JetBrainsMono" in s["font"] and s["text"].isdigit()]
    for a, b in zip(rows, rows[1:]):
        if int(b["text"]) == int(a["text"]) + 1:
            assert b["origin"][1] - a["origin"][1] >= 1.3 * a["size"], "Cramped code rows"
            assert a["size"] >= 14, (page.number + 1, "Code shrunk too far")
            code_rows += 1
    if page.number:
        footer = page.get_text(clip=pymupdf.Rect(
            page.rect.width * .75, page.rect.height - 43, page.rect.width, page.rect.height))
        assert "".join(footer.split()) == f"{page.number}/42", (page.number + 1, footer)
    tasks.extend(map(int, re.findall(r"^Task (\d+)$", text, re.M)))
assert tasks == [1, 2, 3, 4, 5]
assert code_rows >= 110, "Code spacing check did not cover the examples"

# Compile the actual snippets; all file operations run in a disposable directory.
snippets = {
    title: textwrap.dedent(match[1])
    for title, section in re.findall(r"^== ([^\n]+)\n(.*?)(?=^== |\Z)", source, re.M | re.S)
    if (match := re.search(r"```java\n(.*?)\n\s*```", section, re.S))
}
assert len(snippets) == 15
with tempfile.TemporaryDirectory() as directory:
    root = Path(directory)
    names = {}
    for i, (title, code) in enumerate(snippets.items()):
        name = f"Demo{i}"
        names[title] = name
        if title == "Collect the Components":
            code += snippets["Compute the Magnitude"]
        if title == "Close Resources on Every Exit":
            code = "public static void main(String[] args) throws IOException {" + code + "}"
        (root / f"{name}.java").write_text(
            "import java.io.*; import java.util.*; import java.nio.charset.*;\n"
            + f"public class {name} {{\n{code}\n}}")
    subprocess.run(["javac", "--release", "11", *map(str, root.glob("*.java"))],
                   check=True, capture_output=True, timeout=30)
    runs = 0

    def run(title, input="", output=None, error=None):
        global runs
        result = subprocess.run(["java", "-cp", directory, names[title]], cwd=root,
                                input=input, capture_output=True, text=True, timeout=10)
        assert (result.returncode != 0) == (error is not None), (title, result.stderr)
        if output is not None:
            assert result.stdout == output, (title, result.stdout)
        if error:
            assert error in result.stderr, (title, result.stderr)
        runs += 1
        return result.stdout

    run("Predict the Output", output="Hamburg: 22.7 °C")
    run("Read a Line", "Hello Java\n", "Please enter a sentence: Hello Java\n")
    run("A Token Loop", "Hello\tJava\n127", "Hello\nJava\n127\n")
    run("A Token Loop", output="")
    run("Parse a Typed Value", "127", "Please enter a byte value: Entered: 127\n")
    for token in ("128", "Hamburg"):
        run("Parse a Typed Value", token, error="InputMismatchException")
    for title in ("Catch the Exception", "Check Before Reading"):
        for token in ("127", "-128"):
            run(title, token, f"Entered: {token}\n")
        for token in ("128", "Hamburg"):
            run(title, token, f"Not a byte value: {token}\n")
    run("Catch the Exception", error="NoSuchElementException")
    run("Check Before Reading", output="End of input.\n")
    run("Collect the Components", "7 4 0 15 End", "a = [7, 4, 0, 15]^T\n||a|| = 17.03\n")
    run("Collect the Components", "50000", "a = [50000]^T\n||a|| = 50000.00\n")
    run("Collect the Components", "End", "a = []^T\n||a|| = 0.00\n")
    run("Read Individual Character Values", "A\r\n", "Please enter a character: 65\n13\n10\n")
    run("Read Individual Character Values", "A\n", "Please enter a character: 65\n10\n-1\n")
    run("Read Two Lines", "Hello\r\nJava\n", "First line: Second line: Hello\nJava\n")
    path = root / "Testdatei.txt"
    run("Create, Inspect, Delete", output="Read: true\nWrite: true\n")
    assert not path.exists()
    path.write_text("Keep this file.")
    run("Create, Inspect, Delete", output="Already exists; left unchanged.\n")
    assert path.read_text() == "Keep this file.", "Example deleted an existing file"
    assert "Testdatei.txt" in run("List a Directory").splitlines()
    run("Write a Text File", output="")
    expected = "This is the first line.\nAnd here comes the second line.\n"
    assert path.read_text() == expected
    reader = "Read Until EOF, Not Until ready() Is False"
    run(reader, output=expected)
    run("Close Resources on Every Exit", output="This is the first line.\n")
    path.write_text("Grüße\n\nLast line", encoding="utf-8")
    run(reader, output="Grüße\n\nLast line\n")
    path.write_text("")
    run(reader, output="")
    path.unlink()
    run(reader, error="FileNotFoundException")
print(f"PASS: {len(pdf)} pages, 20 CeTZ diagrams, {code_rows} code-row gaps, {runs} Java runs")
