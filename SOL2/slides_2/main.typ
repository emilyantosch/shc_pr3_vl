#import "@preview/touying:0.5.2": *
#import themes.university: *

#import "@preview/fletcher:0.5.1" as flechter: diagram, node, edge

#import "@preview/gentle-clues:1.0.0": *
#import "@preview/pinit:0.2.0": *
#import "@preview/codly:1.0.0": *
#show: codly-init.with()

#import "@preview/numbly:0.1.0": numbly

#set text(lang: "en", font: "Roboto")
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

- In the introduction, I gave you an overview of the topics for the
  upcoming lecture.
- You have also written your first program in Java!

- Today we'll cover *Imperative Concepts*.

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

- We will discuss imperative concepts in programming with Java.
- You will understand the simple data types in Java.
- You will control program flow with control structures and loops.
- You will apply the correct coding style.

= Simple Data Types

== Data Types and Memory

#slide[
  #question[How can a program remember its state?]

  #pause

  - Variables that store the state in the computer's memory.
  - The content of the memory on the computer is interpreted based on the *data type*.

  #figure(
    image("../assets/img/2024_10_06_data_storage_rev01.png", height: 25%),
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
  The following data structures are available in Java:

  #figure(
    image("../assets/img/2024_10_06_data_types_java_rev01.png", height: 70%),
    caption: [Data types in Java],
  )
]

#slide[
  - Memory sizes and the corresponding value ranges:

  #figure(
    image("../assets/img/2024_10_06_data_types_ranges_java_rev01.png"),
    caption: [Value ranges of data types in Java],
  )
]
== Declaration of Variables

#memo[Variables must be declared before they can be used.]
- A data type is written before the variable name.
- A declaration could look like this:
```java
int a;
float b;
char c;
```

== Initialization of Variables
#memo[After declaration, a value can be assigned. This is called
  initialization.]
- A value is assigned to the variable using the assignment operator ```=```:

```java
a = 5;
b = 3.5;
c = 'A';
```

== Definition of Variables
#memo[Declaration and initialization can also be done in one step. This
  is then called definition.]

- Beide Schritte werden direkt hintereinander geschreiben.
- Deklaration und Initialisierung (Definition):
```java
int a = 5;
float b = 3.5;
char c = 'A';
```
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
  - Zeichen werden mit 2 Byte kodiert.
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

== Coding Style

#question[What is a *Coding Style*? What does the term tell you?]

#pause
- The coding style is a collection of rules that determine how code
  should be written.
- Uniform code is easier to read and maintain.

#memo[Compliance with the coding style will be evaluated in the exam!]

== Coding Style: Naming Conventions

- All names, and this applies to all identifiers, should be written in English!
- The following naming conventions should be followed:
  - Classes: *CamelCase*
  - Methods and variables: *camelCase*
  - Constants: *UPPER_CASE*
  - Packages: *lowercase*

#tip[From my experience: Make your variables as meaningful as possible!
  Then the name can also be longer.]

= Comments and Identifiers

== Character Set

- As already mentioned, Java uses the Unicode character set.
- This means more characters are possible (65,536 to be exact).
- So you can write your comments in German, English,
  or Chinese without major restrictions.
- However, I would ask you to write your comments in *German* or *English*.

#memo[Since your keyboard doesn't have 65,536 characters, you can also copy
  and paste the characters. Alternatively for #emoji.face.grin:
  ```java
  System.out.println("\u{1F600}");
  ```
]

== Comments

#slide[

  #question[What do you think about the following statement? Why are comments important?]
  #quotation[
    #quote(attribution: [Many Developers], block: true)[
      Make the code readable? Who else is supposed to read it?
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

- There are the usual arithmetic operators.
- In general, operators are also evaluated from left to right.

#figure(
  image("../assets/img/2024_10_08_arithmetische_operatoren_java_rev01.png"),
  caption: [Arithmetic operators in Java],
)

== Increment and Decrement

#slide[
  - There are also the same operators for incrementing and decrementing as
    in C.

    #figure(
      image("../assets/img/2024_10_08_increment_decrement_operatoren_rev01.png"),
      caption: [Operators for increment and decrement in Java],
    )
]

#slide[
  #question[Think about it: What will appear on the console here?]

  ```java
  int a = 1;
  System.out.println("a   : " + a);
  System.out.println("++a : " + ++a);
  System.out.println("a++ : " + a++);
  System.out.println("--a : " + --a);
  System.out.println("a-- : " + a--);
  ```

]

== Comparison Operators

- Es gibt auch die gleichen Vergleichsoperatoren wie in C!

#figure(
  image("../assets/img/2024_10_08_boolean_operatoren_rev01.png"),
  caption: [Vergleichsoperatoren in Java],
)

#slide[
  #question[Zum Mitdenken: Was passiert hier?]

  ```java
  int a = 7, b = 4;
  boolean parentheses = (a > b) == (a <= b);
  boolean priorities = a > b == a <= b;
  System.out.println(parentheses);
  System.out.println(priorities);
  ```
]

== Logical Operators

- Das Ergebnis der logischen Operatoren ist immer ein Wahrheitswert, der in Java
  als
  `boolean` dargestellt wird.

#figure(
  image("../assets/img/2024_10_09_logische_operatoren_rev01.png"),
  caption: [Logische Operatoren in Java],
)

#memo[
  - Bei den logischen Operatoren wird der rechte Operand nicht ausgeführt, wenn das
    Ergebnis bereits feststeht. Im folgenden Beispiel wird `a` nicht ausgewertet.
  - Beispiel: ```java (true || a)```
  - Das nennt man dann *Short Circuit*.
  - Wird dann interessant, wenn der rechte Operand bspw. eine Funktion/Methode ist.
]

#question[Wieder zum Mitdenken: Was passiert im folgenden Code?]

```java
int a = 3, b = 4;
System.out.println((++a == b) || (a++ > b));
System.out.println("a = " + a);
```

== Assignment Operators

- Wie in C gitb es auch in Java Zuweisungsoperatoren. Diese können auch mit
  anderen Operatoren kombiniert werden.
- Der Platzhalter `<op>` steht unter anderem für `*, /, +` und `-`.

#figure(
  image("../assets/img/2024_10_09_zuweisungs_operatoren_rev01.png"),
  caption: [Zuweisungsoperatoren in Java],
)

#question[Ein letztes Mal: Was passiert in diesem Code?]

```java
int a = 1;
a += 2;
System.out.println(a);
System.out.println(a *= --a);
System.out.println(a *= -a++);
System.out.println(a /= 10);
```

= Type Conversion

== Type Conversion
- Zur Erinnerung: Typkorrektheit verhindert, dass Variablen einen Wert bekommen,
  der nicht ihrem Datentyp entspricht.
- Das verhindert Fehler und macht den Code sicherer.

#warning[Eine Variable, die vom Typ `int` ist passt allerdings in eine Variable vom Typ `byte`.
  Wie können Sie den Wert in `byte` von trotzdem in eine `int` Variable speichern?]

#idea[Sie können einfach schreiben, dass Sie das explizit wollen!]

```java
int a = 80;
byte b = (byte) a;
System.out.println(b);
```

#slide[
  #question[Was passiert in dem folgenden Code?]

  ```java
  double a = 128.38;
  int b = (int) a;
  byte c = (byte) a;
  System.out.println("double: " + a);
  System.out.println("int   : " + b);
  System.out.println("byte  : " + c);
  ```
]

#question[
  Was passiert, wenn Sie den Wert von `128` in eine `byte` Variable speichern?
]

#pause

- Da der Datentyp ```byte``` nur Werte von `-128` bis `127` speichern kann, wird
  der Wert überlaufen.
- Das Ergebnis wird eine negative Zahl sein. In diesem Fall wird es `-128` sein.

== Implicit Type Conversion

#memo[
  - Prinzip der impliziten Typkonvertierung:
    - Kein Datenverlust bei Zuweisung von einem kleineren in einen größeren Typ.
    - Der Cast-Operator ist nicht notwendig.
    - Es erfolgt eine automatische Konvertierung.
]

#example[
  - `short` (-32.768 bis 32.767) passt in `int` (-2.147.483.648 bis 2.147.483.647).
  ```java
  short a = 71;
  int b = (int) a;
  int c = a;
  ```
]

#question[
  Zum Mitdenken: Welche der folgenden Zeilen werden kompilieren?
]
```java
short a = 1024;
long b = a;
float c = b;
```
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
      image("../assets/img/2024_10_09_implizite_typkonvertierung_rev01.png"),
      caption: [Implizite Typkonvertierung in Java],
    )
  ]

  #memo[
    - Ganzzahlen `char` und `short` besitzen jeweils 2 Byte, `char` ist aber ein
      *unsigned* Datentyp.
      - Wertebereich char: 0 bis 65.535
      - Wertebereich short: -32.768 bis 32.767
    - Nicht alle long-Werte in float darstellbar (Potenzieller Datenverlust!).
  ]
]

= Control Structures

== if Statement

#memo[If-Anweisungen sind die einfachste Form der Kontrollstrukturen. Sie erlauben es,
  Anweisungen nur auszuführen, wenn eine Bedingung erfüllt ist.]

```java
if (Bedingung) {
  Anweisungen
}
```
#slide[
  - Die Bedingung muss, anders als in C, immer ein `boolean` sein.
  - Anwesungen werden nur ausgeführt, wenn die Bedingung wahr (`true`) ist.
  - Bei nur einer Anweisung können die geschweiften Klammern weggelassen werden.
  ```java
  int a = 4, b = 8;
    int maximum = a;

    if (b > maximum) {
      maximum = b;
    }
  ```
]

== if-else Statement

Mittels einer `else`-Anweisung kann ein Block angegeben werden, der ausgeführt
wird, wenn die Bedingung nicht erfüllt ist.

```java
if (Bedingung) {
      Anweisungen 1
    } else {
      Anweisungen 2
    }
```

#slide[
  Die Anweisung 2 im obigen Beispiel wird eben ausgeführt, wenn die Bedingung `false` ist.

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

Für einfache Zuweisung mittels `if-else`-Anweisungen kann ein Ausdruck in dieser
Form verwendet werden:
```java
(Bedingung) ? Ausdruck 1 : Ausdruck 2;
```
- Bedinung `true`: Ausdruck 1 wird eingesetzt
- Bedingung `false`: Ausdruck 2 wird eingesetzt

```java
int a = 4, b = 8;
int maximum = (a > b) ? a : b;
```

== if-else Statement

#task[
  - Gegeben ist eine Ganzzahl `weekDay` zwischen 1 und 7.
  - Es entspricht: 1 = Montag, 2 = Dienstag, 3 = Mittwoch usw.
  Erzeugen Sie in Abhängigkeit des Wertes folgende Konsolenausgaben:
  - Montag bis Freitag: "Arbeiten"
  - Samstag: "Einkaufen"
  - Sonntag: "Ausruhen"
]

#example[
  ```java
  byte weekDay = 3;

    if (weekDay <= 5) {
      System.out.println("Arbeiten");
    } else if (weekDay == 6) {
      System.out.println("Einkaufen");
    } else if (weekDay == 7) {
      System.out.println("Ausruhen");
    }
  ```
]

== switch Statement
Mit der `switch`-Anweisung lassen sich `if-else`-Anweisungen vereinfachen.
```java
switch (Ausdruck) {
    case Wert 1:
    Anweisungen
    break;
    case Wert 2:
    ...
    default:
    Anweisungen
    }
```
#slide[

  - Ausdruck ist z.B. eine ganzzahlige Variable (außer Typ `long`) oder ein `String` (ab
    Java 7).
  - Anweisungen, `break` und `default` sind optional.
  - Mehrere `case`-Sprungmarken direkt hintereinander sind erlaubt.
  - Sprung zu …
    - `case`-Sprungmarke, falls diese den Wert von Ausdruck hat
    - `default`, falls keine passende `case`-Sprungmarke
    - Ende des `switch`-Blocks, falls keine passende `case`-Sprungmarke und kein `default`
  - Von `case`-Sprungmarke oder `default` weiter bis `break` oder Ende des
    `switch`-Blocks
]

#slide[
  #task[Implementieren Sie eine Lösung für die Aufgabe 3 als `switch`-Anweisung]
]
#slide[
  ```java
  switch (weekDay) {
    case 1:
    case 2:
    case 3:
    case 4:
    case 5:
        System.out.println("Arbeiten");
        break;
    case 6:
        System.out.println("Einkaufen");
        break;
    case 7:
        System.out.println("Ausruhen");
        break;
    default:
        System.out.println("Den Tag kenn' ich nicht ...");
    }
  ```
]

== while Loop

Mit der `while`-Schleife wird eine Anweisung so lange ausgeführt, wie die
Bedingung `true` ist.

```java
while (Bedingung) {
      Anweisungen
    }
```

- Falls die Bedingung zu Beginn bereits false ist, wird die Anweisung nie
  ausgeführt.
- Auch *kopfgesteuerte* oder *abweisende* Schleife genannt.

#slide[
  #align(left + horizon)[]
  #figure(
    image("../assets/img/2024_10_09_while_loop_rev01.png"),
    caption: [while-Schleife in Java],
  )
]

== do-while Loop

Mit der `do-while`-Schleife wird eine Anweisung mindestens einmal ausgeführt.
Wenn die Bedingung `true` ist, wird die Anweisung wieder ausgeführt.

```java
do {
      Anweisungen
    } while (Bedingung);
```

- Auch *fußgesteuerte* oder *nicht abweisende* Schleife genannt.

#align(left + horizon)[
  #figure(
    image("../assets/img/2024_10_09_dowhile_loop_rev01.png"),
    caption: [do-while-Schleife in Java],
  )
]

== for Loop

Mit der `for`-Schleife können Sie eine Anweisung eine bestimmte Anzahl von Malen
wiederholen.

```java
for (Init; Bedingung; Update) {
      Anweisungen
    }
```

- Falls Bedingung `false` ist, wird die Anweisung nie ausgeführt.
- Init wird nur einmal ausgeführt, dafür aber immer.
- Update wird nach jeder Iteration ausgeführt.
#align(left + horizon)[
  #figure(
    image("../assets/img/2024_10_09_for_loop_rev01.png"),
    caption: [for-Schleife in Java],
  )
]

== Jump Statements

Mittels Sprunganweisungen können Sie den Programmfluss steuern. `break` beendet
die Schleife und `continue` springt zum nächsten Schleifendurchlauf.

#figure(
  image("../assets/img/2024_10_09_break_continue_loop_rev01.png"),
  caption: [Visualisierung von break und continue in Java],
)

#question[Was passiert in dem folgenden Code?]
```java
System.out.println("Break (bei i == 2):");
for (int i = 0; i <= 4; i++) {
  if (i == 2) {
    break;
  }
  System.out.println("  i = " + i);
}
```

#question[Was passiert in dem folgenden Code?]
```java
System.out.println("\nContinue (bei i == 2):");
for (int i = 0; i <= 4; i++) {
  if (i == 2) {
    continue;
  }
  System.out.println("  i = " + i);
}
```

== Coding Style

- Wie bereits erwähnt, ist der Coding Style wichtig. Daher gibt es bei den
  Kontrollstrukturen auch einen Coding Style.

- Öffnende geschweifte Klammern werden in der gleichen Zeile wie die
  Kontrollstruktur geschrieben (das gilt für alle öffnenden Klammern).
- Nach einer schließenden geschweiften Klammer wird ein Zeilenumbruch gemacht. Bei `else` steht
  die schließende Klammer in der gleichen Zeile.

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

= License Notice

== Attribution

- This work is shared under the CC BY-NC-SA 4.0 License and the respective Public
  License
- #link("https://creativecommons.org/licenses/by-nc-sa/4.0/")
- This work is based off of the work Prof. Dr. Marc Hensel.
- Some of the images and texts, as well as the layout were changed.
- The base material was supplied in private, therefore the link to the source
  cannot be shared with the audience.
