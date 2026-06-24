#import "@preview/grape-suite:3.1.0": colors, exercise
#import "@preview/gentle-clues:1.3.0": *
#import exercise: project, subtask, task
#import colors: *

#import "@preview/codly:1.3.0": *
#show: codly-init.with()

#codly(
  languages: (
    java: (
      name: text(font: "JetBrainsMono NFM", " Java", weight: "bold"),
      icon: text(font: "JetBrainsMono NFM", "\u{e738}", weight: "bold"),
      color: rgb("#CE412B"),
    ),
    c: (
      name: text(font: "JetBrainsMono NFM", " C", weight: "bold"),
      icon: text(font: "JetBrainsMono NFM", "\u{e61e}", weight: "bold"),
      color: rgb("#5612EC"),
    ),
  ),
)

#set page(paper: "a4", margin: (x: 16mm, y: 16mm), numbering: "1")
#set text(lang: "en", size: 10pt)
#set par(leading: 0.55em)

#let squared-notes-page(title) = [
  #pagebreak()
  #block(
    width: 100%,
    height: 260mm,
    stroke: rgb("#345995") + 0.7pt,
    inset: 3mm,
    radius: 3pt,
  )[
    #strong(title)
    #v(2mm)
    #table(
      columns: range(34).map(_ => 5mm),
      rows: range(48).map(_ => 5mm),
      stroke: rgb("#9db6e0").transparentize(60%) + 0.35pt,
      inset: 0pt,
      ..range(34 * 48).map(_ => [])
    )
  ]
]

#align(center)[
  #text(size: 14pt, weight: "bold")[Oral Examination -- Student Handout]
]
#align(center)[Software Construction 2 · Tasks 1-4 and Bonus]

#block(
  width: 100%,
  stroke: rgb("#345995") + 0.7pt,
  inset: 7pt,
  radius: 3pt,
)[
  #strong[Task 1. Core OOP concepts, warm-up]

  Explain each concept shortly and give one Java example where helpful. Please talk through your thoughts aloud.

  - class vs. object
  - encapsulation and why fields should usually be `private`
  - inheritance vs. composition (`is-a` vs. `has-a`)
  - method overloading vs. overriding
]

#v(5pt)

#block(
  width: 100%,
  stroke: rgb("#345995") + 0.7pt,
  inset: 7pt,
  radius: 3pt,
)[
  #strong[Task 2. True/False questionnaire: OOP and Java basics]

  Answer each statement with true or false. *Please talk through your thoughts aloud while answering; explain why you choose true or false.*

  #table(
    columns: (1fr, 15mm, 15mm),
    inset: 5pt,
    table.header([*Statement*], [*True*], [*False*]),
    [In Java, a class can extend only one other class.], [], [],
    [A `private` field can be accessed directly from any other class in the same package.], [], [],
    [A constructor has the same name as the class and no return type.], [], [],
    [Method overloading means same method name with different parameter lists.], [], [],
    [A subclass can override an inherited method by providing a compatible method with the same signature.], [], [],
    [An interface can be implemented by multiple unrelated classes.], [], [],
    [A `static` field belongs separately to each object instance.], [], [],
    [For objects, `==` compares references, not logical content.], [], [],
  )
]

#pagebreak()

#block(
  width: 100%,
  stroke: rgb("#345995") + 0.7pt,
  inset: 7pt,
  radius: 3pt,
)[
  #strong[Task 3. 2-minute writing task: small method]

  Write a Java method `countPositive(int[] values)` that returns the number of values greater than 0. Then explain what should happen for `null` and for an empty array.

  #box(width: 100%, height: 35mm, stroke: rgb("#777777") + 0.5pt)[]
]

#v(5pt)

#block(
  width: 100%,
  stroke: rgb("#345995") + 0.7pt,
  inset: 7pt,
  radius: 3pt,
)[
  #strong[Task 4. Debugging task: find and repair errors]

  Mark at least four problems in the code and explain how you would correct them.

  ```java
  public class BankAccount {
      public double balance;

      public void BankAccount(double balance) {
          balance = balance;
      }

      public deposit(double amount) {
          balance += amount;
      }

      public void withdraw(double amount) {
          balance - amount;
      }
  }
  ```

  #box(width: 100%, height: 52mm, stroke: rgb("#777777") + 0.5pt)[]
]

#pagebreak()

#block(
  width: 100%,
  stroke: rgb("#345995") + 0.7pt,
  inset: 7pt,
  radius: 3pt,
)[
  #strong[Bonus. Code reading: dynamic dispatch]

  Predict the output and explain why. Then answer whether `Circle c = new Shape();` compiles.

  ```java
  class Shape {
      public String name() { return "shape"; }
      public void print() { System.out.println(name()); }
  }

  class Circle extends Shape {
      @Override
      public String name() { return "circle"; }
  }

  public class Demo {
      public static void main(String[] args) {
          Shape s = new Circle();
          s.print();
      }
  }
  ```

  #box(width: 100%, height: 28mm, stroke: rgb("#777777") + 0.5pt)[]
]

#squared-notes-page[Notes and answers]
#squared-notes-page[Additional notes and answers]
