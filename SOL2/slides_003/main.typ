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
    short-title: [Java · Lecture 3],
    subtitle: [Lecture 3 - Classes and Objects],
    author: [Emily Lucia Antosch],
    date: datetime.today().display("[day].[month].[year]"),
    institution: [HAW Hamburg],
  ),
)

// Codly renders lines as grid rows; vertical inset controls their spacing.
#show raw.where(block: true): it => {
  codly(inset: (x: .32em, y: .22em))
  it
}

#title-slide(authors: [Emily Lucia Antosch])
#outline-slide()

= Introduction
== Where Are We Now?
#slide[
  #diagram("roadmap", height: 200pt)
]

== The Goal of This Chapter
#slide[
  - Model data and behavior with classes.
  - Create objects and change their state through methods.
  - Distinguish instance members from class members.
]

= Classes and Objects
== Class
#slide[
  A class is a "blueprint" for objects.
  #v(12pt)
  #diagram("members", height: 270pt)
]

== Relationship Between Class and Object
#slide[
  #diagram("person-instances", height: 290pt)
]

== Classes in Java
#slide[
  ```java
  class ClassName {
      // Fields
      // Methods
  }
  ```
  #tip[Use one source file per class: `ClassName.java`.]
]

== Example: Simple Class
#slide[
  #task[Model a student with a name, student number, and enrollment year.]
]

#slide[
  #grid(columns: (1fr, 1fr), gutter: 24pt,
    [
      ```java
      class Student {
          String name;
          int matrNumber;
          int enrolledYear;
      }
      ```
    ],
    [#diagram("student-class", height: 190pt)],
  )
  No methods or encapsulation yet.
]

== Example: One Class, Many Objects
#slide[
  #diagram("student-instances", height: 290pt)
]

== Example: Local Variables
#slide[
  #question[What values do `count`, `lena`, and `jan` have?]
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
  #diagram("locals", height: 250pt)
]

== Example: `new` Operator
#slide[
  ```java
  public class StudentDemo {
      public static void main(String[] args) {
          int count;
          Student lena, jan;
          lena = new Student();
      }
  }
  ```
  `new Student()` creates an object. `=` stores its reference.
]

#slide[
  *1. Create the object*: allocate memory and initialize fields.
  #v(12pt)
  #diagram("allocate", height: 240pt)
]

#slide[
  *2. Assign the reference* to `lena`.
  #v(12pt)
  #diagram("assign", height: 240pt)
]

= Variables and Memory
== Access to Object Variables
#slide[
  Use the dot operator: `objectReference.member`.
  #v(16pt)
  #diagram("access", height: 210pt)
]

#slide[
  #question[What will this print?]
  #text(17pt)[
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

== Variables: Scope and Type
#slide[
  #diagram("variable-kinds", height: 260pt)
]

== Initialization
#slide[
  #diagram("initialization", height: 230pt)
]

#slide[
  *Default field values* — not defaults for local variables.
  #v(14pt)
  #text(21pt)[
    #table(
      columns: (1fr, 1fr), inset: 12pt,
      fill: (_, y) => if calc.odd(y) { palette.surface },
      table.header([*Type*], [*Default*]),
      [`byte`, `short`, `int`, `long`], [`0`],
      [`char`], [`'\u0000'`],
      [`float`, `double`], [`0.0`],
      [`boolean`], [`false`],
      [Reference type], [`null`],
    )
  ]
]

#slide[
  A field initializer replaces the default value.
  ```java
  class Student {
      String name = "Unknown";
      int matrNumber;
      int enrolledYear = 2019;
  }
  ```
]

#slide[
  #question[What will this print?]
  #text(17pt)[
    ```java
    public class StudentDemo {
        public static void main(String[] args) {
            Student lena = new Student();
            System.out.println("Name: " + lena.name);
            System.out.println("Number: " + lena.matrNumber);
            System.out.println("Enrolled: " + lena.enrolledYear);
            lena.name = "Lena";
            System.out.println("Name: " + lena.name);
        }
    }
    ```
  ]
]

== Assignment of References
#slide[
  Two references, two objects.
  #v(12pt)
  #diagram("references", height: 250pt)
]

#slide[
  #question[What changes after `jan = lena;`?]
]

#slide[
  #diagram("alias", height: 290pt)
]

#slide[
  #question[What will this print after `jan = lena;`?]
  ```java
  lena.name = "Birgit";
  jan.name = "Kai";
  System.out.println(lena.name);
  System.out.println(jan.name);
  ```
]

#slide[
  Both print `Kai`: the variables refer to the *same object*.
  #v(12pt)
  #diagram("mutation", height: 250pt)
]

== Garbage Collection
#slide[
  #diagram("garbage", height: 260pt)
  Automatic, not immediate. No `free` or `delete`.
]

= Methods
== Methods: Syntax
#slide[
  ```java
  ReturnType methodName(Type parameter, ...) {
      // Statements
      return value;
  }
  ```
  #v(12pt)
  #diagram("method-signature", height: 120pt)
  `void` methods return no value.
]

== Methods: Examples
#slide[
  #task[Calculate the average of two floating-point numbers.]
]

#slide[
  ```java
  public class MathUtils {
      double average(double a, double b) {
          return (a + b) / 2.0;
      }
  }
  ```
]

#slide[
  #text(18pt)[
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
]

#slide[
  #diagram("method-call", height: 230pt)
]

#slide[
  #task[Calculate the digit sum of a non-negative integer.]
]

#slide[
  #text(19pt)[
    ```java
    public class MathUtils {
        int sumOfDigits(int number) {
            int sum = 0;
            while (number > 0) {
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
  #diagram("accessors", height: 150pt)
  #v(20pt)
  #set text(size: 18pt)
  #grid(columns: (1fr, 1fr), gutter: 24pt,
    [
      ```java
      void setName(String value) {
          name = value;
      }
      ```
    ],
    [
      ```java
      String getName() {
          return name;
      }
      ```
    ],
  )
]

== Methods: Call-by-Value
#slide[
  Java copies argument values into local parameter variables.
  ```java
  double square(double a) {
      a = a * a;
      return a;
  }
  ```
  ```java
  double b = 3.0;
  double result = square(b);
  ```
]

#slide[
  #diagram("call-by-value", height: 280pt)
]

== Methods: Objects as Parameters
#slide[
  The reference is copied; the object is *not* copied.
  #text(19pt)[
    ```java
    public class CallByValueDemo {
        static void setNameBirgit(Student student) {
            student.name = "Birgit";
            System.out.println(student.name);
        }
        // main() follows on the next slide
    }
    ```
  ]
]

#slide[
  #text(19pt)[
    ```java
    public static void main(String[] args) {
        Student lena = new Student();
        lena.name = "Lena";
        setNameBirgit(lena);
        System.out.println(lena.name);
    }
    ```
  ]
  Both calls to `println` print `Birgit`.
]

#slide[
  *Before the call*
  #v(12pt)
  #diagram("parameter-before", height: 200pt)
]

#slide[
  *Pass a copy of the reference*
  #v(12pt)
  #diagram("parameter-copy", height: 250pt)
]

#slide[
  *Modify the shared object*
  #v(12pt)
  #diagram("parameter-mutate", height: 250pt)
  Reassigning `student` would not reassign `lena`.
]

== The `this` Reference
#slide[
  #question[Can the parameter have the same name as the field?]
  ```java
  public class Student {
      String name;

      void setName(String newName) {
          name = newName;
      }
  }
  ```
]

#slide[
  #question[Does this change the field?]
  ```java
  void setName(String name) {
      name = name;
  }
  ```
  #pause
  No. Both names refer to the parameter; it hides the field.
]

#slide[
  `this` refers to the object whose method is running.
  ```java
  public class Student {
      String name;

      void setName(String name) {
          this.name = name;
      }
  }
  ```
]

#slide[
  #diagram("this-reference", height: 230pt)
]

== Overloading
#slide[
  #task[Write a method that returns the maximum of two integers.]
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

#slide[
  #task[Add a method for two `double` values.]
  ```java
  double max(double a, double b) {
      return (a > b) ? a : b;
  }
  ```
]

#slide[
  #task[Add a method for three integers.]
  ```java
  int max(int a, int b, int c) {
      return max(max(a, b), c);
  }
  ```
]

#slide[
  #diagram("overloads", height: 260pt)
  Parameter names and return types do *not* distinguish overloads.
]

#slide[
  Same method name does not guarantee the same behavior.
  ```java
  int max(int a, int b) {
      return (a > b) ? a : b;
  }

  short max(short a, short b) {
      System.out.println("Aaaarrrghhh!");
      return 7;
  }
  ```
]

== Methods: Coding Style
#slide[
  Use `camelCase` (`snake_case` also accepted here).
  Use blank lines between methods and logical steps.
  ```java
  double average(double a, double b) {
      return (a + b) / 2.0;
  }

  int max(int a, int b) {
      int result = (a > b) ? a : b;

      return result;
  }
  ```
]

#slide[
  Use spaces around operators and after commas. Keep indentation consistent.
  #v(12pt)
  #set text(size: 17pt)
  #grid(columns: (1fr, 1fr), gutter: 24pt,
    [
      *Readable*
      ```java
      int a = 5;
      for (int i = 1; i < 10; i++) {
          a *= i;
      }
      ```
    ],
    [
      *Cramped*
      ```java
      int a=5;
      for(int i=1;i<10;i++){
          a*=i;
      }
      ```
    ],
  )
]

= Constructors
== Constructors
#slide[
  A constructor initializes a new object. It has the class name and *no return type*.
  ```java
  public class Student {
      String name;

      Student(String name) {
          this.name = name;
      }
  }
  ```
]

#slide[
  #diagram("construction", height: 180pt)
]

== No-Argument and Default Constructors
#slide[
  This is an *explicit no-argument constructor*.
  ```java
  public class Student {
      String name;

      Student() {
      }
  }
  ```
  `name` is already `null` before the constructor body runs.
]

#slide[
  #diagram("default-constructor", height: 250pt)
  The compiler-generated no-argument constructor is the *default constructor*.
]

== `this` vs. `this(…)`
#slide[
  - `this`: reference to the current object.
  - `this(…)`: call another constructor in the same class.
  - In these examples, constructor delegation comes first.
  #v(16pt)
  #diagram("constructor-chain", height: 190pt)
]

#slide[
  ```java
  public class Aircraft {
      String model, airline;
      int numberEngines;

      Aircraft() {
          numberEngines = 1;
      }
      // Overloaded constructors follow
  }
  ```
]

#slide[
  Add these constructors inside `Aircraft`:
  ```java
  Aircraft(String model) {
      this();
      this.model = model;
  }

  Aircraft(String model, String airline) {
      this(model);
      this.airline = airline;
  }
  ```
]

== Constructors: Examples
#slide[
  #question[Will this compile?]
  ```java
  public class Aircraft {
      String model;

      public static void main(String[] args) {
          Aircraft aircraft = new Aircraft();
      }
  }
  ```
  #pause
  Yes. The compiler supplies `Aircraft()`.
]

#slide[
  #question[Will `new Aircraft()` compile with this class?]
  ```java
  public class Aircraft {
      String model;
      Aircraft(String model) {
          this.model = model;
      }
  }
  ```
  #pause
  No. Only `Aircraft(String)` exists; `Aircraft()` is missing.
]

== Task: Class Circle
#slide[
  #task[Model a circle. Implement these four constructors.]
  #diagram("circle-task", height: 260pt)
]

#slide[
  #text(18pt)[
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
        // Two more constructors follow
    }
    ```
  ]
]

#slide[
  Add these constructors inside `Circle`:
  ```java
  Circle(double radius) {
      this(0.0, 0.0, radius);
  }

  Circle(Circle circle) {
      this(circle.x, circle.y, circle.radius);
  }
  ```
  The copy constructor creates a *new object* with the same field values.
]

#slide[
  #text(18pt)[
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
  ]
  #tip[IntelliJ IDEA: *Code → Generate → Constructor*.]
]

#slide[
  #task[Add getters and setters. Reject negative radii in the setter.]
  #tip[IntelliJ IDEA: *Code → Generate → Getter and Setter*.]
]

#slide[
  #set text(size: 17pt)
  #grid(columns: (1fr, 1fr), gutter: 24pt,
    [
      ```java
      double getX() {
          return x;
      }

      void setX(double x) {
          this.x = x;
      }
      ```
      Add `getY`, `getRadius`, and `setY` in the same way.
    ],
    [
      ```java
      void setRadius(double radius) {
          if (radius >= 0.0) {
              this.radius = radius;
          }
      }
      ```
      A negative value leaves the radius unchanged.
    ],
  )
  #v(12pt)
  The constructors above do not yet validate the radius.
]

= Class Variables & Class Methods
== Class Variables
#slide[
  #question[Does `PI` exist only once in memory?]
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

#slide[
  No. `final` prevents reassignment; it does not make a field shared.
  #v(16pt)
  #diagram("instance-pi", height: 230pt)
]

#slide[
  #question[Does `count` count all objects created?]
  #text(19pt)[
    ```java
    public class Circle {
        double x, y, radius;
        int count;

        Circle() {
            radius = 1.0;
            count++;
        }
    }
    ```
  ]
]

#slide[
  No. Each object increments its own `count` from 0 to 1.
  #v(16pt)
  #diagram("instance-count", height: 230pt)
]

#slide[
  `static` makes a field belong to the *class*, not to each object.
  #v(12pt)
  #diagram("static-fields", height: 270pt)
]

#slide[
  #text(18pt)[
    ```java
    public class Circle {
        double x, y, radius;
        static final double PI = 3.141592653589793;
        static int count;

        Circle() {
            radius = 1.0;
            count++;
        }

        double getArea() {
            return PI * radius * radius;
        }
    }
    ```
  ]
]

#slide[
  Access a class field with `ClassName.fieldName`.
  #text(18pt)[
    ```java
    public class CircleDemo {
        public static void main(String[] args) {
            Circle circle1 = new Circle();
            Circle circle2 = new Circle();
            Circle circle3 = new Circle();

            System.out.println("Created: " + Circle.count);
        }
    }
    ```
  ]
  Prints `Created: 3`. The counter tracks creations, not live objects.
]

== Class Methods
#slide[
  #diagram("static-methods", height: 230pt)
]

#slide[
  #text(19pt)[
    ```java
    public class Circle {
        static double getPi() {
            return 3.141592653589793;
        }
    }
    ```
    ```java
    public class CircleDemo {
        public static void main(String[] args) {
            System.out.println("Pi: " + Circle.getPi());
        }
    }
    ```
  ]
  Both `getPi` and `main` are class methods.
]

= License Notice
== Attribution
#slide[
  - Shared under #link("https://creativecommons.org/licenses/by-nc-sa/4.0/")[CC BY-NC-SA 4.0] and the applicable public license.
  - Based on teaching material by Prof. Dr. Marc Hensel.
  - Text, diagrams, and layout adapted. Original material supplied privately; no public source link is available.
]
