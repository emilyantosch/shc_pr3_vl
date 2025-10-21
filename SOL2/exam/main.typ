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
    - Class
    - Object
    - Inheritance
    - Composition
    - Method Overriding\
    #box(height: 65%, width: 100%, stroke: color.black)[]
  ],
  [],
  (
    (2, [Class is a blueprint or template that defines the structure and behavior of objects, containing attributes and methods.]),
    (2, [Object is an instance of a class that has its own state and behavior, created using the class definition.]),
    (2, [Inheritance is a mechanism that allows a class to inherit properties and methods from another class, enabling code reuse and establishing an is-a relationship.]),
    (2, [Composition is a design principle where a class contains instances of other classes as attributes, establishing a has-a relationship and promoting modularity.]),
    (2, [Method Overriding occurs when a subclass provides its own implementation of a method that is already defined in its parent class, allowing specialized behavior.]),
  ),
)

#task(
  [Concepts of Object-Oriented Programming],
  [
    Briefly describe what the various terms and concepts mean in Java or object-oriented programming.
  ],
  [
    #subtask(points: 5)[
      Define the term "polymorphism". Explain the difference between compile-time and runtime polymorphism, and provide an example for each.\
      #box(height: 85%, width: 100%, stroke: color.black)[]
    ]
    #subtask(points: 5)[
      Explain what static methods and static attributes are in Java. How do they differ from instance methods and attributes? Provide an example.\
      #box(height: 40%, width: 100%, stroke: color.black)[]
    ]
    #subtask(points: 5)[
      Explain the differences between an abstract class and an interface in Java. When would you use one over the other? Provide an example for each.\
      #box(height: 45%, width: 100%, stroke: color.black)[]
    ]
  ],
  (
    (
      5,
      [Polymorphism allows objects to take many forms. Compile-time polymorphism is achieved through method overloading (same method name, different parameters). Runtime polymorphism is achieved through method overriding (subclass provides specific implementation of parent method).],
    ),
    (
      5,
      [Static methods and attributes belong to the class rather than instances. They are shared across all objects and can be accessed without creating an instance. Instance members are unique to each object.],
    ),
    (5, [Abstract classes can have both abstract and concrete methods, can have constructors, and support single inheritance. Interfaces contain only abstract methods (before Java 8), support multiple inheritance, and define contracts. Use abstract classes for shared code, interfaces for contracts.]),
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
      [In Java, a class can inherit from multiple other classes.], [], [],
      [Static methods can be overridden in subclasses.], [], [],
      [A constructor must have the same name as the class.], [], [],
      [Private methods are inherited by subclasses but cannot be accessed.], [], [],
      [An interface can contain concrete (implemented) methods.], [], [],
      [The ```java this``` keyword refers to the current instance of a class.], [], [],
      [Abstract classes can be instantiated directly.], [], [],
      [Method overloading is an example of compile-time polymorphism.], [], [],
    )
  ],
  [],
  (
    (2, [False]),
    (2, [False]),
    (2, [True]),
    (2, [True]),
    (2, [True]),
    (2, [True]),
    (2, [False]),
    (2, [True]),
  ),
)

#pagebreak()
#task(
  [Code Completion],
  points: 12,
  [
    Complete the following ```java Rectangle``` class by filling in the missing code directly in the gaps. The class should represent a rectangle with width and height.

    ```java
    public class Rectangle {
        // TODO: Add private attributes for width and height (both double)




        // TODO: Create a constructor that takes width and height as parameters
        // and initializes the attributes




        // TODO: Create a getter method for width




        // TODO: Create a getter method for height




        // TODO: Create a method calculateArea() that returns the area of the rectangle




        // TODO: Create a method calculatePerimeter() that returns the perimeter




        // TODO: Override the toString() method to return a string in the format:
        // "Rectangle[width=5.0, height=3.0]"




    }
    ```
  ],
  [],
  (
    (2, [Two private double attributes: width and height]),
    (2, [Constructor with two parameters that initializes both attributes using `this` keyword]),
    (2, [Two getter methods: getWidth() and getHeight() that return the respective values]),
    (2, [calculateArea() method returns width * height]),
    (2, [calculatePerimeter() method returns 2 * (width + height)]),
    (2, [toString() method properly overridden with @Override annotation and returns formatted string]),
  ),
)

#task(
  [Code Debugging],
  points: 12,
  [
    The following ```java BankAccount``` class contains several errors. Find and explain all the errors in the code below. Note that errors include both syntax errors that would prevent compilation AND violations of OOP principles (such as encapsulation).

    ```java
    public class BankAccount {
        public double balance;
        private String accountNumber;

        public void BankAccount(String accountNumber, double initialBalance) {
            accountNumber = accountNumber;
            balance = initialBalance;
        }

        public String getAccountNumber() {
            return this.accountNumber;
        }

        public deposit(double amount) {
            balance = balance + amount;
        }

        public void withdraw(double amount) {
            balance - amount;
        }

        public String toString() {
            "Account: " + accountNumber + ", Balance: " + balance;
        }
    }
    ```

    List all errors you found and explain what is wrong:\
    #box(width: 100%, height: 60%, stroke: color.black)[]
  ],
  [],
  (
    (2, [Error 1: balance should be private, not public - violates encapsulation principle]),
    (2, [Error 2: Constructor has return type void - constructors must not have a return type]),
    (2, [Error 3: In constructor, `accountNumber = accountNumber` assigns parameter to itself - should use `this.accountNumber = accountNumber`]),
    (2, [Error 4: deposit method is missing return type - should be `public void deposit(double amount)`]),
    (2, [Error 5: withdraw method doesn't assign the result - should be `balance = balance - amount` or `balance -= amount`]),
    (2, [Error 6: toString method is missing return keyword - should be `return "Account: " + ...`]),
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

