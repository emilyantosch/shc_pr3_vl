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
    short-title: [Java · Lecture 9],
    subtitle: [Lecture 9 - Input and Output],
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
== From Exceptions to Input and Output
#slide[
  #diagram("roadmap", height: 180pt)
]

== Read, Transform, Write
#slide[
  #diagram("goals", height: 240pt)
  #text(18pt)[Examples omit imports from java.io, java.util and java.nio.charset.]
]

= Streams and Screen Output
== Input and Output Are Relative to the Program
#slide[
  #diagram("streams", height: 200pt)
]

== Read System.out.println()
#slide[
  #diagram("println-parts", height: 220pt)
]

== Choose an Output Method
#slide[
  #diagram("output-methods", height: 260pt)
]

== Predict the Output
#slide[
  #text(20pt)[
    ```java
    public static void main(String[] args) {
        double hawaii = 15.97;
        double hamburg = 22.71;
        String.format(Locale.ROOT, "Hawaii: %.1f °C", hawaii);
        System.out.printf(Locale.ROOT, "Hamburg: %.1f °C", hamburg);
    }
    ```
    Which call prints? Which returns a String? Is there a line break?
  ]
]

== Three Standard Streams
#slide[
  #diagram("system-streams", height: 270pt)
]

= Keyboard Input
== Scanner Splits and Parses Input
#slide[
  #diagram("scanner", height: 210pt)
  #text(18pt)[These one-shot examples close System.in at the end. Keep a shared Scanner open while the application still needs input.]
]

== Read a Line
#slide[
  #text(20pt)[
    ```java
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        System.out.print("Please enter a sentence: ");
        System.out.println(scanner.nextLine());
        scanner.close();
    }
    ```
    Replace nextLine() with next(). What changes?
  ]
]

== Tokens Are Not Lines
#slide[
  #diagram("tokens", height: 250pt)
  #text(18pt)[After nextInt(), nextLine() reads the rest of the current line—possibly empty.]
]

== Read Until End of Input
#slide[
  #diagram("token-loop", height: 245pt)
  #task[Read and print each token with next(). Stop at end of input.]
]

== A Token Loop
#slide[
  #text(20pt)[
    ```java
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        while (scanner.hasNext()) {
            System.out.println(scanner.next());
        }
        scanner.close();
    }
    ```
    What changes if the loop condition is true?
    Send EOF: Ctrl-D on an empty line (Unix), or Ctrl-Z then Enter (Windows).
  ]
]

== Parse a Typed Value
#slide[
  #text(20pt)[
    Predict the result for 127, 128 and Hamburg.
    ```java
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        System.out.print("Please enter a byte value: ");
        System.out.println("Entered: " + scanner.nextByte());
        scanner.close();
    }
    ```
    Other pairs: nextInt() / hasNextInt(), nextDouble() / hasNextDouble(),
    nextBoolean() / hasNextBoolean().
  ]
]

== A Token Must Fit the Type
#slide[
  #diagram("typed-input", height: 245pt)
  #task[Handle invalid input in two ways: catch the exception, or check before reading.]
]

== Two Ways to Handle a Mismatch
#slide[
  #diagram("validation", height: 270pt)
  #text(18pt)[hasNextByte() does not consume input. Before retrying, consume an invalid token with next().]
]

== Catch the Exception
#slide[
  #text(19pt)[
    ```java
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        try {
            System.out.println("Entered: " + scanner.nextByte());
        } catch (InputMismatchException e) {
            System.out.println("Not a byte value: " + scanner.next());
        } finally {
            scanner.close();
        }
    }
    ```
    This version assumes a token is available. EOF throws NoSuchElementException.
  ]
]

== Check Before Reading
#slide[
  #text(19pt)[
    ```java
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        if (scanner.hasNextByte()) {
            System.out.println("Entered: " + scanner.nextByte());
        } else if (scanner.hasNext()) {
            System.out.println("Not a byte value: " + scanner.next());
        } else {
            System.out.println("End of input.");
        }
        scanner.close();
    }
    ```
  ]
]

== Task: Read a Vector
#slide[
  #task[Read int components until a non-integer token or EOF. Print the vector and its magnitude.]
  #diagram("vector-flow", height: 190pt)
]

== Collect the Components
#slide[
  #text(20pt)[
    ```java
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        ArrayList<Integer> vector = new ArrayList<>();
        while (scanner.hasNextInt()) {
            vector.add(scanner.nextInt());
        }
        scanner.close();
        printVector(vector);
    }
    ```
    Add the method from the next slide to the same class.
  ]
]

== Compute the Magnitude
#slide[
  #text(20pt)[
    ```java
    static void printVector(ArrayList<Integer> vector) {
        double sumOfSquares = 0;
        for (int component : vector) {
            sumOfSquares += (double) component * component;
        }
        System.out.println("a = " + vector + "^T");
        System.out.printf(Locale.ROOT, "||a|| = %.2f%n",
            Math.sqrt(sumOfSquares));
    }
    ```
    Convert before multiplication to avoid int overflow. An empty vector has magnitude 0.
  ]
]

= Byte and Character Streams
== Bytes and Characters Have Different APIs
#slide[
  #diagram("stream-types", height: 270pt)
]

== Decode Bytes into Characters
#slide[
  #diagram("decoding", height: 225pt)
  #text(18pt)[Use the charset that matches the input. Scanner is still convenient for keyboard input; this chain shows the underlying layers.]
]

== Read Individual Character Values
#slide[
  #text(20pt)[
    ```java
    public static void main(String[] args) throws IOException {
        InputStreamReader reader = new InputStreamReader(System.in);
        System.out.print("Please enter a character: ");
        System.out.println(reader.read());
        System.out.println(reader.read());
        System.out.println(reader.read());
        reader.close();
    }
    ```
    read() returns a UTF-16 code unit as an int, or −1 at EOF.
    What happens after typing A and pressing Enter?
  ]
]

== Enter Does Not Always Mean 13, 10
#slide[
  #diagram("line-endings", height: 265pt)
]

== Buffer Characters, Read Lines
#slide[
  #diagram("buffering", height: 170pt)
  #task[Read two lines with BufferedReader, then print both. Close the outer reader.]
]

== Read Two Lines
#slide[
  #text(19pt)[
    ```java
    public static void main(String[] args) throws IOException {
        InputStreamReader reader = new InputStreamReader(System.in);
        BufferedReader bufferedReader = new BufferedReader(reader);
        System.out.print("First line: ");
        String line1 = bufferedReader.readLine();
        System.out.print("Second line: ");
        String line2 = bufferedReader.readLine();
        System.out.println(line1);
        System.out.println(line2);
        bufferedReader.close();
    }
    ```
  ]
]

= Files
== A File Object Represents a Path
#slide[
  #diagram("file-model", height: 260pt)
]

== Create, Inspect, Delete
#slide[
  #text(18pt)[
    ```java
    public static void main(String[] args) throws IOException {
        File file = new File("Testdatei.txt");
        if (file.createNewFile()) {
            try {
                System.out.println("Read: " + file.canRead());
                System.out.println("Write: " + file.canWrite());
            } finally {
                if (!file.delete()) {
                    throw new IOException("Could not delete " + file);
                }
            }
        } else {
            System.out.println("Already exists; left unchanged.");
        }
    }
    ```
  ]
]

== List a Directory
#slide[
  #text(19pt)[
    ```java
    public static void main(String[] args) throws IOException {
        File directory = new File(".");
        String[] children = directory.list();
        if (children == null) {
            throw new IOException("Cannot list " + directory);
        }
        for (String child : children) {
            System.out.println(child);
        }
    }
    ```
    list() returns null if the path is not a directory or an I/O error occurs.
  ]
]

== Read and Write Raw Bytes
#slide[
  #diagram("file-streams", height: 245pt)
]

== Chain Text File Streams
#slide[
  #diagram("text-files", height: 255pt)
  #text(18pt)[BufferedWriter.newLine() writes only the platform line separator, not a whole line.]
]

== Close Resources on Every Exit
#slide[
  #diagram("resource-flow", height: 150pt)
  #text(20pt)[
    ```java
    try (BufferedReader reader = new BufferedReader(
            new FileReader("Testdatei.txt", StandardCharsets.UTF_8))) {
        System.out.println(reader.readLine());
    }
    ```
    Closing the wrapper closes its underlying reader. FileReader / FileWriter charset constructors require Java 11+.
  ]
]

== Write a Text File
#slide[
  #text(19pt)[
    #task[Write two lines to a file, then read and print them in a second program.]
    ```java
    public static void main(String[] args) throws IOException {
        try (BufferedWriter writer = new BufferedWriter(
                new FileWriter("Testdatei.txt", StandardCharsets.UTF_8))) {
            writer.write("This is the first line.");
            writer.newLine();
            writer.write("And here comes the second line.");
            writer.newLine();
        }
    }
    ```
    This overwrites an existing file. Closing flushes buffered output.
  ]
]

== Read Until EOF, Not Until ready() Is False
#slide[
  #text(20pt)[
    ```java
    public static void main(String[] args) throws IOException {
        try (BufferedReader reader = new BufferedReader(
                new FileReader("Testdatei.txt", StandardCharsets.UTF_8))) {
            String line;
            while ((line = reader.readLine()) != null) {
                System.out.println(line);
            }
        }
    }
    ```
    ready() checks whether reading can proceed without blocking. It is not an EOF test.
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
