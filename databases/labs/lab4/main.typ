#import "@preview/grape-suite:1.0.0": exercise, german-dates

#import "@preview/gentle-clues:1.0.0": *
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
  title: "Praktikum 4 - Erstellung eines Labyrinths mittels Arrays, sowie Rekursion", university: [HAW Hamburg], institute: [Fakultät TI - SHC], seminar: [OOP], abstract: [
    In diesem Praktikum sollen die ersten Kenntnisse in der Programmiersprache Java
    gefestigt werden. Sie benötigen die ersten vier Vorlesungen, um dieses Praktikum
    bewältigen zu können. Es soll eine Namensverwaltung programmiert werden, mit der
    Sie eine Liste an Namen nach bestimmten Regeln ändern können.
  ], show-outline: true, author: "Emily Antosch", show-solutions: false,
)

= Einleitung

Eine arme, hungrige Maus sitzt in der linken, oberen Ecke eines Labyrinths
(siehe Skizze) und möchte zu einem Stück Käse, welches sich in der rechten,
unteren Ecke des Labyrinths befindet. Sie kann dabei alle nichtstraffierten
Felder betreten, aber jeweils nur über eine, zwei Feldern gemeinsame, Kante.
Helfen Sie der Maus, zu dem Käse zu gelangen. Schreiben Sie dazu eine rekursive
Methode in Java, die der Maus einen Weg zum Käse zeigt.

#figure(image("../../assets/img/2024_11_04_maus_laby_rev01.png"))

#tip[
  Ihre Methode muss für jedes mögliche Feld versuchen, über die vier
  Nachbarfelder, je einen Weg zum Käse zu finden.
]

#pagebreak()
= Vorbereitung
Bilden Sie das Labyrinth in einem zweidimensionalen Array ab. Verwenden Sie
dabei jeweils zwei Felder mehr als durch das Labyrinth vorgegeben und belegen
Sie die Randfelder mit Wänden (entsprechend der straffierten Elemente im
Labyrinth). Da sich die Maus oben links befindet, gibt es zu Beginn nur zwei
sinnvolle Wege. Verwenden Sie aber ab dem zweiten Schritt eine Methode, die alle
vier Richtungen prüft und sich selbst aufruft, d. h. rekursiv arbeitet, um den
Weg zu finden. Tipp: Verwenden Sie ein Kennzeichnungszeichen, um den Weg, den
die Maus gegangen ist zu kennzeichnen, denn die Maus soll ja nicht zurücklaufen.
(Dies wird Ihnen bei der Implementierung des Algorithmus‘ hilfreich sein. War
der eingeschlagene Weg nicht erfolgreich, geht die Maus diesen Weg wieder
zurück, löscht dabei wieder die Kennzeichnung und beginnt von vorne mit der
Suche.) Am Ende soll der Weg durch das Labyrinth eingezeichnet sein. Wenn Sie
möchten, können Sie das Labyrinth mit grafischen Methoden nachbilden und auch
den Weg der Maus zum Käse darin eintragen. Auch eine Modifikation des Labyrinths
oder eine größere Anzahl von Feldern ist möglich.

= Praktikumsdurchführung
Sollte Ihr Programm noch nicht fehlerfrei funktionieren, versuchen wir das im
Laufe des Praktikums zu berichtigen. Bei einer guten Vorbereitung sollte das
kein Problem darstellen, denn jede Studentin und jeder Student muss zu Beginn
des Praktikums ihre bzw. seine Lösung erklären können und prinzipiell in der
Lage sein, die Aufgabe alleine zu bewältigen, so dass spätestens am Endes des
Praktikums die Aufgabe zufriedenstellend gelöst ist.
#memo[
  Eine zeitliche Verlängerung ist bei diesem Versuch ausgeschlossen!
]
Natürlich unterstützen wir Sie wieder dabei, aber es muss auch Ihr persönliches
Engagement deutlich zu erkennen sein! Viel Spaß und viel Erfolg wünschen Ihnen
Philipp Krause und Emily Antosch!
