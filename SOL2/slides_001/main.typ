#import "@preview/touying:0.7.4": *
#import "diagrams.typ": diagram
#import "@preview/tiaoma:0.3.0"
#import "@preview/gentle-clues:1.3.1": *
#import "@preview/pinit:0.2.2": *
#import "@preview/codly:1.3.0": *
#show: codly-init.with()
#import "@preview/numbly:0.1.0": numbly
#import "../hestia/theme.typ": *

#set text(lang: "en")
#set heading(numbering: numbly("{1}.", default: "1.1"))

#show: hestia-theme.with(config-info(
  title: [Object-Oriented\ Programming in Java],
  short-title: [Java · Lecture 1],
  subtitle: [Lecture 1 — Organization and Introduction],
  author: [Emily Lucia Antosch],
  date: datetime.today().display("[day].[month].[year]"),
  institution: [HAW Hamburg],
))

#title-slide(authors: [Emily Lucia Antosch])

#slide[
  #text(34pt, weight: "semibold")[Today's route]
  #v(16pt)
  #set outline.entry(fill: none)
  #show outline.entry: it => block(inset: (y: 6pt), it)
  #outline(title: none, depth: 1)
]

= Organization

== What you'll know
#slide[
  #v(12pt)
  + *How the course works*\ Lectures, labs, preparation, and the exam.
  + *What you need*\ Prior knowledge and the software to install.
  + *How to reach me*\ Introductions and contact details.
]

== About me
#slide[
  #grid(
    columns: (1fr, 1fr),
    gutter: 36pt,
    [
      #text(32pt, weight: "semibold")[Emily Lucia Antosch]
      #v(8pt)
      Backend Software Engineer\ at MOIA · 25 years old
    ],
    [
      #text(22pt)[
        *B.Sc.* Electrical and Information Technology

        *M.Sc. in progress*\ Practical Computer Science
      ]
    ],
  )
  #v(20pt)
  #text(23pt)[#link("mailto:emilylucia.antosch@haw-hamburg.de")[emilylucia.antosch\@haw-hamburg.de]]
  #v(12pt)
  #info[I'm new to university teaching. Please be patient with me.]
]

== Course schedule
#slide[
  #text(38pt, weight: "semibold")[Wednesdays · 15:55–19:15]
  #v(16pt)
  - The early sessions prepare you for the labs.
  - Take part in short questions and code-along exercises.
  #v(12pt)
  #memo[Ask as soon as something is unclear. I'm happy to explain it again.]
]

== Laboratory sessions
#slide[
  #grid(
    columns: (1fr, 1fr),
    gutter: 28pt,
    stack(spacing: 12pt, text(62pt, fill: palette.green)[4], [labs this semester]),
    stack(spacing: 12pt, text(62pt, fill: palette.green)[2], [people per team]),
  )
  #v(28pt)
  #warning[Successful lab participation is mandatory. Without it, you cannot take the exam.]
]

== Prepare before each lab
#slide[
  - There will be detailed instructions coming from the lab lecturers soon!
  - You will work through some tasks at home, and some tasks will be done in session.
  - If you get stuck, be ready to explain your approach and what the task asks for.
  - Lab lecturers will help you finish the parts you could not complete.
  #v(12pt)
  #memo[Bring questions, not blank pages.]
]

== Present your work
#slide[
  #text(32pt, weight: "semibold")[Present at least two tasks this semester.]
  #v(16pt)
  - You may not get to choose which tasks you present.
  - Be ready to present any task you have worked on.
  #v(12pt)
  #tip[Start early. Don't leave both presentations until the last lab.]
]

== What we'll build on
#slide[
  - Use your prior programming knowledge to write simple Java programs.
  - Learn object-oriented programming and compare it with other paradigms.
  #v(28pt)
  #text(22pt, fill: palette.muted)[The module handbook contains the full course description.]
]

== Set up your tools
#two-column-slide[
  #text(32pt, weight: "semibold")[Java SDK]
  #v(14pt)
  Install the Java development tools.

  The setup guide is in the Moodle room.
][
  #text(32pt, weight: "semibold")[IntelliJ IDEA]
  #v(14pt)
  We'll use JetBrains' IDE throughout the course.

  I recommend it for beginners.
]

= Introduction

== What you'll learn
#slide[
  + *Connect old and new concepts*\ Build on your previous programming lectures.
  + *Think in objects*\ Understand classes and how this approach differs from C.
  + *Run a Java program*\ Create and execute a program in IntelliJ IDEA.
]

== Start with the fundamentals
#slide[
  #enum(
    [*Imperative concepts*],
    [*Classes and objects*],
    [*Class library*],
    [*Inheritance*],
    [*Interfaces*],
  )
]

== Then extend the toolkit
#slide[
  #enum(
    start: 6,
    [*Graphical user interfaces*],
    [*Exception handling*],
    [*Input and output*],
    [*Multithreading* — parallel computing],
  )
]

== Objects and classes
#slide[
  #grid(
    columns: 1,
    rows: (auto, 1fr, auto),
    gutter: 12pt,
    [We describe things through their properties.],
    align(center + horizon, diagram("car")),
    idea[Object-oriented programming brings this way of thinking into code.],
  )
]

#slide[
  #question[Which properties describe a person? Which would a program need?]
  #v(18pt)
  #pause
  #grid(
    columns: (1fr, 1fr),
    gutter: 36pt,
    [*Student record*\ Name, address, student ID], [*Website account*\ Username, password, join date],
  )
]

#slide[
  #text(32pt, weight: "semibold")[One blueprint. Many objects.]
  #v(16pt)
  - A *class* defines the properties as variables.
  - Each *object* has its own values for those properties.
  #v(12pt)
  #example[The *Student* class can describe both *Max* and *Ines*: different names, different student IDs.]
]

#diagram-slide[
  #figure(diagram("class-objects"), caption: [One class describes multiple objects])
]

#slide[
  A class brings variables and functions together.
  #v(22pt)
  #grid(
    columns: (1fr, 2fr),
    column-gutter: 32pt,
    row-gutter: 22pt,
    [*Attributes*], [Variables that store the object's data.],
    [*State*], [The current values of those attributes.],
    [*Methods*], [Functions that read or change those values.],
  )
]

#diagram-slide[
  *UML class diagrams* describe attributes and methods.
][
  #figure(diagram("attributes-methods"), caption: [A UML class diagram for Person])
]

== Data encapsulation
#diagram-slide[
  Methods control access to an object's attributes.
][
  #figure(diagram("encapsulation"), caption: [Access data through the class's methods])<data-encapsulation>
]

#slide[
  #text(32pt, weight: "semibold")[Protect the object's state.]
  #v(24pt)
  - Encapsulated data is not directly accessible to every part of the program.
  - Methods can check values before changing an attribute.
  - This prevents invalid state and unintended access.
]

#slide[
  #question[How does this differ from a struct in C?]
  #v(18pt)
  #pause
  - Direct field access requires the struct definition to be visible.
  - A public struct does not protect its data.
  - The data and the functions are not combined into a class.
]

== Inheritance
#diagram-slide[
  Derive a new class from a base class: reuse its attributes and methods, then extend it without duplicating code.
][
  #figure(diagram("inheritance"))
]

== Composition
#diagram-slide[
  Build classes from other classes: a *House* contains *Windows*, *Walls*, and *Doors*.
][
  #figure(diagram("composition"), caption: [Composition is a strong whole–part relationship])
]

== Program execution in Java
#slide[
  + Execution starts in the static *main* method.
  + It creates objects and stores their *references* in variables.
  + Use those references to access the objects.
  + Objects can create other objects and call their methods.
  + In our single-threaded example, execution ends when *main* returns.
]

#diagram-slide[
  #figure(diagram("references"), caption: [References connect objects during execution])
]

= The Java Programming Language

== Java vs. C
#callout-slide[
  #task[
    Write these in *C*:
    - Sum the numbers 1 to n with a *for* loop.
    - Find the larger of two numbers with *if*.
    - Put that comparison in a *getMax()* function.
  ]
]

#diagram-slide[
  Java's control flow and syntax will look familiar from C and C++. We'll build on what you already know.
][
  #figure(diagram("java-origins"), caption: [Influences on the Java programming language])
]

== Compilation
#two-column-slide[
  #text(32pt, weight: "semibold")[1. Develop]
  #v(18pt)
  Write source code on your PC.

  The compiler turns it into *bytecode*.
][
  #text(32pt, weight: "semibold")[2. Execute]
  #v(18pt)
  The *JVM* (Java Virtual Machine) runs the bytecode.

  No recompilation for each target platform.
]

#diagram-slide[
  #figure(diagram("jvm"), caption: [Compile once; run bytecode on each platform's JVM])
]

#two-column-slide[
  #text(32pt, weight: "semibold")[Compiled]
  #v(18pt)
  Recompile the source for each target platform.
][
  #text(32pt, weight: "semibold")[Interpreted]
  #v(18pt)
  Run the source with an interpreter on the target platform.
]

#diagram-slide[
  #figure(diagram("interpreted"), caption: [Execution of interpreted languages])
]

#diagram-slide[
  #figure(diagram("compiled"), caption: [Execution of compiled languages])
]

== Properties of Java
#slide[
  #question[What would you want from a new language? What would you change about C/C++?]
  #v(14pt)
  #pause
  - *Object-oriented* — classes, objects, inheritance
  - *Platform-independent* — the JVM
  - *Strongly typed* — types such as int and String
  - *Automatic memory management* — the garbage collector
]

#callout-slide[
  #text(font: "Libertinus Serif", size: 48pt)[Which is the better language?]
  #v(22pt)
  #text(40pt, fill: palette.green)[C or Java?]
]

= The First Program

== Your development environment
#sidebar-slide[
  *IntelliJ IDEA* is the IDE we'll use in class and in the exam.

  It can set up the Java JDK you need to program.

  #link("https://www.jetbrains.com/idea/download/?section=windows")[Download IntelliJ IDEA] or scan the code. Choose the Community Edition.
][
  #align(center + horizon)[
    #tiaoma.barcode("https://www.jetbrains.com/idea/download/?section=windows", "QRCode", options: (scale: 3.0))
  ]
]

#diagram-slide[
  #figure(diagram("toolchain"), caption: [The structure of the Java Toolchain])
]

#slide[
  #task[
    *Prepare:* choose a directory for your files and open IntelliJ IDEA.

    + Select *File > New > Project*.
    + Give the project a name and location.
    + Choose *Java*, *IntelliJ*, and the appropriate *JDK*.
    + Click *Create*.
  ]
]

#slide[
  #task[
    #grid(
      columns: (1fr, 1fr),
      gutter: 32pt,
      [
        *Create a package*
        + Right-click *src*.
        + Select *New > Package*.
        + Enter a name.
      ],
      [
        *Create a class*
        + Right-click the package.
        + Select *New > Java Class*.
      ],
    )
  ]
]

== The first program
#code-slide[
  #v(22pt)
  ```java
  public static void main(String[] args) {
    System.out.println("Hello World!");
  }
  ```
  #v(18pt)
  #idea[Enter this method inside the class you just created. Ready already? Code along.]
]

== Applications in Java
#slide[
  #grid(
    columns: (1fr, 2fr),
    column-gutter: 30pt,
    row-gutter: 24pt,
    [*Public class*], [```java public class MyApplication {...}```],
    [*Matching filename*], [`MyApplication.java`],
    [*Entry point*], [```java public static void main(String[] args)```],
  )
]

#code-slide[
  #v(3.5em)
  ```java
  public class pin1MyApplipin3cationpin2 {
    public static void pin4mapin5in(String[] args) {
      System.out.println("Hello World!");
    }
  }
  ```
  #pause
  #pinit-rect-from(3, pos: top)[This name is freely selectable.]
  #pause
  #pinit-rect-from(5, pos: bottom, fill: palette.instance)[This method must always be called main.]
]

= Literature

== Read further
#two-column-slide[
  #text(20pt, fill: palette.muted)[D. Abts]
  #v(14pt)
  #text(32pt, weight: "semibold")[Grundkurs JAVA]
  #v(14pt)
  Springer-Vieweg
][
  #text(20pt, fill: palette.muted)[H.-P. Habelitz]
  #v(14pt)
  #text(32pt, weight: "semibold")[Programmieren lernen mit Java]
  #v(14pt)
  Rheinwerk Computing
]

= License Notice

== Attribution
#slide[
  *CC BY-NC-SA 4.0* and its Public License\
  #link("https://creativecommons.org/licenses/by-nc-sa/4.0/")
  #v(22pt)
  Based on material by *Prof. Dr. Marc Hensel*.\
  Some images, text, and the layout have been changed.
  #v(16pt)
  #text(
    22pt,
    fill: palette.muted,
  )[The source material was supplied privately. Its link cannot be shared with the audience.]
]
