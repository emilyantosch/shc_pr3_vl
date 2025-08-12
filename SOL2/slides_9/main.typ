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
    subtitle: [Vorlesung 9 - Eingabe und Ausgabe],
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
  - Ausnahmen werfen und fangen,
  - mit `try` und `catch` Ausnahmen behandeln
  - und eigene Ausnahmetypen definieren.
- Heute geht es weiter mit den *Ausnahmebehandlungen*.

#slide[
  1. Imperative Konzepte
  2. Klassen und Objekte
  3. Klassenbibliothek
  4. Vererbung
  5. Schnittstellen
  6. Graphische Oberflächen
  7. Ausnahmebehandlung
  8. *Eingaben und Ausgaben*
  9. Multithreading (Parallel Computing)
]

== Das Ziel dieses Kapitels

- Sie lesen Zeichen, Zeichenketten sowie Zahlenwerte von der Tastatur ein.
- Sie verketten und verwenden im Java SDK enthaltene Eingabe- und Ausgabeströme
  zur Eingabe und Ausgabe von Bytes, Zeichen und Textzeilen.
- Sie lesen und schreiben Zeichenketten aus bzw. in Textdateien.

= Stream-Konzept & Bildschirmausgabe
== Stream-Konzept

#slide[
  #text(size: 18pt)[
    - Strom (Stream): Transportiert Daten von Sender („Quelle“) zu Empfänger („Senke“)
    - Eingabe (Input): Einlesen von Daten in ein Programm
    - Ausgabe (Output): Daten verlassen ein Programm
    - Klassenbibliothek enthält etwa 50 Klassen für alle wichtigen Ein- und
      Ausgabevarianten

    #figure(image("../assets/img/2024_10_08_eva_stream_rev01.png", height: 60%))

  ]
]

#slide[
  #text(size: 18pt)[
    - Mit dem, was wir schon gelernt haben:
      - Was sind eigentlich die Bestandteile von `System.out.println()`?

    - Nur das macht Sinn:
      - `System`: Klasse (da keine Variable System deklariert)
      - `out`: Klassenvariable von System, referenziert ein Objekt
      - `println()`: Methode des über `out` referenzierten Objektes

    - Ausgabestrom:
      - `System.out` referenziert Objekt der Klasse `PrintStream`
      - Objekt ist mit Bildschirm verbunden
  ]
]

#slide[
  #text(size: 13pt)[
    - Ausgewählte Methoden der Klasse PrintStream:

      #figure(image("../assets/img/slides_9/2024_11_08_sout_prints_rev01.png", height: 40%))

    #question[

      - Was wird ausgegeben?
    ]
    ```java
        public static void main(String[] args) {
        double tempHawaiiCelsius = 15.97;
        double tempHamburgCelsius = 22.71;
        String.format("Hawaii: %.1f °C", tempHawaiiCelsius); System.out.printf("Hamburg:%.1f °C", tempHamburgCelsius);
        }
    ```
  ]
]
#slide[
  #text(size: 18pt)[
    In `System` referenzierte Ströme:

    #figure(image("../assets/img/slides_9/2024_11_08_system_outerrin_rev01.png", height: 40%))
  ]
]

= Tastatureingabe
== Klasse `Scanner`
#slide[
  #text(size: 18pt)[
    - Bietet Methoden zum Einlesen von Texten und einfachen Datentypen (z.B. int)
    - Texteingabe wird analysiert und interpretiert („Parsen“, z.B. in Ganzzahl
      wandeln)

    - Erzeugung und Beendigung:
      - Scanner-Objekt wird im Konstruktor mit Eingabestrom verbunden
      - Die Verbindung sollte über die Scanner-Methode close() beendet werden.

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
      - Hoppla, was passiert hier?
    ]
    ```java
    public class ScannerToken {
        public static void main(String[] args) {
            Scanner scanner = new Scanner(System.in);

            System.out.print("Bitte einen Satz eingeben: ");
            System.out.println(scanner.next());
            scanner.close();
        }
    }
    ```
    - Methode `next()`: Nur erstes Wort anstatt ganzer Satz eingelesen und ausgegeben
    - Es werden Wörter und Zeilen unterschieden.
  ]
]

#slide[
  #text(size: 18pt)[
    - Trennzeichen mehrerer Eingaben:
      - Token: Einzelne Wörter oder Werte (z.B. Ganzzahl)
      - Token in Eingabe durch Trennzeichen getrennt
      - Standardtrennzeichen ist ein Whitespace (d.h. Leerzeichen, Tabulator,
        Zeilenumbruch)

    - Methoden:
      - Trennzeichen über Methode useDelimiter() änderbar
      - Über Methode hasNext() Abfrage, ob noch Token vorhanden sind

    #task[

      - Schreiben Sie ein Programm, das einen Satz über next() einliest.]

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
      - Was geschieht, wenn Sie scanner.hasNext() durch true ersetzen?
      - Wie verhält sich next() sobald alle Wörter eingelesen sind?
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

            System.out.print("Bitte einen byte-Wert eingeben: ");
            System.out.println("Eingegeben: " + scanner.nextByte());
            scanner.close();
        }
    }
    ```
  ]
]
#slide[
  #text(size: 18pt)[
    - Fehler beim Parsen:
      - Eingaben „128“ und „Hamburg“: Ausnahme vom Typ `InputMismatchException`
      - Hat Basisklasse `RuntimeException` (Ausnahmebehandlung nicht zwingend
        erforderlich)
        #task[
          - Das Programm soll nicht durch eine Ausnahme beendet werden:
            - Finden Sie zwei unterschiedliche Möglichkeiten, dies zu vermeiden.
            - Implementieren Sie diese Möglichkeiten.
        ]

    - Ansätze:
      - Fangen der Ausnahme
      - Abfrage über `hasNextByte()`
  ]
]
#slide[
  #text(size: 18pt)[
    - Ausnahme fangen:
    ```java
    public class ScannerByte2 {
        public static void main(String[] args) {
            Scanner scanner = new Scanner(System.in);

            System.out.print("Bitte einen byte-Wert eingeben: ");
            try {
                System.out.println("Eingegeben: " + scanner.nextByte());
            } catch (InputMismatchException e) {
                System.out.println("Eingabe ist kein byte-Wert.");
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
    - Datentyp abfragen:
    ```java
    public class ScannerByte3 {
        public static void main(String[] args) {
            Scanner scanner = new Scanner(System.in);

            System.out.print("Bitte einen byte-Wert eingeben: ");
            if (scanner.hasNextByte()) {
                System.out.println("Eingegeben: " + scanner.nextByte());
            } else {
                System.out.println("Kein byte-Wert: " + scanner.next());
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
      - Einlesen der Komponenten eines Vektors (Datentyp `int`)
      - Komponenten einlesen bis anderes Token (z. B. ein Buchstabe) eingegeben wurde
      - Ausgabe des Vektors sowie des Betrages
    ]

    #example[
      Integer-Komponenten (mit anderem Zeichen beenden): 7 4 0 15 Ende \
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
            System.out.print("Integer-Komponenten (mit anderem Zeichen beenden): ");
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

= Byte Streams & Character Streams
== Byte Streams & Character Streams

#slide[
  #text(size: 15pt)[
    - Was war nochmal die Besonderheit von Zeichen in Java?
      - Alle Zeichen als 2 Byte (Unicode) codiert
      - Unterscheide: Ströme, die Elemente aus 1 Byte oder 2 Byte („Zeichen“)
        transportieren

    - Byteströme (byteorientierte Ströme):
      - Transportierten einzelne Bytes
      - Klassen InputStream und OutputStream sowie hiervon abgeleitete Klassen

    - Zeichenströme (characterorientierte Ströme):
      - Transportierten Zeichen aus jeweils 2 Byte
      - Abstrakte Klassen Reader und Writer sowie hiervon abgeleitete Klassen

        #figure(image("../assets/img/slides_9/2024_11_08_object_streams_rev01.png", height: 40%))
  ]
]

#slide[
  #text(size: 18pt)[
    - Tastatur liefert Strom aus einzelnen Bytes (z. B. `System.in` vom Datentyp
      `InputStream`)
      - Java-Zeichen bestehen aus 2 Bytes
      - Bytestrom mit Zeichenstrom verbinden

    - Anmerkungen:
      - Ziel im Folgenden: Veranschaulichung der Verkettung von Strömen
      - Ja, Tastatureingaben (Code $≤ 255$) müssten Sie nicht mit einem Zeichenstrom
        verketten.
      - Ja, verwenden Sie für Tastatureingaben ruhig Scanner.
    #figure(
      image(
        "../assets/img/slides_9/2024_11_08_tastatur_stream_programm_rev01.png",
        height: 40%,
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

            System.out.print("Bitte ein Zeichen eingeben: ");
            System.out.println(reader.read());
            System.out.println(reader.read());
            System.out.println(reader.read());
            reader.close();
        }
    }
    ```
    #question[
      - Warum wird `read()` dreimal aufgerufen?
      - Warum sind die zweite und dritte Ausgabe immer 13 und 10?
    ]
  ]
]

#slide[
  #text(size: 18pt)[
    - `BufferedReader` liest einen Zeichenstrom und puffert die Zeichen
    - Bietet z.B. Methode `readLine()` zum Auslesen einer Zeile
    - Analog gibt Klasse `BufferedWriter` ganze Zeile über `newLine()` aus

      #figure(
        image(
          "../assets/img/slides_9/2024_11_08_tastatur_stream_buffered_rev01.png",
          height: 30%,
        ),
      )

      #task[
        - Ändern Sie das vorherige Beispiel folgendermaßen ab:
          - Einlesen zweier Zeilen über
          - BufferedReader Anschließend beide Zeilen ausgeben
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

            System.out.print("Bitte erste Zeile eingeben:  ");
            String line1 = bufferedReader.readLine();
            System.out.print("Bitte zweite Zeile eingeben: ");
            String line2 = bufferedReader.readLine();

            System.out.println(line1);
            System.out.println(line2);
            reader.close();
        }
    }
    ```
  ]
]

= Dateien
== Dateien und Verzeichnissen

#slide[
  #text(size: 14pt)[
    - Klasse `File` repräsentiert Datei oder Verzeichnis
      - Objekte beinhalten Informationen über Datei, nicht deren Inhalt
      - Intellij verwendet das Projekt-Verzeichnis als Stammverzeichnis zum
        Lesen/Schreiben.
    ```java
    public class CreateFile {
        public static void main(String[] args) throws IOException {
            File file = new File("Testdatei.txt");
            boolean isExists = file.exists();

            if (!isExists) {
                System.out.println("Datei erzeugen");
                isExists = file.createNewFile();
            }

            if (isExists && file.isFile()) {
                System.out.println("Lesen: " + file.canRead());
                System.out.println("Schreiben: " + file.canWrite());
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
    - Byteströme:
      - Dateien über Klassen FileInputStream lesen und über FileOutputStream schreiben

    - Zeichenströme (z.B. Textdateien):
      - Dateien über FileReader lesen und über FileWriter schreiben
      - Gepufferte Zeichenströme über BufferedReader und BufferedWriter

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
    - Lassen Sie uns das anwenden:
      - Erstellen Sie ein Programm, das eine Textdatei schreibt.
      - Erstellen Sie ein weiteres Programm, das den Inhalt der Textdatei einliest und
        ausgibt.

    ```java
    public class WriteFile {
        public static void main(String[] args) throws IOException {
            File file = new File("Testdatei.txt");
            FileWriter writer = new FileWriter(file);
            BufferedWriter bufferedWriter = new BufferedWriter(writer);

            bufferedWriter.write("Dies ist die erste Zeile.");
            bufferedWriter.newLine();
            bufferedWriter.write("Und hier kommt die zweite Zeile.");
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
