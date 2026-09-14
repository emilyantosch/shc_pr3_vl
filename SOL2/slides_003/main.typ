#import "@preview/touying:0.5.2": *
#import themes.university: *

#import "@preview/fletcher:0.5.1" as flechter: diagram, edge, node

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
    subtitle: [Lecture 3 - Classes and Objects],
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
  - Last time we dealt with the imperative concepts of the Java programming language.
  - You can now
    - use simple data types in Java,
    - control program flow with control structures and loops, and
    - convert data types.
  - Today we'll cover *Classes and Objects*.
]

#slide[
  1. Imperative Concepts
  2. *Classes and Objects*
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

  - You will implement classes and objects in Java to model real things.
  - You will create objects of a class and change their state through operations.
  - You will apply additional programming guidelines to improve the quality and
    maintainability of your code.
]

= Classes and Objects
== Class
#slide[
  - A *class* is a blueprint for objects. It contains
    - *Attributes* (data fields) and
    - *Methods* (operations).
  - Together, attributes and methods are called *members*.
  #align(left + horizon)[
    #figure(
      image("../assets/img/slides_3/20250730_attributes_methods_rev01.png", height: 50%),
      caption: [UML notation of a Person class],
    )
  ]
]

#slide[
  - Data record of a class created in memory at runtime
  - Variables describe the *state* of the object
  - Methods describe the *capabilities* of the object
  - Terms for variables: *attributes*, *object variables*, *instance variables*

  #figure(
    image(
      "../assets/img/slides_3/2024_10_10_klassen_methoden_attribute_rev01.png",
      height: 45%,
    ),
    caption: [Division of methods and attributes],
  )
]
== Relationship Between Class and Object
#slide[
  - Class: Description ("blueprint") of a data type
  - Object of a class: Created element of the data type
  - Any number of objects of a class can be created.

  #figure(
    image("../assets/img/slides_3/2024_10_10_klassen_mehr_objekte_rev01.png", height: 60%),
    caption: [Multiple objects from one class],
  )
]

== Classes in Java
#slide[
  - Classes can be declared using the following code:
  ```java
  class ClassName {
      Attributes
      Methods
      }
  ```

  #tip[Create each class in its own file!]

]

== Example: Simple Class
#slide[
  #task[Let us create this simple class:
    - Class Student, described by name, student number and year of enrollment
  ]

  #pause

  ```java
  class Student {
      String name;
      int matrNumber;
      int enrolledYear;
    }
  ```

  - The class has neither methods nor data encapsulation against external influence.

  #figure(
    image("../assets/img/slides_3/2024_10_10_klassen_uml_student_rev01.png"),
    caption: [UML representation of the class we just created],
  )
]

== Example: One Class, Many Objects
#slide[
  - Class ("One class for all students"):
    - The class is a new data type.
    - Defines what data describes students

  - Objects ("A separate object for each student"):
    - Objects are instances in memory.
    - Have the structure of the class, but are filled with data
    - Any number of objects can be created.

  #figure(
    image("../assets/img/slides_3/2024_10_10_klassen_mehr_objekte_uml_rev01.png"),
    caption: [Multiple objects can be created from one class],
  )
]

== Example: Local Variables
#slide[
  #question[What values do the variables `count`, `jan` and `lena` have?]

  ```java
  public class StudentDemo {
      public static void main(String[] args) {
          int count;
          Student lena, jan;
      }
    }
  ```
]

#slide[
  #question[What values do the variables `count`, `jan` and `lena` have?]
  #figure(
    image(
      "../assets/img/slides_3/20250813_class_vs_primitive_rev01.png",
      height: 50%,
    ),
    caption: [Primitive data types vs. Objects],
  )
]

== Example: `new` Operator
#slide[
  - Objects are created using the `new` operator.
    ```java
    public class StudentDemo {
        public static void main(String[] args) {
            int count;
            Student lena, jan;
            lena = pin1nepin2wpin3 Student();
        }
    }
    ```
  #pinit-rect-from(2, [`new`-Operator])
  #pinit-highlight(1, 3)

]

#slide[
  - Step 1: `new` operator creates object.
    - Reserve memory space for object (with object variables).
    - Initialize object variables with default values (more on this soon).

    #figure(
      image("../assets/img/slides_3/2024_10_10_klassen_primitv_vergleich.png"),
      caption: [Creating reference with `new`],
    )

]

#slide[
  - Step 2: Assignment
    - Writes reference ("address") of the new object to variable `lena`.
    - Is independent of the `new` operator and the creation of the object

    #figure(
      image("../assets/img/slides_3/2024_10_10_klassen_primitiv_zuordnung_rev01.png"),
      caption: [Assignment of reference to variable],
    )
]

= Variables and Memory
== Objective
#slide[
  #conclusion[
    - We have already looked at this:
      - What are classes and objects?
      - How do you declare classes?
      - How do you create objects?
  ]

  - In the following we want to look at the following aspects:
    - Access to object variables
    - Initialization of object variables
    - Assignment of references
    - Automatic memory management
]

== Access to Object Variables
#slide[
  - Access to object variables is done using the dot operator:
  ```java
  ObjectReference.Member
  ```
  - The `ObjectReference` is a reference to an object that is stored in a
    variable.
  - `Member` is, for example, an attribute/object variable
]

#slide[
  #question[What will be output?]
  #text(size: 16pt)[

    ```java
    public class StudentDemo1 {
        public static void main(String[] args) {
          Student lena = new Student();
          System.out.println("Enrolled: " + lena.enrolledYear);
          lena.name = "Lena";
          lena.matrNumber = 591753;
          lena.enrolledYear = 2012;
          System.out.println("Enrolled: " + lena.enrolledYear);
        }
      }
    ```
  ]
]
== Initialization of Classes
#slide[
  #align(left + horizon)[

    #memo[
      - *Object/Instance variable*: Declared in class as an attribute of an object.
      - *Local variable*: Declared locally (e.g. in method or loop).
      - *Reference variable*: Has class as data type, can store reference to object.
    ]
  ]
]

#slide[
  - As a reminder:
    - Local variables are not automatically initialized. (Compiler prevents
      access.)
    - Object variables, however, are initialized when an object is created.

  #text(size: 22pt)[
    #align(center + horizon)[
      #figure(
        table(
          columns: (auto, auto, auto),
          inset: 10pt,
          align: left + horizon,
          fill: (_, y) => if calc.odd(y) { green.lighten(90%) },
          table.header([*Type*], [*Data Type*], [*Initial Value*]),
          [Integer and Character], [`byte, short, int, long, char`], [0],
          [Floating Point], [`float, double`], [0.0],
          [Truth], [`boolean`], [`false`],
          [Reference], [Any Class], [`null`],
        ),
        caption: [Value ranges of data types],
      )
    ]
  ]
]

#slide[
  - Initial values can also be set in the class itself.

  ```java
  class Student {
    String name = "Unknown";
    int matrNumber;
    int enrolledYear = 2019;
  }
  ```
]

#slide[
  #question[What will be output in the following code?]
  #text(size: 16pt)[

    ```java
    public class StudentDemo {
        public static void main(String[] args) {
          Student lena = new Student();
          System.out.println("Name:     " + lena.name);
          System.out.println("Number:   " + lena.matrNumber);
          System.out.println("Enrolled: " + lena.enrolledYear);
          lena.name = "Lena";
          System.out.println("Name:     " + lena.name);
        }
      }
    ```
  ]
]

== Assignment of References
#slide[
  - Assume we have the following state in our code:

  #figure(
    image("../assets/img/slides_3/2024_10_10_klassen_referenz_zuweisung_rev01.png"),
    caption: [Assignment of references to variables],
  )
]

#slide[
  #question[
    What happens now if we add the following code:
    ```java
    jan = lena;
    ```
  ]
]
#slide[
  #align(left + horizon)[
    #figure(
      image("../assets/img/slides_3/2024_10_10_klassen_referenzen_verschieben_rev01.png"),
      caption: [Moving references],
    )
  ]
]

#slide[
  #question[What will be output when you execute the following code afterwards?]
  ```java
  lena.name = "Birgit";
  jan.name = "Kai";
  System.out.println(lena.name);
  System.out.println(jan.name);
  ```
]

#slide[
  - Jan and Lena now reference the *same* object. Changes to values via `jan` also affect
    `lena`.

  #figure(
    image("../assets/img/slides_3/2024_10_14_referenzen_selbes_objekt_rev01.png"),
    caption: [Both variables point to the same reference],
  )

]

#slide[
  - The object that was previously referenced via `jan` now has no reference
    anymore.
  - Thus there is *no* way to access the object anymore.
  - The *Garbage Collector* will free the memory again using *Reference Counting*.
  - There is no `free` or `delete` like in C!

    #figure(
      image("../assets/img/slides_3/2024_10_14_referenz_objekt_verschwindet_rev01.png"),
      caption: [The Garbage Collector frees memory],
    )
]

= Methods
== Methods: Syntax
#slide[
  - Methods correspond to functions from C, which you already know.
  #text(size: 22pt)[
    ```java
    ReturnType MethodName(Parameters) {
     Statement;
    }
    ```
  ]
  - Return type
    - Primitive data type, class of an object or `void`.
    - Return is done as in C using `return`.
  - Method name
    - Any valid identifier (see Chapter 2)
    - From our coding style: *camelCase* (I also allow *snake_case*)

]

#slide[
  #text(size: 24pt)[
    - Methods correspond to functions from C, which you already know.
      ```java
      ReturnType MethodName(Parameters) {
       Statement;
      }
      ```
    - Parameters
      - Empty or comma-separated parameters
      - Each parameter is in the form: `datatype identifier`
    - Call
      - Method name followed by parentheses
      - Arguments in the parentheses
      - Expression is replaced by return value
  ]
]

== Methods: Examples

#slide[
  #task[Calculate the average of two floating-point numbers.]

  #pause

  ```java
  public class MathUtils {
        double average(double a, double b) {
            return (a + b) / 2.0;
        }
    }
  ```
]

#slide[
  ```java
    public class MathUtilsDemo {
        public static void main(String[] args) {
            MathUtils math = new MathUtils();
            double a1 = 3.5, a2 = 7;
            double mean = math.average(a1, a2);
            System.out.println(mean);
            System.out.println(math.average(1.5, 3.2));
        }
    }
  ```
]

#slide[
  #task[Calculate the sum of all digits of an integer.]

  #pause

  #text(size: 17pt)[
    ```java
    public class MathUtils {
          int sumOfDigits(int number) {
              int sum = 0;
              while(number > 0) {
                  sum += number % 10;
                  number /= 10;
              }
              return sum;
          }
      }
    ```
  ]

]
#slide[
  ```java
    public class MathUtilsDemo {
        public static void main(String[] args) {
            MathUtils math = new MathUtils();
            System.out.println(math.sumOfDigits(0));
            System.out.println(math.sumOfDigits(2016));
        }
    }
  ```
]

== Getters and Setters
#slide[
  #memo[
    - *Getter*: Method that returns the value of an instance variable
    - *Setter*: Method that assigns a (passed) value to an instance variable
  ]
]

#slide[
  #text(size: 22pt)[
    ```java
    public class Student {
      String name;

      void setName(String studentName){
        name = studentName;
      }

      String getName(){
        return name;
      }

    }
    ```
  ]
]

== Methods: Call-by-Value

#slide[

  - Parameter passing when calling a method:
    - Basically the value of the variable is passed ("Call by value").
    - Not possible to pass a kind of "pointer" to the variable.
    - In method, the variable used in the method call cannot be changed.

  ```java
  double square(double a) {
        a = a * a; // Local, does NOT modify b in main()
        return a;
    }
  ```
]

#slide[
  #align(left + horizon)[
    #figure(
      image("../assets/img/slides_3/20250813_call_by_value_rev01.png", height: 90%),
      caption: [Diagram for Call-by-Value],
    )
  ]
]

== Methods: Objects as Parameters

- Reference variables as parameters:
  - Value (i.e. stored reference) of the passed variable is not changed.
  - But: The referenced object can be changed!

```java
public class CallByValueDemo {
      static void setNameBirgit(Student student) {
          student.name = "Birgit";
          System.out.println(student.name);
      }
```
#slide[
  #align(left + horizon)[
    ```java
    public static void main(String[] args) {
              Student lena = new Student();
              lena.name = "Lena";
              setNameBirgit(lena);
              System.out.println(lena.name);
          }
      }
    ```
  ]
]

#slide[

  - Original state in `main()` method:

  #figure(
    image("../assets/img/slides_3/2024_10_14_referenz_lena_objekt_rev01.png"),
    caption: [Initial state],
  )
]

#slide[

  - Call of the (meaningless) method `setNameBirgit()`:

  #figure(
    image("../assets/img/slides_3/2024_10_14_referenz_lena_student_verschieben_rev01.png"),
    caption: [Moving the reference to the method],
  )
]

#slide[

  - Modification of the object in the method `setNameBirgit()`:

  #figure(
    image("../assets/img/slides_3/2024_10_14_referenz_lena_student_birgit_rev01.png"),
    caption: [Modification of object in method],
  )
]

== this Reference

#question[Look at the following code. What is unsightly?]

```java
public class Student {
      String name;

      void setName(String newName) {
          name = newName;
      }
  }
```

#slide[
  - We would like to name the parameter of the setter `name` as well!

  #question[Does the following call work?]

  ```java
  void setName(String name) {
      name = name;
  }
  ```
  #pause
  - No! The compiler would use the local variable in each case.
  - How can we access the instance variable?
]

#slide[
  #memo[
    - Using `this` we can access the current instance we are
      currently in.
  ]
  #text(size: 20pt)[
    ```java
    public class Student {
          String name;

          void setName(String name) {
              this.name = name;
          }
      }
    ```
  ]
]

#slide[
  - So
    - If you want to access a local variable, simply use the
      identifier of the variable
    - If you want to access an instance variable, use the `this` reference
      with the member operator with `.`.

  #figure(
    image("../assets/img/slides_3/2024_10_14_this_diagramm_rev01.png", height: 40%),
    caption: [`this` reference],
  )
]

== Overloading

#slide[
  #task[Write a method that calculates the maximum of two integers.]
  #text(size: 22pt)[
    ```java
    int max(int a, int b) {
          if (a > b) {
              return a;
          } else {
              return b;
          }
      }
    ```
  ]
]

#slide[
  #task[Write another method in the same class that calculates the maximum of two `double` numbers.]

  ```java
  double max(double a, double b) {
        return (a > b) ? a : b;  // Compact if/else syntax
    }
  ```
]

#slide[
  #task[Write yet another method in the same class that returns the maximum
    of three integers.]

  ```java
  int max(int a, int b, int c) {
       return max(max(a, b), c);
    }
  ```
]

#slide[
  - Overloaded methods (overloading):
    - Multiple methods with the same name exist in a class.
    - Only possible if parameter types are different.
    - Compiler selects the correct method based on the parameters.

  ```java
  int max(int, int)
  double max(double, double)
  int max(int, int, int)
  ```
]

#slide[
  - Note:
    - Signature: Method name and parameter types
    - Only data types of parameters relevant (distinction by names not possible)
    - Distinction by return type is not sufficient (Why?)
]

#slide[
  #memo[- These are not the same methods!]
  #text(size: 18pt)[
    #align(left + horizon)[
      #grid(
        gutter: 12pt,
        columns: (auto, auto),
        [
          ```java
          int max(int a, int b) {
              if (a > b) {
                  return a;
              } else {
                  return b;
              }
          }
          ```
        ],
        [
          ```java
          short max(short a, short b) {
                System.out.println("Aaaarrrghhh!");
                return 7;
          }
          ```
        ],
      )
    ]
  ]
]

== Methods: Coding Style
#slide[
  - Blank lines should increase code readability.
  - A blank line is mandatory between methods or classes (1).
  - A blank line is usually placed after declarations (2).
  - A blank line is usually placed between logical sections.
]

#slide[
  #example[

    #text(size: 16pt)[
      ```java
      public class MyClass {

         public static int max(int a, int b) {
            return (a > b) ? a : b;
         }

         public static void swap(Object a, Object b) {
            Object temp;

            temp = a;
            a = b;
            b = temp;
         }
      }
      ```
    ]
  ]
]

#slide[
  - Spaces should increase code readability.
  - A space is mandatory between expressions.
  - A space is usually placed between operands.

    #text(size: 18pt)[
      #align(left + horizon)[
        #grid(
          gutter: 12pt,
          columns: (auto, auto),
          [
            ```java
            public static void main(String[] args) {
               int a = 5;

               for (int i = 1; i < 10; i++) {
                  a *= i;
               }
            }
            ```
          ],
          [
            ```java
            public static void main(String[] args) {
               int a=5;

               for(int i=1;i<10;i++){
                  a*=i;
               }
            }
            ```
          ],
        )
      ]
    ]
]

== What a chapter!

- We have accomplished a lot in this section!
  - Syntax of methods
  - Parameters (call by value)
  - this reference
  - Overloading methods
  - Coding Style

Let us now look at how to specifically create and
initialize objects.

= Constructors

== Constructors

#memo[
  - Special methods for initializing an object
    - Are executed when an object is created
    - Note: Constructors have no return type
]

```java
ClassName(Parameters){
Statements;
}
```

#slide[
  - Using the following code, one could create a constructor for the class `Student`:

  ```java
  public class Student {
        String name;

        Student(String name) {  // Attention: No return type
            this.name = name;
        }
    }
  ```
]

#slide[
  - Default constructor: Constructor with empty parameter list
  - Initializes instance variables depending on type with 0, 0.0, `false` or `null`

  #example[
    ```java
    public class Student {
          String name;

          Student() {      // Default constructor
          }
      }
    ```
  ]
]

#slide[
  - The previous example could also be represented like this:
  ```java
  public class Student {
        String name;

        Student() {      // Default constructor
            name = null;
        }
    }
  ```
]

#slide[
  - Compiler automatically generates the default constructor under certain conditions
  - Simple rules:
  1. If you don't write a constructor for a class:
    - The compiler automatically generates the default constructor
  2. If you write at least one constructor for a class:
    - The compiler does not generate a constructor
    - Only the constructors you implemented exist
]

== `this`: Reference vs. Method
#slide[
  - `this` reference (as a reminder):
    - Use within any (instance) method
    - Used like a variable
    - Contains reference to object for which the method was called

  - `this()` method
    - Use only within a constructor.
    - Is a method call.
    - this(parameter list) calls constructor with matching parameter list.
    - May only stand as the first statement in the constructor.
]

#slide[
  #text(size: 15pt)[

    ```java
    public class Aircraft {
          String model, airline;
          int numberEngines;

          Aircraft() {
              numberEngines = 1;
          }

          Aircraft(String model) {
              this();
              this.model = model;
          }

          Aircraft(String model, String airline) {
              this(model);
              this.airline = airline;
          }
      }
    ```
  ]
]

== Constructors: Examples

#slide[
  #question[Will the following code compile? What do you think?]
  ```java
  public class Aircraft {
        String model;

        public static void main(String[] args) {
            Aircraft aircraft = new Aircraft();
        }
    }
  ```
]

#slide[
  #success[
    - Yes, it will!
      - The compiler generates a default constructor because the class does not contain one.
      - This is then called in the `main()` method!
  ]
]
#slide[
  #question[Will the following code compile? What do you think?]
  #text(size: 16pt)[

    ```java
    public class Aircraft {
          String model;

          Aircraft(String model) {
              this.model = model;
          }

          public static void main(String[] args) {
              Aircraft aircraft = new Aircraft();
          }
      }
    ```
  ]
]

#slide[
  #error[
    - No, it will not!
      - Since the class contains a constructor, the compiler does not generate a
        default constructor.
      - The constructor used in the `main()` method therefore does not exist.
  ]
]
== Task: Class Circle
#slide[
  #text(size: 21pt)[
    #task[
      - Let us write a class Circle:
        - Represents a geometric circle
          - Represented by
          - x and y coordinates of the center point
          - Radius r
        - Constructors:
          - Default constructor creates unit circle around coordinate origin (0 ; 0)
          - Constructor with x, y and radius as parameters
          - Constructor with radius as parameter
          - Constructor with object of class Circle as parameter (creates copy)
    ]
  ]
]

#slide[
  #text(size: 16pt)[
    ```java
    public class Circle {
      double x, y, radius;

      public Circle(double x, double y, double radius) {
          this.x = x;
          this.y = y;
          this.radius = radius;
      }

      Circle() {
          this(0.0, 0.0, 1.0);
      }

      Circle(double radius) {
          this(0.0, 0.0, radius);
      }

      Circle(Circle circle) {
          this(circle.x, circle.y, circle.radius);
      }
    }
    ```
  ]
]

#slide[
  #text(size: 18pt)[
    - The class we just wrote can be created as follows:

      ```java
      public class CircleDemo {
            public static void main(String[] args) {
                Circle circle1 = new Circle();
                Circle circle2 = new Circle(2.5);
                Circle circle3 = new Circle(circle2);
                Circle circle4 = new Circle(-1.2, 7.1, 3.0);
            }
        }
      ```

    #tip[
      The following menu item in IntelliJ IDEA can save you a lot of work: Code /
      Generate / Constructor
    ]
  ]
]

#slide[
  #task[Extend the class with getter and setter methods.]
  #tip[Via the menu items Code / Generate / Getter and Setter you can save even more
    time!]
]

#slide[
  #text(size: 20pt)[
    ```java
    double getX() {
        return x;
    }

    // getY() and getRadius() accordingly

    void setX(double x) {
        this.x = x;
    }

    void setY(double y) {
        this.y = y;
    }

    void setRadius(double radius) {
        if (radius >= 0.0) {        // Prevent disallowed data
            this.radius = radius;
        }
    }
    ```
  ]
]

= Class Variables & Class Methods

== Class Variables

#slide[
  #question[Do you think you reserve the variable `PI` only once in memory?]
  #text(size: 18pt)[
    ```java
    public class Circle {
          double x, y, radius;
          final double PI = 3.141592653589793;

          double getArea() {
              return PI * radius * radius;
          }
      }
    ```
  ]
]

#slide[
  #error[
    - Answer: No, again for each object!
  ]

  #figure(
    image("../assets/img/slides_3/2024_10_14_objekt_circle_rev01.png", height: 40%),
    caption: [Memory is reserved again for each object.],
  )
]

#slide[
  #question[What do you think, does the variable `count` count the number of objects?]
  #text(size: 17pt)[
    ```java
    public class Circle {
          double x, y, radius;
          int count;    // Count number of objects created

          Circle() {
              radius = 1.0;
              count++;
          }
      }
    ```
  ]
]

#slide[
  #error[
    - Answer: No, each object gets a new variable `count`!
  ]

  #figure(
    image("../assets/img/slides_3/2024_10_15_circle_count_rev01.png", height: 40%),
    caption: [The variable `count` is created again and again.],
  )
]

#slide[

  - One solution is *class variables*!
  - Class variables are created only once for the entire class
  - Are not created for a specific (not for each object) object
  - Are already created at program start (loading the class)
    - They exist even when there is (still) no object of the class.
  - Syntax: Variable with keyword static
]

#slide[
  #figure(
    image("../assets/img/slides_3/2024_10_15_klassenattribute_rev01.png"),
    caption: [Class attributes in the different objects],
  )
]

#slide[
  - Class `Circle` with class variables:
    #text(size: 17pt)[

      ```java
      public class Circle {
            double x, y, radius;
            static final double PI = 3.141592653589793;
            static int count;

            double getArea() {
                return PI * radius * radius;
            }

            Circle() {
                radius = 1.0;
                count++;
            }
        }
      ```
    ]
]

#slide[
  - Access to class variables
    - Within the method of the class it corresponds to access to instance variables
    - Outside the class ```java ClassName.VariableName```
    #text(size: 18pt)[

      ```java
        public class CircleDemo {
              public static void main(String[] args) {
                  Circle circle1 = new Circle();
                  Circle circle2 = new Circle();
                  Circle circle3 = new Circle();

                  System.out.println("Number of objects: " + Circle.count);
              }
          }
      ```

    ]
]

== Class Methods

#slide[

  - Completely analogous to class variables:
    - Class methods are called for a class
    - Are not called for a specific object
    - Method becomes class method through keyword static
    - Can be called without object of the class being created

  - Call outside the class:
  ```java
  ClassName.MethodName
  ```
]

#slide[
  #memo[
    - Important consequences:
      - `this` reference does not exist in class methods
      - Instance variables do not exist in class methods
  ]
]

#slide[
  #example[
    - In this example there are two class methods!
      #text(size: 14pt)[

        ```java
        public class Circle {
              double x, y, radius = 1.0;

              static double getPi() {
                  return 3.141592653589793;
              }
          }

          public class CircleDemo {
              public static void main(String[] args) {
                  System.out.println("Pi: " + Circle.getPi());
              }
          }
        ```

      ]
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
