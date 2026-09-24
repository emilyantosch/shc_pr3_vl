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
    short-title: [Java · Lecture 10],
    subtitle: [Lecture 10 - Parallel Computing],
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
== From I/O to Concurrent Tasks
#slide[
  #diagram("roadmap", height: 180pt)
]

== Create, Coordinate, Protect
#slide[
  #diagram("goals", height: 240pt)
  #text(18pt)[Examples use platform threads. Swing examples omit imports from javax.swing and java.awt.]
]

= Parallel Processing
== Scrambled Eggs and Pudding: One Cook
#slide[
  #diagram("cooking-serial", height: 210pt)
  #question[How would four cooks share the work with only one burner?]
]

== Four Cooks, One Burner
#slide[
  #diagram("cooking-parallel", height: 285pt)
  #text(18pt)[Prepare in parallel; use the burner in sequence. Arrows show prerequisites, not durations.]
]

== What Limits Parallel Work?
#slide[
  #diagram("constraints", height: 265pt)
  #text(18pt)[More threads do not automatically make a program faster.]
]

== Separate Stacks, Shared Objects
#slide[
  #diagram("memory", height: 275pt)
  #text(18pt)[A thread is an execution path within a process. Shared objects allow communication—and conflicting access.]
]

== Which Threads Already Exist?
#slide[
  #question[Besides main, which background work does the JVM perform?]
]
#slide[
  #diagram("jvm-threads", height: 255pt)
  #text(18pt)[A worker can outlive main(). Daemon threads do not keep the JVM alive.]
]

== Concurrency Is Not Always Parallelism
#slide[
  #diagram("scheduling", height: 275pt)
]

= Class-Based Threads
== start() Creates Concurrency; run() Contains Work
#slide[
  #diagram("thread-api", height: 240pt)
]

== Object Creation Is Not Thread Start
#slide[
  #diagram("fork", height: 240pt)
]

== Start an Empty Thread
#slide[
  #text(20pt)[
    #task[Create and start an additional thread.]
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
    Why does the worker print nothing? No task was supplied to run().
  ]
]

== Extend Thread and Override run()
#slide[
  #diagram("inheritance", height: 250pt)
  #task[Make the worker print a message. Call start(), not run().]
]

== A Thread Subclass
#slide[
  #text(19pt)[
    ```java
    public class PrintThread extends Thread {
        @Override
        public void run() {
            System.out.println("Hooray, I'm running in parallel!");
        }
    }
    ```
    ```java
    public class RunThread2 {
        public static void main(String[] args) {
            PrintThread thread = new PrintThread();
            thread.start();
            System.out.println("Thread started");
        }
    }
    ```
    Separate files: PrintThread.java and RunThread2.java. Which message appears first?
  ]
]

= Interface-Based Threads
== Separate the Task from Its Execution
#slide[
  #diagram("runnable", height: 275pt)
  #text(18pt)[Implementing Runnable leaves your class free to extend another class.]
]

== Implement Runnable
#slide[
  #text(20pt)[
    ```java
    public class PrintRunnable implements Runnable {
        @Override
        public void run() {
            System.out.println("Hooray, I'm running in parallel!");
        }
    }
    ```
    ```java
    public class InterfaceBased {
        public static void main(String[] args) {
            PrintRunnable task = new PrintRunnable();
            Thread thread = new Thread(task);
            thread.start();
            System.out.println("Thread started");
        }
    }
    ```
  ]
]

== Two Counters: The Worker
#slide[
  #text(20pt)[
    ```java
    class CounterRunnable implements Runnable {
        private int counter;
        @Override
        public void run() {
            while (counter < 10) {
                System.out.println("Thread counter: " + counter++);
            }
            System.out.println("Exiting run()");
        }
    }
    ```
    This counter belongs to the Runnable object.
  ]
]

== Two Counters: The Main Thread
#slide[
  #text(20pt)[
    ```java
    public class Counters {
        private static int counter;
        public static void main(String[] args) {
            new Thread(new CounterRunnable()).start();
            while (counter < 10) {
                System.out.println("Main counter: " + counter++);
            }
            System.out.println("Exiting main()");
        }
    }
    ```
    Predict the output. These are two separate counter fields, not shared state.
  ]
]

== One Possible Interleaving
#slide[
  #diagram("counter-output", height: 285pt)
  #text(18pt)[Neither thread is guaranteed to finish first. The worker can continue after main returns.]
]

= Thread States and Waiting
== Think Like a Thread
#slide[
  #question[Which states and transitions do you need when the CPU is busy, a lock is held, or another thread has not finished?]
]

== Java Thread.State
#slide[
  #diagram("states", height: 290pt)
]

== Ready and Running Are Both RUNNABLE
#slide[
  #diagram("scheduler", height: 270pt)
]

== sleep() Pauses the Calling Thread
#slide[
  #diagram("sleep", height: 260pt)
  #text(18pt)[Milliseconds are a long value. Timing depends on the scheduler; it is not an exact deadline.]
]

== Handle Interruption
#slide[
  #text(20pt)[
    ```java
    public static void main(String[] args) {
        Thread worker = new Thread(new PrintRunnable());
        worker.start();
        try {
            Thread.sleep(1000);
        } catch (InterruptedException e) {
            Thread.currentThread().interrupt();
            return;
        }
        System.out.println("Main is ready again");
    }
    ```
    Main sleeps, not worker. Restore the interrupt flag when you cannot propagate the exception.
  ]
]

== Task: Blink a Window
#slide[
  #task[Alternate the background between yellow and light gray about every 750 ms.]
  #diagram("blink", height: 220pt)
]

== Keep Swing Updates on the Event Dispatch Thread
#slide[
  #diagram("gui-threads", height: 265pt)
  #text(18pt)[Never sleep on the EDT. A Swing Timer is simpler for real GUI animation; this exercise demonstrates a worker thread.]
]

== Build the Window on the EDT
#slide[
  #text(19pt)[
    ```java
    public class FlashLight {
        private boolean isLightOn;
        private final JFrame frame = new JFrame("Flashing light");
        public FlashLight() {
            frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
            frame.setSize(300, 250);
            frame.getContentPane().setBackground(Color.LIGHT_GRAY);
            frame.setVisible(true);
        }
        public void switchLight() {
            isLightOn = !isLightOn;
            frame.getContentPane().setBackground(
                isLightOn ? Color.YELLOW : Color.LIGHT_GRAY);
        }
    }
    ```
  ]
]

== A Worker Schedules the Color Change
#slide[
  #text(19pt)[
    ```java
    class FlashThread extends Thread {
        private final FlashLight light;
        FlashThread(FlashLight light) { this.light = light; }
        public void run() {
            while (!isInterrupted()) {
                SwingUtilities.invokeLater(light::switchLight);
                try {
                    Thread.sleep(750);
                } catch (InterruptedException e) {
                    Thread.currentThread().interrupt();
                    return;
                }
            }
        }
    }
    ```
  ]
]

== Start the Window and Worker
#slide[
  #text(20pt)[
    Add this method to FlashLight:
    ```java
    public static void main(String[] args) {
        SwingUtilities.invokeLater(() -> {
            FlashLight light = new FlashLight();
            new FlashThread(light).start();
        });
    }
    ```
    The lambda runs on the EDT. Closing this demo window exits the application.
  ]
]

== join() Waits for Another Thread to Finish
#slide[
  #diagram("join", height: 240pt)
]

== Continue Only After the Worker Ends
#slide[
  #text(20pt)[
    ```java
    public static void main(String[] args)
            throws InterruptedException {
        Thread worker = new Thread(new PrintRunnable());
        worker.start();
        worker.join();
        System.out.println("We have joined!");
    }
    ```
    join(ms) limits the wait; check isAlive() afterwards. A timeout does not stop the worker.
  ]
]

== A Sleepy Worker
#slide[
  #text(18pt)[
    ```java
    public class SleepyThread extends Thread {
        @Override
        public void run() {
            for (int i = 0; i < 5; i++) {
                System.out.println("I'm sooo tired ...");
                try {
                    Thread.sleep(1000);
                } catch (InterruptedException e) {
                    Thread.currentThread().interrupt();
                    return;
                }
            }
            System.out.println("Okay, I'm awake again.");
        }
    }
    ```
  ]
]

== Predict the Output with and Without join()
#slide[
  #text(19pt)[
    ```java
    public class JoinThreads {
        public static void main(String[] args)
                throws InterruptedException {
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
    Compare join(), no join(), and join(1500). Which thread waits?
  ]
]

== Three Waiting Behaviors
#slide[
  #diagram("join-variants", height: 245pt)
  #text(18pt)[The combined sleep and timed join make the interval roughly 1900 ms while sleepy is still alive, not exactly 1500 ms.]
]

= Synchronization
== Shared Account, Concurrent Updates
#slide[
  #text(18pt)[
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
    Starting at €5000, two threads deposit and withdraw €50. Could the balance end at €4950?
    Teaching model only: real money needs decimal or integer units and input validation.
  ]
]

== A Lost Update
#slide[
  #diagram("lost-update", height: 295pt)
]

== Conflicting Access to Shared State
#slide[
  #diagram("access", height: 285pt)
  #text(18pt)[A race condition makes correctness depend on timing. Unsynchronized conflicting accesses to a shared field form a data race.]
]

== synchronized Uses the Object's Monitor
#slide[
  #diagram("monitor", height: 230pt)
  #task[Protect both account methods with the same monitor.]
]

== Protect the Whole Read–Check–Write
#slide[
  #text(19pt)[
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
    Unlocking makes writes visible to the next thread that acquires the same monitor.
  ]
]

== Serialize Updates, Not the Whole Program
#slide[
  #diagram("safe-update", height: 240pt)
]

== The Monitor Belongs to the Object
#slide[
  #diagram("monitor-scope", height: 270pt)
  #text(18pt)[Unsynchronized methods do not acquire the monitor and can still run. Protect every access to shared mutable state.]
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
