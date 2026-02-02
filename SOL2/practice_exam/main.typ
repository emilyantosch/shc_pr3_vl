#import "@preview/grape-suite:3.1.0": colors, exercise
#import "@preview/gentle-clues:1.2.0": *
#import exercise: project, subtask, task
#import colors: *

#import "@preview/codly:1.3.0": *
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
  institute: [Faculty TI],
  seminar: [SO2 - Object-Oriented Programming in Java],

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

  grade-scale: (([very good], 0.9), ([good], 0.8), ([satisfactory], 0.7), ([sufficient], 0.5), ([failed], 0.49)),
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
    #box(height: 65%, width: 100%, stroke: color.black)[
      1. Encapsulation is the principle of bundling data and methods that operate on that data within a class, while hiding internal implementation details through access modifiers.
      ```java
        private double balance;

        public double getBalance() {
          return balance;
        }

        public void setBalance(double balance) {
          this.balance = balance;
        }
      ```
      2. Polymorphism allows objects of different classes to be treated through a common interface, enabling methods to behave differently based on the object type.
      ```java
        class Animal {
          public void makeSound() {
            System.out.println("...");
          }
        };
        class Cat extends Animal {
          public void sleep() {
            System.out.println("Purr");

          }
        }
      ```
      3. Constructor is a special method called when creating an object instance, used to initialize the object's state and allocate resources.
      ```java
        class Animal {
          private double height;
          public Animal(double height) {
            this.height = height;
          }
        };
      ```
      4. Interface is a contract that defines a set of abstract methods that implementing classes must provide, enabling abstraction and multiple inheritance of type.
      ```java
        interface Resizeable {
          void resize(double factor);
        };
      ```
      5. Abstract Class is a class that cannot be instantiated and may contain both abstract methods (without implementation) and concrete methods (with implementation).
      ```java
        abstract class Animal {
          public abstract void makeSound();
        };
      ```
    ]
  ],
  [],
  (
    (
      2,
      [Encapsulation is the principle of bundling data and methods that operate on that data within a class, while hiding internal implementation details through access modifiers.],
    ),
    (
      2,
      [Polymorphism allows objects of different classes to be treated through a common interface, enabling methods to behave differently based on the object type.],
    ),
    (
      2,
      [Constructor is a special method called when creating an object instance, used to initialize the object's state and allocate resources.],
    ),
    (
      2,
      [Interface is a contract that defines a set of abstract methods that implementing classes must provide, enabling abstraction and multiple inheritance of type.],
    ),
    (
      2,
      [Abstract Class is a class that cannot be instantiated and may contain both abstract methods (without implementation) and concrete methods (with implementation).],
    ),
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
      #box(height: 85%, width: 100%, stroke: color.black)[
        *Inheritance* allows a subclass to inherit attributes and methods from a parent class using the `extends` keyword. The subclass can reuse and extend the functionality of the parent class.

        The *`super` keyword* refers to the parent class and is used to:
        - Call the parent class constructor: `super()`
        - Access parent class methods: `super.methodName()`

        ```java
        class Animal {
            protected String name;

            public Animal(String name) {
                this.name = name;
            }

            public void makeSound() {
                System.out.println("Some sound");
            }
        }

        class Dog extends Animal {
            private String breed;

            public Dog(String name, String breed) {
                super(name);  // Call parent constructor
                this.breed = breed;
            }

            @Override
            public void makeSound() {
                super.makeSound();  // Call parent method
                System.out.println("Woof!");
            }
        }
        ```
      ]
    ]
    #subtask(points: 5)[
      Explain the difference between method overloading and method overriding. When is each used, and what are the rules for each? Provide examples.\
      #box(height: 40%, width: 100%, stroke: color.black)[
        *Method Overloading* (compile-time polymorphism):
        - Same class, same method name, *different parameters*
        - Return type can be different
        ```java
        public int add(int a, int b) { return a + b; }
        public double add(double a, double b) { return a + b; }
        ```

        *Method Overriding* (runtime polymorphism):
        - Subclass provides different implementation of parent method
        - *Same signature* (name, parameters, return type)
        - Use `@Override` annotation
        ```java
        class Animal { public void speak() { System.out.println("..."); } }
        class Cat extends Animal {
            @Override
            public void speak() { System.out.println("Meow"); }
        }
        ```
      ]
    ]
    #subtask(points: 5)[
      Describe the three main access modifiers in Java: public, private, and protected. How do they control visibility, and when should each be used? Provide examples.\
      #box(height: 45%, width: 100%, stroke: color.black)[
        *`public`*: Accessible from *anywhere* (any class, any package).
        - Use for: APIs, methods meant to be called externally
        ```java
        public void displayInfo() { ... }
        ```

        *`private`*: Accessible only *within the same class*.
        - Use for: Internal data, encapsulation of attributes
        ```java
        private double balance;  // Only accessible via getters/setters
        ```

        *`protected`*: Accessible within the *same class, same package, and subclasses* (even in different packages).
        - Use for: Members that subclasses need to access
        ```java
        protected String name;  // Subclasses can access directly
        ```
      ]
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
    (
      5,
      [Public members are accessible everywhere. Private members are only accessible within the same class. Protected members are accessible within the same class, subclasses, and the same package. Use private for encapsulation, protected for inheritance, and public for interfaces.],
    ),
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
      [In Java, a subclass constructor must call a superclass constructor either explicitly or implicitly.], [x], [],
      [Two methods with the same name and parameters but different return types can coexist in the same class.],
      [],
      [x],

      [The protected access modifier allows access from any class in the same package.], [x], [],
      [An abstract class must contain at least one abstract method.], [], [x],
      [Interface methods are public and abstract by default.], [x], [],
      [A concrete class that implements an interface must provide implementations for all interface methods.], [x], [],
      [The ```java super``` keyword can be used to access private members of the parent class.], [], [x],
      [A static method can access instance variables directly without an object reference.], [], [x],
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
        private double radius;

        // TODO: Create a constructor that takes radius as a parameter
        // and initializes the attribute
        public Circle(double radius) {
          this.radius = radius;
        }

        // TODO: Create a getter method for radius
        public double getRadius() {
          return radius;
        }

        // TODO: Create a setter method for radius that validates the radius is positive
        public void setRadius(double radius) {
          if (radius > 0.0) {
            this.radius = radius;
          }
        }

        // TODO: Create a method calculateArea() that returns the area (π × r²)
        public double calculateArea() {
          return Math.PI * radius * radius;
        }

        // TODO: Create a method calculateCircumference() that returns the circumference (2 × π × r)
        public double calculateCircumference() {
          return 2 * Math.PI * radius;
        }

        // TODO: Override the toString() method to return a string in the format:
        // "Circle[radius=5.0]"
        public String toString() {
          return "Circle[radius=" + radius + "]"
        }
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
  [
    - Error 1: name attribute has no access modifier (package-private) - violates encapsulation, should be private
    - Error 2: Constructor missing semicolon after `this.studentId = studentId`
    - Error 3: Constructor doesn't initialize `gpa` attribute - all attributes should be initialized
    - Error 4: In `setGpa`, `gpa = gpa` assigns parameter to itself - should use `this.gpa = gpa`
    - Error 5: `getStudentInfo()` is static but tries to access instance variables (`name`, `studentId`, `gpa`) - static methods cannot access instance variables directly
    - Error 6: Missing getter methods for `name` and `gpa` - breaks encapsulation principle of providing access to private data
  ],
  (
    (2, [Error 1: name attribute has no access modifier (package-private) - violates encapsulation, should be private]),
    (2, [Error 2: Constructor missing semicolon after `this.studentId = studentId`]),
    (2, [Error 3: Constructor doesn't initialize gpa attribute - all attributes should be initialized]),
    (2, [Error 4: In setGpa, `gpa = gpa` assigns parameter to itself - should use `this.gpa = gpa`]),
    (
      2,
      [Error 5: getStudentInfo() is static but tries to access instance variables (name, studentId, gpa) - static methods cannot access instance variables directly],
    ),
    (
      2,
      [Error 6: Missing getter methods for name and gpa - breaks encapsulation principle of providing access to private data],
    ),
  ),
)
#pagebreak()

= Practical Part: 60min

#task(
  [Contact Book Application],
  [
    Create a contact book application that allows users to manage a list of contacts. This task requires implementing multiple classes and demonstrating object-oriented programming principles.

    Your program should support the following operations:
    - Add a new contact with name, phone number, and email
    - Delete a contact by name
    - Search for a contact by name (case-insensitive)
    - Display all contacts

    The application should use proper OOP design with separate ```java Contact``` and ```java ContactBook``` classes.

    #tip[
      You can use ```java ArrayList<Contact>``` to store contacts. Example:
      ```java
      import java.util.ArrayList;

      ArrayList<Contact> contacts = new ArrayList<>();
      contacts.add(new Contact("John", "123-456", "john@email.com"));
      ```
      For searching, use ```java String.equalsIgnoreCase(String other)``` for case-insensitive comparison.
      \
    ]
  ],
  [
    #subtask(points: 3)[
      Create a new project. Give the project a name that contains your student ID number and your name.
      Create both a ```java Contact``` class and a ```java ContactBook``` class.
    ]
    #subtask(points: 5)[
      Implement the ```java Contact``` class with private attributes for name, phone, and email. Include a constructor that initializes all three attributes and getter methods for each attribute. Override the ```java toString()``` method to provide a readable representation.
    ]
    #subtask(points: 4)[
      Implement the ```java ContactBook``` class with a private ```java ArrayList<Contact>``` to store contacts. Include a constructor that initializes the empty list.
    ]
    #subtask(points: 6)[
      Create an ```java addContact(String name, String phone, String email)``` method in ContactBook that creates a new Contact object and adds it to the list. Validate that none of the parameters are null or empty before adding.
    ]
    #subtask(points: 5)[
      Create a ```java deleteContact(String name)``` method that removes a contact by name (case-insensitive). Return true if a contact was deleted, false if no matching contact was found.
    ]
    #subtask(points: 6)[
      Create a ```java searchContact(String name)``` method that searches for and returns a contact by name (case-insensitive). Return null if no matching contact is found.
    ]
    #subtask(points: 3)[
      Create a ```java displayAllContacts()``` method that prints all contacts in a readable format. Handle the case when the contact book is empty.
    ]
    #subtask(points: 5)[
      Create a ```java main``` method that demonstrates all functionality comprehensively. Add several contacts, test searching, deleting, and displaying. Show clear output for each operation.
    ]
    #subtask(points: 3)[
      When programming your solution, pay attention to proper coding style including naming conventions, encapsulation (private attributes with public methods), and clear code structure.
    ]

  ],
  (
    (
      3,
      [Project created with appropriate name. Both Contact and ContactBook classes exist and are properly structured.],
    ),
    (5, [Contact class properly implemented with private attributes, constructor, getters, and toString() override.]),
    (4, [ContactBook class properly implemented with ArrayList and constructor.]),
    (6, [addContact method works correctly with proper validation of inputs.]),
    (5, [deleteContact method works correctly with case-insensitive search and returns appropriate boolean.]),
    (6, [searchContact method works correctly with case-insensitive matching and returns correct Contact or null.]),
    (3, [displayAllContacts method works correctly and handles empty contact book gracefully.]),
    (5, [Main method demonstrates all functionality comprehensively with multiple test cases.]),
    (3, [Code follows proper OOP principles: encapsulation, good naming, clear structure, and appropriate comments.]),
  ),
)
