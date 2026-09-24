#import "@preview/touying:0.7.4": *
#import "@preview/codly:1.3.0": *
#show: codly-init.with()
#import "@preview/numbly:0.1.0": numbly
#import "../hestia/theme.typ": *
#import "diagrams.typ": diagram

#set text(lang: "en")
#set heading(numbering: numbly("{1}.", default: "1.1"))

#show: hestia-theme.with(
  compact: true,
  config-info(
    title: [Object-Oriented\ Programming in Java],
    short-title: [Java · Lecture 2],
    subtitle: [Lecture 2 — Imperative Concepts],
    author: [Emily Lucia Antosch],
    date: datetime.today().display("[day].[month].[year]"),
    institution: [HAW Hamburg],
  ),
)

// Codly lays out each code line as a grid row: increase its vertical inset.
#show raw.where(block: true): it => {
  codly(inset: (x: .32em, y: .22em))
  it
}
#set table(inset: 8pt, align: left + horizon,
  fill: (_, y) => if calc.odd(y) { palette.surface })

#title-slide(authors: [Emily Lucia Antosch])
#outline-slide()

= Introduction
== Where Are We Now?
#slide[
  #diagram("roadmap", height: 200pt)
]

== The Goal of This Chapter
#slide[
  - Choose Java's primitive data types.
  - Control program flow with conditions and loops.
  - Write readable code with consistent names and formatting.
]

= Simple Data Types
== Data Types and Memory
#slide[
  #question[How can a program remember its state?]
  #pause
  Variables store values in memory. Their types determine how those values are interpreted.
  #v(12pt)
  #diagram("memory", height: 150pt)
]

#slide[
  #question[Which data types do you know from C?]
  #pause
  - `int`, `char`, `float`, `double`, `bool`
  - `struct`, `enum`, `union`
  - Arrays and pointers
  - `void`: no value
]

== Data Types in Java
#slide[
  #diagram("data-types", height: 295pt)
]

#slide[
  #text(20pt)[
    #table(
      columns: (auto, auto, auto, 1fr),
      table.header([*Kind*], [*Type*], [*Size*], [*Range / values*]),
      table.cell(rowspan: 4, [Integer]), [`byte`], [1 byte], [$-2^7$ to $2^7 - 1$],
      [`short`], [2 bytes], [$-2^15$ to $2^15 - 1$],
      [`int`], [4 bytes], [$-2^31$ to $2^31 - 1$],
      [`long`], [8 bytes], [$-2^63$ to $2^63 - 1$],
      [Character], [`char`], [2 bytes], [0 to 65,535 (UTF-16 code unit)],
      table.cell(rowspan: 2, [Floating point]), [`float`], [4 bytes], [IEEE 754 binary32],
      [`double`], [8 bytes], [IEEE 754 binary64],
      [Truth], [`boolean`], [Not specified], [`true` or `false`],
    )
  ]
]

== Declaration and Initialization
#slide[
  #diagram("variable-lifecycle", height: 200pt)
  #v(18pt)
  #memo[Declare a local variable before use. Assign a value before reading it.]
]

#slide[
  Declare first, then assign the initial values with `=`.
  #grid(columns: (1fr, 1fr), gutter: 24pt,
    [
      *Declaration*
      ```java
      int a;
      float b;
      char c;
      ```
    ],
    [
      *Initialization*
      ```java
      a = 5;
      b = 3.5f;
      c = 'A';
      ```
    ],
  )
]

#slide[
  Declaration and initialization can be combined.
  ```java
  int a = 5;
  float b = 3.5f;
  char c = 'A';
  ```
]

== Scope of Variables
#slide[
  #diagram("scope", height: 245pt)
  A local variable's scope starts at its declaration and ends with its block.
]

== Type Correctness
#slide[
  Assignments must use compatible types.
  ```java
  float b = 3.5f;
  int a = b; // Compile error: possible loss of precision
  ```
  #memo[Java does not implicitly narrow a float to an int.]
]

#slide[
  #question[What differs from C?]
  #pause
  - Java uses classes and arrays, not C's `struct` or `union`.
  - Integer widths are fixed; there is no `unsigned` keyword.
  - `char` is unsigned and stores one 16-bit UTF-16 code unit.
  - No pointer arithmetic.
]

== Literals
#slide[
  A *literal* is a value written directly in source code.
  #v(14pt)
  #diagram("literal-types", height: 170pt)
]

#slide[
  #question[Why does this fail to compile?]
  ```java
  float point = 3.1416;
  ```
  #pause
  `3.1416` is a `double` literal. Java does not implicitly narrow it to `float`.
]

#slide[
  Use an `f` suffix, or choose a `double` variable.
  ```java
  float point = 3.1416f;
  double precisePoint = 3.1416;
  ```
]

== Constants
#slide[
  A `final` variable can be assigned only once.
  ```java
  final double PI = 3.1416;
  PI = 3; // Compile error: PI is final
  ```
]

== Creating Console Output
#slide[
  #task[Open an executable class in IntelliJ IDEA. Run this code.]
  ```java
  int age = 24;
  System.out.println(24);
  System.out.println(age);
  ```
]

#slide[
  Use `+` to combine text and values.
  ```java
  int age = 24;
  System.out.println("My age is " + 24);
  System.out.println("My age is " + age);
  ```
  #tip[In IntelliJ IDEA, type `sout` and press Tab to insert `System.out.println()`.]
]

== Coding Style
#slide[
  #question[What is a coding style?]
  #pause
  Shared naming and formatting rules make code easier to read and maintain.
  #memo[Coding style is assessed in the exam.]
]

== Coding Style: Naming Conventions
#slide[
  Use meaningful English names.
  #table(
    columns: (1fr, 1fr, 1fr),
    table.header([*Identifier*], [*Convention*], [*Example*]),
    [Class], [UpperCamelCase], [`BankAccount`],
    [Method / variable], [lowerCamelCase], [`accountBalance`],
    [Constant], [UPPER_CASE], [`MAX_SIZE`],
    [Package], [lowercase], [`banking`],
  )
]

= Comments and Identifiers
== Character Set
#slide[
  Java uses Unicode. Some characters need two UTF-16 code units.
  #diagram("unicode", height: 180pt)
  ```java
  System.out.println("\uD83D\uDE00"); // 😀
  ```
  Write course comments in German or English.
]

== Comments
#slide[
  #question[Who will need to read your code?]
  #v(24pt)
  “Make the code readable? Who else is supposed to read this?”
]

#slide[
  - Explain intent, assumptions, and non-obvious decisions.
  - Keep comments accurate when code changes.
  #memo[Useful comments explain why, not what the code already says.]
]

#slide[
  #question[How do line and block comments differ?]
  #pause
  ```java
  // A line comment ends at the line break.
  int distance; // Distance between a and b
  ```
  ```java
  /* A block comment can span
     several lines. */
  ```
]

== Identifiers
#slide[
  An *identifier* is a name in your program.
  - Start with a Java letter, `_`, or a currency symbol such as `$`.
  - Later characters may also be digits.
  - Names are case-sensitive; spaces are not allowed.
  - Keywords and `true`, `false`, `null` are not names.
  - A single `_` is not an identifier (Java 9+).
]

#slide[
  #text(19pt)[
    *Reserved keywords*
    #table(
      columns: (1fr, 1fr, 1fr, 1fr), inset: 4pt,
      `abstract`, `double`, `int`, `super`,
      `assert`, `else`, `interface`, `switch`,
      `boolean`, `enum`, `long`, `synchronized`,
      `break`, `extends`, `native`, `this`,
      `byte`, `final`, `new`, `throw`,
      `case`, `finally`, `package`, `throws`,
      `catch`, `float`, `private`, `transient`,
      `char`, `for`, `protected`, `try`,
      `class`, `goto`, `public`, `void`,
      `const`, `if`, `return`, `volatile`,
      `continue`, `implements`, `short`, `while`,
      `default`, `import`, `static`, `_`,
      `do`, `instanceof`, `strictfp`, [],
    )
    Contextual keywords such as `var` have additional restrictions.
  ]
]

#slide[
  #question[Which identifiers are allowed, and why?]
  #grid(columns: (1fr, 1fr), gutter: 24pt,
    [
      ```java
      int length;
      int länge;
      int maxLength;
      int max_length;
      int _max_length;
      int max-length;
      int !maxLength;
      ```
    ],
    [
      ```java
      int 3dlength;
      String öpnvKosten;
      String €kosten;
      String kostenin€;
      String €;
      int long;
      int c.o.s.t;
      String @cost;
      ```
    ],
  )
]

= Operators
== Arithmetic Operators
#slide[
  #text(21pt)[
    #table(
      columns: (auto, 1fr, 1fr),
      table.header([*Operator*], [*Operation*], [*Example*]),
      [`+`, `-`], [Unary sign], [`+a`, `-a`],
      [`++`, `--`], [Increment / decrement], [`++count`, `count--`],
      [`*`, `/`, `%`], [Multiply / divide / remainder], [`11 % 4` gives `3`],
      [`+`, `-`], [Add / subtract], [`a + b`, `a - b`],
    )
  ]
  - Multiplication, division, and remainder bind before addition and subtraction.
  - Most binary operators group left to right; parentheses override precedence.
  - Integer division discards the fractional part: `7 / 2` is `3`.
]

== Increment and Decrement
#slide[
  #diagram("increment", height: 210pt)
  `--a` and `a--` follow the same order, but subtract 1.
]

#slide[
  #question[What does this print?]
  ```java
  int a = 1;
  System.out.println("++a : " + ++a);
  System.out.println("a   : " + a);
  System.out.println("a++ : " + a++);
  System.out.println("--a : " + --a);
  System.out.println("a-- : " + a--);
  ```
]

== Comparison Operators
#slide[
  #table(
    columns: (auto, 1fr),
    table.header([*Operator*], [*Meaning*]),
    [`<`, `<=`], [Less than / less than or equal to],
    [`>`, `>=`], [Greater than / greater than or equal to],
    [`==`, `!=`], [Equal to / not equal to],
  )
  Comparisons produce a `boolean`. Relational operators bind before equality operators.
]

#slide[
  #question[Do these expressions give the same result?]
  ```java
  int a = 7, b = 4;
  boolean parentheses = (a > b) == (a <= b);
  boolean priorities = a > b == a <= b;
  System.out.println(parentheses);
  System.out.println(priorities);
  ```
]

== Logical Operators
#slide[
  #table(
    columns: (auto, 1fr, 1fr),
    table.header([*Operator*], [*Meaning*], [*True when…*]),
    [`!`], [NOT], [the operand is false],
    [`^`], [XOR], [the operands differ],
    [`&&`], [AND], [both operands are true],
    [`||`], [OR], [at least one operand is true],
  )
  For boolean operands, precedence decreases from top to bottom.
]

== Short-Circuit Evaluation
#slide[
  #diagram("short-circuit", height: 275pt)
  Only `&&` and `||` can skip the right operand; `^` evaluates both.
]

#slide[
  #question[What is the final value of a?]
  ```java
  int a = 3, b = 4;
  System.out.println((++a == b) || (a++ > b));
  System.out.println("a = " + a);
  ```
]

== Assignment Operators
#slide[
  #table(
    columns: (1fr, 1fr),
    table.header([*Assignment*], [*For an int variable a*]),
    [`a = 3`], [Store 3],
    [`a += 2`], [`a = a + 2`],
    [`a *= 2`], [`a = a * 2`],
    [`a /= 2`], [`a = a / 2`],
  )
  Also available: `-=`, `%=` and bitwise compound assignments.

  #text(20pt)[Compound assignment evaluates the left operand once and converts the result back to its type.]
]

#slide[
  #question[What does this print?]
  ```java
  int a = 1;
  a += 2;
  System.out.println(a);
  System.out.println(a *= --a);
  System.out.println(a *= -a++);
  System.out.println(a /= 10);
  ```
]

= Type Conversion
== Explicit Type Conversion
#slide[
  A narrowing conversion needs an explicit *cast*.
  ```java
  int a = 80;
  byte b = (byte) a;
  System.out.println(b);
  ```
  #warning[A cast can lose precision or change the value.]
]

#slide[
  #question[What does each cast produce?]
  ```java
  double a = 128.38;
  int b = (int) a;
  byte c = (byte) a;
  System.out.println("double: " + a);
  System.out.println("int   : " + b);
  System.out.println("byte  : " + c);
  ```
]

#slide[
  #diagram("narrowing", height: 180pt)
  #memo[A byte ranges from −128 to 127. Casting 128 to byte produces −128.]
]

== Implicit Type Conversion
#slide[
  Widening conversions need no cast.
  ```java
  short a = 71;
  int b = (int) a; // Cast is allowed, but redundant
  int c = a;
  ```
]

#slide[
  #question[Which lines compile?]
  ```java
  short a = 1024;
  long b = a;
  float c = b;
  ```
]

#slide[
  #question[Which lines compile?]
  ```java
  char d = 'A';
  short e = d;
  int f = d;
  ```
]

#slide[
  #diagram("widening", height: 165pt)
  #text(21pt)[
    - `char`: 0…65,535; `short`: −32,768…32,767. Neither range contains the other.
    - `int` → `float` and `long` → `float` / `double` can lose precision.
  ]
]

= Control Structures
== if Statement
#slide[
  Execute the body only when the boolean condition is `true`.
  #grid(columns: (1fr, 1fr), gutter: 28pt,
    [
      ```java
      if (condition) {
        // Statements
      }
      ```
    ],
    [#diagram("if", height: 215pt)],
  )
]

#slide[
  ```java
  int a = 4, b = 8;
  int maximum = a;
  if (b > maximum) {
    maximum = b;
  }
  ```
  Braces are optional for one statement; keep them for readability.
]

== if-else Statement
#slide[
  Exactly one branch runs.
  #grid(columns: (1fr, 1fr), gutter: 28pt,
    [
      ```java
      if (condition) {
        // Statements 1
      } else {
        // Statements 2
      }
      ```
    ],
    [#diagram("if-else", height: 235pt)],
  )
]

#slide[
  ```java
  int a = 4, b = 8;
  int maximum;
  if (a > b) {
    maximum = a;
  } else {
    maximum = b;
  }
  ```
]

== The ? Operator
#slide[
  Select one of two values.
  ```java
  int maximum = (a > b) ? a : b;
  ```
  #diagram("ternary", height: 190pt)
]

== if-else Exercise
#slide[
  #task[Given `weekDay` from 1 (Monday) to 7 (Sunday), print the matching activity.]
  #diagram("weekday", height: 200pt)
]

#slide[
  ```java
  byte weekDay = 3;
  if (weekDay <= 5) {
    System.out.println("Working");
  } else if (weekDay == 6) {
    System.out.println("Shopping");
  } else if (weekDay == 7) {
    System.out.println("Resting");
  }
  ```
]

== switch Statement
#slide[
  Select an entry point by value.
  ```java
  switch (expression) {
    case 1:
      // Statements
      break;
    default:
      // Fallback statements
  }
  ```
]

#slide[
  #diagram("switch", height: 260pt)
  #text(20pt)[No match and no `default`: skip the switch. Without `break`, execution falls through subsequent labels.]
]

#slide[
  - Classic switch selectors include `byte`, `short`, `char`, `int`, their wrappers, enums, and `String`.
  - Several labels can share a body.
  - `default` handles unmatched values; it is optional.
  #task[Rewrite the weekday exercise using a classic `switch` statement.]
]

#slide[
  #text(21pt)[*Solution · cases 1–6*]
  ```java
  switch (weekDay) {
    case 1: case 2: case 3: case 4: case 5:
      System.out.println("Working");
      break;
    case 6:
      System.out.println("Shopping");
      break;
  ```
]

#slide[
  #text(21pt)[*Solution · continued*]
  #codly(offset: 7)
  ```java
    case 7:
      System.out.println("Resting");
      break;
    default:
      System.out.println("Unknown day");
  }
  ```
]

== while Loop
#slide[
  Test before each iteration. The body may run *zero times*.
  ```java
  while (condition) {
    // Statements
  }
  ```
]

#slide[
  #diagram("while", height: 270pt)
]

== do-while Loop
#slide[
  Test after each iteration. The body runs *at least once*.
  ```java
  do {
    // Statements
  } while (condition);
  ```
]

#slide[
  #diagram("do-while", height: 270pt)
]

== for Loop
#slide[
  Group initialization, condition, and update in one header.
  ```java
  for (int i = 0; i < 5; i++) {
    System.out.println(i);
  }
  ```
]

#slide[
  #diagram("for", height: 260pt)
  Init runs once. Update follows each completed iteration.
]

== Jump Statements
#slide[
  #diagram("jumps", height: 260pt)
  #text(21pt)[
    `break` exits the loop. `continue` skips the rest of its body.
    In a `for` loop, `continue` runs the update before testing again;
    in `while` and `do-while`, it goes to the condition.
  ]
]

#slide[
  #question[What does this print?]
  ```java
  for (int i = 0; i <= 4; i++) {
    if (i == 2) {
      break;
    }
    System.out.println("i = " + i);
  }
  ```
]

#slide[
  #question[What changes with continue?]
  ```java
  for (int i = 0; i <= 4; i++) {
    if (i == 2) {
      continue;
    }
    System.out.println("i = " + i);
  }
  ```
]

== Coding Style
#slide[
  - Open braces on the same line; indent the body consistently.
  - Put `else` on the same line as the preceding closing brace.
  ```java
  if (a > b) {
    maximum = a;
  } else {
    maximum = b;
  }
  ```
]

= License Notice
== Attribution
#slide[
  - Licensed under #link("https://creativecommons.org/licenses/by-nc-sa/4.0/")[CC BY-NC-SA 4.0].
  - Based on teaching material by Prof. Dr. Marc Hensel.
  - Text, illustrations, and layout have been adapted.
  - The original material was provided privately and cannot be linked here.
]
