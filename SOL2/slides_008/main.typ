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
    short-title: [Java · Lecture 8],
    subtitle: [Lecture 8 - Exception Handling],
    author: [Emily Lucia Antosch],
    date: datetime.today().display("[day].[month].[year]"),
    institution: [HAW Hamburg],
  ),
)

// Codly uses grid rows: vertical inset controls code line spacing.
#show raw.where(block: true): it => {
  codly(inset: (x: .32em, y: .22em))
  it
}

#title-slide(authors: [Emily Lucia Antosch])
#outline-slide()

= Introduction
== From Interfaces to Exception Handling
#slide[
  #diagram("roadmap", height: 190pt)
]

== Handle Failures, Define Their Meaning
#slide[
  #diagram("goals", height: 220pt)
]

= Exception Handling
== Predict the Output
#slide[
  #text(18pt)[
    What is printed for (3, 2)? What changes for (7, 0)?
    ```java
    public class ProvokeException {
        public static void main(String[] args) {
            printRatio(3, 2);
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

== What Can Fail?
#slide[
  #diagram("failures", height: 260pt)
  #text(18pt)[Which failures could the application recover from?]
]

== Throwable: Exceptions and Errors
#slide[
  #diagram("hierarchy", height: 260pt)
]

== Spot the Exception
#slide[
  #text(20pt)[
    Evaluate each snippet independently.
    ```java
    int[] array = {1, 2, 3, 4};
    System.out.println(array[4]);
    ```
    ```java
    String message = null;
    System.out.println(message.length());
    ```
    ```java
    int code = Integer.parseInt("12a4");
    ```
    An uninitialized local variable would be a compile-time error, not a null reference.
  ]
]

== Throw, Search, Handle
#slide[
  #diagram("handling", height: 270pt)
]

= Throwing exceptions
== Throw an Exception Object
#slide[
  #text(20pt)[
    Java throws exceptions for failures such as integer division by zero.
    Your code can also throw explicitly:
    ```java
    throw new ArithmeticException("Division by zero");
    ```
    Or create the object first:
    ```java
    ArithmeticException problem =
        new ArithmeticException("Division by zero");
    throw problem;
    ```
    The optional message explains the failure.
  ]
]

== Task: Reject a Zero Divisor
#slide[
  #task[Throw ArithmeticException before dividing if b is zero. Include a message.]
  #text(20pt)[
    ```java
    public static void printRatio(int a, int b) {
        int ratio = a / b;
        System.out.println("Ratio = " + ratio);
    }
    ```
  ]
]

== An Explicit Guard
#slide[
  #text(18pt)[
    ```java
    public class ThrowException {
        public static void main(String[] args) {
            printRatio(3, 0);
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
    The final print statement in main is never reached.
  ]
]

== Read a Stack Trace
#slide[
  #text(18pt)[
    ```text
    Exception in thread "main" java.lang.ArithmeticException: Division by zero
        at ThrowException.printRatio(ThrowException.java:8)
        at ThrowException.main(ThrowException.java:3)
    ```
  ]
  #diagram("stack-trace", height: 160pt)
]

= Catching exceptions
== Catch a Matching Type
#slide[
  #text(20pt)[
    ```java
    try {
        // Code that may throw.
    } catch (ArithmeticException e) {
        // Handle the failure.
    }
    // Continue if try or catch completes normally.
    ```
    A catch matches its declared type and subclasses.
    Throwing skips the rest of the try block.
  ]
]

== Follow the Control Flow
#slide[
  #diagram("catch-flow", height: 280pt)
]

== Task: Keep the Caller Running
#slide[
  #task[Catch the division failure inside printRatio. Let main reach its final print statement.]
  #text(20pt)[
    ```java
    public static void printRatio(int a, int b) {
        int ratio = a / b;
        System.out.println("Ratio = " + ratio);
    }
    ```
  ]
]

== Handle the Failure Locally
#slide[
  #text(20pt)[
    ```java
    public static void printRatio(int a, int b) {
        try {
            int ratio = a / b;
            System.out.println("Ratio = " + ratio);
        } catch (ArithmeticException e) {
            System.out.println("Caught in printRatio()");
            System.out.println(e.getMessage());
            System.out.println(e.toString());
        }
        System.out.println("Exiting printRatio()");
    }
    ```
  ]
]

== Inspect the Exception Object
#slide[
  #diagram("methods", height: 235pt)
]

== Catch Locally: Is Zero a Valid Result?
#slide[
  #text(18pt)[
    ```java
    public static void main(String[] args) {
        System.out.println("Ratio = " + getRatio(3, 0));
        System.out.println("Exiting main()");
    }
    public static int getRatio(int a, int b) {
        int ratio = 0;
        try {
            ratio = a / b;
        } catch (ArithmeticException e) {
            System.out.println("Caught in getRatio()");
        }
        System.out.println("Exiting getRatio()");
        return ratio;
    }
    ```
  ]
]

== Catch in the Caller
#slide[
  #text(18pt)[
    ```java
    public static void main(String[] args) {
        try {
            int ratio = getRatio(3, 0);
            System.out.println("Ratio = " + ratio);
        } catch (ArithmeticException e) {
            System.out.println("Caught in main()");
        }
        System.out.println("Exiting main()");
    }
    public static int getRatio(int a, int b) {
        int ratio = a / b;
        System.out.println("Exiting getRatio()");
        return ratio;
    }
    ```
  ]
]

== Choose the First Matching Catch
#slide[
  #diagram("catch-order", height: 280pt)
]

== Put Specific Types First
#slide[
  #text(20pt)[
    ```java
    try {
        // Code that may throw.
    } catch (NumberFormatException e) {
        // Invalid numeric text.
    } catch (IllegalArgumentException e) {
        // Other invalid arguments.
    }
    ```
    NumberFormatException extends IllegalArgumentException.
    Reversing these catches makes the first case unreachable.
  ]
]

== Two Failures, One Evaluation Order
#slide[
  #text(18pt)[
    Which failure happens first? What is printed?
    ```java
    static int recursiveIncrease(int i) {
        return recursiveIncrease(i + 1);
    }
    public static void main(String[] args) {
        int[] a = new int[4];
        try {
            a[4] = recursiveIncrease(7);
        } catch (ArrayIndexOutOfBoundsException e) {
            System.out.println("Caught invalid index");
        }
        System.out.println("Exiting main()");
    }
    ```
  ]
]

== Catch Either Failure Type
#slide[
  #text(18pt)[
    Add a catch for StackOverflowError. Use recursiveIncrease from the previous slide.
    ```java
    public static void main(String[] args) {
        int[] a = new int[4];
        try {
            a[4] = recursiveIncrease(7);
        } catch (ArrayIndexOutOfBoundsException e) {
            System.out.println("Caught invalid index");
        } catch (StackOverflowError e) {
            System.out.println("Caught StackOverflowError");
        }
        System.out.println("Exiting main()");
    }
    ```
    For this assignment, the right-hand side runs before the bounds check.
    Only StackOverflowError occurs. Catching it is a teaching example, not a recovery strategy.
  ]
]

== An Exception Inside a Catch
#slide[
  #text(18pt)[
    Is the new failure handled? Predict the output.
    ```java
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
    ```
    Use recursiveIncrease from the previous example.
  ]
]

== Sibling Catches Do Not Protect Each Other
#slide[
  #diagram("catch-scope", height: 255pt)
]

== A Nested Handler
#slide[
  #text(20pt)[
    ```java
    int[] a = new int[4];
    try {
        a[4] = 0;
    } catch (ArrayIndexOutOfBoundsException e) {
        try {
            recursiveIncrease(7);
        } catch (StackOverflowError inner) {
            System.out.println("Caught inner StackOverflowError");
        }
    }
    System.out.println("Continuing after the handler");
    ```
    In real code, fix the recursion rather than relying on this recovery.
  ]
]

== Finally: Cleanup Before Leaving
#slide[
  #diagram("finally-flow", height: 215pt)
  #text(18pt)[
    Finally runs when control leaves try / catch, including on return or throw.
    It is not guaranteed if the JVM terminates or execution never leaves the block.
  ]
]

== Write Cleanup Last
#slide[
  #text(20pt)[
    ```java
    try {
        // Use a resource.
    } catch (SomeException e) {
        // Handle a specific failure.
    } finally {
        // Cleanup, e.g. close an opened resource.
    }
    ```
    SomeException is a placeholder for the relevant type.
    For closeable resources, prefer try-with-resources (next lecture).
  ]
]

== Finally During Propagation
#slide[
  #text(18pt)[
    What is printed before the uncaught error? Use recursiveIncrease as before.
    ```java
    public static void main(String[] args) {
        int[] a = new int[4];
        try {
            a[4] = 0;
        } catch (ArrayIndexOutOfBoundsException e) {
            recursiveIncrease(7);
            System.out.println("Caught invalid index");
        } finally {
            System.out.println("Finally");
        }
        System.out.println("Exiting main()");
    }
    ```
  ]
]

== Finally Before a Return
#slide[
  #text(18pt)[
    Predict the output of System.out.println("Ratio = " + getRatio(3, 0)).
    ```java
    public static int getRatio(int a, int b) {
        int ratio = 0;
        try {
            ratio = a / b;
        } catch (ArithmeticException e) {
            System.out.println("Caught in getRatio()");
            return 0;
        } finally {
            System.out.println("Finally");
        }
        System.out.println("Exiting getRatio()");
        return ratio;
    }
    ```
  ]
]

== Valid Block Combinations
#slide[
  #diagram("structure", height: 140pt)
  #text(20pt)[
    Cleanup without a handler:
    ```java
    try {
        // May throw; no local recovery.
    } finally {
        // Cleanup before propagation.
    }
    ```
  ]
]

= Defining custom exceptions
== Give a Domain Failure a Type
#slide[
  #text(20pt)[
    ```java
    public static double squareRoot(double x) {
        return Math.sqrt(x);
    }
    ```
    Math.sqrt returns NaN for negative input; this application should reject it.
  ]
  #task[Define NegativeParamException and throw it when x < 0.]
]

== Extend an Existing Exception Class
#slide[
  #diagram("custom", height: 280pt)
]

== Why Does This Not Compile?
#slide[
  #text(18pt)[
    ```java
    class NegativeParamException extends Exception {}

    public class OwnException {
        public static void main(String[] args) {
            System.out.println(squareRoot(25.0));
        }
        public static double squareRoot(double x) {
            if (x < 0.0) {
                throw new NegativeParamException();
            }
            return Math.sqrt(x);
        }
    }
    ```
    The compiler reports an unhandled checked exception, even with positive input in main.
  ]
]

== Checked Exceptions: Catch or Declare
#slide[
  #diagram("checked-choice", height: 250pt)
]

== Declare with throws
#slide[
  #text(18pt)[
    Use the same NegativeParamException class extending Exception.
    ```java
    public static void main(String[] args)
            throws NegativeParamException {
        System.out.println(squareRoot(25.0));
    }
    public static double squareRoot(double x)
            throws NegativeParamException {
        if (x < 0.0) {
            throw new NegativeParamException();
        }
        return Math.sqrt(x);
    }
    ```
    throws declares a possible failure; throw actually raises it.
    Declaring it in main does not handle it.
  ]
]

== Checked and Unchecked Types
#slide[
  #diagram("checked-tree", height: 280pt)
]

== Alternative: An Unchecked Custom Exception
#slide[
  #text(18pt)[
    ```java
    class NegativeParamException extends RuntimeException {}

    public class OwnRuntimeException {
        public static void main(String[] args) {
            System.out.println(squareRoot(25.0));
        }
        public static double squareRoot(double x) {
            if (x < 0.0) {
                throw new NegativeParamException();
            }
            return Math.sqrt(x);
        }
    }
    ```
    No catch or throws declaration is required. A caller can still catch it.
  ]
]

== Pass the Message to the Superclass
#slide[
  #diagram("message", height: 105pt)
  #text(20pt)[
    ```java
    class MyException extends Exception {
        public MyException(String message) {
            super(message);
        }
    }
    ```
  ]
]

== Read the Custom Message
#slide[
  #text(20pt)[
    ```java
    public static void main(String[] args) {
        try {
            throw new MyException("Invalid application state");
        } catch (MyException e) {
            System.out.println("Message: " + e.getMessage());
        }
    }
    ```
    Output: Message: Invalid application state
  ]
]

= License Notice
== Attribution
#slide[
  #text(18pt)[
    - Shared under #link("https://creativecommons.org/licenses/by-nc-sa/4.0/")[CC BY-NC-SA 4.0].
    - Based on teaching material by Prof. Dr. Marc Hensel, supplied privately.
    - Text, diagrams and layout adapted; the private source cannot be linked.
  ]
]
