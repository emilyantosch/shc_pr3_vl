#import "@preview/touying:0.5.2": *
#import themes.university: *

#import "@preview/fletcher:0.5.1" as flechter: diagram, node, edge

#import "@preview/gentle-clues:1.0.0": *
#import "@preview/pinit:0.2.0": *
#import "@preview/codly:1.0.0": *
#show: codly-init.with()

#import "@preview/numbly:0.1.0": numbly

#set text(lang: "de")

#show: university-theme.with(
  aspect-ratio: "16-9",
  config-info(
    title: [Objektorientierte Programmierung in Java],
    subtitle: [Vorlesung 1 - Organisation und Einführung],
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
    color: rgb("#CE412B")
    ),
    c: (
      name: text(font: "JetBrainsMono NFM", " C", weight: "bold"),
      icon: text(font: "JetBrainsMono NFM", "\u{e61e}", weight: "bold"),
      color: rgb("#5612EC")
  
  
)
  )
)

#set heading(numbering: numbly("{1}.", default: "1.1"))

#set align(left + top)

#title-slide(authors: ([Emily Lucia Antosch]))

#align(left + top)[

#outline()
]

= Organisation

== Das Ziel dieses Kapitels

- Ich will mich bei Ihnen vorstellen und mit Ihnen den Ablauf dieses Moduls besprechen.
- Sie bekommen einen Überblick über die Voraussetzungen in diesem Modul und können diese erfüllen.
- Sie wissen, wie sich mich erreichen können.

== Kurz zu mir

- Emily Lucia Antosch, 24 Jahre alt
- Bachelor in Elektro- und Informationstechnik
- Zurzeit tätig als Anwendungsentwicklerin bei NVL
- Nächste Station: Masterstudium Informatik
- Mail: emilylucia.antosch\@haw-hamburg.de

#info[Ich mach das zum ersten Mal, seien Sie also bitte nachsichtig.]
== Vorlesungsablauf

- Vorlesungen teilen sich in Termine am Dienstag und Donnerstag auf
  - Am Anfang sind sehr viele Termine, die Sie auf das Praktikum vorbereiten sollen
- Ich würde Sie bitten, sich an der Vorlesung aktiv zu beteiligen
- Es wird kleine Fragen und Aufgaben geben, die Sie live beantworten und mitprogrammieren können

#memo[Falls Sie etwas nicht verstehen, fragen Sie bitte sofort! Ich wiederhole gerne Inhalte auf Deutsch oder Englisch!]

== Vorlesungsfokus

- Wir wollen hier eine Brücke aus Ihren Vorkenntnissen bauen.
- Am Ende der Vorlesung sollten Sie in der Lage sein, in Java einfache Programme zu erstellen.
- Außerdem sollten Sie dann Objektorientierte Programmierung beherrschen und die Unterschiede zu anderen Paradigmen in der Programmierung herausstellen können.
- Den genauen Stoff können Sie außerhalb der Vorlesung auch im Modulhandbuch nachlesen

== Vorraussetzungen

- Sie brauchen eine Installation des *Java SDK*.
  - Dafür habe ich Ihnen eine Anleitung geschrieben, die Sie im Moodle-Raum finden.
- Außerdem wird die Vorlesung mit dem Tool *JetBrains IntelliJ* sein. 
  - Dies ist, wie ich finde, eine sehr gute und einfache IDE für den Anfang.
  - Auch hierfür finden Sie eine Anleitung im Moodle.

= Einführung

== Das Ziel dieses Kapitels

- Sie sollen ihr bekanntes Wissen aus vorhergehenden Vorlesungen auf neue Inhalte anwenden.
- Sie kennen die grundlegenden Ideen der Objektorientierten Programmierung und kennen den Unterschied zu der Programmierung in C.
- Wir erstellen ein einfaches Programm in der Entwicklungsumgebung Intellij IDEA und führen dieses aus.


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

In der echten Welt werden oft Dinge über ihre Eigenschaften bestimmt und beschrieben:

- Ein Auto hat Eigenschaften wie 
  - einen Hersteller
  - eine Farbe
  - einen Verbrauch

#idea[Mithilfe der Objektorientierten Programmierung können wir diesen intuitiven Ansatz auch bei der Programmierung anwenden!]

#question[Über welche Eigenschaften könnten Sie zum Beispiel eine Person beschreiben? Wie passt das vielleicht in den Programmierungskontext?]

- Für Studenten:
  - Name, Anschrift, Immatrikulationsnummer
- Für Programme/Webseiten:
  - Username, Passwort, Beitrittsdatum

- Um aus diesem ähnlichen Bauplan dann mehrere gleichartige Objekte zu erstellen, wird eine Klasse ertellt, 
  - Sie enthält alle Eigenschaften, die wir gerade definiert haben, also zum Beispiel Variablen
  - Aus ihr lassen sich ganz verschiedene Objekte erstellen, die diese Eigenschaften unterschiedlich gefüllt haben

#example[Aus der Klasse *Student* lassen sich zum Beispiel die beiden Studenten *Max* und *Ines* erstellen, die beide unterschiedlich heißen und eine eigene Immatrikulationsnummer haben.]

#align(center + horizon)[
#diagram(
spacing: (100mm, 40mm),
	node-stroke: luma(80%),
	node((0.5,0), [*Klasse Person*], name: <d>),
	node((0,1), [*Ines*], name: <n>),
	node((1,1), [*Max*], name: <e>), 

	edge(<d>, ((), "|-", (0,0.5)), ((), "-|", <n>), <n>, "-|>"),
	edge(<d>, ((), "|-", (0,0.5)), ((), "-|", <e>), <e>, "-|>"),




	edge(<e>, "<|-|>", <n>, stroke: teal, label: text(teal)[Gleiche Klasse, anderes Objekt], left),

	edge((rel: (-25pt, 0pt), to: <n>), <d>, "-|>", bend: 40deg, stroke: orange, text(orange)[Objekt der Klasse], label-angle: auto)

)
]
== Das erste Programm

#align(left + horizon)[
```c
int main (){
  printf("Hello World!");
  return 0;
}
```

```java
public static void main(String[] args){
  System.out.println("Hello World!");
}
```
#idea[Wenn Sie schon soweit sind, programmieren Sie gerne mit!]
]
