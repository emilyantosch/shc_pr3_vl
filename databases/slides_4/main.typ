#import "@preview/touying:0.5.2": *
#import themes.university: *

#import "@preview/fletcher:0.5.1" as flechter: diagram, node, edge

#import "@preview/gentle-clues:1.0.0": *
#import "@preview/pinit:0.2.0": *
#import "@preview/codly:1.0.0": *
#show: codly-init.with()

#import "@preview/numbly:0.1.0": numbly

#set text(lang: "de", font: "Roboto")
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
    title: [Objektorientierte Programmierung in Java], subtitle: [Vorlesung 4 - Klassenbibliotheken], author: [Emily Lucia Antosch], date: datetime.today().display("[day].[month].[year]"), institution: [HAW Hamburg],
  ),
)

#codly(
  languages: (
    sql: (
      name: text(font: "JetBrainsMono NFM", " SQL", weight: "bold"),
      icon: text(font: "JetBrainsMono NFM", "\u{e76e}", weight: "bold"),
      color: rgb("#2563eb"),
    ),
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

- Zuletzt haben wir uns mit Klassen und Objekten beschäftigt.
- Sie können nun
  - einfache Klassen in Java schreiben,
  - aus den Klassen Objekte erzeugen, Attribute verwenden und Methoden aufrufen und
  - Klassenvariablen und Klassenmethoden verwenden.
- Heute geht es weiter mit *Klassenbibliotheken*.

#slide[
  1. Imperative Konzepte
  2. Klassen und Objekte
  3. *Klassenbibliothek*
  4. Vererbung
  5. Schnittstellen
  6. Graphische Oberflächen
  7. Ausnahmebehandlung
  8. Eingaben und Ausgaben
  9. Multithreading (Parallel Computing)
]

== Das Ziel dieses Kapitels

- Sie wenden Zeichenketten beispielsweise für eine formatierte Ausgabe von Daten
  an.
- Sie organisieren gleichartige Daten in Feldern, Matrizen sowie Listen.
- Sie wandeln Zeichenketten in Zahlenwerte und wenden mathematische Funktionen auf
  Zahlenwerte an.

= Zeichenketten

== Zeichenketten

#slide[

- Zeichenketten in C
  - Variablen: Zeiger auf Array des primitiven Datentyps `char`
  - Speichergröße vom Programmierer verwaltet
  - Datentyp hat keine Methoden
- Zeichenketten in Java:
  - Zeichenketten sind Objekte der Klasse String.
  - Variablen referenzieren Objekte
  - Speichergröße vom Objekt verwaltet
  - Datentyp stellt Methoden zur Verfügung
]

#slide[
  #figure(
    image("../assets/img/2024_10_16_strings_c_java_rev01.png"), caption: [Zeichenketten: Unterschiede C und Java],
  )
]

== Zeichenketten erzeugen

- Erzeugung erfolgt auch über den `new`-Operator:
```java
String name = new String("Lena");
```
- Alternativ auch durch Zuweisung eines Literales:
```java
String name = "Lena";
```
- Zuweisung eines Literales auch nach Erzeugung möglich:
```java
String name = new String("Lena");
name = "Birgit";
```

== Zeichenketten als unveränderbar

#slide[
  #memo[
    - Wie in vielen objektorientierten Sprachen:
      - Objekte der Klasse String sind unveränderbar (immutable).
      - Ihr Wert kann nach Erzeugung nicht modifiziert werden.
      - Zum mehrstufigen Aufbau existiert die Klasse StringBuilder
  ]
]

#slide[
#question[Welche Ausgabe erzeugt folgendes Programm?]
#text(size: 16pt)[

```java
public static void main(String[] args) {
    String lena1 = new String("Lena");
    String lena2 = lena1;

    System.out.println("lena1: " + lena1 + "\nlena2: " + lena2);
    System.out.println("Referenzen gleich: " + (lena1 == lena2));

    lena2 += " B.";
    System.out.println("\nlena1: " + lena1 + "\nlena2: " + lena2);
    System.out.println("Referenzen gleich: " + (lena1 == lena2));
}
```
]
]

#slide[
- Zur Veranschaulichung

```java
String lena1 = new String("Lena");
String lena2 = lena1;
```

#figure(
  image("../assets/img/2024_10_16_string_immut_objects_rev01.png"), caption: [Referenz auf Zeichenkette],
)
]

#slide[
```java
lena2 += " B.";
```
#figure(
  image("../assets/img/2024_10_16_string_immut_two_objects_rev01.png"), caption: [Änderung der Zeichenkette führt zu neuem Objekt],
)
]

== Verkettung von Zeichenketten

- Zeichenketten sind über den Plus-Operator verknüpfbar:
```java
String name = "Lena " + "oder " + "dann ";
  name = name + "doch " + "wieder ";
  name += "Birgit?";
```

- Implizite Umwandlung anderer Datentypen in ein String-Objekt:
  - Auswertung der Plus-Operatoren von links nach rechts
  - Umwandlung in String, sofern der andere Operand nicht vom Typ String ist

#slide[
#question[Was wird ausgegeben?]
```java
  int a = 20;
  int b = 22;
  System.out.println("Jahr: " + a + b);
  System.out.println(a + b + " (Jahr)");
  ```
]

== `toString()`-Methode
#slide[

```java
public String toString() {
      // Methodenrumpf
      // Rückgabe eines Objektes vom Typ String
  }
```

- Methodenkopf vorgeschrieben
- Methodenrumpf frei programmierbar
- Gibt für Objekte einen String zurück, der Objekt beschreiben sollte
- Wird bei impliziter Umwandlung eines Objektes in einen String aufgerufen
]

#slide[
#task[Lassen Sie uns das einmal ausprobieren!
- Erzeugen Sie eine Klasse Person und implementieren Sie die `toString()`-Methode]
- Überprüfen Sie den impliziten Aufruf mittels der Konsolenausgabe.
]

#slide[
```
public class Person {
      String firstName, surname;

      public Person(String firstName, String surname) {
          this.firstName = firstName;
          this.surname = surname;
      }

      public String toString() {
          return firstName + " " + surname;
      }
  }
  ```
]

#slide[
```
Person lena = new Person("Lena", "Jensen");
String name = "Name: " + lena;
System.out.println(lena);
System.out.println(name);
  ```
]

== String-Methoden

#slide[

  - Weitere Methoden beinhalten z.B.:
    - Länge der Zeichenkette
    - Zeichen an bestimmten Position (Erstes Zeichen hat Index 0!)
    - Bestimmtes Zeichen ersetzen
    - Bestimmtes Zeichen oder Teilzeichenkette suchen
    - Zeichenkette teilen
    - Umwandlung in Kleinbuchstaben oder Großbuchstaben
    - Vergleich zweier Zeichenketten
    - Und noch einige Weitere!
]

#slide[
#task[
  - Ersetzen Sie "Humbug" durch "Hamburg".
]
```java
  String hamburg = "Willkommen in Humbug!";
  hamburg = hamburg.replace("Humbug", "Hamburg");
  System.out.println(hamburg);
  ```
]

#slide[
#question[Was wird ausgegeben?]
```java
  String upper = "Willkommen in Hamburg!";
  String lower = "willkommen in hamburg!";

  System.out.println(lower.equals(upper));
  System.out.println(lower.equals(upper.toLowerCase()));
  System.out.println(lower.equalsIgnoreCase(upper));
  ```
]

== String-Formatierung

- Gerne gefragt:
  - Kann man auch das Format des Strings bei der Ausgabe anpassen? *Ja, natürlich!*

- Klassenmethode `format()`:
  - Erzeugt eine formatierte Zeichenkette
  - Es erfolgt keine Ausgabe auf Konsole.
  - Syntax (fast) identisch mit printf() aus C/C++

#slide[
#question[Was wird ausgegeben?]

```java
  double wind = 21.4532;
  String weather = String.format("%s %d: %.1f km/h", "Station", 7, wind);
  System.out.println(weather);
```
#pause
- *Ausgabe:* Station 7: 21,5 km/h
]

#slide[
- Formatangaben:

```java %[ArgumentNr.] [Flags] [MindestanzahlZeichen] [.Genauigkeit] Format```

#figure(
  image("../assets/img/2024_10_16_string_formats_rev01.png", height: 60%), caption: [Formate und Flags],
)
]

#slide[
#question[Was wird ausgegeben?]
  #text(size: 20pt)[

```java
  double wind = 21.4532;
  System.out.println(String.format("%2.2f km/h", wind));
  System.out.println(String.format("%8.2f km/h", wind));
  System.out.println(String.format("%08.2f km/h", wind));
  ```
  ]
#pause
- Ausgabe:
  - 21,45 km/h
  - 21,45 km/h
  - 00021,45 km/h
]


#slide[
  #memo[
    - Mindestanzahl der Zeichen:
      - Schließt Nachkommastellen, sowie das Komma ein
      - Schneidet keine Vorkommastellen ab
  ]
]

#slide[
#question[
  - Was fällt auf?
]
```java
  double wind = 21.4532;
  System.out.println(String.format("%2.2f km/h", wind));
  ```
- Ausgabe: 21,45 km/h
  #pause
- Oben bei Ausgabe „deutsches Nachkomma“ statt „englischer Punkt“
- Durch Lokalisierung vorgegeben
]

#slide[
#example[
```java
  double wind = 21.4532;
  System.out.println(String.format(Locale.US, "%2.2f km/h", wind));
  System.out.println(String.format(Locale.GERMAN, "%2.2f km/h", wind));
```

- Ausgabe: 21.45 km/h 21,45 km/h
]

]
= Arrays
== Arrays (Felder)

- Arrays in C:
  - Variablen: Zeiger auf erstes Element des Arrays im Speicher
  - Speichergröße vom Programmierer verwaltet
  - Datentyp hat keine Methoden

- Arrays in Java:
  - Arrays sind Objekte.
  - Variablen referenzieren Objekte
  - Speichergröße vom Objekt verwaltet
  - Datentyp stellt Methoden zur Verfügung

#slide[
  #figure(
    image("../assets/img/2024_10_16_arrays_c_java_rev01.png"), caption: [Arrays in Java und C],
  )
]

== Erzeugung von Arrays

- Sammlung von Elementen mit gleichem Datentyp
- Datentyp wird durch eckige Klammern zum Array (z.B. `int[]`, `String[]`)
- Array-Klassen sind eigene (weitere) Datentypen

- Deklaration:
  - Erfordert keine Angabe der Länge
  - Variable kann Arrays beliebiger Länge referenzieren
  - Deklaration erzeugt kein Objekt, sondern Referenzvariable

```java
int[] filter;
```
#memo[- Klammern hinter Variablennamen zulässig, aber nicht empfohlen (Warum?)]
```java
int filter[];
```

== Erzeugung: Dynamische Deklaration

- Array-Objekt mittels new-Operator erzeugen
- Anzahl der Felder in eckigen Klammern
- Beachte: Keine runden „Konstruktor-Klammern“ hinter Datentyp
- Werte im Array werden mit 0, 0.0, false bzw. null initialisiert

```java
int[] filter = new int[];
```

#figure(
  image("../assets/img/2024_10_16_filter_array_empty_rev01.png"), caption: [Erstellung eines Arrays],
)

== Erzeugung: Zuweisen von Elementen

- Zugriff auf Array-Element über Index in eckigen Klammern
- Erstes Element besitzt Index 0

```java
int[] filter = new int[3];
  filter[0] = 1;
  filter[1] = 2;
  filter[2] = 1;
```

#figure(
  image("../assets/img/2024_10_16_filter_array_filled_single_rev01.png"), caption: [Zuweisen von Werten durch Indexzugriff],
)

== Erzeugung: Statische Deklaration

- Man kann einem Array bereits bei Erzeugung des Objektes die Werte zuweisen.
- Werte in geschweiften Klammern und durch Kommas getrennt
- Mit und ohne Verwendung des new-Operators zulässig

```java
int[] filter = {1, 2, 1};
int[] filter = new int[] {1, 2, 1};
```

#figure(
  image("../assets/img/2024_10_16_filter_array_filled_single_rev01.png"), caption: [Füllen bei Deklaration],
)

== Eigenschaften: Array-Klassen

- Arrays sind Objekte der entsprechenden Klasse:
  - Arrays besitzen Methoden.
  - Anzahl der Elemente über Instanzvariable length

#question[Welches Array wird durch den Code erzeugt?]

#text(size: 22pt)[

```java
int[] filter = new int[3];
  for (int i = 0; i < filter.length; i++) {
      filter[i] = i * i;
  }
```
]

#figure(
  image("../assets/img/2024_10_16_filter_array_question_rev01.png"), caption: [Befüllen durch `for`-Schleife],
)

#slide[

- Indizes:
  - Bei Zugriff auf Element überprüft, ob Index im erlaubten Bereich liegt
  - Mehr im Kapitel über Ausnahmen und Fehlerbehandlung

  #example[
  Beispiele erlaubter und nicht erlaubter Indizes:
  ```java
                              int[] filter = new int[3];
                              filter[0] = -1;
                              filter[2] = 4;
                              filter[-1] = 1;
                              filter[3] = 2;
                                ```
  ]
  #figure(
    image("../assets/img/2024_10_16_filter_array_index_rev01.png"), caption: [Indizes des Arrays `filter`],
  )
]

#slide[
- Arrays für beliebige Datentypen (auch eigene Klassen) deklarierbar
- Objekte müssen vom gleichen Typ sein (oder Subtyp, hierzu mehr bei Vererbung)
- Nicht die Objekte gespeichert, sondern Referenzen zu den Objekten

```java
  Person[] friends = new Person[3];
  friends[0] = new Person("Lena");
  friends[1] = new Person("Birgit");
  friends[2] = new Person("Jan");
  ```

#figure(
  image("../assets/img/2024_10_16_friends_array_classes_rev01.png"), caption: [Arrays aus Objekten],
)
]

== Fragen
#slide[
#question[
  Was wird ausgegeben?
]

```java
  int[] a = {1, 2, 3, 4, 5};
  int[] b = a;
  b[3] = 0;
  System.out.println(b[2]);
  System.out.println(a[3]);
  ```
]

#slide[
#question[Was wird ausgegeben?]

```java
  int[] a = {1, 2, 3, 4, 5};
  int[] b = {1, 2, 3, 4, 5};
  System.out.println(a == b);
  ```
]

#slide[
#question[Was wird ausgegeben?]
  #text(size: 18pt)[

```java
public class ArrayDemo {
      static int[] createSortedArray(int a, int b) {
          if (a < b) {
              return new int[] {a, b};
          } else {
              return new int[] {b, a};
          }
      }

      public static void main(String[] args) {
          System.out.println( createSortedArray(7, 4)[1] );
      }
  }
  ```
  ]
]

#slide[
#task[
- Schreiben Sie eine Methode, die die Elemente eines `int[]`-Arrays aufsteigend
  sortiert.
- Testen Sie die Methode anhand des Arrays `{10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 7}`.
]

]

#slide[
  #text(size: 18pt)[
```java
public static void sort(int[] a) {
    int i = 0;
    while (i <= a.length - 2) {
        if (a[i] > a[i+1]) {
            // Swap elements and shift index to left element
            int temp = a[i];
            a[i] = a[i+1];
            a[i+1] = temp;
            if (i > 0)
                i--;
        } else {
            i++;
        }
    }
}
  ```
  ]
]

= Mehrdimensionale Arrays

== Mehrdimensionale Arrays

- Mehrdimensionale Arrays sind „Felder von Feldern“.
- Beispiel: `int[][]` ist Array, dessen Elemente vom Datentyp `int[]` sind.

Dynamische Deklaration:
```java
  int[][] filter = new int[3][4];
```
Statische Deklaration:
```java
  int[][] filter = {{1,2,3}, {4,5,6}, {7,8,9}};
```

#figure(
  image("../assets/img/2024_10_16_filter_array_dim_rev01.png"), caption: [Mehrdimensionales Array],
)

#slide[
  #question[Was wird ausgegeben?]

  ```java
  int[][] a = {{1,2}, {3,4}, {5,6}};

	System.out.println(a.length);
	System.out.println(a[2].length);

	System.out.println(a[1][1]);
	System.out.println(a[2][0]);
  ```

]
#slide[
#figure(image("../assets/img/2024_10_16_a_array_question_dim_rev01.png"), caption: [Mehrdimensionale Arrays mit Werten])
]

#slide[
  #question[Was wird ausgegeben?]

  ```java
int[][] a = {{1,2}, {3,4}, {5,6}};
int[] b = a[0];
int c = b[1];

b[1] = 7;
System.out.println(a[0][1]);
System.out.println(c);
  ```
]

#slide[
  #figure(image("../assets/img/2024_10_16_a_b_c_array_question_rev01.png"), caption: [Komplizierte mehrdimensionale Arrays])
]

#slide[
- Mehrdimensionale Arrays müssen nicht rechteckig sein
- Beispiel: Jeder Zeile eines zweidimensionalen Arrays eigenes Array zuweisen

#task[Erstellen Sie eine Dreiecksmatrix mittels einer `for`-Schleife!]

#pause

#text(size: 18pt)[
```java
int[][] a = new int[3][];
	for (int i = 0; i < a.length; i++) {
	    a[i] = new int[i + 1];
	}
```
]
]
#slide[
  #figure(image("../assets/img/2024_10_17_triangle_array_rev01.png"), caption: [Mehrdimensionales Array in der Form eines Dreiecks])
]

= Listen

== ArrayList

#slide[
- Arrays: Größe nach Erzeugung nicht mehr änderbar („semidynamisch“)
- Listen: Elemente können hinzugefügt oder entfernt werden („dynamisch“)
  - Datentyp zu speichernder Elemente in spitzen Klammern (siehe unten: String)
]

#slide[
  #text(size: 18pt)[    
```java
public class ArrayListDemo {
	    public static void main(String[] args) {
	        ArrayList<String> names = new ArrayList<String>();
	        names.add("Lena");
	        names.add("Birgit");
	        names.add("Jan");
	        names.add(new String("Jan"));
	    }
	}
```
  ]
]
#slide[
- Beispiele:
  - Anzahl der Elemente (`size()`)
  - Zugriff auf Elemente (`get()`)
  - Abfrage, ob bestimmtes Element in Liste ist (`contains()`)
  - Element aus Liste entfernen (`remove()`)
]

#slide[
  #text(size: 18pt)[

  ```java
ArrayList<String> names = new ArrayList<String>();
	String birgit = "Birgit";
	names.add("Lena");
	names.add(birgit);

	for (int i = 0; i < names.size(); i++) {
	    System.out.println(names.get(i));
	}

	if (names.contains(birgit)) {
	    names.remove(birgit);
	}
```
  ]
]

= foreach-Schleife

== foreach-Schleife

#slide[
```java
for (Datentyp Variable : Iterationsobjekt) {
    Anweisungen
}
```

- Motivation:
  - Mitunter jedes Element z.B. eines Arrays oder einer Liste benötigt
  - Aber: Position innerhalb des Arrays oder der Liste wird nicht benötigt
  - Daher auch kein Schleifenzähler als Index benötigt
]

#slide[
- Schleife iteriert vom ersten bis zum letzten Element durch Array (oder Liste):
- Beim ersten Durchlauf hat Variable den Wert des 1. Elements
- Beim zweiten Durchlauf hat Variable den Wert des 2. Elements und so weiter
- Beim letzten Durchlauf hat Variable den Wert des letzten Elements
]

#slide[
  #question[Was wird ausgegeben?]
  ```java
int[] a = {7, 1, 3, 8};

	for (int element : a) {
	    System.out.println("Element: " + element);
	}
  ```
  #figure(image("../assets/img/2024_10_16_foreach_rev01.png"), caption: [Ergebnis der foreach-Schleife])
]

#slide[
  #task[
    - Erstellen Sie Folgendes unter Verwendung einer foreach-Schleife:
    - Methode, die den Mittelwert der in einem Array enthaltenen Zahlen zurückgibt
    - Programm, das die Methode verwendet
  ]
]

#slide[
  #text(size: 20pt)[
  ```java
static double average(double[] numbers) {
	    double sum = 0.0;

	    for(double number : numbers) {
	        sum += number;
	    }
	    return sum / numbers.length;
	}

	public static void main(String[] args) {
	    double[] a = {1.43, 2, .2, 6.32, 7.1, 8.1};
	    System.out.println("Average = " + average(a));
	}
  ```
  ]
]

= Wrapperklassen & `Math`-Klasse

== Wrapperklassen

- Primitive Datentypen:
  - Speichern Wert (z.B. Ganzzahl) direkt
  - Besitzen keine Methoden

- Wrapperklassen:
  - „Packen“ (to wrap) primitive Datentypen in Klassen ein
  - Stellen Methoden (z.B. für Ganzzahlen) zur Verfügung

#figure(image("../assets/img/2024_10_16_wrapper_rev01.png"), caption: [Wrapperklassen für primitive Datentypen])

#slide[
  #text(size: 22pt)[
- Primitiven Datentypen in String umwandeln
```java
	int a = 7; 
	Integer b = new Integer(a); 
	String c = b.toString();
```
- Kürzere Alternative über Klassenmethode:
```java
	String a = Integer.toString(7);
```
- String in primitiven Datentypen umwandeln:
```java
	String a = "7";
	int b = Integer.parseInt(a);
```
  ]
]

#slide[
  #text(size: 22pt)[
- Umwandlungen:
  - Boxing: Umwandlung primitiver Datentyp in Objekt einer Wrapperklasse
  - Unboxing: Umwandlung Objekt einer Wrapperklasse in primitiven Datentyp
```java
	Integer object = new Integer(24); //Boxing of int value
	int noObject = object.intValue(); //Unboxing of object
```

- Autoboxing: Automatische Umwandlungen (beide Richtungen)
```java
	Integer object = 24; //Automatic boxing of int value
	int noObject = object; //Automatic unboxing of object
```
  ]
]

#slide[
  #figure(image("../assets/img/2024_10_16_wrapper_conversion_rev01.png"), caption: [Typumwandlung mit Wrapperklassen])
]

== `Math`-Klasse

#slide[

- Mathematische Konstanten: Eulerzahl e, Kreiszahl $pi$
- Mathematische Funktionen (als Klassenmethoden), z.B.:
  - Trigonometrische Funktionen
  - Rundung
  - Betrag
  - Exponentialfunktion und Logarithmus
  - Maximum und Minimum
  - Wurzeln
  - Zufallszahlen

  #example[
    ```java
    double angleDeg = 127.5;
    double angleRad = Math.toRadians(angleDeg);
    System.out.printf("cos(%.2f) = %.2f\n", angleRad, Math.cos(angleRad));
    ```
  ]



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
