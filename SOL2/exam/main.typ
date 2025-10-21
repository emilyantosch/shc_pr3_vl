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
      Define the term "polymorphism". Provide an example that shows how polymorphism is implemented in Java.\
      #box(height: 85%, width: 100%, stroke: color.black)[]
    ]
    #subtask(points: 5)[
      Explain the differences between an abstract class and an interface in Java. Provide an example for each use case.\
      #box(height: 40%, width: 100%, stroke: color.black)[]
    ]
    #subtask(points: 5)[
      Why is it good when data is encapsulated? And how is this data encapsulation created? Explain this and provide an example.\
      #box(height: 45%, width: 100%, stroke: color.black)[]
    ]
  ],
  (
    (
      5,
      [A method can exist in different classes with different implementations while having the same method name and signature. Overloading and overriding.],
    ),
    (
      5,
      [An abstract class is a class that cannot be instantiated. An interface is a collection of abstract methods.],
    ),
    (5, [Clarity and structure, security, maintainability. Encapsulation using `private`, as well as getters and setters.]),
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
      [A class can inherit from multiple other classes.], [], [],
      [Inheritance and composition are two words for the same thing.], [], [],
      [A reference to an object must always be of exactly the same class as the object itself.], [], [],
      [With ```java public Auto()``` you define a constructor for the class ```java Auto```.], [], [],
      [A class can implement multiple interfaces.], [], [],
      [With the keyword ```java impl``` you can define that a class implements an interface.],
      [],
      [],

      [With the expression ```java let number : i32 = 0;``` you define a variable with the name ```java number``` and the value `0`.],
      [],
      [],

      [The main advantage of data encapsulation is that you protect data from unauthorized access.], [], [],
    )
  ],
  [],
  (
    (2, [False]),
    (2, [False]),
    (2, [False]),
    (2, [True]),
    (2, [True]),
    (2, [False]),
    (2, [True]),
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

