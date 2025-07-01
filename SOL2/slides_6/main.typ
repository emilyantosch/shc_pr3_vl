#import "@preview/touying:0.5.2": *
#import themes.university: *

#import "@preview/fletcher:0.5.1" as flechter: diagram, node, edge
#import "@preview/wrap-it:0.1.0": wrap-content

#import "@preview/gentle-clues:1.0.0": *
#import "@preview/pinit:0.2.0": *
#import "@preview/codly:1.0.0": *
#show: codly-init.with()

#import "@preview/numbly:0.1.0": numbly

#set text(lang: "de", font: "Roboto")
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
    subtitle: [Vorlesung 6 - Abstrakte Elemente],
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

- In der letzten Vorlesung ging es um Vererbung
- Sie können nun
  - einfache Vererbungslinien erzeugen und verwenden,
  - Methoden aus der Basisklasse überlagern,
  - die `equals()`-Methode verwenden, um Objekte miteinander zu vergleichen,
  - Objekte über die jeweilige Basisklasse referenzieren
- Heute geht es weiter mit den *Schnittstellen*.

#slide[
  1. Imperative Konzepte
  2. Klassen und Objekte
  3. Klassenbibliothek
  4. Vererbung
  5. *Schnittstellen*
  6. Graphische Oberflächen
  7. Ausnahmebehandlung
  8. Eingaben und Ausgaben
  9. Multithreading (Parallel Computing)
]

== Das Ziel dieses Kapitels

- Sie bilden gemeinsame Eigenschaften von Klassen ab, indem Sie Klassen um gemeinsame Schnittstellen (in Form von abstrakten Basisklassen oder Interfaces) erweitern.
- Sie verbergen den Datentyp von Objekten, indem Sie Objekte beim Zugriff auf gemeinsame Eigenschaften unterschiedlicher Klassen über Schnittstellen referenzieren.
- Sie sortieren eine Sammlung von Objekten gleichen Datentyps nach beliebigen Kriterie

= Abstrakte Elemente & Methoden
== Abstrakte Elemente
#slide[
  #text(size: 18pt)[
    #question[
      - Erinnern Sie sich an unsere geometrischen Objekte?
      - Was stört Sie am bisherigen Aufbau unserer Klassen?
      - Was ergibt keinen Sinn bzw. ist „unschön“?

    ]
  ]
  #pause
  #figure(
    image("../assets/img/2024_10_23_geometrische_form_ohneAbstrakt_rev01.png", height: 50%),
    caption: [Überlagern der Methode aus Shape],
  )

]

#slide[

  #let body = [

    #text(size: 16pt)[

      - Klasse wird durch Schlüsselwort abstract zu abstrakter Klasse
      - Effekt: Es können keine Objekte der Klasse erstellt werden.
      - Stattdessen:
        - Klasse ableiten und in (konkreten = nicht abstrakten) Subklassen erweitern
        - Objekte der Subklassen erstellen
      ```java
      	public abstract class A {
      	    // ...
      	}

      	public class B extends A {
      	    // ...
      	}

      	public static void main(String[] args) {
      	    A abstractObj = new A();
      	    B concreteObj = new B();
      	}
      ```
    ]
  ]
  #let fig = [
    #align(center + horizon)[
      #figure(image("../assets/img/2024_10_23_abstrakte_klasse_rev01.png"))
    ]
  ]
  #grid(
    columns: (70%, 30%),
    gutter: 0.25em,
    body, fig,
  )
]

#slide[
  #text(size: 18pt)[

    #let top = [
      - Methode wird durch das Schlüsselwort abstract zur abstrakten Methode
      - Abstrakte Methode enthält nur die Deklaration, aber keine Implementierung
    ]
    #let mid = [
      #let left = [
        ```java
        public abstract class ImageSource {
        	    String name;

        	    public abstract Image getNextImage();
        	}
        ```
      ]
      #let right = figure(image("../assets/img/2024_10_23_abstrakte_methoden_rev01.png"))
      #grid(
        columns: (60%, 40%),
        gutter: 0.05em,
        left, right,
      )
    ]
    #let bot = [
      #memo[
        - Abstrakte Methoden können nicht aufgerufen werden (existiert keine Implementierung!)
        - Gibt stattdessen vor, welche Methoden Subklassen besitzen müssen
      ]
    ]
    #grid(rows: (auto, 30%, auto), gutter: 2.5em, top, mid, bot)
  ]
]

#slide[
  #text(size: 16pt)[

    #let body = [

      - Klassen mit abstrakten Methoden müssen abstrakt sein.
      - Ansonsten könnten für Objekte nicht implementierte Methoden aufgerufen werden.
      - Vererbung:
        - Abstrakte Methoden werden vererbt.
        - Subklassen abstrakt, solange nicht alle abstrakten Methoden implementier

      ```java
      	public abstract class ImageSource {
      	    String name;

      	    public abstract Image getNextImage();
      	}

      	public class Camera extends ImageSource {
      	    public Image getNextImage() {
      	        // ...
      	    }
      	}
      ```
    ]
    #let fig = figure(image("../assets/img/2024_10_23_abstrakte_klasse_methode_rev01.png"))
    #grid(
      columns: (80%, 20%),
      gutter: 0.25em,
      body, fig,
    )
  ]
]

#slide[
  #figure(
    image("../assets/img/2024_10_24_abstrakt_klasse_methode_baum_rev01.png", height: 90%),
    caption: [Großer Overview über Abstrakte Klassen und Methoden],
  )
]

#slide[
  #task[
    - Verbessern Sie nun den Aufbau der Klassenstruktur.
    - Verwenden Sie hierfür abstrakte Elemente.
  ]
  #figure(image("../assets/img/2024_10_24_geom_form_ohne_erkl_rev01.png", height: 50%))
]

#slide[
  #text(size: 18pt)[
    - Keine Objekte der Klasse Shape, sondern nur von konkreten geometrischen Formen
    - Alle Klassen für geometrischen Formen besitzen getArea().
    - Implementierung je nach Typ der geometrischen Form
      #figure(
        image("../assets/img/2024_10_24_geom_formen_abst_impl_rev01.png", height: 60%),
        caption: [Abstrakte und implementierte Methoden],
      )

  ]
]
= Interfaces
== Interfaces
#slide[
  - Klassen (zur Erinnerung):
    - Konkrete Klassen können keine abstrakten Methoden enthalten.
    - Abstrakte Klassen können zusätzlich abstrakte Methoden enthalten.

  - Grundlegende Idee einer Schnittstelle:
    - Deklariert lediglich abstrakte Methoden
    - Gibt also vor, welche Methoden eine Klasse implementieren muss
    - Enthält keine Variablen (Kein Objekt erzeugbar: keine Konstruktoren benötigt)
    - Beschreiben oft Eigenschaften (z.B. Comparable, Cloneable, Scalable, …)
]

#slide[
  - Sichtbarkeit:
    - Alle Methoden sind public abstract (auch wenn Modifier fehlen).
    - Alle Attribute sind public static final (auch wenn Modifier fehlten).

  - Ab Java 8 auch implementierte Methoden:
    - Default-Methoden: Vergleichbar mit herkömmlichen Methoden in einer Klasse
    - Statische Methoden
]

#slide[
  #figure(
    image("../assets/img/2024_10_24_abstufung_klas_abst_inter_rev01.png"),
    caption: [Abstufung zwischen Konkret, Abstrakt und Interface],
  )
]

#slide[
  #text(size: 20pt)[

    #let body = [
      - Deklaration einer Schnittstelle:
      ```java
      	  Modifier interface Schnittstellenname {
      		Konstanten
      		Abstrakte Methoden
      		Default-Methoden und statische Methoden
      	  }
      ```

      - Deklariere Methode `resize()`, um Größe eines Objektes zu ändern
      ```java
      	public interface Scalable {
      	    void resize(double factor);
      	}
      ```
    ]
    #let fig = figure(image("../assets/img/2024_10_24_scalable_interface_rev01.png"))
    #grid(
      columns: (75%, 25%),
      gutter: 0.25em,
      body, fig,
    )
  ]
]

#slide[
  #text(size: 16pt)[
    #let body = [

      - Klassen implementieren Schnittstellen über das Schlüsselwort implements
      - Klasse erbt Elemente der Schnittstelle und implementiert abstrakte Methoden
      ```java
      	public class Vector2D implements Scalable {
      	    private double x, y;

      	    public Vector2D(double x, double y) {
      	        this.x = x;
      	        this.y = y;
      	    }

      	    public void resize(double factor) {
      	        x *= factor;
      	        y *= factor;
      	    }
      	    // Weitere Methoden ...
      	}
      ```
    ]
    #let fig = figure(image("../assets/img/2024_10_24_scalable_interface_vector_rev01.png"))
    #grid(
      columns: (70%, 30%),
      gutter: 0.25em,
      body, fig,
    )
  ]
]

#slide[
  #text(size: 18pt)[
    - Interface-Methode nicht implementiert: Methode bleibt abstrakt
    - Daher dann auch die Klasse abstrakt
    - Subklassen erst dann konkret, wenn alle abstrakten Methoden implementiert

  ]

  #figure(
    image("../assets/img/2024_10_24_scalable_interface_abstrakt_vector_rev01.png", height: 60%),
    caption: [Abstrakte Klassen und Interfaces],
  )
]

#slide[
  #text(size: 18pt)[
    #let body = [

      - Zur Erinnerung: Mehrfachvererbung für Klassen nicht erlaubt
      - Aber: Implementierung beliebig vieler Schnittstellen (durch Kommas getrennt) erlaubt

      ```java
      	interface Interface1 {
      	    // ...
      	}

      	interface Interface2 {
      	    // ...
      	}

      	class ClassA implements Interface1, Interface2 {
      	    // ...
      	}
      ```
    ]
    #let fig = figure(image("../assets/img/2024_10_24_double_interface_rev01.png"))
    #grid(
      columns: (80%, 20%),
      gutter: 0.25em,
      body, fig,
    )
  ]
]

#slide[
  #text(size: 16pt)[
    Klasse GrayImage implementiert Scalable, Drawable und Rotateable
    ```java
    	public class GrayImage implements Scalable, Drawable, Rotateable {
    	    // Attribute und Konstruktoren
    	    // Methoden der Schnittstellen
    	    // Weitere Methoden
    }
    ```

    #figure(image("../assets/img/2024_10_24_grayimage_interface_rev01.png", height: 50%), caption: [GrayImage-Beispiel])
  ]
]

#slide[
  #text(size: 16pt)[
    #let body = [

      - Schnittstellen können durch extends abgeleitet werden.
      - Für Schnittstellen ist Mehrfachvererbung erlaubt!

      ```java
      	interface Interface1 {
      	    // ...
      	}

      	interface Interface2 {
      	    // ...
      	}

      	interface Interface3 extends Interface1, Interface2 {
      	    // ...
      	}

      	class ClassA implements Interface3 {
      	    // ...
      	}
      ```
    ]
    #let fig = figure(image("../assets/img/2024_10_24_interface_vererbung_rev01.png"))
    #grid(
      columns: (65%, 35%),
      gutter: 0.25em,
      body, fig,
    )
  ]
]

#slide[
  #text(size: 16pt)[
    #let body = [
      - Genauso wie bei Basisklassen:
        - Objekte über Datentypen ihrer implementierten Schnittstellen referenzierbar
        - Referenzvariable kann nur auf Attribute und Methoden ihrer Schnittstelle zugreifen
        #question[
          - Welche Zugriffe auf Attribute sind zulässig und welche nicht?
        ]

      ```java
      	public static void main(String[] args) {
      	    Vector2D classRef = new Vector2D(1, 3);
      	    Scalable interRef = classRef;

      	    classRef.resize(1.5);
      	    System.out.println(classRef.getX());
      	    interRef.resize(1.5);
      	    System.out.println(interRef.getX());
      	}
      ```

    ]
    #let fig = figure(image("../assets/img/2024_10_24_scalable_vector_voll_rev01.png"))
    #grid(
      columns: (80%, 20%),
      gutter: 0.25em,
      body, fig,
    )
  ]
]

#slide[
  #text(size: 18pt)[
    #task[
      - Erstellen Sie eine Schnittstelle Transformable mit folgenden Methoden:
        - Verschieben
        - Rotation um 90° (je eine Methode für Rotation nach links und nach rechts)
        - Skalieren
        - Implementieren Sie die Schnittstelle in allen Klassen geometrischer Formen
    ]
    #figure(image("../assets/img/2024_10_24_geom_form_ohne_erkl_rev01.png", height: 45%))
  ]
]

= Vergleich (Interface `Comparable`)

== Interface `Comparable`

#slide[
  #text(size: 18pt)[
    #let body = [
      - Vergleich von Objekten (Welches ist „größer“, welches „kleiner“?)

      ```java
      	public interface Comparable<Type> {
      	    public int compareTo(Type other);
      	}
      ```
      - Verwendung:
        - Schnittstelle in eigener Klasse implementieren
        - Platzhalter Type durch eigenen Klassennamen ersetzen
        - Rückgabewert wird wie folgt gedeutet:
        #figure(image("../assets/img/2024_10_24_comparable_returnvalue_rev01.png"))
    ]

    #let fig = figure(image("../assets/img/2024_10_24_comparable_A_rev01.png"))
    #grid(
      columns: (80%, 20%),
      gutter: 0.25em,
      body, fig,
    )
  ]
]

#slide[
  #text(size: 15pt)[
    #let body = [
      - Vergleich von Vektoren anhand des Betrages:
      ```java
      	public class Vector2D implements Comparable<Vector2D> {
      	    double x, y;

      	    public double getAbs() {
      	        return Math.sqrt(x * x + y * y);
      	    }

      	    public int compareTo(Vector2D other) {
      	        if (getAbs() < other.getAbs()) {
      	            return -1;
      	        } else if (getAbs() > other.getAbs()) {
      	            return 1;
      	        } else {
      	            return 0;
      	        }
      	    }
      	}
      ```
    ]
    #let fig = figure(image("../assets/img/2024_10_24_comparable_vector_rev01.png"))
    #grid(
      columns: (80%, 20%),
      gutter: 0.25em,
      body, fig,
    )
  ]
]

#slide[
  #text(size: 15pt)[
    #let body = [
      - Listen über Klassenmethode `Collections.sort()` sortieren
      - Voraussetzung: Elemente in Liste implementieren Comparable
      - Methode `sort()` verwendet paarweise die Vergleichsmethode `compareTo()`
      ```java
      	public static void main(String[] args) {
      	    ArrayList<Vector2D> vectors = new ArrayList<Vector2D>();
      	    vectors.add(new Vector2D(0, 5));
      	    vectors.add(new Vector2D(0, -1));
      	    vectors.add(new Vector2D(7, 8));
      	    vectors.add(new Vector2D(0, 0));

      	    Collections.sort(vectors);
      	    for (Vector2D vector : vectors) {
      	        System.out.println(vector.getAbs());
      	    }
      	}
      ```


    ]
    #let fig = figure(image("../assets/img/2024_10_24_comparable_vector_rev01.png"))
    #grid(
      columns: (80%, 20%),
      gutter: 0.25em,
      body, fig,
    )
  ]
]

#slide[
  #text(size: 18pt)[
    #task[
      - Implementieren Sie `Comparable<Type>` für geometrische Objekte.
      - Kriterium für den Vergleich ist die Fläche der Objekte.
    ]
    #figure(image("../assets/img/2024_10_24_geom_form_ohne_erkl_rev01.png", height: 50%))

  ]
]

#slide[
  #text(size: 18pt)[
    #memo[
      - Nur die Klasse `Shape` muss `Comparable` implementieren.
      - Die übrigen Klassen erben die Schnittstelle und Implementierung.
    ]
    #figure(image("../assets/img/2024_10_24_comparable_shape_rev01.png", height: 50%))

  ]
]

#slide[
  #text(size: 15pt)[
    - Implementierung in Shape:
    ```java
    public abstract class Shape implements Comparable<Shape> {
        // Attribute und andere Methoden ...

        public int compareTo(Shape other) {
            double thisArea = getArea();
            double otherArea = other.getArea();

            if (thisArea < otherArea) {
                return -1;
            } else if (thisArea > otherArea) {
                return 1;
            } else {
                return 0;
            }
        }
    }
    ```
  ]
]

#slide[
  #text(size: 15pt)[
    ```java
    	public static void main(String[] args) {
    	    ArrayList<Shape> shapes = new ArrayList<Shape>();
    	    shapes.add(new Circle(0.0, 0.0, 2.0));
    	    shapes.add(new Circle(0.0, 0.0, 1.0));
    	    shapes.add(new Rectangle(0.0, 0.0, 10.0, 5.0));
    	    shapes.add(new Square(0.0, 0.0, 0.5));

    	    System.out.println("Flächen (unsortiert):");
    	    for (Shape shape : shapes) {
    	        System.out.println(shape.getArea());
    	    }

    	    Collections.sort(shapes);
    	    System.out.println("\nFlächen (sortiert):");
    	    for (Shape shape : shapes) {
                System.out.println(shape.getArea());
            }
        }
    ```
  ]
]

= License Notice

== Attribution

- This work is shared under the CC BY-NC-SA 4.0 License and the respective Public
  License
- #link("https://creativecommons.org/licenses/by-nc-sa/4.0/")
- This work is based off of the work Prof. Dr. Marc Hensel.
- Some of the images and texts, as well as the layout were changed.
- The base material was supplied in private, therefore the link to the source
  cannot be shared with the audience.
