#import "@preview/touying:0.5.2": *
#import themes.university: *

#import "@preview/fletcher:0.5.1" as flechter: diagram, edge, node
#import "@preview/wrap-it:0.1.0": wrap-content

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
    subtitle: [Lecture 5 - Inheritance],
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

== Where Are We Currently?

- The last lecture was about class libraries
- You can now
  - use simple class libraries to manipulate strings or arrays
  - read all items from an array via a `foreach` loop
  - perform type conversions using wrapper classes,
  - perform simple mathematical calculations using the `Math` class.
- Today we continue with *Inheritance*.

#slide[
  1. Imperative Concepts
  2. Classes and Objects
  3. Class Library
  4. *Inheritance*
  5. Interfaces
  6. Graphical User Interfaces
  7. Exception Handling
  8. Input and Output
  9. Multithreading (Parallel Computing)
]

== The Goal of This Chapter

- You create new data types by extending existing classes with additional
  properties, for example to avoid duplicated source code.
- You use visibility modifiers to protect the attributes of a class from
  direct external access.

= Inheritance
== Inheritance
#slide[
  - Class takes over ("inherits") variables and methods of an existing class
  - Goal: Reuse of existing classes

  - Example and UML notation:
    - Class A exists
    - Class B is created and inherits from A

  - Terms:
    - Class A: Superclass (base class, parent class)
    - Class B: Subclass (derived class, child class)
    - Inheritance: Derivation, English: inheritance

    #figure(
      image("../assets/img/slides_5/2024_10_20_vererbung_AB_rev01.png"),
      caption: [Simple example of inheritance],
    )
]

#slide[
  - Derivation from base class using `extends`:
  ```java
  class ClassName extends BaseClass {
      Attributes
      Methods
      }
  ```
  #example[
    ```java
    class A {
          // ...
      }

      class B extends A {
          // ...
      }
    ```
  ]
]

#slide[
  #text(size: 20pt)[
    #task[
      - Create the following classes:
        - Person: Objects contain the name
        - Pilot: Objects contain the name and previous flight hours
        - Executable class that creates a Pilot object and outputs the name
    ]
  ]
  #figure(
    image(
      "../assets/img/slides_5/2024_10_20_vererbung_person_pilot_rev01.png",
      height: 40%,
    ),
    caption: [Pilot inherits from Person],
  )
]

#slide[
  #text(size: 16pt)[
    ```java
    public class Person {
          String name;
      }

      public class Pilot extends Person {
          int flightHours;
      }

      public class PilotDemo {
          public static void main(String[] args) {
              Pilot pilot = new Pilot();

              pilot.name = "Lukas Luft";
              pilot.flightHours = 1482;
              System.out.println("Name: " + pilot.name);
          }
      }
    ```
  ]
]

#slide[
  #figure(
    grid(
      columns: 2,
      gutter: 1em,
      image("../assets/img/slides_5/2024_10_20_vererbung_uml_person_pilot_rev01.png"),
      image("../assets/img/slides_5/2024_10_20_vererbung_pilot_objekt_rev01.png"),
    ),
    caption: [Inheritance of attributes],
  )
]

#slide[
  #let body = [
    - Class B can add new variables and methods

    - Terms:
      - Specialization: Class B is more specialized than Class A
      - Generalization: Class A is more general than Class B

    - Example:
      - Class Pilot has inherited from Person and added flightHours
      - A Pilot is a Person, i.e. Person is more general than Pilot.
  ]
  #let fig = figure(
    grid(
      columns: 1,
      rows: 2,
      gutter: 1em,
      image("../assets/img/slides_5/2024_10_20_vererbung_AB_rev01.png"),
      image("../assets/img/slides_5/2024_10_20_vererbung_uml_person_pilot_rev01.png"),
    ),
  )

  #grid(
    columns: (80%, 20%),
    gutter: 1em,
    body, fig,
  )
  ```java
    public class Person {
        String name;
    }

    public class Pilot extends Person {
        int flightHours;
    }
  ```
]

#slide[
  - Data encapsulation (information hiding): Variables protected from external access
  - Restrictions on access to classes, variables and methods through
    modifiers
  - Mental model: "Visibility" (i.e. is element visible or known?)

  #text(size: 20pt)[
    #align(center + horizon)[
      #figure(
        table(
          columns: (auto, auto, auto, auto, auto, auto),
          inset: 10pt,
          align: (x, y) => if x >= 0 and x <= 2 { left + horizon } else { center + horizon },
          fill: (_, y) => if calc.odd(y) { green.lighten(90%) },
          table.header([*Modifier*], [*UML*], [*Visibility*], [*Class*], [*Attributes*], [*Methods*]),
          [`public`], [`+`], [All Classes], [x], [x], [x],
          [`protected`], [`#`], [Subclasses, classes of the package], [], [x], [x],
          [`private`], [`-`], [Within the class], [], [x], [x],
          [`<none>`], [`~`], [Classes of the package], [x], [x], [x],
        ),
        caption: [Formats and Flags],
      )
    ]
  ]
  #question[Is `private` allowed as a modifier for constructors?]
]

#slide[
  #let body = [
    - Class B inherits all visible variables and methods of Class A
    - Class B possesses variables and methods from A and can use them (as if
      they were defined in Class B)

    - Example:
      - Object of Class Pilot uses variable name from base class Person
  ]
  #let fig = figure(
    grid(
      columns: 1,
      rows: 2,
      gutter: 1em,
      image("../assets/img/slides_5/2024_10_20_vererbung_AB_rev01.png"),
      image("../assets/img/slides_5/2024_10_20_vererbung_uml_person_pilot_rev01.png"),
    ),
  )
  #grid(
    columns: (80%, 20%),
    gutter: 1em,
    body, fig,
  )
]

#slide[
  ```java
    public class PilotDemo {
        public static void main(String[] args) {
            Pilot pilot = new Pilot();

            pilot.name = "Lukas Luft";
            pilot.flightHours = 1482;
            System.out.println("Name: " + pilot.name);
        }
    }
  ```
]
#slide[
  #question[
    - What do you think, which components of a class are not inherited?
  ]

  - Not passed to derived class:
    - Constructors and destructors
    - Class variables and class methods (modifier static)
    - Private variables and methods (modifier private)
]

#slide[
  - Notes:
    - Static elements never inherited, as they are bound to a class and not to a concrete object
    - Private elements are present in subclass, but it cannot directly access them
]

#slide[
  - Subclasses can be further inherited.
  - Any number of subclasses can be derived from one class.
  - However, inheriting from multiple base classes is not possible
    (multiple inheritance)

    #figure(
      image("../assets/img/slides_5/20250813_inheritance_models_rev01.png", height: 53%),
      caption: [Possible structures for inheritance],
    )
]

#slide[
  #question[
    - What do you think, which base class does Person have?
  ]
  #text(size: 20pt)[
    ```java
      public class Person {
          String name;
      }
    ```
  ]
  - You couldn't have known this before:
    - In Java a class Object is defined.
    - No base class specified. Implicitly derived from Object (extends Object)
]

#slide[
  #figure(
    image("../assets/img/slides_5/2024_10_20_vererbung_uml_person_pilot_rev01.png"),
    caption: [Object as superclass of Person],
  )
]

#slide[
  - Important consequence:
    - Object is the base class of every inheritance hierarchy
    #figure(
      image("../assets/img/slides_5/2024_10_20_vererbung_object_klasse_rev01.png"),
      caption: [Object as part of every inheritance],
    )
]

#slide[
  #question[
    - What do you think?
      - How many classes have no base class?
      - How many classes have more than one direct base class?
  ]
]

#slide[

  #text(size: 18pt)[
    - Important consequence:
    - Every class inherits the methods defined in Object (e.g. toString())
    - Example:
      ```java
      public class Person {
        String name;
      }

      public class ObjectDemo {
        public static void main(String[] args) {
            Person person = new Person();

            person.name = "Lukas Luft";
            System.out.println(person.toString());
        }
      }
      ```
  ]
]

#slide[
  #text(size: 20pt)[

    #task[
      - Implement classes for geometric objects Circle, Rectangle and Square.
      - Use only public variables for now.
      - Don't implement any methods for now.
    ]
  ]
  #figure(
    image(
      "../assets/img/slides_5/2024_10_20_vererbung_geometrische_Formen_rev01.png",
      height: 40%,
    ),
    caption: [Geometric shapes as objects],
  )
]

#slide[
  #text(size: 15pt)[
    ```java
      public class Circle {
          public double x, y;
          public double radius;
      }

      public class Rectangle {
          public double x, y;
          public double width, height;
      }

      public class Square {
          public double x, y;
          public double width;
      }
    ```
    #task[Now create a common base class!]
  ]
]

#slide[
  #let body = [
    #text(size: 18pt)[

      ```java
      public class Shape {
            public double x, y;
        }

        public class Circle extends Shape {
            public double radius;
        }

        public class Rectangle extends Shape {
            public double width, height;
        }

        public class Square extends Shape {
            public double width;
        }
      ```
    ]
  ]
  #let fig = figure(image("../assets/img/slides_5/2024_10_20_vererbung_geom_formen_baum_rev01.png"))
  #grid(
    columns: (80%, 20%),
    gutter: 0.5em,
    body, fig,
  )
]

#slide[
  #question[
    - Which variables are declared in the respective classes?
  ]
  #task[
    - Add a constructor for the Circle class!
  ]
]

#slide[
  #text(size: 15pt)[
    ```java
      public class Shape {
          public double x, y;
      }

      public class Circle extends Shape {
          public double radius;

          public Circle(double x, double y, double radius) {
              this.x = x;
              this.y = y;
              this.radius = radius;
          }
      }
    ```
    #memo[
      - Note: Variables x and y of the base class are used like "own" variables
      - Hide the variables of the Shape class through the private modifier.

    ]

  ]

]

#slide[
  #text(size: 15pt)[
    ```java
    public class Shape {
          private double x, y;
      }

      public class Circle extends Shape {
          public double radius;

          public Circle(double x, double y, double radius) {
              this.x = x;
              this.y = y;
              this.radius = radius;
          }
      }
    ```
    #error[
      - The variables x and y of the base class are not visible in Circle.
      - Error: In the constructor of class Circle, x and y are unknown.
    ]
  ]
]

#slide[
  #text(size: 15pt)[
    ```java
    public class Shape {
          private double x, y;

          public void setX(double x) {
              this.x = x;
          }
          // Additionally getter and corresponding methods for y ...
      }

      public class Circle extends Shape {
          public double radius;

          public Circle(double x, double y, double radius) {
              setX(x);
              setY(y);
              this.radius = radius;
          }
      }
    ```
  ]
]

= Object Instantiation
== Object Creation

#slide[
  #let fig = figure(image("../assets/img/slides_5/2024_10_20_vererbung_ABC_rev01.png"))

  #let body = [
    #text(size: 18pt)[
      - Class C contains its own methods as well as methods from classes A and B.
      - Class C contains its own variables as well as variables from classes A and B.
      #question[
        - What do you think?
          - How are methods of a new object of class C created?
          - How are variables of an object of class C created and initialized?
      ]
      - Methods:
        - Are not created anew for each object, but are defined for the class

      - Variables:
        - Start at the base class of the inheritance hierarchy
        - In each step, create and initialize variables of the corresponding (base) class
        - Initialization via constructor of the respective (base) class

    ]

  ]

  #grid(
    columns: (85%, 15%),
    gutter: 0.5em,
    body, fig,
  )
]

#slide[

  - Variables for objects of class C:
    - Object contains the variables declared in class C
    - Additionally contains variables inherited from class B
    - These contain the variables inherited from class A

    #figure(
      image("../assets/img/slides_5/20250813_inheritance_attributes_rev01.png", height: 51%),
      caption: [Composition of the object of class C],
    )
]

#slide[
  - New object of class C:
    - Traverse inheritance hierarchy upward:
    - Class C has base class B: Call to create variables from B
    - Class B has base class A: Call to create variables from A

  - Create and initialize variables "from inside out"
    (constructor chaining):
    - Create variables from A and initialize via constructor A()
    - Create variables from B and initialize via constructor B()
    - Create variables from C and initialize via constructor C()
]

#slide[
  #figure(
    image("../assets/img/slides_5/20250813_inheritance_attributes_tower_rev01.png", height: 90%),
    caption: [Variables of class C in memory],
  )
]

#slide[
  #let body = [

    #text(size: 17pt)[
      - Constructor of the base class:
        - Call via super() as first statement in constructor of derived class
        - If super(...) is missing, the default constructor of the base class is called.

      ```java
        public class A {
            double a;
            // Default constructor is automatically generated
        }

        public class B extends A {
            double b;

            public B(double b) {
                super();    // Call default constructor of class A
                this.b = b;
            }
        }
      ```
    ]
  ]
  #let fig = figure(image("../assets/img/slides_5/2024_10_20_vererbung_erzeugen_rev01.png"))
  #grid(
    columns: (85%, 15%),
    gutter: 0.25em,
    body, fig,
  )
]

#slide[

  - Do you remember?
    #text(size: 18pt)[
      ```java
        public class Shape {
            private double x, y;
        }

        public class Circle extends Shape {
            public double radius;

            public Circle(double x, double y, double radius) {
                this.x = x;
                this.y = y;
                this.radius = radius;
            }
        }
      ```
    ]
    #task[
      - The variables x and y are unknown in Circle.
      - Solve the problem by adding a constructor for the base class
        Shape.
    ]
]

#slide[
  #text(size: 16pt)[

    ```java
    public class Shape {
        private double x, y;

        public Shape(double x, double y) {
            this.x = x;
            this.y = y;
        }
    }

    public class Circle extends Shape {
        public double radius;

        public Circle(double x, double y, double radius) {
            super(x, y);  // Matching signature to the constructor of the base class!
            this.radius = radius;
        }
    }
    ```
  ]
]

#slide[
  #task[
    - Protect all attributes through the private modifier.
    - Create appropriate getters and setters if necessary.
  ]

  #figure(
    image(
      "../assets/img/slides_5/2024_10_20_vererbung_uml_geom_formen_rev01.png",
      height: 40%,
    ),
    caption: [Structure of inheritance],
  )
]

#slide[
  #text(size: 16pt)[
    ```java
    public class Circle extends Shape {
        private double radius;

        public Circle(double x, double y, double radius) {
            super(x, y);
            this.radius = radius;
        }

        public double getRadius() {
            return radius;
        }

        public void setRadius(double radius) {
            this.radius = radius;
        }
    }
    ```
  ]
]

= Referencing via Base Class
== Base Class Reference

#slide[
  #let body = [
    #text(size: 16pt)[

      - Let's consider the following inheritance line:
      ```java
        public class Person {
            String name;

            public Person(String name) {
                this.name = name;
            }
        }

        public class Pilot extends Person {
            String airline;

            public Pilot(String name, String airline) {
                super(name);
                this.airline = airline;
            }
        }
      ```
    ]
  ]
  #let fig = figure(image("../assets/img/slides_5/2024_10_20_vererbung_uml_person_pilot_rev01.png"))

  #grid(
    columns: (85%, 15%),
    gutter: 0.25em,
    body, fig,
  )
]

#slide[
  #let body = [
    #text(size: 18pt)[

      - What do you think about the following program?

        ```java
          public class ReferenceDemo {
            public static void main(String[] args) {
              Pilot pilot = new Pilot("Birgit", "Winglet Airways");
              Person personRef = pilot;
              Object objectRef = pilot;

            System.out.println(personRef.name);
          }
        }
        ```

        #memo[
          There is only one object (with data type Pilot). Object is referenced via variables with
          other data types than Pilot
        ]

    ]
  ]
  #let fig = figure(image("../assets/img/slides_5/2024_10_20_vererbung_uml_person_pilot_rev01.png"))

  #grid(
    columns: (85%, 15%),
    gutter: 0.25em,
    body, fig,
  )

]

#slide[

  - Class Pilot inherits from class Person and extends it
  - Pilot contains Person ("Pilot is a Person") Referenceable as Person
  - Object is not changed by this (i.e. object remains of type Pilot)!
    #figure(
      image("../assets/img/slides_5/2024_10_20_vererbung_referenzen_rev01.png", height: 40%),
      caption: [References to an object with base class],
    )
]

#slide[

  - In general:
    - Objects can be treated like objects of their base classes.
    - Objects referenceable via data types of their base classes
    - Reference variable can only access attributes and methods of its class
]
#slide[
  #text(size: 18pt)[

    #question[
      - Which accesses to attributes are allowed and which are not?
    ]
    ```java
      public static void main(String[] args) {
          Pilot pilot = new Pilot("Birgit", "Winglet Airways");
          Person personRef = pilot;
          Object objectRef = pilot;

          System.out.println(personRef.name);
          System.out.println(personRef.airline);
          System.out.println(objectRef.name);
          System.out.println(objectRef.airline);
      }
    ```
  ]
]
= Overriding
== Overriding Methods
#slide[

  #let body = [
    #text(size: 16pt)[
      - Class Person is derived from Object and therefore inherits toString() from Object and
        therefore defines another toString() method

      ```java
        public class Person {
            private String name;

            public Person(String name) {
                this.name = name;
            }

            public String getName() {
                return name;
            }

            public String toString() {
                return name;
            }
        }
      ```
    ]
  ]
  #let fig = figure(image("../assets/img/slides_5/2024_10_20_vererbung_person_toString_rot_rev01.png"))

  #grid(
    columns: (80%, 20%),
    gutter: 0.25em,
    body, fig,
  )
]

#slide[

  #let body = [
    #text(size: 18pt)[
      - Class Pilot:
        - Derived from Person and therefore inherits toString() from Person
        - Defines another toString() method
      ```java
        public class Pilot extends Person {
            private String airline;

            public Pilot(String name, String airline) {
                super(name);
                this.airline = airline;
            }

            public String toString() {
                return String.format("%s (%s)", getName(), airline);
            }
        }
      ```
    ]
  ]
  #let fig = figure(image("../assets/img/slides_5/2024_10_20_vererbung_person_pilot_tostring_rot_rev01.png"))

  #grid(
    columns: (80%, 20%),
    gutter: 0.25em,
    body, fig,
  )

]

#slide[
  #text(size: 20pt)[
    #question[
      What will be output?
    ]
    ```java
    public static void main(String[] args) {
          Person person = new Person("Birgit Janssen");
          System.out.println("person: " + person);
          System.out.println("person.toString(): " + person.toString());

          Pilot pilot = new Pilot("Jan Birgerson", "Winglet Airways");
          System.out.println("pilot.toString(): " + pilot.toString());
      }
    ```
  ]

]
#slide[
  #let body = [
    #text(size: 18pt)[
      - Output:
        - `person`: Birgit Janssen
        - `person.toString()`: Birgit Janssen
        - `pilot.toString()`: Jan Birgerson (Winglet Airways)

        #memo[
          - Respective method of the corresponding class, not the superclass(es), executed
          - Term: Method of the superclass overridden by newly defined methods
        ]
    ]
  ]

  #let fig = figure(image("../assets/img/slides_5/2024_10_20_vererbung_toString_rev01.png"))
  #grid(
    columns: (80%, 20%),
    gutter: 0.25em,
    body, fig,
  )
]
#slide[

  #let body = [
    #text(size: 18pt)[
      #question[
        - What will be output?
      ]
      ```java
      public static void main(String[] args) {
          Pilot pilot = new Pilot("Jan Birgerson", "Winglet Airways");
          Object objectRef = pilot;
          Person personRef = pilot;

          System.out.println("objectRef: " + objectRef.toString());
          System.out.println("personRef: " + personRef.toString());
      }
      ```
      #pause
      - Output:
        - `objectRef`: Jan Birgerson (Winglet Airways)
        - `personRef`: Jan Birgerson (Winglet Airways)

    ]
  ]

  #let fig = figure(image("../assets/img/slides_5/2024_10_20_vererbung_toString_rev01.png"))
  #grid(
    columns: (80%, 20%),
    gutter: 0.25em,
    body, fig,
  )
]
#slide[
  #memo[
    Method of the corresponding class executed, even when referenced via superclass(es)
  ]
]

#slide[
  #let body = [
    #text(size: 14pt)[

      - Access to overridden methods of the base class via reference super
      - Example:
      ```java
      	public class Pilot extends Person {
      	    // Instance variable, constructor, toString() ...

      	    public String toStringOfSuperClass() {
      	        return super.toString();
      	    }
      	}

      	public static void main(String[] args) {
      	    Pilot pilot = new Pilot("Jan Birgerson", "Winglet Airways");
      	    System.out.println("Pilot.toString(): " + pilot.toString());
      	    System.out.println("super.toString(): " + pilot.toStringOfSuperClass());
      	}
      ```
      #pause
      - Output:
        - `Pilot.toString()`: Jan Birgerson (Winglet Airways)
        - `super.toString()`: Jan Birgerson
    ]
  ]

  #let fig = figure(image("../assets/img/slides_5/2024_10_20_vererbung_toString_rev01.png"))
  #grid(
    columns: (80%, 20%),
    gutter: 0.25em,
    body, fig,
  )

]

#slide[
  #let fig = figure(image("../assets/img/slides_5/2024_10_20_vererbung_toString_rev01.png"))
  #let body = [
    #text(size: 14pt)[

      - Variables with modifier final are constants.
        - Value cannot be changed after first assignment
      #question[
        - What do you think?
          - What does final do for classes?
          - What does final do for methods?
      ]
      #pause
      - Classes:
        - Class with modifier final cannot be derived
        - Example: String class

      - Methods:
        - Method with modifier final cannot be overridden in subclass
      #figure(
        image("../assets/img/slides_5/2024_10_20_vererbung_final_rev01.png"),
        caption: [`final` keyword in inheritance],
      )
    ]
  ]

  #grid(
    columns: (80%, 20%),
    gutter: 0.25em,
    body, fig,
  )

]

#slide[

  - Overriding methods:
    - Methods inherited from the base class may be redefined.
    - Terms: Overriding (or also overwriting)
    - When called, the overriding method ("newest version") is executed
    - Call the hidden method `name()` of the base class via `super.name()`
    - Modifier `final` prevents overriding in subclasses

  - Overriding attributes:
    - Derived class can override variables of the base class in the same way
]

#slide[
  #text(size: 18pt)[
    #question[
      - Which methods does Jason, the cat, have?
      - From which classes does each method definition come?
    ]
    #figure(image("../assets/img/slides_5/20250813_inheritance_overriding_methods_rev01.png", height: 60%))

  ]
]
#slide[
  #text(size: 18pt)[
    #question[
      - Which methods does Jason, the cat, have?
      - From which classes does each method definition come?
    ]
    #figure(image("../assets/img/slides_5/20250813_inheritance_overriding_methods_colors_rev01.png", height: 60%))

  ]
]

#slide[
  #text(size: 18pt)[
    #task[
      - Add methods `getArea()` to determine the area of an object.
      - Create the following executable program:
        - Stores one object each `Circle`, `Rectangle` and `Square` in a common list
        - Determines sum of areas from this list
    ]

  ]
  #figure(image("../assets/img/slides_5/2024_10_20_vererbung_uml_geom_formen_rev01.png", height: 50%))

]
#slide[
  #text(size: 18pt)[
    Klasse `Circle`:
    ```java
    	public double getArea() {
    	    return Math.PI * radius * radius;
    	}
    ```
    Klasse `Rectangle`:
    ```java
    	public double getArea() {
    	    return width * height;
    	}
    ```
    Klasse `Square`:
    ```java
    	public double getArea() {
    	    return width * width;
    	}
    ```
  ]
]

#slide[
  #text(size: 16pt)[

    - Executable program:
    ```java
    	public static void main(String[] args) {
    	    ArrayList<Shape> shapes = new ArrayList<Shape>();
    	    shapes.add(new Circle(2.0, 3.0, 1.0));
    	    shapes.add(new Rectangle(-1.0, 0.0, 3.5, 4.0));
    	    shapes.add(new Square(0.0, 0.0, 2.5));

    	    double sumArea = 0.0;
    	    for (Shape shape : shapes) {
    	        sumArea += shape.getArea();
    	    }

    	    System.out.println("Overall area of shapes = " + sumArea);
    	}
    ```
    - Method `getArea()` must also be implemented in `Shape`
    - However, it is not used, but overridden by subclasses: Very ugly!
    - We will learn a more elegant solution later.

  ]
]

= Polymorphismus
== Polymorphismus

#slide[
  - The good news:
    - Only a new term, otherwise everything is already known
    - No, really. Honestly. Really true ...

  - Polymorphism:
    - Literal meaning: "Many forms"
    - Methods with the same name can take multiple forms.
    - In other words: Multiple implementations of methods with the same name
    - Typical characteristic of object-oriented languages

]

#slide[

  #question[
    - Where have we already encountered this?
  ]
  #pause
  - Methods with the same name in the same class: Overloading
  - Methods with the same name in inheritance line: Overriding (also: Overwriting)
]

#slide[
  #let left = [
    #text(size: 18pt)[
      - Overloading:
        - Methods in class have the same name
        - Must have different signatures (i.e. different parameter types)
        #figure(
          image("../assets/img/slides_5/2024_10_20_vererbung_mathfunctions_rev01.png"),
          caption: [Class MathFunctions],
        )

    ]

  ]
  #let right = [
    #text(size: 18pt)[
      - Overriding / Overwriting:
        - Methods in inheritance line have the same name
        - Must have the same signature (i.e. same name and parameter types)

        #figure(
          image("../assets/img/slides_5/2024_10_20_vererbung_toString_rev01.png"),
          caption: [Inheritance of `toString()`],
        )

    ]
  ]
  #grid(
    columns: (50%, 50%),
    gutter: 0.25em,
    left, right,
  )
]
= Comparing Objects

== Comparison Operator (==)

#slide[
  #question[
    - Class Point contains the variables x and y
    - What will be output?

  ]
  ```java
  	Point a = new Point(1, 2);
  	Point b = new Point(7, 3);
  	System.out.println(a == b);
  ```

]

#slide[
  #question[
    - And now?
  ]
  ```java
  	Point a = new Point(1, 2);
  	Point b = new Point(1, 2);
  	System.out.println(a == b);
  ```

]

#slide[
  #question[
    - Und nun?
    ```java
    	Point a = new Point(1, 2);
    	Point b = a;
    	System.out.println(a == b);
    ```

  ]
]
#slide[

  #let body = [
    #text(size: 14pt)[
      - Comparison operator compares whether variables have the same content
        - Content is respectively a reference to an object
        - Comparison only true when variables reference the same object

        #example[
          ```java
          	Point a = new Point(1, 2);
          	Point b = new Point(1, 2);
          	Point c = new Point(7, 3);
          	Point d = a;
          ```
        ]
      #error[
        - `a == b`: Different objects (with same values)
        - `a == c`: Different objects (and values)
      ]

      #success[
        - `a == d`: Same object: same reference
      ]
    ]

  ]
  #let fig = figure(image("../assets/img/slides_5/2024_10_20_vererbung_referenzen_point_rev01.png"))
  #grid(
    columns: (80%, 20%),
    gutter: 0.25em,
    body, fig,
  )
]

== `equals()`-Methode
#slide[
  #text(size: 22pt)[
    ```java
    	public boolean equals(Object obj) {
    	    // Method body
    	    // Return a value of type boolean
    	}
    ```

    - Comparison whether all variables of two referenced objects have the same values
    - Method is already defined in class Object

    - Overriding in own classes:
      - Class Object cannot know which variables you add in subclasses
      - Therefore override method if necessary to compare added attributes
      - In IntelliJ IDEA this is conveniently possible via the Generate menu.
  ]
]

#slide[
  #text(size: 20pt)[
    #question[
      - Given class Point with x and y coordinates
      - What result do the comparisons in the table provide?
    ]
  ]
  #figure(image("../assets/img/slides_5/2024_10_20_vererbung_referenzen_frage_rev01.png", height: 60%))
]

#slide[
  #text(size: 20pt)[
    #question[
      - Given class Point with x and y coordinates
      - What result do the comparisons in the table provide?
    ]
  ]
  #figure(image("../assets/img/slides_5/2024_10_20_vererbung_referenzen_antwort_rev01.png", height: 60%))
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
