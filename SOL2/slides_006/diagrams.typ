#import "@preview/cetz:0.4.1": canvas, draw
#import "../hestia/theme.typ": palette
#import "../slides_002/diagrams.typ": node, arrow, label
#import "../slides_005/diagrams.typ": uml, inherits

// UML realization: dashed line, hollow triangle pointing to the interface.
#let realizes(..points) = {
  let (x, y) = points.pos().last()
  draw.line(..points, stroke: (paint: palette.relation, thickness: 1pt, dash: "dashed"))
  draw.line((x, y), (x - .25, y - .45), (x + .25, y - .45), close: true,
    fill: white, stroke: 1pt + palette.relation)
}

#let roadmap() = {
  for (x, title, detail) in (
    (0, [Inheritance], [Reuse and override]),
    (8, [Interfaces], [Model shared contracts]),
    (16, [Comparable], [Order and sort objects]),
  ) {
    node(x, 2, strong(title), width: 7, fill: if x == 0 { palette.surface } else { palette.green.lighten(85%) })
    label((x, .5), detail)
    if x < 16 { arrow((x + 3.5, 2), (x + 4.5, 2)) }
  }
  label((0, 3.5), [Last lecture])
  label((12, 3.5), [Today])
}

#let shapes(abstract: false, comparable: false) = {
  let title = if abstract { emph([Shape]) } else { [Shape] }
  let area = if abstract { emph([\+ getArea(): double]) } else { [\+ getArea(): double] }
  let rows = ([− x, y: double], area)
  if comparable { rows.push([\+ compareTo(Shape): int]) }
  uml(8, 6, title, rows: rows, width: 7)
  for (x, title, fields, formula) in (
    (0, [Circle], [− radius: double], [π × radius²]),
    (8, [Rectangle], [− width, height: double], [width × height]),
    (16, [Square], [− width: double], [width²]),
  ) {
    uml(x, .5, title, rows: (fields, [\+ getArea(): double]), width: 7)
    inherits((x, .5), (x, 2), (8, 2), (8, 6 - .85 - .65 * rows.len()))
    if abstract {
      label((x, -2.6), formula)
    }
  }
  if comparable {
    uml(8, 9, [«interface» Comparable\<Shape\>], rows: (emph([\+ compareTo(Shape): int]),), width: 11)
    realizes((8, 6), (8, 7.5))
    label((8, -3.8), [Subclasses inherit compareTo(); each supplies its own getArea().])
  } else if abstract {
    label((8, -4), [Italics = abstract · instantiate only the concrete shapes])
  }
}

#let instantiation() = {
  uml(0, 5, emph([A · abstract]), width: 6)
  uml(0, 1, [B · concrete], width: 6)
  inherits((0, 1), (0, 4.15))
  node(9, 4.6, [`new A()` · compile error], width: 10, fill: palette.coral.lighten(90%))
  arrow((3, 4.6), (4, 4.6))
  node(9, .6, [`new B()` · B object], width: 10, fill: palette.green.lighten(85%))
  arrow((3, .6), (4, .6))
  label((6, -1.6), [`A ref = new B();` is valid])
}

#let image-source(tree: false) = {
  uml(8, 7, emph([ImageSource]), rows: (emph([\+ getNextImage(): Image]),), width: 9)
  if tree {
    for (x, title) in ((-2, [Camera]), (8, [Scanner]), (18, emph([VideoSource]))) {
      uml(x, 2.5, title, rows: (if x == 18 { emph([\+ getNextImage(): Image]) } else { [\+ getNextImage(): Image] },), width: 9)
      inherits((x, 2.5), (x, 4), (8, 4), (8, 5.5))
    }
    for (x, title) in ((12.5, [VideoCamera]), (23, [VideoFile])) {
      uml(x, -2, title, rows: ([\+ getNextImage(): Image],), width: 9)
      inherits((x, -2), (x, -.5), (18, -.5), (18, 1))
    }
    label((8, -5), [Still missing an implementation? The subclass must remain abstract.])
  } else {
    uml(8, 2.5, [Camera], rows: ([\+ getNextImage(): Image],), width: 9)
    inherits((8, 2.5), (8, 5.5))
    label((8, -.5), [Declaration above · implementation below])
  }
}

#let dispatch() = {
  node(0, 2, [`ImageSource ref`], width: 7)
  node(11, 2, underline([camera: Camera]), width: 9)
  arrow((3.5, 2), (6.5, 2))
  node(0, -1, [`ref.getNextImage()`], width: 7)
  node(11, -1, [Camera.getNextImage()], width: 9)
  arrow((3.5, -1), (6.5, -1))
  label((6, -3), [Abstract reference type · concrete implementation runs])
}

#let type-kinds() = {
  for (x, title, rows) in (
    (0, [Concrete class], ([Instance + static fields], [Implemented methods], [Constructors], [Can instantiate])),
    (10, emph([Abstract class]), ([Instance + static fields], [Implemented + abstract methods], [Constructors], [Cannot instantiate])),
    (20, [«interface» Interface], ([Constants; no instance fields], [Abstract + default/static methods], [No constructors], [Cannot instantiate])),
  ) {
    uml(x, 5, title, rows: rows, width: 9.5)
  }
  label((10, .4), [A concrete class must implement all inherited abstract methods.])
}

#let interface-members() = {
  for (y, kind, rule) in (
    (6, [Method with no body], [Implicitly public abstract]),
    (3.5, [Field], [Implicitly public static final]),
    (1, [default method · Java 8+], [Inherited instance implementation]),
    (-1.5, [static method · Java 8+], [Called on the interface; not inherited]),
  ) {
    node(0, y, kind, width: 10)
    node(14, y, rule, width: 13)
    arrow((5, y), (7.5, y))
  }
  label((7, -3.6), [Java 9+ also permits private helper methods.])
}

#let scalable(abstract: false) = {
  uml(8, 7, [«interface» Scalable], rows: (emph([\+ resize(double): void]),), width: 9)
  uml(8, 2.5, if abstract { emph([Vector]) } else { [Vector2D] },
    rows: if abstract { (emph([\+ resize(double): void]),) } else { ([− x, y: double], [\+ resize(double): void]) }, width: 9)
  realizes((8, 2.5), (8, 5.5))
  if abstract {
    for (x, title, fields) in ((2.5, [Vector2D], [− x, y: double]), (13.5, [Vector3D], [− x, y, z: double])) {
      uml(x, -2, title, rows: (fields, [\+ resize(double): void]), width: 9)
      inherits((x, -2), (x, -.5), (8, -.5), (8, 1))
    }
    label((8, -5.8), [Concrete subclasses implement resize().])
  } else {
    label((8, -1.5), [Dashed triangle = implements])
  }
}

#let multiple(extended: false, gray: false) = {
  let parents = if gray { ([Scalable], [Drawable], [Rotateable]) } else { ([Interface1], [Interface2]) }
  let middle = (parents.len() - 1) * 5.5
  for (i, title) in parents.enumerate() {
    let x = i * 11
    let rows = if gray { ((emph([\+ resize(double): void]),), (emph([\+ draw(): void]),), (emph([\+ rotateLeft(): void]),)).at(i) } else { () }
    uml(x, 7, [«interface» #title], rows: rows, width: 10)
    let end = 7 - .85 - .65 * rows.len()
    if extended {
      inherits((middle, 2), (middle, 4), (x, 4), (x, end))
    } else {
      realizes((middle, 2), (middle, 4), (x, 4), (x, end))
    }
  }
  uml(middle, 2, if gray { [GrayImage] } else if extended { [«interface» Interface3] } else { [ClassA] },
    width: 10, rows: if gray { ([\+ resize(double): void], [\+ draw(): void], [\+ rotateLeft(): void]) } else { () })
  if extended {
    uml(middle, -2, [ClassA], width: 10)
    realizes((middle, -2), (middle, 1.15))
    label((middle, -4.2), [Interfaces extend interfaces · classes implement interfaces])
  } else if not gray {
    label((middle, -.5), [One superclass · any number of interfaces])
  }
}

#let references() = {
  node(0, 5, [`Vector2D classRef`], width: 8)
  node(0, 0, [`Scalable interRef`], width: 8)
  uml(14, 4, underline([object: Vector2D]), width: 9,
    rows: ([− x = 1, y = 3], [\+ resize(double): void], [\+ getX(), getY(): double]))
  arrow((4, 5), (7, 5), (7, 2.5), (9.5, 2.5))
  arrow((4, 0), (7, 0), (7, 2.5), (9.5, 2.5))
  label((0, 3.5), [resize() · getX() · getY()])
  label((0, -1.5), [resize() only])
  label((8, -3.5), [One object · the reference type determines available methods])
}

#let transformable() = {
  uml(8, 7, [«interface» Transformable], width: 12,
    rows: (emph([\+ move(double dx, double dy): void]), emph([\+ rotateLeft(): void]),
      emph([\+ rotateRight(): void]), emph([\+ resize(double factor): void])))
  uml(8, 2, emph([Shape]), width: 7)
  realizes((8, 2), (8, 3.55))
  for (x, title) in ((0, [Circle]), (8, [Rectangle]), (16, [Square])) {
    uml(x, -.5, title, width: 7)
    inherits((x, -.5), (x, .3), (8, .3), (8, 1.15))
  }
}

#let comparable(vector: false) = {
  let name = if vector { [Vector2D] } else { [A] }
  uml(0, 6, [«interface» Comparable<#name>], width: 12,
    rows: (emph([\+ compareTo(#name): int]),))
  uml(0, 1.5, name, width: 12, rows: ([\+ compareTo(#name): int],))
  realizes((0, 1.5), (0, 4.5))
  label((0, -1.5), [Replace the type parameter with your class.])
}

#let comparison() = {
  label((8, 5), [`this.compareTo(other)` returns an int])
  draw.line((0, 1), (16, 1), stroke: 1pt + palette.relation)
  for (x, sign, meaning) in ((0, [< 0], [this comes before other]), (8, [0], [Same position in the ordering]), (16, [> 0], [this comes after other])) {
    draw.circle((x, 1), radius: .12, fill: palette.relation)
    node(x, 3, sign, width: 3)
    label((x, -.5), meaning)
  }
  label((8, -2.5), [Only the sign matters · zero does not mean object identity])
}

#let sorting(shapes: false) = {
  let before = if shapes { [Circle: 4π · Circle: π · Rectangle: 50 · Square: 0.25] } else { [5 · 1 · √113 · 0] }
  let after = if shapes { [Square: 0.25 · Circle: π · Circle: 4π · Rectangle: 50] } else { [0 · 1 · 5 · √113] }
  node(8, 6, before, width: 21, height: 1.4)
  node(8, 2.5, [`Collections.sort()`], width: 9)
  arrow((8, 5.3), (8, 3))
  node(8, -1, after, width: 21, height: 1.4, fill: palette.green.lighten(85%))
  arrow((8, 2), (8, -.3))
  label((17, 2.5), [compareTo()
    #linebreak()by #if shapes { [area] } else { [magnitude] }])
  label((8, -3), [Ascending natural order · the list is changed in place])
}

#let diagrams = (
  roadmap: roadmap, shapes-before: shapes, shapes: shapes.with(abstract: true),
  instantiation: instantiation, image-source: image-source,
  image-tree: image-source.with(tree: true), dispatch: dispatch,
  type-kinds: type-kinds, interface-members: interface-members,
  scalable: scalable, abstract-vector: scalable.with(abstract: true),
  multiple: multiple, gray-image: multiple.with(gray: true),
  interface-inheritance: multiple.with(extended: true), references: references,
  transformable: transformable, comparable: comparable,
  comparable-vector: comparable.with(vector: true), comparison: comparison,
  sorting: sorting, comparable-shapes: shapes.with(abstract: true, comparable: true),
  sorting-shapes: sorting.with(shapes: true),
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
