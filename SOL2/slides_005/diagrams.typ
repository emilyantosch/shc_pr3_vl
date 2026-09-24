#import "@preview/cetz:0.4.1": canvas, draw
#import "../hestia/theme.typ": palette
#import "../slides_002/diagrams.typ": node, arrow, label

// UML boxes use a top-edge y coordinate; hollow triangles point to the superclass.
#let uml(x, y, title, rows: (), width: 5, color: palette.surface) = {
  let height = .85 + .65 * rows.len()
  draw.rect((x - width / 2, y - height), (x + width / 2, y), fill: white)
  draw.rect((x - width / 2, y - .85), (x + width / 2, y), fill: color)
  label((x, y - .425), strong(title))
  for (i, row) in rows.enumerate() {
    draw.content((x - width / 2 + .25, y - 1.175 - .65 * i), row, anchor: "west")
  }
}
#let inherits(..points) = {
  let (x, y) = points.pos().last()
  draw.line(..points, stroke: 1pt + palette.relation)
  draw.line((x, y), (x - .25, y - .45), (x + .25, y - .45), close: true,
    fill: white, stroke: 1pt + palette.relation)
}

#let roadmap() = {
  for (x, name, detail) in (
    (0, [Class libraries], [Reuse existing types]),
    (7, [Inheritance], [Extend types · protect state]),
    (14, [Interfaces], [Define shared contracts]),
  ) {
    node(x, 1, strong(name), width: 6,
      fill: if x == 7 { palette.green.lighten(80%) } else { palette.surface })
    label((x, -.4), detail)
  }
  arrow((3, 1), (4, 1))
  arrow((10, 1), (11, 1))
  label((7, 2.5), [Today])
}

#let inheritance() = {
  uml(0, 4, [A · superclass])
  uml(0, 0, [B · subclass])
  inherits((0, 0), (0, 3.15))
  label((6, 3.55), [Existing fields and methods])
  label((6, -.4), [Adds fields and methods])
  arrow((-4, 2.9), (-4, .3))
  label((-7, 1.6), [Specialization])
  arrow((10.5, .3), (10.5, 2.9))
  label((13.5, 1.6), [Generalization])
  label((3, -2.2), [`class B extends A` · B is an A])
}

#let pilot(object: false) = {
  uml(0, 5, [Person], rows: ([\~ name: String],))
  uml(0, 1, [Pilot], rows: ([\~ flightHours: int],))
  inherits((0, 1), (0, 3.5))
  if object {
    uml(10, 4, underline([pilot: Pilot]), width: 7.5,
      rows: ([name = "Lukas Luft"], [flightHours = 1482]))
    arrow((2.5, .2), (5, .2), (5, 2.5), (6.25, 2.5), dashed: true)
    label((10, .4), [One object, both fields])
  } else {
    label((6, 4.2), [Inherited: name])
    label((6, .2), [Added: flightHours])
  }
}

#let access-grid() = {
  let widths = (4.5, 3, 3.5, 4.5, 3.5)
  let rows = (
    ([*Member modifier*], [*Same class*], [*Same package*], [*Subclass*\ *elsewhere*], [*Unrelated*\ *class*]),
    ([`public` · +], [yes], [yes], [yes], [yes]),
    ([`protected` · \#], [yes], [yes], [restricted\*], [no]),
    ([none · \~], [yes], [yes], [no], [no]),
    ([`private` · −], [yes], [no], [no], [no]),
  )
  for (i, row) in rows.enumerate() {
    let x = 0
    for (j, cell) in row.enumerate() {
      node(x + widths.at(j) / 2, -i * 1.2, text(16pt, cell), width: widths.at(j), height: 1.2,
        fill: if i == 0 { palette.green.lighten(85%) } else { white })
      x += widths.at(j)
    }
  }
  label((9.5, -6.2), [\*Outside the package: instance access through subclass-typed receivers only.])
}

#let members() = {
  for (y, kind, rule) in (
    (4, [Accessible instance members], [Inherited · methods may be overridden]),
    (1.5, [Accessible static members], [Inherited · belong to the class; may be hidden]),
    (-1, [Private members], [Not inherited · superclass state still exists in the object]),
    (-3.5, [Constructors], [Not inherited · invoked through constructor chaining]),
  ) {
    node(0, y, kind, width: 8)
    node(13, y, rule, width: 15)
    arrow((4, y), (5.5, y))
  }
}

#let models() = {
  for (y, title) in ((5, [A]), (2, [B]), (-1, [C])) { uml(0, y, title, width: 2) }
  inherits((0, 2), (0, 4.15))
  inherits((0, -1), (0, 1.15))
  label((0, -2.5), [Valid: chain])
  uml(8, 5, [A], width: 2)
  for (x, title) in ((5, [B]), (8, [C]), (11, [D])) {
    uml(x, 0, title, width: 2)
    inherits((x, 0), (x, 2.7), (8, 2.7), (8, 4.15))
  }
  label((8, -2.5), [Valid: siblings])
  uml(17, 5, [A], width: 2)
  uml(21, 5, [B], width: 2)
  uml(19, 0, [C], width: 2)
  inherits((19, 0), (19, 2.7), (17, 2.7), (17, 4.15))
  inherits((19, 0), (19, 2.7), (21, 2.7), (21, 4.15))
  label((19, 1.2), [×], color: palette.instance)
  label((19, -2.5), [Invalid: two direct superclasses], color: palette.instance)
}

#let object-root() = {
  uml(7, 6, [Object], rows: ([\+ toString(): String],), width: 6)
  for (x, title) in ((0, [Person]), (14, [Shape])) {
    uml(x, 2.5, title, width: 5)
    inherits((x, 2.5), (x, 3.5), (7, 3.5), (7, 4.5))
  }
  uml(0, -.5, [Pilot])
  inherits((0, -.5), (0, 1.65))
  for (x, title) in ((10.5, [Circle]), (17.5, [Rectangle])) {
    uml(x, -.5, title, width: 5)
    inherits((x, -.5), (x, .6), (14, .6), (14, 1.65))
  }
  label((8, -2.9), [Only Object has no superclass; every other class has exactly one direct superclass.])
}

#let shapes() = {
  arrow((-2, -1), (18, -1))
  arrow((-2, -1), (-2, 5))
  label((18.6, -1), [x])
  label((-2, 5.6), [y])
  draw.circle((1, 2), radius: 1.3, fill: palette.surface)
  draw.circle((1, 2), radius: .06, fill: palette.ink)
  arrow((1, 2), (2.3, 2))
  label((1.5, 2.7), [radius])
  label((.6, .1), [(x, y)])
  label((1, 4.5), [*Circle*])
  for (x, w, h, title) in ((6, 4, 2, [Rectangle]), (13, 3, 3, [Square])) {
    draw.rect((x, 0), (x + w, h), fill: palette.surface)
    draw.circle((x, 0), radius: .06, fill: palette.ink)
    label((x + w / 2, -.5), [width])
    label((x + w / 2, 4.5), strong(title))
    label((x - .4, .6), [(x, y)])
    if w != h { label((x + w + 1, 1), [height]) }
  }
}

#let separate-shapes() = {
  for (x, title, fields) in (
    (0, [Circle], [\+ radius: double]),
    (8, [Rectangle], [\+ width, height: double]),
    (16, [Square], [\+ width: double]),
  ) {
    uml(x, 4, title, rows: ([\+ x, y: double], fields), width: 7)
    label((x, .5), [Same position fields])
  }
  label((8, -1.5), [Move x and y into one common superclass.])
}

#let shape-tree(private: false, areas: false) = {
  let sign = if private { [−] } else { [+] }
  uml(7, 6, [Shape], rows: ([#sign x, y: double],), width: 6)
  for (x, title, fields, formula) in (
    (0, [Circle], [#sign radius: double], [π × radius²]),
    (7, [Rectangle], [#sign width, height: double], [width × height]),
    (14, [Square], [#sign width: double], [width²]),
  ) {
    uml(x, 2, title, rows: (fields,), width: 6.5)
    inherits((x, 2), (x, 3.2), (7, 3.2), (7, 4.5))
    if areas {
      node(x, -1.5, formula, width: 6)
      arrow((x, .5), (x, -1))
    }
  }
  if areas { label((7, -3.2), [Same call: getArea() · implementation depends on the object]) }
}

#let encapsulation() = {
  node(0, 2, [Circle constructor], width: 6)
  uml(12, 5, [Shape], rows: ([− x, y: double], [\+ setX(x), setY(y)]), width: 7)
  arrow((3, 2.5), (6, 2.5), (6, 3.8), (8.5, 3.8), color: palette.instance)
  label((5.8, 4.8), [Direct access ×], color: palette.instance)
  arrow((3, 1.5), (7, 1.5), (7, 3.15), (8.5, 3.15))
  label((5.6, .2), [Use accessible methods])
}

#let object-state() = {
  for (y, name) in ((6, [A]), (3, [B]), (0, [C])) { uml(0, y, name, width: 3) }
  inherits((0, 3), (0, 5.15))
  inherits((0, 0), (0, 2.15))
  draw.rect((6, -.9), (15, 6), fill: white)
  label((10.5, 5.3), underline([object: C]))
  for (y, body) in ((3.7, [Fields declared in A]), (2, [Fields declared in B]), (.3, [Fields declared in C])) {
    node(10.5, y, body, width: 8, height: 1.4)
  }
  arrow((1.5, -.4), (4, -.4), (4, 2), (6, 2), dashed: true)
  label((8, -2.5), [One object: all instance fields, including private superclass state.])
  label((8, -3.7), [Methods belong to classes; their code is not copied into each object.])
}

#let construction() = {
  label((-1, 4), [Call super()])
  for (i, title) in ([C()], [B()], [A()], [Object()]).enumerate() {
    let x = 4 + i * 4.5
    node(x, 4, title, width: 3.5)
    if i < 3 { arrow((x + 1.75, 4), (x + 2.75, 4)) }
  }
  label((-1, 0), [Initialize])
  for (i, title) in ([Object], [A], [B], [C]).enumerate() {
    let x = 4 + i * 4.5
    node(x, 0, title, width: 3.5, fill: palette.green.lighten(85%))
    if i < 3 { arrow((x + 1.75, 0), (x + 2.75, 0)) }
  }
  label((9, -2), [First allocate all fields with default values; then run the constructor chain.])
  label((9, -3.2), [At each class: field initializers, then constructor body after super().])
}

#let constructor-rules() = {
  for (y, condition, effect) in (
    (4, [No constructor declared], [Compiler generates a default constructor]),
    (1, [No explicit this(...) or super(...) call], [Compiler inserts super()]),
    (-2, [No accessible superclass no-arg constructor], [Implicit super() fails to compile]),
  ) {
    node(0, y, condition, width: 11)
    node(14, y, effect, width: 12)
    arrow((5.5, y), (8, y))
  }
}

#let references() = {
  uml(12, 4.5, underline([pilot object: Pilot]), width: 9,
    rows: ([Person: name = "Birgit"], [Pilot: airline = "Winglet Airways"]))
  for (y, name) in ((5, [`Pilot pilot`]), (2.5, [`Person personRef`]), (0, [`Object objectRef`])) {
    node(0, y, name, width: 6)
    arrow((3, y), (5.5, y), (5.5, 3.4), (7.5, 3.4))
  }
  label((8, -2), [Three references · one object · runtime type stays Pilot])
}

#let reference-access() = {
  for (y, ref, members) in (
    (4, [`Pilot`], [name · airline · toString()]),
    (1.5, [`Person`], [name · toString()]),
    (-1, [`Object`], [toString()]),
  ) {
    node(0, y, ref, width: 4)
    node(10, y, members, width: 11)
    arrow((2, y), (4.5, y))
  }
  label((6, -3), [Reference type determines available members; access rules still apply.])
}

#let overriding() = {
  for (x, title, result) in (
    (0, [Object], [Class + @ + hex hash]),
    (8, [Person], [name]),
    (16, [Pilot], [name + airline]),
  ) {
    uml(x, 4, title, rows: ([\+ toString(): String],), width: 6.5)
    node(x, 0, result, width: 7.5)
    arrow((x, 2.5), (x, .5))
    if x > 0 {
      draw.line((x - 3.25, 3.5), (x - 4.75, 3.5), stroke: 1pt + palette.relation)
      draw.line((x - 4.75, 3.5), (x - 4.3, 3.75), (x - 4.3, 3.25),
        close: true, fill: white, stroke: 1pt + palette.relation)
    }
  }
  label((8, -2), [Same signature · subclass supplies a new implementation])
}

#let dispatch(super-call: false) = {
  if super-call {
    node(0, 3, [`pilot.toString()`], width: 7)
    node(0, 0, [`super.toString()` in Pilot], width: 7)
    node(11, 3, [Pilot: name + airline], width: 9)
    node(11, 0, [Person: name], width: 9)
    arrow((3.5, 3), (6.5, 3))
    arrow((3.5, 0), (6.5, 0))
    label((5.5, -2), [super selects the superclass implementation on the same object.])
  } else {
    for (y, ref) in ((5, [`pilot.toString()`]), (2.5, [`personRef.toString()`]), (0, [`objectRef.toString()`])) {
      node(0, y, ref, width: 7.5)
      arrow((3.75, y), (5.5, y), (5.5, 2.5), (7, 2.5))
    }
    node(11, 2.5, [*Pilot.toString()*\ Jan Birgerson (Winglet Airways)], width: 8, height: 2)
    label((7, -2), [Runtime object type selects the overridden instance method.])
  }
}

#let final-rules() = {
  for (y, kind, operation, result) in (
    (4, [`final` variable], [Reassign after initialization], [Blocked]),
    (1.5, [`final` method], [Override in subclass], [Blocked]),
    (-1, [`final` class], [Extend (e.g. String)], [Blocked]),
  ) {
    node(0, y, kind, width: 6)
    node(9, y, operation, width: 10)
    arrow((3, y), (4, y))
    label((16, y), result, color: palette.instance)
  }
  label((8, -3), [Final reference: no reassignment. The object may still change.])
}

#let field-hiding() = {
  node(0, 3, [`Person ref = new Pilot();`], width: 10)
  node(13, 3, [`ref.name` → Person field], width: 10)
  node(13, 0, [`ref.toString()` → Pilot method], width: 10)
  arrow((5, 3), (8, 3))
  arrow((5, 3), (6, 3), (6, 0), (8, 0))
  label((7, -2), [Fields are hidden, not overridden. Avoid duplicate field names.])
}

#let cat(answer: false) = {
  let colors = (palette.green.lighten(85%), palette.yellow.lighten(85%), palette.coral.lighten(85%))
  uml(0, 7, [Mammal], rows: ([breathe()], [sleep()], [eat()]), color: colors.at(0))
  uml(0, 3.2, [Carnivore], rows: ([eat()],), color: colors.at(1))
  uml(0, 0, [Cat], rows: ([sleep()], [hunt()], [purr()]), color: colors.at(2))
  inherits((0, 3.2), (0, 4.2))
  inherits((0, 0), (0, 1.7))
  label((11, 7.3), underline([jason: Cat]))
  if answer {
    for (y, method, origin, color) in (
      (5.8, [breathe()], [Mammal], colors.at(0)),
      (4, [eat()], [Carnivore], colors.at(1)),
      (2.2, [sleep()], [Cat], colors.at(2)),
      (.4, [hunt()], [Cat], colors.at(2)),
      (-1.4, [purr()], [Cat], colors.at(2)),
    ) {
      node(9, y, method, width: 4, fill: color)
      node(15, y, origin, width: 4, fill: color)
      arrow((11, y), (13, y))
    }
  } else {
    node(11, 2.5, [Which methods?\ Which defining class?], width: 9, height: 2)
  }
}

#let polymorphism() = {
  label((0, 6), [*Overloading* · compiler selects by arguments])
  uml(0, 4.5, [MathFunctions], width: 10, rows: (
    [max(int, int): int], [max(int, int, int): int],
    [max(double, double): double], [max(double\[\]): double],
  ))
  label((0, -.4), [Same name · different parameter lists])
  label((14, 6), [*Overriding* · runtime selects by object])
  uml(14, 4.5, [Person], width: 7, rows: ([toString(): String],))
  uml(14, .5, [Pilot], width: 7, rows: ([toString(): String],))
  inherits((14, .5), (14, 3))
  label((14, -2.4), [Same signature · inheritance hierarchy])
}

#let identity() = {
  for (y, name) in ((6, [`d`]), (4, [`a`]), (1, [`b`]), (-2, [`c`])) {
    node(0, y, name, width: 2)
  }
  for (y, coords) in ((4, [x = 1, y = 2]), (1, [x = 1, y = 2]), (-2, [x = 7, y = 3])) {
    node(8, y, [*Point*\ #coords], width: 6, height: 1.8)
    arrow((1, y), (5, y))
  }
  arrow((1, 6), (3, 6), (3, 4.4), (5, 4.4))
  label((16, 4), [`a == d` → true])
  label((16, 1), [`a == b` → false])
  label((16, -2), [`a == c` → false])
}

#let equality(answer: false) = {
  label((0, 7), [*References*])
  label((15, 7), [`a == b`])
  label((20, 7), [`a.equals(b)`])
  for (i, second, same, equal) in ((0, [(10, 2)], false, false), (1, [(10, 25)], false, true), (2, [(10, 25)], true, true)) {
    let y = 5 - i * 3.5
    node(0, y, [`a`], width: 1.8)
    node(5, y, [Point (10, 25)], width: 6)
    arrow((.9, y), (2, y))
    node(0, y - 1.4, [`b`], width: 1.8)
    if same {
      arrow((.9, y - 1.4), (1.4, y - 1.4), (1.4, y - .3), (2, y - .3))
    } else {
      node(8, y - 1.4, [Point #second], width: 6)
      arrow((.9, y - 1.4), (5, y - 1.4))
    }
    label((15, y - .5), if answer { repr(same) } else { [?] })
    label((20, y - .5), if answer { repr(equal) } else { [?] })
  }
  label((10, -5), [Assume Point overrides equals() to compare x and y.])
}

#let equals-rule() = {
  node(0, 2, [`Object.equals()`], width: 7)
  node(12, 2, [Same object? · default is identity], width: 12)
  arrow((3.5, 2), (6, 2))
  node(0, -1, [`Point.equals()` override], width: 7)
  node(12, -1, [Same coordinates? · chosen value semantics], width: 12)
  arrow((3.5, -1), (6, -1))
  label((7, -3.2), [Equal objects must have equal hash codes: override hashCode() too.])
}

#let diagrams = (
  roadmap: roadmap, inheritance: inheritance, pilot: pilot,
  pilot-object: pilot.with(object: true),
  visibility: access-grid, members: members, models: models, object-root: object-root,
  shapes: shapes, separate-shapes: separate-shapes,
  shape-tree: shape-tree, shape-private: shape-tree.with(private: true),
  areas: shape-tree.with(private: true, areas: true), encapsulation: encapsulation,
  object-state: object-state, construction: construction,
  constructor-rules: constructor-rules, references: references,
  reference-access: reference-access, overriding: overriding, dispatch: dispatch,
  super-call: dispatch.with(super-call: true), final: final-rules, field-hiding: field-hiding,
  cat: cat, cat-answer: cat.with(answer: true), polymorphism: polymorphism,
  identity: identity, equality: equality, equality-answer: equality.with(answer: true),
  equals-rule: equals-rule,
)

#let diagram(name, height: 260pt) = layout(size => {
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
