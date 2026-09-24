#import "@preview/cetz:0.4.1": canvas, draw
#import "../hestia/theme.typ": palette
#import "../slides_002/diagrams.typ": node, arrow, label, decision

// UML compartments, with neutral visibility where the Java example is package-private.
#let uml(x, y, title, fields, methods: (), width: 6) = {
  let field-height = fields.len() * .65 + .35
  let method-height = if methods.len() > 0 { methods.len() * .65 + .35 } else { 0 }
  let bottom = y - .85 - field-height - method-height
  draw.rect((x - width / 2, bottom), (x + width / 2, y), fill: palette.surface)
  draw.line((x - width / 2, y - .85), (x + width / 2, y - .85))
  label((x, y - .42), strong(title))
  for (i, field) in fields.enumerate() {
    draw.content((x - width / 2 + .25, y - 1.3 - i * .65), field, anchor: "west")
  }
  if methods.len() > 0 {
    draw.line((x - width / 2, y - .85 - field-height), (x + width / 2, y - .85 - field-height))
    for (i, method) in methods.enumerate() {
      draw.content((x - width / 2 + .25, y - 1.3 - field-height - i * .65), method, anchor: "west")
    }
  }
}

#let student(x, y, name, number: 0, year: 0) = uml(x, y, underline[:Student],
  ([name = #name], [matrNumber = #number], [enrolledYear = #year]))

#let roadmap() = {
  for (x, title, detail) in (
    (0, [*Imperative concepts*], [Values · control flow]),
    (6.5, [*Classes and objects*], [State · behavior]),
    (13, [*Class library*], [Reuse existing classes]),
  ) {
    node(x, 1, title, width: 6, fill: if x == 6.5 { palette.green.lighten(80%) } else { palette.surface })
    label((x, -.2), detail)
  }
  arrow((3, 1), (3.5, 1))
  arrow((9.5, 1), (10, 1))
  label((6.5, 2.2), [Today], color: palette.relation)
}

#let members() = {
  uml(3, 5, [Person], ([− firstName: String], [− surname: String]),
    methods: ([\+ getFirstName(): String], [\+ getSurname(): String], [\+ setFirstName(String)], [\+ setSurname(String)]), width: 7)
  node(13, 3.4, [*Attributes* → state], width: 7)
  node(13, .8, [*Methods* → behavior], width: 7)
  arrow((6.5, 3.4), (9.5, 3.4))
  arrow((6.5, .8), (9.5, .8))
  label((8, -1.4), [Attributes + methods = members])
}

#let instances(person: false) = {
  if person {
    uml(2, 3, [Person], ([firstName: String], [surname: String]),
      methods: ([getFirstName(): String], [setFirstName(String)]))
    for (y, name) in ((4, [“Ines”]), (1, [“Max”]), (-2, [“Lena”])) {
      uml(12, y, underline[:Person], ([firstName = #name], [surname = …]))
      arrow((5, .5), (7, .5), (7, y - 1), (9, y - 1))
    }
  } else {
    uml(2, 3, [Student], ([name: String], [matrNumber: int], [enrolledYear: int]))
    student(12, 4, [“Lena”], number: 591753, year: 2016)
    student(12, 0, [“Jan”], number: 591601, year: 2015)
    arrow((5, 1), (7, 1), (7, 2.5), (9, 2.5))
    arrow((7, 1), (7, -1.5), (9, -1.5))
  }
  label((2, 4.5), [One blueprint])
  label((12, 5.3), [Independent object state])
}

#let allocation(stage: 0) = {
  label((1, 4.2), [*Local variables*])
  label((12, 4.2), [*Object memory*])
  for (y, name) in ((2.8, [count: int]), (1, [lena: Student]), (-.8, [jan: Student])) {
    label((-1.5, y), name)
    node(2.5, y, if stage == 2 and y == 1 { [ref] } else { [unassigned] }, width: 3.4)
  }
  if stage > 0 {
    student(12, 2.6, [null])
    if stage == 2 { arrow((4.2, 1), (9, 1)) }
    label((12, -1.7), if stage == 1 { [`new Student()` creates an object] } else { [`lena = …` stores its reference] })
  } else {
    node(12, 1, [No Student objects yet], width: 7)
    label((6, -2.5), [Reading an unassigned local variable is a compile error.])
  }
}

#let access() = {
  node(0, 2, [`lena`], width: 3)
  uml(8, 4, underline[:Student], ([name = “Lena”], [matrNumber = 591753], [enrolledYear = 2012]))
  arrow((1.5, 2), (5, 2))
  label((8, -.4), [`lena.enrolledYear` → 2012])
  label((0, 3.4), [Object reference])
}

#let variable-kinds() = {
  label((7, 5.6), [Two independent questions])
  node(2, 4, [*Where is it declared?*], width: 7)
  node(12, 4, [*What does it store?*], width: 7)
  for (y, left, right) in (
    (2, [In a method → local variable], [Primitive type → value]),
    (0, [Class, non-static → instance field], [Reference type → reference or null]),
  ) {
    node(2, y, left, width: 8.5)
    node(12, y, right, width: 8.5)
    for x in (2, 12) {
      arrow((x, 3.5), (x, 3), (x - 4.8, 3), (x - 4.8, y), (x - 4.25, y))
    }
  }
  label((7, -1.5), [A reference variable can be a local variable or a field.])
}

#let initialization() = {
  node(0, 3, [*Local variable*], width: 5)
  node(8, 3, [Assign before reading], width: 8)
  arrow((2.5, 3), (4, 3))
  node(0, .5, [*Instance field*], width: 5)
  node(8, .5, [Default value at object creation], width: 8)
  arrow((2.5, .5), (4, .5))
  node(8, -1.5, [Field initializer, then constructor body], width: 10)
  arrow((8, 0), (8, -1))
}

#let references(shared: false, changed: false, garbage: false) = {
  node(0, 2, [`lena`], width: 3)
  node(0, -1.5, [`jan`], width: 3)
  student(10, 3.5, if changed { [“Kai”] } else { [“Lena”] }, number: 591753, year: 2016)
  student(10, -.5, [“Jan”], number: 591601, year: 2015)
  arrow((1.5, 2), (7, 2))
  if shared {
    arrow((1.5, -1.5), (4, -1.5), (4, 1.3), (7, 1.3))
    label((0, -3), [`jan = lena;`])
    label((10, -4.5), if garbage { [Unreachable → eligible for collection] } else { [No remaining reference] }, color: palette.instance)
    if garbage {
      draw.rect((6.8, -.3), (13.2, -3.9), stroke: (paint: palette.instance, dash: "dashed"))
    }
  } else { arrow((1.5, -1.5), (7, -1.5)) }
}

#let method-signature() = {
  for (x, part, meaning) in (
    (0, [`ReturnType`], [Primitive, reference,\ or void]),
    (7, [`methodName`], [Valid identifier]),
    (14, [`(Type name, …)`], [Parameters, or empty ()]),
  ) {
    node(x, 2, part, width: 6)
    arrow((x, 1.5), (x, .5))
    label((x, 0), meaning)
  }
}

#let method-call() = {
  node(0, 3, [`math.average(3.5, 7.0)`], width: 7)
  node(10, 3, [`a = 3.5`, `b = 7.0`], width: 7)
  arrow((3.5, 3), (6.5, 3))
  label((5, 4), [Arguments → parameters])
  node(10, 0, [`return (a + b) / 2.0;`], width: 7)
  arrow((10, 2.5), (10, .5))
  node(0, 0, [`mean = 5.25`], width: 7)
  arrow((6.5, 0), (3.5, 0))
  label((5, -1), [Return value])
}

#let accessors() = {
  node(0, 2, [`setName("Lena")`], width: 6)
  uml(8, 3, underline[:Student], ([name = “Lena”],))
  node(16, 2, [`getName()`], width: 5)
  arrow((3, 2), (5, 2))
  arrow((11, 2), (13.5, 2))
  label((0, .4), [Write state])
  label((16, .4), [Read → “Lena”])
}

#let call-by-value() = {
  label((0, 5), [*Caller*])
  label((10, 5), [*square(double a)*])
  node(0, 3.5, [`b = 3.0`], width: 5)
  node(10, 3.5, [`a = 3.0`], width: 5)
  arrow((2.5, 3.5), (7.5, 3.5))
  label((5, 4.3), [Copy value])
  node(10, 1, [`a = a * a;` → 9.0], width: 6)
  arrow((10, 3), (10, 1.5))
  node(0, 1, [`b` is still 3.0], width: 5)
  node(0, -1.5, [`result = 9.0`], width: 5)
  arrow((10, .5), (10, -1.5), (2.5, -1.5))
  label((6, -.8), [`return a;`])
}

#let object-parameter(stage: 0) = {
  label((0, 4.4), [*main()*])
  node(0, 3, [`lena`], width: 3)
  student(11, 4, if stage == 2 { [“Birgit”] } else { [“Lena”] })
  arrow((1.5, 3), (8, 3))
  if stage > 0 {
    label((0, .6), [*setNameBirgit(…)*])
    node(0, -.7, [`student`], width: 3)
    arrow((0, 2.5), (0, -.2), dashed: true)
    label((2.7, 1.4), [Copy reference])
    arrow((1.5, -.7), (5, -.7), (5, 1.7), (8, 1.7))
    label((11, -1.6), if stage == 2 { [`student.name = "Birgit";`] } else { [Two variables, one object] })
  }
}

#let this-reference() = {
  node(0, 3, [`lena.setName("Lena")`], width: 7)
  node(0, 0, [Parameter `name` = “Lena”], width: 7)
  uml(11, 4, underline[:Student], ([this.name = “Lena”],), methods: ([setName(String name)],), width: 7)
  arrow((3.5, 3), (7.5, 3))
  label((5.5, 3.8), [`this`])
  arrow((3.5, 0), (5.5, 0), (5.5, 2.7), (7.5, 2.7))
  label((6, -1.3), [`this.name = name;` copies the parameter into the field.])
}

#let overloads() = {
  for (y, call, signature) in (
    (4, [`max(2, 5)`], [`max(int, int)`]),
    (2, [`max(2.0, 5.0)`], [`max(double, double)`]),
    (0, [`max(2, 5, 3)`], [`max(int, int, int)`]),
  ) {
    node(0, y, call, width: 6)
    node(10, y, signature, width: 8)
    arrow((3, y), (6, y))
  }
  label((5, 5.5), [Compiler selects by argument types and count])
  label((5, -1.5), [Signature = method name + ordered parameter types])
}

#let construction() = {
  for (x, body) in ((0, [Allocate memory\ Set field defaults]),
    (7, [Run initialization\ and constructor]), (14, [Return reference\ Assign to variable])) {
    node(x, 2, body, width: 6, height: 1.8)
  }
  arrow((3, 2), (4, 2))
  arrow((10, 2), (11, 2))
  label((7, 4), [`Student lena = new Student("Lena");`])
}

#let default-constructor() = {
  label((7, 6), [Does the class declare a constructor?])
  decision(7, 4, [Declared?])
  node(1, 0, [Compiler adds\ no-argument constructor], width: 7, height: 1.8)
  node(13, 0, [Only declared\ constructors exist], width: 7, height: 1.8)
  arrow((5.2, 4), (1, 4), (1, .9))
  arrow((8.8, 4), (13, 4), (13, .9))
  label((2.5, 4.6), [No])
  label((11.5, 4.6), [Yes])
}

#let constructor-chain() = {
  for (x, title, action) in (
    (0, [`Aircraft(model, airline)`], [`this.airline = airline;`]),
    (8, [`Aircraft(model)`], [`this.model = model;`]),
    (15, [`Aircraft()`], [`numberEngines = 1;`]),
  ) {
    node(x, 3, title, width: if x == 0 { 7.5 } else { 6 })
    node(x, 0, action, width: if x == 0 { 7.5 } else { 6 })
  }
  arrow((3.75, 3), (5, 3))
  arrow((11, 3), (12, 3))
  arrow((15, 2.5), (15, .5))
  arrow((12, 0), (11, 0))
  arrow((5, 0), (3.75, 0))
  label((7, 4.4), [Delegate first →])
  label((7, -1.4), [← Complete constructor bodies])
}

#let circle-task() = {
  draw.line((-3, -1.5), (4, -1.5), mark: (end: ">"))
  draw.line((-2, -2), (-2, 4.5), mark: (end: ">"))
  draw.circle((.5, 1), radius: 2, fill: palette.surface)
  draw.circle((.5, 1), radius: .06, fill: palette.ink)
  arrow((.5, 1), (2.5, 1))
  label((1.5, 1.6), [radius])
  label((.5, .3), [(x, y)])
  label((4.3, -1.5), [x])
  label((-2, 4.9), [y])
  uml(11, 4.5, [Circle], ([x, y: double], [radius: double]), methods: (
    [Circle() → (0, 0, 1)], [Circle(x, y, radius)], [Circle(radius) → (0, 0, radius)], [Circle(circle) → copy fields],
  ), width: 9)
}

#let circle-memory(kind: "pi") = {
  let shared = kind == "static"
  if shared {
    uml(7, 6, [Circle · class fields], ([static PI = 3.14159…], [static count = 3]), width: 7)
  }
  for (i, values) in (([2.1], [−1.4], [2.0]), ([0.0], [0.5], [1.0]), ([−1.0], [5.0], [1.5])).enumerate() {
    let x = i * 7
    let fields = ([x = #values.at(0)], [y = #values.at(1)], [radius = #values.at(2)])
    if not shared { fields.push(if kind == "pi" { [PI = 3.14159…] } else { [count = 1] }) }
    uml(x, 1.5, underline[:Circle], fields)
    if shared { arrow((x, 1.5), (x, 2.4), (7, 2.4), (7, 3.5), dashed: true) }
  }
  label((7, -3.2), if shared { [One shared copy per class, even without instances] }
    else { [Each object has its own field] })
}

#let static-methods() = {
  node(0, 3, [`Circle.getPi()`], width: 6)
  node(10, 3, [*Class method*\ No receiver, no `this`], width: 8, height: 1.7)
  arrow((3, 3), (6, 3))
  node(0, 0, [`circle.getArea()`], width: 6)
  node(10, 0, [*Instance method*\ `this` refers to `circle`], width: 8, height: 1.7)
  arrow((3, 0), (6, 0))
  label((5, -2), [Static methods need an object reference\ to access instance fields.])
}

#let diagrams = (
  roadmap: roadmap, members: members, person-instances: instances.with(person: true),
  student-class: () => uml(0, 3, [Student], ([name: String], [matrNumber: int], [enrolledYear: int])),
  student-instances: instances, locals: allocation, allocate: allocation.with(stage: 1),
  assign: allocation.with(stage: 2), access: access, variable-kinds: variable-kinds,
  initialization: initialization, references: references, alias: references.with(shared: true),
  mutation: references.with(shared: true, changed: true),
  garbage: references.with(shared: true, changed: true, garbage: true),
  method-signature: method-signature, method-call: method-call,
  accessors: accessors, call-by-value: call-by-value,
  parameter-before: object-parameter, parameter-copy: object-parameter.with(stage: 1),
  parameter-mutate: object-parameter.with(stage: 2), this-reference: this-reference,
  overloads: overloads, construction: construction, default-constructor: default-constructor,
  constructor-chain: constructor-chain, circle-task: circle-task,
  instance-pi: circle-memory, instance-count: circle-memory.with(kind: "count"),
  static-fields: circle-memory.with(kind: "static"), static-methods: static-methods,
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
