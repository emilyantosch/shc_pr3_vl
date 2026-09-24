#import "@preview/cetz:0.4.1": canvas, draw
#import "../hestia/theme.typ": palette
#import "../slides_002/diagrams.typ": node, arrow, label

#let roadmap() = {
  for (x, title, detail) in ((0, [Exception handling], [Throw · catch · define]),
    (10, [Input and output], [Read · transform · write]), (20, [Multithreading], [Run tasks concurrently])) {
    node(x, 2, strong(title), width: 9,
      fill: if x == 10 { palette.green.lighten(85%) } else { palette.surface })
    label((x, .3), detail)
    label((x, 3.5), if x == 0 { [Previously] } else if x == 10 { [Today] } else { [Next] })
    if x < 20 { arrow((x + 4.5, 2), (x + 5.5, 2)) }
  }
}

#let goals() = {
  for (y, source, tool, result) in ((6, [Keyboard input], [Scanner], [Tokens + typed values]),
    (3, [Bytes], [Reader + buffering], [Characters + lines]),
    (0, [Text files], [Reader / Writer], [Read + write text])) {
    node(0, y, source, width: 8)
    node(11, y, tool, width: 10)
    node(24, y, result, width: 11)
    arrow((4, y), (6, y))
    arrow((16, y), (18.5, y))
  }
}

#let streams() = {
  node(0, 3, [Source], width: 6)
  node(12, 3, [Program], width: 6, fill: palette.green.lighten(85%))
  node(24, 3, [Sink], width: 6)
  arrow((3, 3), (9, 3))
  arrow((15, 3), (21, 3))
  label((6, 4.2), [Input stream])
  label((18, 4.2), [Output stream])
  label((0, 1.2), [Keyboard · file])
  label((12, 1.2), [Read → process → write])
  label((24, 1.2), [Terminal · file])
}

#let println-parts() = {
  for (x, part, meaning) in ((0, [System], [Class]), (11, [out], [Static field → PrintStream]),
    (23, [println(message)], [Instance method call])) {
    node(x, 3, strong(part), width: 10)
    label((x, 1.2), meaning)
    if x < 23 { arrow((x + 5, 3), (if x == 0 { 6 } else { 18 }, 3)) }
  }
  label((11, -1), [System.out normally writes to the terminal; it can be redirected])
}

#let output-methods() = {
  for (y, call, result) in ((6, [print("Hi")], [Hi · no line break]),
    (3, [println("Hi")], [Hi + platform line separator]),
    (0, [printf("%.1f", 2.75)], [2.8 · formatted output])) {
    node(0, y, call, width: 12)
    node(17, y, result, width: 13)
    arrow((6, y), (10.5, y))
  }
  label((8, -2), [PrintStream.format works like printf · number formatting depends on locale])
}

#let system-streams() = {
  node(0, 6, [Standard input], width: 8)
  node(13, 6, [System.in · InputStream], width: 13)
  node(26, 3, [Program], width: 7, height: 2)
  arrow((4, 6), (6.5, 6))
  arrow((19.5, 6), (26, 6), (26, 4))
  for (y, field, target) in ((1, [System.out · PrintStream], [Standard output]),
    (-3, [System.err · PrintStream], [Standard error])) {
    node(13, y, field, width: 13)
    node(0, y, target, width: 8)
    arrow((26, 2), (26, y), (19.5, y))
    arrow((6.5, y), (4, y))
  }
  label((11, -5), [Usually keyboard / terminal · each stream can be redirected independently])
}

#let scanner() = {
  node(0, 3, [System.in], width: 7)
  node(11, 3, [Scanner], width: 8)
  node(23, 3, [Your program], width: 9)
  arrow((3.5, 3), (7, 3))
  arrow((15, 3), (18.5, 3))
  label((11, 5), [Split tokens + parse values])
  label((0, 1), [Input stream])
  label((23, 1), [String · int · double · …])
  label((11, -1), [close() closes the underlying stream, including System.in])
}

#let tokens() = {
  node(0, 4, [Input: "Hello Java" + Enter], width: 14)
  for (y, method, result) in ((7, [next()], ["Hello"]), (1, [nextLine()], ["Hello Java"])) {
    node(16, y, method, width: 8)
    node(28, y, result, width: 10)
    arrow((7, 4), (9, 4), (9, y), (12, y))
    arrow((20, y), (23, y))
  }
  label((15, -1), [Fresh Scanner for each path · nextLine consumes the line separator])
  label((15, -2.5), [Default token delimiters: whitespace · change with useDelimiter(...)])
}

#let token-loop() = {
  node(0, 5, [hasNext()], width: 8)
  node(13, 5, [next() → process token], width: 11)
  arrow((4, 5), (7.5, 5))
  label((6, 6), [true])
  arrow((18.5, 5), (21, 5), (21, 8), (0, 8), (0, 5.5))
  node(0, 0, [End of input → stop], width: 10)
  arrow((0, 4.5), (0, .5))
  label((-2, 2.5), [false])
  label((15, 2), [No complete token yet? May block.])
  label((15, .5), [Enter ends a line, not the stream.])
  label((10, -2.5), [next() at end of input throws NoSuchElementException])
}

#let typed-input() = {
  for (y, token, result) in ((6, ["127"], [byte value 127]),
    (3, ["128"], [InputMismatchException]), (0, ["Hamburg"], [InputMismatchException])) {
    node(0, y, token, width: 7)
    node(11, y, [nextByte()], width: 8)
    node(26, y, result, width: 14,
      fill: if y == 6 { palette.green.lighten(85%) } else { palette.coral.lighten(90%) })
    arrow((3.5, y), (7, y))
    arrow((15, y), (19, y))
  }
  label((13, -2), [Valid byte range: −128 … 127 · mismatch leaves the token unread])
}

#let validation() = {
  for (x, title) in ((0, [Attempt: nextByte()]), (20, [Check: hasNextByte()])) {
    node(x, 6, title, width: 13)
    node(x, 2, [Valid → consume byte], width: 13)
    arrow((x, 5.5), (x, 2.5))
  }
  node(0, -2, [Mismatch → catch exception], width: 15)
  node(20, -2, [false → invalid token or EOF], width: 15)
  arrow((-6.5, 6), (-9, 6), (-9, -2), (-7.5, -2))
  arrow((26.5, 6), (29, 6), (29, -2), (27.5, -2))
  label((10, -4), [InputMismatchException is unchecked · handle it or validate first])
}

#let vector-flow() = {
  node(0, 3, [7  4  0  15  End], width: 9)
  node(13, 3, [hasNextInt() / nextInt()], width: 13)
  node(28, 3, [[7, 4, 0, 15]], width: 10)
  arrow((4.5, 3), (6.5, 3))
  arrow((19.5, 3), (23, 3))
  label((13, 1), [Stop before End · not an int])
  node(28, -1, [√(49 + 16 + 0 + 225) ≈ 17.03], width: 16)
  arrow((28, 2.5), (28, -.5))
}

#let stream-types() = {
  node(13, 8, [Object], width: 7)
  for (x, name, detail) in ((0, [InputStream], [Read bytes]), (9, [OutputStream], [Write bytes]),
    (18, [Reader], [Read characters]), (27, [Writer], [Write characters])) {
    node(x, 4, name, width: 8)
    arrow((x, 4.5), (x, 6), (13, 6), (13, 7.5))
    label((x, 2.4), detail)
  }
  label((4.5, .5), [8-bit units])
  label((22.5, .5), [16-bit UTF-16 code units])
  label((13, -1.5), [All four are abstract classes · a Unicode character may need two char values])
}

#let decoding() = {
  node(0, 3, [Keyboard / System.in], width: 11)
  node(15, 3, [InputStreamReader], width: 12)
  node(30, 3, [Program], width: 8)
  arrow((5.5, 3), (9, 3))
  arrow((21, 3), (26, 3))
  label((7, 4.2), [Bytes])
  label((24, 4.2), [Characters])
  label((15, .8), [Decode using the input charset])
  label((15, -1), [Example: UTF-8 C3 A4 → ä → UTF-16 00E4])
}

#let line-endings() = {
  for (y, input, result) in ((6, [A + CRLF], [65 → 13 → 10]),
    (3, [A + LF], [65 → 10 → wait]), (0, [End of input], [read() returns −1])) {
    node(0, y, input, width: 10)
    node(16, y, result, width: 13)
    arrow((5, y), (9.5, y))
  }
  label((8, -2), [read() returns an int · line endings depend on the terminal / platform])
  label((8, -3.5), [With LF, a third read may block until more input or EOF])
}

#let buffering() = {
  for (x, title, detail) in ((0, [System.in], [Bytes]), (12, [InputStreamReader], [Decode]),
    (26, [BufferedReader], [Buffer + readLine()]), (38, [Program], [String])) {
    node(x, 3, title, width: if x == 12 or x == 26 { 12 } else { 9 })
    label((x, 1), detail)
  }
  arrow((4.5, 3), (6, 3))
  arrow((18, 3), (20, 3))
  arrow((32, 3), (33.5, 3))
  label((19, -1.5), [readLine() removes the line separator · null means end of input])
}

#let file-model() = {
  node(0, 4, [new File("Testdatei.txt")], width: 14)
  node(18, 4, [Pathname], width: 10)
  arrow((7, 4), (13, 4))
  for (y, title) in ((0, [Metadata: exists · isFile · canRead]), (-3, [Operations: createNewFile · delete])) {
    node(18, y, title, width: 20)
    arrow((18, 3.5), (6, 3.5), (6, y), (8, y))
  }
  label((7, -5), [File does not contain file data · streams read / write the contents])
  label((7, -6.5), [Relative paths resolve from the process working directory])
}

#let file-streams() = {
  for (y, left, middle, right) in ((6, [File], [FileInputStream], [Program]),
    (2, [Program], [FileOutputStream], [File])) {
    node(0, y, left, width: 7)
    node(13, y, middle, width: 12)
    node(26, y, right, width: 7)
    arrow((3.5, y), (7, y))
    arrow((19, y), (22.5, y))
    label((13, y - 1.4), [Bytes · no character decoding])
  }
}

#let text-files() = {
  for (y, a, b, c, d) in ((6, [Program], [BufferedWriter], [FileWriter], [File]),
    (0, [File], [FileReader], [BufferedReader], [Program])) {
    for (x, title) in ((0, a), (12, b), (26, c), (38, d)) {
      node(x, y, title, width: if x == 12 or x == 26 { 12 } else { 9 })
    }
    arrow((4.5, y), (6, y))
    arrow((18, y), (20, y))
    arrow((32, y), (33.5, y))
  }
  label((12, 4), [write(text) + newLine()])
  label((26, 4), [Encode characters → bytes])
  label((12, -2), [Decode bytes → characters])
  label((26, -2), [readLine() → String])
  label((19, -4), [Use the same charset to write and read · close the outermost wrapper])
}

#let resource-flow() = {
  for (x, title) in ((0, [Open resource]), (11, [Read / write]), (22, [Automatic close()])) {
    node(x, 3, title, width: 10)
    if x < 22 { arrow((x + 5, 3), (x + 6, 3)) }
  }
  arrow((11, 2.5), (11, 0), (22, 0), (22, 2.5))
  label((16.5, -1), [Also on exception or return])
  label((11, 5), [try-with-resources])
}

#let diagrams = (
  roadmap: roadmap, goals: goals, streams: streams, println-parts: println-parts,
  output-methods: output-methods, system-streams: system-streams, scanner: scanner,
  tokens: tokens, token-loop: token-loop, typed-input: typed-input, validation: validation,
  vector-flow: vector-flow, stream-types: stream-types, decoding: decoding,
  line-endings: line-endings, buffering: buffering, file-model: file-model,
  file-streams: file-streams, text-files: text-files, resource-flow: resource-flow,
)

#let diagram(name, height: 250pt) = layout(size => {
  set text(size: 26pt, fill: palette.ink)
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
