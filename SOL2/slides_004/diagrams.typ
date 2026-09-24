#import "@preview/cetz:0.4.1": canvas, draw
#import "../hestia/theme.typ": palette
#import "../slides_002/diagrams.typ": node, arrow, label

// x is the left edge. Indices belong to the array, not to its reference variable.
#let cells(x, y, values, indices: true, width: 1.5) = {
  for (i, value) in values.enumerate() {
    node(x + (i + .5) * width, y, value, width: width)
    if indices { label((x + (i + .5) * width, y - .9), text(14pt, str(i))) }
  }
}

#let array-object(x, y, values, title: [int\[\]]) = {
  draw.rect((x - .2, y - 1.25), (x + values.len() * 1.5 + .2, y + 1.4), radius: .15)
  label((x + values.len() * .75, y + .95), title)
  cells(x, y, values)
}

#let string-object(x, y, value) = node(x, y, [*String*\ #value], width: 5, height: 1.8)

#let roadmap() = {
  for (x, title, detail) in (
    (0, [*Classes and objects*], [Build your own types]),
    (7, [*Class libraries*], [Reuse existing types]),
    (14, [*Inheritance*], [Extend existing types]),
  ) {
    node(x, 1, title, width: 6, fill: if x == 7 { palette.green.lighten(80%) } else { palette.surface })
    label((x, -.3), detail)
  }
  arrow((3, 1), (4, 1))
  arrow((10, 1), (11, 1))
  label((7, 2.3), [Today], color: palette.relation)
}

#let c-java(strings: true) = {
  label((0, 4), [*C*])
  node(0, 2.6, if strings { [`char *name`] } else { [`int *values`] }, width: 4)
  arrow((2, 2.6), (5, 2.6))
  cells(5, 2.6, if strings { ([L], [e], [n], [a], [`\0`]) } else { ([1], [2], [8], [7]) }, indices: false)
  label((9, 4), if strings { [Characters end at `\0`] } else { [Pointer to first element] })
  label((9, 1.3), [Program manages storage and bounds])
  label((0, -1), [*Java*])
  node(0, -2.5, if strings { [`String name`] } else { [`int[] values`] }, width: 4)
  arrow((2, -2.5), (5, -2.5))
  if strings {
    string-object(7.5, -2.5, [“Lena”])
    label((12, -2.5), [`length()`\ `charAt(i)`])
  } else {
    array-object(5, -2.5, ([1], [2], [8], [7]))
    label((13, -2.5), [`length = 4`])
  }
  label((9, -4.5), [Reference to object · runtime manages memory])
}

#let strings(changed: false) = {
  node(0, 2, [`lena1`], width: 3)
  node(0, -1, [`lena2`], width: 3)
  string-object(10, 2, [“Lena”])
  arrow((1.5, 2), (7.5, 2))
  if changed {
    string-object(10, -1, [“Lena B.”])
    arrow((1.5, -1), (7.5, -1))
    label((5, -3), [New object; the original String is unchanged])
  } else {
    arrow((1.5, -1), (5, -1), (5, 1.6), (7.5, 1.6))
    label((5, -3), [Two references, one immutable object])
  }
}

#let immutable() = {
  node(0, 2, [*String*\ “Lena”], width: 4, height: 1.7)
  node(7, 2, [`+ " B."`], width: 4)
  node(14, 2, [*New String*\ “Lena B.”], width: 5, height: 1.7)
  arrow((2, 2), (5, 2))
  arrow((9, 2), (11.5, 2))
  label((0, .4), [Unchanged])
  node(7, -2, [StringBuilder: build text in several steps], width: 13)
}

#let concatenation() = {
  for (y, first, second, result) in (
    (3, [`"Year: " + 20`], [`"Year: 20" + 22`], [“Year: 2022”]),
    (0, [`20 + 22`], [`42 + " (Year)"`], [“42 (Year)”]),
  ) {
    node(0, y, first, width: 5.5)
    node(7, y, second, width: 6)
    node(14, y, result, width: 5)
    arrow((2.75, y), (4, y))
    arrow((10, y), (11.5, y))
  }
  label((7, 4.5), [Evaluate + from left to right])
  label((7, -1.5), [If either operand is a String, + concatenates])
}

#let to-string() = {
  node(0, 2, [`"Name: " + lena`], width: 6)
  node(8, 2, [`lena.toString()`], width: 6)
  node(16, 2, [“Lena Jensen”], width: 7)
  arrow((3, 2), (5, 2))
  arrow((11, 2), (12.5, 2))
  label((8, .4), [public String toString()])
  label((8, -1), [Concatenation result: “Name: Lena Jensen”])
}

#let string-methods() = {
  node(7, 5, [*String* “Hamburg”], width: 6)
  for (x, y, title, methods) in (
    (0, 2.5, [Inspect], [`length()` · `charAt(0)`]),
    (14, 2.5, [Find], [`indexOf("burg")` · `contains("Ham")`]),
    (0, 0, [Transform], [`replace(…)` · `toLowerCase()`]),
    (14, 0, [Compare], [`equals(…)` · `equalsIgnoreCase(…)`]),
    (7, -2.5, [Split], [`split(",")` → String\[\]]),
  ) {
    node(x, y, [*#title*\ #methods], width: 11, height: 1.7)
    if x == 7 {
      arrow((7, 0), (7, y + .85))
    } else {
      arrow((7, 4.5), (7, y), (if x == 0 { 5.5 } else { 8.5 }, y))
    }
  }
}

#let formatting() = {
  node(0, 3, [Format + arguments\ `"%s %d: %.1f km/h"`], width: 9, height: 1.8)
  node(12, 3, [`String.format(…)`], width: 7)
  arrow((4.5, 3), (8.5, 3))
  node(12, 0, [“Station 7: 21.5 km/h”], width: 9)
  arrow((12, 2.5), (12, .5))
  node(0, 0, [`System.out.println(…)`], width: 9)
  arrow((7.5, 0), (4.5, 0))
  label((6, -1.6), [Formatting returns text; println prints it])
}

#let format-parts() = {
  for (x, token, meaning) in (
    (0, [`%`], [Start]), (3, [`2$`], [Argument\ 2]), (6, [`0`], [Zero\ padding]),
    (9, [`8`], [Minimum\ width]), (12, [`.2`], [Precision]), (15, [`f`], [Decimal\ float]),
  ) {
    node(x, 2, token, width: 2.6)
    arrow((x, 1.5), (x, .5))
    label((x, 0), align(center, meaning))
  }
  label((7.5, 4), [`%[argument_index$][flags][width][.precision]conversion`])
  label((7.5, -1.5), [Only % and the conversion are required])
}

#let format-width() = {
  for (y, spec, chars) in (
    (4, [`%2.2f`], ([2], [1], [.], [4], [5])),
    (2, [`%8.2f`], ([␣], [␣], [␣], [2], [1], [.], [4], [5])),
    (0, [`%08.2f`], ([0], [0], [0], [2], [1], [.], [4], [5])),
  ) {
    label((0, y), spec)
    cells(3, y, chars, indices: false, width: 1)
  }
  label((6, 5.5), [21.4532 formatted with Locale.US])
  label((6, -1.5), [Width includes the decimal separator; it never truncates digits])
  label((6, -2.6), [␣ = one space])
}

#let locales() = {
  node(0, 2, [21.4532\ `"%.2f"`], width: 4, height: 1.8)
  for (y, locale, result) in ((3.5, [`Locale.US`], [“21.45”]), (.5, [`Locale.GERMAN`], [“21,45”])) {
    node(7, y, locale, width: 6)
    node(14, y, result, width: 4)
    arrow((2, 2), (3, 2), (3, y), (4, y))
    arrow((10, y), (12, y))
  }
  label((7, -1.5), [Without an explicit locale, format uses the default formatting locale])
}

#let array-creation() = {
  for (x, code, meaning) in (
    (0, [`int[] filter;`], [Declare a reference\ No array yet]),
    (8, [`new int[3]`], [Create an array\ Three zeros]),
    (16, [`filter = …;`], [Store the reference\ Length fixed at 3]),
  ) {
    node(x, 2, code, width: 6.5)
    label((x, 0), meaning)
  }
  arrow((3.25, 2), (4.75, 2))
  arrow((11.25, 2), (12.75, 2))
}

#let filter(values: ([0], [0], [0]), bounds: false) = {
  node(0, 1, [`filter`], width: 3)
  arrow((1.5, 1), (5.8, 1))
  array-object(6, 1, values)
  label((8.25, 3.1), [`length = 3`])
  if bounds {
    label((4.5, -.9), [−1 ✗], color: palette.instance)
    label((12, -.9), [3 ✗], color: palette.instance)
    label((6, -2.4), [Valid indices: 0 ≤ index < length])
    label((6, -3.5), [Otherwise: ArrayIndexOutOfBoundsException], color: palette.instance)
  }
}

#let friends() = {
  node(0, 4, [`friends`], width: 3)
  arrow((1.5, 4), (5.8, 4))
  array-object(6, 4, ([ref], [ref], [ref]), title: [Person\[\]])
  for (i, name) in ([“Lena”], [“Birgit”], [“Jan”]).enumerate() {
    let x = i * 6
    node(x, 0, [*Person*\ firstName = #name], width: 5.5, height: 1.8)
    arrow((7.3 + i * 1.5, 3.5), (7.3 + i * 1.5, 2 - i * .3), (x, 2 - i * .3), (x, .9))
  }
  label((6, -2), [Array elements store references, not the Person objects])
}

#let array-alias(separate: false) = {
  node(0, 2, [`a`], width: 3)
  node(0, -2, [`b`], width: 3)
  array-object(6, 2, if separate { ([1], [2], [3], [4], [5]) } else { ([1], [2], [3], [0], [5]) })
  arrow((1.5, 2), (5.8, 2))
  if separate {
    array-object(6, -2, ([1], [2], [3], [4], [5]))
    arrow((1.5, -2), (5.8, -2))
    label((7, -4.2), [`a == b` → false: equal contents, different objects])
  } else {
    arrow((1.5, -2), (4, -2), (4, 1.6), (5.8, 1.6))
    label((7, -4.2), [`b[3] = 0` changes the array seen through both references])
  }
}

#let matrix(rows: (([1], [2], [3]), ([4], [5], [6]), ([7], [8], [9])), name: [filter], alias: false) = {
  node(0, .5, name, width: 3)
  arrow((1.5, .5), (4.3, .5))
  draw.rect((4.3, -3.75), (6.2, 4.2), radius: .15)
  label((5.25, 5), [int\[\]\[\]])
  label((12, 5), [int\[\] rows])
  for (i, row) in rows.enumerate() {
    let y = 3.5 - i * 3
    node(5.25, y, [ref], width: 1.5)
    label((5.25, y - .9), text(14pt, str(i)))
    draw.rect((9.8, y - 1.25), (10.2 + row.len() * 1.5, y + .7), radius: .15)
    cells(10, y, row)
    arrow((6, y), (9.8, y))
  }
  if alias {
    node(0, 5.5, [`b`], width: 3)
    arrow((1.5, 5.5), (2.3, 5.5), (2.3, 6.5), (8, 6.5), (8, 3.8), (9.8, 3.8))
    node(17, 3.5, [`c = 2`], width: 3.5)
    label((17, 2.1), [Copied value])
    label((9, -5), [`b[1] = 7` changes a[0][1]; c stays 2])
  } else {
    label((9, -5), [Each outer element refers to a row array])
  }
}

#let list-growth() = {
  label((0, 4.5), [*Array*])
  node(0, 3, [`String[2]`], width: 4)
  node(9, 3, [“Lena” | “Birgit”], width: 8)
  arrow((2, 3), (5, 3))
  label((9, 1.7), [`length` stays 2])
  label((0, -.2), [*ArrayList*])
  node(0, -1.7, [`names.add("Jan")`], width: 6)
  node(10, -1.7, [“Lena” | “Birgit” | “Jan”], width: 10)
  arrow((3, -1.7), (5, -1.7))
  label((10, -3), [`size()` grows from 2 to 3])
}

#let list-methods() = {
  node(7, 5, [names: “Lena” | “Birgit” | “Jan”], width: 13)
  for (x, y, code, result) in (
    (0, 2, [`size()`], [3]), (14, 2, [`get(1)`], [“Birgit”]),
    (0, -1, [`contains("Birgit")`], [true]),
    (14, -1, [`remove("Birgit")`], [“Lena” | “Jan”\ size() = 2]),
  ) {
    node(x, y, [#code\ #result], width: 10, height: 1.9)
    arrow((7, 4.5), (7, y), (if x == 0 { 5 } else { 9 }, y))
  }
}

#let foreach() = {
  for (i, value) in ([7], [1], [3], [8]).enumerate() {
    let x = i * 4.5
    node(x, 3, value, width: 3)
    label((x, 4.2), [Pass #(i + 1)])
    node(x, 0, [element = #value], width: 4)
    arrow((x, 2.5), (x, .5))
    if i < 3 { arrow((x + 1.5, 3), (x + 3, 3)) }
  }
  label((6.75, -1.7), [Visit each element in order; no index variable needed])
}

#let conversions() = {
  node(0, 2, [*int*\ 7], width: 4, height: 1.8)
  node(12, 2, [*String*\ “7”], width: 4, height: 1.8)
  arrow((2, 2.5), (10, 2.5))
  label((6, 3.5), [`Integer.toString(7)`])
  arrow((10, 1.5), (2, 1.5))
  label((6, .4), [`Integer.parseInt("7")`])
  label((6, -1.5), [Invalid integer text → NumberFormatException], color: palette.instance)
}

#let boxing() = {
  node(0, 2, [*int*\ 24], width: 4, height: 1.8)
  node(13, 2, [*Integer*\ value = 24], width: 5, height: 1.8)
  arrow((2, 2.5), (10.5, 2.5))
  label((6.25, 4), [Boxing: `Integer.valueOf(24)`])
  arrow((10.5, 1.5), (2, 1.5))
  label((6.25, 0), [Unboxing: `object.intValue()`])
  label((6.25, -2), [Automatic: `Integer object = 24;` → `int value = object;`])
  label((6.25, -3.2), [Unboxing null throws NullPointerException], color: palette.instance)
}

#let math-methods() = {
  node(7, 5, [*Math* · static members], width: 9)
  for (x, y, title, methods) in (
    (0, 2, [Angles], [`toRadians` · `sin` · `cos`]),
    (14, 2, [Scale], [`pow` · `sqrt` · `exp` · `log`]),
    (0, -1, [Compare / round], [`min` · `max` · `abs` · `round`]),
    (14, -1, [Constants / random], [`PI` · `E` · `random()`]),
  ) {
    node(x, y, [*#title*\ #methods], width: 11, height: 1.9)
    arrow((7, 4.5), (7, y), (if x == 0 { 5.5 } else { 8.5 }, y))
  }
}

#let diagrams = (
  roadmap: roadmap, strings-c-java: c-java, immutable: immutable,
  strings-shared: strings, strings-changed: strings.with(changed: true),
  concatenation: concatenation, to-string: to-string, string-methods: string-methods,
  formatting: formatting, format-parts: format-parts, format-width: format-width, locales: locales,
  arrays-c-java: c-java.with(strings: false), array-creation: array-creation,
  array-empty: filter, array-filled: filter.with(values: ([1], [2], [1])),
  array-question: filter.with(values: ([?], [?], [?])),
  array-bounds: filter.with(values: ([−1], [0], [4]), bounds: true), friends: friends,
  array-alias: array-alias, arrays-separate: array-alias.with(separate: true),
  matrix: matrix,
  matrix-zero: matrix.with(rows: (([0], [0], [0], [0]), ([0], [0], [0], [0]), ([0], [0], [0], [0]))),
  matrix-values: matrix.with(rows: (([1], [2]), ([3], [4]), ([5], [6])), name: [a]),
  matrix-alias: matrix.with(rows: (([1], [7]), ([3], [4]), ([5], [6])), name: [a], alias: true),
  triangle: matrix.with(rows: (([0],), ([0], [0]), ([0], [0], [0])), name: [a]),
  list-growth: list-growth, list-methods: list-methods, foreach: foreach,
  conversions: conversions, boxing: boxing, math-methods: math-methods,
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
