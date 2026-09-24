#import "@preview/touying:0.7.4": *
#import "@preview/gentle-clues:1.3.1" as clues
#import "@preview/codly:1.3.0": codly
#import "@preview/pinit:0.2.2": pin, pinit-point-from

// One quiet accent; rust and ochre are reserved for semantic distinctions.
#let palette = (
  paper: rgb("#fbfaf7"),
  ink: rgb("#272e2b"),
  green: rgb("#45685a"),
  blue: rgb("#45685a"),
  coral: rgb("#98513f"),
  yellow: rgb("#805e2b"),
  sandstone: rgb("#d7d9d1"),
  purple: rgb("#45685a"),
  stone: rgb("#737b75"),
  hairline: rgb("#dce0d9"),
  surface: rgb("#eff2ed"),
  divider: rgb("#aeb9b0"),
  muted: rgb("#5d6961"),
  relation: rgb("#315e4e"),
  instance: rgb("#914a38"),
)
#let dark-palette = (
  palette
    + (
      paper: rgb("#1f2924"),
      ink: rgb("#f5f4ef"),
      hairline: rgb("#4c5b51"),
      surface: rgb("#2b3730"),
      green: rgb("#b8cebd"),
      divider: rgb("#687c6d"),
      muted: rgb("#bcc9be"),
    )
)

#let footer(self) = {
  let t = self.store.hestia
  set text(size: 11pt, fill: t.muted)
  stack(dir: ttb, spacing: 9pt, line(length: 100%, stroke: .6pt + t.hairline), components.left-and-right(
    self.info.author + h(14pt) + if self.info.short-title == auto { self.info.title } else { self.info.short-title },
    context utils.slide-counter.display() + " / " + utils.last-slide-number,
  ))
}

#let header(self) = {
  let t = self.store.hestia
  set align(left + top)
  pad(top: 25pt, stack(
    dir: ttb,
    spacing: 8pt,
    text(size: 13pt, fill: t.muted, utils.display-current-heading(level: 1)),
    text(size: 34pt, weight: "semibold", tracking: -.02em, fill: t.ink, utils.display-current-heading(
      level: 2,
      numbered: false,
    )),
  ))
}

// Same config/repeat/setting/composer contract as Touying's standard slide.
#let slide(config: (:), repeat: auto, setting: body => body, composer: auto, ..bodies) = touying-slide-wrapper(self => {
  self = utils.merge-dicts(self, config-page(
    header: header,
    footer: footer,
  ))
  let compose = if composer == auto { cols.with(lazy-layout: false) } else { composer }
  let compact-compose(..bodies) = {
    // Keep Touying's counter/reveal preambles outside the measured content.
    // ponytail: dense legacy slides shrink as a unit; split them for larger projection text.
    let content = {
      show align.where(alignment: left + horizon): it => align(left + top, it.body)
      show align.where(alignment: center + horizon): it => align(center + top, it.body)
      compose(..bodies)
    }
    context utils.fit-to-height(height: page.height - 170pt, prescale-width: page.width - 104pt,
      grow: false, reflow: false, content)
  }
  touying-slide(self: self, config: config, repeat: repeat, setting: setting,
    composer: if self.store.hestia-compact { compact-compose } else { composer }, ..bodies)
})

#let title-slide(extra: none, ..args) = touying-slide-wrapper(self => {
  let info = self.info + args.named()
  let authors = info.at("authors", default: info.author)
  let t = self.store.hestia
  self = utils.merge-dicts(self, config-common(freeze-slide-counter: true), config-page(
    header: none,
    footer: none,
    margin: (x: 52pt, y: 44pt),
  ))
  touying-slide(self: self, {
    text(17pt, fill: t.green, weight: "semibold", info.subtitle)
    v(1fr)
    block(width: 100%, text(font: "Libertinus Serif", size: 60pt, tracking: -.025em, info.title))
    v(24pt)
    line(length: 62pt, stroke: 3pt + t.green)
    v(1fr)
    text(22pt, if type(authors) == array { authors.join([ · ]) } else { authors })
    v(5pt)
    text(14pt, fill: t.muted, utils.display-info-date(self))
    extra
  })
})

#let outline-slide() = slide[
  #text(34pt, weight: "semibold")[Today's route]
  #v(16pt)
  #set outline.entry(fill: none)
  #show outline.entry: it => block(inset: (y: 6pt), it)
  #outline(title: none, depth: 1)
]

#let new-section-slide(level: 1, numbered: true, title) = touying-slide-wrapper(self => {
  let t = self.store.hestia
  self = utils.merge-dicts(self, config-page(
    header: none,
    footer: footer,
    fill: t.surface,
    margin: (top: 52pt, bottom: 48pt, x: 52pt),
  ))
  touying-slide(self: self, align(left + horizon, {
    line(length: 62pt, stroke: 3pt + t.green)
    v(26pt)
    block(width: 92%, text(font: "Libertinus Serif", size: 56pt, tracking: -.02em, utils.display-current-heading(
      level: level,
      numbered: numbered,
    )))
  }))
})

#let two-column-slide(..args) = slide.with(composer: components.side-by-side.with(columns: (1fr, 1fr), gutter: 44pt))(
  ..args,
)
#let sidebar-slide(..args) = slide.with(composer: components.side-by-side.with(columns: (2fr, 1fr), gutter: 44pt))(
  ..args,
)
#let code-slide(..args) = slide(..args)
// With two bodies, reserve the remaining height for the diagram and caption.
#let diagram-slide(..args) = slide.with(composer: (..bodies) => {
  let bodies = bodies.pos()
  let panel(body) = context block(
    width: 100%,
    height: 100%,
    fill: if page.fill == dark-palette.paper { palette.paper } else { none },
    radius: 4pt,
    inset: 10pt,
    {
      set text(fill: palette.ink)
      // ponytail: 40pt caption budget; increase it if captions exceed two lines.
      set image(width: 100%, height: 100% - 40pt, fit: "contain")
      align(center + horizon, body)
    },
  )
  if bodies.len() == 1 {
    panel(bodies.first())
  } else {
    assert.eq(bodies.len(), 2, message: "diagram-slide expects a diagram, or text and a diagram")
    grid(
      columns: 1,
      rows: (auto, 1fr),
      gutter: 12pt,
      bodies.first(),
      panel(bodies.last()),
    )
  }
})(..args)
#let callout-slide(..args) = slide.with(setting: body => align(left + horizon, body))(..args)
#let footer-slide(body, ..args) = slide(
  ..args,
  setting: body => {
    set align(left + horizon)
    set text(size: 36pt, weight: "medium")
    body
  },
  body,
)

// Retain translated labels and task numbering alongside optional illustrations.
#let callout(clue: clues.info, accent: palette.blue, size: .88em, illustration: none, ..args) = {
  set text(size: size, fill: palette.ink)
  let body = clue(
    icon: none,
    accent-color: accent,
    border-width: 0pt,
    header-color: accent.lighten(91%),
    body-color: accent.lighten(91%),
    ..args,
  )
  if illustration == none { body } else {
    grid(columns: (auto, 1fr), column-gutter: 12pt, align: horizon, illustration, body)
  }
}
#let info = callout.with(clue: clues.info,
  illustration: image("info.png", width: 80pt, height: 80pt, fit: "contain", alt: ""))
#let memo = callout.with(clue: clues.memo, accent: palette.coral,
  illustration: image("memorize.png", width: 80pt, height: 80pt, fit: "contain", alt: ""))
#let warning = callout.with(clue: clues.warning, accent: palette.yellow,
  illustration: image("warning.png", width: 80pt, height: 80pt, fit: "contain", alt: ""))
#let tip = info
#let idea = memo
#let question = callout.with(clue: clues.question, accent: palette.blue, size: 1.12em, title: none,
  illustration: image("questions.png", width: 80pt, height: 80pt, fit: "contain", alt: ""))
#let example = info
#let conclusion = callout.with(clue: clues.conclusion, accent: palette.green)
#let success = callout.with(clue: clues.success, accent: palette.green)
#let error = callout.with(clue: clues.error, accent: palette.coral)
#let quotation = callout.with(clue: clues.quotation, accent: palette.green)
#let task = callout.with(clue: clues.task, accent: palette.green,
  illustration: image("task.png", width: 80pt, height: 80pt, fit: "contain", alt: ""))

// Pinit annotations stay outside the code frame; never clip the slide body.
// ponytail: offsets/400pt width fit the pilot's five lines; retune for longer code.
#let pinit-rect-from(height: auto, pos: bottom, fill: palette.relation, point-pin, body) = {
  set text(size: 20pt)
  let height = if height == auto { if pos == bottom { 6em } else { 2em } } else { height }
  pinit-point-from(
    fill: fill,
    pin-dx: 0em,
    pin-dy: if pos == bottom { 0em } else { -0.6em },
    body-dx: 0pt,
    body-dy: if pos == bottom { -1.7em } else { -1.6em },
    offset-dx: 0em,
    offset-dy: if pos == bottom { 1.2em + height } else { -0.6em - height },
    point-pin,
    rect(
      width: if pos == bottom { 400pt } else { auto },
      inset: 0.5em,
      fill: white,
      stroke: (bottom: 0.12em + fill),
      text(fill: fill, body),
    ),
  )
}

#let hestia-theme(dark: false, compact: false, image-source: source => source, ..args, body) = {
  let t = if dark { dark-palette } else { palette }
  show: touying-slides.with(
    config-page(
      paper: "presentation-16-9",
      fill: t.paper,
      background: rect(width: 100%, height: 100%, stroke: none, fill: tiling(size: (16pt, 16pt), place(
        center + horizon,
        circle(radius: .35pt, fill: t.green, stroke: none),
      ))),
      margin: (top: 112pt, bottom: 48pt, x: 52pt),
      header-ascent: 0pt,
      footer-descent: 26pt,
    ),
    config-common(
      breakable: not compact,
      ..if compact { (default-frozen-counters: ()) } else { (:) },
      slide-fn: slide,
      new-section-slide-fn: new-section-slide,
      zero-margin-header: false,
      zero-margin-footer: false,
    ),
    config-colors(primary: t.ink, neutral-darkest: t.ink, neutral-lightest: t.paper),
    config-store(hestia: t, hestia-compact: compact),
    config-methods(init: (self: none, body) => {
      set text(font: "Source Sans 3", size: 25pt, fill: t.ink)
      set par(leading: if compact { .2em } else { .35em })
      set list(tight: false, indent: 0pt, body-indent: .8em, spacing: if compact { .2em } else { .55em })
      set enum(tight: false, indent: 0pt, body-indent: .5em, spacing: if compact { .2em } else { .8em })
      set align(left + top)
      show heading: set text(weight: "semibold")
      show strong: it => text(weight: "bold", it.body)
      set figure(numbering: none) if compact
      show figure.caption: set text(size: 15pt, fill: palette.muted)
      // Resolve legacy percentage heights before measuring a compact slide.
      show image: it => context {
        if compact and type(it.height) == relative and it.height.ratio != 0% {
          let fields = it.fields()
          let source = fields.remove("source")
          fields.height = it.height.ratio * (page.height - 160pt) + it.height.length
          image(image-source(source), ..fields)
        } else { it }
      }
      // Syntax highlighting assumes a light surface; Codly supplies it.
      set raw(theme: "syntax.tmTheme")
      show raw: it => context text(
        font: "JetBrainsMono NFM",
        size: if compact { calc.min(20pt, text.size) } else { 20pt },
        it,
      )
      show raw.where(block: true): set text(fill: palette.ink)
      show raw: it => {
        show regex("pin\\d"): it => pin(eval(it.text.slice(3)))
        it
      }
      show: clues.gentle-clues.with(
        border-radius: 4pt,
        content-inset: (x: 16pt, top: 6pt, bottom: 14pt),
        header-inset: (x: 16pt, top: 10pt, bottom: 2pt),
      )
      codly(
        inset: if compact { (x: .32em, y: .08em) } else { .32em },
        radius: 4pt,
        fill: white,
        zebra-fill: palette.surface,
        stroke: .6pt + palette.hairline,
        languages: (
          sql: (
            name: text(font: "JetBrainsMono NFM", " SQL", weight: "bold"),
            color: palette.relation,
          ),
          java: (
            name: text(font: "JetBrainsMono NFM", " Java", weight: "bold"),
            color: palette.relation,
          ),
          c: (
            name: text(font: "JetBrainsMono NFM", " C", weight: "bold"),
            color: palette.relation,
          ),
        ),
      )
      body
    }),
    ..args,
  )
  body
}
