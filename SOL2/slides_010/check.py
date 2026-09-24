"""Run: uv run --with pymupdf python SOL2/slides_010/check.py (requires JDK 11+)."""
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
assert len(set(re.findall(r'#diagram\("([^"]+)"', source))) == 25
for state in ("NEW", "RUNNABLE", "BLOCKED", "WAITING", "TIMED_WAITING", "TERMINATED"):
    assert state in drawings
subprocess.run(["typst", "compile", "--root", str(folder.parent),
                str(folder / "main.typ"), str(folder / "main.pdf")], check=True)
pdf = pymupdf.open(folder / "main.pdf")
assert len(pdf) == 51, "Inspect unexpected slide breaks"
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
        assert "".join(footer.split()) == f"{page.number}/50", (page.number + 1, footer)
    tasks.extend(map(int, re.findall(r"^Task (\d+)$", text, re.M)))
assert tasks == [1, 2, 3, 4]
assert code_rows >= 135, "Code spacing check did not cover the examples"

# Compile the actual slide snippets, joining only the explicitly split examples.
snippets = {
    title: [textwrap.dedent(code) for code in re.findall(r"```java\n(.*?)\n\s*```", section, re.S)]
    for title, section in re.findall(r"^== ([^\n]+)\n(.*?)(?=^== |\Z)", source, re.M | re.S)
    if "```java" in section
}
assert sum(map(len, snippets.values())) == 16
with tempfile.TemporaryDirectory() as directory:
    root = Path(directory)
    for title, blocks in snippets.items():
        for code in blocks:
            if title == "Start the Window and Worker":
                continue
            if title == "Build the Window on the EDT":
                code = code.rstrip()[:-1] + snippets["Start the Window and Worker"][0] + "\n}"
            if title == "Shared Account, Concurrent Updates":
                code = code.replace("class Account", "class UnsafeAccount")
            if title in ("Handle Interruption", "Continue Only After the Worker Ends"):
                name = "SleepDemo" if title == "Handle Interruption" else "JoinDemo"
                code = f"public class {name} {{\n{code}\n}}"
            name = re.search(r"\bclass (\w+)", code)[1]
            (root / f"{name}.java").write_text("import javax.swing.*; import java.awt.*;\n" + code)

    (root / "ThreadCheck.java").write_text("""
        import java.lang.reflect.Modifier;
        public class ThreadCheck {
            public static void main(String[] args) throws Exception {
                PrintThread worker = new PrintThread();
                worker.run();
                assert worker.getState() == Thread.State.NEW;
                worker.start();
                worker.join();
                assert worker.getState() == Thread.State.TERMINATED;
                try {
                    worker.start();
                    throw new AssertionError("Restart must fail");
                } catch (IllegalThreadStateException expected) { }

                SleepyThread sleepy = new SleepyThread();
                sleepy.start();
                sleepy.interrupt();
                sleepy.join(2000);
                assert !sleepy.isAlive() : "Interruption must stop the worker";
                assert sleepy.isInterrupted() : "Restore the interrupt flag";

                Account account = new Account();
                for (String method : new String[] {"deposit", "withdraw"}) {
                    assert Modifier.isSynchronized(
                        Account.class.getMethod(method, double.class).getModifiers());
                }
                account.deposit(5000);
                Thread deposit = new Thread(() -> {
                    for (int i = 0; i < 1000; i++) account.deposit(1);
                });
                Thread withdraw = new Thread(() -> {
                    for (int i = 0; i < 1000; i++) account.withdraw(1);
                });
                deposit.start(); withdraw.start();
                deposit.join(); withdraw.join();
                var balance = Account.class.getDeclaredField("balance");
                balance.setAccessible(true);
                assert balance.getDouble(account) == 5000 : "Lost account update";
            }
        }
    """)
    subprocess.run(["javac", "--release", "11", *map(str, root.glob("*.java"))],
                   check=True, capture_output=True, timeout=30)
    runs = 0

    def run(name):
        global runs
        result = subprocess.run(["java", "-ea", "-cp", directory, name], cwd=root,
                                capture_output=True, text=True, timeout=15)
        assert result.returncode == 0, (name, result.stderr)
        runs += 1
        return result.stdout.splitlines()

    message = "Hooray, I'm running in parallel!"
    assert run("RunThread1") == ["Object created", "Thread started"]
    for name in ("RunThread2", "InterfaceBased"):
        assert sorted(run(name)) == sorted([message, "Thread started"])
    output = run("Counters")
    for prefix, ending in (("Main", "Exiting main()"), ("Thread", "Exiting run()")):
        expected = [f"{prefix} counter: {i}" for i in range(10)]
        assert [line for line in output if line.startswith(prefix)] == expected
        assert output.index(ending) > output.index(expected[-1])
    assert len(output) == 22
    assert sorted(run("SleepDemo")) == sorted([message, "Main is ready again"])
    assert run("JoinDemo") == [message, "We have joined!"]
    output = run("JoinThreads")
    assert output.count("I'm sooo tired ...") == 5
    assert output[-1] == "At last ..."
    assert output.index("Okay, I'm awake again.") < len(output) - 1
    run("ThreadCheck")
print(f"PASS: {len(pdf)} pages, 25 CeTZ diagrams, {code_rows} code-row gaps, 16 Java snippets, {runs} Java runs")
