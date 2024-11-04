#import "@preview/grape-suite:1.0.0": exercise, german-dates

#set text(lang: "de")

#import "@preview/codly:1.0.0": *
#show: codly-init.with()

#codly(
  languages: (
    java: (
      name: text(font: "JetBrainsMono NFM", " Java", weight: "bold"), icon: text(font: "JetBrainsMono NFM", "\u{e738}", weight: "bold"), color: rgb("#CE412B"),
    ), c: (
      name: text(font: "JetBrainsMono NFM", " C", weight: "bold"), icon: text(font: "JetBrainsMono NFM", "\u{e61e}", weight: "bold"), color: rgb("#5612EC"),
    ),
  ),
)

#show: exercise.project.with(
title: "Praktikum 1 - Namensverwaltung mit Java",

    university: [HAW Hamburg],
    institute: [Fakultät TI - SHC],
    seminar: [OOP],

    abstract: [
  In diesem Praktikum sollen die ersten Kenntnisse in der Programmiersprache Java gefestigt werden. Sie benötigen die ersten vier Vorlesungen, um dieses Praktikum bewältigen zu können. Es soll eine Namensverwaltung programmiert werden, mit der Sie eine Liste an Namen nach bestimmten Regeln ändern können.
],
    show-outline: true,

    author: "Emily Antosch",

    show-solutions: false

)

= Einleitung

In China besteht die Möglichkeit, den eigenen Namen alle drei
Jahre zu ändern. Das zu erstellende Programm soll ohne erneute Übersetzung auf verschiedenen Hardwareplattformen lauffähig sein. Erstellen Sie daher ein Java Programm, mit Hilfe dessen dies möglich ist. Gehen Sie dabei wie folgt vor:
- Erstellen Sie zuerst eine Klasse: Person, die folgende Attribute enthält: vorname, nachname, namensänderungsdatum (getrennt nach Tag, Monat und Jahr).
- Schreiben Sie nun ein Java-Programm, das zuerst die in Hamburg übliche Redensart für „Guten Tag!“ auf der Konsole ausgibt.
- Anschließend erstellt Ihr Programm drei Objekte der Klasse Person, diese lauten:
- person_1, person_2 und person_3.
- Dann erfragt Ihr Programm welche Person (1, 2 oder 3) ihren Namen ändern möchte.
- Die Eingabe 0 führt zum Programmende und die Eingabe 4 zum Anzeigen der gespeicherten Attribute aller Objekte. Lautet die Eingabe 1, 2 oder 3, wird nach dem neuen Vor- und Nachnamen und dem Tag, Monat und Jahr, ab wann diese Änderung gültig sein soll, gefragt. Dieses Datum ist hinsichtlich der Dreijahresfrist zu prüfen. Ist die Prüfung erfolgreich, wird die Änderung in dem entsprechenden Objekt vorgenommen und das Ergebnis angezeigt. Ist sie nicht erfolgreich, wird eine Fehlermeldung ausgegeben und das Programm fortgesetzt.
- Die Eingaben in den einzelnen Eingabefeldern selbst müssen nicht auf Korrektheit, sprich Buchstaben, Zahlen, Sonderzeichen, geprüft werden, d. h. die Eingaben in den einzelnen Eingabefeldern müssen sinnvoll erfolgen und müssen nicht von Ihrem Programm geprüft werden. In einem realen Projekt würde diese Vorverarbeitung durch ein weiteres Programm geprüft werden und ist daher nicht Gegenstand dieser Aufgabe.

#pagebreak()

= Vorbereitung
Verdeutlichen Sie sich zunächst die Aufgabenstellung, indem Sie erst die Klasse Person gemäß UML-Notation zeichnen und dann ein Struktogramm oder Flussdiagramm erstellen, das diese Aufgabe löst.
Definieren Sie anschließend alle notwendigen Klassen in Java.

= Hilfestellung
Das folgende Programm, welches eine Konsoleneingabe verdeutlicht, können Sie zur Lösung dieser Aufgabe verwenden:

```java
import java.io.*;
public class Eingabe{
  public static void main(String[] args) throws IOException {
  // Konsoleneingabe
  InputStreamReader isr = new InputStreamReader(System.in);
  BufferedReader br = new BufferedReader(isr);
  System.out.print("Geben Sie hier etwas ein: ");
  String eingabe = br.readLine();

  System.out.println("Sie haben \"" + eingabe + "\" eingegeben.");

  // Falls eine Zahl zur Fallunterscheidung benötigt wird (z. B. Volljährigkeit):
  int zahl = Integer.parseInt(eingabe);
  if (zahl >= 18){
    System.out.println("Volljährig.");
  } else {
    System.out.println("Noch nicht volljährig.");
  }
 }
}
```


= Labordurchführung

Sollte Ihr Programm noch nicht fehlerfrei funktionieren, versuchen wir das im Laufe des Praktikums zu berichtigen. Bei einer guten Vorbereitung sollte das kein Problem darstellen, denn jede Studentin und jeder Student muss zu Beginn des Praktikums ihre bzw. seine Lösung erklären können und prinzipiell in der Lage sein, die Aufgabe alleine zu bewältigen, so dass spätestens am Endes des Praktikums die Aufgabe zufriedenstellend gelöst ist.
Natürlich unterstützen wir Sie dabei, aber es muss auch Ihr persönliches Engagement deutlich zu erkennen sein!
Viel Spaß und viel Erfolg wünschen Ihnen Philipp Krause und Emily Antosch! 
