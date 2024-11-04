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
  title: "Praktikum 3 - Erweiterung der Namensverwaltung unter Berücksichtigung von realistischen Studierendenzahlen", university: [HAW Hamburg], institute: [Fakultät TI - SHC], seminar: [OOP], abstract: [
    In diesem Praktikum sollen Sie die Prinzipien der Vererbung anwenden, um Ihre
    Namensverwaltung noch ein Stück besser zu machen. Außerdem sollen realistisch
    hohe Zahlen bei der Verarbeitung von Studierenden verwendet werden.
  ], show-outline: true, author: "Emily Antosch", show-solutions: false,
)

= Einleitung

Erweitern Sie Ihr Java-Programm aus Versuch 2 um Immatrikulationsnummern und
implementieren Sie es so, dass Sie mittels einer einzigen Konstanten `MAX_ANZAHL`
definieren können, wie viele Studierende das Programm maximal verwalten kann.
Diese maximale Anzahl kann zwischen 1 und mehreren Millionen liegen. Für das
Praktikum ist ein Vorgabewert von 500 zu wählen. Gehen Sie dabei wie folgt vor:
- Erstellen Sie eine neue Klasse Studierende, welche neben der
  Immatrikulationsnummer alle Aspekte der Klasse Person erbt. Die
  Immatrikulationsnummer beginnt mit 1001 und erhöht sich mit jeder weiteren
  Person um eins. Auch diese Immatrikulationsnummer kann lediglich über
  entsprechende Methoden angesprochen werden. Ansonsten bleibt alles wie gehabt,
  d. h. das Programm wird mit der Eingabe einer 0 beendet, Mit der Eingabe der `MAX_ANZAHL+1` werden
  alle Attribute aller Studierenden angezeigt und mit `MAX_ANZAHL+2` wird die
  maximale Anzahl der durch das Programm verwaltbaren Studierenden ausgegeben.

= Vorbereitung
Verdeutlichen Sie sich auch hier wieder zunächst die Aufgabenstellung, indem Sie
zuerst die Klassen Studierende und Person gemäß UML-Notation unter Beachtung
ihrer korrekten Beziehungen zeichnen. Definieren Sie anschließend alle
notwendigen Klassen, Methoden und Variablen in Java.

= Praktikumsdurchführung:
Sollte Ihr Programm noch nicht fehlerfrei funktionieren, versuchen wir das im
Laufe des Praktikums zu berichtigen. Bei einer guten Vorbereitung sollte das
kein Problem darstellen, denn jede Studentin und jeder Student muss zu Beginn
des Praktikums ihre bzw. seine Lösung erklären können und prinzipiell in der
Lage sein, die Aufgabe alleine zu bewältigen, so dass spätestens am Ende des
Praktikums die Aufgabe zufriedenstellend gelöst ist. Natürlich unterstützen wir
Sie wieder dabei, aber es muss auch Ihr persönliches Engagement deutlich zu
erkennen sein! Viel Spaß und viel Erfolg wünschen Ihnen Philipp Krause und Emily
Antosch!

