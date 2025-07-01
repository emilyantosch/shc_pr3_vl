#import "@preview/touying:0.5.2": *
#import themes.university: *

#import "@preview/fletcher:0.5.1" as flechter: diagram, node, edge

#import "@preview/tiaoma:0.2.1"

#import "@preview/gentle-clues:1.0.0": *
#import "@preview/pinit:0.2.0": *
#import "@preview/codly:1.0.0": *
#show: codly-init.with()

#import "@preview/numbly:0.1.0": numbly

#set text(lang: "en")
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
    subtitle: [Lecture 1 - Organization and Introduction],
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

= Organization

== The Goal of This Chapter

- I want to introduce myself to you and discuss the course structure of this module.
- You will get an overview of the prerequisites for this module and will be able to
  meet them.
- You will know how to reach me.

== About Me

- Emily Lucia Antosch, 24 years old
- Bachelor's degree in Electrical and Information Technology
- Currently working as an application developer at NVL
- Next step: Master's degree in Computer Science
- Email: emilylucia.antosch\@haw-hamburg.de

#info[I'm doing this for the first time, so please be patient with me.]
== Course Schedule

- Lectures are divided into sessions on Tuesdays and Thursdays.
  - At the beginning, there are many sessions designed to prepare you for the practicum.
- I would ask you to actively participate in the lectures.
- There will be small questions and tasks that you can answer live and
  code along with.

#memo[If you don't understand something, please ask immediately! I'm happy to
  repeat content in German or English!]

== Lecture Focus

- We want to build a bridge from your prior knowledge.
- By the end of the lecture, you should be able to create simple programs
  in Java.
- Additionally, you should then master object-oriented programming and be able to
  highlight the differences to other programming paradigms.
- You can also read about the exact content outside of the lecture in the module
  handbook.

== Prerequisites

- You need an installation of the *Java SDK*.
  - For this, I have written a guide that you can find in the Moodle room or
    SHCneo room.
- Additionally, the lecture will use the tool *JetBrains IntelliJ*.
  - This is, in my opinion, a very good and simple IDE for beginners.
  - You will also find a guide for this in Moodle.

= Introduction

== The Goal of This Chapter

- You should apply your existing knowledge from previous lectures to new content.
- You will know the fundamental ideas of object-oriented programming and
  understand the difference from programming in C.
- We will create a simple program in the IntelliJ IDEA development environment
  and execute it.

== Topic Overview: Fundamentals

The first lectures focus on the following principles:

1. Imperative Concepts
2. Classes and Objects
3. Class Library
4. Inheritance
5. Interfaces

== Topic Overview: Advanced Concepts

From the fundamentals, we then want to derive further concepts:

6. Graphical User Interfaces
7. Exception Handling
8. Input and Output
9. Multithreading (Parallel Computing)

== Objects and Classes

In the real world, things are often determined and described by their properties:

- A car has properties such as
  - a manufacturer
  - a color
  - fuel consumption

#idea[Using object-oriented programming, we can apply this intuitive
  approach to programming as well!]
#slide[

  #question[What properties could you use to describe a person, for example? How
    might this fit into the programming context?]

  #pause
  - For students:
    - Name, address, student ID number
  - For programs/websites:
    - Username, password, join date
]

- To create multiple similar objects from this similar blueprint,
  a class is created,
  - It contains all the properties we just defined, for example
    variables.
  - From it, completely different objects can be created that have these properties
    filled differently.

#example[From the *Student* class, for example, the two students *Max* and
  *Ines* can be created, who both have different names and their own
  student ID number.]
#slide[
  #align(center + horizon)[
    #figure(
      diagram(
        spacing: (100mm, 40mm),
        node-stroke: luma(80%),
        node((0.5, 0), [*Person Class*], name: <d>),
        node((0, 1), [*Ines*], name: <n>),
        node((1, 1), [*Max*], name: <e>),
        edge(<d>, ((), "|-", (0, 0.5)), ((), "-|", <n>), <n>, "-|>"),
        edge(<d>, ((), "|-", (0, 0.5)), ((), "-|", <e>), <e>, "-|>"),
        edge(
          <e>,
          "<|-|>",
          <n>,
          stroke: teal,
          label: text(teal)[Same class, different object],
          left,
        ),
        edge(
          (rel: (-25pt, 0pt), to: <n>),
          <d>,
          "-|>",
          bend: 40deg,
          stroke: orange,
          text(orange)[Object of the class],
          label-angle: auto,
        ),
      ),
      caption: [Relationship between classes and objects of that class],
    )
  ]
]

- Variables and functions are thus combined into a class.
  - A set of variables is defined.
  - For these variables, functions are introduced that can read and
    modify them.

#memo[
  - Variables are called *attributes*.
  - The values of these variables describe the *state* of the object.
  - Functions are called *methods*.
]

- So-called UML class diagrams can be used to describe classes with their *attributes*
  and *methods*.

#figure(
  image("../assets/img/2024_10_03_class_person_explain_rev01.png"),
  caption: [UML Class Diagram],
)

== Data Encapsulation

- Data can be encapsulated using attributes and methods of classes.

#figure(
  image("./../assets/img/2024_10_03_data_capsulation_rev01.png", width: 80%),
  caption: [Data encapsulation through classes],
)<data-capsule>

- Data can be encapsulated using attributes and methods of classes.
  - Not all parts of the program can access encapsulated data, which increases
    security.
  - Additionally, attributes can be protected from erroneous values this way.

#slide[
  #figure(image("../assets/img/2024_10_04_data_capsulation_checks_rev01.png"))
]

#slide[
  #question[How is this different in C?]

  #pause
  - The data structure (i.e., the *struct*) must be made public for access to
    the elements.
  - The data is not protected.
  - There is no association between the data and the functions.
]

== Inheritance

#slide[
  - Through inheritance, new classes can be created from other classes.

  #figure(image("../assets/img/2024_10_04_class_inheritance_rev01.png", width: 35%))

]

#slide[
  - Through inheritance, new classes can be created from other classes.
  - The methods and attributes of the base class are inherited and extended with
    additional code.
  - No duplicated code.
]

#matrix-slide[
  #align(left + top)[
    - Classes can also be composed of other classes.
    - This is called *composition*.
    - For example, the *House* class would be composed of
      *Windows*, *Walls*, and *Doors*.

  ]
][
  #figure(
    image("../assets/img/2024_10_04_class_composition_rev01.png", height: 80%),
    caption: [Composition of the *House* class, which inherits from *Building*],
  )
]

== Program Execution in Java

1. At program startup, a special *main* method is executed in the _main object_.
2. In this method, objects are created and the *references* to these
  objects are stored in variables.
3. These variables can then be used to access the respective object.
4. Objects in the program can then create additional objects and
  call methods.
5. As soon as the *main* method is finished, the program ends.

#figure(
  image("../assets/img/2024_10_05_references_java_program_rev01.png"),
  caption: [References in the lifetime of a program],
)

= The Java Programming Language

== Java vs. C

#slide[
  #task[Let's first write a few simple tasks in the programming language
    C:
    - Sum of numbers 1 to n using a *for* loop.
    - Maximum of two numbers using an *if* statement.
    - Determine the maximum of two numbers using the *getMax()* function.
  ]
]

- I have good news: You could have executed this code in Java without any problems!
- The *syntax*, i.e., the keywords and structure of the language, is very close
  to C and C++!
- Therefore, we want to continue building on your prior knowledge.

#figure(
  image("../assets/img/2024_10_04_java_origin_rev01.png", height: 40%),
  caption: [The influences on the Java programming language],
)

== Compilation

1. Development
  - Source code is written on the PC.
  - Compiler compiles source code into *bytecode*.
2. Execution
  - Bytecode is executed on the *JVM* (Java Virtual Machine).
  - Execution does not require recompilation for each target platform.

#slide[
  #align(left + horizon)[
    #figure(
      image("../assets/img/2024_10_04_jvm_principle_rev01.png"),
      caption: [Program execution with the JVM],
    )
  ]
]

#slide[

  - Differences in other programming languages that are compiled or interpreted:
    - *Compiled languages* must be recompiled for each target platform.
    - *Interpreted languages* must be interpreted by their own interpreter on the
      target platform itself.
]

#slide[
  #align(left + horizon)[

    #figure(
      image("../assets/img/2024_10_04_interpreted_lang_principle_rev01.png"),
      caption: [Execution of compiled languages],
    )
  ]
]
#slide[
  #align(left + horizon)[

    #figure(
      image("../assets/img/2024_10_04_compiled_lang_principle_rev01.png"),
      caption: [Execution of interpreted languages],
    )
  ]

]

== Properties of Java

#question[If you could develop a new language, what would be important to you? What
  would you change about C/C++?]
#pause
- Java
  - Object-oriented language (i.e., classes, objects, and inheritance)
  - Platform-independent (via *JVM*)
  - Strongly typed (fixed types like *int* and *String*)
  - Robust (i.e., Garbage Collector)

#slide[
  #question[Which is the better programming language: C or Java?]
]

= The First Program

== IDE

- I would recommend IntelliJ IDEA from JetBrains as an IDE.
  - This tool will also be used in the exam.
  - The IDE also includes the Java JDK, which you need for programming.
#align(center + horizon)[
  #tiaoma.barcode(
    "https://www.jetbrains.com/idea/download/?section=windows",
    "QRCode",
    options: (scale: 3.0),
  )
]
- Choose the Community Edition at #link("https://www.jetbrains.com/idea/download/?section=windows"),
  or scan the QR code.
#slide[
  #align(left + horizon)[

    #figure(
      image("../assets/img/2024_10_03_jdk_jre_compiler_rev01.png"),
      caption: [The structure of the Java Toolchain#footnote(numbering: "*")[Application Programming Interface]],
    )
  ]
]

#task[
  - Preparation:
    1. First open a directory where you will store the programming files.
    2. Open IntelliJ IDEA.
  - Create project:
    1. Select File > New > Project.
    2. Assign a name and a location.
    3. Choose Java and IntelliJ and the appropriate JDK
    4. Click "Create"
]

#slide[
  #task[
    - Create package
      1. Right-click on src
      2. Select New > Package
      3. Enter name
    - Create class
      1. Right-click on package
      2. Choose New > Java Class
  ]
]

== The First Program
#align(left + horizon)[

  ```java
  public static void main(String[] args){
    System.out.println("Hello World!");
  }
  ```
  #idea[Enter the code into the file you just created. If you're already that far,
    feel free to code along!]
]

== Applications in Java

A Java file can be executed if it has a public (*public*)
class: ```java public class MyApplication {...}``` \

#pause

The class must also have the same name as the file, for example
`MyApplication.java` \

#pause

The class has the method: ```java public static void main(String[] args)``` \

#slide[
  //#align(left + horizon)[
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
  #pinit-rect-from(
    5,
    pos: bottom,
    fill: rgb(180, 10, 10),
  )[This method must always be called main.]
  //]
]
= Literature
== Literature Recommendations
- Some books that might help you during the course:
  - D. Abts: Grundkurs JAVA, Springer-Vieweg
  - H.-P. Habelitz: Programmieren lernen mit Java, Rheinwerk Computing

= License Notice

== Attribution

- This work is shared under the CC BY-NC-SA 4.0 License and the respective Public
  License
- #link("https://creativecommons.org/licenses/by-nc-sa/4.0/")
- This work is based off of the work Prof. Dr. Marc Hensel.
- Some of the images and texts, as well as the layout were changed.
- The base material was supplied in private, therefore the link to the source
  cannot be shared with the audience.
