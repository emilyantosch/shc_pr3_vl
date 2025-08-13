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
    subtitle: [Lecture 10 - Parallel Computing],
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

- In the last lecture, we dealt with output and input
- You can now
  - send and format output to the console in the right channel,
  - request input from the user
  - and read files in Java.
- Today we continue with *parallel processing*.

#slide[
  1. Imperative Konzepte
  2. Klassen und Objekte
  3. Klassenbibliothek
  4. Vererbung
  5. Schnittstellen
  6. Graphical User Interfaces
  7. Exception Handling
  8. Input and Output
  9. *Multithreading (Parallel Computing)*
]

== The goal of this chapter

- You execute program code simultaneously in concurrent execution threads (threads).
- You modify the states of active threads to generate the required functionality.
- You synchronize threads and objects to prevent erroneous data states due to incorrect execution orders.

= Parallel processing
== Example: Scrambled eggs and pudding

#slide[
  #text(size: 18pt)[

    - You make scrambled eggs and pudding.
    - Possible sequence:
    #figure(image("../assets/img/slides_10/2024_11_07_serial_ruehrei_rev01.png", height: 40%))

    #question[
      - What could the sequence look like if four of you are cooking?
      - Constraint: There is only one stove burner
    ]
  ]
]

#slide[
  #text(size: 18pt)[

    - Possible sequence
    - Resource conflict: stove burner

    #figure(image("../assets/img/slides_10/2024_11_07_parallel_ruehrei_rev01.png", height: 80%))

  ]
]

#slide[
  #text(size: 18pt)[
    - Possible distribution among four people
    #figure(image("../assets/img/slides_10/2024_11_07_parallel_swimlane_rev01.png", height: 80%))
  ]
]

#slide[
  #text(size: 18pt)[
    - Task is divided into subtasks that can be executed in parallel
    - Results of subtasks must be exchanged

    - Problems:
      - Dependencies: Subtasks need results of other subtasks
      - Resource conflict: Subtasks need the same resource
      - Communication overhead: Exchange of results requires resources and time

    - Tasks cannot be parallelized arbitrarily or automatically.
  ]
]

#slide[
  #text(size: 18pt)[
    - Terms:
      - Thread (English for "thread"): Execution thread within a program
      - Multithreading: Multiple (parallel) execution threads within a program

    - Memory:
      - Threads share the memory area of the program:
      - Therefore share variables and objects
      - Can communicate efficiently (but unsafely!) via variables and objects
    - But: Each thread has its own call stack of called methods
  ]
]

#slide[
  #text(size: 18pt)[
    #question[
      - Small riddle in between:
      - We have already learned about at least one parallel thread. Which one?
    ]
    #pause
    - Answer:
      - Garbage Collector (free memory of unreferenced objects)

    - Note:
      - Java programs create a main thread on startup
      - Set main() as the bottom method on the call stack
      - If needed, additionally a thread for the Garbage Collector is started
      - Program terminates as soon as the last associated thread has terminated
  ]
]

#slide[
  #text(size: 18pt)[
    - Allocates computing time (i.e. processors or processor cores) to programs and threads
    - Waiting times of other threads or programs are used

    - Pseudo-parallelism:
      - If there are more parallel execution threads than processors or processor cores
      - Scheduler distributes computing time in slices:
        - Execution in temporal alternation
        - Impression that things are processed in parallel
  ]
]

= Class-based threads
== Class Thread

#slide[
  #text(size: 18pt)[

    - Threads are created by objects of the Thread class:
    - Method `start()` creates and starts parallel execution thread
    - Method `run()` contains code to be executed in execution thread
    - Execution thread is terminated as soon as `run()` is terminated

    #figure(image("../assets/img/slides_10/2024_11_07_klasse_thread_uml_rev01.png", height: 40%))
  ]
]

#slide[
  #text(size: 18pt)[

    - Illustration
    #figure(image("../assets/img/slides_10/2024_11_07_programmfluss_thread_rev01.png", height: 60%))
  ]
]

#slide[
  #text(size: 13pt)[
    #task[
      - Let's implement this:
      - Write a program that creates an additional thread.
    ]

    ```java
    public class RunThread1 {
        public static void main(String[] args) {
            Thread thread = new Thread();
            System.out.println("Object created");
            thread.start();
            System.out.println("Thread started");
        }
    }
    ```
    #question[
      - But you can't see anything from the thread!
        - The run() method of the Thread class is "empty".
        - How can we make the thread output text to the console?
    ]
  ]
]
#slide[
  #text(size: 18pt)[
    - Approach:
      - The actual work takes place in the run() method.
      - The run() method of the Thread class is "empty".

    - Derive your own Thread class from Thread and override run()

    #figure(image("../assets/img/slides_10/2024_11_07_vererbung_thread_uml_rev01.png", height: 40%))
  ]
]

#slide[
  #text(size: 15pt)[
    #task[
      - Generate console output in an additional thread.
    ]

    ```java
    public class PrintThread extends Thread {
        public void run() {
            System.out.println("Hooray, I'm running in parallel!");
        }
    }

    public class RunThread2 {
        public static void main(String[] args) {
            PrintThread thread = new PrintThread();
            System.out.println("Object created");
            thread.start();
            System.out.println("Thread started");
        }
    }
    ```
  ]
]

= Interface-based threads
== Interface Runnable

#slide[
  #text(size: 18pt)[

    - Alternative to deriving from Thread:
      - Own class implements interface `Runnable` with `run()` method
      - Runnable object is passed to Thread object: No inheritance required

    - Responsibilities:
      - Runnable object contains what should be executed
      - Thread object contains everything needed for concurrency

    #figure(image("../assets/img/slides_10/2024_11_07_interface_Runnable_rev01.png", height: 40%))
  ]
]

#slide[
  #text(size: 16pt)[
    ```java
    public class PrintRunnable implements Runnable {
        public void run() {
            System.out.println("Hooray, I'm running in parallel!");
        }
    }

    public class InterfaceBased {
        public static void main(String[] args) {
            PrintRunnable runnable = new PrintRunnable();
            Thread thread = new Thread(runnable);

            System.out.println("Objects created");
            thread.start();
            System.out.println("Thread started");
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
    class CounterRunnable implements Runnable {
        private int counter;
        public void run() {
            while (counter < 10)
                System.out.println("\t\t\tThread counter: " + counter++);
            System.out.println("\t\t\tExiting run()");
        }
    }
    public class Counters {
        private static int counter;
        public static void main(String[] args) {
            new Thread(new CounterRunnable()).start();
            while (counter < 10)
                System.out.println("Main counter: " + counter++);
            System.out.println("Exiting main()");
        }
    }
    ```
  ]
]

#slide[
  #text(size: 18pt)[
    #let body = [

      - Methods `run()` and `main()` count to 9
      - Unpredictable who finishes first

      - Example output (right):
        - `main` thread finished first
        - Thread with `run()` continues running
    ]
    #let fig = figure(image("../assets/img/slides_10/2024_11_07_thread_counter_rev01.png"))
    #grid(
      columns: (60%, 40%),
      gutter: 0.25em,
      body, fig,
    )
  ]
]

= States and selected methods
== Thread states

#slide[
  #text(size: 18pt)[
    #question[
      - Imagine you were a thread:
        - What states could you reasonably take?
        - What state transitions would make sense?
    ]

    - Don't forget the following:
      - What happens when there are more threads than processors?
      - What should you do when waiting for input?
  ]
]

#slide[
  #text(size: 18pt)[

    - New: Java object created, but not yet started as a thread
    - Runnable: Ready to be executed. Waiting for processor.
    - Running: Has processor and is currently being executed
    - Blocked: Is not executed and would not be even with a free processor
    - Terminated: Thread terminated. Java object still exists!

    #figure(image("../assets/img/slides_10/2024_11_07_ablauf_thread_queue_rev01.png", height: 50%))
  ]
]

#slide[
  #text(size: 16pt)[

    - Assigns computing time to threads (i.e. Runnable becomes Running)
    - Withdraws processor from threads again (i.e. Running becomes Runnable):
      - Required if more threads than processors exist
      - Idea: Threads receive computing time alternately

    - Control of behavior:
      - Scheduler is not controllable
      - No guarantee that threads receive computing time alternately
      - `setPriority()` sets priority, but no guarantee how scheduler considers it
      - "The scheduler is a diva!"

    #figure(image("../assets/img/slides_10/2024_11_07_lauffaehig_laeuft_rev01.png", height: 35%))
  ]
]

#slide[
  #text(size: 18pt)[
    #let body = [
      - Put running thread in blocked state for a certain time
      - Pass waiting time in milliseconds as parameter (data type long)

      - Early wake-up:
        - Thread can be "woken up" prematurely by interrupt() method
        - Throws exception of type InterruptedException

      ```java
      MyThread thread = new MyThread();
      thread.start();
      try {
          Thread.sleep(1000);
      } catch (InterruptedException e) {
          e.printStackTrace();
      }
      ```
    ]
    #let fig = figure(image("../assets/img/slides_10/2024_11_07_laufend_sleep_block_rev01.png"))
    #grid(
      columns: (80%, 20%),
      gutter: 0.25em,
      body, fig,
    )
  ]
]

#slide[
  #text(size: 13pt)[

    - Make the window blink (every 0.75 s alternating between yellow and light gray):
    ```java
    public class FlashLight {
        private boolean isLightOn;
        private JFrame frame;
        private FlashLight() {
            frame = new JFrame("Flashing light");
            frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
            frame.setSize(300, 250);
            frame.setVisible(true);
        }
        public void switchLight() {
            isLightOn = !isLightOn;
            if (isLightOn)
                frame.getContentPane().setBackground(Color.YELLOW);
            else
                frame.getContentPane().setBackground(Color.LIGHT_GRAY);
        }
        public static void main(String[] args) {
            FlashLight flashLight = new FlashLight();
        }
    }
    ```
  ]
]
#slide[
  #text(size: 14pt)[

    - Required for blinking:
      - Thread that calls the switchLight() method every 0.75 s

    ```java
    class FlashThread extends Thread {
        private FlashLight flashLight;

        public FlashThread(FlashLight flashLight) {
            this.flashLight = flashLight;
        }

        public void run() {
            while (true) {
                flashLight.switchLight();
                try {
                    Thread.sleep(750);
                } catch (InterruptedException e) {
                }
            }
        }
    }
    ```
  ]
]

#slide[
  #text(size: 18pt)[
    - Creation and starting of the thread in FlashLight:
    ```java
    public static void main(String[] args) {
        FlashLight flashLight = new FlashLight();
        FlashThread thread = new FlashThread(flashLight);
        thread.start();
    }
    ```

    #figure(image("../assets/img/slides_10/2024_11_11_flashlight_rev01.png", height: 50%))
  ]
]

#slide[
  #text(size: 18pt)[

    #let body = [
      - Make running thread wait for the end of another thread

      - Example:
        - Waits at `thread.join()` until `thread` terminates
        - Only then console output occurs

      ```java
      public static void main(String[] args) {
          MyThread thread = new MyThread();
          thread.start();
          thread.join();
          System.out.println("We have joined!");
      }
      ```
      - Maximum waiting time:
        - Maximum waiting time can be specified as parameter (data type `long`)
        - What is this needed for? (After all, you don't wait for no reason)

    ]
    #let fig = figure(image("../assets/img/slides_10/2024_11_11_blocked_join_rev01.png"))
    #grid(
      columns: (80%, 20%),
      gutter: 0.5em,
      body, fig,
    )
  ]
]

#slide[
  #text(size: 15pt)[
    #question[
      - What does this thread do?
    ]

    ```java
    public class SleepyThread extends Thread {
        public void run() {
            for (int i = 0; i < 5; i++) {
                System.out.println("I'm sooo tired ...");
                try {
                    Thread.sleep(1000);
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
            }
            System.out.println("Okay, I'm awake again.");
        }
    }
    ```
  ]
]

#slide[
  #text(size: 15pt)[
    - It continues:
      - What output is produced?
      - What output would be produced without the line sleepy.join()?
      - What output would be produced with sleepy.join(1500)?
    ```java
    public class JoinThreads {
        public static void main(String[] args) throws InterruptedException {
            SleepyThread sleepy = new SleepyThread();
            sleepy.start();

            while (sleepy.isAlive()) {
                System.out.println("Wake up!");
                Thread.sleep(400);
                sleepy.join();
            }
            System.out.println("At last ...");
        }
    }
    ```
  ]
]

= Synchronization
== Synchronization
#slide[
  #text(size: 13pt)[
    - Class represents a bank account with methods for deposits and withdrawals
    - Account movements in parallel via threads (e.g. ATM, counter, direct debit)

    ```java
    public class Account {
        private double balance;

        public void deposit(double amount) {
            double newBalance = balance + amount;
            if (newBalance > balance)
                balance = newBalance;
        }

        public void withdraw(double amount) {
            double newBalance = balance - amount;
            if (newBalance >= 0.0)
                balance = newBalance;
        }
    }
    ```
    - What happened there?!
      - You withdraw 50 € while 50 € is credited as a transfer.
      - Afterwards there are 50 € less than before in the account.

  ]
]
#slide[
  #text(size: 18pt)[
    - Cause:
      - Threads simultaneously execute methods deposit() and withdraw()
      - Both methods access variable balance.

    #figure(image("../assets/img/slides_10/2024_11_11_deposit_withdraw_thread_rev01.png", height: 50%))

  ]
]

#slide[
  #text(size: 15pt)[
    - Two threads share a variable.
      - Race Condition: Result of the program depends on access order

    - When does the result depend on which thread is "faster"?
      - Both threads read the variable
      - One thread reads, one thread writes to the variable
      - Both threads write to the variable

    - Answer:
      - Race condition when at least one thread writes

    #figure(image("../assets/img/slides_10/2024_11_11_race_conditions_rev01.png", height: 40%))
  ]
]

#slide[
  #text(size: 18pt)[
    - Keyword `synchronized` for methods:
      - Object is locked as soon as a thread enters a synchronized method
      - Object is released again when thread leaves the method

    - Synchronized methods (mutual exclusion):
      - Object locked: Threads cannot enter synchronized methods. (All synchronized methods are locked, not just the one currently being executed!)
      - Threads wait in blocked state until the object is released again.

    - Non-synchronized methods:
      - Threads can enter non-synchronized methods when object is locked.

    #task[
      - Help your bank:
        - Ensure that nothing goes wrong with deposits and withdrawals.
    ]
  ]
]

#slide[
  #text(size: 16pt)[

    Synchronization via `synchronized`:
    ```java
    public class Account {
        private double balance;

        public synchronized void deposit(double amount) {
            double newBalance = balance + amount;
            if (newBalance > balance)
                balance = newBalance;
        }

        public synchronized void withdraw(double amount) {
            double newBalance = balance - amount;
            if (newBalance >= 0.0)
                balance = newBalance;
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
