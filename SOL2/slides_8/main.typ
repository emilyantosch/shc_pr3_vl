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
    title: [Objektorientierte Programmierung in Java],
    subtitle: [Vorlesung 8 - Ausnahmebehandlung],
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

= Einleitung

== Wo sind wir gerade?

- In der letzten Vorlesung haben wir uns mit dem Erstellen von graphischen
  Oberflächen beschäftigt
- Sie können nun
  - Fenster erzeugen, in dem andere Elemente leben können,
  - Elemente mittels Layouts und Panels arrangieren
  - und Grafiken direkt in Java erzeugen.
- Heute geht es weiter mit den *Ausnahmebehandlungen*.

#slide[
  1. Imperative Konzepte
  2. Klassen und Objekte
  3. Klassenbibliothek
  4. Vererbung
  5. Schnittstellen
  6. Graphische Oberflächen
  7. *Ausnahmebehandlung*
  8. Eingaben und Ausgaben
  9. Multithreading (Parallel Computing)
]

== Das Ziel dieses Kapitels
- Sie behandeln bei Programmausführung auftretende Ausnahmen und Fehler, um in
  aufgetretenen Ausnahmesituationen einen geordneten Programmfluss herzustellen.
- Sie definieren eigene, an die Bedürfnisse Ihrer konkreten Anwendung angepasste,
  Ausnahmeklassen.

= Exception Handling
== Introductory Example

#slide[
  #text(size: 13pt)[
    #question[
      - Was wird von folgendem Programm ausgegeben?
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
      - Und was wird für a = 7 und b = 0 ausgegeben?
    ]
  ]
]

#slide[
  #text(size: 18pt)[
    #question[
      - Was kann in einem Programm alles „schief gehen“?
      - Wann muss der normale Programmfluss unterbrochen werden?
      - Wann muss ein Programm beendet werden, wann kann es fortgeführt werden?
    ]

    #example[
      - Division durch Null
      - Aufruf `a.method()`, obwohl Variable `a` den Wert null hat
      - Negativer oder zu hoher Index für Arrays
      - Wandeln der Zeichenkette „Dies ist Text“ in eine Ganzzahl vom Typ `int`
      - Datei nicht gefunden
      - Kein Speicher mehr verfügbar
    ]
  ]
]

#slide[
  #text(size: 18pt)[

    - Ausnahmen und Fehler durch Objekte spezieller Klassen dargestellt
    - Basisklasse aller Ausnahmeklassen ist Throwable

    #figure(image("../assets/img/2024_11_04_throwable_rev01.png"))

    - Man unterscheide:
      - Exception (Ausnahme): Behandelbar, Programm kann fortgeführt werden
      - Error bzw. fatal error (Fehler): Nicht behandelbar, Programm beenden

  ]
]

#slide[
  #text(size: 15pt)[
    #memo[
      - Ausnahme wird auch als Oberbegriff für Ausnahmen und Fehler verwendet.
      - Ausnahmebehandlung wird auch als Exception handling bezeichnet.

    ]

    - Einige Klassen für Ausnahmen:
      - Division durch Null (ArithmeticException)
      - Zugriff auf Methode oder Attribut über null-Referenz (NullPointerException)
      - Unzulässiger Feldindex (ArrayIndexOutOfBoundsException)
      - Unzulässige Zeichen beim Lesen einer Zahl (NumberFormatException)
      - Datei nicht gefunden (FileNotFoundException)

    ```java
    int[] array = {1, 2, 3, 4};
    System.out.println(array[4]);

    String message;
    System.out.println(message.length());

    int code = Integer.parseInt("12a4");
    ```

  ]
]

== Ablauf der Ausnahmebehandlung

#slide[
  #text(size: 18pt)[
    1. Ausnahme werfen:
      - Programmfluss wird unmittelbar unterbrochen
      - Objekt erzeugt, das Ausnahme repräsentiert
    2. Ausnahme fangen:
      - Programmierer kann Ausnahme abfangen und behandeln

    #figure(image("../assets/img/2024_11_04_programmfluss_throwable_rev01.png", height: 50%))

  ]
]

#slide[
  #text(size: 18pt)[
    - Falls keine Ausnahmebehandlung programmiert: Programm wird beendet

      #figure(image("../assets/img/2024_11_04_programmfluss_noexceptionhandling_rev01.png"))

  ]
]

= Ausnahme werfen
== Ausnahme werfen

#slide[
  #text(size: 18pt)[
    - Im Fehlerfall werden Ausnahmen automatisch erzeugt (z.B. Division durch Null).
    - Ausnahmen lassen sich aber auch explizit werfen.

    ```java
    throw ExceptionObject;
    ```

    - Konstruktor kann String (z.B. als Fehlerbeschreibung) übergeben werden

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
    - Zur Veranschaulichung:
      - Werfen Sie eine Ausnahme, bevor versucht wird, durch Null zu teilen.
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
    - Beispiellösung:

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
    - Ausgabe im Fehlerfall:
      - Ausnahmetyp (z.B. ArithmeticException)
      - Fehlermeldung (z.B. „Division by zero“)
      - Stacktrace (d.h. Kette der aufgerufenen Methoden)

    #example[
      #text(fill: red)[
        ```
        Exception in thread "main" java.lang.ArithmeticException: Division by zero at
          kapitel8_exceptions.ThrowException.printRatio(E02_ThrowException.java:20) at
          kapitel8_exceptions.ThrowException.main(E02_ThrowException.java:14)
        ```

      ]

    ]

    - Methode `main()` hat in Zeile 14 `printRatio()` aufgerufen
    - Methode `printRatio()` hat in Zeile 20 die Ausnahme geworfen
  ]
]

= Ausnahmen fangen
== Exception Handling


#slide[
  #text(size: 18pt)[
    - Ausnahmen lassen sich fangen und behandeln:
    ```java
     try {
         // Aweisungen ...
     } catch (ExceptionTyp e) {
         // Aweisungen ...
     }
    ```

    - Try-Block enthält Code, der Ausnahme werfen kann
    - Falls Ausnahme im try-Block geworfen wird:
      1. Try-Block unmittelbar beendet
      2. Catch-Block ausgeführt, sofern Ausnahmetyp (ExceptionType) passt
      3. Programm läuft nach catch-Block weiter
    - Ausnahmetyp des catch-Blocks passt nicht: Ausnahme wird nicht gefangen!
    - Keine Ausnahme geworfen: Catch-Block wird übersprungen
  ]
]

#slide[
  #text(size: 18pt)[
    - Vermeiden Sie den „Absturz“:
      - Fangen Sie die geworfene Ausnahme!
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
    - Bespiellösung:
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
    - Ausgewählte Methoden für Ausnahmeobjekte:
      - `getMessage()`
      - `printStackTrace()`
      - `toString()`
  ]
]

#slide[
  #text(size: 13pt)[
    #question[
      Und nun?
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
      Und nun?
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
    - Können mehrere Ausnahmearten auftreten, werden mehrere catch-Blöcke benötigt.
    - Ausnahmetypen der catch-Blöcke müssen sich unterscheiden
    - Es wird der erste passende catch-Block ausgeführt.
    ```java
     try {
         // ...
     } catch (ExceptionTyp1 e) {
         // ...
     } catch (ExceptionTyp2 e) {
         // ...
     } catch (ExceptionTyp3 e) {
         // ...
     }
    ```
  ]
]

#slide[
  #text(size: 14pt)[
    #question[
      - Folgender Quelltext enthält zwei Fehlerquellen. Welche?
      - Welche Ausgabe erzeugt das Programm?
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
      - Ändern Sie den vorherigen Quelltext derart, dass beide Fehlerquellen gefangen werden.
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
      - Hoppla, unten läuft etwas im catch-Block schief!
      - Wird die erneute Ausnahme behandelt? Was wird ausgegeben?
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
    - Ein catch-Block bezieht sich nur auf den zugehörigen try-Block.
    - Wirft catch-Block Ausnahme, wird diese nicht durch nachfolgende Blöcke gefangen
    #question[
      - Wie können wir die im catch-Block erzeugte Ausnahme fangen?
    ]
  ]
]


#slide[
  #text(size: 17pt)[
    - Quelltext, der Ausnahme erzeugt, in geschachteltem try-Block
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
    - Mitunter muss bestimmter Code auf jeden Fall ausgeführt werden.
    - Beispiel: Schließen geöffneter Dateien oder Datenströme

    - Optionaler finally-Block:
      - Steht immer als letztes (d.h. nach try- und catch-Blöcken)
      - Code wird am Ende des Konstruktes ausgeführt … wirklich immer … ganz ehrlich!
    ```java
     try {
         // ...
     } catch (ExceptionTyp1 e) {
         // ...
     } catch (ExceptionTyp2 e) {
         // ...
     } finally {
         // Wird garantiert ausgeführt
     }
    ```
  ]
]

#slide[
  #text(size: 13pt)[
    #question[
      - Was wird ausgegeben?
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
      - Was wird ausgegeben?
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
    - Regeln für Blöcke:
      - Genau einen try-Block als ersten Block
      - Keinen oder beliebig viele catch-Blöcke nach dem try-Block
      - Keinen oder einen finally-Block als letzten Block
      - Ein try-Block muss mindestens einen catch- oder finally-Block haben.

    - Folgender Aufbau ist zulässig:
    ```java
    try {
         // ...
    } finally {
         // ...
    }
    ```
  ]
]

= Eigene Ausnahmen definieren
== Eigene Ausnahmen

#slide[
  #text(size: 15pt)[
    - Betrachten wir folgendes Programm:
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
      - Methode squareRoot() soll für negative Parameter eine Ausnahme werfen
      - Wie könnten wir einen eigenen Typ (z.B. NegativeParameterException) definieren?
    ]
  ]
]

#slide[
  #text(size: 15pt)[
    - Eigenen Ausnahmetyp durch Ableiten einer bestehenden Klasse
    - Erster Ansatz: Ableiten der Klasse Exception

    #figure(image("../assets/img/2024_11_05_vererbung_throwable_rev01.png", height: 60%))

  ]
]

#slide[
  #text(size: 15pt)[
    - Ansatz erzeugt Fehlermeldung („Unbehandelte Ausnahme“)
    - Wieso denn das jetzt?!

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
    - Hintergrund:
      - Ausnahmen müssen gefangen werden ODER
      - Methode muss über throws deklarieren, dass sie einen Ausnahmetyp werfen kann.

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
    - Dies gilt für alle Ausnahmetypen (d.h. Throwable und davon abgeleitet) außer für:
      - Klasse RuntimeException
      - Von RuntimeException (direkt oder indirekt) abgeleitete Klassen
        #figure(image("../assets/img/2024_11_05_vererbung_runtimeexception_rev01.png"))
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

    - Beschreibung („message“) an Konstruktor der Basisklasse übergeben
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
