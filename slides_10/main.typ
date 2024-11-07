#import "@preview/touying:0.5.2": *
#import themes.university: *

#import "@preview/fletcher:0.5.1" as flechter: diagram, node, edge
#import "@preview/wrap-it:0.1.0": wrap-content

#import "@preview/gentle-clues:1.0.0": *
#import "@preview/pinit:0.2.0": *
#import "@preview/codly:1.0.0": *
#show: codly-init.with()

#import "@preview/numbly:0.1.0": numbly

#set text(lang: "de", font: "Roboto", size: 18pt)
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
    title: [Objektorientierte Programmierung in Java], subtitle: [Vorlesung 10 - Parallel Computing], author: [Emily Lucia Antosch], date: datetime.today().display("[day].[month].[year]"), institution: [HAW Hamburg],
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

- In der letzten Vorlesung haben wir uns mit der Ausgabe und Eingabe beschäftigt
- Sie können nun
  - Ausgabe auf der Konsole in den richtigen Kanal senden und formatieren,
  - Eingabe vom User einfordern
  - und Dateien in Java einlesen.
- Heute geht es weiter mit der *Parallelverarbeitung*.

#slide[
  1. Imperative Konzepte
  2. Klassen und Objekte
  3. Klassenbibliothek
  4. Vererbung
  5. Schnittstellen
  6. Graphische Oberflächen
  7. Ausnahmebehandlung
  8. Eingaben und Ausgaben
  9. *Multithreading (Parallel Computing)*
]

== Das Ziel dieses Kapitels

- Sie führen Programmcode zeitgleich in nebenläufigen Ausführungssträngen (Threads) aus.
- Sie verändern die Zustände aktiver Threads zur Erzeugung der geforderten Funktionalität.
- Sie synchronisieren Threads und Objekte, um fehlerhafte Datenzustände durch nicht korrekte Ausführungsreihenfolgen zu verhindern.

= Parallelverarbeitung
== Beispiel: Rührei und Pudding

#slide[
#text(size: 18pt)[

- Sie machen Rührei und Pudding.
- Möglicher Ablauf:
#figure(image("../assets/img/2024_11_07_serial_ruehrei_rev01.png", height: 40%))

#question[
- Wie könnte der Ablauf aussehen, wenn Sie zu viert kochen?
- Einschränkung: Es gibt nur eine Herdplatte
    ]
]
]

#slide[
#text(size: 18pt)[

- Mögliche Reihenfolge
- Ressourcenkonflikt: Herdplatte

#figure(image("../assets/img/2024_11_07_parallel_ruehrei_rev01.png", height: 40%))

]
]

#slide[
#text(size: 18pt)[
- Mögliche Aufteilung auf vier Personen
#figure(image("../assets/img/2024_11_07_parallel_swimlane_rev01.png", height: 40%))
]
]

#slide[
#text(size: 18pt)[
- Aufgabe wird in Teilaufgaben zerlegt, die parallel ausgeführt werden können
- Ergebnisse der Teilaufgaben müssen ausgetauscht werden

- Probleme:
  - Abhängigkeiten: Teilaufgaben benötigen Ergebnisse anderer Teilaufgaben
  - Ressourcenkonflikt: Teilaufgaben benötigen dieselbe Ressource
  - Kommunikations-Overhead: Austausch von Ergebnissen benötigt Ressourcen und Zeit

- Aufgaben können nicht beliebig oder automatisch parallelisiert werden.
]
]

#slide[
#text(size: 18pt)[
- Begriffe:
  - Thread (engl. für „Faden“): Ausführungsstrang innerhalb eines Programmes
  - Multithreading: Mehrere (parallele) Ausführungsstränge innerhalb eines Programmes

- Speicher:
  - Threads teilen sich Speicherbereich des Programmes:
  - Teilen sich daher Variablen und Objekte
  - Können effizient (aber unsicher!) über Variablen und Objekte kommunizieren
- Aber: Jeder Thread hat eigenen Aufruf-Stack der aufgerufenen Methoden
]
]

#slide[
#text(size: 18pt)[
#question[
- Kleines Rätsel zwischendurch:
- Zumindest einen parallelen Thread haben wir bereits kennengelernt. Welchen?
]
#pause
- Antwort:
  - Garbage Collector (Speicher nicht referenzierter Objekte freigeben)

- Beachte:
  - Java-Programme erzeugen beim Start einen main-Thread
  - Setzen hierbei main() als unterste Methode auf den Aufruf-Stack
  - Bei Bedarf zusätzlich ein Thread für den Garbage Collector gestartet
  - Programm beendet, sobald der letzte zugehörige Thread beendet wurde
]
]

#slide[
#text(size: 18pt)[
- Teilt Programmen und Threads Rechenzeit (d.h. Prozessoren bzw. Prozessorkerne) zu
- Wartezeiten anderer Threads oder Programme genutzt

- Pseudo-Parallelität:
  - Falls mehr parallele Ausführungsstränge als Prozessoren bzw. Prozessorkerne
  - Scheduler verteilt Rechenzeit scheibchenweise:
    - Ausführung im zeitlichen Wechsel
    - Eindruck, dass Dinge parallel prozessiert werden
]
]

= Klassenbasierte Threads

#slide[
#text(size: 18pt)[

- Threads werden durch Objekte der Klasse Thread erzeugt:
- Methode `start()` erzeugt und startet parallelen Ausführungsstrang
- Methode `run()` enthält Code, der in Ausführungsstrang ausgeführt werden soll
- Ausführungsstrang wird beendet, sobald `run()` beendet wird

#figure(image("../assets/img/2024_11_07_klasse_thread_uml_rev01.png", height: 40%))
]
]

#slide[
#text(size: 18pt)[

- Veranschaulichung
#figure(image("../assets/img/2024_11_07_programmfluss_thread_rev01.png", height: 40%))
]
]

#slide[
#text(size: 13pt)[
    #task[
- Lassen Sie uns dies implementieren:
- Schreiben Sie ein Programm, das einen zusätzlichen Thread erzeugt.
    ]

```java
public class RunThread1 {
    public static void main(String[] args) {
        Thread thread = new Thread();
        System.out.println("Objekt erzeugt");
        thread.start();
        System.out.println("Thread gestartet");
    }
}
```
#question[
- Aber man sieht ja gar nichts vom Thread!
  - Die run()-Methode der Klasse Thread ist „leer“.
  - Wie können wir den Thread einen Text auf Konsole ausgeben lassen?
    ]
]
]
#slide[
#text(size: 18pt)[

- Sie machen Rührei und Pudding.
- Möglicher Ablauf:
#figure(image("../assets/img/2024_11_07_serial_ruehrei_rev01.png", height: 40%))

#question[
- Wie könnte der Ablauf aussehen, wenn Sie zu viert kochen?
- Einschränkung: Es gibt nur eine Herdplatte
    ]
]
]
#slide[
#text(size: 18pt)[

- Sie machen Rührei und Pudding.
- Möglicher Ablauf:
#figure(image("../assets/img/2024_11_07_serial_ruehrei_rev01.png", height: 40%))

#question[
- Wie könnte der Ablauf aussehen, wenn Sie zu viert kochen?
- Einschränkung: Es gibt nur eine Herdplatte
    ]
]
]
#slide[
#text(size: 18pt)[

- Sie machen Rührei und Pudding.
- Möglicher Ablauf:
#figure(image("../assets/img/2024_11_07_serial_ruehrei_rev01.png", height: 40%))

#question[
- Wie könnte der Ablauf aussehen, wenn Sie zu viert kochen?
- Einschränkung: Es gibt nur eine Herdplatte
    ]
]
]
#slide[
#text(size: 18pt)[

- Sie machen Rührei und Pudding.
- Möglicher Ablauf:
#figure(image("../assets/img/2024_11_07_serial_ruehrei_rev01.png", height: 40%))

#question[
- Wie könnte der Ablauf aussehen, wenn Sie zu viert kochen?
- Einschränkung: Es gibt nur eine Herdplatte
    ]
]
]
#slide[
#text(size: 18pt)[

- Sie machen Rührei und Pudding.
- Möglicher Ablauf:
#figure(image("../assets/img/2024_11_07_serial_ruehrei_rev01.png", height: 40%))

#question[
- Wie könnte der Ablauf aussehen, wenn Sie zu viert kochen?
- Einschränkung: Es gibt nur eine Herdplatte
    ]
]
]

#slide[
#text(size: 18pt)[

- Sie machen Rührei und Pudding.
- Möglicher Ablauf:
#figure(image("../assets/img/2024_11_07_serial_ruehrei_rev01.png", height: 40%))

#question[
- Wie könnte der Ablauf aussehen, wenn Sie zu viert kochen?
- Einschränkung: Es gibt nur eine Herdplatte
    ]
]
]
= License Notice

== Attribution

- This work is shared under the CC BY-NC-SA 4.0 License and the respective Public
  License
- link("https://creativecommons.org/licenses/by-nc-sa/4.0/")
- This work is based off of the work Prof. Dr. Marc Hensel.
- Some of the images and texts, as well as the layout were changed.
- The base material was supplied in private, therefore the link to the source
  cannot be shared with the audience.
