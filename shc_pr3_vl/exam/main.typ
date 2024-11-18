#import "@preview/grape-suite:1.0.0": exercise, colors
#import "@preview/gentle-clues:1.0.0": *
#import exercise: project, task, subtask
#import colors: *

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

#show: project.with(
    type: [Klausur],
    suffix-title: [Objektorientiere Programmierung],

    show-point-distribution-in-tasks: true,
    show-namefield: true,
    show-timefield: true,

    max-time: 90,
    show-lines: true,

    show-solutions: true,
    solutions-as-matrix: true,

    university: [HAW Hamburg],
    institute: [SHC - Fakultät TI],
    seminar: [Objektorientiere Programmierung in Java],

    task-type: [Aufgabe],
    extra-task-type: [Extraaufgabe],

    solution-matrix-task-header: [Aufgabe],
    solution-matrix-achieved-points-header: [Erreichte Punkte],

    distribution-header-point-value: [Punkte],
    distribution-header-point-grade: [Wert],

    message: (points-sum, extrapoints-sum) => [Insgesamt sind #points-sum + #extrapoints-sum P. erreichbar. Sie haben #box(line(stroke: purple, length: 1cm)) P. von #points-sum P. erreicht.],

    solutions-title: [Lösungsvorschläge],
    timefield: (time) => [Zeit: #time min.],

    grade-scale: (([sehr gut], 0.9), ([gut], 0.8), ([befriedigend], 0.7), ([ausreichend], 0.6), ([n.b.], 0.59))
)

= Theoretischer Teil: 45min

#task(points: 10, [Grundbegriffe], [
    Erklären Sie die folgenden fünf Grundbegriffe aus der objektorientierten Programmierung:
  - Attribut
  - Methode
  - Klasse
  - Objekt
  - Vererbung\
  #box(height: 70%, width: 100%, stroke: color.black)[]
], [], (
    (2, [Attribut als Variable oder Eigenschaft einer Klasse/Objekt.]),
    (2, [Methode als Funktion oder Fähigkeit einer Klasse/Objekt.]),
    (2, [Klasse als Bauplan für ein oder mehr Objekte]),
    (2, [Objekt als Instanz einer Klasse]),
    (2, [Vererbung als Möglichkeit, Code zu organisieren. Weitergabe von Methoden und Attributen.]),
))

#task([Konzepte der Objektorientieren Programmierung], [
  Beschreiben Sie kurz, was die verschiedenen Begriffe und Konzepte in Java bzw. der Objektorientieren Programmierung bedeuten. 
], [
    #subtask(points: 5)[
Definieren Sie den Begriff „Polymorphismus“. Geben Sie ein Beispiel an, das zeigt, wie ein Polymorphismus in Java implementiert wird.\
    #box(height: 85%, width: 100%, stroke: color.black)[]
    ]
    #subtask(points: 5)[
Erklären Sie die Unterschiede zwischen einer abstrakten Klasse und einem Interface in Java. Nennen Sie jeweils ein Beispiel für den Einsatz.\
    #box(height: 40%, width: 100%, stroke: color.black)[]
    ]
    #subtask(points: 5)[
    Warum ist es gut, wenn Daten gekapselt werden? Und wie wird diese Datenkapselung erzeugt? Erklären Sie dies und geben Sie ein Beispiel.\
    #box(height: 45%, width: 100%, stroke: color.black)[]
    ]
], (
    (5, [Eine Methode in unterschiedlichen Klassen mit unterschiedlichen Implementierungen existieren kann, während sie den gleichen Methodennamen und die gleiche Signatur trägt. Überladen und Überschreiben.]),
    (5, [Eine abstrakte Klasse ist eine Klasse, die nicht instanziiert werden kann. Ein Interface ist eine Sammlung aus abstrakten Methoden.]),
    (5, [Klarheit und Struktur, Sicherheit, Wartbarkeit. Kapselung mittels `private`, sowie Getter und Setter.]),
))

#task(points: 16, [Wahr oder Falsch], [
  Entscheiden Sie bei den folgenden Aussagen, ob Sie richtig oder falsch sind:
#table(
  columns: (auto, auto, auto),
  inset: 10pt,
  align: horizon,
  table.header(
    [*Frage*], [*Wahr*], [*Falsch*],
  ),
    [Eine Klasse kann von mehreren anderen Klassen erben.], [], [],
    [Vererbung und Komposition sind zwei Worte für die selbe Sache.], [], [],
    [Eine Referenz auf ein Objekt muss immer von genau der selben Klasse sein wie das Objekt selbst.], [], [],
    [Mit ```java public Auto()``` definieren Sie einen Konstruktor für die Klasse ```java Auto```.], [], [],
    [Eine Klasse kann mehrere Interfaces implementieren.], [], [],
    [Mit dem Schlüsselwort ```java impl``` können Sie definieren, dass eine Klasse ein Interface implementiert.], [], [],
    [Mit dem Ausdruck ```java let number : i32 = 0;``` definieren Sie eine Variable mit dem Namen ```java number``` und dem Wert `0`.], [], [], 
    [Der Hauptvorteil der Datenkapselung ist es, dass Sie Daten vor unerlaubten Zugriff schützen.], [], []
)
], [], (
    (2, [Falsch]),
    (2, [Falsch]),
    (2, [Falsch]),
    (2, [Wahr]),
    (2, [Wahr]),
    (2, [Falsch]),
    (2, [Wahr]),
))

#pagebreak()
#task(
  [Beschreibung eines bestehenden Programms], extra: true, points: 10, [

In dem folgenden Programmcode wird ein einfaches Bibliothekssystem erzeugt. Beschreiben Sie, welche Funktionen mit dem Code abgedeckt werden. Welche Klassen und Methoden sind definiert? 
  Fällt Ihnen ein, wie Sie das Programm erweitern könnten?\
  #box(width: 100%, height: 87%, stroke: color.black)[]
  1. Die Klasse ```java Book```
  ```java
public class Book {
    private String title;
    private String author;
    private boolean isBorrowed;

    public Book(String title, String author) {
        this.title = title;
        this.author = author;
        this.isBorrowed = false;
    }

    public String getTitle() {
        return title;
    }

    public String getAuthor() {
        return author;
    }

    public boolean isBorrowed() {
        return isBorrowed;
    }

    public void borrow() {
        if (!isBorrowed) {
            isBorrowed = true;
            System.out.println("Das Buch '" + title + "' wurde ausgeliehen.");
        } else {
            System.out.println("Das Buch '" + title + "' ist bereits ausgeliehen.");
        }
    }

    public void returnBook() {
        if (isBorrowed) {
            isBorrowed = false;
            System.out.println("Das Buch '" + title + "' wurde zurückgegeben.");
        } else {
            System.out.println("Das Buch '" + title + "' war nicht ausgeliehen.");
        }
    }

    public String toString() {
        return "Buch: " + title + " von " + author + (isBorrowed ? " (ausgeliehen)" : " (verfügbar)");
    }
}
  ```

  #v(90%)
  2. Die Klasse ```java Library```

  ```java
import java.util.ArrayList;

public class Library {
    private ArrayList<Book> books;

    public Library() {
        books = new ArrayList<>();
    }

    public void addBook(Book book) {
        books.add(book);
        System.out.println("Das Buch '" + book.getTitle() + "' wurde der Bibliothek hinzugefügt.");
    }

    public void listBooks() {
        if (books.isEmpty()) {
            System.out.println("Die Bibliothek enthält keine Bücher.");
        } else {
            System.out.println("Liste der Bücher in der Bibliothek:");
            for (Book book : books) {
                System.out.println(book);
            }
        }
    }

    public void borrowBook(String title) {
        for (Book book : books) {
            if (book.getTitle().equalsIgnoreCase(title)) {
                book.borrow();
                return;
            }
        }
        System.out.println("Das Buch '" + title + "' wurde nicht gefunden.");
    }

    public void returnBook(String title) {
        for (Book book : books) {
            if (book.getTitle().equalsIgnoreCase(title)) {
                book.returnBook();
                return;
            }
        }
        System.out.println("Das Buch '" + title + "' wurde nicht gefunden.");
    }
}
  ```
  #v(90%)
  3. Die Klasse ```java Main```
  ```java
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Library library = new Library();
        Scanner scanner = new Scanner(System.in);
        boolean running = true;

        // Beispielbücher hinzufügen
        library.addBook(new Book("Der Herr der Ringe", "J.R.R. Tolkien"));
      library.addBook(new Book("Harry Potter und der Stein der Weisen", "J.K. Rowling"));
        library.addBook(new Book("1984", "George Orwell"));

        while (running) {
            System.out.println("\nBibliothekssystem:");
            System.out.println("1. Bücher anzeigen");
            System.out.println("2. Buch ausleihen");
            System.out.println("3. Buch zurückgeben");
            System.out.println("4. Beenden");
            System.out.print("Wählen Sie eine Option: ");
            int choice = scanner.nextInt();
            scanner.nextLine(); // Eingabezeile leeren

            switch (choice) {
                case 1:
                    library.listBooks();
                    break;
                case 2:
                    System.out.print("Titel des auszuleihenden Buches: ");
                    String borrowTitle = scanner.nextLine();
                    library.borrowBook(borrowTitle);
                    break;
                case 3:
                    System.out.print("Titel des zurückzugebenden Buches: ");
                    String returnTitle = scanner.nextLine();
                    library.returnBook(returnTitle);
                    break;
                case 4:
                    running = false;
                    System.out.println("Programm beendet.");
                    break;
                default:
                    System.out.println("Ungültige Option. Bitte erneut versuchen.");
                    break;
            }
        }
        scanner.close();
    }
}
  ```
], [], 
(
(2, [Override von `toString`]),
(2, [Datenkapselung mittels `private` und Getter und Setter]),
(2, [`ArrayList` statt normalem Array.]),
(2, [`Scanner` wird als Eingabe über die Kommandozeile verwendet.]),
(2, [Erweiterungen: Abstrakte-Klassen, Exceptions, Benutzerverwaltung]),
))
#pagebreak()

= Praktischer Teil: 45min

#task([Römisch zu Arabisch], [
    Die römischen Ziffern bestehen aus sieben verschiedenen Symbolen: I, V, X, L, C, D und M.
  #align(center + horizon)[
#table(
  columns: (auto, auto),
  inset: 10pt,
  align: horizon,
  table.header(
    [*Symbol*], [*Wert*],
  ),
    [I], [1],
    [V], [5],
    [X], [10],
    [L], [50],
    [C], [100],
    [D], [500],
    [M], [1000]
)

  ]
Zum Beispiel wird die Zahl 2 als II geschrieben, da es zwei Einsen sind. Die Zahl 12 wird als XII dargestellt, was X (10) plus II (2) entspricht. Die Zahl 27 wird als XXVII geschrieben, was XX (20) plus V (5) plus II (2) ist.

Römische Ziffern werden normalerweise von links nach rechts in der Reihenfolge von der größten zur kleinsten Zahl geschrieben. Allerdings wird die Zahl 4 nicht als IIII geschrieben, sondern als IV. Da die Eins vor der Fünf steht, subtrahieren wir sie, und so erhalten wir vier. Das gleiche Prinzip gilt für die Zahl 9, die als IX geschrieben wird. Es gibt sechs Fälle, in denen Subtraktion angewendet wird:

- I kann vor V (5) und X (10) stehen, um 4 und 9 zu bilden. 
- X kann vor L (50) und C (100) stehen, um 40 und 90 zu bilden. 
- C kann vor D (500) und M (1000) stehen, um 400 und 900 zu bilden.

Schreiben Sie ein Programm, welches Ihnen eine römische Zahl in eine arabische (numerische) Zahl umrechnet!

  #tip[
    Sie werden durch den String iterieren müssen. Nutzen Sie dafür die Methode ```java String.getChar(int i)```, wobei hier i der Index ist, an dem Sie den Wert auslesen möchten. Beispiel:
    ```java 
    String s = "Hallo";
    System.out.println("Buchstabe an der ersten Stelle von " + s + " ist " + s.charAt(0) + "."); //Buchstabe an der ersten Stelle von Hallo ist H.
    ```
    \
  ]
], [
    #subtask(points: 5)[
    Legen Sie ein neues Projekt an. Geben Sie dabei dem Projekt einen Namen, der Ihre Matrikelnummer und Ihren Namen enthält. 
    Erstellen Sie eine Klasse mit einer Methode, die einen entsprechenden Namen und Parameter sowie Rückgabewert enthält.
    ]
    #subtask(points: 30)[
      Implementieren Sie die Funktion, die oben angegeben ist. Schreiben Sie zudem eine `main`-Methode, welche die Methode gegen Testinput laufen lässt.
    ]
    #subtask(points: 5)[
      Legen Sie Ihr Projekt auf der externen Festplatte ab, die Sie von der Klausuraufsicht zur Verfügung gestellt bekommen. Fragen Sie einfach, falls Sie Ihr Projekt ablegen möchten. Nachdem das Projekt abgelegt worden ist, gibt es keine weiteren Möglichkeiten, Änderungen zu machen. 
    ]

], (
    (4, [Der Code hat den richtigen Coding Style und sieht ordentlich aus.]),
    (8, [Der Code funktioniert wie beschrieben und gibt bei richtigem Input eine richtige Antwort zurück.]),
    (4, [Das Programm ist gegen Fehler durch falsche Eingaben gesichert. Ein nicht definiertes Zeichen führt zu einem Abbruch der Operation.]),
    (4, [Das Programm ist gegen Fehler durch falsche Eingaben gesichert. Es wurde ein entsprechendes Exception Handling implementiert.]),
    (5, [Es ist ein Projekt mit entsprechendem Namen, sowie eine Klasse und eine Methode angelegt.]),
    (5, [Die Methode ist entsprechend benannt, hat Parameter und Rückgabewert, die mit der Aufgabenstellung zusammenpassen.]),
    (5, [Es gibt eine main-Methode in einer der Klassen, die ausführbar ist und den Code gegen Testinput testet.]),
    (5, [Das Projekt ist auf der Festplatte, ist richtig benannt und kann geöffnet werden.]),
))

