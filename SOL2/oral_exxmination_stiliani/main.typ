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

#set page(paper: "a4", margin: (x: 13mm, y: 12mm), numbering: "1")
#set text(lang: "en", size: 9pt)
#set par(leading: 0.45em)

#let answer(body) = block(
  width: 100%,
  fill: rgb("#f6f6f6"),
  stroke: rgb("#b8b8b8") + 0.5pt,
  inset: 4.5pt,
  radius: 2pt,
)[
  #text(size: 8pt)[*Expected / pass indicators:* #body]
]

#let q(title, prompt, key) = block(
  width: 100%,
  stroke: rgb("#345995") + 0.7pt,
  inset: 5pt,
  radius: 3pt,
  below: 5pt,
)[
  #strong(title)
  #v(2pt)
  #prompt
  #v(2pt)
  #answer(key)
]

#align(center)[
  #text(size: 13pt, weight: "bold")[Oral Examination Sheet -- Software Construction 2]
]
#align(center)[HAW Hamburg · EMI · SO2 · Student: *Stiliani* · Examiner copy]

#q(
  [1. Core OOP concepts, warm-up (5 min)],
  [
    Ask short explanations with one Java example each:
    - class vs. object
    - encapsulation and why fields should usually be `private`
    - inheritance vs. composition (`is-a` vs. `has-a`)
    - method overloading vs. overriding
  ],
  [
    Can define class as blueprint, object as instance with state. Mentions information hiding, invariants, getters/setters or methods instead of public fields. Distinguishes `extends` from member fields. Overloading = same name, different parameter list, compile-time choice. Overriding = subclass provides its own implementation of inherited method. Can give small Java example.
  ],
)

#q(
  [2. True/False questionnaire: OOP and Java basics (5 min)],
  [
    Student answers each statement with true or false. Remind her: *Please talk through your thoughts aloud while answering; reasoning is more important than guessing.*

    #table(
      columns: (1fr, 13mm, 13mm),
      inset: 3pt,
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
  ],
  [
    Answer key:
    1. True -- Java has single class inheritance.
    2. False -- `private` means accessible only inside declaring class.
    3. True -- constructors have class name and no return type.
    4. True -- overload resolution uses parameter list.
    5. True -- same signature, compatible return type; `@Override` should compile.
    6. True -- interfaces define contracts for many implementations.
    7. False -- `static` belongs to class and is shared.
    8. True -- `.equals()` is for logical equality if implemented.
  ],
)

#q(
  [Bonus. Code reading: dynamic dispatch (if time remains)],
  [
    Ask student to predict output and explain why. Then ask whether `Circle c = new Shape();` compiles.

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
  ],
  [
    Output: `circle`. Variable type is `Shape`, actual object is `Circle`; overridden methods are selected at runtime. `print()` is inherited, calls `name()`, and dynamic dispatch resolves to `Circle.name()`. `Circle c = new Shape();` does not compile without unsafe cast because not every `Shape` is a `Circle`.
  ],
)

#block(fill: rgb("#fff8e6"), stroke: rgb("#e6c46a") + 0.5pt, inset: 5pt, radius: 3pt)[
  *Suggested passing evidence:* student can explain OOP terms without memorized-only wording, justify true/false Java statements aloud, repair basic Java syntax/OOP errors, and write one correct loop with edge-case reasoning.
]

#pagebreak()

#q(
  [3. 2-minute writing task: small method],
  [
    Student writes Java method `countPositive(int[] values)` that returns number of values greater than 0. Then explain null and empty-array behavior.

    #box(width: 100%, height: 28mm, stroke: rgb("#777777") + 0.5pt)[]
  ],
  [
    Acceptable solution:

    ```java
    public static int countPositive(int[] values) {
        if (values == null) {
            return 0;
        }
        int count = 0;
        for (int value : values) {
            if (value > 0) {
                count++;
            }
        }
        return count;
    }
    ```

    Empty array returns `0`. Null handling may also throw `IllegalArgumentException`; must be stated consistently.
  ],
)

#q(
  [4. Debugging task: find and repair errors (7 min)],
  [
    Ask student to mark at least four problems and say correction.

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
  ],
  [
    `balance` should be `private` for encapsulation. Constructor must have no return type: `public BankAccount(double balance)`. Field assignment needs `this.balance = balance;`. `deposit` missing return type: `public void deposit(double amount)`. `withdraw` expression not assigned: `balance -= amount;`. Good answer may also discuss validation: reject negative deposit/withdraw, prevent overdraft depending on requirements.
  ],
)

#q(
  [5. Closing transfer questions (3--5 min)],
  [
    Choose two if time remains:
    - Why use an interface instead of a concrete class?
    - What does `static` mean for fields and methods?
    - Why is `@Override` useful?
    - What is difference between `==` and `.equals()` for objects?
    - What should unit tests for `countPositive` cover?
  ],
  [
    Interface defines contract and enables multiple implementations. `static` belongs to class, not instance. `@Override` documents intent and catches signature mistakes. `==` compares references for objects; `.equals()` compares logical equality if implemented. Tests: null/empty, all negative, zero, positive mix, one element.
  ],
)


