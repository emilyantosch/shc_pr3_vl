"""Check both WS 2026/27 papers: eight PDFs and their embedded Java solutions.

uv run --no-project --with pymupdf python SOL2/exam_winter_2026/check.py \
    SOL2/*exam_winter_2026/*_rev01.pdf
Requires Typst's build outputs, PyMuPDF, and a JDK supporting --release 17.
"""
import re
import subprocess
import sys
import tempfile
from pathlib import Path

import pymupdf

ROOT = Path(__file__).resolve().parents[1]
KINDS = ("exam_winter_2026", "mock_exam_winter_2026")
paths = [Path(arg) for arg in sys.argv[1:]]
assert len(paths) == 8, "Pass exactly eight PDFs from one revision."
assert len({re.search(r"_rev([^/]+)\.pdf$", p.name)[1] for p in paths}) == 1
seen = set()
for path in paths:
    kind = path.parent.name
    solution = "_solution_" in path.name
    printer = "_print_" in path.name
    key = (kind, solution, printer)
    assert kind in KINDS and key not in seen, (path, "unexpected or duplicate edition")
    seen.add(key)
    with pymupdf.open(path) as doc:
        assert len(doc) == (12 if solution else 8), (path, "unexpected pagination")
        tasks = [title for level, title, _ in doc.get_toc() if level == 1]
        assert len(tasks) == 6 and all(title.startswith(f"Task {i}:")
                                       for i, title in enumerate(tasks, 1)), (path, tasks)
        text = "\n".join(page.get_text() for page in doc)
        assert ("Solution / marking" in text) == solution, (path, "answer visibility")
        assert ("Instructor copy" in text) == solution, path
        assert ("assert " in text) == solution, (path, "solution code visibility")
        assert ("slightly harder" in text) == kind.startswith("mock"), path
        assert "\ufffd" not in text, (path, "missing glyph")
        cover = doc[0].get_text()
        assert "90 minutes" in cover and "105 points" in cover and "2026/27" in cover, path
        assert "Signature" not in cover, (path, "signature field")
        if not solution and kind == "exam_winter_2026":
            assert not any(d["color"] is not None and d["rect"].width > 100
                           and d["rect"].height > 10 for d in doc[1].get_drawings()), (path, "answer boxes")
        if kind == "exam_winter_2026":
            completion = doc[4].get_text()
            assert not re.search(r"[_-]{4,}", completion), (path, "completion rules")
            assert all(re.search(rf"(?m)^{n}$", completion) for n in range(1, 30)), (path, "completion writing space")
        assert len(doc[0].get_links()) == 6, (path, "task navigation")
        assert ("Instructor solutions" if solution else "Student copy") in doc.metadata["title"]
        tf_page = doc[tasks.index("Task 3: True or False") + 1]
        assert tf_page.get_text().count("X") == (8 if solution else 0)
        for page in doc:
            assert abs(page.rect.width - 595.28) < .1 and abs(page.rect.height - 841.89) < .1, path
            # Ignore headers and footers when detecting accidental empty overflow pages.
            body = page.get_text(clip=pymupdf.Rect(50, 50, 550, 786))
            assert len(body.split()) > 35, (path, page.number + 1, "nearly empty page")
            corner = page.get_pixmap(clip=pymupdf.Rect(0, 0, 32, 32))
            colors = {corner.pixel(x, y) for x in range(32) for y in range(32)}
            if printer:
                assert colors == {(255, 255, 255)}, (path, "print background")
                for drawing in page.get_drawings():
                    if drawing["rect"].width > 5 and drawing["rect"].height > 5:
                        assert drawing["fill"] in (None, (1, 1, 1)), (path, "shaded print panel")
            else:
                assert len(colors) > 1 and (255, 255, 255) not in colors, (path, "digital dots")
            footer = page.get_text(clip=pymupdf.Rect(490, 800, 595, 842))
            assert "".join(footer.split()) == f"{page.number + 1}/{len(doc)}", (path, "footer")
            for block in page.get_text("dict")["blocks"]:
                for line in block.get("lines", []):
                    for span in line["spans"]:
                        x0, y0, x1, y1 = span["bbox"]
                        assert 51 < x0 < x1 < page.rect.width - 50, (path, page.number + 1, span)
                        assert 20 < y0 < y1 < page.rect.height - 18, (path, page.number + 1, span)
                        if span["size"] > 9.1:
                            assert y1 < 786, (path, "footer collision", span)
            for font in page.get_fonts():
                assert any(name in font[3] for name in ("SourceSans3", "LibertinusSerif", "JetBrainsMono")), (path, font)
                assert doc.extract_font(font[0])[3], (path, "unembedded font")
        if printer:
            with pymupdf.open(path.with_name(path.name.replace("_print_", "_digital_"))) as digital:
                assert len(doc) == len(digital), path
                for a, b in zip(doc, digital):
                    assert a.get_text("words") == b.get_text("words"), (path, "content/layout mismatch")
        print(f"PASS {path.name}: {len(doc)} pages")
assert seen == {(kind, solution, printer) for kind in KINDS
                for solution in (False, True) for printer in (False, True)}

# Compile the actual code printed in the instructor copies, not a parallel implementation.
checks = {
    "exam_winter_2026": r'''
        WaterTank tank = new WaterTank(25);
        assert tank.getLevel() == 25 && tank.freeCapacity() == 75;
        assert tank.toString().equals("WaterTank[level=25]");
        tank.setLevel(0); assert tank.freeCapacity() == 100;
        tank.setLevel(100); assert tank.freeCapacity() == 0;
        for (int invalid : new int[] {-1, 101, Integer.MIN_VALUE, Integer.MAX_VALUE}) {
            rejects(() -> new WaterTank(invalid));
            rejects(() -> tank.setLevel(invalid));
            assert tank.getLevel() == 100;
        }
        ScoreCard score = new ScoreCard(new String("Quiz"), 4);
        assert score.getBonus() == 4;
        assert score.hasName(new String("Quiz")) && !score.hasName("Other");
        assert score.sum(new int[] {}) == 0;
        assert score.sum(new int[] {3, -2, 5}) == 6;
        Reading r = new Reading("Hall", -20);
        assert r.getRoom().equals("Hall") && r.getTemperature() == -20;
        assert r.toString().contains("Hall") && r.toString().contains("-20");
        SensorLog log = new SensorLog();
        assert log.averageTemperature() == 0 && log.countAbove(0) == 0;
        assert log.addReading(" A ", -20) && log.addReading("A", 50);
        assert log.averageTemperature() == 15.0;
        assert log.countAbove(-21) == 2 && log.countAbove(-20) == 1;
        assert log.countAbove(50) == 0;
        assert !log.addReading("B", -21) && !log.addReading("B", 51);
        assert !log.addReading("", 0) && !log.addReading(" \t ", 0);
        assert !log.addReading(null, 0);
        assert log.averageTemperature() == 15.0 && log.countAbove(-21) == 2;
        SensorLog fractional = new SensorLog();
        assert fractional.addReading("X", -1) && fractional.addReading("Y", 0);
        assert fractional.averageTemperature() == -0.5;
    ''',
    "mock_exam_winter_2026": r'''
        ScoreRange range = new ScoreRange(2, 5);
        assert !range.contains(1) && range.contains(2) && range.contains(5);
        assert !range.contains(6);
        assert range.clamp(Integer.MIN_VALUE) == 2;
        assert range.clamp(3) == 3 && range.clamp(Integer.MAX_VALUE) == 5;
        assert range.toString().equals("ScoreRange[2..5]");
        ScoreRange single = new ScoreRange(-2, -2);
        assert single.contains(-2) && single.clamp(0) == -2;
        rejects(() -> new ScoreRange(5, 2));
        Booking booking = new Booking(new String("A1"), 1);
        assert booking.matches(new String("A1")) && !booking.matches("B1");
        assert booking.getRemaining() == 1 && booking.reserve();
        assert booking.getRemaining() == 0 && !booking.reserve();
        assert booking.getRemaining() == 0;
        ParcelQueue queue = new ParcelQueue();
        assert queue.dispatchNext() == null;
        for (String invalid : new String[] {null, "", " \t "}) {
            assert !queue.addParcel(invalid, 2) && queue.findParcel(invalid) == null;
        }
        assert !queue.addParcel("X", 0) && !queue.addParcel("X", 4);
        assert queue.addParcel(" A ", 1) && !queue.addParcel(" a ", 3);
        Parcel a = queue.findParcel(" a ");
        assert a.getId().equals("A") && a.getPriority() == 1;
        assert a.toString().contains("A") && a.toString().contains("1");
        assert queue.addParcel("B", 3) && queue.addParcel("C", 3);
        assert queue.addParcel("D", 2);
        Parcel b = queue.findParcel("B");
        assert queue.findParcel(" b ") == b && queue.dispatchNext() == b;
        assert queue.findParcel("B") == null;
        assert queue.dispatchNext().getId().equals("C");
        assert queue.dispatchNext().getId().equals("D");
        assert queue.dispatchNext() == a && queue.dispatchNext() == null;
        assert queue.addParcel("a", 2) && queue.dispatchNext().getId().equals("a");
    ''',
}
for kind in KINDS:
    source = (ROOT / kind / "main.typ").read_text()
    assert re.findall(r"#task\((\d),", source) == list("123456")
    assert sum(map(int, re.findall(r"\],\s+\[(\d+)\],", source))) == 40
    blocks = re.findall(r"```java\n(.*?)\n[ \t]*```", source, re.S)
    # The last listing for each public class is its corrected solution.
    classes = {match[1]: block for block in blocks
               if (match := re.search(r"public class (\w+)", block))}
    assert len(classes) == 5, (kind, classes.keys())
    with tempfile.TemporaryDirectory() as tmp:
        directory = Path(tmp)
        for name, code in classes.items():
            (directory / f"{name}.java").write_text(code)
        (directory / "Checks.java").write_text('''
public class Checks {
    static void rejects(Runnable action) {
        try { action.run(); }
        catch (IllegalArgumentException expected) { return; }
        throw new AssertionError("Expected IllegalArgumentException");
    }
    public static void main(String[] args) {
''' + checks[kind] + "\n    }\n}\n")
        if kind.startswith("mock"):
            base, child, trace = "Ticket", "ExpressTicket", "Announcer"
            extra = 'assert new ExpressTicket(4).price() == 7;'
            expected_trace = "L-object\nA-string\n"
            expected_demo = "No parcels\nP1: priority 2\nP2: priority 3\nP3: priority 3\n"
        else:
            base, child, trace = "Vehicle", "Bicycle", "Signal"
            extra = 'assert new Bicycle("B1").label().equals("Bike: B1");'
            expected_trace = "ding\ncount=2\n"
            expected_demo = "No readings\nKitchen: 20 C\nKitchen: 21 C\n"
        declarations = [next(b for b in blocks if re.search(rf"class {name}\b", b))
                        for name in (base, child, trace)]
        trace_classes, trace_main = declarations.pop().split("// Inside main:")
        (directory / "TheoryCheck.java").write_text("\n".join(declarations) + trace_classes
            + "\npublic class TheoryCheck { public static void main(String[] args) {\n"
            + trace_main + extra + "\n} }\n")
        subprocess.run(["javac", "--release", "17", *map(str, directory.glob("*.java"))], check=True)
        for name, expected in (("Checks", ""), ("Demo", expected_demo), ("TheoryCheck", expected_trace)):
            result = subprocess.run(["java", "-ea", "-cp", tmp, name], check=True, capture_output=True, text=True)
            assert result.stdout == expected, (kind, name, result.stdout, expected)
    print(f"PASS {kind}: embedded Java compiles; traces, demos, and boundary checks pass")
