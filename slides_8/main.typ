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
    fill: fill, pin-dx: 0em, pin-dy: if pos == bottom { 0em } else { -0.6em }, body-dx: 0pt, body-dy: if pos == bottom { -1.7em } else { -1.6em }, offset-dx: 0em, offset-dy: if pos == bottom { 1.2em + height } else { -0.6em - height }, point-pin, rect(inset: 0.5em, stroke: (bottom: 0.12em + fill), {
      set text(fill: fill)
      body
    }),
  )
}
#show: university-theme.with(
  aspect-ratio: "16-9", config-info(
    title: [Objektorientierte Programmierung in Java], subtitle: [Vorlesung 6 - Abstrakte Elemente], author: [Emily Lucia Antosch], date: datetime.today().display("[day].[month].[year]"), institution: [HAW Hamburg],
  ),
)

#codly(
  languages: (
    java: (
      name: text(font: "JetBrainsMono NFM", " Java", weight: "bold"), icon: text(font: "JetBrainsMono NFM", "\u{e738}", weight: "bold"), color: rgb("#CE412B"),
    ), c: (
      name: text(font: "JetBrainsMono NFM", " C", weight: "bold"), icon: text(font: "JetBrainsMono NFM", "\u{e61e}", weight: "bold"), color: rgb("#5612EC"),
    ),
  ),
)

#title-slide(authors: ([Emily Lucia Antosch]))

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

= Ausnahmebehandlung
== Einführendes Beispiel

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
#text(
  size: 18pt,
)[
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
  #text(
    size: 18pt,
  )[

    - Ausnahmen und Fehler durch Objekte spezieller Klassen dargestellt
    - Basisklasse aller Ausnahmeklassen ist Throwable

    #figure(image("../assets/img/2024_11_04_throwable_rev01.png"))

    - Man unterscheide:
      - Exception (Ausnahme): Behandelbar, Programm kann fortgeführt werden
      - Error bzw. fatal error (Fehler): Nicht behandelbar, Programm beenden

  ]
]

#slide[
#text(
  size: 18pt,
)[
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
  #text(
    size: 18pt,
  )[
    1. Ausnahme werfen:
      - Programmfluss wird unmittelbar unterbrochen
      - Objekt erzeugt, das Ausnahme repräsentiert
    2. Ausnahme fangen:
      - Programmierer kann Ausnahme abfangen und behandeln

    #figure(image("../assets/img/2024_11_04_programmfluss_throwable_rev01.png"))

  ]
]

#slide[
  #text(
    size: 18pt,
  )[
    - Falls keine Ausnahmebehandlung programmiert: Programm wird beendet

      #figure(
        image("../assets/img/2024_11_04_programmfluss_noexceptionhandling_rev01.png"),
      )

  ]
]

= Ausnahme werfen
== Ausnahme werfen

#slide[
#text(
  size: 18pt,
)[
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
#text(size: 18pt)[
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
#text(
  size: 18pt,
)[
- Ausgabe im Fehlerfall:
  - Ausnahmetyp (z.B. ArithmeticException)
  - Fehlermeldung (z.B. „Division by zero“)
  - Stacktrace (d.h. Kette der aufgerufenen Methoden)

#example[
#text(
  fill: red,
)[
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

= License Notice

== Attribution

- This work is shared under the CC BY-NC-SA 4.0 License and the respective Public
  License
- link("https://creativecommons.org/licenses/by-nc-sa/4.0/")
- This work is based off of the work Prof. Dr. Marc Hensel.
- Some of the images and texts, as well as the layout were changed.
- The base material was supplied in private, therefore the link to the source
  cannot be shared with the audience.
