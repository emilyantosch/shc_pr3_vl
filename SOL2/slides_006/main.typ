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
    subtitle: [Lecture 6 - Abstract Elements],
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

- The last lecture was about inheritance
- You can now
  - create and use simple inheritance lines,
  - override methods from the base class,
  - use the `equals()` method to compare objects with each other,
  - reference objects via the respective base class
- Today we continue with *Interfaces*.

#slide[
  1. Imperative Concepts
  2. Classes and Objects
  3. Class Library
  4. Inheritance
  5. *Interfaces*
  6. Graphical User Interfaces
  7. Exception Handling
  8. Input and Output
  9. Multithreading (Parallel Computing)
]

== The Goal of This Chapter

- You model common properties of classes by extending classes with common interfaces (in the form of abstract base classes or interfaces).
- You hide the data type of objects by referencing objects via interfaces when accessing common properties of different classes.
- You sort a collection of objects of the same data type according to arbitrary criteria

= Abstract Elements & Methods
== Abstract Elements
#slide[
  #text(size: 18pt)[
    #question[
      - Do you remember our geometric objects?
      - What bothers you about the current structure of our classes?
      - What doesn't make sense or is "ugly"?

    ]
  ]
  #pause
  #figure(
    image("../assets/img/slides_6/20250813_inheritance_overriding_abstract_rev01.png", height: 45%),
    caption: [Overriding the method from Shape],
  )

]

#slide[

  #let body = [

    #text(size: 16pt)[

      - Class becomes abstract class through keyword abstract
      - Effect: No objects of the class can be created.
      - Instead:
        - Derive class and extend in (concrete = non-abstract) subclasses
        - Create objects of the subclasses
      ```java
      	public abstract class A {
      	    // ...
      	}

      	public class B extends A {
      	    // ...
      	}

      	public static void main(String[] args) {
      	    A abstractObj = new A();
      	    B concreteObj = new B();
      	}
      ```
    ]
  ]
  #let fig = [
    #align(center + horizon)[
      #figure(image("../assets/img/slides_6/20250813_inheritance_overriding_abstract_italic_rev01.png"))
    ]
  ]
  #grid(
    columns: (70%, 30%),
    gutter: 0.25em,
    body, fig,
  )
]

#slide[
  #text(size: 18pt)[

    #let top = [
      - Method becomes abstract method through the keyword abstract
      - Abstract method contains only the declaration, but no implementation
    ]
    #let mid = [
      #let left = [
        ```java
        public abstract class ImageSource {
        	    String name;

        	    public abstract Image getNextImage();
        	}
        ```
      ]
      #let right = figure(image("../assets/img/slides_6/20250813_inheritance_overriding_abstract_italic_rev01.png"))
      #grid(
        columns: (60%, 40%),
        gutter: 0.05em,
        left, right,
      )
    ]
    #let bot = [
      #memo[
        - Abstract methods cannot be called (no implementation exists!)
        - Instead specifies which methods subclasses must have
      ]
    ]
    #grid(
      rows: (auto, 30%, auto),
      gutter: 2.5em,
      top,
      mid,
      bot,
    )
  ]
]

#slide[
  #text(size: 16pt)[

    #let body = [

      - Classes with abstract methods must be abstract.
      - Otherwise, non-implemented methods could be called for objects.
      - Inheritance:
        - Abstract methods are inherited.
        - Subclasses remain abstract as long as not all abstract methods are implemented

      ```java
      	public abstract class ImageSource {
      	    String name;

      	    public abstract Image getNextImage();
      	}

      	public class Camera extends ImageSource {
      	    public Image getNextImage() {
      	        // ...
      	    }
      	}
      ```
    ]
    #let fig = figure(image("../assets/img/slides_6/2024_10_23_abstrakte_klasse_methode_rev01.png"))
    #grid(
      columns: (80%, 20%),
      gutter: 0.25em,
      body, fig,
    )
  ]
]

#slide[
  #figure(
    image("../assets/img/slides_6/2024_10_24_abstrakt_klasse_methode_baum_rev01.png", height: 90%),
    caption: [Large overview of abstract classes and methods],
  )
]

#slide[
  #task[
    - Now improve the structure of the class hierarchy.
    - Use abstract elements for this.
  ]
  #figure(image("../assets/img/slides_6/2024_10_24_geom_form_ohne_erkl_rev01.png", height: 50%))
]

#slide[
  #text(size: 18pt)[
    - No objects of class Shape, but only of concrete geometric shapes
    - All classes for geometric shapes have getArea().
    - Implementation depends on the type of geometric shape
      #figure(
        image("../assets/img/slides_6/2024_10_24_geom_formen_abst_impl_rev01.png", height: 60%),
        caption: [Abstract and implemented methods],
      )

  ]
]
= Interfaces
== Interfaces
#slide[
  - Classes (as a reminder):
    - Concrete classes cannot contain abstract methods.
    - Abstract classes can additionally contain abstract methods.

  - Basic idea of an interface:
    - Declares only abstract methods
    - Therefore specifies which methods a class must implement
    - Contains no variables (No object creatable: no constructors needed)
    - Often describe properties (e.g. Comparable, Cloneable, Scalable, ...)
]

#slide[
  - Visibility:
    - All methods are public abstract (even when modifiers are missing).
    - All attributes are public static final (even when modifiers were missing).

  - From Java 8 also implemented methods:
    - Default methods: Comparable to conventional methods in a class
    - Static methods
]

#slide[
  #align(center + horizon)[
    #figure(
      image("../assets/img/slides_6/20250813_interface_abstract_real_rev01.png"),
      caption: [Gradient between Real, Abstract and Interface],
    )
  ]
]

#slide[
  #text(size: 20pt)[

    #let body = [
      - Declaration of an interface:
      ```java
      	  Modifier interface InterfaceName {
      		Constants
      		Abstract Methods
      		Default methods and static methods
      	  }
      ```

      - Declare method `resize()` to change size of an object
      ```java
      	public interface Scalable {
      	    void resize(double factor);
      	}
      ```
    ]
    #let fig = figure(image("../assets/img/slides_6/2024_10_24_scalable_interface_rev01.png"))
    #grid(
      columns: (75%, 25%),
      gutter: 0.25em,
      body, fig,
    )
  ]
]

#slide[
  #text(size: 16pt)[
    #let body = [

      - Classes implement interfaces via the keyword implements
      - Class inherits elements of the interface and implements abstract methods
      ```java
      	public class Vector2D implements Scalable {
      	    private double x, y;

      	    public Vector2D(double x, double y) {
      	        this.x = x;
      	        this.y = y;
      	    }

      	    public void resize(double factor) {
      	        x *= factor;
      	        y *= factor;
      	    }
      	    // Additional methods ...
      	}
      ```
    ]
    #let fig = figure(image("../assets/img/slides_6/2024_10_24_scalable_interface_vector_rev01.png"))
    #grid(
      columns: (70%, 30%),
      gutter: 0.25em,
      body, fig,
    )
  ]
]

#slide[
  #text(size: 18pt)[
    - Interface method not implemented: Method remains abstract
    - Therefore the class is also abstract
    - Subclasses only become concrete when all abstract methods are implemented

  ]

  #figure(
    image("../assets/img/slides_6/2024_10_24_scalable_interface_abstrakt_vector_rev01.png", height: 60%),
    caption: [Abstract classes and interfaces],
  )
]

#slide[
  #text(size: 18pt)[
    #let body = [

      - As a reminder: Multiple inheritance for classes not allowed
      - But: Implementation of any number of interfaces (separated by commas) allowed

      ```java
      	interface Interface1 {
      	    // ...
      	}

      	interface Interface2 {
      	    // ...
      	}

      	class ClassA implements Interface1, Interface2 {
      	    // ...
      	}
      ```
    ]
    #let fig = figure(image("../assets/img/slides_6/2024_10_24_double_interface_rev01.png"))
    #grid(
      columns: (80%, 20%),
      gutter: 0.25em,
      body, fig,
    )
  ]
]

#slide[
  #text(size: 16pt)[
    Class GrayImage implements Scalable, Drawable and Rotateable
    ```java
    	public class GrayImage implements Scalable, Drawable, Rotateable {
    	    // Attributes and constructors
    	    // Interface methods
    	    // Additional methods
    }
    ```

    #figure(
      image("../assets/img/slides_6/2024_10_24_grayimage_interface_rev01.png", height: 50%),
      caption: [GrayImage-Beispiel],
    )
  ]
]

#slide[
  #text(size: 16pt)[
    #let body = [

      - Interfaces can be derived through extends.
      - Multiple inheritance is allowed for interfaces!

      ```java
      	interface Interface1 {
      	    // ...
      	}

      	interface Interface2 {
      	    // ...
      	}

      	interface Interface3 extends Interface1, Interface2 {
      	    // ...
      	}

      	class ClassA implements Interface3 {
      	    // ...
      	}
      ```
    ]
    #let fig = figure(image("../assets/img/slides_6/2024_10_24_interface_vererbung_rev01.png"))
    #grid(
      columns: (65%, 35%),
      gutter: 0.25em,
      body, fig,
    )
  ]
]

#slide[
  #text(size: 16pt)[
    #let body = [
      - Just like with base classes:
        - Objects referenceable via data types of their implemented interfaces
        - Reference variable can only access attributes and methods of its interface
        #question[
          - Which accesses to attributes are allowed and which are not?
        ]

      ```java
      	public static void main(String[] args) {
      	    Vector2D classRef = new Vector2D(1, 3);
      	    Scalable interRef = classRef;

      	    classRef.resize(1.5);
      	    System.out.println(classRef.getX());
      	    interRef.resize(1.5);
      	    System.out.println(interRef.getX());
      	}
      ```

    ]
    #let fig = figure(image("../assets/img/slides_6/2024_10_24_scalable_vector_voll_rev01.png"))
    #grid(
      columns: (80%, 20%),
      gutter: 0.25em,
      body, fig,
    )
  ]
]

#slide[
  #text(size: 18pt)[
    #task[
      - Create an interface Transformable with the following methods:
        - Move
        - Rotation by 90° (one method each for rotation left and right)
        - Scale
        - Implement the interface in all classes of geometric shapes
    ]
    #figure(image("../assets/img/slides_6/2024_10_24_geom_form_ohne_erkl_rev01.png", height: 45%))
  ]
]

= Comparison (Interface `Comparable`)

== Interface `Comparable`

#slide[
  #text(size: 18pt)[
    #let body = [
      - Comparison of objects (Which is "larger", which is "smaller"?)

      ```java
      	public interface Comparable<Type> {
      	    public int compareTo(Type other);
      	}
      ```
      - Usage:
        - Implement interface in own class
        - Replace placeholder Type with own class name
        - Return value is interpreted as follows:
      #text(size: 16pt)[
        #align(center + horizon)[
          #figure(
            table(
              columns: (auto, auto),
              inset: 10pt,
              align: left + horizon,
              fill: (_, y) => if calc.odd(y) { green.lighten(90%) },
              table.header([*Return Value*], [*Meaning*]),
              [Negative], [`this < other`],
              [Null], [`this == other`],
              [Positive], [`this > other`],
            ),
            caption: [Formats and Flags],
          )
        ]
      ]
    ]

    #let fig = figure(image("../assets/img/slides_6/2024_10_24_comparable_A_rev01.png"))
    #grid(
      columns: (80%, 20%),
      gutter: 0.25em,
      body, fig,
    )
  ]
]

#slide[
  #text(size: 15pt)[
    #let body = [
      - Comparison of vectors based on magnitude:
      ```java
      	public class Vector2D implements Comparable<Vector2D> {
      	    double x, y;

      	    public double getAbs() {
      	        return Math.sqrt(x * x + y * y);
      	    }

      	    public int compareTo(Vector2D other) {
      	        if (getAbs() < other.getAbs()) {
      	            return -1;
      	        } else if (getAbs() > other.getAbs()) {
      	            return 1;
      	        } else {
      	            return 0;
      	        }
      	    }
      	}
      ```
    ]
    #let fig = figure(image("../assets/img/slides_6/2024_10_24_comparable_vector_rev01.png"))
    #grid(
      columns: (80%, 20%),
      gutter: 0.25em,
      body, fig,
    )
  ]
]

#slide[
  #text(size: 15pt)[
    #let body = [
      - Sort lists via class method `Collections.sort()`
      - Prerequisite: Elements in list implement Comparable
      - Method `sort()` uses the comparison method `compareTo()` pairwise
      ```java
      	public static void main(String[] args) {
      	    ArrayList<Vector2D> vectors = new ArrayList<Vector2D>();
      	    vectors.add(new Vector2D(0, 5));
      	    vectors.add(new Vector2D(0, -1));
      	    vectors.add(new Vector2D(7, 8));
      	    vectors.add(new Vector2D(0, 0));

      	    Collections.sort(vectors);
      	    for (Vector2D vector : vectors) {
      	        System.out.println(vector.getAbs());
      	    }
      	}
      ```


    ]
    #let fig = figure(image("../assets/img/slides_6/2024_10_24_comparable_vector_rev01.png"))
    #grid(
      columns: (80%, 20%),
      gutter: 0.25em,
      body, fig,
    )
  ]
]

#slide[
  #text(size: 18pt)[
    #task[
      - Implement `Comparable<Type>` for geometric objects.
      - Criterion for the comparison is the area of the objects.
    ]
    #figure(image("../assets/img/slides_6/2024_10_24_geom_form_ohne_erkl_rev01.png", height: 50%))

  ]
]

#slide[
  #text(size: 18pt)[
    #memo[
      - Only the class `Shape` must implement `Comparable`.
      - The remaining classes inherit the interface and implementation.
    ]
    #figure(image("../assets/img/slides_6/2024_10_24_comparable_shape_rev01.png", height: 50%))

  ]
]

#slide[
  #text(size: 15pt)[
    - Implementation in Shape:
    ```java
    public abstract class Shape implements Comparable<Shape> {
        // Attributes and other methods ...

        public int compareTo(Shape other) {
            double thisArea = getArea();
            double otherArea = other.getArea();

            if (thisArea < otherArea) {
                return -1;
            } else if (thisArea > otherArea) {
                return 1;
            } else {
                return 0;
            }
        }
    }
    ```
  ]
]

#slide[
  #text(size: 15pt)[
    ```java
    	public static void main(String[] args) {
    	    ArrayList<Shape> shapes = new ArrayList<Shape>();
    	    shapes.add(new Circle(0.0, 0.0, 2.0));
    	    shapes.add(new Circle(0.0, 0.0, 1.0));
    	    shapes.add(new Rectangle(0.0, 0.0, 10.0, 5.0));
    	    shapes.add(new Square(0.0, 0.0, 0.5));

    	    System.out.println("Areas (unsorted):");
    	    for (Shape shape : shapes) {
    	        System.out.println(shape.getArea());
    	    }

    	    Collections.sort(shapes);
    	    System.out.println("\nAreas (sorted):");
    	    for (Shape shape : shapes) {
                System.out.println(shape.getArea());
            }
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
