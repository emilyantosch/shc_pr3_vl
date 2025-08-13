#import "@preview/touying:0.5.2": *
#import themes.university: *

#import "@preview/fletcher:0.5.1" as flechter: diagram, node, edge
#import "@preview/wrap-it:0.1.0": wrap-content

#import "@preview/gentle-clues:1.0.0": *
#import "@preview/pinit:0.2.0": *
#import "@preview/codly:1.0.0": *
#show: codly-init.with()

#import "@preview/numbly:0.1.0": numbly

#set text(lang: "de", font: "Roboto", size: 18pt)
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
    subtitle: [Lecture 8 - Exception Handling],
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

== Where are we now?

- In the last lecture, we dealt with creating graphical
  user interfaces
- You can now
  - create windows in which other elements can live,
  - arrange elements using layouts and panels
  - and create graphics directly in Java.
- Today we continue with *Exception Handling*.

#slide[
  1. Imperative Konzepte
  2. Klassen und Objekte
  3. Klassenbibliothek
  4. Vererbung
  5. Schnittstellen
  6. Graphische Oberflächen
  7. *Exception Handling*
  8. Input and Output
  9. Multithreading (Parallel Computing)
]

== The goal of this chapter
- You handle exceptions and errors that occur during program execution to
  establish an orderly program flow in exceptional situations.
- You define your own exception classes adapted to the needs of your specific
  application.

= Exception Handling
== Introductory Example

#slide[
  #text(size: 13pt)[
    #question[
      - What output is produced by the following program?
    ]

    ```java
    public class ProvokeException {
        public static void main(String[] args) {
            int a = 3;
            int b = 2;
            printRatio(a, b);
            System.out.println("Exiting main()");
        }

        public static void printRatio(int a, int b) {
            int ratio = a / b;
            System.out.println("Ratio = " + ratio);
        }
    }
    ```
    #question[
      - And what output is produced for a = 7 and b = 0?
    ]
  ]
]

#slide[
  #text(size: 18pt)[
    #question[
      - What can go "wrong" in a program?
      - When must the normal program flow be interrupted?
      - When must a program be terminated, when can it be continued?
    ]

    #example[
      - Division by zero
      - Calling `a.method()` although variable `a` has the value null
      - Negative or too high index for arrays
      - Converting the string "This is text" to an integer of type `int`
      - File not found
      - No more memory available
    ]
  ]
]

#slide[
  #text(size: 18pt)[

    - Exceptions and errors are represented by objects of special classes
    - Base class of all exception classes is Throwable

    #figure(image("../assets/img/slides_8/2024_11_04_throwable_rev01.png"))

    - One distinguishes:
      - Exception: Handleable, program can be continued
      - Error or fatal error: Not handleable, terminate program

  ]
]

#slide[
  #text(size: 15pt)[
    #memo[
      - Exception is also used as a collective term for exceptions and errors.
      - Exception handling is also called Exception handling.

    ]

    - Some classes for exceptions:
      - Division by zero (ArithmeticException)
      - Access to method or attribute via null reference (NullPointerException)
      - Invalid array index (ArrayIndexOutOfBoundsException)
      - Invalid characters when reading a number (NumberFormatException)
      - File not found (FileNotFoundException)

    ```java
    int[] array = {1, 2, 3, 4};
    System.out.println(array[4]);

    String message;
    System.out.println(message.length());

    int code = Integer.parseInt("12a4");
    ```

  ]
]

== Exception handling flow

#slide[
  #text(size: 18pt)[
    1. Throwing an exception:
      - Program flow is immediately interrupted
      - Object is created that represents the exception
    2. Catching an exception:
      - Programmer can catch and handle the exception

    #figure(image("../assets/img/slides_8/2024_11_04_programmfluss_throwable_rev01.png", height: 50%))

  ]
]

#slide[
  #text(size: 18pt)[
    - If no exception handling is programmed: program is terminated

      #figure(image("../assets/img/slides_8/2024_11_04_programmfluss_noexceptionhandling_rev01.png"))

  ]
]

= Throwing exceptions
== Throwing exceptions

#slide[
  #text(size: 18pt)[
    - In case of error, exceptions are automatically generated (e.g. division by zero).
    - However, exceptions can also be thrown explicitly.

    ```java
    throw ExceptionObject;
    ```

    - Constructor can be passed a string (e.g. as error description)

      #example[
        ```java
        throw new Exception();
        throw new Exception("Division by zero");
        Exception exception = new Exception(); throw exception;
        ```
      ]

  ]
]

#slide[
  #text(size: 18pt)[
    - For illustration:
      - Throw an exception before attempting to divide by zero.
    ```java
    public class ThrowException {
        public static void main(String[] args) {
            int a = 3;
            int b = 0;
            printRatio(a, b);
            System.out.println("Exiting main()");
        }

        public static void printRatio(int a, int b) {
            int ratio = a / b;
            System.out.println("Ratio = " + ratio);
        }
    }
    ```
  ]
]

#slide[
  #text(size: 17pt)[
    - Example solution:

    ```java
    public class ThrowException {
        public static void main(String[] args) {
            int a = 3;
            int b = 0;
            printRatio(a, b);
            System.out.println("Exiting main()");
        }

        public static void printRatio(int a, int b) {
            if (b == 0) {
                throw new ArithmeticException("Division by zero");
            }
            System.out.println("Ratio = " + (a / b));
        }
    }
    ```
  ]
]

#slide[
  #text(size: 18pt)[
    - Output in case of error:
      - Exception type (e.g. ArithmeticException)
      - Error message (e.g. "Division by zero")
      - Stack trace (i.e. chain of called methods)

    #example[
      #text(fill: red)[
        ```
        Exception in thread "main" java.lang.ArithmeticException: Division by zero at
          kapitel8_exceptions.ThrowException.printRatio(E02_ThrowException.java:20) at
          kapitel8_exceptions.ThrowException.main(E02_ThrowException.java:14)
        ```

      ]

    ]

    - Method `main()` called `printRatio()` at line 14
    - Method `printRatio()` threw the exception at line 20
  ]
]

= Catching exceptions
== Exception Handling


#slide[
  #text(size: 18pt)[
    - Exceptions can be caught and handled:
    ```java
     try {
         // Statements ...
     } catch (ExceptionType e) {
         // Statements ...
     }
    ```

    - Try block contains code that can throw an exception
    - If an exception is thrown in the try block:
      1. Try block is immediately terminated
      2. Catch block is executed if the exception type (ExceptionType) matches
      3. Program continues after the catch block
    - Exception type of catch block doesn't match: Exception is not caught!
    - No exception thrown: Catch block is skipped
  ]
]

#slide[
  #text(size: 18pt)[
    - Avoid the "crash":
      - Catch the thrown exception!
    ```java
    public class TryCatch {
        public static void main(String[] args) {
            int a = 3;
            int b = 0;
            printRatio(a, b);
            System.out.println("Exiting main()");
        }

        public static void printRatio(int a, int b) {
            int ratio = a / b;
            System.out.println("Ratio = " + ratio);
        }
    }
    ```
  ]
]

#slide[
  #text(size: 17pt)[
    - Example solution:
    ```java
    public static void printRatio(int a, int b) {
        try {
            int ratio = a / b;
            System.out.println("Ratio = " + ratio);
        } catch (ArithmeticException e) {
            System.out.println("Exception caught in printRatio()");
            System.out.println("e.getMessage(): " + e.getMessage());
            System.out.println("e.toString(): " + e + "\n");
        }
        System.out.println("Exiting printRatio()");
    }
    ```
    - Selected methods for exception objects:
      - `getMessage()`
      - `printStackTrace()`
      - `toString()`
  ]
]

#slide[
  #text(size: 13pt)[
    #question[
      And now?
    ]
    ```java
    public class TryCatchChain1 {
        public static void main(String[] args) {
            int ratio = getRatio(3, 0);
            System.out.println("Ratio = " + ratio);
            System.out.println("Exiting main()");
        }
        public static int getRatio(int a, int b) {
            int ratio = 0;
            try {
                ratio = a / b;
            } catch (ArithmeticException e) {
                System.out.println("Exception caught in getRatio()");
            }
            System.out.println("Exiting getRatio()");
            return ratio;
        }
    }
    ```
  ]
]

#slide[
  #text(size: 13pt)[
    #question[
      And now?
    ]
    ```java
    public class TryCatchChain2 {
        public static void main(String[] args) {
            try {
                int ratio = getRatio(3, 0);
                System.out.println("Ratio = " + ratio);
            } catch (ArithmeticException e) {
                System.out.println("Exception caught in main()");
            }
            System.out.println("Exiting main()");
        }

        public static int getRatio(int a, int b) {
            int ratio = a / b;
            System.out.println("Exiting getRatio()");
            return ratio;
        }
    }
    ```
  ]
]

#slide[
  #text(size: 18pt)[
    - If multiple exception types can occur, multiple catch blocks are needed.
    - Exception types of catch blocks must be different
    - The first matching catch block is executed.
    ```java
     try {
         // ...
     } catch (ExceptionType1 e) {
         // ...
     } catch (ExceptionType2 e) {
         // ...
     } catch (ExceptionType3 e) {
         // ...
     }
    ```
  ]
]

#slide[
  #text(size: 14pt)[
    #question[
      - The following source code contains two error sources. Which ones?
      - What output does the program produce?
    ]
    ```java
    public class ExceptionTypes1 {
        static int recursiveIncrease(int i) {
            return recursiveIncrease(i + 1);
        }

        public static void main(String[] args) {
            int[] a = new int[4];
            try {
                a[4] = recursiveIncrease(7);
            } catch (ArrayIndexOutOfBoundsException e) {
                System.out.println("Caught ArrayIndexOutOfBoundsException");
            }
            System.out.println("Exiting main()");
        }
    }
    ```
  ]
]

#slide[
  #text(size: 13pt)[
    #task[
      - Modify the previous source code so that both error sources are caught.
    ]
    ```java
    public class ExceptionTypes2 {
        static int recursiveIncrease(int i) {
            return recursiveIncrease(i + 1);
        }

        public static void main(String[] args) {
            int[] a = new int[4];
            try {
                a[4] = recursiveIncrease(7);
            } catch (ArrayIndexOutOfBoundsException e) {
                System.out.println("Caught ArrayIndexOutOfBoundsException");
            } catch (StackOverflowError e) {
                System.out.println("Caught StackOverflowError");
            }
            System.out.println("Exiting main()");
        }
    }
    ```
  ]
]

#slide[
  #text(size: 13pt)[
    #question[
      - Oops, something goes wrong in the catch block below!
      - Is the new exception handled? What is output?
    ]
    ```java
    public class ExceptionTypes3 {
        static int recursiveIncrease(int i) {
            return recursiveIncrease(i + 1);
        }
        public static void main(String[] args) {
            int[] a = new int[4];
            try {
                a[4] = 0;
            } catch (ArrayIndexOutOfBoundsException e) {
                recursiveIncrease(7);
            } catch (StackOverflowError e) {
                System.out.println("Caught StackOverflowError");
            }
            System.out.println("Exiting main()");
        }
    }
    ```
  ]
]

#slide[
  #text(size: 18pt)[
    - A catch block only refers to its associated try block.
    - If catch block throws an exception, it is not caught by subsequent blocks
    #question[
      - How can we catch the exception generated in the catch block?
    ]
  ]
]


#slide[
  #text(size: 17pt)[
    - Source code that generates exception in nested try block
    ```java
    public static void main(String[] args) {
        int[] a = new int[4];
        try {
            a[4] = 0;
        } catch (ArrayIndexOutOfBoundsException e1) {
            try {
                recursiveIncrease(7);
            } catch (StackOverflowError e2) {
                System.out.println("Caught inner StackOverflowError");
            }
        } catch (StackOverflowError e) {
            System.out.println("Caught outer StackOverflowError");
        }
        System.out.println("Exiting main()");
    }
    ```
  ]
]

#slide[
  #text(size: 18pt)[
    - Sometimes certain code must be executed in any case.
    - Example: Closing open files or data streams

    - Optional finally block:
      - Always comes last (i.e. after try and catch blocks)
      - Code is executed at the end of the construct ... really always ... honestly!
    ```java
     try {
         // ...
     } catch (ExceptionType1 e) {
         // ...
     } catch (ExceptionType2 e) {
         // ...
     } finally {
         // Is guaranteed to be executed
     }
    ```
  ]
]

#slide[
  #text(size: 13pt)[
    #question[
      - What is output?
    ]
    ```java
    public class TryCatchFinally1 {
        static int recursiveIncrease(int i) {
            return recursiveIncrease(i + 1);
        }
        public static void main(String[] args) {
            int[] a = new int[4];
            try {
                a[4] = 0;
            } catch (ArrayIndexOutOfBoundsException e1) {
                recursiveIncrease(7);
                System.out.println("Caught ArrayIndexOutOfBoundsException");
            } finally {
                System.out.println("Finally");
            }
            System.out.println("Exiting main()");
        }
    }
    ```
  ]
]

#slide[
  #text(size: 13pt)[
    #question[
      - What is output?
    ]
    ```java
    public class TryCatchFinally2 {
        public static void main(String[] args) {
        System.out.println("Ratio = " + getRatio(3, 0));
        }
        public static int getRatio(int a, int b) {
            int ratio = 0;
            try {
                ratio = a / b;
            } catch (ArithmeticException e) {
                System.out.println("Exception caught in getRatio()");
                return 0;
            } finally {
                System.out.println("Finally");
            }
            System.out.println("Exiting getRatio()");
            return ratio;
        } }
    ```
  ]
]

#slide[
  #text(size: 13pt)[
    - Rules for blocks:
      - Exactly one try block as the first block
      - None or any number of catch blocks after the try block
      - None or one finally block as the last block
      - A try block must have at least one catch or finally block.

    - The following structure is allowed:
    ```java
    try {
         // ...
    } finally {
         // ...
    }
    ```
  ]
]

= Defining custom exceptions
== Custom exceptions

#slide[
  #text(size: 15pt)[
    - Let's consider the following program:
    ```java
    public class OwnException1 {
        public static void main(String[] args) {
            double x = 25.0;
            System.out.printf("sqrt(%f) = %f", x, squareRoot(x));
        }

        public static double squareRoot(double x) {
            return Math.sqrt(x);
        }
    }
    ```
    #question[
      - Method squareRoot() should throw an exception for negative parameters
      - How could we define our own type (e.g. NegativeParameterException)?
    ]
  ]
]

#slide[
  #text(size: 15pt)[
    - Custom exception type by deriving from an existing class
    - First approach: Derive from the Exception class

    #figure(image("../assets/img/slides_8/2024_11_05_vererbung_throwable_rev01.png", height: 60%))

  ]
]

#slide[
  #text(size: 15pt)[
    - Approach generates error message ("Unhandled exception")
    - Why is that now?!

    ```java
    class NegativeParamException extends Exception {
    }

    public class OwnException2 {
        public static void main(String[] args) {
            double x = 25.0;
            System.out.printf("sqrt(%f) = %f", x, squareRoot(x));
        }

        public static double squareRoot(double x) {
            if (x < 0.0) {
                throw new NegativeParamException();
            }
            return Math.sqrt(x);
        }
    }
    ```
  ]
]
#slide[
  #text(size: 17pt)[
    - Background:
      - Exceptions must be caught OR
      - Method must declare via throws that it can throw an exception type.

    ```java
    public class OwnException2 {
        public static void main(String[] args) throws NegativeParamException {
            double x = 25.0;
            System.out.printf("sqrt(%f) = %f", x, squareRoot(x));
        }

        public static double squareRoot(double x) throws NegativeParamException {
            if (x < 0.0) {
                throw new NegativeParamException();
            }
            return Math.sqrt(x);
        }
    }
    ```

  ]
]

#slide[
  #text(size: 18pt)[
    - This applies to all exception types (i.e. Throwable and derived from it) except for:
      - Class RuntimeException
      - Classes derived (directly or indirectly) from RuntimeException
        #figure(image("../assets/img/slides_8/2024_11_05_vererbung_runtimeexception_rev01.png"))
  ]
]

#slide[
  #text(size: 17pt)[

    ```java
    class NegativeParamException extends RuntimeException {
    }

    public class OwnRuntimeException {
        public static void main(String[] args) {
            double x = 25.0;
            System.out.printf("sqrt(%f) = %f", x, squareRoot(x));
        }

        public static double squareRoot(double x) {
            if (x < 0.0) {
                throw new NegativeParamException();
            }
            return Math.sqrt(x);
        }
    }
    ```
  ]
]


#slide[
  #text(size: 17pt)[

    - Description ("message") passed to constructor of base class
    ```java
    class MyException extends Exception {
        public MyException(String message) {
            super(message);
        }
    }

    public class OwnExceptionWithMessage {
        public static void main(String[] args) {
            try {
                throw new MyException("An exception just for fun :-) ...");
            } catch (MyException e) {
                System.out.println("Message: " + e.getMessage());
            }
        }
    }
    ```
  ]
]
= License Notice

== Attribution

- This work is shared under the CC BY-NC-SA 4.0 License and the respective Public
  License
- link("https://creativecommons.org/licenses/by-nc-sa/4.0/")
- This work is based off of the work Prof. Dr. Marc Hensel.
- Some of the images and texts, as well as the layout were changed.
- The base material was supplied in private, therefore the link to the source
  cannot be shared with the audience.
