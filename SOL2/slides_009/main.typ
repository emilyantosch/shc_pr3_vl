#import "@preview/touying:0.5.2": *
#import themes.university: *

#import "@preview/fletcher:0.5.1" as flechter: diagram, edge, node
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
    subtitle: [Lecture 9 - Input and Output],
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

- In the last lecture, we dealt with handling exceptions
- You can now
  - throw and catch exceptions,
  - handle exceptions with `try` and `catch`
  - and define your own exception types.
- Today we continue with *Input and Output*.

#slide[
  1. Imperative Concepts
  2. Classes and Objects
  3. Class Libraries
  4. Inheritance
  5. Interfaces
  6. Graphical User Interfaces
  7. Exception Handling
  8. *Input and Output*
  9. Multithreading (Parallel Computing)
]

== The goal of this chapter

- You read characters, strings and numeric values from the keyboard.
- You chain and use input and output streams contained in the Java SDK
  for input and output of bytes, characters and text lines.
- You read and write strings from and to text files.

= Stream concept & Screen output
== Stream concept

#slide[
  #text(size: 18pt)[
    - Stream: Transports data from sender ("source") to receiver ("sink")
    - Input: Reading data into a program
    - Output: Data leaves a program
    - Class library contains about 50 classes for all important input and
      output variants

    #figure(image("../assets/img/slides_9/20250813_data_stream_rev01.png", height: 60%))

  ]
]

#slide[
  #text(size: 18pt)[
    - With what we have already learned:
      - What are the components of `System.out.println()`?

    - Only this makes sense:
      - `System`: Class (since no variable System is declared)
      - `out`: Class variable of System, references an object
      - `println()`: Method of the object referenced via `out`

    - Output stream:
      - `System.out` references object of class `PrintStream`
      - Object is connected to the screen
  ]
]

#slide[
  #text(size: 24pt)[
    - Selected methods of the PrintStream class:
    #text(size: 18pt)[
      #align(center + horizon)[
        #figure(
          table(
            columns: (auto, auto),
            inset: 10pt,
            align: left + horizon,
            fill: (_, y) => if calc.odd(y) { green.lighten(90%) },
            table.header([*Methods*], [*Meaning*]),
            [`println(String message)`], [Output with line break(`print line`)],
            [`print(String message)`], [Output without line break],
            [`printf(String format, Object... arg)`], [Formatted Output (see `String.format()`)],
            [`format(String format, Object... arg)`], [Formatted Output (see `String.format()`)],
          ),
          caption: [Formats and Flags],
        )
      ]
    ]
  ]
]
#slide[
  #question[
    - What is output?
  ]
  ```java
      public static void main(String[] args) {
      double tempHawaiiCelsius = 15.97;
      double tempHamburgCelsius = 22.71;
      String.format("Hawaii: %.1f °C", tempHawaiiCelsius); System.out.printf("Hamburg:%.1f °C", tempHamburgCelsius);
      }
  ```
]

#slide[
  #text(size: 24pt)[
    Streams referenced in `System`:

    #text(size: 22pt)[
      #align(center + horizon)[
        #figure(
          table(
            columns: (auto, auto, auto),
            inset: 15pt,
            align: left + horizon,
            fill: (_, y) => if calc.odd(y) { green.lighten(90%) },
            table.header([*Reference*], [*Data Type*], [*Meaning*]),
            [`System.out`], [`PrintStream`], [Output on screen],
            [`System.err`], [`PrintStream`], [Error output on screen],
            [`System.in`], [`InputStream`], [Input from keyboard],
          ),
          caption: [Formats and Flags],
        )
      ]
    ]
  ]
]

= Keyboard input
== Class `Scanner`
#slide[
  #text(size: 18pt)[
    - Provides methods for reading texts and simple data types (e.g. int)
    - Text input is analyzed and interpreted ("parsing", e.g. converting to integer)

    - Creation and termination:
      - Scanner object is connected to input stream in constructor
      - The connection should be terminated via the Scanner method close().

        #example[
          ```java
          public class ScannerLine {
              public static void main(String[] args) {
                  Scanner scanner = new Scanner(System.in);

                  System.out.print("Bitte einen Satz eingeben: ");
                  System.out.println(scanner.nextLine());
                  scanner.close();
              }
          }
          ```
        ]
  ]
]
#slide[
  #text(size: 18pt)[
    #question[
      - Oops, what happens here?
    ]
    ```java
    public class ScannerToken {
        public static void main(String[] args) {
            Scanner scanner = new Scanner(System.in);

            System.out.print("Please enter a sentence: ");
            System.out.println(scanner.next());
            scanner.close();
        }
    }
    ```
    - Method `next()`: Only first word instead of entire sentence is read and output
    - Words and lines are distinguished.
  ]
]

#slide[
  #text(size: 18pt)[
    - Separators of multiple inputs:
      - Token: Individual words or values (e.g. integer)
      - Tokens in input separated by separators
      - Default separator is a whitespace (i.e. space, tab,
        line break)

    - Methods:
      - Separator changeable via method useDelimiter()
      - Via method hasNext() query whether tokens are still available

    #task[

      - Write a program that reads a sentence via next().]

  ]
]
#slide[
  #text(size: 18pt)[
    ```java
    public class ScannerNext {
        public static void main(String[] args) {
            Scanner scanner = new Scanner(System.in);

            System.out.print("Bitte einen Satz eingeben: ");
            while (scanner.hasNext()) {
                System.out.println(scanner.next());
            }
            scanner.close();
        }
    }
    ```
    #question[
      - What happens if you replace scanner.hasNext() with true?
      - How does next() behave once all words have been read?
    ]
  ]
]
#slide[
  #text(size: 17pt)[
    - Spezielle Methoden für einfache Datentypen:
      - Einlesen: `nextBoolean()`, `nextInt()`, `nextDouble()`, …
      - Abfrage: `hasNextBoolean()`, `hasNextInt()`, `hasNextDouble()`, …
        #question[
          - Welche Ausgaben werden für die Eingaben „127“, „128“ und „Hamburg“ erzeugt?
        ]
    ```java
    public class ScannerByte1 {
        public static void main(String[] args) {
            Scanner scanner = new Scanner(System.in);

            System.out.print("Please enter a byte value: ");
            System.out.println("Entered: " + scanner.nextByte());
            scanner.close();
        }
    }
    ```
  ]
]
#slide[
  #text(size: 18pt)[
    - Parsing errors:
      - Inputs "128" and "Hamburg": Exception of type `InputMismatchException`
      - Has base class `RuntimeException` (exception handling not mandatory)
        #task[
          - The program should not be terminated by an exception:
            - Find two different ways to avoid this.
            - Implement these approaches.
        ]

    - Approaches:
      - Catch the exception
      - Query via `hasNextByte()`
  ]
]
#slide[
  #text(size: 18pt)[
    - Catch exception:
    ```java
    public class ScannerByte2 {
        public static void main(String[] args) {
            Scanner scanner = new Scanner(System.in);

            System.out.print("Please enter a byte value: ");
            try {
                System.out.println("Entered: " + scanner.nextByte());
            } catch (InputMismatchException e) {
                System.out.println("Input is not a byte value.");
            } finally {
                scanner.close();
            }
        }
    }
    ```
  ]
]

#slide[
  #text(size: 18pt)[
    - Query data type:
    ```java
    public class ScannerByte3 {
        public static void main(String[] args) {
            Scanner scanner = new Scanner(System.in);

            System.out.print("Please enter a byte value: ");
            if (scanner.hasNextByte()) {
                System.out.println("Entered: " + scanner.nextByte());
            } else {
                System.out.println("Not a byte value: " + scanner.next());
            }
            scanner.close();
        }
    }
    ```
  ]
]

#slide[
  #text(size: 18pt)[
    #task[
      - Read the components of a vector (data type `int`)
      - Read components until another token (e.g. a letter) is entered
      - Output the vector as well as the magnitude
    ]

    #example[
      Integer components (terminate with different character): 7 4 0 15 End \
      $a = [7, 4, 0, 15]^T$\
      $||a|| = 17,03$

    ]
  ]
]

#slide[
  #text(size: 13pt)[
    ```java
    public class ScannerVektor {
        public static void main(String[] args) {
            Scanner scanner = new Scanner(System.in);
            ArrayList<Integer> vector = new ArrayList<Integer>();
            System.out.print("Integer components (terminate with different character): ");
            while (scanner.hasNextInt())
                vector.add(scanner.nextInt());
            scanner.close();
            if (vector.size() > 0) {
                System.out.print("a = [" + vector.get(0));
                long sumOfSquares = vector.get(0) * vector.get(0);

                for (int i = 1; i < vector.size(); i++) {
                    System.out.print(", " + vector.get(i));
                    sumOfSquares += vector.get(i) * vector.get(i);
                }
                System.out.println("]^T");
                System.out.printf("||a|| = %.2f\n", Math.sqrt(sumOfSquares));
            }
        }
    }
    ```
  ]
]

= Byte & Character Streams
== Byte & Character Streams

#slide[
  #text(size: 15pt)[
    - What was the special feature of characters in Java again?
      - All characters encoded as 2 bytes (Unicode)
      - Distinguish: Streams that transport elements of 1 byte or 2 bytes ("characters")

    - Byte streams (byte-oriented streams):
      - Transport individual bytes
      - Classes InputStream and OutputStream as well as classes derived from them

    - Character streams (character-oriented streams):
      - Transport characters of 2 bytes each
      - Abstract classes Reader and Writer as well as classes derived from them

        #figure(image("../assets/img/slides_9/2024_11_08_object_streams_rev01.png", height: 40%))
  ]
]

#slide[
  #text(size: 18pt)[
    - Keyboard delivers stream of individual bytes (e.g. `System.in` of data type
      `InputStream`)
      - Java characters consist of 2 bytes
      - Connect byte stream with character stream

    - Notes:
      - Goal in the following: Illustration of stream chaining
      - Yes, keyboard inputs (code $\leq 255$) you wouldn't need to chain with a character stream.
      - Yes, feel free to use Scanner for keyboard inputs.
    #figure(
      image(
        "../assets/img/slides_9/20250813_keyboard_to_program_rev01.png",
        height: 33%,
      ),
    )

  ]
]

#slide[
  #text(size: 18pt)[
    ```java
    public class KeyboardReader1 {
        public static void main(String[] args) throws IOException {
            InputStreamReader reader = new InputStreamReader(System.in);

            System.out.print("Please enter a character: ");
            System.out.println(reader.read());
            System.out.println(reader.read());
            System.out.println(reader.read());
            reader.close();
        }
    }
    ```
    #question[
      - Why is `read()` called three times?
      - Why are the second and third outputs always 13 and 10?
    ]
  ]
]

#slide[
  #text(size: 18pt)[
    - `BufferedReader` reads a character stream and buffers the characters
    - Provides e.g. method `readLine()` for reading out a line
    - Analogously, class `BufferedWriter` outputs entire line via `newLine()`

      #figure(
        image(
          "../assets/img/slides_9/20250813_keyboard_to_program_buffered_reader_rev01.png",
          height: 25%,
        ),
      )

      #task[
        - Modify the previous example as follows:
          - Read two lines via
          - BufferedReader Then output both lines
      ]
  ]
]

#slide[
  #text(size: 18pt)[
    ```java
    public class KeyboardReader2 {
        public static void main(String[] args) throws IOException {
            InputStreamReader reader = new InputStreamReader(System.in);
            BufferedReader bufferedReader = new BufferedReader(reader);

            System.out.print("Please enter first line:  ");
            String line1 = bufferedReader.readLine();
            System.out.print("Please enter second line: ");
            String line2 = bufferedReader.readLine();

            System.out.println(line1);
            System.out.println(line2);
            reader.close();
        }
    }
    ```
  ]
]

= Files
== Files and Directories

#slide[
  #text(size: 14pt)[
    - Class `File` represents file or directory
      - Objects contain information about file, not its content
      - IntelliJ uses the project directory as root directory for
        reading/writing.
    ```java
    public class CreateFile {
        public static void main(String[] args) throws IOException {
            File file = new File("Testdatei.txt");
            boolean isExists = file.exists();

            if (!isExists) {
                System.out.println("Create file");
                isExists = file.createNewFile();
            }

            if (isExists && file.isFile()) {
                System.out.println("Read: " + file.canRead());
                System.out.println("Write: " + file.canWrite());
                file.delete();
            }
        }
    }
    ```
  ]
]

#slide[
  #text(size: 18pt)[
    ```java
    public class ListDirectory {
        public static void main(String[] args) {
            File directory = new File(".");

            if (directory.isDirectory()) {
                String[] children = directory.list();
                for (String child : children) {
                    System.out.println(child);
                }
            }
        }
    }
    ```
  ]
]
#slide[
  #text(size: 18pt)[
    - Byte streams:
      - Read files via FileInputStream classes and write via FileOutputStream

    - Character streams (e.g. text files):
      - Read files via FileReader and write via FileWriter
      - Buffered character streams via BufferedReader and BufferedWriter

        #figure(
          image(
            "../assets/img/slides_9/2024_11_08_programm_datei_reader_writer_rev01.png",
            height: 50%,
          ),
        )
  ]
]

#slide[
  #text(size: 16pt)[
    - Let's apply this:
      - Create a program that writes a text file.
      - Create another program that reads the content of the text file and
        outputs it.

    ```java
    public class WriteFile {
        public static void main(String[] args) throws IOException {
            File file = new File("Testdatei.txt");
            FileWriter writer = new FileWriter(file);
            BufferedWriter bufferedWriter = new BufferedWriter(writer);

            bufferedWriter.write("This is the first line.");
            bufferedWriter.newLine();
            bufferedWriter.write("And here comes the second line.");
            bufferedWriter.newLine();
            bufferedWriter.close();
        }
    }
    ```
  ]
]

#slide[
  #text(size: 18pt)[
    ```java
    public class ReadFile {
        public static void main(String[] args) throws IOException {
            File file = new File("Testdatei.txt");
            FileReader reader = new FileReader(file);
            BufferedReader bufferedReader = new BufferedReader(reader);

            while (bufferedReader.ready()) {
                System.out.println(bufferedReader.readLine());
            }
            bufferedReader.close();
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
