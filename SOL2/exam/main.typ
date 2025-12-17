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
    (2, [calculatePerimeter() method returns $2 * ("width" + "height")$]),
    (2, [calculateArea() method returns $"width" * "height"$]),
    (2, [toString() method properly overridden with `@Override` annotation and returns formatted string]),
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
  [Word/Text Analyzer],
  [
    Create a program that analyzes a given text and provides various statistics about it.

    Your program should analyze text and provide the following information:
    - Count the total number of words
    - Count the total number of characters (excluding spaces)
    - Find and return the longest word
    - Count how many times a specific word appears (case-insensitive)

    #tip[
      You can use the ```java String.split()``` method to split text into words. Example:
      ```java
      String text = "Hello world from Java";
      String[] words = text.split(" ");
      System.out.println("Number of words: " + words.length); // 4
      ```
      You can also use ```java String.toLowerCase()``` for case-insensitive comparison and ```java String.replace()``` to remove spaces.
      \
    ]
  ],
  [
    #subtask(points: 3)[
      Create a new project. Give the project a name that contains your student ID number and your name.
      Create a ```java TextAnalyzer``` class with appropriate methods.
    ]
    #subtask(points: 5)[
      Create a method ```java countWords(String text)``` that counts and returns the total number of words in the given text.
    ]
    #subtask(points: 5)[
      Create a method ```java countCharacters(String text)``` that counts and returns the total number of characters, excluding spaces.
    ]
    #subtask(points: 7)[
      Create a method ```java findLongestWord(String text)``` that finds and returns the longest word in the text. If there are multiple words with the same length, return any one of them.
    ]
    #subtask(points: 7)[
      Create a method ```java countWordOccurrences(String text, String word)``` that counts how many times a specific word appears in the text. The comparison should be case-insensitive (e.g., "Hello" and "hello" should be counted as the same word).
    ]
    #subtask(points: 5)[
      Create a ```java main``` method that demonstrates all the functionality with test cases. Test with at least one sample text that shows all methods working correctly.
    ]
    #subtask(points: 5)[
      Ensure your methods handle edge cases properly (empty strings, null values, single words, etc.) and validate input appropriately.
    ]
    #subtask(points: 3)[
      When programming your solution, pay attention to the common coding styles that were established in the lecture (naming conventions, indentation, comments).
    ]

  ],
  (
    (3, [Project created with appropriate name containing student ID and name. TextAnalyzer class exists.]),
    (5, [countWords method implemented correctly and returns accurate word count for various test cases.]),
    (5, [countCharacters method implemented correctly and excludes spaces properly.]),
    (7, [findLongestWord method implemented correctly and returns the longest word.]),
    (7, [countWordOccurrences method implemented correctly with case-insensitive matching.]),
    (5, [Main method exists and demonstrates all functionality with clear test output.]),
    (5, [Code includes proper input validation and handles edge cases (null, empty strings).]),
    (3, [Code follows proper coding style: good naming, indentation, and includes helpful comments.]),
  ),
)
