"""Run: uv run --with pymupdf python SOL2/slides_008/check.py (requires JDK)."""
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
assert len(set(re.findall(r'#diagram\("([^"]+)"', source))) == 16
subprocess.run(["typst", "compile", "--root", str(folder.parent),
                str(folder / "main.typ"), str(folder / "main.pdf")], check=True)
pdf = pymupdf.open(folder / "main.pdf")
assert len(pdf) == 48, "Inspect unexpected slide breaks"
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
        if int(b["text"]) == int(a["text"]) + 1 and abs(a["bbox"][0] - b["bbox"][0]) < 1:
            assert b["origin"][1] - a["origin"][1] >= 1.3 * a["size"], "Cramped code rows"
            assert a["size"] >= 14, (page.number + 1, "Code shrunk too far")
            code_rows += 1
    if page.number:
        footer = page.get_text(clip=pymupdf.Rect(
            page.rect.width * .75, page.rect.height - 43, page.rect.width, page.rect.height))
        assert "".join(footer.split()) == f"{page.number}/47", (page.number + 1, footer)
    tasks.extend(map(int, re.findall(r"^Task (\d+)$", text, re.M)))
assert tasks == [1, 2, 3]
assert code_rows >= 170, "Code spacing check did not cover the examples"

# Compile the actual slide snippets; use temporary files, not duplicate Java fixtures.
def snippet(title):
    section = source.split("== " + title + "\n", 1)[1].split("\n== ", 1)[0]
    return textwrap.dedent(re.search(r"```java\n(.*?)\n\s*```", section, re.S)[1])


recursion = "static int recursiveIncrease(int i) { return recursiveIncrease(i + 1); }"
checked = "class NegativeParamException extends Exception {}"
cases = [
    ("Predict the Output", "", ["Ratio = 1", "Exiting main()"], None),
    ("An Explicit Guard", "", [], "ArithmeticException: Division by zero"),
    ("Catch Locally: Is Zero a Valid Result?", "",
     ["Caught in getRatio()", "Exiting getRatio()", "Ratio = 0", "Exiting main()"], None),
    ("Catch in the Caller", "", ["Caught in main()", "Exiting main()"], None),
    ("Two Failures, One Evaluation Order", "", [], "StackOverflowError"),
    ("Catch Either Failure Type", recursion, ["Caught StackOverflowError", "Exiting main()"], None),
    ("An Exception Inside a Catch", recursion, [], "StackOverflowError"),
    ("A Nested Handler", recursion,
     ["Caught inner StackOverflowError", "Continuing after the handler"], None),
    ("Finally During Propagation", recursion, ["Finally"], "StackOverflowError"),
    ("Finally Before a Return", '''public static void main(String[] args) {
        System.out.println("Ratio = " + getRatio(3, 0));
    }''', ["Caught in getRatio()", "Finally", "Ratio = 0"], None),
    ("Declare with throws", checked, ["5.0"], None),
    ("Alternative: An Unchecked Custom Exception", "", ["5.0"], None),
    ("Read the Custom Message", snippet("Pass the Message to the Superclass"),
     ["Message: Invalid application state"], None),
    ("Why Does This Not Compile?", "", None, None),
]
for title, helper, output, error in cases:
    code = snippet(title)
    public_class = re.search(r"public class (\w+)", code)
    if public_class:
        name = public_class[1]
    else:
        name = "Demo"
        if title == "A Nested Handler":
            code = "public static void main(String[] args) {" + code + "}"
        if helper.startswith("class "):
            code = helper + "\npublic class Demo {" + code + "}"
        else:
            code = "public class Demo {" + helper + code + "}"
    with tempfile.TemporaryDirectory() as directory:
        path = Path(directory) / f"{name}.java"
        path.write_text(code)
        compiled = subprocess.run(["javac", str(path)], capture_output=True, text=True, timeout=30)
        if output is None:
            assert compiled.returncode != 0 and "NegativeParamException" in compiled.stderr, title
            continue
        assert compiled.returncode == 0, (title, compiled.stderr)
        result = subprocess.run(["java", "-cp", directory, name],
                                capture_output=True, text=True, timeout=10)
        assert result.stdout.splitlines() == output, (title, result.stdout)
        assert (result.returncode != 0) == (error is not None), (title, result.stderr)
        if error:
            assert error in result.stderr, (title, result.stderr)
print(f"PASS: {len(pdf)} pages, 16 CeTZ diagrams, {code_rows} code-row gaps, {len(cases)} Java checks")
