#import "@preview/touying:0.5.2": *
#import themes.university: *

#import "@preview/fletcher:0.5.1" as flechter: diagram, edge, node

#import "@preview/gentle-clues:1.0.0": *
#import "@preview/pinit:0.2.0": *
#import "@preview/codly:1.0.0": *
#show: codly-init.with()

#import "@preview/numbly:0.1.0": numbly

#set text(lang: "en", font: ("Roboto", "JetBrainsMono NF"))
#set heading(numbering: numbly("{1}.", default: "1.1"))

#set align(left + top)

#show raw: it => {
  show regex("pin\d"): it => pin(eval(it.text.slice(3)))
  it
}
#let pinit-rect-from(height: 2em, pos: bottom, fill: rgb(0, 180, 255), point-pin, body) = {
  pinit-point-from(
    fill: fill,
    pin-dx: 0em,
    pin-dy: if pos == bottom { 0em } else { -0.6em },
    body-dx: 0pt,
    body-dy: if pos == bottom { -1.7em } else { -1.6em },
    offset-dx: 0em,
    offset-dy: if pos == bottom { 1.2em + height } else { -0.6em - height },
    point-pin,
    rect(
      inset: 0.5em,
      stroke: (bottom: 0.12em + fill),
      {
        set text(fill: fill)
        body
      },
    ),
  )
}
#show: university-theme.with(
  aspect-ratio: "16-9",
  config-info(
    title: [Object-Oriented Programming in Java],
    subtitle: [Lecture 2 - Imperative Concepts],
    author: [Emily Lucia Antosch],
    date: datetime.today().display("[day].[month].[year]"),
    institution: [HAW Hamburg],
  ),
)

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

#title-slide(authors: [Emily Lucia Antosch])

#outline(depth: 1)

= Introduction

== Where Are We Now?

#slide[
  - In the introduction, I gave you an overview of the topics for the
    upcoming lecture.
  - You have also written your first program in Java!

  - Today we'll cover *Imperative Concepts*.
]

#slide[
  1. *Imperative Concepts*
  2. Classes and Objects
  3. Class Library
  4. Inheritance
  5. Interfaces
  6. Graphical User Interfaces
  7. Exception Handling
  8. Input and Output
  9. Multithreading (Parallel Computing)
]

== The Goal of This Chapter
#slide[
  - We will discuss imperative concepts in programming with Java.
  - You will understand the simple data types in Java.
  - You will control program flow with control structures and loops.
  - You will apply the correct coding style.
]

= Simple Data Types
== Data Types and Memory
#slide[
  #question[How can a program remember its state?]
  #pause
  - Variables that store the state in the computer's memory.
  - The content of the memory on the computer is interpreted based on the *data type*.
  #figure(
    image("../assets/img/slides_2/20250730_memory_datastorage_rev01.png", height: 20%),
    caption: [Memory in the computer with values from the program],
  )
]

#slide[
  #question[Which data types do you already know from C?]
  #pause
  - *int*, *char*, *float*, *double*
  - *struct*, *enum*, *union*
  - *void*, *bool*
  - *Arrays with []* and *Pointers with \**
]

== Data Types in Java
#slide[
  The following data types are available in Java:
  #figure(
    image("../assets/img/slides_2/20250813_data_types_rev01.png", height: 79%),
    caption: [Data types in Java],
  )
]

#slide[
  - Memory sizes and the corresponding value ranges:
  #align(center + horizon)[
    #figure(
      table(
        columns: (auto, auto, auto, auto),
        inset: 10pt,
        align: left + horizon,
        fill: (x, y) => if calc.odd(y) and x > 0 { green.lighten(90%) },
        table.header([*Type*], [*Data Type*], [*Size*], [*Value*]),
        table.cell(rowspan: 4, "Integer"), [`byte`], [1 Byte], [$-2^7 "to" 2^7-1$],
        [`short`], [2 Byte], [$-2^15 "to" 2^15-1$],
        [`int`], [4 Byte], [$-2^31 "to" 2^31-1$],
        [`long`], [8 Byte], [$-2^63 "to" 2^63-1$],
        [Character], [`char`], [2 Byte], [$0 "to" 2^16-1$],
        table.cell(rowspan: 2, "Floating Point"), [`float`], [4 Byte], [],
        [`double`], [8 Byte], [],
        [Truth], [`boolean`], [1 Bit], [`true` or `false`],
      ),
      caption: [Value ranges of data types],
    )
  ]
]

== Declaration of Variables
#slide[
  #memo[Variables must be declared before they can be used.]
  - A data type is written before the variable name.
  - A declaration could look like this:
  ```java
  int a;
  float b;
  char c;
  ```
]

== Initialization of Variables
#slide[
  #memo[After declaration, a value can be assigned. This is called
    initialization.]
  - A value is assigned to the variable using the assignment operator ```=```:

  ```java
  a = 5;
  b = 3.5;
  c = 'A';
  ```
]

== Definition of Variables
#slide[
  #memo[Declaration and initialization can also be done in one step. This
    is then called definition.]
  ```java
  int a = 5;
  float b = 3.5;
  char c = 'A';
  ```
]

== Scope of Variables
#slide[
  - Variables have a scope that is defined by the curly braces.
  - Variables can be declared at any point in the code.
  - The compiler prevents the use of variables that have not been initialized.
]

== Type Correctness
#slide[
  - Types must be correct to avoid errors.
    - Unlike in C, values must be assigned to the correct data type.
    - The following would not work:
  ```java
  int a = 5;
  float b = apin1;
  ```
  #pinit-rect-from(height: 2em, pos: bottom, fill: rgb(0, 180, 255), 1)[Incorrect type]
]

#slide[
  #question[What differences do you see between C and Java when it comes to data types?]
  - No composite data types in Java.
  - No `unsigned` in Java.
  - Memory sizes are fixed and guaranteed.
  - Characters are encoded with 2 bytes.
    - 65,536 characters can be represented instead of 256.
]

== Literals
#slide[
  #memo[A *literal* is a constant, immutable number or string that
    appears directly in the code.]
  - So when you write a specific value directly in code, you use
    a literal.
  - This is then not represented by a variable.
]

#slide[
  #question[Why do you think the following code doesn't work?
    ```java
    float point = 3.1416;
    ```
  ]
  #pause
  - The number is a fixed floating-point number that is interpreted by Java as *double*.
  - Due to type correctness, the value is not stored in a *float* variable.
    The Java compiler gives an error.
]

#slide[
  #question[How would you correct the code?]
  #pause
  - You can write the value as a *float* literal:
  ```java
    float point = 3.1416f;
  ```
  - Alternatively, you can store the value in a *double* variable:
  ```java
    double point = 3.1416d;
  ```
]

== Constants
#slide[
  - We just had the example of the circle number $pi$.
  - In Java, there is the keyword ```final``` to define constants.
  - These can then no longer be changed.
  ```java
    final double PI = 3.1416;
  ```
  - After a constant has been declared, it can no longer be changed.
    The following code would therefore generate an error:

  ```java
    PI = 3;
  ```
]

== Creating Console Output
#slide[
  #task[
    We now want to create a console output:
    - Open IntelliJ IDEA and open or create a new executable
      class.
    - Try the following code:
    ```java
    int age = 24;
    System.out.println(24);
    System.out.println(age);
    ```
  ]
]

#slide[
  #text(size: 22pt)[
    #task[
      - Using the "+" operator, you can combine text and variables:

      ```java
      int age = 24;
      System.out.println("My age is " + 24);
      System.out.println("My age is " + age);
      ```
    ]
    #tip[
      - Type ```java sout``` in IntelliJ IDEA and press the
        Tab key. This saves time when writing ```java System.out.println()```!
    ]
  ]
]

== Coding Style
#slide[
  #text(size: 24pt)[
    #question[What is a *Coding Style*? What does the term tell you?]
    #pause
    - The coding style is a collection of rules that determine how code
      should be written.
    - Uniform code is easier to read and maintain.

    #memo[Compliance with the coding style will be evaluated in the exam!]
  ]
]

== Coding Style: Naming Conventions
#slide[
  #text(size: 24pt)[
    - All names, and this applies to all identifiers, should be written in English!
    - The following naming conventions should be followed:
      - Classes: *CamelCase*
      - Methods and variables: *camelCase*
      - Constants: *UPPER_CASE*
      - Packages: *lowercase*
    #tip[From my experience: Make your variables as meaningful as possible!
      Then the name can also be longer.]
  ]
]


= Comments and Identifiers
== Character Set
#slide[
  #text(size: 22pt)[
    - As already mentioned, Java uses the Unicode character set.
    - This means more characters are possible (65,536 to be exact).
    - So you can write your comments in German, English, or Chinese without major restrictions.
    - However, I would ask you to write your comments in *German* or *English*.

    #memo[Since your keyboard doesn't have 65,536 characters, you can also copy
      and paste the characters. Alternatively for #emoji.face.grin:
      ```java
      System.out.println("\u{1F600}");
      ```
    ]
  ]
]


== Comments
#slide[
  #question[What do you think about the following statement? Why are comments important?]
  #quotation[
    #quote(attribution: [Many Developers], block: true)[
      Make the code readable? Who else is supposed to read this?
    ]
  ]
]

#slide[
  - Comments are important for documenting code and improving
    maintainability.
  - Both users of the code and the developers will need to understand
    the code. Comments are essential for this.

  #memo[Not the quantity, but the quality of comments is crucial!
    Always comment directly while you are programming!]
]

#slide[
  #question[What is the difference between a *block comment* and a
    *line comment*?]
  #pause
  - *Line comments* start with ```//``` and end at the end of the line.
  - *Block comments* start with ```/*``` and end with ```*/```.
]

#slide[
  - Example of a line comment:
  ```java
    // This is a line comment
    int distance; // Euclidean distance between a and b
  ```
  - Example of a block comment:
  ```java
    /* The calculation of the Euclidean distance follows these steps:
     1. Calculate the difference of coordinates
     2. Square the difference
     ...  */
  ```
]

== Identifiers
#slide[
  #text(size: 24pt)[
    - All things that you name in Java are called *identifiers*. Many
      things you write need a name!

    #memo[
      - Follow these rules for identifiers:
        - Letters, numbers, underscores, and dollar signs are allowed.
        - The first character may not be a number.
        - Case sensitivity is observed.
        - No spaces or keywords.
        - Not the literals `true`, `false`, or `null`.
    ]
  ]
]

#slide[
  - All reserved keywords in Java:
  #align(center + horizon)[
    #table(
      columns: 4,
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
      `default`, `import`, `static`, ``,
      `do`, `instanceof`, `strictfp`, ``,
    )
  ]
]

#slide[
  #question[Which of the identifiers are allowed in your opinion and why?]
  ```java
    int length;
    int länge;
    int maxLength;
    int max_length;
    int _max_length;
    int max-length;
    int !maxLength;

    int 3dlength;
    String öpnvKosten;
    String €kosten;
    String kostenin€
    String €;
    int long;
    int c.o.s.t;
    String @cost;
  ```
]

= Operators
== Operators
#slide[
  - There are the usual arithmetic operators.
  - In general, operators are also evaluated from left to right.
  #text(size: 13pt)[
    #align(center + horizon)[
      #figure(
        table(
          columns: (auto, auto, auto, auto),
          inset: 10pt,
          align: left + horizon,
          fill: (_, y) => if calc.odd(y) { green.lighten(90%) },
          table.header([*Operator*], [*Name*], [*Example*], [*Priority*]),
          [`+`], [Prefix], [`a = 7`], [1],
          [`-`], [Prefix], [`a = -7`], [1],
          [`++`], [Increment], [`++count, count++`], [1],
          [`--`], [Decrement], [`--count, count--`], [1],
          [`*`], [Multiplication], [`area = length * width`], [2],
          [`/`], [Division], [`mean = sum / count`], [2],
          [`%`], [Modulo], [`11 % 4 (ergibt 3)`], [2],
          [`+`], [Addition], [`a = b + c`], [3],
          [`-`], [Substraction], [`a = b - c`], [3],
        ),
        caption: [Value ranges of data types],
      )
    ]
  ]
]

== Increment and Decrement
#slide[
  - There are also the same operators for incrementing and decrementing as in C.
  #text(size: 24pt)[
    #align(center + horizon)[
      #figure(
        table(
          columns: (auto, auto, auto, auto),
          inset: 10pt,
          align: left + horizon,
          fill: (_, y) => if calc.odd(y) { green.lighten(90%) },
          table.header([*Operator*], [*Type*], [*Value of Expression*], [*Change of a*]),
          [`++a`], [Prefix], [`a + 1`], [`a = a + 1`],
          [`a++`], [Postfix], [`a`], [`a = a + 1`],
          [`--a`], [Prefix], [`a - 7`], [`a = a - 1`],
          [`a--`], [Postfix], [`a`], [`a = a - 1`],
        ),
        caption: [Value ranges of data types],
      )
    ]
  ]
]

#slide[
  #question[Think about it: What will appear on the console here?]
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
  - There are also the same comparison operators as in C!

  #text(size: 24pt)[
    #align(center + horizon)[
      #figure(
        table(
          columns: (auto, auto, auto),
          inset: 10pt,
          align: left + horizon,
          fill: (_, y) => if calc.odd(y) { green.lighten(90%) },
          table.header([*Operator*], [*Name*], [*Priority*]),
          [`<`], [less than], [5],
          [`<=`], [less than or equal to], [5],
          [`>`], [larger than], [5],
          [`>=`], [larger than or equal to], [5],
          [`==`], [equal to], [6],
          [`!=`], [not equal to], [6],
        ),
        caption: [Value ranges of data types],
      )
    ]
  ]
]

#slide[
  #question[Think about it: What happens here?]

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
  - The result of logical operators is always a truth value, which is represented as `boolean` in Java.
  #text(size: 24pt)[
    #align(center + horizon)[
      #figure(
        table(
          columns: (auto, auto, auto),
          inset: 10pt,
          align: left + horizon,
          fill: (_, y) => if calc.odd(y) { green.lighten(90%) },
          table.header([*Operator*], [*Name*], [*Priority*]),
          [`!`], [NOT], [1],
          [`^`], [XOR], [8],
          [`&&`], [AND], [10],
          [`||`], [OR], [11],
        ),
        caption: [Value ranges of data types],
      )
    ]
  ]
  #memo[
    - With logical operators, the right operand is not executed if the
      result is already determined. In the following example, `a` is not evaluated.
    - Example: ```java (true || a)```
    - This is called *Short Circuit*.
    - This becomes interesting when the right operand is, for example, a function/method.
  ]
]
#slide[
  #question[Think about it again: What happens in the following code?]

  ```java
  int a = 3, b = 4;
  System.out.println((++a == b) || (a++ > b));
  System.out.println("a = " + a);
  ```
]

== Assignment Operators
#slide[
  - As in C, there are also assignment operators in Java. These can also be
    combined with other operators.
  - The placeholder `<op>` stands for `*, /, +` and `-`, among others.

  #text(size: 24pt)[
    #align(center + horizon)[
      #figure(
        table(
          columns: (auto, auto, auto),
          inset: 10pt,
          align: left + horizon,
          fill: (_, y) => if calc.odd(y) { green.lighten(90%) },
          table.header([*Operator*], [*Name*], [*Priority*]),
          [`=`], [Assignment], [13],
          [`<op>=`], [Combined Assignment:\ `a <op>= b <=> a = a <op> b`], [13],
        ),
        caption: [Value ranges of data types],
      )
    ]
  ]
]

#slide[
  #question[One last time: What happens in this code?]

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
== Type Conversion
#slide[
  - As a reminder: Type correctness prevents variables from getting a value
    that does not correspond to their data type.
  - This prevents errors and makes the code safer.

  #warning[However, a variable of type `int` does not fit into a variable of type `byte`.
    How can you still store the value from `int` in a `byte` variable?]

  #idea[You can simply write that you want this explicitly!]

  ```java
  int a = 80;
  byte b = (byte) a;
  System.out.println(b);
  ```
]

#slide[
  #question[What happens in the following code?]
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
  #question[
    What happens when you store the value `128` in a `byte` variable?
  ]
  #pause
  - Since the data type ```byte``` can only store values from `-128` to `127`,
    the value will overflow.
  - The result will be a negative number. In this case it will be `-128`.
]

== Implicit Type Conversion
#slide[
  #memo[
    - Principle of implicit type conversion:
      - No data loss when assigning from a smaller to a larger type.
      - The cast operator is not necessary.
      - Automatic conversion takes place.
  ]

  #example[
    - `short` (-32,768 to 32,767) fits into `int` (-2,147,483,648 to 2,147,483,647).
    ```java
    short a = 71;
    int b = (int) a;
    int c = a;
    ```
  ]
]

#slide[
  #question[
    Think about it: Which of the following lines will compile?
  ]
  ```java
  short a = 1024;
  long b = a;
  float c = b;
  ```
]

#slide[
  ```java
  char d = 'A';
  short e = d;
  int f = d;
  ```
]

#slide[
  #align(left + horizon)[
    #figure(
      image("../assets/img/slides_2/20250813_implizite_typkonvertierung_rev01.png"),
      caption: [Implicit type conversion in Java],
    )
  ]

  #memo[
    - Integer types `char` and `short` each have 2 bytes, but `char` is an
      *unsigned* data type.
      - Value range char: 0 to 65,535
      - Value range short: -32,768 to 32,767
    - Not all long values can be represented in float (potential data loss!).
  ]
]

= Control Structures
== if Statement
#slide[
  #memo[If statements are the simplest form of control structures. They allow
    statements to be executed only when a condition is met.]

  ```java
  if (condition) {
    statements
  }
  ```
]

#slide[
  - The condition must always be a `boolean`, unlike in C.
  - Statements are only executed when the condition is true (`true`).
  - With only one statement, the curly braces can be omitted.
  ```java
  int a = 4, b = 8;
    int maximum = a;

    if (b > maximum) {
      maximum = b;
    }
  ```
]

== if-else Statement
#slide[
  Using an `else` statement, you can specify a block that is executed
  when the condition is not met.

  ```java
  if (condition) {
        statements 1
      } else {
        statements 2
      }
  ```
]

#slide[
  Statement 2 in the above example is executed when the condition is `false`.

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
  For simple assignment using `if-else` statements, an expression in this
  form can be used:
  ```java
  (condition) ? expression 1 : expression 2;
  ```
  - Condition `true`: expression 1 is used
  - Condition `false`: expression 2 is used

  ```java
  int a = 4, b = 8;
  int maximum = (a > b) ? a : b;
  ```
]

== if-else Statement
#slide[
  #task[
    - Given is an integer `weekDay` between 1 and 7.
    - It corresponds to: 1 = Monday, 2 = Tuesday, 3 = Wednesday, etc.
    Generate the following console outputs depending on the value:
    - Monday to Friday: "Working"
    - Saturday: "Shopping"
    - Sunday: "Resting"
  ]

  #example[
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
]

== switch Statement
#slide[
  With the `switch` statement, `if-else` statements can be simplified.
  ```java
  switch (expression) {
      case value 1:
      statements
      break;
      case value 2:
      ...
      default:
      statements
      }
  ```
]

#slide[
  - Expression is e.g. an integer variable (except type `long`) or a `String` (from
    Java 7).
  - Statements, `break` and `default` are optional.
  - Multiple `case` labels directly in succession are allowed.
  - Jump to …
    - `case` label, if it has the value of the expression
    - `default`, if no matching `case` label
    - End of `switch` block, if no matching `case` label and no `default`
  - From `case` label or `default` continue until `break` or end of
    `switch` block
]

#slide[
  #task[Implement a solution for task 3 as a `switch` statement]
]

#slide[
  ```java
  switch (weekDay) {
    case 1:
    case 2:
    case 3:
    case 4:
    case 5:
        System.out.println("Working");
        break;
    case 6:
        System.out.println("Shopping");
        break;
    case 7:
        System.out.println("Resting");
        break;
    default:
        System.out.println("I don't know that day...");
    }
  ```
]

== while Loop
#slide[
  With the `while` loop, a statement is executed as long as the
  condition is `true`.

  ```java
  while (condition) {
        statements
      }
  ```
  - If the condition is already false at the beginning, the statement is never
    executed.
  - Also called a *head-controlled* or *rejecting* loop.
]

#slide[
  #align(left + horizon)[]
  #figure(
    image("../assets/img/slides_2/20250730_while_loop_condition_rev01.png", height: 90%),
    caption: [while-Schleife in Java],
  )
]

== do-while Loop
#slide[
  With the `do-while` loop, a statement is executed at least once.
  If the condition is `true`, the statement is executed again.

  ```java
  do {
        statements
      } while (condition);
  ```

  - Also called a *foot-controlled* or *non-rejecting* loop.

  #align(left + horizon)[
    #figure(
      image("../assets/img/slides_2/20250813_do_while_rev01.png", height: 90%),
      caption: [do-while-Schleife in Java],
    )
  ]
]

== for Loop
#slide[
  With the `for` loop, you can repeat a statement a certain number of times.

  ```java
  for (init; condition; update) {
        statements
      }
  ```

  - If condition is `false`, the statement is never executed.
  - Init is executed only once, but always.
  - Update is executed after each iteration.
  #align(left + horizon)[
    #figure(
      image("../assets/img/slides_2/20250813_for_loop_rev01.png", height: 70%),
      caption: [for-Schleife in Java],
    )
  ]
]

== Jump Statements
#slide[
  Using jump statements, you can control the program flow. `break` terminates
  the loop and `continue` jumps to the next loop iteration.

  #figure(
    image("../assets/img/slides_2/20250813_break_continue_rev01.png"),
    caption: [Visualisierung von break und continue in Java],
  )
]
#slide[
  #question[What happens in the following code?]
  ```java
  System.out.println("Break (when i == 2):");
  for (int i = 0; i <= 4; i++) {
    if (i == 2) {
      break;
    }
    System.out.println("  i = " + i);
  }
  ```
]

#slide[
  #question[What happens in the following code?]
  ```java
  System.out.println("\nContinue (when i == 2):");
  for (int i = 0; i <= 4; i++) {
    if (i == 2) {
      continue;
    }
    System.out.println("  i = " + i);
  }
  ```
]


== Coding Style
#slide[
  - As already mentioned, coding style is important. Therefore, there is also a coding style for
    control structures.

  - Opening curly braces are written on the same line as the
    control structure (this applies to all opening braces).
  - After a closing curly brace, a line break is made. With `else`, the
    closing brace is on the same line.

  #example[
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
]

= License Notice
== Attribution

- This work is shared under the CC BY-NC-SA 4.0 License and the respective Public
  License
- #link("https://creativecommons.org/licenses/by-nc-sa/4.0/")
- This work is based off of the work Prof. Dr. Marc Hensel.
- Some of the images and texts, as well as the layout were changed.
- The base material was supplied in private, therefore the link to the source
  cannot be shared with the audience.
