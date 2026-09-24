#import "@preview/cetz:0.4.1": canvas, draw
#import "../hestia/theme.typ": palette
#import "../slides_002/diagrams.typ": node, arrow, label
#import "../slides_005/diagrams.typ": uml, inherits
#import "../slides_006/diagrams.typ": realizes

// GUI drawings are schematics, not platform-specific screenshots.
#let window(x, y, title, width: 12, height: 8) = {
  draw.rect((x, y), (x + width, y + height), fill: white)
  draw.rect((x, y + height - 1), (x + width, y + height), fill: palette.surface)
  draw.content((x + .3, y + height - .5), strong(title), anchor: "west")
  label((x + width - .5, y + height - .5), [×])
}

#let roadmap() = {
  for (x, title, detail) in (
    (0, [Interfaces], [Shared contracts]),
    (8, [Graphical interfaces], [Components + events]),
    (16, [Exception handling], [Recover from failure]),
  ) {
    node(x, 2, strong(title), width: 7.4,
      fill: if x == 8 { palette.green.lighten(85%) } else { palette.surface })
    label((x, .5), detail)
    if x < 16 { arrow((x + 3.7, 2), (x + 4.3, 2)) }
  }
  label((0, 3.5), [Previously])
  label((8, 3.5), [Today])
  label((16, 3.5), [Next])
}

#let goals() = {
  for (x, title, detail) in (
    (0, [Build], [Frames · menus · labels]),
    (8, [Arrange + draw], [Layouts · Graphics]),
    (16, [React], [Events · Observer pattern]),
  ) {
    node(x, 2, strong(title), width: 6.5)
    label((x, .5), detail)
    if x < 16 { arrow((x + 3.25, 2), (x + 4.75, 2)) }
  }
}

#let explorer() = {
  window(0, 0, [File browser], width: 18, height: 9)
  node(2, 7.2, [Back], width: 3)
  node(9, 7.2, [Home / Documents], width: 9, fill: white)
  node(15.7, 7.2, [Search], width: 3.6, fill: white)
  draw.rect((.4, .4), (4.4, 6.3), fill: palette.surface)
  for (y, name) in ((5.5, [Home]), (4.1, [Documents]), (2.7, [Downloads])) { label((2.4, y), name) }
  for (y, name, detail) in ((5.5, [Lectures], [Folder]), (3.8, [Notes.txt], [Text file]), (2.1, [Photo.png], [Image])) {
    node(9, y, name, width: 7, fill: if y == 3.8 { palette.green.lighten(85%) } else { white })
    label((15, y), detail)
  }
}

#let toolkits() = {
  node(8, 7, [Java desktop libraries], width: 9)
  for (x, title, widget, paint) in (
    (1, [AWT · java.awt], [Native widgets], [Operating system draws controls]),
    (15, [Swing · javax.swing], [Mostly lightweight components], [Swing draws controls]),
  ) {
    node(x, 4, strong(title), width: 12)
    arrow((8, 6.5), (8, 5.5), (x, 5.5), (x, 4.5))
    label((x, 2.5), widget)
    label((x, 1.2), paint)
  }
  arrow((9, 4), (7, 4))
  label((8, 3), [builds on])
  label((8, -1), [Both included in the JDK])
}

#let frame() = {
  window(0, 0, [GUI example])
  draw.rect((0, 5.8), (12, 7), fill: palette.surface)
  label((2, 6.4), [File   Help])
  label((6, 2.9), [Content pane])
  for (y, name, target) in ((7.5, [Title + window controls], 7.5), (5.4, [Optional JMenuBar], 6.4), (2.9, [Place components here], 2.9)) {
    label((19, y), name)
    arrow((15, y), (13.5, y), (13.5, target), (12, target))
  }
  label((6, -1.2), [JFrame contains both menu bar and content pane])
}

#let hierarchy() = {
  node(8, 7, [JFrame], width: 5)
  node(8, 4.5, [Content pane · BoxLayout.Y_AXIS], width: 12)
  arrow((8, 6.5), (8, 5))
  for (x, title) in ((1, [Drawing panel]), (15, [JPanel · BoxLayout.X_AXIS])) {
    node(x, 1.8, title, width: 11)
    arrow((8, 4), (8, 3.2), (x, 3.2), (x, 2.3))
  }
  for (x, title) in ((11, [JButton]), (19, [JButton])) {
    node(x, -1, title, width: 5)
    arrow((15, 1.3), (15, .3), (x, .3), (x, -.5))
  }
  label((1, -1), [Each container owns its layout])
}

#let startup() = {
  for (x, title, detail) in (
    (0, [main()], [Queue GUI creation]),
    (8, [Constructor on EDT], [Build + configure frame]),
    (16, [setVisible(true)], [Show window]),
  ) {
    node(x, 2, title, width: 7)
    label((x, .5), detail)
    if x < 16 { arrow((x + 3.5, 2), (x + 4.5, 2)) }
  }
}

#let geometry() = {
  arrow((0, 9), (15, 9))
  arrow((0, 9), (0, -1))
  label((15.6, 9), [x])
  label((0, -1.7), [y])
  label((-1, 9.6), [(0, 0)])
  window(2, 1, [GUI example], width: 10, height: 6)
  draw.line((2, 7), (2, 9), stroke: (dash: "dashed"))
  draw.line((0, 7), (2, 7), stroke: (dash: "dashed"))
  label((1, 9.7), [50])
  label((-1, 7), [50])
  draw.line((2, .2), (12, .2), mark: (start: "<", end: ">"))
  label((7, -.6), [400 px])
  draw.line((13, 1), (13, 7), mark: (start: "<", end: ">"))
  label((15, 4), [300 px])
  label((7, -2), [Frame size includes borders and title bar · not to scale])
}

#let menu-tree() = {
  node(11.5, 6, [JFrame], width: 5)
  node(11.5, 4, [JMenuBar], width: 6)
  arrow((11.5, 5.5), (11.5, 4.5))
  label((17, 5), [setJMenuBar()])
  for (x, title, items) in ((5, [File], ((0, [Open]), (5, [Save]), (10, [Exit]))),
    (20.5, [Help], ((18, [Help]), (23, [About])))) {
    node(x, 2, [JMenu · #title], width: 7)
    arrow((11.5, 3.5), (11.5, 3), (x, 3), (x, 2.5))
    for (item-x, item) in items {
      node(item-x, 0, item, width: 4.5)
      arrow((x, 1.5), (x, 1), (item-x, 1), (item-x, .5))
    }
  }
  label((11.5, -1.3), [Bottom row: JMenuItem · menus and items use add()])
}

#let menu-output() = {
  for (x, title, items) in ((0, [File], ([Open], [Save], [Exit])), (13, [Help], ([Help], [About]))) {
    window(x, 0, [Menu example], width: 11, height: 7)
    draw.rect((x, 5), (x + 11, 6), fill: palette.surface)
    label((x + 1.5, 5.5), [File])
    label((x + 4, 5.5), [Help])
    let left = x + if title == [File] { .3 } else { 2.8 }
    draw.rect((left, 5), (left + 4.5, 4.8 - items.len()), fill: white)
    for (i, item) in items.enumerate() {
      label((left + 2.25, 4.4 - i), item)
      if title == [File] and i == 1 { draw.line((left, 2.9), (left + 4.5, 2.9)) }
    }
    label((x + 5.5, -1), [#title menu open])
  }
}

#let labels() = {
  window(0, 0, [Label example], width: 12, height: 9)
  // A vector stand-in for the ImageIcon loaded by the Java example.
  draw.rect((4.8, 5), (7.2, 7.4), fill: palette.surface)
  draw.circle((6.6, 6.8), radius: .25, fill: palette.yellow)
  draw.line((5, 5.2), (5.8, 6.2), (6.3, 5.6), (7, 6.3), stroke: 2pt + palette.green)
  label((6, 4.5), [Icon])
  draw.rect((.2, .2), (11.8, 4), stroke: 1.4pt + red)
  draw.rect((.3, .3), (11.7, 3.9), stroke: 1pt + orange)
  draw.content((11.5, 2), [Right-aligned text], anchor: "east")
  label((19, 6), [JLabel · image + text])
  arrow((15, 6), (12, 6))
  label((19, 2), [JLabel · etched border])
  arrow((15, 2), (12, 2))
  label((6, -1.2), [GridLayout(2, 1) · equal-height rows])
}

#let layouts() = {
  for (x, y, name) in ((0, 5, [BoxLayout.X_AXIS]), (14, 5, [BoxLayout.Y_AXIS]),
    (0, -1, [GridLayout(2, 2)]), (14, -1, [FlowLayout])) {
    label((x + 5.5, y + 3.8), strong(name))
    draw.rect((x, y), (x + 11, y + 3), fill: white)
    if name == [BoxLayout.X_AXIS] {
      for (i, title) in ([Ready], [Set], [Go]).enumerate() { node(x + 1.8 + i * 3.5, y + 1.5, title, width: 3.5) }
    } else if name == [BoxLayout.Y_AXIS] {
      for (i, title) in ([Ready], [Set], [Go]).enumerate() { node(x + 5.5, y + 2.5 - i, title, width: 4) }
    } else if name == [GridLayout(2, 2)] {
      for (i, title) in ([Ready], [Set], [Go], [Again]).enumerate() {
        node(x + 2.75 + calc.rem(i, 2) * 5.5, y + 2.25 - calc.floor(i / 2) * 1.5, title, width: 5.5, height: 1.5)
      }
    } else {
      node(x + 3.6, y + 2.3, [Ready], width: 4)
      node(x + 7.4, y + 2.3, [Set], width: 3)
      node(x + 3.3, y + 1, [Go], width: 3)
      node(x + 7.2, y + 1, [Again], width: 4)
    }
  }
  label((5.5, -2), [Equal-sized cells])
  label((19.5, -2), [Wrap when the row is full])
}

#let nested-layout(annotated: false) = {
  window(0, 0, [Nested layouts], width: 18, height: 9)
  draw.line((9, 0), (9, 8))
  draw.line((0, 4), (18, 4))
  label((4.5, 6), [Top left])
  node(13.5, 7, [Right], width: 4)
  node(13.5, 5.8, [top], width: 4)
  node(2.5, 2, [Left], width: 4)
  node(6.5, 2, [bottom], width: 4)
  label((13.5, 2), [Bottom right])
  if annotated {
    label((13.5, 4.7), [JPanel · Y_AXIS])
    label((4.5, .8), [JPanel · X_AXIS])
    label((9, -1.2), [Content pane · GridLayout(2, 2)])
  }
}

#let painting() = {
  node(0, 5, [Window exposed / resized], width: 10)
  node(0, 1, [repaint() request], width: 10)
  node(13, 3, [Swing painting system], width: 10)
  arrow((5, 5), (6.5, 5), (6.5, 3), (8, 3))
  arrow((5, 1), (6.5, 1), (6.5, 3), (8, 3))
  node(13, -1, [paintComponent(Graphics g)], width: 11)
  arrow((13, 2.5), (13, -.5))
  label((4, -1), [Scheduled on the EDT])
  label((7, -3), [Graphics provides text, lines, rectangles, ovals and arcs])
}

#let paint-uml() = {
  uml(0, 6, [JPanel], width: 14, rows: ([\# paintComponent(Graphics): void], [\+ repaint(): void]))
  uml(0, 1, [MyPaintPanel], width: 14, rows: ([\# paintComponent(Graphics): void], [\+ getPreferredSize(): Dimension]))
  inherits((0, 1), (0, 3.85))
  label((0, -3), [Override paintComponent(); call super first])
}

#let painted-output() = {
  window(0, 0, [Panel example], width: 12, height: 9)
  // Same 300 × 200 drawing coordinates as the Java example, scaled by .04.
  draw.rect((1, 4.8), (5, 6), fill: white)
  label((3, 5.4), text(13pt, [JPanel]))
  draw.rect((1, 2), (5, 3.2), fill: white)
  label((3, 2.6), text(13pt, [MyPaintPanel]))
  draw.line((3, 3.2), (3, 4.8))
  draw.line((2.8, 4.4), (3, 4.8), (3.2, 4.4), close: true, fill: black)
  draw.rect((8.08, 3.52), (8.56, 5.2), fill: red, stroke: none)
  draw.circle((8.32, 2.88), radius: .32, fill: red, stroke: none)
}

#let traffic-lights() = {
  for (x, active) in ((0, 2), (6, 0)) {
    draw.rect((x + 1.3, -3.5), (x + 1.7, 4), fill: palette.ink)
    draw.rect((x, 0), (x + 3, 8), fill: palette.ink)
    for (i, color) in (red, yellow, lime).enumerate() {
      draw.circle((x + 1.5, 6.6 - i * 2.5), radius: .9,
        fill: if i == active { color } else { palette.stone }, stroke: none)
    }
    draw.line((x + 1.5, -.7), (x + 2.7, -1.9), (x + 1.5, -3.1), (x + .3, -1.9), close: true, fill: white)
    draw.line((x + 1.5, -1), (x + 2.4, -1.9), (x + 1.5, -2.8), (x + .6, -1.9), close: true, fill: yellow)
  }
}

#let color-window(annotated: false) = {
  window(0, 0, [Button example], width: 13, height: 9)
  for (i, title) in ([Change color to red], [Change color to blue], [Change to random color]).enumerate() {
    node(6.5, 7 - i * 2, title, width: 13, height: 2)
  }
  draw.rect((0, 0), (13, 2), fill: palette.surface)
  if annotated {
    label((19, 5), [3 × JButton])
    arrow((16, 5), (13, 5))
    label((19, 1), [JPanel])
    arrow((16, 1), (13, 1))
    label((6.5, -1.3), [GridLayout(4, 1)])
  } else {
    for (y, title, color) in ((7, [Red], rgb("#ff0000")), (5, [Blue], rgb("#0000ff")), (3, [Random], rgb("#ab78b9"))) {
      arrow((13, y), (17, y))
      draw.rect((17.5, y - .6), (19, y + .6), fill: color)
      label((21, y), title)
    }
    label((18, -1.3), [Click → panel background])
  }
}

#let event-sequence() = {
  for (x, title) in ((0, [User]), (8, [Button]), (19, [Listener])) {
    node(x, 8, title, width: 5)
    draw.line((x, 7.5), (x, -2), stroke: (paint: palette.muted, dash: "dashed"))
  }
  arrow((19, 6), (8, 6))
  label((13.5, 6.7), [1 · register listener])
  for (y, step) in ((3, [2]), (-.5, [3])) {
    arrow((0, y), (8, y))
    label((4, y + .7), [#step · click])
    arrow((8, y - 1), (19, y - 1))
    label((13.5, y - .3), [callback(event)])
  }
  label((9.5, -3.2), [Register once · notify on every action · time flows downward])
}

#let observer(swing: false) = {
  let subject = if swing { [JButton] } else { [Button · subject] }
  let contract = if swing { [«interface» ActionListener] } else { [«interface» Observer] }
  let method = if swing { [\+ actionPerformed(ActionEvent): void] } else { [\+ update(): void] }
  uml(0, 6, subject, width: 12, rows: if swing { ([\+ addActionListener(ActionListener)],) } else { ([− observers: List\<Observer\>], [\+ register(Observer): void]) })
  uml(17, 6, contract, width: 13, rows: (emph(method),))
  arrow((6, 5), (10.5, 5))
  label((8.25, 6), [0..\*])
  uml(17, .5, if swing { [ButtonEvent] } else { [ConcreteObserver] }, width: 13, rows: (method,))
  realizes((17, .5), (17, 4.5))
  label((0, .5), [Stores listeners by interface type])
  label((0, -1), [No concrete class dependency])
  label((10, -3), if swing { [On an action: call actionPerformed(event) on each registered listener] }
    else { [On a change: call update() on each registered observer] })
}

#let dispatch() = {
  node(0, 3, [ActionEvent], width: 6)
  for (y, method, meaning) in ((6, [getSource()], [Which object?]), (0, [getActionCommand()], [Which command string?])) {
    node(9, y, method, width: 8)
    node(20, y, meaning, width: 10)
    arrow((3, 3), (4, 3), (4, y), (5, y))
    arrow((13, y), (15, y))
  }
  label((12, -2), [Two ways to choose the response])
}

#let listeners() = {
  for (i, event, listener) in (
    (0, [Component · resize / move / show / hide], [ComponentListener]),
    (1, [Focus · gained / lost], [FocusListener]),
    (2, [Key · pressed / released / typed], [KeyListener]),
    (3, [Mouse · click / press / release / enter / exit], [MouseListener]),
    (4, [Pointer · moved / dragged], [MouseMotionListener]),
    (5, [Wheel · rotated], [MouseWheelListener]),
  ) {
    let y = 9 - i * 1.8
    node(0, y, event, width: 14)
    node(13, y, listener, width: 9)
    arrow((7, y), (8.5, y))
  }
  label((5, -1.4), [KeyListener receives key events only while the component has focus])
}

#let dialog() = {
  window(0, 0, [Application], width: 17, height: 11)
  window(2, 2.5, [Message], width: 13, height: 5.5)
  draw.circle((3.4, 5.5), radius: .5, fill: palette.surface)
  label((3.4, 5.5), [i])
  label((9.3, 5.5), [This is an information message.])
  node(8.5, 3.6, [OK], width: 3)
  label((8.5, -1.3), [Modal: dismiss the dialog to return to the parent window])
}

#let controls() = {
  for (y, goal, classes) in ((8, [Enter text], [JTextField · JPasswordField · JTextArea]),
    (5, [Choose values], [JCheckBox · JComboBox · JList]),
    (2, [Explain a control], [setToolTipText("...")]),
    (-1, [Choose a file], [JFileChooser])) {
    node(0, y, goal, width: 7)
    node(14, y, classes, width: 17)
    arrow((3.5, y), (5.5, y))
  }
}

#let diagrams = (
  roadmap: roadmap, goals: goals, explorer: explorer, toolkits: toolkits,
  frame: frame, hierarchy: hierarchy, startup: startup, geometry: geometry,
  menu-tree: menu-tree, menu-output: menu-output, labels: labels, layouts: layouts,
  nested-layout: nested-layout, nested-annotated: nested-layout.with(annotated: true),
  painting: painting, paint-uml: paint-uml, painted-output: painted-output,
  traffic-lights: traffic-lights, color-window: color-window,
  color-components: color-window.with(annotated: true), event-sequence: event-sequence,
  observer: observer, action-listener: observer.with(swing: true), dispatch: dispatch,
  listeners: listeners, dialog: dialog, controls: controls,
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
