#import "@preview/touying:0.7.4": *
#import "@preview/codly:1.3.0": *
#import "@preview/fletcher:0.5.8": diagram, node, edge
#import "@preview/cetz:0.4.1"
#import "@preview/numbly:0.1.0": numbly
#import "theme.typ": *

#show: codly-init.with()
#set text(lang: "en")
#set heading(numbering: numbly("{1}.", default: "1.1"))
#show: hestia-theme.with(dark: sys.inputs.at("dark", default: "false") == "true", config-info(
  title: [Hestia layout checks], subtitle: [SOL2 · shared theme],
  author: [Theme check], date: [01.01.2026], institution: [HAW Hamburg],
))

#title-slide()
= Layouts
== Standard content
#slide[
  Source Sans 3 regular, *bold*, _italic_, and inline `Java`.
  #question[What would you like to know?]
  #pause
  Overlay revealed; the slide number must not change.
]
== Sidebar
#sidebar-slide[
  - Main content uses two thirds of the width.
  - All layout helpers accept Touying slide arguments.
][
  #info[Sidebar note]
]
== Two columns
#two-column-slide[
  #memo[Left column]
][
  #tip[Right column]
]
== Code
#code-slide[
  ```java
  public static void main(String[] args) {
    System.out.println("Hello World!");
  }
  ```
  #idea[Keep syntax, language badge, and line numbers.]
]
== Diagram
#diagram-slide[
  #figure(diagram(
    node((0, 0), [Class], name: <class>),
    node((3, 0), [Object], name: <object>),
    edge(<class>, <object>, "->"),
  ), caption: [Fletcher diagram])
]
== Diagram with content
#diagram-slide[
  Text stays above the figure; the figure uses the remaining height.
][
  #figure(cetz.canvas({
    import cetz.draw: *
    rect((0, 0), (5, 1.5), fill: palette.green.lighten(75%), radius: .2)
    content((2.5, .75), [Cetz canvas])
  }), caption: [Cetz diagram])
]
== Callout
#callout-slide[
  #task[Gentle Clues must still number this as Task 1.]
  #warning[High-contrast text on light callout plates.]
]
== Footer
#footer-slide[
  End of layout checks.
  #context {
    assert.eq(utils.slide-counter.final().first(), 9)
    assert.eq(counter(page).final().first(), 9)
  }
]
