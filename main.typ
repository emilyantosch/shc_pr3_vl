#import "@preview/touying:0.5.2": *
#import themes.university: *
#import "@preview/gentle-clues:1.0.0": *

#import "@preview/codly:1.0.0": *
#show: codly-init.with()
#import "@preview/numbly:0.1.0": numbly

#set text(lang: "de")

#show: university-theme.with(
  aspect-ratio: "16-9",
  config-info(
    title: [Objektorientierte Programmierung in Java],
    subtitle: [Vorlesung 1 - Einführung],
    author: [Emily Lucia Antosch],
    date: datetime.today().display("[day].[month].[year]"),
    institution: [HAW Hamburg],
    logo: emoji.school,
  ),
)

#codly(
  languages: (
    java: (
    name: text(font: "JetBrainsMono NFM", " Java", weight: "bold"),
    icon: text(font: "JetBrainsMono NFM", "\u{e738}", weight: "bold"),
    color: rgb("#CE412B")
    )
  )
)

#set heading(numbering: numbly("{1}.", default: "1.1"))

#title-slide(authors: ([Emily Lucia Antosch]))

#outline()

= Organisation

== Mein Lebenslauf

#align(left + horizon)[


- Emily Lucia Antosch, 24 Jahre alt
- Bachelor in Elektro- und Informationstechnik
- Zurzeit tätig als Anwendungsentwicklerin bei NVL
- Nächste Station: Masterstudium Informatik

- Ich mach das zum ersten Mal, seien Sie also bitte nachsichtig
]
== Vorlesungsablauf

- Vorlesungen teilen sich in Termine am Dienstag und Donnerstag auf
  - Am Anfang sind sehr viele Termine, die Sie auf das Praktikum vorbereiten sollen
- Ich würde Sie bitten, sich an der Vorlesung aktiv zu beteiligen
- Es wird kleine Fragen und Aufgaben geben, die Sie live beantworten und mitprogrammieren können

#memo[Falls Sie etwas nicht verstehen, fragen Sie bitte sofort! Ich wiederhole gerne Inhalte auf Deutsch oder Englisch!]

== Vorlesungsfokus

- Den genauen Stoff können Sie außerhalb der Vorlesung auch im Modulhandbuch nachlesen
- Wir wollen hier eine Brücke aus Ihren Vorkenntnissen bauen.

== Vorraussetzungen

- Sie brauchen eine Installation des Java SDKs.
  - Dafür habe ich Ihnen eine Anleitung geschrieben, die Sie im Moodle-Raum finden.
- Außerdem wird die Vorlesung mit dem Tool JetBrains Intellij sein. 
  - Dies ist, wie ich finde, eine sehr gute und einfache IDE für den Anfang.
  - Auch hierfür finden Sie eine Anleitung im Moodle.
   
== Das erste Programm

#align(left + horizon)[
```java
public static void main(String[] args){
  System.out.println("Hello World!");
}
```
#idea[Wenn Sie schon soweit sind, programmieren Sie gerne mit!]
]
