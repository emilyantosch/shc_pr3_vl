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

= Theoretical Part: 45min

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
  [Description of an Existing Program],
  points: 10,
  [

    The following program code creates a simple library system. Describe which functions are covered by the code. Which classes and methods are defined?
    Can you think of how you could extend the program?\
    #box(width: 100%, height: 87%, stroke: color.black)[]
    1. The class ```java Book```
    ```java
    public class Book {
        private String title;
        private String author;
        private boolean isBorrowed;

        public Book(String title, String author) {
            this.title = title;
            this.author = author;
            this.isBorrowed = false;
        }

        public String getTitle() {
            return title;
        }

        public String getAuthor() {
            return author;
        }

        public boolean isBorrowed() {
            return isBorrowed;
        }

        public void borrow() {
            if (!isBorrowed) {
                isBorrowed = true;
                System.out.println("The book '" + title + "' has been borrowed.");
            } else {
                System.out.println("The book '" + title + "' is already borrowed.");
            }
        }

        public void returnBook() {
            if (isBorrowed) {
                isBorrowed = false;
                System.out.println("The book '" + title + "' has been returned.");
            } else {
                System.out.println("The book '" + title + "' was not borrowed.");
            }
        }

        public String toString() {
            return "Book: " + title + " by " + author + (isBorrowed ? " (borrowed)" : " (available)");
        }
    }
    ```

    #v(90%)
    2. The class ```java Library```

    ```java
    import java.util.ArrayList;

    public class Library {
        private ArrayList<Book> books;

        public Library() {
            books = new ArrayList<>();
        }

        public void addBook(Book book) {
            books.add(book);
            System.out.println("The book '" + book.getTitle() + "' has been added to the library.");
        }

        public void listBooks() {
            if (books.isEmpty()) {
                System.out.println("The library contains no books.");
            } else {
                System.out.println("List of books in the library:");
                for (Book book : books) {
                    System.out.println(book);
                }
            }
        }

        public void borrowBook(String title) {
            for (Book book : books) {
                if (book.getTitle().equalsIgnoreCase(title)) {
                    book.borrow();
                    return;
                }
            }
            System.out.println("The book '" + title + "' was not found.");
        }

        public void returnBook(String title) {
            for (Book book : books) {
                if (book.getTitle().equalsIgnoreCase(title)) {
                    book.returnBook();
                    return;
                }
            }
            System.out.println("The book '" + title + "' was not found.");
        }
    }
    ```
    #v(90%)
    3. The class ```java Main```
    ```java
    import java.util.Scanner;

    public class Main {
        public static void main(String[] args) {
            Library library = new Library();
            Scanner scanner = new Scanner(System.in);
            boolean running = true;

            // Add sample books
            library.addBook(new Book("The Lord of the Rings", "J.R.R. Tolkien"));
          library.addBook(new Book("Harry Potter and the Philosopher's Stone", "J.K. Rowling"));
            library.addBook(new Book("1984", "George Orwell"));

            while (running) {
                System.out.println("\nLibrary System:");
                System.out.println("1. Display books");
                System.out.println("2. Borrow book");
                System.out.println("3. Return book");
                System.out.println("4. Exit");
                System.out.print("Select an option: ");
                int choice = scanner.nextInt();
                scanner.nextLine(); // Clear input line

                switch (choice) {
                    case 1:
                        library.listBooks();
                        break;
                    case 2:
                        System.out.print("Title of the book to borrow: ");
                        String borrowTitle = scanner.nextLine();
                        library.borrowBook(borrowTitle);
                        break;
                    case 3:
                        System.out.print("Title of the book to return: ");
                        String returnTitle = scanner.nextLine();
                        library.returnBook(returnTitle);
                        break;
                    case 4:
                        running = false;
                        System.out.println("Program terminated.");
                        break;
                    default:
                        System.out.println("Invalid option. Please try again.");
                        break;
                }
            }
            scanner.close();
        }
    }
    ```
  ],
  [],
  (
    (2, [Override of `toString`]),
    (2, [Data encapsulation using `private` and getters and setters]),
    (2, [`ArrayList` instead of a normal array.]),
    (2, [`Scanner` is used for input via the command line.]),
    (2, [Extensions: Abstract classes, exceptions, user management]),
  ),
)
#pagebreak()

= Practical Part: 45min

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

