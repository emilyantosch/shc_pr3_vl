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
    short-title: [Java · Lecture 5],
    subtitle: [Lecture 5 - Inheritance],
    author: [Emily Lucia Antosch],
    date: datetime.today().display("[day].[month].[year]"),
    institution: [HAW Hamburg],
  ),
)

// Codly lays out code in grid rows; increase their vertical inset.
#show raw.where(block: true): it => {
  codly(inset: (x: .32em, y: .22em))
  it
}

#title-slide(authors: [Emily Lucia Antosch])
#outline-slide()

= Introduction
== From Reuse to Inheritance
#slide[
  #diagram("roadmap", height: 190pt)
]

= Inheritance
== Extending a Class
#slide[
  #diagram("inheritance", height: 230pt)
]

#slide[
  ```java
  class A {
      // Existing fields and methods
  }

  class B extends A {
      // Additional fields and methods
  }
  ```
]

== Task: Person and Pilot
#slide[
  #task[Create Person and Pilot. Create a Pilot object and print its name.]
  #diagram("pilot", height: 210pt)
]

#slide[
  Each public class belongs in its own file.
  ```java
  public class Person {
      String name;
  }

  public class Pilot extends Person {
      int flightHours;
  }
  ```
  These fields have package access. Put the demo in the same package.
]

#slide[
  #text(19pt)[
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
]

#slide[
  #diagram("pilot-object", height: 260pt)
]

== Visibility and Encapsulation
#slide[
  #diagram("visibility", height: 230pt)
  #text(18pt)[Top-level classes: public or package access. Constructors may be private.]
]

== What Is Inherited?
#slide[
  #diagram("members", height: 260pt)
  Java has no C++-style destructors.
]

== Inheritance Structures
#slide[
  #diagram("models", height: 250pt)
]

== Object: The Root Class
#slide[
  #question[Which superclass does Person have?]
  ```java
  public class Person {
      String name;
  }
  ```
  With no explicit `extends`, a class implicitly extends `Object`.
]

#slide[
  #diagram("object-root", height: 260pt)
]

#slide[
  Every class inherits instance methods from `Object`, including `toString()`.
  ```java
  Person person = new Person();
  person.name = "Lukas Luft";
  System.out.println(person.toString());
  ```
  Default output: a class name, `@`, and a hash code in hexadecimal—not the name field.
]

== Task: Geometric Shapes
#slide[
  #task[Model Circle, Rectangle, and Square with public fields. No methods yet.]
  #diagram("shapes", height: 220pt)
]

#slide[
  #diagram("separate-shapes", height: 190pt)
  #task[Move the common fields into a Shape superclass.]
]

#slide[
  #diagram("shape-tree", height: 240pt)
  ```java
  public class Shape {
      public double x, y;
  }
  ```
]

#slide[
  #text(19pt)[
    ```java
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
  #task[Add a Circle constructor that sets x, y, and radius.]
]

== Initializing Inherited Fields
#slide[
  #text(19pt)[
    ```java
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
  #question[What breaks if Shape makes x and y private?]
]

#slide[
  #diagram("encapsulation", height: 230pt)
  Private fields still exist in the object, but Circle cannot access them directly.
]

#slide[
  #text(18pt)[
    #grid(columns: (1fr, 1fr), gutter: 24pt,
      [
        ```java
        public class Shape {
            private double x, y;

            public void setX(double x) {
                this.x = x;
            }
            public void setY(double y) {
                this.y = y;
            }
        }
        ```
      ],
      [
        ```java
        public class Circle
                extends Shape {
            public double radius;

            public Circle(double x,
                          double y,
                          double radius) {
                setX(x);
                setY(y);
                this.radius = radius;
            }
        }
        ```
      ],
    )
  ]
]

= Object Instantiation
== One Object, All Instance Fields
#slide[
  #diagram("object-state", height: 280pt)
]

== Constructor Chaining
#slide[
  #diagram("construction", height: 250pt)
]

== Calling the Superclass Constructor
#slide[
  Put `super(...)` first in the constructors used in this lecture.
  #text(19pt)[
    ```java
    public class A {
        double a;  // Initially 0.0
    }
    public class B extends A {
        double b;

        public B(double b) {
            super();
            this.b = b;
        }
    }
    ```
  ]
]

#slide[
  #diagram("constructor-rules", height: 250pt)
]

== Task: Initialize Superclass State
#slide[
  #task[Add a Shape constructor for x and y. Call it from Circle instead of using setters.]
  #diagram("shape-private", height: 220pt)
]

#slide[
  #text(18pt)[
    #grid(columns: (1fr, 1fr), gutter: 24pt,
      [
        ```java
        public class Shape {
            private double x, y;

            public Shape(double x,
                         double y) {
                this.x = x;
                this.y = y;
            }
        }
        ```
      ],
      [
        ```java
        public class Circle
                extends Shape {
            public double radius;

            public Circle(double x,
                          double y,
                          double radius) {
                super(x, y);
                this.radius = radius;
            }
        }
        ```
      ],
    )
  ]
  `super(x, y)` selects the matching constructor—not a default constructor.
]

== Task: Protect the Shape Fields
#slide[
  #task[Make all fields private. Add constructors and only the getters/setters you need.]
  #diagram("shape-private", height: 220pt)
]

#slide[
  #text(19pt)[
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
== Person and Pilot, with Constructors
#slide[
  #text(18pt)[
    #grid(columns: (1fr, 1fr), gutter: 24pt,
      [
        ```java
        public class Person {
            String name;

            public Person(String name) {
                this.name = name;
            }
        }
        ```
      ],
      [
        ```java
        public class Pilot
                extends Person {
            String airline;

            public Pilot(String name,
                         String airline) {
                super(name);
                this.airline = airline;
            }
        }
        ```
      ],
    )
  ]
]

== One Object, Several Reference Types
#slide[
  #text(19pt)[
    ```java
    Pilot pilot = new Pilot("Birgit", "Winglet Airways");
    Person personRef = pilot;
    Object objectRef = pilot;
    ```
  ]
  #diagram("references", height: 210pt)
]

== Reference Type Controls Access
#slide[
  #question[Which accesses compile? Assume all classes are in the same package.]
  #text(19pt)[
    ```java
    Pilot pilot = new Pilot("Birgit", "Winglet Airways");
    Person personRef = pilot;
    Object objectRef = pilot;

    System.out.println(personRef.name);
    System.out.println(personRef.airline);
    System.out.println(objectRef.name);
    System.out.println(objectRef.airline);
    ```
  ]
]

#slide[
  #diagram("reference-access", height: 250pt)
  Of the four accesses, only `personRef.name` compiles.
]

= Overriding
== A New Implementation of toString()
#slide[
  #diagram("overriding", height: 250pt)
]

== Person Overrides toString()
#slide[
  #text(19pt)[
    ```java
    public class Person {
        private String name;
        public Person(String name) {
            this.name = name;
        }
        public String getName() {
            return name;
        }
        @Override
        public String toString() {
            return name;
        }
    }
    ```
  ]
]

== Pilot Overrides toString()
#slide[
  #text(19pt)[
    ```java
    public class Pilot extends Person {
        private String airline;
        public Pilot(String name, String airline) {
            super(name);
            this.airline = airline;
        }
        @Override
        public String toString() {
            return String.format("%s (%s)", getName(), airline);
        }
    }
    ```
  ]
]

== Which Implementation Runs?
#slide[
  #question[What will this print?]
  #text(18pt)[
    ```java
    Person person = new Person("Birgit Janssen");
    System.out.println(person);
    System.out.println(person.toString());

    Pilot pilot = new Pilot("Jan Birgerson", "Winglet Airways");
    System.out.println(pilot.toString());
    ```
  ]
  #pause
  ```text
  Birgit Janssen
  Birgit Janssen
  Jan Birgerson (Winglet Airways)
  ```
]

== Runtime Type Selects the Method
#slide[
  #question[Does the reference type change the output?]
  #text(18pt)[
    ```java
    Pilot pilot = new Pilot("Jan Birgerson", "Winglet Airways");
    Object objectRef = pilot;
    Person personRef = pilot;
    System.out.println(objectRef.toString());
    System.out.println(personRef.toString());
    ```
  ]
]

#slide[
  #diagram("dispatch", height: 250pt)
]

== Calling the Superclass Implementation
#slide[
  Inside `Pilot`:
  ```java
  public String toStringOfSuperClass() {
      return super.toString();
  }
  ```
  #diagram("super-call", height: 190pt)
]

== What Does final Prevent?
#slide[
  #diagram("final", height: 250pt)
]

== Fields Are Not Overridden
#slide[
  Suppose both `Person` and `Pilot` declare a public field named `name`.
  #diagram("field-hiding", height: 220pt)
  Static methods are also selected by compile-time type, not runtime dispatch.
]

== Exercise: Jason the Cat
#slide[
  #diagram("cat", height: 290pt)
]

#slide[
  #diagram("cat-answer", height: 290pt)
]

== Task: Sum the Areas
#slide[
  #task[
    Add `getArea()` to the shape classes. Store one Circle, Rectangle, and Square
    in an `ArrayList<Shape>` and sum their areas.
  ]
]

#slide[
  #diagram("areas", height: 290pt)
]

#slide[
  #text(18pt)[
    ```java
    // In Circle:
    @Override
    public double getArea() {
        return Math.PI * radius * radius;
    }
    // In Rectangle:
    @Override
    public double getArea() {
        return width * height;
    }
    // In Square:
    @Override
    public double getArea() {
        return width * width;
    }
    ```
  ]
]

#slide[
  For now, add this placeholder to `Shape`; each concrete shape overrides it.
  ```java
  public double getArea() {
      return 0.0;
  }
  ```
  A later lecture replaces the placeholder with an *abstract method*.
]

#slide[
  #text(19pt)[
    ```java
    // Import java.util.ArrayList; code inside main():
    ArrayList<Shape> shapes = new ArrayList<>();
    shapes.add(new Circle(2.0, 3.0, 1.0));
    shapes.add(new Rectangle(-1.0, 0.0, 3.5, 4.0));
    shapes.add(new Square(0.0, 0.0, 2.5));

    double sumArea = 0.0;
    for (Shape shape : shapes) {
        sumArea += shape.getArea();
    }
    System.out.println("Overall area = " + sumArea);
    ```
  ]
]

= Polymorphism
== Same Name, Different Implementations
#slide[
  #diagram("polymorphism", height: 270pt)
  Overloading cannot differ only by return type.
]

= Comparing Objects
== Identity: The == Operator
#slide[
  #question[What does each comparison print?]
  #text(19pt)[
    ```java
    Point a = new Point(1, 2);
    Point b = new Point(1, 2);
    Point c = new Point(7, 3);
    Point d = a;

    System.out.println(a == b);
    System.out.println(a == c);
    System.out.println(a == d);
    ```
  ]
]

#slide[
  #diagram("identity", height: 270pt)
  `==` compares references, not field values.
]

== Value Equality: equals()
#slide[
  #diagram("equals-rule", height: 220pt)
  Use your IDE’s Generate menu to create `equals()` and `hashCode()` together.
]

== Exercise: Identity or Equality?
#slide[
  #diagram("equality", height: 290pt)
]

#slide[
  #diagram("equality-answer", height: 290pt)
]

= License Notice
== Attribution
#slide[
  - Shared under #link("https://creativecommons.org/licenses/by-nc-sa/4.0/")[CC BY-NC-SA 4.0] and the applicable public license.
  - Based on teaching material by Prof. Dr. Marc Hensel.
  - Text, diagrams, and layout adapted. Original material supplied privately; no public source link is available.
]
