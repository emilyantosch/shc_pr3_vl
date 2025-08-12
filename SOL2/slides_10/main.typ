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
    fill: fill,
    pin-dx: 0em,
    pin-dy: if pos == bottom { 0em } else { -0.6em },
    body-dx: 0pt,
    body-dy: if pos == bottom { -1.7em } else { -1.6em },
    offset-dx: 0em,
    offset-dy: if pos == bottom { 1.2em + height } else { -0.6em - height },
    point-pin,
    rect(
      inset: 0.5em,
      stroke: (bottom: 0.12em + fill),
      {
        set text(fill: fill)
        body
      },
    ),
  )
}
#show: university-theme.with(
  aspect-ratio: "16-9",
  config-info(
    title: [Objektorientierte Programmierung in Java],
    subtitle: [Vorlesung 10 - Parallel Computing],
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
      color: rgb("#CE412B"),
    ),
    c: (
      name: text(font: "JetBrainsMono NFM", " C", weight: "bold"),
      icon: text(font: "JetBrainsMono NFM", "\u{e61e}", weight: "bold"),
      color: rgb("#5612EC"),
    ),
  ),
)

#title-slide(authors: [Emily Lucia Antosch])

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
    #figure(image("../assets/img/slides_10/2024_11_07_serial_ruehrei_rev01.png", height: 40%))

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

    #figure(image("../assets/img/slides_10/2024_11_07_parallel_ruehrei_rev01.png", height: 80%))

  ]
]

#slide[
  #text(size: 18pt)[
    - Mögliche Aufteilung auf vier Personen
    #figure(image("../assets/img/slides_10/2024_11_07_parallel_swimlane_rev01.png", height: 80%))
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
== Klasse Thread

#slide[
  #text(size: 18pt)[

    - Threads werden durch Objekte der Klasse Thread erzeugt:
    - Methode `start()` erzeugt und startet parallelen Ausführungsstrang
    - Methode `run()` enthält Code, der in Ausführungsstrang ausgeführt werden soll
    - Ausführungsstrang wird beendet, sobald `run()` beendet wird

    #figure(image("../assets/img/slides_10/2024_11_07_klasse_thread_uml_rev01.png", height: 40%))
  ]
]

#slide[
  #text(size: 18pt)[

    - Veranschaulichung
    #figure(image("../assets/img/slides_10/2024_11_07_programmfluss_thread_rev01.png", height: 60%))
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
    - Ansatz:
      - Die eigentliche Arbeit findet in der run()-Methode statt.
      - Die run()-Methode der Klasse Thread ist „leer“.

    - Eigene Thread-Klasse von Thread ableiten und run() überlagern

    #figure(image("../assets/img/slides_10/2024_11_07_vererbung_thread_uml_rev01.png", height: 40%))
  ]
]

#slide[
  #text(size: 15pt)[
    #task[
      - Erzeugen Sie in einem zusätzlichen Thread eine Konsolenausgabe.
    ]

    ```java
    public class PrintThread extends Thread {
        public void run() {
            System.out.println("Hurra, ich laufe parallel!");
        }
    }

    public class RunThread2 {
        public static void main(String[] args) {
            PrintThread thread = new PrintThread();
            System.out.println("Objekt erzeugt");
            thread.start();
            System.out.println("Thread gestartet");
        }
    }
    ```
  ]
]

= Interface-basierte Threads
== Interface Runnable

#slide[
  #text(size: 18pt)[

    - Alternativ zum Ableiten von Thread:
      - Eigene Klasse implementiert Interface `Runnable` mit `run()`-Methode
      - Runnable-Objekt wird an Thread-Objekt übergeben: Keine Vererbung erforderlich

    - Verantwortlichkeiten:
      - Runnable-Objekt beinhaltet, was ausgeführt werden soll
      - Thread-Objekt beinhaltet alles, was zur Nebenläufigkeit benötigt wird

    #figure(image("../assets/img/slides_10/2024_11_07_interface_Runnable_rev01.png", height: 40%))
  ]
]

#slide[
  #text(size: 16pt)[
    ```java
    public class PrintRunnable implements Runnable {
        public void run() {
            System.out.println("Hurra, ich laufe parallel!");
        }
    }

    public class InterfaceBased {
        public static void main(String[] args) {
            PrintRunnable runnable = new PrintRunnable();
            Thread thread = new Thread(runnable);

            System.out.println("Objekte erzeugt");
            thread.start();
            System.out.println("Thread gestartet");
        }
    }
    ```
  ]
]
#slide[
  #text(size: 13pt)[

    #question[
      - Was wird ausgegeben?
    ]

    ```java
    class CounterRunnable implements Runnable {
        private int counter;
        public void run() {
            while (counter < 10)
                System.out.println("\t\t\tThread counter: " + counter++);
            System.out.println("\t\t\tExiting run()");
        }
    }
    public class Counters {
        private static int counter;
        public static void main(String[] args) {
            new Thread(new CounterRunnable()).start();
            while (counter < 10)
                System.out.println("Main counter: " + counter++);
            System.out.println("Exiting main()");
        }
    }
    ```
  ]
]

#slide[
  #text(size: 18pt)[
    #let body = [

      - Methoden `run()` und `main()` zählen bis 9
      - Nicht vorhersagbar, wer zuerst fertig ist

      - Beispielausgabe (rechts):
        - `main`-Thread zuerst beendet
        - Thread mit `run()` läuft weiter
    ]
    #let fig = figure(image("../assets/img/slides_10/2024_11_07_thread_counter_rev01.png"))
    #grid(
      columns: (60%, 40%),
      gutter: 0.25em,
      body, fig,
    )
  ]
]

= Zustände und ausgewählte Methoden
== Thread-Zustände

#slide[
  #text(size: 18pt)[
    #question[
      - Stellen Sie sich vor, Sie wären ein Thread:
        - Welche Zustände könnten Sie sinnvoller Weise einnehmen?
        - Welche Zustandsübergänge wären sinnvoll?
    ]

    - Vergessen Sie Folgendes nicht:
      - Was passiert, wenn mehr Threads als Prozessoren existieren?
      - Was sollten Sie machen, wenn Sie auf eine Eingabe warten?
  ]
]

#slide[
  #text(size: 18pt)[

    - Neu: Java-Objekt erstellt, aber noch nicht als Thread gestartet
    - Lauffähig: Bereit, ausgeführt zu werden. Wartet auf Prozessor.
    - Laufend: Hat Prozessor und wird gerade ausgeführt
    - Blockiert: Wird nicht ausgeführt und würde es auch bei freiem Prozessor nicht
    - Terminiert: Thread beendet. Java-Objekt existiert weiterhin!

    #figure(image("../assets/img/slides_10/2024_11_07_ablauf_thread_queue_rev01.png", height: 50%))
  ]
]

#slide[
  #text(size: 16pt)[

    - Weist Threads Rechenzeit zu (d.h. Lauffähig wird Laufend)
    - Entzieht Threads Prozessor wieder (d.h. Laufend wird Lauffähig):
      - Benötigt, falls mehr Threads als Prozessoren existieren
      - Idee: Threads erhalten abwechselnd Rechenzeit

    - Steuerung des Verhaltens:
      - Scheduler ist nicht steuerbar
      - Keine Garantie, dass Threads abwechselnd Rechenzeit erhalten
      - `setPriority()` setzt Priorität, aber keine Garantie wie Scheduler sie berücksichtigt
      - „Der Scheduler ist eine Diva!“

    #figure(image("../assets/img/slides_10/2024_11_07_lauffaehig_laeuft_rev01.png", height: 35%))
  ]
]

#slide[
  #text(size: 18pt)[
    #let body = [
      - Laufenden Thread eine bestimmte Zeit in Zustand Blockiert versetzen
      - Wartezeit in Millisekunden als Parameter (Datentyp long) übergeben

      - Vorzeitiges Aufwecken:
        - Thread kann durch Methode interrupt() vorzeitig „aufgeweckt“ werden
        - Wirft hierbei Ausnahme vom Typ InterruptedException

      ```java
      MyThread thread = new MyThread();
      thread.start();
      try {
          Thread.sleep(1000);
      } catch (InterruptedException e) {
          e.printStackTrace();
      }
      ```
    ]
    #let fig = figure(image("../assets/img/slides_10/2024_11_07_laufend_sleep_block_rev01.png"))
    #grid(
      columns: (80%, 20%),
      gutter: 0.25em,
      body, fig,
    )
  ]
]

#slide[
  #text(size: 13pt)[

    - Lassen Sie das Fenster blinken (alle 0,75 s Wechsel zwischen gelb und hellgrau):
    ```java
    public class FlashLight {
        private boolean isLightOn;
        private JFrame frame;
        private FlashLight() {
            frame = new JFrame("Blinklicht");
            frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
            frame.setSize(300, 250);
            frame.setVisible(true);
        }
        public void switchLight() {
            isLightOn = !isLightOn;
            if (isLightOn)
                frame.getContentPane().setBackground(Color.YELLOW);
            else
                frame.getContentPane().setBackground(Color.LIGHT_GRAY);
        }
        public static void main(String[] args) {
            FlashLight flashLight = new FlashLight();
        }
    }
    ```
  ]
]
#slide[
  #text(size: 14pt)[

    - Zum Blinken benötigt:
      - Thread, der alle 0,75 s die Methode switchLight() aufruft

    ```java
    class FlashThread extends Thread {
        private FlashLight flashLight;

        public FlashThread(FlashLight flashLight) {
            this.flashLight = flashLight;
        }

        public void run() {
            while (true) {
                flashLight.switchLight();
                try {
                    Thread.sleep(750);
                } catch (InterruptedException e) {
                }
            }
        }
    }
    ```
  ]
]

#slide[
  #text(size: 18pt)[
    - Erzeugung und Starten des Threads in FlashLight:
    ```java
    public static void main(String[] args) {
        FlashLight flashLight = new FlashLight();
        FlashThread thread = new FlashThread(flashLight);
        thread.start();
    }
    ```

    #figure(image("../assets/img/slides_10/2024_11_11_flashlight_rev01.png", height: 50%))
  ]
]

#slide[
  #text(size: 18pt)[

    #let body = [
      - Laufenden Thread auf Ende eines anderen Threads warten lassen

      - Beispiel:
        - Wartet bei `thread.join()`, bis `thread` terminiert
        - Erst dann erfolgt die Konsolenausgabe

      ```java
      public static void main(String[] args) {
          MyThread thread = new MyThread();
          thread.start();
          thread.join();
          System.out.println("We have joined!");
      }
      ```
      - Maximale Wartezeit:
        - Maximale Wartezeit kann als Parameter (Datentyp `long`) angegeben werden
        - Wozu wird dies benötigt? (Man wartet ja schließlich nicht ohne Grund)

    ]
    #let fig = figure(image("../assets/img/slides_10/2024_11_11_blocked_join_rev01.png"))
    #grid(
      columns: (80%, 20%),
      gutter: 0.5em,
      body, fig,
    )
  ]
]

#slide[
  #text(size: 15pt)[
    #question[
      - Was macht dieser Thread?
    ]

    ```java
    public class SleepyThread extends Thread {
        public void run() {
            for (int i = 0; i < 5; i++) {
                System.out.println("I'm sooo tired ...");
                try {
                    Thread.sleep(1000);
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
            }
            System.out.println("Okay, I'm awake again.");
        }
    }
    ```
  ]
]

#slide[
  #text(size: 15pt)[
    - Es geht noch weiter:
      - Welche Ausgabe wird erzeugt?
      - Welche Ausgabe würde ohne die Zeile sleepy.join() erzeugt?
      - Welche Ausgabe würde mit sleepy.join(1500) erzeugt?
    ```java
    public class JoinThreads {
        public static void main(String[] args) throws InterruptedException {
            SleepyThread sleepy = new SleepyThread();
            sleepy.start();

            while (sleepy.isAlive()) {
                System.out.println("Wake up!");
                Thread.sleep(400);
                sleepy.join();
            }
            System.out.println("At last ...");
        }
    }
    ```
  ]
]

= Synchronisation
== Synchronisation
#slide[
  #text(size: 13pt)[
    - Klasse repräsentiert ein Bankkonto mit Methoden für Ein- und Auszahlungen
    - Kontobewegungen parallel über Threads (z.B. Geldautomat, Schalter, Lastschrift)

    ```java
    public class Account {
        private double balance;

        public void deposit(double amount) {
            double newBalance = balance + amount;
            if (newBalance > balance)
                balance = newBalance;
        }

        public void withdraw(double amount) {
            double newBalance = balance - amount;
            if (newBalance >= 0.0)
                balance = newBalance;
        }
    }
    ```
    - Was ist denn da passiert?!
      - Sie heben 50 € ab, während 50 € als Überweisung gutgeschrieben werden.
      - Anschließend sind 50 € weniger als zuvor auf dem Konto.

  ]
]
#slide[
  #text(size: 18pt)[
    - Ursache:
      - Threads führen gleichzeitig Methoden deposit() und withdraw() aus
      - Beide Methoden greifen auf Variable balance zu.

    #figure(image("../assets/img/slides_10/2024_11_11_deposit_withdraw_thread_rev01.png", height: 50%))

  ]
]

#slide[
  #text(size: 15pt)[
    - Zwei Threads teilen sich eine Variable.
      - Race Condition: Ergebnis des Programmes hängt von Zugriffsreihenfolge ab

    - Wann ist das Ergebnis davon abhängig, welcher Thread „schneller ist“?
      - Beide Threads lesen die Variable
      - Ein Thread liest, ein Thread schreibt in die Variable
      - Beide Threads schreiben in die Variable

    - Antwort:
      - Race Condition, wenn mindestens ein Thread schreibt

    #figure(image("../assets/img/slides_10/2024_11_11_race_conditions_rev01.png", height: 40%))
  ]
]

#slide[
  #text(size: 18pt)[
    - Schlüsselwort `synchronized` für Methoden:
      - Objekt wird gesperrt, sobald ein Thread eine synchronisierte Methode betritt
      - Objekt wird wieder freigegeben, wenn Thread die Methode wieder verlässt

    - Synchronisierte Methoden (gegenseitiger Ausschluss):
      - Objekt gesperrt: Threads können keine synchronisierten Methoden betreten. (Alle synchronisierten Methoden sind gesperrt, nicht nur die gerade ausgeführte!)
      - Threads warten im Zustand Blockiert bis das Objekt wieder freigegeben wurde.

    - Nicht-synchronisierte Methoden:
      - Threads können aber bei gesperrtem Objekt nicht-synchronisierte Methoden betreten.

    #task[
      - Helfen Sie Ihrer Bank:
        - Sorgen Sie dafür, dass bei Einzahlungen und Auszahlungen nichts mehr schief geht.
    ]
  ]
]

#slide[
  #text(size: 16pt)[

    Synchronisierung über `synchronized`:
    ```java
    public class Account {
        private double balance;

        public synchronized void deposit(double amount) {
            double newBalance = balance + amount;
            if (newBalance > balance)
                balance = newBalance;
        }

        public synchronized void withdraw(double amount) {
            double newBalance = balance - amount;
            if (newBalance >= 0.0)
                balance = newBalance;
        }
    }
    ```
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
