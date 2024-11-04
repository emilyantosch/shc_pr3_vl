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
title: "Praktikum 2 - Erweiterung der Namensverwaltung um Methoden, Klassenvariablen und Arrays",

    university: [HAW Hamburg],
    institute: [Fakultät TI - SHC],
    seminar: [OOP],

    abstract: [
  In diesem Praktikum sollen Sie Klassenmethoden, Bibliotheken und weitere Features von Java nutzen, um ihr Programm noch ein bisschen besser zu machen. Dabei sollen Sie ihr Programm noch dynamischer werden und besser auf mehr Studenten reagieren können. Außerdem sollen Sie die Daten in den Objekten kapseln. 
],
    show-outline: true,

    author: "Emily Antosch",

    show-solutions: false

)

= Einleitung

Erweitern Sie Ihr Java-Programm, zum Schutz der Instanzvariablen, nun um sogenannte Getter- und Setter-Methoden. (Dazu ist die Monatseingabe exemplarisch auf Plausibilität zu prüfen.) Führen Sie ferner eine Klassenvariable ein, welche die Anzahl der Personen zählt und auf Anforderung ausgibt. Speichern Sie die einzelnen Personen nun in einem Array und nicht mehr in getrennten Variablen.
Gehen Sie dabei wie folgt vor:
- Die Eingaben in den einzelnen Eingabefeldern selbst müssen wieder nicht auf Korrektheit, sprich Buchstaben, Zahlen, Sonderzeichen, geprüft werden, d. h. die Eingaben in den einzelnen Eingabefeldern müssen sinnvoll erfolgen und müssen nicht von Ihrem Programm geprüft werden. Allerdings sind sämtliche Instanzvariablen nun vor direktem Zugriff von außen zu schützen, d. h. diese bekommen das Attribut private und der Zugriff auf sie erfolgt mittels sogenannten Getter- und Setter-Methoden. Dabei ist lediglich die Monatseingabe exemplarisch auf Plausibilität zu prüfen.
- Führen Sie eine Klassenvariable ein, welche die Anzahl der Personen zählt und auf Anforderung ausgibt, d. h. mit der Eingabe der Zahl 5 im Auswahlmenue wird die Anzahl der Personen ausgegeben. (Diese ist zwar bei dieser Aufgabenstellung noch konstant, könnte aber bei einer späteren Erweiterung an Bedeutung gewinnen.)
- Ferner sind die einzelnen Personen nun in einem Array und nicht mehr in getrennten Variablen zu speichern, um eine Erweiterung auf eine realistische Personenzahl zu ermöglichen.

= Vorbereitung
Verdeutlichen Sie sich auch hier wieder zunächst die Aufgabenstellung, indem Sie erst die Klasse Person gemäß UML-Notation zeichnen und dann ein Struktogramm oder Flussdiagramm erstellen, das diese Aufgabe löst.
Definieren Sie anschließend alle notwendigen Klassen, Methoden und Variablen in Java.

= Praktikumsdurchführung
Sollte Ihr Programm noch nicht fehlerfrei funktionieren, versuchen wir das im Laufe des Praktikums zu berichtigen. Bei einer guten Vorbereitung sollte das kein Problem darstellen, denn jede Studentin und jeder Student muss zu Beginn des Praktikums ihre bzw. seine Lösung erklären können und prinzipiell in der Lage sein, die Aufgabe alleine zu bewältigen, so dass spätestens am Endes des Praktikums die Aufgabe zufriedenstellend gelöst ist.
Natürlich unterstützen wir Sie wieder dabei, aber es muss auch Ihr persönliches Engagement deutlich zu erkennen sein!

= Praktikumsausarbeitung
Erstellen Sie dieses Mal auch eine schriftliche Ausarbeitung, die Sie Herrn Krause beim nächsten Praktikumstermin zeigen, damit Sie auch an Ihrer schriftlichen Ausdrucksweise arbeiten.
Viel Spaß und viel Erfolg wünschen Ihnen Philipp Krause und Emily Antosch

