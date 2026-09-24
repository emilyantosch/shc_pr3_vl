#import "@preview/cetz:0.4.1": canvas, draw
#import "../hestia/theme.typ": palette

#let node(x, y, label, fill: palette.blue.lighten(75%), width: 3, height: 1) = {
  draw.rect((x - width / 2, y - height / 2), (x + width / 2, y + height / 2),
    fill: fill, radius: .08)
  draw.content((x, y), align(center, text(15pt, label)))
}
#let arrow(..points, color: palette.ink, dashed: false) = draw.line(..points,
  stroke: (paint: color, thickness: 1pt, dash: if dashed { "dashed" } else { "solid" }),
  mark: (end: ">"))
#let label(at, body, color: palette.ink) = draw.content(at, text(fill: color, body))

#let car() = {
  label((3.7, 3.9), [*A car*])
  draw.line((0, 1), (0, 1.9), (1.2, 2.15), (2.2, 3.15),
    (4.7, 3.15), (5.8, 2.15), (7.2, 1.9), (7.4, 1),
    close: true, fill: palette.green.lighten(65%))
  draw.line((1.7, 2.15), (2.4, 2.9), (3.35, 2.9), (3.35, 2.15),
    close: true, fill: palette.paper)
  draw.line((3.65, 2.15), (3.65, 2.9), (4.55, 2.9), (5.4, 2.15),
    close: true, fill: palette.paper)
  draw.line((3.5, 2), (3.5, 1.1))
  draw.line((3.85, 1.85), (4.3, 1.85))
  draw.rect((6.85, 1.55), (7.2, 1.8), fill: palette.yellow.lighten(65%))
  for x in (1.5, 5.9) {
    draw.circle((x, 1), radius: .65, fill: palette.ink)
    draw.circle((x, 1), radius: .3, fill: palette.paper)
  }
  draw.line((7.4, 1.85), (8.8, 1.85), stroke: palette.relation)
  draw.line((8.8, .4), (8.8, 3.3), stroke: palette.relation)
  for (y, property) in ((3.3, [Manufacturer]), (1.85, [Color]), (.4, [Fuel consumption])) {
    draw.line((8.8, y), (9.5, y), stroke: palette.relation)
    draw.content((9.8, y), anchor: "west", text(15pt, property))
  }
}

#let class-objects() = {
  node(8, 4, [*Person Class*], fill: palette.green.lighten(65%), width: 4)
  node(3, 1, [*Ines*])
  node(13, 1, [*Max*])
  arrow((8, 3.5), (8, 2.7), (3, 2.7), (3, 1.5))
  arrow((8, 3.5), (8, 2.7), (13, 2.7), (13, 1.5))
  draw.line((4.5, 1), (11.5, 1), stroke: palette.relation, mark: (start: ">", end: ">"))
  label((8, -.05), [Same class, different object], color: palette.relation)
  arrow((1.5, 1), (.5, 1), (.5, 4), (6, 4), color: palette.instance)
  label((3, 4.6), [Object of the class], color: palette.instance)
}

#let attributes-methods() = {
  import draw: rect, line, content
  rect((0, 0), (8, 5.6), fill: white)
  rect((0, 4.7), (8, 5.6), fill: palette.green.lighten(65%))
  line((0, 3), (8, 3))
  label((4, 5.15), [*Person*])
  content((.25, 3.85), anchor: "west", text(font: "JetBrainsMono NFM", size: 15pt)[
    -firstName: String\
    -surname: String
  ])
  content((.25, 1.5), anchor: "west", text(font: "JetBrainsMono NFM", size: 15pt)[
    \+ getFirstName(): String\
    \+ getSurname(): String\
    \+ setFirstName(String)\
    \+ setSurname(String)
  ])
  line((7.2, 3.7), (9, 4.2), (10, 4.2), stroke: palette.relation)
  content((10.2, 4.2), anchor: "west", [Attributes])
  line((7.2, 1.5), (9, 2.1), (10, 2.1), stroke: palette.relation)
  content((10.2, 2.1), anchor: "west", [Methods])
}

#let encapsulation() = {
  draw.rect((4, 0), (13, 5.5), fill: palette.yellow.lighten(75%), radius: .3)
  label((8.5, 5.05), [*Person object*])
  draw.rect((5.6, 1.5), (11.4, 3.8), fill: white, radius: .15)
  label((8.5, 3.4), [Private attributes])
  node(7.15, 2.8, [firstName], fill: palette.green.lighten(65%), width: 2.6, height: .6)
  node(9.85, 2.8, [Franziska], width: 2.6, height: .6)
  node(7.15, 2.1, [surname], fill: palette.green.lighten(65%), width: 2.6, height: .6)
  node(9.85, 2.1, [Meyer], width: 2.6, height: .6)
  node(6.3, 4.25, [getFirstName()], fill: white, width: 3.6, height: .65)
  node(10.7, 4.25, [setFirstName()], fill: white, width: 3.6, height: .65)
  node(6.3, .75, [getSurname()], fill: white, width: 3.6, height: .65)
  node(10.7, .75, [setSurname()], fill: white, width: 3.6, height: .65)
  label((1.6, 2), [Retrieve\ surname])
  arrow((1.6, 1.4), (1.6, .75), (4.5, .75))
  label((15.4, 2.6), [Change\ first name])
  arrow((15.4, 3.3), (15.4, 4.25), (12.5, 4.25))
}

#let inheritance() = {
  node(7, 2.7, [*Animal Class*], fill: palette.green.lighten(65%), width: 4)
  for (x, name) in ((2, [*Dog Class*]), (7, [*Cat Class*]), (12, [*Cow Class*])) {
    node(x, 0, name, fill: palette.sandstone.lighten(50%))
    arrow((7, 2.2), (x, .5))
  }
}

#let composition() = {
  draw.circle((0, 2), radius: (6, 2.7), fill: palette.blue.lighten(85%))
  draw.circle((0, 1.35), radius: (4, 2.05), fill: palette.green.lighten(75%))
  draw.circle((0, .65), radius: (2.2, 1.35), fill: palette.yellow.lighten(65%))
  label((0, 4), [Association])
  label((0, 2.75), [Aggregation])
  label((0, .65), [Composition])
}

#let references() = {
  node(2.5, 5, [*Entry point*\ main()], fill: palette.coral.lighten(75%), width: 4, height: 1.4)
  node(13, 5, [*Object A*], width: 4, height: 1.4)
  node(5.5, 1, [*Object B*], width: 4, height: 1.4)
  node(13, 1, [*Object C*], width: 4, height: 1.4)
  arrow((4.5, 5), (11, 5))
  label((7.7, 5.5), [Reference])
  arrow((11, 4.6), (6.5, 1.7))
  label((7.2, 3.8), [Reference])
  arrow((13, 4.3), (13, 1.7))
  label((14.6, 3), [Reference])
  arrow((7.5, 1), (11, 1))
  label((9.2, 1.5), [Reference])
  label((8, -.3), [Objects created during execution])
}

#let java-origins() = {
  node(0, 1, [*C*], width: 1.5, fill: palette.sandstone.lighten(50%))
  node(4, 1, [*C++*], width: 2)
  node(9, 1, [*Java*], width: 2.5, fill: palette.green.lighten(65%))
  node(15, 1, [*Smalltalk*], width: 3.5)
  arrow((.75, 1), (3, 1))
  arrow((5, 1), (7.75, 1))
  label((6.4, .3), [Syntax], color: palette.instance)
  arrow((13.25, 1), (10.25, 1))
  label((11.75, .3), [Semantics], color: palette.instance)
}

#let jvm() = {
  node(1.5, 4.5, [Source code\ (\*.java)], fill: palette.coral.lighten(75%), height: 1.4)
  node(1.5, 2.25, [Compiler\ (javac)], height: 1.4)
  node(1.5, 0, [Bytecode\ (\*.class)], fill: palette.coral.lighten(75%), height: 1.4)
  arrow((1.5, 3.8), (1.5, 2.95))
  arrow((1.5, 1.55), (1.5, .7))
  label((7.5, 6), [Share identical bytecode], color: palette.relation)
  for (x, arch) in ((7, [Arch A]), (11.5, [Arch B]), (16, [Arch C])) {
    node(x, 4.5, [Bytecode\ (\*.class)], fill: palette.coral.lighten(75%), height: 1.4)
    node(x, 2.25, [JVM], height: 1.4)
    node(x, 0, arch, fill: palette.yellow.lighten(65%), height: 1.4)
    arrow((3, 0), (4.5, 0), (4.5, 5.5), (x, 5.5), (x, 5.2), dashed: true, color: palette.relation)
    arrow((x, 3.8), (x, 2.95))
    arrow((x, 1.55), (x, .7))
  }
}

#let interpreted() = {
  node(0, 2, [Source code], fill: palette.coral.lighten(75%))
  for (y, arch) in ((4, [Arch A]), (0, [Arch B])) {
    node(5, y, [Source code], fill: palette.coral.lighten(75%))
    node(10, y, [Interpreter])
    node(15, y, arch, fill: palette.yellow.lighten(65%))
    arrow((1.5, 2), (2.5, 2), (2.5, y), (3.5, y), dashed: true)
    arrow((6.5, y), (8.5, y))
    arrow((11.5, y), (13.5, y))
  }
  label((5, 5.1), [Share source], color: palette.relation)
}

#let compiled() = {
  node(0, 2, [Source code], fill: palette.coral.lighten(75%))
  for (y, arch) in ((4, "A"), (0, "B")) {
    node(4.5, y, [Compiler\ for #arch], height: 1.4)
    node(9, y, [Program #arch], fill: palette.green.lighten(65%))
    node(13.5, y, [Program #arch], fill: palette.green.lighten(65%))
    node(18, y, [Arch #arch], fill: palette.yellow.lighten(65%))
    arrow((1.5, 2), (2.25, 2), (2.25, y), (3, y))
    arrow((6, y), (7.5, y))
    arrow((10.5, y), (12, y), dashed: true)
    arrow((15, y), (16.5, y))
  }
  label((4.5, 5.3), [Compile per target])
  label((11.25, 5.3), [Share binary], color: palette.relation)
}

#let toolchain() = {
  draw.rect((0, 0), (14, 6), fill: palette.coral.lighten(85%), radius: .2)
  label((7, 5.4), [*JDK — Java Development Kit*])
  node(7, 4.4, [Developer tools (compiler, debugger, …)], fill: white, width: 12)
  draw.rect((1, .5), (13, 3.55), fill: palette.green.lighten(75%), radius: .2)
  label((7, 3), [*JRE — Java Runtime Environment*])
  node(7, 2.1, [Class libraries], fill: white, width: 10, height: .8)
  node(7, 1.1, [Java Virtual Machine], fill: palette.yellow.lighten(65%), width: 10, height: .8)
}

#let diagrams = (
  "car": car,
  "class-objects": class-objects,
  "attributes-methods": attributes-methods,
  "encapsulation": encapsulation,
  "inheritance": inheritance,
  "composition": composition,
  "references": references,
  "java-origins": java-origins,
  "jvm": jvm,
  "interpreted": interpreted,
  "compiled": compiled,
  "toolchain": toolchain,
)

// Coordinates are in cm. Keep labels and geometry together when fitting a slide.
#let diagram(name) = layout(size => {
  set text(size: 14pt, fill: palette.ink)
  set par(leading: .5em)
  let body = canvas({
    draw.set-style(stroke: .8pt + palette.muted)
    diagrams.at(name)()
  })
  context {
    let natural = measure(body)
    // Match the theme's short-caption budget without changing the shared theme.
    let factor = calc.min(size.width / natural.width, (size.height - 40pt) / natural.height)
    assert(factor > 0, message: "No room for diagram: " + name)
    scale(x: factor * 100%, y: factor * 100%, reflow: true, body)
  }
})
