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
- Keine Zusammengestzen Datentypen in Java.
- Kein `unsigned` in Java.
- Speichergrößen sind festgelegt und garantiert.
- Zeichen werden mit 2 Byte kodiert.
  - 65.536 Zeichen können dargestellt werden anstatt von 256.
]
== Literale
#slide[
  #memo[Ein *Literal* ist eine konstante, unveränderliche Zahl oder Zeichenfolge, die
    direkt im Code steht.]
  - Wenn Sie also einen bestimmten Wert direkt in Code schreiben, verwenden Sie
    einen Literal.
  - Dieser wird dann nicht von einer Variablen repräsentiert.
]

#slide[
#question[Warum glauben Sie, dass der folgende Code nicht funktioniert?
```java
float point = 3.1416;
    ```
]
#pause
- Der Zahl ist eine feste Fließkommazahl, die von Java als *double* interpretiert
  wird.
- Wegen der Typkorrektheit wird der Wert nicht in eine *float* Variable
  gespeichert. Der Java Compiler gibt einen Fehler aus.
]

#slide[
#question[Wie würden Sie den Code korrigieren?]
#pause
- Sie können den Wert als *float* Literal schreiben:
```java
  float point = 3.1416f;
```
- Alternativ können Sie den Wert in eine *double* Variable speichern:
```java
  double point = 3.1416d;
```
]

== Konstanten

#slide[
- Wir haben gerade bereits das Beispiel der Kreiszahl $pi$ gehabt.
- In Java gibt es das Schlüsselwort ```final```, um Konstanten zu definieren.
- Diese können dann nicht mehr verändert werden.

```java
  final double PI = 3.1416;
```
- Nachdem eine Konstante deklariert wurde, kann sie nicht mehr verändert werden.
  Der folgende Code würde also einen Fehler erzeugen:

```java
  PI = 3;
```
]

== Konsolenausgaben erzeugen

#task[
Wir wollen jetzt einmal eine Konsolenausgabe erzeugen:
- Öffnen Sie IntelliJ IDEA und öffnen oder erstellen Sie eine neue ausführbare
  Klasse.
- Probieren Sie den folgenden Code:
```java
  int age = 24;
  System.out.println(24);
  System.out.println(age);
  ```
]
#task[
- Mithilfe des "+" Operators können Sie Text und Variablen kombinieren:

```java
  int age = 24;
  System.out.println("Mein Alter ist " + 24);
  System.out.println("Mein Alter ist " + age);
  ```
]
#tip[
- Geben Sie einmal in IntelliJ IDEA ```java sout``` ein und drücken Sie die
  Tab-Taste. Das spart Zeit beim Schreiben von ```java System.out.println()```!
]

== Coding Style

#question[Was ist ein *Coding Style*? Was sagt Ihnen der Begriff?]

#pause
- Der Coding Style ist eine Sammlung von Regeln, die bestimmen, wie Code
  geschrieben werden sollte.
- Einheitlicher Code ist leichter zu lesen und zu warten.

#memo[Die Einhaltung des Coding Styles wird in der Klausur bewertet!]

== Coding Style: Namenskonventionen

- Alle Namen, und das gilt für alle Bezeichner, sind in der englischen Sprache zu
  schreiben!
- Folgende Namenskonventionen sollten eingehalten werden:
  - Klassen: *CamelCase*
  - Methoden und Variablen: *camelCase*
  - Konstanten: *UPPER_CASE*
  - Pakete: *lowercase*

#tip[Aus meiner Erfahrung: Machen Sie Ihre Variablen so aussagekräftig wie möglich!
  Dann darf der Name auch länger sein.]

= Kommentare und Bezeichner

== Zeichensatz

- Wie bereits erwähnt, verwendet Java den Unicode-Zeichensatz.
- Das heißt, es sind mehr Zeichen möglich (65.536 um genau zu sein).
- So können Sie Ihre Kommentare ohne größere Einschränkungen auf Deutsch, Englisch
  oder Chinesisch schreiben.
- Ich würde Sie jedoch bitten, Ihre Kommentare in *Deutsch* oder *Englisch* zu
  verfassen.

#memo[Da Ihre Tastatur keine 65.536 Zeichen hat, können Sie die Zeichen auch kopieren
und einfügen. Alternativ für #emoji.face.grin:
```java
System.out.println("\u{1F600}");
```
]

== Kommentare

#slide[

  #question[Was denken Sie zu der folgenden Aussage? Warum sind Kommentare wichtig?]
  #quotation[
    #quote(attribution: [Viele Entwickler], block: true)[
      Den Code lesbar machen? Wer soll das denn sonst lesen?
    ]
  ]

]

#slide[

  - Kommentare sind wichtig, um den Code zu dokumentieren und die Wartbarkeit zu
    verbessern.
  - Sowohl Nutzer des Codes als auch die Entwickler werden den Code verstehen
    müssen. Dafür sind Kommentare unerlässlich.

  #memo[Nicht die Menge, sondern die Qualität der Kommentare ist entscheidend!
    Kommentieren Sie immer direkt während Sie auch programmieren!]
]

#slide[
#question[Was ist der Unterschied zwischen einem *Blockkommentar* und einem
  *Zeilenkommentar*?]
#pause
- *Zeilenkommentare* beginnen mit ```//``` und enden am Ende der Zeile.
- *Blockkommentare* beginnen mit ```/*``` und enden mit ```*/```.
]

#slide[
- Beispiel für einen Zeilenkommentar:
```java
  // Dies ist ein Zeilenkommentar
  int distance; // Euklidischer Abstand zwischen a und b
```
- Beispiel für einen Blockkommentar:
```java
  /* Die Berechnung des euklidischen Abstands läuft über folgende Schritte ab:
   1. Berechnung der Differenz der Koordinaten
   2. Quadrieren der Differenz
   ...  */
```
]

== Bezeichner

- Alle Dinge, die sie in Java benennen, werden als *Bezeichner* bezeichnet. Viele
  Dinge, die Sie schreiben brauchen einen Namen!

#memo[
- Beachten Sie folgende Regeln für Bezeichner:
  - Erlaubt sind Buchstaben, Zahlen, Unterstriche und Dollarzeichen.
  - Das erste Zeichen darf keine Zahl sein.
  - Groß- und Kleinschreibung wird unterschieden.
  - Keine Leerzeichen oder Schlüsselworte.
  - Nicht die Literale `true`, `false` oder `null`.
]

#slide[
- Alle reservierten Schlüsselworte in Java:
#align(
  center + horizon,
)[

#table(
  columns: 4, `abstract`, `double`, `int`, `super`, `assert`, `else`, `interface`, `switch`, `boolean`, `enum`, `long`, `synchronized`, `break`, `extends`, `native`, `this`, `byte`, `final`, `new`, `throw`, `case`, `finally`, `package`, `throws`, `catch`, `float`, `private`, `transient`, `char`, `for`, `protected`, `try`, `class`, `goto`, `public`, `void`, `const`, `if`, `return`, `volatile`, `continue`, `implements`, `short`, `while`, `default`, `import`, `static`, ``, `do`, `instanceof`, `strictfp`, ``,
)
]
]

#slide[

  #question[Welche der Bezeichner sind aus Ihrer Sicht erlaubt und warum?]

  ```java
    int length;
    int länge;
    int maxLength;
    int max_length;
    int _max_length;
    int max-length;
    int !maxLength;

    int 3dlength;
    String öpnvKosten;
    String €kosten;
    String kostenin€
    String €;
    int long;
    int c.o.s.t;
    String @cost;
  ```

]

= Operatoren

== Operatoren

- Es gibt die üblichen arithmetischen Operatoren. 
- Generell werden Operatoren auch von links nach rechts ausgewertet.

#figure(image("../assets/img/2024_10_08_arithmetische_operatoren_java_rev01.png"), caption: [Arithmetische Operatoren in Java])

== Inkrement und Dekrement

#slide[
- Es gibt auch die gleichen Operatoren zum Inkrementieren und Dekrementieren wie in C.

  #figure(image("../assets/img/2024_10_08_increment_decrement_operatoren_rev01.png"), caption: [Operatoren für das Inkrement und Dekrement in Java])
]

#slide[
  #question[Zum Mitdenken: Was wird hier auf der Konsole erscheinen?]

  ```java
  int a = 1;
	System.out.println("a   : " + a);
	System.out.println("++a : " + ++a);
	System.out.println("a++ : " + a++);
	System.out.println("--a : " + --a);
	System.out.println("a-- : " + a--);
  ```

]

== Logische Operatoren

- Es gibt auch die gleichen logischen Operatoren wie in C!

#figure(image("../assets/img/2024_10_08_boolean_operatoren_rev01.png"), caption: [Logische Operatoren in Java])

#slide[
  #question[Zum Mitdenken: Was passiert hier?]

  ```java
  int a = 7, b = 4;
	boolean parentheses = (a > b) == (a <= b);
	boolean priorities = a > b == a <= b;
	System.out.println(parentheses);
	System.out.println(priorities);
  ```
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
