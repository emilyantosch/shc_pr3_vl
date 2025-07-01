#import "@preview/touying:0.5.2": *
#import themes.university: *

#import "@preview/fletcher:0.5.1" as flechter: diagram, node, edge
#import "@preview/wrap-it:0.1.0": wrap-content

#import "@preview/gentle-clues:1.0.0": *
#import "@preview/pinit:0.2.0": *
#import "@preview/codly:1.0.0": *
#show: codly-init.with()

#import "@preview/numbly:0.1.0": numbly

#set text(lang: "en", font: "Roboto")
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
    subtitle: [Lecture 5 - Inheritance],
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

== Where Are We Currently?

- In der letzten Vorlesung ging es um Klassenbibliotheken
- Sie können nun
  - einfache Klassenbibliotheken verwenden, um Strings oder Arrays zu manipulieren
  - aus einem Array alle Items über eine `foreach`-Schleife auslesen
  - mithilfe von Wrapperklassen Typumwandlungen durchführen,
  - einfache mathematische Rechnung mithilfe der `Math`-Klasse ausführen.
- Heute geht es weiter mit der *Vererbung*.

#slide[
  1. Imperative Konzepte
  2. Klassen und Objekte
  3. Klassenbibliothek
  4. *Vererbung*
  5. Schnittstellen
  6. Graphische Oberflächen
  7. Ausnahmebehandlung
  8. Eingaben und Ausgaben
  9. Multithreading (Parallel Computing)
]

== The Goal of This Chapter

- Sie erzeugen neue Datentypen, indem Sie bestehende Klassen um zusätzliche
  Eigenschaften erweitern, um beispielsweise duplizierten Quelltext zu vermeiden.
- Sie verwenden Sichtbarkeits-Modifizierer, um die Attribute einer Klasse vor
  direktem Zugriff von außen zu schützen.

= Inheritance
== Inheritance
#slide[
  - Klasse übernimmt („erbt“) Variablen und Methoden einer vorhandener Klassen
  - Ziel: Wiederverwendung existierender Klassen

  - Beispiel und UML-Notation:
    - Klasse A ist vorhanden
    - Klasse B wird erstellt und erbt von A

  - Begriffe:
    - Klasse A: Superklasse (Basisklasse, Oberklasse)
    - Klasse B: Subklasse (abgeleitete Klasse, Unterklasse)
    - Vererbung: Ableitung, engl.: inheritance

    #figure(
      image("../assets/img/2024_10_20_vererbung_AB_rev01.png"),
      caption: [Einfaches Beispiel für Vererbung],
    )
]

#slide[
  - Ableitung der Basisklasse mittels `extends`:
  ```java
  class Klassenname extends Basisklasse {
      Attribute
      Methoden
      }
  ```
  #example[
    ```java
    class A {
          // ...
      }

      class B extends A {
          // ...
      }
    ```
  ]
]

#slide[
  #text(size: 20pt)[
    #task[
      - Erstellen Sie folgende Klassen:
        - Person: Objekte beinhalten den Namen
        - Pilot: Objekte beinhalten den Namen und die bisherigen Flugstunden
        - Ausführbare Klasse, die ein Objekt Pilot erzeugt und den Namen ausgibt
    ]
  ]
  #figure(
    image(
      "../assets/img/2024_10_20_vererbung_person_pilot_rev01.png",
      height: 40%,
    ),
    caption: [Pilot erbt von Person],
  )
]

#slide[
  #text(size: 16pt)[
    ```java
    public class Person {
          String name;
      }

      public class Pilot extends Person {
          int flightHours;
      }

      public class PilotDemo {
          public static void main(String[] args) {
              Pilot pilot = new Pilot();

              pilot.name = "Lukas Luft";
              pilot.flightHours = 1482;
              System.out.println("Name: " + pilot.name);
          }
      }
    ```
  ]
]

#slide[
  #figure(
    grid(
      columns: 2,
      gutter: 1em,
      image("../assets/img/2024_10_20_vererbung_uml_person_pilot_rev01.png"),
      image("../assets/img/2024_10_20_vererbung_pilot_objekt_rev01.png"),
    ),
    caption: [Vererbung von Attributen],
  )
]

#slide[
  #let body = [
    - Klasse B kann neue Variablen und Methoden hinzufügen

    - Begriffe:
      - Spezialisierung: Klasse B ist spezieller als Klasse A
      - Generalisierung: Klasse A ist allgemeiner als Klasse B

    - Beispiel:
      - Klasse Pilot hat von Person geerbt und flightHours hinzugefügt
      - Ein Pilot ist eine Person, d.h. Person ist allgemeiner als Pilot.
  ]
  #let fig = figure(
    grid(
      columns: 1,
      rows: 2,
      gutter: 1em,
      image("../assets/img/2024_10_20_vererbung_AB_rev01.png"),
      image("../assets/img/2024_10_20_vererbung_uml_person_pilot_rev01.png"),
    ),
  )

  #grid(
    columns: (80%, 20%),
    gutter: 1em,
    body, fig,
  )
  ```java
    public class Person {
        String name;
    }

    public class Pilot extends Person {
        int flightHours;
    }
  ```
]

#slide[
  - Datenkapselung (information hiding): Variablen vor Zugriff von außen geschützt
  - Einschränkungen des Zugriffs auf Klassen, Variablen und Methoden durch
    Modifizierer
  - Gedankenbild: „Sichtbarkeit“ (d.h. ist Element sichtbar bzw. bekannt?)

    #figure(
      image("../assets/img/2024_10_20_klassen_modifier_rev01.png"),
      caption: [Modifier für Klassen, Methoden und Attribute],
    )
    #question[Ist `private` als Modifier für Konstruktoren erlaubt?]
]

#slide[
  #let body = [
    - Klasse B erbt alle sichtbaren Variablen und Methoden der Klasse A
    - Klasse B besitzt Variablen und Methoden von A und kann diese verwenden (so als
      ob diese in Klasse B definiert worden wären)

    - Beispiel:
      - Objekt von Klasse Pilot nutzt Variable name der Basisklasse Person
  ]
  #let fig = figure(
    grid(
      columns: 1,
      rows: 2,
      gutter: 1em,
      image("../assets/img/2024_10_20_vererbung_AB_rev01.png"),
      image("../assets/img/2024_10_20_vererbung_uml_person_pilot_rev01.png"),
    ),
  )
  #grid(
    columns: (80%, 20%),
    gutter: 1em,
    body, fig,
  )
]

#slide[
  ```java
    public class PilotDemo {
        public static void main(String[] args) {
            Pilot pilot = new Pilot();

            pilot.name = "Lukas Luft";
            pilot.flightHours = 1482;
            System.out.println("Name: " + pilot.name);
        }
    }
  ```
]
#slide[
  #question[
    - Was meinen Sie, welche Bestandteile einer Klasse werden nicht vererbt?
  ]

  - Nicht an abgeleitete Klasse weitergegeben:
    - Konstruktoren und Destruktoren
    - Klassenvariablen und Klassenmethoden (Modifizierer static)
    - Private Variablen und Methoden (Modifizierer private)
]

#slide[
  - Hinweise:
    - Statische Elemente nie vererbt, da an eine Klasse und nicht an konkretes Objekt
      gebunden
    - Private Elemente sind in Subklasse vorhanden, sie kann aber nicht direkt darauf
      zugreifen
]

#slide[
  - Subklassen können weitervererbt werden.
  - Von einer Klasse können beliebig viele Subklassen abgeleitet werden.
  - Das Erben von mehreren Basisklassen ist hingegen nicht möglich
    (Mehrfachvererbung)

    #figure(
      image("../assets/img/2024_10_20_vererbung_strukturen_rev01.png", height: 50%),
      caption: [Mögliche Strukturen zur Vererbung],
    )
]

#slide[
  #question[
    - Was meinen Sie, welche Basisklasse besitzt Person?
  ]
  #text(size: 20pt)[
    ```java
      public class Person {
          String name;
      }
    ```
  ]
  - Sie konnten es bisher nicht wissen:
    - In Java ist eine Klasse Object definiert.
    - Keine Basisklasse angegeben. Implizit von Object abgeleitet (extends Object)
]

#slide[
  #figure(
    image("../assets/img/2024_10_20_vererbung_uml_person_pilot_rev01.png"),
    caption: [Object als Superklasse von Person],
  )
]

#slide[
  - Wichtige Konsequenz:
    - Object ist Basisklasse jeder Vererbungshierarchie
    #figure(
      image("../assets/img/2024_10_20_vererbung_object_klasse_rev01.png"),
      caption: [Object als Teil jeder Vererbung],
    )
]

#slide[
  #question[
    - Was meinen Sie?
      - Wie viele Klassen besitzen keine Basisklasse?
      - Wie viele Klassen besitzen mehr als eine direkte Basisklasse?
  ]
]

#slide[

  - Wichtige Konsequenz:
  - Jede Klasse erbt die in Object definierten Methoden (z. B. toString())
  - Beispiel:
    #text(size: 16pt)[
      ```java
      public class Person {
        String name;
      }

      public class ObjectDemo {
        public static void main(String[] args) {
            Person person = new Person();

            person.name = "Lukas Luft";
            System.out.println(person.toString());
        }
      }
      ```
    ]
]

#slide[
  #text(size: 20pt)[

    #task[
      - Implementieren Sie Klassen für geometrische Objekte Kreis, Rechteck und Quadrat.
      - Verwenden Sie zunächst nur öffentliche Variablen.
      - Implementieren Sie zunächst keine Methoden.
    ]
  ]
  #figure(
    image(
      "../assets/img/2024_10_20_vererbung_geometrische_Formen_rev01.png",
      height: 40%,
    ),
    caption: [Geometrische Formen als Objekte],
  )
]

#slide[
  #text(size: 15pt)[
    ```java
      public class Circle {
          public double x, y;
          public double radius;
      }

      public class Rectangle {
          public double x, y;
          public double width, height;
      }

      public class Square {
          public double x, y;
          public double width;
      }
    ```
    #task[Erstellen Sie nun eine gemeinsame Basisklasse!]
  ]
]

#slide[
  #let body = [
    #text(size: 18pt)[

      ```java
      public class Shape {
            public double x, y;
        }

        public class Circle extends Shape {
            public double radius;
        }

        public class Rectangle extends Shape {
            public double width, height;
        }

        public class Square extends Shape {
            public double width;
        }
      ```
    ]
  ]
  #let fig = figure(image("../assets/img/2024_10_20_vererbung_geom_formen_baum_rev01.png"))
  #grid(
    columns: (80%, 20%),
    gutter: 0.5em,
    body, fig,
  )
]

#slide[
  #question[
    - Welche Variablen sind in den jeweiligen Klassen deklariert?
  ]
  #task[
    - Ergänzen Sie für die Klasse Circle einen Konstruktor!
  ]
]

#slide[
  #text(size: 15pt)[
    ```java
      public class Shape {
          public double x, y;
      }

      public class Circle extends Shape {
          public double radius;

          public Circle(double x, double y, double radius) {
              this.x = x;
              this.y = y;
              this.radius = radius;
          }
      }
    ```
    #memo[
      - Beachte: Variablen x und y der Basisklasse werden wie „eigene“ Variablen
        verwendet
      - Verstecken Sie die Variablen der Klasse Shape durch den Modifizierer private.

    ]

  ]

]

#slide[
  #text(size: 15pt)[
    ```java
    public class Shape {
          private double x, y;
      }

      public class Circle extends Shape {
          public double radius;

          public Circle(double x, double y, double radius) {
              this.x = x;
              this.y = y;
              this.radius = radius;
          }
      }
    ```
    #error[
      - Die Variablen x und y der Basisklasse sind in Circle nicht sichtbar.
      - Fehler: Im Konstruktor der Klasse Circle sind x und y unbekannt.
    ]
  ]
]

#slide[
  #text(size: 15pt)[
    ```java
    public class Shape {
          private double x, y;

          public void setX(double x) {
              this.x = x;
          }
          // Zusätzlich Getter sowie entsprechende Methoden für y ...
      }

      public class Circle extends Shape {
          public double radius;

          public Circle(double x, double y, double radius) {
              setX(x);
              setY(y);
              this.radius = radius;
          }
      }
    ```
  ]
]

= Instanziierung von Objekten
== Erzeugung von Objekten

#slide[
  #let fig = figure(image("../assets/img/2024_10_20_vererbung_ABC_rev01.png"))

  #let body = [
    #text(size: 18pt)[
      - Klasse C enthält eigene Methoden sowie Methoden der Klassen A und B.
      - Klasse C enthält eigene Variablen sowie Variablen der Klassen A und B.
      #question[
        - Was meinen Sie?
          - Wie werden Methoden eines neuen Objektes der Klasse C erzeugt?
          - Wie werden Variablen eines Objektes der Klasse C erzeugt und initialisiert?
      ]
      - Methoden:
        - Werden nicht für jedes Objekt neu erzeugt, sondern sind für Klasse definiert

      - Variablen:
        - An Basisklasse der Vererbungshierarchie beginnen
        - In jedem Schritt Variablen der entsprechenden (Basis-)Klasse erzeugen und
          initialisieren
        - Initialisierung über Konstruktor der jeweiligen (Basis-)Klasse

    ]

  ]

  #grid(
    columns: (85%, 15%),
    gutter: 0.5em,
    body, fig,
  )
]

#slide[

  - Variablen für Objekte der Klasse C:
    - Objekt enthält die in der Klasse C deklarierten Variablen
    - Enthält zusätzlich von Klasse B geerbte Variablen
    - Diese enthalten die von Klasse A geerbten Variablen

    #figure(
      image("../assets/img/2024_10_20_vererbung_ABC_aufbau_rev01.png"),
      caption: [Zusammensetzung des Objekts der Klasse C],
    )
]

#slide[
  - Neues Objekt der Klasse C:
    - Vererbungshierarchie nach oben durchlaufen:
    - Klasse C hat Basisklasse B: Aufruf, um Variablen von B zu erzeugen
    - Klasse B hat Basisklasse A: Aufruf, um Variablen von A zu erzeugen

  - Variablen „von innen nach außen“ erzeugen und initialisieren
    (Konstruktorverkettung):
    - Variablen von A erzeugen und über Konstruktor A() initialisieren
    - Variablen von B erzeugen und über Konstruktor B() initialisieren
    - Variablen von C erzeugen und über Konstruktor C() initialisieren
]

#slide[
  #figure(
    image("../assets/img/2024_10_20_vererbung_variablen_speicher_rev01.png"),
    caption: [Variablen der Klasse C im Speicher],
  )
]

#slide[
  #let body = [

    #text(size: 17pt)[
      - Konstruktor der Basisklasse:
        - Aufruf über super() als erste Anweisung im Konstruktor der abgeleiteten Klasse
        - Fehlt super(…) wird der Standardkonstruktor der Basisklasse aufgerufen.

      ```java
        public class A {
            double a;
            // Standardkonstruktor wird automatisch erzeugt
        }

        public class B extends A {
            double b;

            public B(double b) {
                super();    // Aufruf Standardkonstruktor Klasse A
                this.b = b;
            }
        }
      ```
    ]
  ]
  #let fig = figure(image("../assets/img/2024_10_20_vererbung_erzeugen_rev01.png"))
  #grid(
    columns: (85%, 15%),
    gutter: 0.25em,
    body, fig,
  )
]

#slide[

  - Sie erinnern sich?
    #text(size: 18pt)[
      ```java
        public class Shape {
            private double x, y;
        }

        public class Circle extends Shape {
            public double radius;

            public Circle(double x, double y, double radius) {
                this.x = x;
                this.y = y;
                this.radius = radius;
            }
        }
      ```
    ]
    #task[
      - Die Variablen x und y sind in Circle unbekannt.
      - Lösen Sie das Problem durch Ergänzen eines Konstruktors für die Basisklasse
        Shape.
    ]
]

#slide[
  #text(size: 16pt)[

    ```java
    public class Shape {
        private double x, y;

        public Shape(double x, double y) {
            this.x = x;
            this.y = y;
        }
    }

    public class Circle extends Shape {
        public double radius;

        public Circle(double x, double y, double radius) {
            super(x, y);  // Passende Signatur zum Konstruktor der Basisklasse!
            this.radius = radius;
        }
    }
    ```
  ]
]

#slide[
  #task[
    - Schützen Sie alle Attribute durch den Modifizierer private.
    - Erzeugen Sie gegebenenfalls geeignete Getter und Setter.
  ]

  #figure(
    image(
      "../assets/img/2024_10_20_vererbung_uml_geom_formen_rev01.png",
      height: 40%,
    ),
    caption: [Aufbau der Vererbung],
  )
]

#slide[
  #text(size: 18pt)[
    ```java
    public class Circle extends Shape {
        private double radius;

        public Circle(double x, double y, double radius) {
            super(x, y);
            this.radius = radius;
        }

        public double getRadius() {
            return radius;
        }

        public void setRadius(double radius) {
            this.radius = radius;
        }
    }
    ```
  ]
]

= Referenzieren über die Basisklasse
== Referenz Basisklasse

#slide[
  #let body = [
    #text(size: 16pt)[

      - Betrachten wir folgende Vererbungslinie:
      ```java
        public class Person {
            String name;

            public Person(String name) {
                this.name = name;
            }
        }

        public class Pilot extends Person {
            String airline;

            public Pilot(String name, String airline) {
                super(name);
                this.airline = airline;
            }
        }
      ```
    ]
  ]
  #let fig = figure(image("../assets/img/2024_10_20_vererbung_uml_person_pilot_rev01.png"))

  #grid(
    columns: (85%, 15%),
    gutter: 0.25em,
    body, fig,
  )
]

#slide[
  #let body = [
    #text(size: 18pt)[

      - Was meinen Sie zu folgendem Programm?

        ```java
          public class ReferenceDemo {
            public static void main(String[] args) {
              Pilot pilot = new Pilot("Birgit", "Winglet Airways");
              Person personRef = pilot;
              Object objectRef = pilot;

            System.out.println(personRef.name);
          }
        }
        ```

        #memo[
          Es gibt nur ein Objekt (mit Datentyp Pilot). Objekt wird über Variablen mit
          anderen Datentypen als Pilot referenziert
        ]

    ]
  ]
  #let fig = figure(image("../assets/img/2024_10_20_vererbung_uml_person_pilot_rev01.png"))

  #grid(
    columns: (85%, 15%),
    gutter: 0.25em,
    body, fig,
  )

]

#slide[

  - Klasse Pilot erbt von Klasse Person und erweitert diese
  - Pilot beinhaltet Person („Pilot is a Person“) Als Person referenzierbar
  - Objekt wird hierdurch nicht verändert (d.h. Objekt bleibt vom Typ Pilot)!
    #figure(
      image("../assets/img/2024_10_20_vererbung_referenzen_rev01.png", height: 40%),
      caption: [Referenzen auf ein Objekt mit Basisklasse],
    )
]

#slide[

  - Allgemein:
    - Objekte können wie Objekte ihrer Basisklassen behandelt werden.
    - Objekte über Datentypen ihrer Basisklassen referenzierbar
    - Referenzvariable kann nur auf Attribute und Methoden ihrer Klasse zugreifen
]
#slide[
  #text(size: 18pt)[

    #question[
      - Welche Zugriffe auf Attribute sind zulässig und welche nicht?
    ]
    ```java
      public static void main(String[] args) {
          Pilot pilot = new Pilot("Birgit", "Winglet Airways");
          Person personRef = pilot;
          Object objectRef = pilot;

          System.out.println(personRef.name);
          System.out.println(personRef.airline);
          System.out.println(objectRef.name);
          System.out.println(objectRef.airline);
      }
    ```
  ]
]
= Überlagern
== Überlagern von Methoden
#slide[

  #let body = [
    #text(size: 16pt)[
      - Klasse Person ist von Object abgeleitet und erbt daher toString() von Object und
        definiert daher eine weitere toString()-Methode

      ```java
        public class Person {
            private String name;

            public Person(String name) {
                this.name = name;
            }

            public String getName() {
                return name;
            }

            public String toString() {
                return name;
            }
        }
      ```
    ]
  ]
  #let fig = figure(image("../assets/img/2024_10_20_vererbung_person_toString_rot_rev01.png"))

  #grid(
    columns: (80%, 20%),
    gutter: 0.25em,
    body, fig,
  )
]

#slide[

  #let body = [
    #text(size: 18pt)[
      - Klasse Pilot:
        - Von Person abgeleitet und erbt daher toString() von Person
        - Definiert noch eine toString()-Methode
      ```java
        public class Pilot extends Person {
            private String airline;

            public Pilot(String name, String airline) {
                super(name);
                this.airline = airline;
            }

            public String toString() {
                return String.format("%s (%s)", getName(), airline);
            }
        }
      ```
    ]
  ]
  #let fig = figure(image("../assets/img/2024_10_20_vererbung_person_pilot_tostring_rot_rev01.png"))

  #grid(
    columns: (80%, 20%),
    gutter: 0.25em,
    body, fig,
  )

]

#slide[
  #text(size: 20pt)[
    #question[
      Was wird ausgegeben?
    ]
    ```java
    public static void main(String[] args) {
          Person person = new Person("Birgit Janssen");
          System.out.println("person: " + person);
          System.out.println("person.toString(): " + person.toString());

          Pilot pilot = new Pilot("Jan Birgerson", "Winglet Airways");
          System.out.println("pilot.toString(): " + pilot.toString());
      }
    ```
  ]

]
#slide[
  #let body = [
    #text(size: 18pt)[
      - Ausgabe:
        - `person`: Birgit Janssen
        - `person.toString()`: Birgit Janssen
        - `pilot.toString()`: Jan Birgerson (Winglet Airways)

        #memo[
          - Jeweils Methode der entsprechenden Klasse, nicht der Superklasse(n), ausgeführt
          - Begriff: Methode der Superklasse durch neu definierte Methoden überlagert
        ]
    ]
  ]

  #let fig = figure(image("../assets/img/2024_10_20_vererbung_toString_rev01.png"))
  #grid(
    columns: (80%, 20%),
    gutter: 0.25em,
    body, fig,
  )
]
#slide[

  #let body = [
    #text(size: 18pt)[
      #question[
        - Was wird ausgegeben?
      ]
      ```java
      public static void main(String[] args) {
          Pilot pilot = new Pilot("Jan Birgerson", "Winglet Airways");
          Object objectRef = pilot;
          Person personRef = pilot;

          System.out.println("objectRef: " + objectRef.toString());
          System.out.println("personRef: " + personRef.toString());
      }
      ```
      #pause
      - Ausgabe:
        - `objectRef`: Jan Birgerson (Winglet Airways)
        - `personRef`: Jan Birgerson (Winglet Airways)

    ]
  ]

  #let fig = figure(image("../assets/img/2024_10_20_vererbung_toString_rev01.png"))
  #grid(
    columns: (80%, 20%),
    gutter: 0.25em,
    body, fig,
  )
]
#slide[
  #memo[
    Methode der entsprechenden Klasse ausgeführt, selbst bei Referenz über Superklasse(n)
  ]
]

#slide[
  #let body = [
    #text(size: 14pt)[

      - Zugriff auf überlagerte Methoden der Basisklasse über Referenz super
      - Beispiel:
      ```java
      	public class Pilot extends Person {
      	    // Instanzvariable, Konstruktor, toString() ...

      	    public String toStringOfSuperClass() {
      	        return super.toString();
      	    }
      	}

      	public static void main(String[] args) {
      	    Pilot pilot = new Pilot("Jan Birgerson", "Winglet Airways");
      	    System.out.println("Pilot.toString(): " + pilot.toString());
      	    System.out.println("super.toString(): " + pilot.toStringOfSuperClass());
      	}
      ```
      #pause
      - Ausgabe:
        - `Pilot.toString()`: Jan Birgerson (Winglet Airways)
        - `super.toString()`: Jan Birgerson
    ]
  ]

  #let fig = figure(image("../assets/img/2024_10_20_vererbung_toString_rev01.png"))
  #grid(
    columns: (80%, 20%),
    gutter: 0.25em,
    body, fig,
  )

]

#slide[
  #let fig = figure(image("../assets/img/2024_10_20_vererbung_toString_rev01.png"))
  #let body = [
    #text(size: 14pt)[

      - Variablen mit Modifier final sind Konstanten.
        - Wert kann nach erster Zuweisung nicht mehr geändert werden
      #question[
        - Was meinen Sie?
          - Was bewirkt final für Klassen?
          - Was bewirkt final für Methoden?
      ]
      #pause
      - Klassen:
        - Klasse mit Modifier final kann nicht abgeleitet werden
        - Beispiel: Klasse String

      - Methoden:
        - Methode mit Modifier final kann nicht in Subklasse überlagert werden
      #figure(
        image("../assets/img/2024_10_20_vererbung_final_rev01.png"),
        caption: [`final`-Schlüsselwort in der Vererbung],
      )
    ]
  ]

  #grid(
    columns: (80%, 20%),
    gutter: 0.25em,
    body, fig,
  )

]

#slide[

  - Überlagern von Methoden:
    - Von der Basisklasse geerbte Methoden dürfen neu definiert werden.
    - Begriffe: Überlagern (oder auch Überschreiben)
    - Beim Aufruf wird die überlagernde Methode („neueste Version“) ausgeführt
    - Aufruf der verdeckten Methode `name()` der Basisklasse über `super.name()`
    - Modifier `final` unterbindet Überlagern in Subklassen

  - Überlagern von Attributen:
    - Abgeleitete Klasse kann auf gleiche Weise Variablen der Basisklasse überlagern
]

#slide[
  #text(size: 18pt)[
    #question[
      - Welche Methoden hat Jason, die Katze?
      - Aus welchen Klassen stammt jeweils die Methoden-Definition?
    ]
    #figure(image("../assets/img/2024_10_20_vererbung_katze_frage_rev01.png", height: 60%))

  ]
]
#slide[
  #text(size: 18pt)[
    #question[
      - Welche Methoden hat Jason, die Katze?
      - Aus welchen Klassen stammt jeweils die Methoden-Definition?
    ]
    #figure(image("../assets/img/2024_10_20_vererbung_katze_antwort_rev01.png", height: 60%))

  ]
]

#slide[
  #text(size: 18pt)[
    #task[
      - Ergänzen Sie Methoden `getArea()` zur Bestimmung der Fläche eines Objekts.
      - Erstellen Sie folgendes ausführbares Programm:
        - Speichert je ein Objekt `Circle`, `Rectangle` und `Square` in einer gemeinsamen Liste
        - Bestimmt Summe der Flächeninhalte aus dieser Liste
    ]

  ]
  #figure(image("../assets/img/2024_10_20_vererbung_uml_geom_formen_rev01.png", height: 50%))

]
#slide[
  #text(size: 18pt)[
    Klasse `Circle`:
    ```java
    	public double getArea() {
    	    return Math.PI * radius * radius;
    	}
    ```
    Klasse `Rectangle`:
    ```java
    	public double getArea() {
    	    return width * height;
    	}
    ```
    Klasse `Square`:
    ```java
    	public double getArea() {
    	    return width * width;
    	}
    ```
  ]
]

#slide[
  #text(size: 16pt)[

    - Ausführbares Programm:
    ```java
    	public static void main(String[] args) {
    	    ArrayList<Shape> shapes = new ArrayList<Shape>();
    	    shapes.add(new Circle(2.0, 3.0, 1.0));
    	    shapes.add(new Rectangle(-1.0, 0.0, 3.5, 4.0));
    	    shapes.add(new Square(0.0, 0.0, 2.5));

    	    double sumArea = 0.0;
    	    for (Shape shape : shapes) {
    	        sumArea += shape.getArea();
    	    }

    	    System.out.println("Overall area of shapes = " + sumArea);
    	}
    ```
    - Methode `getArea()` muss auch in `Shape` implementiert sein
    - Wird allerdings nicht verwendet, sondern von Subklassen überlagert: Sehr unschön!
    - Wir werden später eine elegantere Lösung kennenlernen.

  ]
]

= Polymorphismus
== Polymorphismus

#slide[
  - Die gute Nachricht:
    - Nur ein neuer Begriff, ansonsten ist alles bereits bekannt
    - Nein, wirklich. Ganz ehrlich. Echt wahr …

  - Polymorphismus:
    - Wortlaut: „Vielgestaltigkeit“
    - Methoden mit gleichem Namen können mehrere Gestalten annehmen.
    - Sprich: Mehrere Implementierungen von Methoden mit gleichem Namen
    - Typische Eigenschaft objektorientierter Sprachen

]

#slide[

  #question[
    - Wo ist uns das bereits begegnet?
  ]
  #pause
  - Methoden gleichen Namens in derselben Klasse: Überladen
  - Methoden gleichen Namens in Vererbungslinie: Überlagern (auch: Überschreiben)
]

#slide[
  #let left = [
    #text(size: 18pt)[
      - Überladen (Overloading):
        - Methoden in Klasse haben gleichen Namen
        - Müssen unterschiedliche Signatur haben (d.h. unterschiedliche Parametertypen)
        #figure(image("../assets/img/2024_10_20_vererbung_mathfunctions_rev01.png"), caption: [Klasse MathFunctions])

    ]

  ]
  #let right = [
    #text(size: 18pt)[
      - Überlagern / Überschreiben (Overriding):
        - Methode in Vererbungslinie haben gleichen Namen
        - Müssen gleiche Signatur haben (d.h. gleichen Namen und Parametertypen)

        #figure(image("../assets/img/2024_10_20_vererbung_toString_rev01.png"), caption: [Vererbung von `toString()`])

    ]
  ]
  #grid(
    columns: (50%, 50%),
    gutter: 0.25em,
    left, right,
  )
]
= Vergleich von Objekten

== Vergleichsoperator (==)

#slide[
  #question[
    - Klasse Point beinhalte die Variablen x und y
    - Was wird ausgegeben?

  ]
  ```java
  	Point a = new Point(1, 2);
  	Point b = new Point(7, 3);
  	System.out.println(a == b);
  ```

]

#slide[
  #question[
    - Und nun?
  ]
  ```java
  	Point a = new Point(1, 2);
  	Point b = new Point(1, 2);
  	System.out.println(a == b);
  ```

]

#slide[
  #question[
    - Und nun?
    ```java
    	Point a = new Point(1, 2);
    	Point b = a;
    	System.out.println(a == b);
    ```

  ]
]
#slide[

  #let body = [
    #text(size: 14pt)[
      - Vergleichsoperator vergleicht, ob Variablen denselben Inhalt haben
        - Inhalt ist jeweils Referenz auf ein Objekt
        - Vergleich nur dann wahr (true), wenn Variablen dasselbe Objekt referenzieren

        #example[
          ```java
          	Point a = new Point(1, 2);
          	Point b = new Point(1, 2);
          	Point c = new Point(7, 3);
          	Point d = a;
          ```
        ]
      #error[
        - `a == b`: Verschiedene Objekte (mit gleichen Werten)
        - `a == c`: Verschiedene Objekte (und Werte)
      ]

      #success[
        - `a == d`: Dasselbe Objekt: gleiche Referenz
      ]
    ]

  ]
  #let fig = figure(image("../assets/img/2024_10_20_vererbung_referenzen_point_rev01.png"))
  #grid(
    columns: (80%, 20%),
    gutter: 0.25em,
    body, fig,
  )
]

== `equals()`-Methode
#slide[
  #text(size: 22pt)[
    ```java
    	public boolean equals(Object obj) {
    	    // Methodenrumpf
    	    // Rückgabe eines Wertes vom Typ boolean
    	}
    ```

    - Vergleich, ob alle Variablen zweier referenzierter Objekte gleiche Werte haben
    - Methode ist bereits in Klasse Object definiert

    - Überlagern in eigenen Klassen:
      - Klasse Object kann nicht wissen, welchen Variablen Sie in Subklassen hinzufügen
      - Methode daher gegebenenfalls überlagern, um hinzugefügte Attribute zu vergleichen
      - In IntelliJ IDEA ist das bequem über das Generate-Menü möglich.
  ]
]

#slide[
  #text(size: 20pt)[
    #question[
      - Gegeben sei Klasse Point mit x- und y-Koordinate
      - Welches Ergebnis liefern die Vergleiche in der Tabelle?
    ]
  ]
  #figure(image("../assets/img/2024_10_20_vererbung_referenzen_frage_rev01.png", height: 60%))
]

#slide[
  #text(size: 20pt)[
    #question[
      - Gegeben sei Klasse Point mit x- und y-Koordinate
      - Welches Ergebnis liefern die Vergleiche in der Tabelle?
    ]
  ]
  #figure(image("../assets/img/2024_10_20_vererbung_referenzen_antwort_rev01.png", height: 60%))
]

= License Notice

== Attribution

- This work is shared under the CC BY-NC-SA 4.0 License and the respective Public
  License
- #link("https://creativecommons.org/licenses/by-nc-sa/4.0/")
- This work is based off of the work Prof. Dr. Marc Hensel.
- Some of the images and texts, as well as the layout were changed.
- The base material was supplied in private, therefore the link to the source
  cannot be shared with the audience.
