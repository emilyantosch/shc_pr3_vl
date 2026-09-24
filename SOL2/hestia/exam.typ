#import "lab.typ": lab-theme, solution
#import "theme.typ": palette
#import "@preview/codly:1.3.0": codly

#let points = (10, 15, 16, 12, 12, 40)
#assert.eq(points.sum(), 105)

#let exam-spacing(body) = {
  set text(spacing: 110%)
  set par(leading: .7em, spacing: .9em)
  set list(tight: false, spacing: .85em)
  set enum(tight: false, spacing: .85em)
  show raw: set text(spacing: 100%)
  body
}

#let exam-theme(mock: false, body) = {
  let kind = if mock { "Mock exam" } else { "Exam" }
  lab-theme(
    title: kind + " - Object-Oriented Programming",
    university: [HAW Hamburg], institute: [Faculty TI], seminar: [SO2 · WS 2026/27],
    author: "Emily Antosch",
    edition: if solution { "Instructor solutions" } else { "Student copy" },
    abstract: exam-spacing[
      *Winter semester 2026/27 · 90 minutes · 105 points*

      Theory: 60 minutes (Tasks 1–5, 65 points). Programming: 30 minutes (Task 6, 40 points).
      #if mock [
        This practice paper is slightly harder than the actual exam. Use the same time limit
        to identify topics that need more practice; finish remaining work afterwards.
      ]
      #if solution [
        *Instructor copy — do not distribute with the student paper.*
        Equivalent correct solutions earn full credit. Award partial credit by the criteria shown.
      ]

      #v(8pt)
      #table(columns: (1fr, 1fr), inset: 10pt, stroke: .5pt + palette.divider,
        [Name: #v(12pt)], [Student ID: #v(12pt)],
        table.cell(colspan: 2)[Date: #v(12pt)],
      )

      *Instructions*
      - Work individually. Answer Tasks 1–5 in the spaces provided; label any additional sheets with your student ID and task number.
      - For Task 6, submit the Java source files in a folder named `StudentID_LastName`. Use a standard JDK (Java 17 or later), without preview features or external libraries.
      - No GUI, interactive menu, file storage, or concurrency is required. Each task is independent.
      - You may use two double-sided A4 sheets or four single-sided A4 sheets as your cheat sheet. Only handwritten notes, made with a pen or on a tablet, are permitted. Typed and printed cheat sheets are not allowed.
      - Submit both your paper and your programming tasks using the designated drive in Explorer.
      - You may start with either theory or programming and switch between them at any time.
      - Check that your paper is complete using the page count in the footer.
    ],
    {
      show: exam-spacing
      set table(stroke: .5pt + palette.divider)
      show raw.where(block: true): set block(breakable: false)
      codly(inset: (x: 8pt, y: 1.5pt))
      table(columns: (1fr, ..points.map(_ => auto), auto), inset: 6pt,
        stroke: .5pt + palette.divider,
        [*Task*], ..range(1, 7).map(n => [*#n*]), [*Total*],
        [Available], ..points.map(n => [#n]), [#points.sum()],
        [Achieved], ..points.map(_ => []), [],
      )
      body
    },
  )
}

#let task(number, title) = {
  pagebreak()
  text(size: 10pt, weight: "semibold", fill: palette.green,
    if number < 6 { "THEORY · 60 MINUTES IN TOTAL" } else { "PROGRAMMING · 30 MINUTES" })
  heading(level: 1)[Task #number: #title]
  text(weight: "semibold")[#points.at(number - 1) points]
  v(7pt)
}

#let answer(height: 30mm, new-page: false, body) = if solution {
  if new-page { pagebreak() }
  block(width: 100%, inset: (left: 10pt), stroke: (left: 1.5pt + palette.green))[
    #block(sticky: true, text(weight: "semibold", fill: palette.green)[Solution / marking])
    #body
  ]
} else if height > 0mm {
  block(width: 100%, height: height)
}

// More space for handwritten code than for read-only listings.
#let completion(body) = {
  codly(inset: (x: 8pt, y: 4pt))
  body
  codly(inset: (x: 8pt, y: 1.5pt))
}

#let choices(rows) = table(
  columns: (auto, 1fr, 13mm, 13mm), inset: 8pt,
  stroke: .5pt + palette.divider,
  table.header([*No.*], [*Statement*], [*True*], [*False*]),
  ..rows.enumerate().map(((i, row)) => (
    [#(i + 1)], row.at(0),
    if solution and row.at(1) { [X] } else { [] },
    if solution and not row.at(1) { [X] } else { [] },
  )).flatten(),
)
