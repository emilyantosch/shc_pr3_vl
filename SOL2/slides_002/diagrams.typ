#import "@preview/cetz:0.4.1": canvas, draw
#import "../hestia/theme.typ": palette

// Same CeTZ geometry and palette as lecture 1; all drawings remain editable here.
#let label(at, body, color: palette.ink) = draw.content(at, text(fill: color, body))
#let node(x, y, body, width: 3, height: 1, fill: palette.surface) = {
  draw.rect((x - width / 2, y - height / 2), (x + width / 2, y + height / 2),
    fill: fill, radius: .08)
  draw.content((x, y), align(center, body))
}
#let arrow(..points, color: palette.relation, dashed: false) = draw.line(..points,
  stroke: (paint: color, thickness: 1pt, dash: if dashed { "dashed" } else { "solid" }),
  mark: (end: ">"))
#let decision(x, y, body) = {
  draw.line((x - 1.8, y), (x, y + 1), (x + 1.8, y), (x, y - 1),
    close: true, fill: palette.yellow.lighten(90%))
  draw.content((x, y), align(center, body))
}

#let roadmap() = {
  for (x, title, detail) in (
    (0, [*First program*], [Compile · run]),
    (6, [*Imperative concepts*], [State · expressions · flow]),
    (12, [*Objects*], [Classes · class library]),
  ) {
    node(x, 1, title, width: 5.5, fill: if x == 6 { palette.green.lighten(80%) } else { palette.surface })
    label((x, -.2), detail)
  }
  arrow((2.75, 1), (3.25, 1))
  arrow((8.75, 1), (9.25, 1))
  label((6, 2.2), [Today], color: palette.relation)
}

#let memory() = {
  node(0, 1, [`byte count = 3;`], width: 5)
  arrow((2.5, 1), (4, 1))
  for (i, bit) in (0, 0, 0, 0, 0, 0, 1, 1).enumerate() {
    node(4.5 + i, 1, str(bit), width: 1, fill: if bit == 1 { palette.green.lighten(80%) } else { white })
  }
  label((8, 2.2), [Memory: 8 bits])
  label((8, -.3), [Interpreted as a byte: *3*])
}

#let data-types() = {
  node(7, 6, [*Java types*], width: 4)
  node(3, 4.4, [*Primitive*], width: 5, fill: palette.green.lighten(80%))
  node(12, 4.4, [*Reference*], width: 5, fill: palette.green.lighten(80%))
  arrow((5, 6), (3, 6), (3, 4.9))
  arrow((9, 6), (12, 6), (12, 4.9))
  for (y, body) in (
    (2.9, [Integer: byte · short · int · long]),
    (1.7, [Floating point: float · double]),
    (.5, [Character: char]),
    (-.7, [Truth: boolean]),
  ) {
    node(3.5, y, body, width: 7, height: .85)
    arrow((.5, 4.4), (-1, 4.4), (-1, y), (0, y))
  }
  for (y, body) in ((2.9, [Classes, including String]), (1.7, [Interfaces]), (.5, [Arrays])) {
    node(12.5, y, body, width: 6, height: .85)
    arrow((9.5, 4.4), (8.5, 4.4), (8.5, y), (9.5, y))
  }
}

#let variable-lifecycle() = {
  node(0, 2, [`int age;`], width: 4)
  node(6, 2, [`age = 24;`], width: 4)
  node(12, 2, [`println(age)`], width: 4)
  arrow((2, 2), (4, 2))
  arrow((8, 2), (10, 2))
  label((0, 3.2), [Declare])
  label((6, 3.2), [Initialize])
  label((12, 3.2), [Use])
  draw.line((0, 1.3), (0, .5), (6, .5), (6, 1.3))
  label((3, -.2), [One step: `int age = 24;`])
}

#let scope() = {
  draw.rect((0, 0), (15, 6), fill: palette.surface, radius: .1)
  label((7.5, 5.4), [*Method block*: `int outer = 1;`])
  draw.rect((1, 1.9), (9, 4.6), fill: palette.green.lighten(85%), radius: .1)
  label((5, 3.9), [*Inner block*: `int inner = 2;`])
  label((5, 2.8), [`outer` and `inner` are in scope])
  label((7.5, .8), [After the inner block: only `outer` is in scope])
  arrow((11, 4.8), (11, 3.2), (9, 3.2))
  label((12.5, 3.2), [`outer`])
}

#let literal-types() = {
  for (x, literal, kind) in ((0, [`42`], [`int`]), (4, [`3.14`], [`double`]),
    (8, [`3.14f`], [`float`]), (12, [`"Java"`], [`String`])) {
    node(x, 2, literal, width: 3)
    node(x, 0, kind, width: 3, fill: palette.green.lighten(85%))
    arrow((x, 1.5), (x, .5))
  }
}

#let unicode() = {
  node(0, 3, [A · U+0041], width: 4)
  node(7, 3, [`\u0041`], width: 6)
  arrow((2, 3), (4, 3))
  label((12, 3), [1 char])
  node(0, 1, [😀 · U+1F600], width: 4)
  node(7, 1, [`\uD83D\uDE00`], width: 6)
  arrow((2, 1), (4, 1))
  label((12, 1), [2 chars])
  label((7, -.3), [One char = one 16-bit UTF-16 code unit])
}

#let increment() = {
  for (y, title, first, second) in (
    (3, [*Prefix* `++a`], [Increment a], [Use new value]),
    (0, [*Postfix* `a++`], [Use old value], [Increment a]),
  ) {
    label((0, y), title)
    node(5, y, first, width: 4.5)
    node(11, y, second, width: 4.5)
    arrow((1.8, y), (2.75, y))
    arrow((7.25, y), (8.75, y))
  }
}

#let short-circuit() = {
  for (x, op, stop-value, other, result) in (
    (0, [`left || right`], [true], [false], [`true`]),
    (10, [`left && right`], [false], [true], [`false`]),
  ) {
    label((x, 5.6), op)
    decision(x, 3.8, [left])
    node(x - 2.4, 1, [Skip right\ #result], width: 3.8, height: 1.6)
    node(x + 2.4, 1, [Evaluate\ right], width: 3.8, height: 1.6)
    arrow((x - 1.8, 3.8), (x - 2.4, 3.8), (x - 2.4, 1.8))
    arrow((x + 1.8, 3.8), (x + 2.4, 3.8), (x + 2.4, 1.8))
    label((x - 3.5, 2.8), stop-value)
    label((x + 3.5, 2.8), other)
  }
}

#let narrowing() = {
  node(0, 2, [`double`\ 128.38], width: 4, height: 1.4)
  node(6, 2, [`int`\ 128], width: 4, height: 1.4)
  node(12, 2, [`byte`\ −128], width: 4, height: 1.4)
  arrow((2, 2), (4, 2))
  arrow((8, 2), (10, 2))
  label((3, 3.2), [`(int)`])
  label((9, 3.2), [`(byte)`])
  label((3, .2), [Discard fraction])
  label((10, .2), [Keep low 8 bits: 10000000])
}

#let widening() = {
  for (i, name, bytes) in ((0, [byte], [1 byte]), (1, [short], [2 bytes]), (2, [int], [4 bytes]),
    (3, [long], [8 bytes]), (4, [float], [4 bytes]), (5, [double], [8 bytes])) {
    node(i * 3.2, 2, name, width: 2.3)
    label((i * 3.2, 3.2), bytes)
    if i < 5 { arrow((i * 3.2 + 1.15, 2), (i * 3.2 + 2.05, 2)) }
  }
  node(3.2, -.2, [char], width: 2.3)
  arrow((4.35, -.2), (6.4, -.2), (6.4, 1.5))
  label((10.8, -.3), [Arrows compose; no explicit cast])
}

#let branch(otherwise: false, ternary: false) = {
  decision(6, 4, [condition])
  arrow((6, 6), (6, 5))
  node(1.5, 1.8, if ternary { [expression 1] } else { [statements 1] }, width: 4)
  arrow((4.2, 4), (1.5, 4), (1.5, 2.3))
  label((2.4, 4.5), [true])
  arrow((1.5, 1.3), (1.5, 0), (6, 0))
  arrow((7.8, 4), (10.5, 4), (10.5, if otherwise { 2.3 } else { 0 }))
  label((9.6, 4.5), [false])
  if otherwise {
    node(10.5, 1.8, if ternary { [expression 2] } else { [statements 2] }, width: 4)
    arrow((10.5, 1.3), (10.5, 0), (6, 0))
  } else { arrow((10.5, 0), (6, 0)) }
  arrow((6, 0), (6, -.9))
  if ternary { label((6, -1.5), [Use the selected value]) }
}

#let weekday() = {
  node(6, 4, [`weekDay`], width: 4)
  for (x, day, action) in ((0, [1–5], [Working]), (6, [6], [Shopping]), (12, [7], [Resting])) {
    node(x, 0, action, width: 4)
    arrow((6, 3.5), (6, 2.5), (x, 2.5), (x, .5))
    label((x + .6, 1.6), day)
  }
}

#let switch-flow() = {
  node(6, 6, [Evaluate expression once], width: 7)
  decision(6, 3.9, [Match?])
  arrow((6, 5.5), (6, 4.9))
  node(1, 1.6, [Matching case], width: 4.5)
  node(11, 1.6, [default, if present], width: 5)
  arrow((4.2, 3.9), (1, 3.9), (1, 2.1))
  arrow((7.8, 3.9), (11, 3.9), (11, 2.1))
  label((2, 4.4), [yes])
  label((10, 4.4), [no])
  node(6, -.4, [Run from the chosen label], width: 8)
  arrow((1, 1.1), (1, -.4), (2, -.4))
  arrow((11, 1.1), (11, -.4), (10, -.4))
  node(6, -2.4, [break or end of switch], width: 8)
  arrow((6, -.9), (6, -1.9))
}

#let while-loop() = {
  decision(4, 2, [condition])
  node(10, 2, [Loop body], width: 4)
  arrow((0, 2), (2.2, 2))
  arrow((5.8, 2), (8, 2))
  label((6.8, 2.5), [true])
  arrow((12, 2), (13, 2), (13, 4.5), (4, 4.5), (4, 3))
  node(4, -1.5, [After loop], width: 4)
  arrow((4, 1), (4, -1))
  label((4.8, 0), [false])
}

#let do-while-loop() = {
  node(3, 2, [Loop body], width: 4)
  decision(10, 2, [condition])
  arrow((-1, 2), (1, 2))
  arrow((5, 2), (8.2, 2))
  arrow((11.8, 2), (13, 2), (13, 4.5), (3, 4.5), (3, 2.5))
  label((11.8, 5), [true])
  node(10, -1.5, [After loop], width: 4)
  arrow((10, 1), (10, -1))
  label((10.8, 0), [false])
}

#let for-loop(jumps: false) = {
  node(0, 3, [Init], width: 2.5)
  decision(5, 3, [condition])
  node(10, 3, [Loop body], width: 3)
  node(15, 3, [Update], width: 3)
  arrow((-2.5, 3), (-1.25, 3))
  arrow((1.25, 3), (3.2, 3))
  arrow((6.8, 3), (8.5, 3))
  label((7.6, 3.5), [true])
  arrow((11.5, 3), (13.5, 3))
  arrow((16.5, 3), (17.5, 3), (17.5, 5.5), (5, 5.5), (5, 4))
  node(5, -1.5, [After loop], width: 3.5)
  arrow((5, 2), (5, -1))
  label((4, .7), [false])
  if jumps {
    arrow((10, 2.5), (10, 1.3), (15, 1.3), (15, 2.5), color: palette.yellow, dashed: true)
    label((12.5, .8), [`continue`], color: palette.yellow)
    arrow((10, 1.3), (10, -1.5), (6.75, -1.5), color: palette.coral, dashed: true)
    label((11, -1), [`break`], color: palette.coral)
  }
}

#let diagrams = (
  roadmap: roadmap, memory: memory, data-types: data-types,
  variable-lifecycle: variable-lifecycle, scope: scope, literal-types: literal-types,
  unicode: unicode, increment: increment, short-circuit: short-circuit,
  narrowing: narrowing, widening: widening,
  "if": branch, if-else: branch.with(otherwise: true),
  ternary: branch.with(otherwise: true, ternary: true),
  weekday: weekday, switch: switch-flow, "while": while-loop,
  do-while: do-while-loop, "for": for-loop, jumps: for-loop.with(jumps: true),
)

#let diagram(name, height: 230pt) = layout(size => {
  set text(size: 16pt, fill: palette.ink)
  set par(leading: .5em)
  let body = canvas({
    draw.set-style(stroke: .8pt + palette.muted)
    diagrams.at(name)()
  })
  let natural = measure(body)
  let factor = calc.min(size.width / natural.width, height / natural.height)
  assert(factor > 0, message: "No room for diagram: " + name)
  align(center, scale(x: factor * 100%, y: factor * 100%, reflow: true, body))
})
