# Hestia PDF theme

This Touying 0.7.4 theme applies to all 30 slide decks in `SOL2/`, `databases/`, and `SHC_PR3/`.
All decks import this shared theme; there are no per-course copies.
`lab.typ` adapts the Hestia palette and typography for all four `SOL2/labs/lab*/main.typ` documents.
`exam.typ` adapts the lab layout for the WS 2026/27 actual and mock exams.
The old exam, archived PDFs, and `SOL2/hestia_v2` are unchanged.
Labs, exams, manuals, and invoices outside SOL2 are unchanged.

## Design

- Warm-white pages, charcoal text, and muted green accents.
- Libertinus Serif titles and chapter dividers. Source Sans 3 body text and headings.
- Body text: 25 pt. Headings: 34 pt. Code: 20 pt. Captions: 15 pt.
- Open layouts with a subtle 16 pt dot grid and no enclosing cards.
- Light callouts with translated labels and the existing task counter. Questions omit the redundant label.
- Tasks, warnings, memo reminders, info, and questions use `task.png`, `warning.png`, `memorize.png`, `info.png`, and `questions.png` respectively, displayed beside the text at 80 pt.
- `idea` is an alias for `memo`; `tip` and `example` are aliases for `info`.
- Vector diagrams with larger labels. Rust and ochre distinguish selected diagram elements and warnings.
- `syntax.tmTheme` defines high-contrast code colors for the light code panels.

Lecture 1 uses shorter explanations, two-column comparisons, and separate layouts for questions, diagrams, and exercises.
Its chapter order, 49 numbered slides, 55 PDF pages, and five reveal steps remain unchanged.
The text now correctly identifies `main` as a static method, not a method on a “main object.”
Institution metadata remains in `config-info`, without visible institutional branding.

SOL2 Lectures 2–10 and all database and SHC_PR3 decks use `compact: true` to retain their existing text, code, diagrams, and reveal steps.
This mode uses tighter list/code spacing, respects local font sizes, and scales overflowing slide bodies to fit.
Legacy vertical alignment becomes top alignment; percentage image heights resolve against the slide body before scaling.
Captions are unnumbered, with figure-counter freezing disabled to avoid Touying convergence problems on reveals.
The title pages, chapter dividers, headers, and footers retain the standard Hestia sizing.

## Build and check

Verified with **Typst 0.15.1** and Codly 1.3.0.
Install **Source Sans 3**, **Libertinus Serif**, and **JetBrainsMono NFM**, including bold and italic styles.
The legacy Inter files under `fonts/` are not used by this design.

Build all courses from the repository root:

```sh
just compile_slides 01
just check_slides
```

Use an unused revision number. Exports are named `YYYYMMDD_slides_N_hestia_rev01.pdf`
inside each deck's directory; SOL2 keeps its zero-padded directory numbers.
Existing PDF filenames are not overwritten.
`check_slides` builds all 30 decks in a temporary directory and checks page/reveal counts,
fonts, colors, dots, text/image bounds, image/text overlap, annotations, and footer sequencing.
It requires `uv` and uses PyMuPDF, like the existing checks.

The database and SHC_PR3 decks require the **repository root**, not the course directory,
because they import `SOL2/hestia/theme.typ`. For one deck:

```sh
typst compile --root . databases/slides_1/main.typ /tmp/databases-1.pdf
```

Those decks pass `image-source: source => read(source, encoding: none)` to `hestia-theme`.
This resolves images relative to the deck when compact mode reconstructs percentage-height images.
SQL code labels use the same Hestia styling as Java and C.
SHC_PR3 also uses the compatible Fletcher 0.5.8 and Tiaoma 0.3.0 packages.
Its missing Person UML image was recovered from repository history into `SHC_PR3/assets/img/`.

For the original SOL2-specific smoke and diagram checks, set `TYPST` to your Typst 0.15.1 executable. Then run:

```sh
for dir in SOL2/slides_*; do
  "$TYPST" compile --root SOL2 "$dir/main.typ" "$dir/main.pdf" || exit
done
"$TYPST" compile --root SOL2 \
  SOL2/hestia/smoke.typ /tmp/sol2-smoke-light.pdf
"$TYPST" compile --root SOL2 --input dark=true \
  SOL2/hestia/smoke.typ /tmp/sol2-smoke-dark.pdf
uv run --no-project --with pymupdf python SOL2/hestia/check.py \
  SOL2/slides_001/main.pdf /tmp/sol2-smoke-light.pdf /tmp/sol2-smoke-dark.pdf \
  SOL2/slides_00{2,3,4,5,6,7,8,9}/main.pdf SOL2/slides_010/main.pdf
git diff --check
```

For SOL2-only dated, revisioned PDFs, run `just --justfile SOL2/justfile compile_slides 03`.
The slide, lab, and exam recipes use the current directories and a relative project root.

## Labs: digital and print

`lab.typ` uses A4 pages, 11 pt Source Sans 3 body text, 30 pt Libertinus Serif titles,
and 9 pt JetBrains Mono code. It imports the slide palette and uses the same syntax colors.
Task links, PDF bookmarks, page numbers, authors, and institution metadata remain available.

- **Digital** (default): warm-white paper, a subtle dot grid, and light green callout/code surfaces.
- **Print**: plain white paper, no dots, no shaded callout/code panels. Text colors and the maze image remain unchanged.
- Both media have identical content and pagination. Solutions are hidden unless `solution=true`.

Build all 16 PDFs (four labs × two media × with/without solutions):

```sh
just --justfile SOL2/justfile compile_labs 03
uv run --no-project --with pymupdf python SOL2/labs/check.py SOL2/labs/lab*/*_rev03.pdf
```

Use an unused revision number to keep previous exports. The check requires exactly one complete revision.
Filenames include `_digital_` or `_print_`; instructor copies also include `_solution_`.
To build one student print copy from the repository root:

```sh
typst compile --root SOL2 --input medium=print --input solution=false \
  SOL2/labs/lab1/main.typ /tmp/lab1-print.pdf
```

`medium` accepts only `digital` or `print`; `solution` accepts only `true` or `false`.
`labs/check.py` checks all editions for A4 size, print backgrounds, digital dots, solution visibility,
fonts, text bounds, navigation, and matching digital/print content and layout.

## Exams: winter semester 2026/27

Sources: `SOL2/exam_winter_2026/main.typ` and `SOL2/mock_exam_winter_2026/main.typ`.
Each source produces four PDFs: digital and print student copies, plus separate digital and print instructor solutions.
Student copies have eight pages. Instructor copies have twelve pages and include answers, reference code, and marking criteria.

Both papers retain the old exam's six task types and point distribution: **10 + 15 + 16 + 12 + 12 + 40 = 105**.
The duration is **90 minutes: 60 for theory and 30 for programming**.
The mock adds reference tracing, overload resolution, duplicate detection, and priority selection with stable ties.
The actual programming task uses a smaller sensor log with counting and averaging.

Both media use the lab palette and fonts. Code panels use less vertical padding to leave room for written answers.
Print copies have white backgrounds, without dots or shaded panels. Content and pagination match the digital copies.

Build and check all eight PDFs from the repository root:

```sh
just --justfile SOL2/justfile compile_exams 01
uv run --no-project --with pymupdf python SOL2/exam_winter_2026/check.py \
  SOL2/*exam_winter_2026/*_rev01.pdf
```

Use an unused revision for a new export. The check requires one complete revision and a JDK that supports `--release 17`.
It checks PDF layout, solution visibility, navigation, fonts, print backgrounds, and matching media.
It also compiles the embedded Java solutions and runs output and boundary checks.
The existing `medium` and `solution` inputs work for individual exam builds. Solutions remain hidden by default.

Keep the actual exam and instructor PDFs separate from published practice materials.
Before the exam, confirm the date and that the designated submission drive is available in Explorer. The cover leaves the date blank and states the handwritten cheat-sheet allowance, submission requirements, and flexible task order.
Review the questions and marking criteria before release. Automated checks do not establish the difficulty or completion time.

## Layouts

Import `theme.typ` after the package imports. Keep `codly-init` before `hestia-theme`.
Use `hestia-theme.with(dark: true, ...)` for a dark canvas.

| Function | Purpose |
| --- | --- |
| `title-slide(authors: [...])` | Title, subtitle, author, and date |
| `new-section-slide` | Automatic numbered chapter divider |
| `outline-slide()` | Hestia agenda with first-level chapter headings |
| `slide[...]` | Content with a heading and slide-number footer |
| `two-column-slide[...][...]` | Equal columns with a 44 pt gutter |
| `sidebar-slide[...][...]` | Main content and sidebar, in a 2:1 ratio |
| `code-slide[...]` | Codly code with line numbers and language label |
| `diagram-slide[figure]` | Centered diagram on the page background; light panel in dark mode |
| `diagram-slide[text][figure]` | Explanation above a diagram |
| `callout-slide[...]` | Vertically centered content |
| `footer-slide[...]` | Large closing statement |

The slide helpers retain Touying's `config`, `repeat`, `setting`, and `composer` arguments.
`smoke.typ` has runnable examples.

Diagram panels reserve 40 pt for captions. Longer captions need more space.
Raster images fit the panel automatically when no explicit dimensions are supplied.
The lecture's CeTZ diagrams scale their geometry and labels together.
Code, annotations, callouts, and diagrams keep light backgrounds in dark mode.
The Pinit offsets fit the five-line example. Longer code requires different offsets.

## Verification and limits

`check.py` checks page counts, aspect ratios, text bounds, footer clearance, embedded fonts, overlays, diagram labels, background dots, diagram surfaces, admonition artwork and transparency, and the download link.
It also checks selected palette pairs and all syntax colors against a 4.5:1 contrast threshold.
With the nine additional PDF arguments, it also checks all migrated decks for page/reveal counts, Hestia fonts and backgrounds, footer sequencing, image bounds, and images overlapping text.
Visual inspection is still necessary for diagram geometry, line breaks, and projection quality.
Compact mode preserves dense slides rather than rewriting them; split these slides when larger projection text is needed.
Its fitting dimensions follow Hestia's fixed page margins (52 pt horizontally, 112 pt above, 48 pt below).

Touying also repeats Figure 8 on the toolchain slide. This existing counter behavior is unchanged.
Dark mode is covered by the layout examples, not a complete dark Lecture 1 migration.
