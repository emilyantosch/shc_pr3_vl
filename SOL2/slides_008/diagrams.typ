#import "@preview/cetz:0.4.1": canvas, draw
#import "../hestia/theme.typ": palette
#import "../slides_002/diagrams.typ": node, arrow, label
#import "../slides_005/diagrams.typ": uml, inherits

#let roadmap() = {
  for (x, title, detail) in (
    (0, [Graphical interfaces], [Components + events]),
    (9, [Exception handling], [Control exceptional paths]),
    (18, [Input and output], [Files + streams]),
  ) {
    node(x, 2, strong(title), width: 8,
      fill: if x == 9 { palette.green.lighten(85%) } else { palette.surface })
    label((x, .5), detail)
    label((x, 3.5), if x == 0 { [Previously] } else if x == 9 { [Today] } else { [Next] })
    if x < 18 { arrow((x + 4, 2), (x + 5, 2)) }
  }
}

#let goals() = {
  node(0, 3, [Exceptional situation], width: 8)
  for (y, title, detail) in ((5, [Handle], [Catch · recover · propagate]), (0, [Model], [Define an application-specific type])) {
    node(11, y, strong(title), width: 8)
    arrow((4, 3), (5.5, 3), (5.5, y), (7, y))
    label((11, y - 1.5), detail)
  }
}

#let failures() = {
  for (i, cause, kind) in (
    (0, [Integer division by zero], [ArithmeticException]),
    (1, [Dereference null], [NullPointerException]),
    (2, [Invalid array index], [ArrayIndexOutOfBoundsException]),
    (3, [Parse "12a4" as an integer], [NumberFormatException]),
    (4, [Open a missing file], [FileNotFoundException]),
    (5, [Exhaust memory], [OutOfMemoryError]),
  ) {
    let y = 10 - i * 2
    node(0, y, cause, width: 11)
    node(15, y, kind, width: 15)
    arrow((5.5, y), (7.5, y))
  }
}

#let hierarchy() = {
  uml(7, 8, [Throwable], width: 7)
  uml(0, 4.5, [Exception], width: 8)
  uml(14, 4.5, [Error], width: 8)
  inherits((0, 4.5), (0, 6), (7, 6), (7, 7.15))
  inherits((14, 4.5), (14, 6), (7, 6), (7, 7.15))
  label((0, 2), [Application may recover])
  label((14, 2), [Serious JVM / system problem])
  label((14, .7), [Usually not recoverable])
  label((7, -1.5), [Both are throwable objects · Error can be caught, but rarely should be])
}

#let handling() = {
  for (x, title) in ((0, [Operation fails]), (10, [Throw exception object]), (20, [Find matching handler])) {
    node(x, 6, title, width: 9)
    if x < 20 { arrow((x + 4.5, 6), (x + 5.5, 6)) }
  }
  node(12, 2, [Execute catch block], width: 9)
  node(26, 2, [Uncaught: thread ends], width: 10)
  arrow((20, 5.5), (20, 4), (12, 4), (12, 2.5))
  arrow((20, 4), (26, 4), (26, 2.5))
  label((14, 4.8), [Found])
  label((25, 4.8), [None])
  node(12, -1, [Continue after handler], width: 9)
  arrow((12, 1.5), (12, -.5))
  label((0, 2), [Normal path stops])
  label((0, .5), [Search outward through callers])
}

#let stack-trace() = {
  node(0, 5, [main() · line 3], width: 9)
  node(14, 5, [printRatio() · line 8], width: 10)
  arrow((4.5, 5), (9, 5))
  label((7, 5.8), [calls])
  node(14, 1.5, [ArithmeticException], width: 10, fill: palette.coral.lighten(90%))
  arrow((14, 4.5), (14, 2))
  label((0, 1.5), [Message: Division by zero])
  label((7, -.5), [Trace order: throw site first, then its callers])
}

#let catch-flow() = {
  node(0, 6, [Execute try], width: 7)
  node(12, 6, [First matching catch], width: 10)
  node(12, 2, [Propagate to caller], width: 10)
  node(0, -1, [Continue after try / catch], width: 11)
  arrow((3.5, 6), (7, 6))
  label((6, 7), [throw])
  arrow((0, 5.5), (0, -.5))
  label((-4, 2.5), [No exception])
  arrow((5.5, 6), (5.5, 2), (7, 2))
  label((10, 3.4), [No match])
  arrow((17, 6), (19, 6), (19, -1), (5.5, -1))
  label((11, 0), [Catch completes normally])
}

#let methods() = {
  node(0, 3, [Caught object e], width: 7)
  for (y, method, result) in ((6, [getMessage()], [Detail message]), (3, [toString()], [Type + message]), (0, [printStackTrace()], [Trace to standard error])) {
    node(11, y, method, width: 9)
    arrow((3.5, 3), (5, 3), (5, y), (6.5, y))
    label((23, y), result)
    arrow((15.5, y), (18, y))
  }
}

#let catch-order() = {
  node(0, 7, [Thrown object], width: 8)
  for (y, kind, result) in ((4, [Matches catch 1?], [Run catch 1]), (0, [Matches catch 2?], [Run catch 2])) {
    node(0, y, kind, width: 8)
    node(13, y, result, width: 8)
    arrow((4, y), (9, y))
    label((6.5, y + .8), [Yes])
  }
  arrow((0, 6.5), (0, 4.5))
  arrow((0, 3.5), (0, .5))
  label((1.2, 2), [No])
  node(0, -3.5, [Propagate], width: 8)
  arrow((0, -.5), (0, -3))
  label((1.2, -1.8), [No])
  label((13, -2), [Only the first match runs])
  label((7, -5.3), [Subclasses before superclasses · unreachable catch blocks do not compile])
}

#let catch-scope() = {
  node(0, 6, [try throws A], width: 9)
  node(12, 6, [catch A throws B], width: 10, fill: palette.coral.lighten(90%))
  arrow((4.5, 6), (7, 6))
  node(0, 1, [Sibling catch B], width: 9)
  label((0, -.5), [Does not handle B from catch A])
  node(12, 1, [Enclosing try / caller], width: 10)
  arrow((12, 5.5), (12, 1.5))
  label((18, 3.5), [Search outward])
  label((8, -3), [Or put a nested try / catch around the failing code inside catch A])
}

#let finally-flow() = {
  for (x, title, after) in ((0, [Normal completion], [Continue]), (12, [Pending return], [Return value]), (24, [Uncaught exception], [Propagate])) {
    node(x, 6, title, width: 10)
    node(x, 2.5, [finally · cleanup], width: 10, fill: palette.green.lighten(85%))
    node(x, -1, after, width: 10)
    arrow((x, 5.5), (x, 3))
    arrow((x, 2), (x, -.5))
  }
  label((12, -3), [Assumes finally completes normally · a return / throw there replaces the pending exit])
}

#let structure() = {
  node(0, 4, [try · exactly one], width: 8)
  node(11, 4, [catch · zero or more], width: 9)
  node(23, 4, [finally · zero or one], width: 9)
  arrow((4, 4), (6.5, 4))
  arrow((15.5, 4), (18.5, 4))
  label((11, 1.5), [Ordinary try needs catch, finally, or both])
  label((11, 0), [Valid: try → catch · try → finally · try → catch → finally])
}

#let custom() = {
  uml(8, 10, [Throwable], width: 14, rows: (
    [\+ Throwable()], [\+ Throwable(String message)], [\+ getMessage(): String],
    [\+ printStackTrace(): void], [\+ toString(): String],
  ))
  uml(0, 3.5, [Exception], width: 9)
  uml(17, 3.5, [Error], width: 9)
  inherits((0, 3.5), (0, 5), (8, 5), (8, 5.9))
  inherits((17, 3.5), (17, 5), (8, 5), (8, 5.9))
  uml(0, 0, [NegativeParamException], width: 12)
  inherits((0, 0), (0, 2.65))
  label((16, -.4), [Application-specific checked type])
}

#let checked-choice() = {
  node(0, 3, [Checked exception], width: 9)
  for (y, title, detail) in ((6, [catch], [Handle here]), (0, [throws], [Declare · caller must handle or declare])) {
    node(12, y, title, width: 8)
    arrow((4.5, 3), (6, 3), (6, y), (8, y))
    label((12, y - 1.5), detail)
  }
  label((0, 0), [Compiler requires one path])
}

#let checked-tree() = {
  uml(13, 10, [Throwable], width: 8)
  uml(7, 6.5, [Exception], width: 9)
  uml(25, 6.5, [Error], width: 9, color: palette.coral.lighten(90%))
  inherits((7, 6.5), (7, 8), (13, 8), (13, 9.15))
  inherits((25, 6.5), (25, 8), (13, 8), (13, 9.15))
  uml(0, 2.5, [NegativeParamException], width: 12)
  uml(14, 2.5, [RuntimeException], width: 11, color: palette.coral.lighten(90%))
  inherits((0, 2.5), (0, 4.5), (7, 4.5), (7, 5.65))
  inherits((14, 2.5), (14, 4.5), (7, 4.5), (7, 5.65))
  label((0, .3), [Checked: catch or declare])
  label((14, .3), [Unchecked + subclasses])
  label((25, 4.7), [Unchecked + subclasses])
  label((11, -2), [All other Throwable types are checked · unchecked does not mean harmless])
}

#let message() = {
  for (x, title, detail) in ((0, [new MyException(text)], [Supply detail]), (12, [super(text)], [Store in Throwable]), (24, [e.getMessage()], [Read detail])) {
    node(x, 2, title, width: 11)
    label((x, .3), detail)
    if x < 24 { arrow((x + 5.5, 2), (x + 6.5, 2)) }
  }
}

#let diagrams = (
  roadmap: roadmap, goals: goals, failures: failures, hierarchy: hierarchy,
  handling: handling, stack-trace: stack-trace, catch-flow: catch-flow,
  methods: methods, catch-order: catch-order, catch-scope: catch-scope,
  finally-flow: finally-flow, structure: structure, custom: custom,
  checked-choice: checked-choice, checked-tree: checked-tree, message: message,
)

#let diagram(name, height: 260pt) = layout(size => {
  set text(size: 18pt, fill: palette.ink)
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
