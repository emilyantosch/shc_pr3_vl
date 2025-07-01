#import "@preview/touying:0.5.2": *
#import themes.university: *

#import "@preview/fletcher:0.5.1" as flechter: diagram, node, edge

#import "@preview/gentle-clues:1.0.0": *
#import "@preview/pinit:0.2.0": *
#import "@preview/codly:1.0.0": *
#show: codly-init.with()

#import "@preview/numbly:0.1.0": numbly

#set text(lang: "en", font: "Roboto")
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
    title: [Object-Oriented Programming in Java],
    subtitle: [Lecture 3 - Classes and Objects],
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

= Introduction

== Where Are We Now?

- Last time we dealt with the imperative concepts of the Java programming language.
- You can now
  - use simple data types in Java,
  - control program flow with control structures and loops, and
  - convert data types.
- Today we'll cover *Classes and Objects*.

#slide[
  1. Imperative Concepts
  2. *Classes and Objects*
  3. Class Library
  4. Inheritance
  5. Interfaces
  6. Graphical User Interfaces
  7. Exception Handling
  8. Input and Output
  9. Multithreading (Parallel Computing)
]

== The Goal of This Chapter

- You will implement classes and objects in Java to model real things.
- You will create objects of a class and change their state through operations.
- You will apply additional programming guidelines to improve the quality and
  maintainability of your code.

= Classes and Objects

== Class

- A *class* is a blueprint for objects. It contains
  - *Attributes* (data fields) and
  - *Methods* (operations).
- Together, attributes and methods are called *members*.

#align(left + horizon)[

  #figure(
    image("../assets/img/2024_10_03_class_person_explain_rev01.png", height: 50%),
    caption: [UML notation of a Person class],
  )
]

#slide[
  - Data record of a class created in memory at runtime
  - Variables describe the *state* of the object
  - Methods describe the *capabilities* of the object
  - Terms for variables: *attributes*, *object variables*, *instance variables*

  #figure(
    image(
      "../assets/img/2024_10_10_klassen_methoden_attribute_rev01.png",
      height: 45%,
    ),
    caption: [Division of methods and attributes],
  )
]
== Relationship Between Class and Object

- Klasse: Beschreibung („Bauplan“) eines Datentyps
- Objekt einer Klasse: Erzeugtes Element des Datentyps
- Es können beliebig viele Objekte einer Klasse erzeugt werden.

#figure(
  image("../assets/img/2024_10_10_klassen_mehr_objekte_rev01.png", height: 60%),
  caption: [Mehrere Objekte aus einer Klasse],
)

== Classes in Java

- Klassen können über den folgenden Code deklariert werden:
```java
class Klassenname {
    Attribute
    Methoden
    }
```

#tip[Legen Sie jede Klasse in einer eigenen Datei an!]

== Example: Simple Class

#task[Lassen Sie uns diese einfache Klasse erstellen:
  - Klasse Student, beschrieben durch Name, Matrikelnummer und Studienbeginn (in
    Jahren)
]

#pause

```java
class Student {
    String name;
    int matrNumber;
    int enrolledYear;
  }
```

- Die Klasse hat weder Methoden noch eine Datenkapselung gegen Einfluss von außen.

#figure(
  image("../assets/img/2024_10_10_klassen_uml_student_rev01.png"),
  caption: [UML-Darstellung der Klasse, die wir eben erstellt haben],
)

== Example: One Class, Many Objects

- Klasse („Eine Klasse für alle Studierenden“):
  - Die Klasse ist ein neuer Datentyp.
  - Legt fest, durch welche Daten Studierende beschrieben werden

- Objekte („Für jede/n Studierende/n ein eigenes Objekt“):
  - Objekte sind Instanzen im Speicher.
  - Besitzen Struktur der Klasse, sind aber mit Daten gefüllt
  - Es können beliebig viele Objekte erzeugt werden.

#figure(
  image("../assets/img/2024_10_10_klassen_mehr_objekte_uml_rev01.png"),
  caption: [Aus einer Klasse lassen sich mehrere Objekte erstellen],
)

== Example: Local Variables

#slide[
  #question[Welche Werte haben die Variablen `count`, `jan` und `lena`?]

  ```java
  public class StudentDemo {
      public static void main(String[] args) {
          int count;
          Student lena, jan;
      }
    }
  ```
]

#slide[
  #question[Welche Werte haben die Variablen `count`, `jan` und `lena`?]
  #figure(
    image(
      "../assets/img/2024_10_10_klassen_primitiv_erklaerung_rev01.png",
      height: 50%,
    ),
    caption: [Primitive Datentypen vs. Objekte],
  )
]

== Example: `new` Operator
#slide[
  - Objekte werden durch den `new`-Operator erzeugt.
    ```java
    public class StudentDemo {
        public static void main(String[] args) {
            int count;
            Student lena, jan;
            lena = pin1nepin2wpin3 Student();
        }
    }
    ```
  #pinit-rect-from(2, [`new`-Operator])
  #pinit-highlight(1, 3)

]

#slide[
  - Schritt 1: `new`-Operator erzeugt Objekt.
    - Speicherplatz für Objekt (mit Objektvariablen) reservieren.
    - Objektvariablen mit Standardwerten initialisieren (mehr dazu gleich).

    #figure(
      image("../assets/img/2024_10_10_klassen_primitv_vergleich.png"),
      caption: [Erstellen von Referenz mit `new`],
    )

]

#slide[
  - Schritt 2: Zuweisung
    - Schreibt Referenz ("Adresse") des neuen Objekts in Variable `lena`.
    - Ist unabhängig vom `new`-Operator und der Erzeugung des Objekts

    #figure(
      image("../assets/img/2024_10_10_klassen_primitiv_zuordnung_rev01.png"),
      caption: [Zuweisung von Referenz an Variable],
    )
]

= Variablen und Speicher

== Objective

#conclusion[
  - Das haben wir uns bereits angeschaut:
    - Was sind Klassen und Objekte?
    - Wie deklariert man Klassen?
    - Wie erzeugt man Objekte?
]

- Im Folgenden wollen wir uns folgende Aspekte anschauen:
  - Zugriff auf Objektvariablen
  - Initialisierung von Objektvariablen
  - Zuweisung von Referenzen
  - Automatische Speicherbereinigung

== Access to Object Variables

- Zugriff auf Objektvariablen erfolgt mittels des Punkt-Operators:
```java
Objektreferenz.Member
```
- Dabei ist die `Objektreferenz` eine Referenz auf ein Objekt, die in einer
  Variable gespeichert ist.
- `Member` ist z.B. ein Attribut/Objektvariable

#slide[
  #question[Was wird ausgegeben?]
  #text(size: 16pt)[

    ```java
    public class StudentDemo1 {
        public static void main(String[] args) {
          Student lena = new Student();
          System.out.println("Enrolled: " + lena.enrolledYear);
          lena.name = "Lena";
          lena.matrNumber = 591753;
          lena.enrolledYear = 2012;
          System.out.println("Enrolled: " + lena.enrolledYear);
        }
      }
    ```
  ]
]
== Initialization of Classes
#align(left + horizon)[

  #memo[
    - *Objekt-/Instanzvariable*: In Klasse als Attribut eines Objektes deklariert.
    - *Lokale Variable*: Lokal deklariert (z.B. in Methode oder Schleife).
    - *Referenzvariable*: Hat Klasse als Datentyp, kann Referenz auf Objekt speichern.
  ]
]
#slide[

  - Zur Erinnerung:
    - Lokale Variablen werden nicht automatisch initialisiert. (Compiler verhindert
      Zugriff.)
    - Objektvariablen werden hingegen bei Erzeugung eines Objektes initialisiert.

  #figure(
    image(
      "../assets/img/2024_10_10_klassen_datentypen_initial_rev01.png",
      height: 40%,
    ),
    caption: [Initialwerte von Objektvariablen],
  )
]

#slide[
  - Initiale Werte können auch in der Klasse selbst festgelegt werden.

  ```java
  class Student {
    String name = "Unbekannt";
    int matrNumber;
    int enrolledYear = 2019;
  }
  ```
]

#slide[
  #question[Was wird ausgegeben in dem folgenden Code?]
  #text(size: 16pt)[

    ```java
    public class StudentDemo {
        public static void main(String[] args) {
          Student lena = new Student();
          System.out.println("Name:     " + lena.name);
          System.out.println("Number:   " + lena.matrNumber);
          System.out.println("Enrolled: " + lena.enrolledYear);
          lena.name = "Lena";
          System.out.println("Name:     " + lena.name);
        }
      }
    ```
  ]
]

== Assignment of References

- Nehmen Sie an, wir haben den folgenden Zustand in unserem Code:

#figure(
  image("../assets/img/2024_10_10_klassen_referenz_zuweisung_rev01.png"),
  caption: [Zuweisung von Referenzen an Variablen],
)

#slide[

  #question[
    Was passiert jetzt, wenn wir den folgenden Code hinzufügen:
    ```java
    jan = lena;
    ```
  ]
]
#align(left + horizon)[
  #figure(
    image("../assets/img/2024_10_10_klassen_referenzen_verschieben_rev01.png"),
    caption: [Verschieben von Referenzen],
  )
]

#slide[
  #question[Was wird ausgegeben, wenn Sie den folgenden Code danach ausführen?]
  ```java
  lena.name = "Birgit";
  jan.name = "Kai";
  System.out.println(lena.name);
  System.out.println(jan.name);
  ```
]

#slide[
  - Jan und Lena, referenzieren nun *dasselbe* Objekt. Änderungen von Werten über `jan` betreffen
    dann auch `lena`.

  #figure(
    image("../assets/img/2024_10_14_referenzen_selbes_objekt_rev01.png"),
    caption: [Beide Variablen zeigen zur gleichen Referenz],
  )

]

#slide[
  - Das Objekt, was vorher über `jan` referenziert wurde, hat nun keine Referenz
    mehr.
  - Damit gibt es *keine* Möglichkeit mehr, auf das Objekt zuzugreifen.
  - Der *Garbage Collector* wird mittels *Reference Counting* den Speicher wieder
    freigeben.
  - Es gibt kein `free` oder `delete` wie in C!

    #figure(
      image("../assets/img/2024_10_14_referenz_objekt_verschwindet_rev01.png"),
      caption: [Der Garbage Collector gibt Speicher frei],
    )
]

= Methoden

== Methods: Syntax

- Methoden entsprechen Funktionen aus C, die Sie ja bereits kennen.
#text(size: 24pt)[

  ```java
  Rückgabetyp Methodenname(Parameter) {
   Anweisung;
  }
  ```
]

- Rückgabetyp
  - Primitiver Datentyp, Klasse eines Objekts oder `void`.
  - Rückgabe erfolgt wie in C mittels `return`.
- Methodenname
  - Beliebiger gültiger Bezeichner (siehe Kapitel 2)
  - Von unserem Coding Style: *camelCase* (ich erlaube auch *snake_case*)

#slide[
  - Methoden entsprechen Funktionen aus C, die Sie ja bereits kennen.
  #text(size: 24pt)[

    ```java
    Rückgabetyp Methodenname(Parameter) {
     Anweisung;
    }
    ```
  ]

  - Parameter
    - Leer oder durch Komma getrente Parameter
    - Jeder Parameter ist in der Form: `datentyp bezeichner`
  - Aufruf
    - Methodenname gefolgt von Klammern
    - Argumente in den Klammern
    - Ausdruck wird durch Rückgabewert ersetzt
]

== Methods: Examples

#slide[
  #task[Berechnen Sie den Mittelwert von zwei Fließkommazahlen.]

  #pause

  ```java
  public class MathUtils {
        double average(double a, double b) {
            return (a + b) / 2.0;
        }
    }
  ```
]

#slide[
  ```java
    public class MathUtilsDemo {
        public static void main(String[] args) {
            MathUtils math = new MathUtils();
            double a1 = 3.5, a2 = 7;
            double mean = math.average(a1, a2);
            System.out.println(mean);
            System.out.println(math.average(1.5, 3.2));
        }
    }
  ```
]

#slide[
  #task[Berechnen Sie die Summer aller Ziffern einer Ganzzahl.]

  #pause

  #text(size: 17pt)[
    ```java
    public class MathUtils {
          int sumOfDigits(int number) {
              int sum = 0;
              while(number > 0) {
                  sum += number % 10;
                  number /= 10;
              }
              return sum;
          }
      }
    ```
  ]

]
#slide[
  ```java
    public class MathUtilsDemo {
        public static void main(String[] args) {
            MathUtils math = new MathUtils();
            System.out.println(math.sumOfDigits(0));
            System.out.println(math.sumOfDigits(2016));
        }
    }
  ```
]

== Getters and Setters
#memo[
  - *Getter*: Methode, die den Wert einer Instanzvariable zurückgibt
  - *Setter*: Methode, die einer Instanzvariable einen (zu übergebenen) Wert zuweist
]

#slide[
  #text(size: 22pt)[
    ```java
    public class Student {
      String name;

      void setName(String studentName){
        name = studentName;
      }

      String getName(){
        return name;
      }

    }
    ```
  ]
]

== Methods: Call-by-Value

#slide[

  - Parameterübergabe bei Aufruf einer Methode:
    - Grundsätzlich der Wert der Variablen übergeben („Call by value“).
    - Nicht möglich, eine Art „Zeiger“ auf die Variable zu übergeben.
    - In Methode kann die beim Methodenaufruf verwendete Variable nicht verändert
      werden.

  ```java
  double square(double a) {
        a = a * a; // Local, does NOT modify b in main()
        return a;
    }
  ```
]

#slide[
  #align(left + horizon)[
    #figure(
      image("../assets/img/2024_10_14_methoden_callbyvalue_rev01.png"),
      caption: [Diagramm für Call-by-Value],
    )
  ]
]

== Methods: Objects as Parameters

- Referenzvariablen als Parameter:
  - Wert (d.h. gespeicherte Referenz) der übergebenen Variable wird nicht verändert.
  - Aber: Das referenzierte Objekt kann verändert werden!

```java
public class CallByValueDemo {
      static void setNameBirgit(Student student) {
          student.name = "Birgit";
          System.out.println(student.name);
      }
```
#slide[
  #align(left + horizon)[
    ```java
    public static void main(String[] args) {
              Student lena = new Student();
              lena.name = "Lena";
              setNameBirgit(lena);
              System.out.println(lena.name);
          }
      }
    ```
  ]
]

#slide[

  - Ursprünglicher Zustand in `main()`-Methode:

  #figure(
    image("../assets/img/2024_10_14_referenz_lena_objekt_rev01.png"),
    caption: [Ausgangszustand],
  )
]

#slide[

  - Aufruf der (unsinnigen) Methode `setNameBirgit()`:

  #figure(
    image("../assets/img/2024_10_14_referenz_lena_student_verschieben_rev01.png"),
    caption: [Verschieben der Referenz in die Methode],
  )
]

#slide[

  - Änderung des Objektes in der Methode `setNameBirgit()`:

  #figure(
    image("../assets/img/2024_10_14_referenz_lena_student_birgit_rev01.png"),
    caption: [Änderung des Objekts in Methode],
  )
]

== this Reference

#question[Schauen Sie sich den folgenden Code an. Was ist unschön?]

```java
public class Student {
      String name;

      void setName(String newName) {
          name = newName;
      }
  }
```

#slide[
  - Wir würden gerne den Parameter des Setters auch `name` nennen!

  #question[Funktioniert der folgende Aufruf?]

  ```java
  void setName(String name) {
      name = name;
  }
  ```
  #pause
  - Nein! Der Compiler würde jeweils auf die lokale Variable verwenden.
  - Wie können wir auf die Instanzvariable zugreifen?
]

#slide[
  #memo[
    - Mittels `this` können wir auf die derzeitige Instanz zugreifen, in der wir uns
      gerade befinden.
  ]
  #text(size: 22pt)[
    ```java
    public class Student {
          String name;

          void setName(String name) {
              this.name = name;
          }
      }
    ```
  ]
]

#slide[
  - Also
    - Wenn Sie auf eine lokale Variable zugreifen wollen, verwenden Sie einfach den
      Bezeichner der Variable
    - Wenn Sie auf eine Instanzvariable zugreifen wollen, verwenden Sie die `this`-Referenz
      mit dem Memberoperator mit `.`.

  #figure(
    image("../assets/img/2024_10_14_this_diagramm_rev01.png", height: 40%),
    caption: [`this`-Referenz],
  )
]

== Overloading

#slide[
  #task[Schreiben Sie eine Methode, die das Maximum zweier Integerzahlen berechnet.]
  #text(size: 22pt)[
    ```java
    int max(int a, int b) {
          if (a > b) {
              return a;
          } else {
              return b;
          }
      }
    ```
  ]
]

#slide[
  #task[Schreiben Sie eine weitere Methode in der selben Klasse, die das Maximum zweier `double`-Zahlen
    berechnet.]

  ```java
  double max(double a, double b) {
        return (a > b) ? a : b;  // Compact if/else syntax
    }
  ```
]

#slide[
  #task[Schreiben Sie noch eine weitere Methode in der selben Klasse, die das Maximum
    von drei Integerzahlen zurückgibt.]

  ```java
  int max(int a, int b, int c) {
       return max(max(a, b), c);
    }
  ```
]

#slide[
  - Überladene Methoden (overloading):
    - In einer Klasse existieren mehrere Methoden mit demselben Namen.
    - Nur möglich, falls Parametertypen unterschiedlich.
    - Compiler wählt anhand der Parameter die richtige Methode aus.

  ```java
  int max(int, int)
  double max(double, double)
  int max(int, int, int)
  ```
]

#slide[
  - Beachte:
    - Signatur: Methodenname und Parametertypen
    - Nur Datentypen der Parameter relevant (Unterscheidung durch Namen nicht möglich)
    - Unterscheidung durch Rückgabetyp reicht nicht (Warum?)
]

#slide[
  #memo[- Das sind nicht die gleichen Methoden!]
  #text(size: 18pt)[
    #align(left + horizon)[
      #grid(
        gutter: 12pt,
        columns: (auto, auto),
        [
          ```java
          int max(int a, int b) {
              if (a > b) {
                  return a;
              } else {
                  return b;
              }
          }
          ```
        ],
        [
          ```java
          short max(short a, short b) {
                System.out.println("Aaaarrrghhh!");
                return 7;
          }
          ```
        ],
      )
    ]
  ]
]

== Methoden: Coding Style
#slide[
  - Leerzeilen sollen die Lesbarkeit des Codes erhöhen.
  - Eine Leerzeile steht zwingend zwischen Methoden oder Klassen (1).
  - Eine Leerzeile steht in der Regel nach Deklarationen (2).
  - Eine Leerzeile steht in der Regel zwischen logischen Abschnitten.
]

#slide[
  #example[

    #text(size: 16pt)[
      ```java
      public class MyClass {

         public static int max(int a, int b) {
            return (a > b) ? a : b;
         }

         public static void swap(Object a, Object b) {
            Object temp;

            temp = a;
            a = b;
            b = temp;
         }
      }
      ```
    ]
  ]
]

#slide[
  - Leerzeichen sollen die Lesbarkeit des Codes erhöhen.
  - Ein Leerzeichen steht zwingend zwischen Ausdrücken.
  - Ein Leerzeichen steht in der Regel zwischen Operanden.

    #text(size: 18pt)[
      #align(left + horizon)[
        #grid(
          gutter: 12pt,
          columns: (auto, auto),
          [
            ```java
            public static void main(String[] args) {
               int a = 5;

               for (int i = 1; i < 10; i++) {
                  a *= i;
               }
            }
            ```
          ],
          [
            ```java
            public static void main(String[] args) {
               int a=5;

               for(int i=1;i<10;i++){
                  a*=i;
               }
            }
            ```
          ],
        )
      ]
    ]
]

== Was ein Kapitel!

- Wir haben in diesem Abschnitt eine Menge geschafft!
  - Syntax von Methoden
  - Parameter (call by value)
  - this-Referenz
  - Überladen von Methoden
  - Coding Style

Lassen Sie uns nun betrachten, wie man Objekte gezielt erzeugen und
initialisieren kann.

= Konstruktoren

== Konstruktoren

#memo[
  - Spezielle Methoden zur Initialisierung eines Objektes
    - Werden bei Erzeugung eines Objektes ausgeführt
    - Beachte: Konstruktoren haben keinen Rückgabetyp
]

```java
Klassenname(Parameter){
Anweisungen;
}
```

#slide[
  - Mittels des folgenden Codes könnte man einen Konstruktor für die Klasse `Student` erstellen:

  ```java
  public class Student {
        String name;

        Student(String name) {  // Achtung: Kein Rückgabetyp
            this.name = name;
        }
    }
  ```
]

#slide[
  - Standardkonstruktor: Konstruktor mit leerer Parameterliste
  - Initialisiert Instanzvariablen je nach Typ mit 0, 0.0, `false` oder `null`

  #example[
    ```java
    public class Student {
          String name;

          Student() {      // Standardkonstruktor
          }
      }
    ```
  ]
]

#slide[
  - Das vorige Beispiel könnte man auch so darstellen:
  ```java
  public class Student {
        String name;

        Student() {      // Standardkonstruktor
            name = null;
        }
    }
  ```
]

#slide[
  - Compiler erzeugt unter bestimmten Bedingungen automatisch den
    Standardkonstruktor
  - Einfache Regeln:
  1. Falls Sie für eine Klasse keinen Konstruktor schreiben:
    - Der Compiler erzeugt automatisch den Standardkonstruktor
  2. Falls Sie für eine Klasse mindestens einen Konstruktor schreiben:
    - Der Compiler erzeugt keinen Konstruktor
    - Es existieren nur die von Ihnen implementierten Konstruktoren
]

== `this`: Referenz vs. Methode
#slide[
  - `this`-Referenz (zur Erinnerung):
    - Verwendung innerhalb beliebiger (Instanz-)Methode
    - Wie eine Variable verwendet
    - Enthält Referenz auf Objekt, für das die Methode aufgerufen wurde

  - `this()`-Methode
    - Verwendung nur innerhalb eines Konstruktors.
    - Ist ein Methodenaufruf.
    - this(Parameterliste) ruft Konstruktor mit passender Parameterliste auf.
    - Darf nur als erste Anweisung im Konstruktor stehen.
]

#slide[
  #text(size: 15pt)[

    ```java
    public class Aircraft {
          String model, airline;
          int numberEngines;

          Aircraft() {
              numberEngines = 1;
          }

          Aircraft(String model) {
              this();
              this.model = model;
          }

          Aircraft(String model, String airline) {
              this(model);
              this.airline = airline;
          }
      }
    ```
  ]
]

== Konstruktoren: Beispiele

#slide[
  #question[Wird der folgende Code kompilieren? Was denken Sie?]
  ```java
  public class Aircraft {
        String model;

        public static void main(String[] args) {
            Aircraft aircraft = new Aircraft();
        }
    }
  ```
]

#slide[
  #success[
    - Ja, wird er!
      - Der Compiler erzeugt einen Standardkonstruktor, weil die Klasse keinen enthält.
      - Dieser wird dann in der `main()`-Methode nun aufgerufen!
  ]
]
#slide[
  #question[Wird der folgende Code kompilieren? Was denken Sie?]
  #text(size: 16pt)[

    ```java
    public class Aircraft {
          String model;

          Aircraft(String model) {
              this.model = model;
          }

          public static void main(String[] args) {
              Aircraft aircraft = new Aircraft();
          }
      }
    ```
  ]
]

#slide[
  #error[
    - Nein, wird er nicht!
      - Da die Klasse einen Konstruktor enthält, erzeugt der Compiler keinen
        Standardkonstruktor.
      - Der verwendete Konstruktor in der `main()`-Methode existiert daher nicht.
  ]
]
== Aufgabe: Klasse Circle
#slide[
  #task[
    - Lassen Sie uns eine Klasse Circle schreiben:
      - Repräsentiert einen geometrischen Kreis
        - Dargestellt durch
        - x- und y-Koordinate des Mittelpunktes
        - Radius r
      - Konstruktoren:
        - Standardkonstruktor erzeugt Einheitskreis um den Koordinatenursprung (0 ; 0)
        - Konstruktor mit x, y und Radius als Parametern
        - Konstruktor mit Radius als Parameter
        - Konstruktor mit Objekt der Klasse Circle als Parameter (erzeugt Kopie)
  ]
]

#slide[
  #text(size: 16pt)[
    ```java
    public class Circle {
      double x, y, radius;

      public Circle(double x, double y, double radius) {
          this.x = x;
          this.y = y;
          this.radius = radius;
      }

      Circle() {
          this(0.0, 0.0, 1.0);
      }

      Circle(double radius) {
          this(0.0, 0.0, radius);
      }

      Circle(Circle circle) {
          this(circle.x, circle.y, circle.radius);
      }
    }
    ```
  ]
]

#slide[
  #text(size: 18pt)[
    - Die Klasse, die wir eben geschrieben haben, können wir wie folgt erzeugen:

      ```java
      public class CircleDemo {
            public static void main(String[] args) {
                Circle circle1 = new Circle();
                Circle circle2 = new Circle(2.5);
                Circle circle3 = new Circle(circle2);
                Circle circle4 = new Circle(-1.2, 7.1, 3.0);
            }
        }
      ```

    #tip[
      Folgender Menüpunkt in IntelliJ IDEA kann Ihnen viel Arbeit ersparen: Code /
      Generate / Constructor
    ]
  ]
]

#slide[
  #task[Erweitern Sie die Klasse um Getter und Setter-Methoden.]
  #tip[Über die Menüpunkte Code / Generate / Getter and Setter können Sie sich weitere
    Zeit sparen!]
]

#slide[
  #text(size: 20pt)[
    ```java
    double getX() {
        return x;
    }

    // getY() und getRadius() entsprechend

    void setX(double x) {
        this.x = x;
    }

    void setY(double y) {
        this.y = y;
    }

    void setRadius(double radius) {
        if (radius >= 0.0) {        // Nicht erlaubte Daten verhindern
            this.radius = radius;
        }
    }
    ```
  ]
]

= Klassenvariablen & Klassenmethoden

== Klassenvariablen

#slide[
  #question[Glauben Sie, dass Sie die Variable `PI` nur einmal im Speicher reservieren?]
  #text(size: 18pt)[
    ```java
    public class Circle {
          double x, y, radius;
          final double PI = 3.141592653589793;

          double getArea() {
              return PI * radius * radius;
          }
      }
    ```
  ]
]

#slide[
  #error[
    - Antwort: Nein, für jedes Objekt erneut!
  ]

  #figure(
    image("../assets/img/2024_10_14_objekt_circle_rev01.png", height: 40%),
    caption: [Speicher wird für jedes Objekt erneut reserviert.],
  )
]

#slide[
  #question[Was meinen Sie, zählt die Variable `count` die Anzahl der Objekte?]
  #text(size: 17pt)[
    ```java
    public class Circle {
          double x, y, radius;
          int count;    // Count number of objects created

          Circle() {
              radius = 1.0;
              count++;
          }
      }
    ```
  ]
]

#slide[
  #error[
    - Antwort: Nein, jedes Objekt bekommt eine neue Variable `count`!
  ]

  #figure(
    image("../assets/img/2024_10_15_circle_count_rev01.png", height: 40%),
    caption: [Die Variable `count` wird immer wieder neu gemacht.],
  )
]

#slide[

  - Eine Lösung sind *Klassenvariablen*!
  - Klassenvariablen werden nur einmal für die gesamte Klasse angelegt
  - Werden nicht für ein bestimmtes (nicht für jedes Objekt) angelegt
  - Werden bereits bei Programmstart (Laden der Klasse) erzeugt
    - Sie existieren auch dann, wenn es (noch) kein Objekt der Klasse gibt.
  - Syntax: Variable mit Schlüsselwort static
]

#slide[
  #figure(
    image("../assets/img/2024_10_15_klassenattribute_rev01.png"),
    caption: [Klassenattribute in den verschiedenen Objekten],
  )
]

#slide[
  - Klasse `Circle` mit Klassenvariablen:
    #text(size: 17pt)[

      ```java
      public class Circle {
            double x, y, radius;
            static final double PI = 3.141592653589793;
            static int count;

            double getArea() {
                return PI * radius * radius;
            }

            Circle() {
                radius = 1.0;
                count++;
            }
        }
      ```
    ]
]

#slide[
  - Zugriff auf Klassenvariablen
    - Innerhalb der Methode der Klasse entspricht es dem Zugriff auf Instanzvariablen
    - Außerhalb der Klasse ```java Klassenname.Variablenname```
    #text(size: 18pt)[

      ```java
        public class CircleDemo {
              public static void main(String[] args) {
                  Circle circle1 = new Circle();
                  Circle circle2 = new Circle();
                  Circle circle3 = new Circle();

                  System.out.println("Anzahl Objekte: " + Circle.count);
              }
          }
      ```

    ]
]

== Klassenmethoden

#slide[

  - Vollkommen analog zu Klassenvariablen:
    - Klassenmethoden werden für eine Klasse aufgerufen
    - Werden nicht für ein bestimmtes Objekt aufgerufen
    - Methode wird durch Schlüsselwort static zur Klassenmethode
    - Können aufgerufen werden, ohne dass Objekt der Klasse erzeugt wurde

  - Aufruf außerhalb der Klasse:
  ```java
  Klassenname.Methodenname
  ```
]

#slide[
  #memo[
    - Wichtige Konsequenzen:
      - `this`-Referenz existiert nicht in Klassenmethoden
      - Instanzvariablen existieren nicht in Klassenmethoden
  ]
]

#slide[
  #example[
    - In diesem Beispiel sind zwei Klassenmethoden!
      #text(size: 14pt)[

        ```java
        public class Circle {
              double x, y, radius = 1.0;

              static double getPi() {
                  return 3.141592653589793;
              }
          }

          public class CircleDemo {
              public static void main(String[] args) {
                  System.out.println("Pi: " + Circle.getPi());
              }
          }
        ```

      ]
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
