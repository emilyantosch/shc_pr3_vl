#import "@preview/grape-suite:3.1.0": colors, exercise
#import "@preview/gentle-clues:1.0.0": *
#import exercise: project, subtask, task
#import colors: *

#import "@preview/codly:1.0.0": *
#show: codly-init.with()

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

#show: project.with(
  type: [Exam],
  suffix-title: [Object-Oriented Programming],

  show-point-distribution-in-tasks: true,
  show-namefield: true,
  show-timefield: true,

  max-time: 90,
  show-lines: true,

  show-solutions: true,
  solutions-as-matrix: true,

  university: [HAW Hamburg],
  institute: [SHC - Faculty TI],
  seminar: [Object-Oriented Programming in Java],

  task-type: [Task],
  extra-task-type: [Extra Task],

  solution-matrix-task-header: [Task],
  solution-matrix-achieved-points-header: [Points Achieved],

  distribution-header-point-value: [Points],
  distribution-header-point-grade: [Value],

  message: (
    points-sum,
    extrapoints-sum,
  ) => [In total, #points-sum + #extrapoints-sum pts. are achievable. You have achieved #box(line(stroke: purple, length: 1cm)) pts. out of #points-sum pts.],

  solutions-title: [Solution Proposals],
  timefield: time => [Time: #time min.],

  grade-scale: (([very good], 0.9), ([good], 0.8), ([satisfactory], 0.7), ([sufficient], 0.6), ([failed], 0.59)),
)

= Theoretical Part: 60min

#task(
  points: 10,
  [Basic Concepts],
  [
    Explain the following five concepts from object-oriented programming and provide an example for each:
    - Encapsulation
    - Polymorphism
    - Constructor
    - Interface
    - Abstract Class\
    #box(height: 65%, width: 100%, stroke: color.black)[]
  ],
  [],
  (
    (2, [Encapsulation is the principle of bundling data and methods that operate on that data within a class, while hiding internal implementation details through access modifiers.]),
    (2, [Polymorphism allows objects of different classes to be treated through a common interface, enabling methods to behave differently based on the object type.]),
    (2, [Constructor is a special method called when creating an object instance, used to initialize the object's state and allocate resources.]),
    (2, [Interface is a contract that defines a set of abstract methods that implementing classes must provide, enabling abstraction and multiple inheritance of type.]),
    (2, [Abstract Class is a class that cannot be instantiated and may contain both abstract methods (without implementation) and concrete methods (with implementation).]),
  ),
)

#task(
  [Concepts of Object-Oriented Programming],
  [
    Briefly describe what the various terms and concepts mean in Java or object-oriented programming.
  ],
  [
    #subtask(points: 5)[
      Explain how inheritance works in Java and what role the `super` keyword plays. Provide an example showing the use of `super` in both constructors and methods.\
      #box(height: 85%, width: 100%, stroke: color.black)[]
    ]
    #subtask(points: 5)[
      Explain the difference between method overloading and method overriding. When is each used, and what are the rules for each? Provide examples.\
      #box(height: 40%, width: 100%, stroke: color.black)[]
    ]
    #subtask(points: 5)[
      Describe the three main access modifiers in Java: public, private, and protected. How do they control visibility, and when should each be used? Provide examples.\
      #box(height: 45%, width: 100%, stroke: color.black)[]
    ]
  ],
  (
    (
      5,
      [Inheritance allows a subclass to inherit attributes and methods from a parent class. The `super` keyword refers to the parent class and is used to call parent constructors (super()) or access parent methods (super.method()). This enables code reuse and specialization.],
    ),
    (
      5,
      [Method overloading occurs in the same class with methods having the same name but different parameters (compile-time polymorphism). Method overriding occurs in subclasses providing a different implementation of a parent method with the same signature (runtime polymorphism).],
    ),
    (5, [Public members are accessible everywhere. Private members are only accessible within the same class. Protected members are accessible within the same class, subclasses, and the same package. Use private for encapsulation, protected for inheritance, and public for interfaces.]),
  ),
)

#task(
  points: 16,
  [True or False],
  [
    Decide whether the following statements are true or false:
    #table(
      columns: (auto, auto, auto),
      inset: 10pt,
      align: horizon,
      table.header([*Question*], [*True*], [*False*]),
      [In Java, a subclass constructor must call a superclass constructor either explicitly or implicitly.], [], [],
      [Two methods with the same name and parameters but different return types can coexist in the same class.], [], [],
      [The protected access modifier allows access from any class in the same package.], [], [],
      [An abstract class must contain at least one abstract method.], [], [],
      [Interface methods are public and abstract by default.], [], [],
      [A class that implements an interface must provide implementations for all interface methods.], [], [],
      [The ```java super``` keyword can be used to access private members of the parent class.], [], [],
      [A static method can access instance variables directly without an object reference.], [], [],
    )
  ],
  [],
  (
    (2, [True]),
    (2, [False]),
    (2, [True]),
    (2, [False]),
    (2, [True]),
    (2, [True]),
    (2, [False]),
    (2, [False]),
  ),
)

#pagebreak()
#task(
  [Code Completion],
  points: 12,
  [
    Complete the following ```java Circle``` class by filling in the missing code directly in the gaps. The class should represent a circle with a radius. Use ```java Math.PI``` for π.

    ```java
    public class Circle {
        // TODO: Add a private attribute for radius (double)




        // TODO: Create a constructor that takes radius as a parameter
        // and initializes the attribute




        // TODO: Create a getter method for radius




        // TODO: Create a setter method for radius that validates the radius is positive




        // TODO: Create a method calculateArea() that returns the area (π × r²)




        // TODO: Create a method calculateCircumference() that returns the circumference (2 × π × r)




        // TODO: Override the toString() method to return a string in the format:
        // "Circle[radius=5.0]"




    }
    ```
  ],
  [],
  (
    (2, [Private double attribute: radius]),
    (2, [Constructor with one parameter that initializes radius using `this` keyword]),
    (2, [Getter method: getRadius() that returns the radius value]),
    (2, [Setter method: setRadius() that validates radius > 0 before setting]),
    (2, [calculateArea() method returns Math.PI * radius * radius]),
    (2, [calculateCircumference() method returns 2 * Math.PI * radius]),
  ),
)

#task(
  [Code Debugging],
  points: 12,
  [
    The following ```java Student``` class contains several errors. Find and explain all the errors in the code below. Note that errors include both syntax errors that would prevent compilation AND violations of OOP principles (such as encapsulation).

    ```java
    public class Student {
        String name;
        private int studentId;
        private double gpa;

        public Student(String name, int studentId) {
            this.name = name;
            this.studentId = studentId
        }

        public void setGpa(double gpa) {
            gpa = gpa;
        }

        public int getStudentId() {
            return this.studentId;
        }

        public static String getStudentInfo() {
            return "Student: " + name + ", ID: " + studentId + ", GPA: " + gpa;
        }

        public void displayInfo() {
            System.out.println(getStudentInfo());
        }
    }
    ```

    List all errors you found and explain what is wrong:\
    #box(width: 100%, height: 60%, stroke: color.black)[]
  ],
  [],
  (
    (2, [Error 1: name attribute has no access modifier (package-private) - violates encapsulation, should be private]),
    (2, [Error 2: Constructor missing semicolon after `this.studentId = studentId`]),
    (2, [Error 3: Constructor doesn't initialize gpa attribute - all attributes should be initialized]),
    (2, [Error 4: In setGpa, `gpa = gpa` assigns parameter to itself - should use `this.gpa = gpa`]),
    (2, [Error 5: getStudentInfo() is static but tries to access instance variables (name, studentId, gpa) - static methods cannot access instance variables directly]),
    (2, [Error 6: Missing getter methods for name and gpa - breaks encapsulation principle of providing access to private data]),
  ),
)
#pagebreak()

= Practical Part: 60min

#task(
  [Roman to Integer],
  [
    Roman numerals consist of seven different symbols: I, V, X, L, C, D, and M.
    #align(center + horizon)[
      #table(
        columns: (auto, auto),
        inset: 10pt,
        align: horizon,
        table.header([*Symbol*], [*Value*]),
        [I], [1],
        [V], [5],
        [X], [10],
        [L], [50],
        [C], [100],
        [D], [500],
        [M], [1000],
      )

    ]
    For example, the number 2 is written as II, as it consists of two ones. The number 12 is represented as XII, which corresponds to X (10) plus II (2). The number 27 is written as XXVII, which is XX (20) plus V (5) plus II (2).

    Roman numerals are normally written from left to right in order from largest to smallest. However, the number 4 is not written as IIII, but as IV. Since the one comes before the five, we subtract it, and thus get four. The same principle applies to the number 9, which is written as IX. There are six cases in which subtraction is applied:

    - I can be placed before V (5) and X (10) to form 4 and 9.
    - X can be placed before L (50) and C (100) to form 40 and 90.
    - C can be placed before D (500) and M (1000) to form 400 and 900.

    Write a program that converts a Roman numeral into an integer number!

    #tip[
      You will need to iterate through the string. Use the method ```java String.getChar(int i)```, where i is the index at which you want to read the value. Example:
      ```java
      String s = "Hello";
      System.out.println("Letter at the first position of " + s + " is " + s.charAt(0) + "."); //Letter at the first position of Hello is H.
      ```
      \
    ]
  ],
  [
    #subtask(points: 3)[
      Create a new project. Give the project a name that contains your student ID number and your name.
      Create a class with a method that has an appropriate name and parameters as well as a return value.
    ]
    #subtask(points: 5)[
      Check the string for invalid character input.
      Create a variable that contains the value of the Roman numeral in numeric format.
    ]
    #subtask(points: 5)[
      Write a `for` loop that iterates through the given string.
    ]
    #subtask(points: 10)[
      Build in logic that evaluates the string and decides whether one of the six special cases has occurred.
    ]
    #subtask(points: 5)[
      Have the method return a value that indicates the value of the Roman numeral in numeric format.
    ]
    #subtask(points: 5)[
      Write a `main` method that runs the method against test input.
    ]
    #subtask(points: 4)[
      When programming your solution, pay attention to the common coding styles that were established in the lecture.
    ]
    #subtask(points: 3)[
      Save your project on the external hard drive that you will receive from the exam supervisor. Just ask if you want to save your project. After the project has been saved, there are no further opportunities to make changes.
    ]

  ],
  (
    (4, [The code has the correct coding style and looks neat.]),
    (8, [The code works as described and returns a correct answer for correct input.]),
    (
      4,
      [The program is protected against errors from incorrect input. An undefined character leads to an abort of the operation.],
    ),
    (
      4,
      [The program is protected against errors from incorrect input. Appropriate exception handling has been implemented.],
    ),
    (5, [A project with an appropriate name has been created, as well as a class and a method.]),
    (
      5,
      [The method is appropriately named, has parameters and a return value that match the task description.],
    ),
    (5, [There is a main method in one of the classes that is executable and tests the code against test input.]),
    (5, [The project is on the hard drive, is named correctly, and can be opened.]),
  ),
)

