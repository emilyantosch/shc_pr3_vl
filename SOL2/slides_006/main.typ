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
    short-title: [Java · Lecture 6],
    subtitle: [Lecture 6 - Abstract Elements],
    author: [Emily Lucia Antosch],
    date: datetime.today().display("[day].[month].[year]"),
    institution: [HAW Hamburg],
  ),
)

// Codly uses grid rows; increase their vertical inset, not paragraph leading.
#show raw.where(block: true): it => {
  codly(inset: (x: .32em, y: .22em))
  it
}

#title-slide(authors: [Emily Lucia Antosch])
#outline-slide()

= Introduction
== From Inheritance to Contracts
#slide[
  #diagram("roadmap", height: 190pt)
]

= Abstract Classes and Methods
== What Is a Plain Shape?
#slide[
  #question[Should we create a Shape object? What would its area be?]
  #pause
  #diagram("shapes-before", height: 210pt)
]

== Abstract Classes Cannot Be Instantiated
#slide[
  #diagram("instantiation", height: 250pt)
]

#slide[
  #text(19pt)[
    ```java
    public abstract class A {
        // Shared state and behavior
    }
    public class B extends A {
        // Concrete subclass
    }
    ```
    Inside `main()`:
    ```java
    A invalid = new A();  // Compile error: abstract class
    A valid = new B();    // Concrete object, abstract reference type
    ```
  ]
]

== Abstract Methods Declare a Contract
#slide[
  ```java
  public abstract class ImageSource {
      String name;
      public abstract Image getNextImage();
  }
  ```
  No method body: a concrete subclass must supply it.
]

#slide[
  #diagram("image-source", height: 230pt)
  #text(18pt)[Italics mark abstract classes and methods in UML.]
]

== Calling Through an Abstract Type
#slide[
  #diagram("dispatch", height: 200pt)
  ```java
  ImageSource ref = new Camera();
  Image image = ref.getNextImage();
  ```
]

== A Subclass Can Stay Abstract
#slide[
  #diagram("image-tree", height: 290pt)
]

== Task: Make Shape Abstract
#slide[
  #task[Prevent plain Shape objects. Require each concrete shape to implement getArea().]
  #diagram("shapes-before", height: 210pt)
]

#slide[
  #diagram("shapes", height: 280pt)
]

#slide[
  #text(19pt)[
    ```java
    public abstract class Shape {
        // Existing fields and constructor
        public abstract double getArea();
    }
    ```
    In `Circle`:
    ```java
    @Override
    public double getArea() {
        return Math.PI * radius * radius;
    }
    ```
  ]
]

= Interfaces
== Classes and Interfaces
#slide[
  #diagram("type-kinds", height: 230pt)
]

== What Can an Interface Declare?
#slide[
  #diagram("interface-members", height: 280pt)
]

== Declare a Shared Capability
#slide[
  ```java
  public interface Scalable {
      void resize(double factor);
  }
  ```
  #diagram("scalable", height: 210pt)
]

== Implement the Contract
#slide[
  #text(18pt)[
    ```java
    public class Vector2D implements Scalable {
        private double x, y;
        public Vector2D(double x, double y) {
            this.x = x;
            this.y = y;
        }
        @Override
        public void resize(double factor) {
            x *= factor;
            y *= factor;
        }
        public double getX() { return x; }
        public double getY() { return y; }
    }
    ```
  ]
]

== Defer Implementation to Subclasses
#slide[
  #diagram("abstract-vector", height: 290pt)
]

== Implement Multiple Interfaces
#slide[
  #diagram("multiple", height: 200pt)
  ```java
  class ClassA implements Interface1, Interface2 {
      // Implement both contracts
  }
  ```
]

#slide[
  #diagram("gray-image", height: 230pt)
  #text(18pt)[
    ```java
    public class GrayImage implements Scalable, Drawable, Rotateable {
        // Implement resize(), draw(), and rotateLeft()
    }
    ```
  ]
]

== Interfaces Can Extend Multiple Interfaces
#slide[
  #diagram("interface-inheritance", height: 220pt)
  #text(18pt)[
    ```java
    interface Interface3 extends Interface1, Interface2 { }
    class ClassA implements Interface3 {
        // Implement all inherited abstract methods
    }
    ```
  ]
]

== One Object, Two Reference Types
#slide[
  #diagram("references", height: 230pt)
  ```java
  Vector2D classRef = new Vector2D(1, 3);
  Scalable interRef = classRef;
  ```
]

#slide[
  #question[Which calls compile?]
  #text(19pt)[
    ```java
    Vector2D classRef = new Vector2D(1, 3);
    Scalable interRef = classRef;

    classRef.resize(1.5);
    System.out.println(classRef.getX());
    interRef.resize(1.5);
    System.out.println(interRef.getX());
    ```
  ]
  #pause
  Only `interRef.getX()` fails: Scalable does not declare it.
]

== Task: Transform Geometric Shapes
#slide[
  #task[Define Transformable. Support moving, 90° left/right rotation, and scaling in every concrete shape.]
  #diagram("transformable", height: 220pt)
]

= Comparison and Sorting
== Comparable Defines the Natural Order
#slide[
  ```java
  public interface Comparable<T> {
      int compareTo(T other);
  }
  ```
  #diagram("comparable", height: 210pt)
]

== Read the Sign, Not the Exact Value
#slide[
  #diagram("comparison", height: 230pt)
]

== Compare Vectors by Magnitude
#slide[
  #diagram("comparable-vector", height: 230pt)
  Keep Scalable too: `implements Scalable, Comparable<Vector2D>`.
]

#slide[
  Add to `Vector2D`:
  #text(19pt)[
    ```java
    public double getAbs() {
        return Math.sqrt(x * x + y * y);
    }
    @Override
    public int compareTo(Vector2D other) {
        return Double.compare(getAbs(), other.getAbs());
    }
    ```
  ]
  `Double.compare` returns a negative value, zero, or a positive value.
]

== Sort a List of Vectors
#slide[
  #text(19pt)[
    ```java
    // Import java.util.ArrayList and java.util.Collections.
    // Inside main():
    ArrayList<Vector2D> vectors = new ArrayList<>();
    vectors.add(new Vector2D(0, 5));
    vectors.add(new Vector2D(0, -1));
    vectors.add(new Vector2D(7, 8));
    vectors.add(new Vector2D(0, 0));
    Collections.sort(vectors);
    for (Vector2D vector : vectors) {
        System.out.println(vector.getAbs());
    }
    ```
  ]
]

#slide[
  #diagram("sorting", height: 250pt)
]

== Task: Compare Shapes by Area
#slide[
  #task[Implement Comparable<Shape>. Order shapes by area. Where should compareTo() go?]
  #diagram("shapes", height: 210pt)
]

#slide[
  #diagram("comparable-shapes", height: 290pt)
]

#slide[
  #text(19pt)[
    ```java
    public abstract class Shape implements Comparable<Shape> {
        // Existing fields, constructor, and other methods
        public abstract double getArea();

        @Override
        public int compareTo(Shape other) {
            return Double.compare(getArea(), other.getArea());
        }
    }
    ```
  ]
  `getArea()` dispatches to each concrete shape's implementation.
]

== Sort Different Shapes Together
#slide[
  #text(19pt)[
    ```java
    // Import java.util.ArrayList and java.util.Collections.
    // Inside main(); use the constructors from lecture 5:
    ArrayList<Shape> shapes = new ArrayList<>();
    shapes.add(new Circle(0.0, 0.0, 2.0));
    shapes.add(new Circle(0.0, 0.0, 1.0));
    shapes.add(new Rectangle(0.0, 0.0, 10.0, 5.0));
    shapes.add(new Square(0.0, 0.0, 0.5));
    Collections.sort(shapes);
    for (Shape shape : shapes) {
        System.out.println(shape.getArea());
    }
    ```
  ]
]

#slide[
  #diagram("sorting-shapes", height: 250pt)
]

= License Notice
== Attribution
#slide[
  - Shared under #link("https://creativecommons.org/licenses/by-nc-sa/4.0/")[CC BY-NC-SA 4.0] and the applicable public license.
  - Based on teaching material by Prof. Dr. Marc Hensel.
  - Text, diagrams, and layout adapted. Original material supplied privately; no public source link is available.
]
