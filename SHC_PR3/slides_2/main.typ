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

#figure(
  image("../assets/img/2024_10_08_arithmetische_operatoren_java_rev01.png"), caption: [Arithmetische Operatoren in Java],
)

== Inkrement und Dekrement

#slide[
  - Es gibt auch die gleichen Operatoren zum Inkrementieren und Dekrementieren wie
    in C.

    #figure(
      image("../assets/img/2024_10_08_increment_decrement_operatoren_rev01.png"), caption: [Operatoren für das Inkrement und Dekrement in Java],
    )
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

== Vergleichsoperatoren

- Es gibt auch die gleichen Vergleichsoperatoren wie in C!

#figure(
  image("../assets/img/2024_10_08_boolean_operatoren_rev01.png"), caption: [Vergleichsoperatoren in Java],
)

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

== Logische Operatoren

- Das Ergebnis der logischen Operatoren ist immer ein Wahrheitswert, der in Java
  als
  `boolean` dargestellt wird.

#figure(
  image("../assets/img/2024_10_09_logische_operatoren_rev01.png"), caption: [Logische Operatoren in Java],
)

#memo[
- Bei den logischen Operatoren wird der rechte Operand nicht ausgeführt, wenn das
  Ergebnis bereits feststeht. Im folgenden Beispiel wird `a` nicht ausgewertet.
- Beispiel: ```java (true || a)```
- Das nennt man dann *Short Circuit*.
- Wird dann interessant, wenn der rechte Operand bspw. eine Funktion/Methode ist.
]

#question[Wieder zum Mitdenken: Was passiert im folgenden Code?]

```java
int a = 3, b = 4;
System.out.println((++a == b) || (a++ > b));
System.out.println("a = " + a);
```

== Zuweisungsoperatoren

- Wie in C gitb es auch in Java Zuweisungsoperatoren. Diese können auch mit
  anderen Operatoren kombiniert werden.
- Der Platzhalter `<op>` steht unter anderem für `*, /, +` und `-`.

#figure(
  image("../assets/img/2024_10_09_zuweisungs_operatoren_rev01.png"), caption: [Zuweisungsoperatoren in Java],
)

#question[Ein letztes Mal: Was passiert in diesem Code?]

```java
int a = 1;
a += 2;
System.out.println(a);
System.out.println(a *= --a);
System.out.println(a *= -a++);
System.out.println(a /= 10);
```

= Typkonvertierung

== Typkonvertierung
- Zur Erinnerung: Typkorrektheit verhindert, dass Variablen einen Wert bekommen,
  der nicht ihrem Datentyp entspricht.
- Das verhindert Fehler und macht den Code sicherer.

#warning[Eine Variable, die vom Typ `int` ist passt allerdings in eine Variable vom Typ `byte`.
Wie können Sie den Wert in `byte` von trotzdem in eine `int` Variable speichern?]

#idea[Sie können einfach schreiben, dass Sie das explizit wollen!]

```java
int a = 80;
byte b = (byte) a;
System.out.println(b);
```

#slide[
#question[Was passiert in dem folgenden Code?]

```java
double a = 128.38;
int b = (int) a;
byte c = (byte) a;
System.out.println("double: " + a);
System.out.println("int   : " + b);
System.out.println("byte  : " + c);
```
]

#question[
Was passiert, wenn Sie den Wert von `128` in eine `byte` Variable speichern?
]

#pause

- Da der Datentyp ```byte``` nur Werte von `-128` bis `127` speichern kann, wird
  der Wert überlaufen.
- Das Ergebnis wird eine negative Zahl sein. In diesem Fall wird es `-128` sein.

== Implizite Typkonvertierung

#memo[
  - Prinzip der impliziten Typkonvertierung:
    - Kein Datenverlust bei Zuweisung von einem kleineren in einen größeren Typ.
    - Der Cast-Operator ist nicht notwendig.
    - Es erfolgt eine automatische Konvertierung.
]

#example[
- `short` (-32.768 bis 32.767) passt in `int` (-2.147.483.648 bis 2.147.483.647).
```java
short a = 71;
int b = (int) a;
int c = a;
```
]

#question[
  Zum Mitdenken: Welche der folgenden Zeilen werden kompilieren?
]
```java
short a = 1024;
long b = a;
float c = b;
```
#slide[
```java
char d = 'A';
short e = d;
int f = d;
```
]

#slide[

#align(
  left + horizon,
)[

  #figure(
    image("../assets/img/2024_10_09_implizite_typkonvertierung_rev01.png"), caption: [Implizite Typkonvertierung in Java],
  )
]

#memo[
- Ganzzahlen `char` und `short` besitzen jeweils 2 Byte, `char` ist aber ein
  *unsigned* Datentyp.
  - Wertebereich char: 0 bis 65.535
  - Wertebereich short: -32.768 bis 32.767
- Nicht alle long-Werte in float darstellbar (Potenzieller Datenverlust!).
]
]

= Kontrollstrukturen

== if-Anweisung

#memo[If-Anweisungen sind die einfachste Form der Kontrollstrukturen. Sie erlauben es,
  Anweisungen nur auszuführen, wenn eine Bedingung erfüllt ist.]

```java
if (Bedingung) {
  Anweisungen
}
```
#slide[
- Die Bedingung muss, anders als in C, immer ein `boolean` sein.
- Anwesungen werden nur ausgeführt, wenn die Bedingung wahr (`true`) ist.
- Bei nur einer Anweisung können die geschweiften Klammern weggelassen werden.
```java
int a = 4, b = 8;
  int maximum = a;

  if (b > maximum) {
    maximum = b;
  }
```
]

== if-else-Anweisung

Mittels einer `else`-Anweisung kann ein Block angegeben werden, der ausgeführt
wird, wenn die Bedingung nicht erfüllt ist.

```java
if (Bedingung) {
      Anweisungen 1
    } else {
      Anweisungen 2
    }
```

#slide[
Die Anweisung 2 im obigen Beispiel wird eben ausgeführt, wenn die Bedingung `false` ist.

```java
int a = 4, b = 8;
  int maximum;

  if (a > b) {
    maximum = a;
  } else {
    maximum = b;
  }
```

]

== Der ?-Operator

Für einfache Zuweisung mittels `if-else`-Anweisungen kann ein Ausdruck in dieser
Form verwendet werden:
```java
(Bedingung) ? Ausdruck 1 : Ausdruck 2;
```
- Bedinung `true`: Ausdruck 1 wird eingesetzt
- Bedingung `false`: Ausdruck 2 wird eingesetzt

```java
int a = 4, b = 8;
int maximum = (a > b) ? a : b;
```

== if-else-Anweisung

#task[
- Gegeben ist eine Ganzzahl `weekDay` zwischen 1 und 7.
- Es entspricht: 1 = Montag, 2 = Dienstag, 3 = Mittwoch usw.
Erzeugen Sie in Abhängigkeit des Wertes folgende Konsolenausgaben:
- Montag bis Freitag: "Arbeiten"
- Samstag: "Einkaufen"
- Sonntag: "Ausruhen"
]

#example[
```java
byte weekDay = 3;

  if (weekDay <= 5) {
    System.out.println("Arbeiten");
  } else if (weekDay == 6) {
    System.out.println("Einkaufen");
  } else if (weekDay == 7) {
    System.out.println("Ausruhen");
  }
```
]

== switch-Anweisung
Mit der `switch`-Anweisung lassen sich `if-else`-Anweisungen vereinfachen.
```java
switch (Ausdruck) {
    case Wert 1:
    Anweisungen
    break;
    case Wert 2:
    ...
    default:
    Anweisungen
    }
```
#slide[

- Ausdruck ist z.B. eine ganzzahlige Variable (außer Typ `long`) oder ein `String` (ab
  Java 7).
- Anweisungen, `break` und `default` sind optional.
- Mehrere `case`-Sprungmarken direkt hintereinander sind erlaubt.
- Sprung zu …
  - `case`-Sprungmarke, falls diese den Wert von Ausdruck hat
  - `default`, falls keine passende `case`-Sprungmarke
  - Ende des `switch`-Blocks, falls keine passende `case`-Sprungmarke und kein `default`
- Von `case`-Sprungmarke oder `default` weiter bis `break` oder Ende des
  `switch`-Blocks
]

#slide[
#task[Implementieren Sie eine Lösung für die Aufgabe 3 als `switch`-Anweisung]
]
#slide[
```java
switch (weekDay) {
  case 1:
  case 2:
  case 3:
  case 4:
  case 5:
      System.out.println("Arbeiten");
      break;
  case 6:
      System.out.println("Einkaufen");
      break;
  case 7:
      System.out.println("Ausruhen");
      break;
  default:
      System.out.println("Den Tag kenn' ich nicht ...");
  }
```
]

== while-Schleife

Mit der `while`-Schleife wird eine Anweisung so lange ausgeführt, wie die
Bedingung `true` ist.

```java
while (Bedingung) {
      Anweisungen
    }
```

- Falls die Bedingung zu Beginn bereits false ist, wird die Anweisung nie
  ausgeführt.
- Auch *kopfgesteuerte* oder *abweisende* Schleife genannt.

#slide[
  #align(left + horizon)[]
  #figure(
    image("../assets/img/2024_10_09_while_loop_rev01.png"), caption: [while-Schleife in Java],
  )
]

== do-while-Schleife

Mit der `do-while`-Schleife wird eine Anweisung mindestens einmal ausgeführt.
Wenn die Bedingung `true` ist, wird die Anweisung wieder ausgeführt.

```java
do {
      Anweisungen
    } while (Bedingung);
```

- Auch *fußgesteuerte* oder *nicht abweisende* Schleife genannt.

#align(
  left + horizon,
)[
  #figure(
    image("../assets/img/2024_10_09_dowhile_loop_rev01.png"), caption: [do-while-Schleife in Java],
  )
]

== for-Schleife

Mit der `for`-Schleife können Sie eine Anweisung eine bestimmte Anzahl von Malen
wiederholen.

```java
for (Init; Bedingung; Update) {
      Anweisungen
    }
```

- Falls Bedingung `false` ist, wird die Anweisung nie ausgeführt.
- Init wird nur einmal ausgeführt, dafür aber immer.
- Update wird nach jeder Iteration ausgeführt.
#align(
  left + horizon,
)[
  #figure(
    image("../assets/img/2024_10_09_for_loop_rev01.png"), caption: [for-Schleife in Java],
  )
]

== Sprunganweisungen

Mittels Sprunganweisungen können Sie den Programmfluss steuern. `break` beendet
die Schleife und `continue` springt zum nächsten Schleifendurchlauf.

#figure(
  image("../assets/img/2024_10_09_break_continue_loop_rev01.png"), caption: [Visualisierung von break und continue in Java],
)

#question[Was passiert in dem folgenden Code?]
```java
System.out.println("Break (bei i == 2):");
for (int i = 0; i <= 4; i++) {
  if (i == 2) {
    break;
  }
  System.out.println("  i = " + i);
}
```

#question[Was passiert in dem folgenden Code?]
```java
System.out.println("\nContinue (bei i == 2):");
for (int i = 0; i <= 4; i++) {
  if (i == 2) {
    continue;
  }
  System.out.println("  i = " + i);
}
```

== Coding Style

- Wie bereits erwähnt, ist der Coding Style wichtig. Daher gibt es bei den
  Kontrollstrukturen auch einen Coding Style.

- Öffnende geschweifte Klammern werden in der gleichen Zeile wie die
  Kontrollstruktur geschrieben (das gilt für alle öffnenden Klammern).
- Nach einer schließenden geschweiften Klammer wird ein Zeilenumbruch gemacht. Bei `else` steht
  die schließende Klammer in der gleichen Zeile.

#example[
```java
int a = 4, b = 8;
  int maximum;

  if (a > b) {
    maximum = a;
  } else {
    maximum = b;
  }
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
