#import "theme.typ": palette
#import "@preview/codly:1.3.0": codly, codly-init

#let medium = sys.inputs.at("medium", default: "digital")
#let solution-input = sys.inputs.at("solution", default: "false")
#assert(medium in ("digital", "print"), message: "medium must be digital or print")
#assert(solution-input in ("true", "false"), message: "solution must be true or false")
#let solution = solution-input == "true"
#let print-version = medium == "print"

#let memo(body) = block(
  width: 100%,
  breakable: false,
  inset: 12pt,
  stroke: (left: 2pt + palette.green),
  fill: if print-version { none } else { palette.surface },
  {
    set text(size: 10pt)
    set heading(level: 2, outlined: false)
    body
  },
)
#let tip(body) = memo[
  #text(weight: "semibold", fill: palette.green)[Tip]
  #parbreak()
  #body
]

#let lab-theme(title: "", university: [], institute: [], seminar: [], abstract: [], author: "",
  edition: if solution { "With solutions" } else { "Exercises" }, body) = {
  let lab = title.split(" - ").first()
  set document(title: title + " — " + edition, author: author.split(" & "))
  set text(font: "Source Sans 3", size: 11pt, lang: "en", fill: palette.ink)
  set par(leading: .55em, spacing: .8em)
  set page(
    paper: "a4",
    margin: (x: 20mm, top: 19mm, bottom: 21mm),
    fill: if print-version { white } else { palette.paper },
    background: if not print-version {
      rect(width: 100%, height: 100%, stroke: none, fill: tiling(size: (16pt, 16pt), place(
        center + horizon, circle(radius: .25pt, fill: palette.divider, stroke: none),
      )))
    },
    header: context if counter(page).get().first() > 1 {
      text(size: 9pt, fill: palette.muted)[#seminar #h(1fr) #lab · #edition]
    },
    footer: context {
      set text(size: 9pt, fill: palette.muted)
      line(length: 100%, stroke: .5pt + palette.hairline)
      v(5pt)
      [#seminar · #lab #h(1fr) #counter(page).display("1 / 1", both: true)]
    },
  )
  set list(indent: 0pt, body-indent: 1em, spacing: .35em)
  set enum(indent: 0pt, body-indent: .6em, spacing: .35em)
  set heading(numbering: none)
  show heading.where(level: 1): set text(size: 21pt, weight: "semibold", tracking: -.02em)
  show heading.where(level: 2): set text(size: 13pt, weight: "semibold", fill: palette.green)
  show strong: set text(weight: "bold")
  set figure(numbering: none)
  set image(width: 80%)
  set raw(theme: "syntax.tmTheme")
  show raw: set text(font: "JetBrainsMono NFM", size: 9pt)
  show: codly-init.with()
  codly(
    inset: (x: 8pt, y: 3pt),
    radius: 3pt,
    fill: white,
    zebra-fill: if print-version { none } else { palette.surface },
    lang-fill: lang => if print-version { white } else { palette.surface },
    stroke: .5pt + palette.hairline,
    languages: (
      java: (name: "Java", color: palette.relation),
      c: (name: "C", color: palette.relation),
    ),
  )

  text(size: 10pt, weight: "semibold", fill: palette.green)[#seminar / #edition]
  v(12pt)
  block(text(font: "Libertinus Serif", size: 30pt, tracking: -.02em, title))
  v(10pt)
  line(length: 44pt, stroke: 2pt + palette.green)
  v(10pt)
  text(size: 10pt, fill: palette.muted, author.replace(" & ", " · "))
  linebreak()
  text(size: 9pt, fill: palette.muted)[#university · #institute]
  v(14pt)
  abstract
  v(10pt)
  text(weight: "semibold", fill: palette.green)[Tasks]
  set outline.entry(fill: none)
  outline(title: none, depth: 1)
  v(12pt)
  body
}
