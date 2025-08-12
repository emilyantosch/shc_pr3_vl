#import "@preview/touying:0.5.2": *
#import themes.university: *

#import "@preview/fletcher:0.5.8" as flechter: diagram, edge, node

#import "@preview/cetz:0.4.1"

#import "@preview/tiaoma:0.2.1"

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
    rect(inset: 0.5em, stroke: (bottom: 0.12em + fill), {
      set text(fill: fill)
      body
    }),
  )
}
#show: university-theme.with(aspect-ratio: "16-9", config-info(
  title: [Object-Oriented Programming in Java],
  subtitle: [Lecture 1 - Organization and Introduction],
  author: [Emily Lucia Antosch],
  date: datetime.today().display("[day].[month].[year]"),
  institution: [HAW Hamburg],
))

#codly(languages: (
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
))

#title-slide(authors: [Emily Lucia Antosch])

#outline(depth: 1)

= Organization

== The Goal of This Chapter

#slide[
  - I want to introduce myself to you and discuss the course structure of this module.
  - You will get an overview of the prerequisites for this module and will be able to
    meet them.
  - You will know how to reach me.
]

== About Me
#slide[
  - Emily Lucia Antosch, 25 years old
  - Bachelor's degree in Electrical and Information Technology
  - Currently working as an application developer at NVL
  - Currently doing my Master's degree in Practical Computer Science
  - Email: emilylucia.antosch\@haw-hamburg.de

  #info[I'm rather new with teaching at university, so please be lenient with me!]
]
== Course Schedule
#slide[
  - Lectures are divided into sessions on Tuesdays and Thursdays.
    - At the beginning, there are many sessions designed to prepare you for the lab.
  - I would ask you to actively participate in the lectures.
  - There will be small questions and tasks that you can answer live and
    code along with.

  #memo[If you don't understand something, please ask immediately! I'm more than happy to repeat any part of the lecture!]
]

== Lecture Focus
#slide[
  - We want to build upon your prior knowledge.
  - By the end of the lecture, you should be able to create simple programs in Java.
  - Also, we want to look at mastering object-oriented programming paradigm and be able to highlight the differences to other programming paradigms.
  - You can also read about the exact content outside of the lecture in the module handbook.
]

== Prerequisites
#slide[
  - You will need an installation of the *Java SDK*.
    - For this, I have written a guide that you can find in the Moodle room.
  - Additionally, the lecture will use the tool *JetBrains IntelliJ*.
    - This is, in my opinion, a very good and simple IDE for beginners.
]

= Introduction
== The Goal of This Chapter
#slide[
  - You will be able to apply your existing knowledge from previous lectures to new content.
  - You will understand the fundamental concepts of object-oriented programming and understand the difference from programming in C.
  - We will create a simple program in the IntelliJ IDEA development environment and execute it.
]

== Topic Overview: Fundamentals
#slide[
  The first lectures focus on the following principles:
  1. Imperative Concepts
  2. Classes and Objects
  3. Class Library
  4. Inheritance
  5. Interfaces
]

== Topic Overview: Advanced Concepts
#slide[
  From the fundamentals, we then want to derive further concepts:
  6. Graphical User Interfaces
  7. Exception Handling
  8. Input and Output
  9. Multithreading (Parallel Computing)
]


== Objects and Classes
#slide[
  In the real world, things are often determined and described by their properties:
  - A car has properties such as
    - a manufacturer
    - a color
    - fuel consumption

  #idea[Using object-oriented programming, we can apply this intuitive
    approach to programming as well!]
]

#slide[
  #question[What properties could you use to describe a person, for example? How
    might this fit into the programming context?]
  #pause
  - For students:
    - Name, address, student ID number
  - For programs/websites:
    - Username, password, join date
]

#slide[
  - To create multiple similar objects from this similar blueprint,
    a class is created:
    - It contains all the properties we just defined in variables.
    - From it, completely different objects can be created that have these properties filled in differently.
  #example[From the *Student* class, for example, the two students *Max* and *Ines* can be created, who both have different names and their own student ID number.]
]

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

#slide[
  - Variables and functions are thus combined into a class.
    - A set of variables is defined.
    - For these variables, functions are introduced that can read and modify them.

  #memo[
    - Variables are called *attributes*.
    - The values of these variables describe the *state* of the object.
    - Functions are called *methods*.
  ]
]

#slide[
  - So-called UML class diagrams can be used to describe classes with their *attributes* and *methods*.
  #align(center + horizon)[
    #figure(
      image("../assets/img/slides_01/20250730_attributes_methods_rev01.png", height: 70%),
      caption: [UML Class Diagram],
    )
  ]
]

== Data Encapsulation
#slide[
  - Data can be encapsulated using attributes and methods of classes.

  #align(center + horizon)[
    #figure(
      image("./../assets/img/slides_01/20250730_data_encapsulation_rev01.png", height: 75%),
      caption: [Data encapsulation through classes],
    )<data-encapsulation>
  ]
]

#slide[
  - Data can be encapsulated using attributes and methods of classes.
    - Not all parts of the program can access encapsulated data, which increases security.
    - Additionally, attributes can be protected from erroneous values this way.
]

#slide[
  #question[Where do the differences lie in comparison to the C programming language?]
  #pause
  - The data structure (i.e., the *struct*) must be made public for access to the elements.
  - The data is not protected.
  - There is no association between the data and the functions.
]

== Inheritance
#slide[
  - Through inheritance, new classes can be created from other classes.
    - The methods and attributes of the base class are inherited and extended with additional code.
    - No duplicated code.
  #figure(image("../assets/img/slides_01/20250812_inheritance_rev01.png", height: 63%))
]

== Composition
#slide[
  - Classes can also be composed of other classes.
  - This is called *composition*.
  - For example, the *House* class would be composed of
    *Windows*, *Walls*, and *Doors*.
  #figure(
    image("../assets/img/slides_01/20250812_composition_rev01.png", height: 50%),
    caption: [Composition of a given class],
  )
]

== Program Execution in Java

#slide[
  1. At program startup, a special *main* method is executed in the _main object_.
  2. In this method, objects are created and the *references* to these
    objects are stored in variables.
  3. These variables can then be used to access the respective object.
  4. Objects in the program can then create additional objects and
    call methods.
  5. As soon as the *main* method is finished, the program ends.

  #figure(
    image("../assets/img/slides_01/20250730_program_execution_references_rev01.png", height: 80%),
    caption: [References in the lifetime of a program],
  )
]

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

#slide[
  - I have good news: You could have executed this code in Java without any problems!
  - The *syntax*, i.e., the keywords and structure of the language, is very close
    to C and C++!
  - Therefore, we want to continue building on your prior knowledge.

  #figure(
    image("../assets/img/slides_01/2024_10_04_java_origin_rev01.png", height: 40%),
    caption: [The influences on the Java programming language],
  )
]

== Compilation
#slide[
  1. Development
    - Source code is written on the PC.
    - Compiler compiles source code into *bytecode*.
  2. Execution
    - Bytecode is executed on the *JVM* (Java Virtual Machine).
    - Execution does not require recompilation for each target platform.
]

#slide[
  #align(left + horizon)[
    #figure(
      image("../assets/img/slides_01/20250812_jvm_bytecode_rev01(2).png"),
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
      image("../assets/img/slides_01/20250812_source_code_interpreter_rev01(1).png"),
      caption: [Execution of compiled languages],
    )
  ]
]
#slide[
  #align(left + horizon)[

    #figure(
      image("../assets/img/slides_01/20250812_source_code_compiler_rev01.png"),
      caption: [Execution of interpreted languages],
    )
  ]

]

== Properties of Java
#slide[
  #question[If you could develop a new language, what would be important to you? What
    would you change about C/C++?]
  #pause
  - Java
    - Object-oriented language (i.e., classes, objects, and inheritance)
    - Platform-independent (via *JVM*)
    - Strongly typed (fixed types like *int* and *String*)
    - Robust (i.e., Garbage Collector)
]

#slide[
  #question[Which is the better programming language: C or Java?]
]

= The First Program
== IDE
#slide[
  - I would recommend IntelliJ IDEA from JetBrains as an IDE.
    - This tool will also be used in the exam.
    - The IDE also includes the Java JDK, which you need for programming.
  #align(center + horizon)[
    #tiaoma.barcode("https://www.jetbrains.com/idea/download/?section=windows", "QRCode", options: (scale: 3.0))
  ]
  - Choose the Community Edition at #link("https://www.jetbrains.com/idea/download/?section=windows"),
    or scan the QR code.
]

#slide[
  #align(left + horizon)[
    #figure(
      image("../assets/img/slides_01/20250812_jre_jdk_rev01.png"),
      caption: [The structure of the Java Toolchain#footnote(numbering: "*")[Application Programming Interface]],
    )
  ]
]

#slide[
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
#slide[
  #align(left + horizon)[

    ```java
    public static void main(String[] args){
      System.out.println("Hello World!");
    }
    ```
    #idea[Enter the code into the file you just created. If you're already that far,
      feel free to code along!]
  ]
]

== Applications in Java
#slide[
  - A Java file can be executed if it has a public (*public*) class: ```java public class MyApplication {...}``` \
  - The class must also have the same name as the file, for example `MyApplication.java`
  - The class has the method: ```java public static void main(String[] args)``` \
]

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
  #pinit-rect-from(5, pos: bottom, fill: rgb(180, 10, 10))[This method must always be called main.]
]

= Literature
== Literature Recommendations
#slide[
  - Some books that might help you during the course:
    - D. Abts: Grundkurs JAVA, Springer-Vieweg
    - H.-P. Habelitz: Programmieren lernen mit Java, Rheinwerk Computing
]

= License Notice
== Attribution
#slide[
  - This work is shared under the CC BY-NC-SA 4.0 License and the respective Public
    License
  - #link("https://creativecommons.org/licenses/by-nc-sa/4.0/")
  - This work is based off of the work Prof. Dr. Marc Hensel.
  - Some of the images and texts, as well as the layout were changed.
  - The base material was supplied in private, therefore the link to the source
    cannot be shared with the audience.
]
