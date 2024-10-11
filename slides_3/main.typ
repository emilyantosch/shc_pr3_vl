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
    title: [Objektorientierte Programmierung in Java], subtitle: [Vorlesung 3 - Klassen und Objekte], author: [Emily Lucia Antosch], date: datetime.today().display("[day].[month].[year]"), institution: [HAW Hamburg],
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

- Zuletzt haben wir uns mit den imperativen Konzepten der Programmiersprache Java
  beschäftigt.
- Sie können nun
  - einfache Datentypen in Java verwenden,
  - den Programmfluss mit Kontrollstrukturen und Schleifen steuern und
  - Datentypen konvertieren.
- Heute geht es um *Klassen und Objekte*.

#slide[
  1. Imperative Konzepte
  2. *Klassen und Objekte*
  3. Klassenbibliothek
  4. Vererbung
  5. Schnittstellen
  6. Graphische Oberflächen
  7. Ausnahmebehandlung
  8. Eingaben und Ausgaben
  9. Multithreading (Parallel Computing)
]

== Das Ziel dieses Kapitels

- Sie implementieren Klassen und Objekte in Java, um reale Dinge abzubilden.
- Sie erzeugen Objekte einer Klasse und ändern deren Zustand über Operationen.
- Sie wenden zusätzliche Programmierrichtlinien an, um die Qualität und die
  Wartbarkeit Ihres Codes zu verbessern.

= Klassen und Objekte

== Klasse

  - Eine *Klasse* ist ein Bauplan für Objekte. Sie enthält
    - *Attribute* (Datenfelder) und
    - *Methoden* (Operationen).
  - Zusammen heißen Attribute und Methoden *Members*.

#align(
  left + horizon,
)[

  #figure(
    image("../assets/img/2024_10_03_class_person_explain_rev01.png", height: 50%), caption: [UML-Notation einer Klasse Person],
  )
]

#slide[
    - Zur Laufzeit im Speicher erzeugter Datensatz einer Klasse
    - Variablen beschreiben *Zustand* des Objekts
    - Methoden beschreiben *Fähigkeiten* des Objekts
    - Bezeichnungen für Variablen: *Attribute*, *Objektvariablen*, *Instanzvariablen*

  #figure(
    image("../assets/img/2024_10_10_klassen_methoden_attribute_rev01.png", height: 45%), caption: [Aufteilung Methoden und Attribute],
  )
]
== Zusammenhang Klasse und Objekt

- Klasse: Beschreibung („Bauplan“) eines Datentyps
- Objekt einer Klasse: Erzeugtes Element des Datentyps
- Es können beliebig viele Objekte einer Klasse erzeugt werden.

#figure(image("../assets/img/2024_10_10_klassen_mehr_objekte_rev01.png", height: 60%), caption: [Mehrere Objekte aus einer Klasse])

== Klassen in Java

- Klassen können über den folgenden Code deklariert werden:
```java
class Klassenname {
		Attribute
		Methoden
	  }
```

#tip[Legen Sie jede Klasse in einer eigenen Datei an!]

== Beispiel: Einfache Klasse

#task[Lassen Sie uns diese einfache Klasse erstellen:
- Klasse Student, beschrieben durch Name, Matrikelnummer und Studienbeginn (in Jahren)
]

#pause

```java
class Student {
		String name;
		int matrNumber;
		int enrolledYear;
	}
```

- Die Klasse hat weder Methoden noch eine Datenkapselung gegen Einfluss von außen.

#figure(image("../assets/img/2024_10_10_klassen_uml_student_rev01.png"), caption: [UML-Darstellung der Klasse, die wir eben erstellt haben])

== Beispiel: Eine Klasse, viele Objekte

- Klasse („Eine Klasse für alle Studierenden“):
  - Die Klasse ist ein neuer Datentyp.
  - Legt fest, durch welche Daten Studierende beschrieben werden

- Objekte („Für jede/n Studierende/n ein eigenes Objekt“):
  - Objekte sind Instanzen im Speicher.
  - Besitzen Struktur der Klasse, sind aber mit Daten gefüllt
  - Es können beliebig viele Objekte erzeugt werden.

#figure(image("../assets/img/2024_10_10_klassen_mehr_objekte_uml_rev01.png"), caption: [Aus einer Klasse lassen sich mehrere Objekte erstellen])

== Beispiel: Lokale Variablen

#slide[
#question[Welche Werte haben die Variablen `count`, `jan` und `lena`?]

```java
public class StudentDemo {
		public static void main(String[] args) {
		    int count;
		    Student lena, jan;
		}
	}
```
]

#slide[
  #question[Welche Werte haben die Variablen `count`, `jan` und `lena`?]
  #figure(image("../assets/img/2024_10_10_klassen_primitiv_erklaerung_rev01.png", height: 50%), caption: [Primitive Datentypen vs. Objekte])
]

== Beispiel: `new`-Operator
#slide[
- Objekte werden durch den `new`-Operator erzeugt.
  ```java
public class StudentDemo {
	  public static void main(String[] args) {
		    int count;
		    Student lena, jan;
		    lena = pin1nepin2wpin3 Student();
		}
}
```
#pinit-rect-from(2, [`new`-Operator])
#pinit-highlight(1,3)

]

#slide[
- Schritt 1: `new`-Operator erzeugt Objekt.
  - Speicherplatz für Objekt (mit Objektvariablen) reservieren.
  - Objektvariablen mit Standardwerten initialisieren (mehr dazu gleich).


  #figure(image("../assets/img/2024_10_10_klassen_primitv_vergleich.png"), caption: [Erstellen von Referenz mit `new`])

]

#slide[
- Schritt 2: Zuweisung
  - Schreibt Referenz ("Adresse") des neuen Objekts in Variable `lena`.
  - Ist unabhängig vom `new`-Operator und der Erzeugung des Objekts

  #figure(image("../assets/img/2024_10_10_klassen_primitiv_zuordnung_rev01.png"), caption: [Zuweisung von Referenz an Variable])
]

= Variablen und Speicher

== Zielsetzung

#conclusion[
- Das haben wir uns bereits angeschaut:
  - Was sind Klassen und Objekte?
  - Wie deklariert man Klassen?
  - Wie erzeugt man Objekte?
]

- Im Folgenden wollen wir uns folgende Aspekte anschauen:
  - Zugriff auf Objektvariablen
  - Initialisierung von Objektvariablen
  - Zuweisung von Referenzen
  - Automatische Speicherbereinigung

== Zugriff auf Objektvariablen

- Zugriff auf Objektvariablen erfolgt mittels des Punkt-Operators:
```java
Objektreferenz.Member
```
- Dabei ist die `Objektreferenz` eine Referenz auf ein Objekt, die in einer Variable gespeichert ist.
- `Member` ist z.B. ein Attribut/Objektvariable

= License Notice

== Attribution

- This work is shared under the CC BY-NC-SA 4.0 License and the respective Public
  License
- #link("https://creativecommons.org/licenses/by-nc-sa/4.0/")
- This work is based off of the work Prof. Dr. Marc Hensel.
- Some of the images and texts, as well as the layout were changed.
- The base material was supplied in private, therefore the link to the source
  cannot be shared with the audience.
