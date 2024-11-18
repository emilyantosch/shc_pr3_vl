#import "@preview/touying:0.5.2": *
#import themes.university: *

#import "@preview/fletcher:0.5.1" as flechter: diagram, node, edge

#import "@preview/tiaoma:0.2.1"

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
    title: [Objektorientierte Programmierung in Java], subtitle: [Vorlesung 1 - Organisation und Einführung], author: [Emily Lucia Antosch], date: datetime.today().display("[day].[month].[year]"), institution: [HAW Hamburg],
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

= Organisation

== Das Ziel dieses Kapitels

- Ich will mich bei Ihnen vorstellen und mit Ihnen den Ablauf dieses Moduls
  besprechen.
- Sie bekommen einen Überblick über die Voraussetzungen in diesem Modul und können
  diese erfüllen.
- Sie wissen, wie sich mich erreichen können.

== Kurz zu mir

- Emily Lucia Antosch, 24 Jahre alt
- Bachelor in Elektro- und Informationstechnik
- Zurzeit tätig als Anwendungsentwicklerin bei NVL
- Nächste Station: Masterstudium Informatik
- Mail: emilylucia.antosch\@haw-hamburg.de

#info[Ich mach das zum ersten Mal, seien Sie also bitte nachsichtig.]
== Vorlesungsablauf

- Vorlesungen teilen sich in Termine am Dienstag und Donnerstag auf.
  - Am Anfang sind sehr viele Termine, die Sie auf das Praktikum vorbereiten sollen.
- Ich würde Sie bitten, sich an der Vorlesung aktiv zu beteiligen.
- Es wird kleine Fragen und Aufgaben geben, die Sie live beantworten und
  mitprogrammieren können.

#memo[Falls Sie etwas nicht verstehen, fragen Sie bitte sofort! Ich wiederhole gerne
  Inhalte auf Deutsch oder Englisch!]

== Vorlesungsfokus

- Wir wollen hier eine Brücke aus Ihren Vorkenntnissen bauen.
- Am Ende der Vorlesung sollten Sie in der Lage sein, in Java einfache Programme
  zu erstellen.
- Außerdem sollten Sie dann Objektorientierte Programmierung beherrschen und die
  Unterschiede zu anderen Paradigmen in der Programmierung herausstellen können.
- Den genauen Stoff können Sie außerhalb der Vorlesung auch im Modulhandbuch
  nachlesen.

== Vorraussetzungen

- Sie brauchen eine Installation des *Java SDK*.
  - Dafür habe ich Ihnen eine Anleitung geschrieben, die Sie im Moodle-Raum bzw.
    SHCneo-Raum finden.
- Außerdem wird die Vorlesung mit dem Tool *JetBrains IntelliJ* sein.
  - Dies ist, wie ich finde, eine sehr gute und einfache IDE für den Anfang.
  - Auch hierfür finden Sie eine Anleitung im Moodle.

= Einführung

== Das Ziel dieses Kapitels

- Sie sollen ihr bekanntes Wissen aus vorhergehenden Vorlesungen auf neue Inhalte
  anwenden.
- Sie kennen die grundlegenden Ideen der Objektorientierten Programmierung und
  kennen den Unterschied zu der Programmierung in C.
- Wir erstellen ein einfaches Programm in der Entwicklungsumgebung Intellij IDEA
  und führen dieses aus.

== Themenübersicht: Grundlagen

Die ersten Vorlesungen beziehen sich auf die folgenden Prinzipien:

1. Imperative Konzepte
2. Klassen und Objekte
3. Klassenbibliothek
4. Vererbung
5. Schnittstellen

== Themenübersicht: Weiterführende Konzepte

Aus den Grundlagen wollen wir dann weitere Konzepte ableiten:

6. Graphische Oberflächen
7. Ausnahmebehandlung
8. Eingaben und Ausgaben
9. Multithreading (Parallel Computing)

== Objekte und Klassen

In der echten Welt werden oft Dinge über ihre Eigenschaften bestimmt und
beschrieben:

- Ein Auto hat Eigenschaften wie
  - einen Hersteller
  - eine Farbe
  - einen Verbrauch

#idea[Mithilfe der Objektorientierten Programmierung können wir diesen intuitiven
  Ansatz auch bei der Programmierung anwenden!]
#slide[

  #question[Über welche Eigenschaften könnten Sie zum Beispiel eine Person beschreiben? Wie
    passt das vielleicht in den Programmierungskontext?]

  #pause
  - Für Studenten:
    - Name, Anschrift, Immatrikulationsnummer
  - Für Programme/Webseiten:
    - Username, Passwort, Beitrittsdatum
]

- Um aus diesem ähnlichen Bauplan dann mehrere gleichartige Objekte zu erstellen,
  wird eine Klasse erstellt,
  - Sie enthält alle Eigenschaften, die wir gerade definiert haben, also zum
    Beispiel Variablen.
  - Aus ihr lassen sich ganz verschiedene Objekte erstellen, die diese Eigenschaften
    unterschiedlich gefüllt haben.

#example[Aus der Klasse *Student* lassen sich zum Beispiel die beiden Studenten *Max* und
  *Ines* erstellen, die beide unterschiedlich heißen und eine eigene
  Immatrikulationsnummer haben.]
#slide[
  #align(
    center + horizon,
  )[
    #figure(
      diagram(
        spacing: (100mm, 40mm), node-stroke: luma(80%), node((0.5, 0), [*Klasse Person*], name: <d>), node((0, 1), [*Ines*], name: <n>), node((1, 1), [*Max*], name: <e>), edge(<d>, ((), "|-", (0, 0.5)), ((), "-|", <n>), <n>, "-|>"), edge(<d>, ((), "|-", (0, 0.5)), ((), "-|", <e>), <e>, "-|>"), edge(
          <e>, "<|-|>", <n>, stroke: teal, label: text(teal)[Gleiche Klasse, anderes Objekt], left,
        ), edge(
          (rel: (-25pt, 0pt), to: <n>), <d>, "-|>", bend: 40deg, stroke: orange, text(orange)[Objekt der Klasse], label-angle: auto,
        ),
      ), caption: [Relation zwischen Klassen und Objekten dieser Klasse],
    )
  ]
]

- Variablen und Funktionen werden also zu einer Klasse zusammengefasst.
  - Es wird eine Menge an Variablen definiert.
  - Für diese Variablen werden wiederum Funktionen eingeführt, die diese lesen und
    ändern können.

#memo[
  - Variablen werden als *Attribute* bezeichnet.
  - Die Werte dieser Variablen beschrieben den *Zustand* des Objekts.
  - Funktionen werden als *Methoden* bezeichnet.
]

- Über sogennante UML Klassendiagramme lassen sich Klassen mit ihren *Attributen*
  und *Methoden* beschreiben.

#figure(
  image("../assets/img/2024_10_03_class_person_explain_rev01.png"), caption: [UML Klassendiagramm],
)

== Datenkapselung

- Mithilfe von Attributen und Methoden von Klassen lassen sich Daten kapseln.

#figure(
  image("./../assets/img/2024_10_03_data_capsulation_rev01.png", width: 80%), caption: [Datenkapselung durch Klassen],
)<data-capsule>

- Mithilfe von Attributen und Methoden von Klassen lassen sich Daten kapseln.
  - Auf gekapselte Daten können nicht alle Teile des Programms zugreifen, was die
    Sicherheit erhöht.
  - Außerdem lassen sich so Attribute vor fehlerhaften Werten schützen.

#slide[
  #figure(image("../assets/img/2024_10_04_data_capsulation_checks_rev01.png"))
]

#slide[
  #question[Wie ist das im Gegensatz dazu in C?]

  #pause
  - Die Datenstruktur (also das *struct*) muss für den Zugriff auf die Elemente
    öffentlich gemacht werden.
  - Die Daten werden nicht geschützt.
  - Es gibt keine Zuordnung zwischen den Daten und den Funktionen.
]

== Vererbung

#slide[
  - Durch Vererbung lassen sich neue Klassen aus anderen Klassen erzeugen.

  #figure(
    image("../assets/img/2024_10_04_class_inheritance_rev01.png", width: 35%),
  )

]

#slide[
  - Durch Vererbung lassen sich neue Klassen aus anderen Klassen erzeugen.
  - Dabei werden die Methoden und Attribute der Basisklasse übernommen und um
    weiteren Code erweitert.
  - Keine duplizierter Code.
]

#matrix-slide[
  #align(
    left + top,
  )[
    - Klassen können auch durch andere Klassen zusammengesetzt sein.
    - Sowas nennt man dann *Komposition*.
    - So wäre zum Beispiel die Klasse *Haus* zusammengesetzt aus zum Beispiel
      *Fenstern*, *Wänden* und *Türen*.

  ]
][
  #figure(
    image("../assets/img/2024_10_04_class_composition_rev01.png", height: 80%), caption: [Komposition der Klasse *Haus*, die von *Gebäude* erbt],
  )
]

== Ablauf eines Programms in Java

1. Bei Programmstart wird eine besondere Methode *main* im _Hauptobjekt_ ausgeführt.
2. In dieser Methode werden dann Objekte erzeugt und die *Referenzen* auf diese
  Objekte in Variablen gespeichert.
3. Über diese Variablen kann dann auf das jeweilige Objekt zugegriffen werden.
4. Objekte in dem Programm können dann wiederum weitere Objekte erzeugen und
  Methoden aufrufen.
5. Sobald die *main*-Methode beendet wurde, endet das Programm.

#figure(
  image("../assets/img/2024_10_05_references_java_program_rev01.png"), caption: [Referenzen in der Lebenszeit eines Programms],
)

= Die Programmiersprache Java

== Java vs. C

#slide[
  #task[Lassen Sie uns erst einmal ein paar einfache Aufgaben in der Programmiersprache
    C schreiben:
    - Summe der Zahlen 1 bis n über *for*-Schleife.
    - Maximum zweier Zahlen über *if*-Anweisung.
    - Maximum zweier Zahlen über die Funktion *getMax()* bestimmen.
  ]
]

- Ich habe gute Nachrichten: Diesen Code hätten Sie auch in Java problemlos
  ausführen können!
- Die *Syntax*, also die Schlüsselworte und der Aufbau der Sprache, ist sehr nahe
  an C und C++!
- Deshalb wollen wir auf Ihre Vorkenntnis weiter aufbauen.

#figure(
  image("../assets/img/2024_10_04_java_origin_rev01.png", height: 40%), caption: [Die Einflüsse auf die Programmiersprache Java],
)

== Kompilieren

1. Entwicklung
  - Quelltext wird am PC geschrieben.
  - Compiler kompiliert Quelltext in einen *Bytecode*.
2. Ausführung
  - Bytecode wird auf *JVM* (Java Virtual Machine) ausgeführt.
  - Ausführung benötigt keine neue Kompilierung für die jeweilige Zielplatform.

#slide[
  #align(
    left + horizon,
  )[
    #figure(
      image("../assets/img/2024_10_04_jvm_principle_rev01.png"), caption: [Die Ausführung eines Programms mit der JVM],
    )
  ]
]

#slide[

  - Unterschiede in anderen Programmiersprachen, die kompiliert oder interpretiert
    sind:
    - *Kompilierte Sprachen* müssen für jede Zielplattform neu kompiliert werden.
    - *Interpretierte Sprachen* müssen durch einen eigenen Interpreter auf der
      Zielplattform selbst interpretiert werden.
]

#slide[
  #align(
    left + horizon,
  )[

    #figure(
      image("../assets/img/2024_10_04_interpreted_lang_principle_rev01.png"), caption: [Ausführung von kompilierten Sprachen],
    )
  ]
]
#slide[
  #align(
    left + horizon,
  )[

    #figure(
      image("../assets/img/2024_10_04_compiled_lang_principle_rev01.png"), caption: [Ausführung von interpretierten Sprachen],
    )
  ]

]

== Eigenschaften von Java

#question[Wenn Sie eine neue Sprache entwicklen könnten, was wäre Ihnen wichtig? Was
  würden Sie an C/C++ ändern?]
#pause
- Java
  - Objektorientierte Sprache (also Klassen, Objekte und Vererbung)
  - Plattformunabhängig (über *JVM*)
  - Stark typisiert (feste Typen wie *int* und *String*)
  - Robust (also Garbage Collector)

#slide[
  #question[Welches ist die bessere Programmiersprache: C oder Java?]
]

= Das erste Programm

== IDE

- Ich würde Ihnen IntelliJ IDEA von JetBrains als IDE empfehlen.
  - Dieses Tool wird auch in der Klausur verwendet werden.
  - Die IDE enthält auch das Java JDK, was sie zum Programmieren brauchen.
#align(
  center + horizon,
)[
  #tiaoma.barcode(
    "https://www.jetbrains.com/idea/download/?section=windows", "QRCode", options: (scale: 3.0),
  )
]
- Wählen Sie die Community Edition auf #link("https://www.jetbrains.com/idea/download/?section=windows"),
  oder scannen Sie den QR-Code.
#slide[
  #align(
    left + horizon,
  )[

    #figure(
      image("../assets/img/2024_10_03_jdk_jre_compiler_rev01.png"), caption: [Der Aufbau der Java Toolchain#footnote(numbering: "*")[Application Programming Interface]],
    )
  ]
]

#task[
  - Vorbereitung:
    1. Öffnen Sie zuerst ein Verzeichnis, in dem Sie die Dateien zu Programmieren
      ablegen werden.
    2. Öffnen Sie IntelliJ IDEA.
  - Projekt anlegen:
    1. File > New > Project auswählen.
    2. Vergeben Sie einen Namen und einen Ort.
    3. Wählen Sie Java und IntelliJ und das entsprechende JDK
    4. Auf "Create" klicken
]

#slide[
  #task[
    - Paket erstellen
      1. Rechtsklick auf src
      2. New > Package auswählen
      3. Name eintragen
    - Klasse erstellen
      1. Rechtsklick auf Paket
      2. New > Java Class wählen
  ]
]

== Das erste Programm
#align(
  left + horizon,
)[

```java
public static void main(String[] args){
  System.out.println("Hello World!");
}
```
#idea[Tragen Sie den Code in die gerade erstellte Datei ein. Wenn Sie schon soweit
  sind, programmieren Sie gerne mit!]
]

== Anwendungen in Java

Eine Java-Datei kann ausgeführt werden, wenn sie eine öffentliche (*public*)
Klasse hat: ```java public class MyApplication {...}``` \

#pause

Die Klasse muss außerdem den gleichen Namen wie die Datei haben, also bspw.
`MyApplication.java` \

#pause

Die Klasse besitzt die Methode: ```java public static void main(String[] args)``` \

#slide[
//#align(left + horizon)[
#v(3.5em)
```java
  public class pin1MyApplipin3cationpin2 {
    public static void pin4mapin5in(String[] args) {
      System.out.println("Hello World!");
  }
}
```
#pause
#pinit-rect-from(3, pos: top)[Dieser Name ist frei wählbar.]
#pause
#pinit-rect-from(
  5, pos: bottom, fill: rgb(180, 10, 10),
)[Diese Methode muss immer main heißen.]
//]
]
= Literatur
== Literaturempfehlungen
- Einige Bücher, die Ihnen vielleicht im Verlauf der Veranstaltung helfen könnten:
  - D. Abts: Grundkurs JAVA, Springer-Vieweg
  - H.-P. Habelitz: Programmieren lernen mit Java, Rheinwerk Computing

= License Notice

== Attribution

- This work is shared under the CC BY-NC-SA 4.0 License and the respective Public
  License
- #link("https://creativecommons.org/licenses/by-nc-sa/4.0/")
- This work is based off of the work Prof. Dr. Marc Hensel.
- Some of the images and texts, as well as the layout were changed.
- The base material was supplied in private, therefore the link to the source
  cannot be shared with the audience.
