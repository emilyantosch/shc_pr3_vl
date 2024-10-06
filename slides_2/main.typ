#import "@preview/touying:0.5.2": *
#import themes.university: *

#import "@preview/fletcher:0.5.1" as flechter: diagram, node, edge

#import "@preview/gentle-clues:1.0.0": *
#import "@preview/pinit:0.2.0": *
#import "@preview/codly:1.0.0": *
#show: codly-init.with()

#import "@preview/numbly:0.1.0": numbly

#set text(lang: "de")
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
    title: [Objektorientierte Programmierung in Java], subtitle: [Vorlesung 2 - Imperative Konzepte], author: [Emily Lucia Antosch], date: datetime.today().display("[day].[month].[year]"), institution: [HAW Hamburg],
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

- In der Einführung habe ich Ihnen einen Überblick über die Themen der
  bevorstehenden Vorlesung gegeben.
- Sie haben außerdem Ihr erstes Programm in Java geschrieben!

- Heute geht es um *Imperative Konzepte*.

#slide[
  1. *Imperative Konzepte*
  2. Klassen und Objekte
  3. Klassenbibliothek
  4. Vererbung
  5. Schnittstellen
  6. Graphische Oberflächen
  7. Ausnahmebehandlung
  8. Eingaben und Ausgaben
  9. Multithreading (Parallel Computing)
]

== Das Ziel dieses Kapitels

- Wir sprechen über imperative Konzepte in der Programmierung mit Java.
- Sie verstehen die einfachen Datentypen in Java.
- Sie steuern den Programmfluss mit Kontrollstrukturen und Schleifen.
- Sie wenden den korrekten Coding Style an.

= Einfache Datentypen

== Datentypen und Speicher

#slide[
  #question[Wie kann sich sein Program Zustand merken?]

  #pause

  - Variablen, die den Zustand im Speicher des Computers speichern.
  - Inhalt des Speichers auf dem Computer wird anhand des *Datentyps* interpretiert.

  #figure(
    image("../assets/img/2024_10_06_data_storage_rev01.png", height: 25%), caption: [Speicher im Computer mit Werten aus dem Programm],
  )
]
#slide[
  #question[Welche Datentypen kennen Sie schon aus C?]
  #pause
  - *int*, *char*, *float*, *double*
  - *struct*, *enum*, *union*
  - *void*, *bool*
  - *Arrays mit []* und *Zeiger mit \**
]

== Datentypen in Java

#slide[
  Folgende Datenstrukturen sind in Java verfügbar:

  #figure(
    image("../assets/img/2024_10_06_data_types_java_rev01.png", height: 70%), caption: [Datentypen in Java],
  )
]

#slide[
  - Speichergrößen und die entsprechenden Wertebereiche:

  #figure(
    image("../assets/img/2024_10_06_data_types_ranges_java_rev01.png"), caption: [Wertebereiche der Datentypen in Java],
  )
]
== Deklaration von Variablen

#memo[Variablen müssen deklariert werden, bevor sie benutzt werden können.]
- Ein Datentyp wird vor dem Variablennamen geschrieben.
- Eine Deklaration könnte so aussehen:
```java
int a;
float b;
char c;
```

== Initialisierung von Variablen
#memo[Im Anschluss an die Deklaration kann ein Wert zugewiesen werden. Das nennt man
  Initialisierung.]
- Der Variable wird mittels des Zuweisungsoperators ```=``` ein Wert zugewiesen:

```java
a = 5;
b = 3.5;
c = 'A';
```

== Definition von Variablen
#memo[Die Deklaration und Initialisierung kann auch in einem Schritt erfolgen. Das
  wird dann als Definition bezeichnet.]

- Beide Schritte werden direkt hintereinander geschreiben.
- Deklaration und Initialisierung (Definition):
```java
int a = 5;
float b = 3.5;
char c = 'A';
```
== Gültigkeitsbereich von Variablen

#slide[
  - Variablen haben einen Gültigkeitsbereich, der durch die geschweiften Klammern
    definiert wird.
  - Variablen können an beliebiger Stelle im Code deklariert werden.
  - Der Compiler verhindert die Verwendung von Variablen, die nicht initialisiert
    wurden.
]

== Typkorrektheit

#slide[

- Typen müssen korrekt sein, um Fehler zu vermeiden.
  - Anders als in C müssen Werte dem korretem Datentyp zugewiesen werden.
  - Folgendes würde nicht funktionieren:

```java
int a = 5;
float b = apin1;
```

#pinit-rect-from(height: 2em, pos: bottom, fill: rgb(0, 180, 255), 1)[Inkorrekter Typ]
]
#slide[
  #question[Welche Unterschiede sehen Sie zwischen C und Java, wenn es um Datentypen geht?]
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
