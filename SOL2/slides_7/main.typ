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

- In der letzten Vorlesung ging es um Schnittstellen und abstrakte Klassen
- Sie können nun
  - abstrakte Klassen verwenden, um ihren Code noch genau zu strukturieren,
  - Schnittstellen implementieren, um Eigenschaften von Klassen darzustellen,
  - Klassen und Objekten mit einer Ordnung mittels `Comparable` belegen,
- Heute geht es weiter mit den *graphischen Oberflächen*.

#slide[
  1. Imperative Konzepte
  2. Klassen und Objekte
  3. Klassenbibliothek
  4. Vererbung
  5. Schnittstellen
  6. *Graphische Oberflächen*
  7. Ausnahmebehandlung
  8. Eingaben und Ausgaben
  9. Multithreading (Parallel Computing)
]

== Das Ziel dieses Kapitels
- Sie erstellen grafische Oberflächen mit z.B. Menüs, Buttons und Textfeldern.
- Sie zeichnen Diagramme aus einfachen geometrischen Formen (z.B. Linien, Kreise).
- Sie reagieren auf Ereignisse (z.B. Drücken eines Buttons), indem Sie grafische Elemente mit bei Benutzereingaben auszuführenden Methoden verbinden.
- Sie verwenden das Observer-Pattern, damit Objekte beliebiger Datentypen auf Ereignisse reagieren können.


= Grundlegende Struktur
== Graphische UI

#slide[
  #text(size: 18pt)[
    #question[
      - Welche Arten von Elementen sehen Sie?
      - Wie reagieren die Elemente? Hängen hierbei Elemente zusammen?
    ]
  ]
  #figure(image("../assets/img/2024_10_25_windows_explorer_rev01.png", height: 50%), caption: [Windows 7 Explorer])
]

#slide[
  #text(size: 18pt)[

    - Grafische Benutzeroberfläche: Graphical user interface (GUI)
    - Klassenbibliotheken AWT und Swing bereits im Java SDK enthalten

    - Abstract Window Toolkit (AWT):
      - Bereits mit Java 1.0 eingeführt
      - Nur grundlegende Oberflächenelemente, um möglichst viele Betriebssysteme zu unterstützen („Kleinster gemeinsamer Nenner“)
      - Setzt die nativen Elemente („Widgets“) des Betriebssystems ein
      - Ursprünglich voller Design-Fehler, da unter großem Druck in nur knapp zwei Monaten entstanden

    - Swing:
      - Erweiterung des AWT
      - Kein direktes Ansprechen der Fensterfunktionen der aktuellen Plattform mehr
      - Komplette Kontrolle über die Anzeigeelemente
  ]
]

#slide[
  #text(size: 18pt)[
    - Basiselement: Rahmen (Frame)
    - Beinhaltet Fensterleiste mit Titel und Steuerelementen (z.B. „Schließen“)
    - Beinhaltet Bereich, in dem Elemente platziert werden können (Content pane)
    - Kann zusätzlich Menüleiste (Menu bar) enthalten

    #figure(
      image("../assets/img/2024_10_25_window_frame_aufbau_rev01.png", height: 50%),
      caption: [Aufbau eines Frames],
    )
  ]
]

#slide[
  #text(size: 18pt)[
    - Elemente werden hierarchisch hinzugefügt.
    - Für Elemente, die andere Elemente aufnehmen, lässt sich das Layout angeben.
    #figure(
      image("../assets/img/2024_10_25_window_frame_hierarchie_rev01.png", height: 70%),
      caption: [Hierarchie eines Windows],
    )
  ]
]


= Graphische Oberflächen erzeugen
== Einfaches Programm

#slide[
  #text(size: 18pt)[
    - Ausführbare main()-Methode erzeugt Objekt der Klasse
    - Klasse erzeugt im Konstruktur Frame mit grafischer Oberfläche
    - „Close Operation“ so angeben, dass Anwendung bei Schließen des Fensters beendet wird

    ```java
    	public class HelloWorld {
    	    public HelloWorld() {
    	        JFrame frame = new JFrame("GUI example");
    	        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
    	        frame.setVisible(true);
    	    }

    	    public static void main(String[] args) {
    	        new HelloWorld();
    	    }
    	}
    ```
  ]
]

#slide[

  #text(size: 18pt)[
    #question[
      - Was passiert, wenn die „Close Operation“ nicht auf „Exit on close“ gesetzt wird?
      - Warum muss man das Fenster extra über setVisible(true) anzeigen?
    ]
    #let left = [
      - Und es sieht nicht wirklich schön aus:
        - Das Fenster ist zu klein!
        - Das Fenster „klebt“ in der linken oberen Ecke!
    ]
    #let right = figure(image("../assets/img/2024_10_25_window_frame_mini_rev01.png", height: 20%))
    #grid(
      columns: (60%, 40%),
      gutter: 0.25em,
      left, right,
    )

    #task[
      - Vergrößern Sie es auf 400 x 300 Pixel (Breite x Höhe).
      - Platzieren Sie es jeweils 50 Pixel vom linken und vom oberen Rand.
      - Hinweis: Lassen Sie sich die Methoden von frame anzeigen.
    ]
  ]
]


#slide[
  #text(size: 18pt)[
    #let body = [
      - Korrigierte Größe und Position:

      ```java
      	public class HelloWorld {
      	    public HelloWorld() {
      	        JFrame frame = new JFrame("GUI example");
      	        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
             frame.setSize(400, 300);
      	        frame.setLocation(50, 50);
      	        frame.setVisible(true);
      	    }

      	    public static void main(String[] args) {
      	        new HelloWorld();
      	    }
      	}
      ```
    ]
    #let fig = figure(image("../assets/img/2024_10_25_window_frame_empty_rev01.png"))
    #grid(
      columns: (70%, 30%),
      gutter: 0.25em,
      body, fig,
    )

  ]
]


#slide[
  #text(size: 18pt)[

    #let body = [
      - Klassen:
        - JMenuBar: Menüleiste
        - JMenu: Menü in Menüleiste (z.B. Datei, Hilfe)
        - JMenuItem: Eintrag in einem Menü (z.B. Neu, Speichern als)

      - Fügen Sie unserem Programm folgende Menüs hinzu:
        - Menü File mit den Menüpunkten Open, Save und Exit
        - Menü Help mit den Menüpunkten Help und About

      #tip[
        - Elemente werden meist über add() hinzugefügt.
        - Die Menüleiste wird über setJMenuBar() hinzugefügt.
      ]
    ]
    #let fig = figure(image("../assets/img/2024_10_25_window_frame_tree_rev01.png"))
    #grid(
      columns: (70%, 30%),
      gutter: 0.25em,
      body, fig,
    )
  ]
]

#slide[
  #text(size: 13pt)[
    #let body = [
      ```java
      public MenuBar() {
          JFrame frame = new JFrame("Menu bar example");
          // Set frame properties ...

          JMenuBar menuBar = new JMenuBar();   // Create menu bar and add to frame
          frame.setJMenuBar(menuBar);

          JMenu menuFile = new JMenu("File");  // Create menu "File"
          menuBar.add(menuFile);
          menuFile.add(new JMenuItem("Open"));
          menuFile.add(new JMenuItem("Save"));
          menuFile.addSeparator();
          menuFile.add(new JMenuItem("Exit"));

          JMenu menuHelp = new JMenu("Help");  // Create menu "Help"
          menuBar.add(menuHelp);
          menuHelp.add(new JMenuItem("About"));

          frame.setVisible(true);
      }
      ```
    ]
    #let fig = [
      #figure(image("../assets/img/2024_10_25_window_frame_file_menu_rev01.png"))
      #figure(image("../assets/img/2024_10_25_window_frame_help_menu_rev01.png"))
    ]
    #grid(
      columns: (70%, 30%),
      gutter: 0.25em,
      body, fig,
    )

  ]
]

#slide[
  #text(size: 18pt)[
    #let body = [
      - Klasse JLabel stellt nicht editierbaren Text dar
        - Kann horizontal und vertikal ausgerichtet werden (z.B. zentriert)
        - Kann Rahmen zeichnen
        - Kann auch Bilder darstellen

      - Erzeugen wir das rechts abgebildete Fenster:
        - Bild über new ImageIcon() laden
        - Rahmen über BorderFactory.createEtchedBorder()
        - Label der Content pane über add() hinzufügen
        - Layout über frame.setLayout(new GridLayout(2, 1))
    ]
    #let fig = [
      #figure(image("../assets/img/2024_10_25_window_frame_lena_rev01.png"))
    ]
    #grid(
      columns: (70%, 30%),
      gutter: 0.25em,
      body, fig,
    )
  ]
]

#slide[
  #text(size: 12pt)[
    #let body = [
      ```java
      // Create frame and set properties
      JFrame frame = new JFrame("Label example");
      frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
      frame.setSize(400, 300);
      frame.setLocation(50, 50);
      frame.setLayout(new GridLayout(2, 1));  // 2 rows, 1 column

      // Create labels
      ImageIcon image = new ImageIcon("folien07_gui/Lena100.jpg");
      JLabel label1 = new JLabel("Lena", image, JLabel.CENTER);
      label1.setHorizontalTextPosition(JLabel.CENTER);
      label1.setVerticalTextPosition(JLabel.BOTTOM);

      JLabel label2 = new JLabel("Horizontal alignment right");
      label2.setHorizontalAlignment(JLabel.RIGHT);
      label2.setBorder(BorderFactory.createEtchedBorder(Color.RED, Color.ORANGE));

      // Add labels to content pane
      Container contentPane = frame.getContentPane();
      contentPane.add(label1);
      contentPane.add(label2);

      frame.setVisible(true);
      ```
    ]
    #let fig = [
      #figure(image("../assets/img/2024_10_25_window_frame_lena_rev01.png"))
    ]
    #grid(
      columns: (70%, 30%),
      gutter: 0.25em,
      body, fig,
    )
  ]
]
= Layout
== Layout-Manager
#slide[
  #text(size: 18pt)[

    - Legen die Anordnung der GUI-Elemente fest

    - Verschiedene Layout-Manager definiert, z. B.:
      - BoxLayout:
        - Elemente übereinander („vertikal“) oder nebeneinander („horizontal“)
      - GridLayout:
        - Elemente in gleichmäßigem Gitter platziert
        - Alle Zellen haben die gleiche Größe
      - FlowLayout:
        - Elemente wie bei horizontalem BoxLayout in Zeile platziert
        - Allerdings Zeilenumbruch, sobald eine Zeile „voll“ ist
  ]
]

#slide[
  #text(size: 17pt)[
    #let body = [
      ```java
      	// Create frame and set properties
      	JFrame frame = new JFrame("Layout example");
      	frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
      	frame.setLocation(50, 50);

      	// Create contents
      	Container contentPane = frame.getContentPane();
      	contentPane.setLayout(new BoxLayout(contentPane, BoxLayout.Y_AXIS));
      	contentPane.add(new JButton("Auf die"));
      	contentPane.add(new JButton("Plätze"));
      	contentPane.add(new JButton("fertig"));
      	contentPane.add(new JButton("los!"));

      	frame.pack();
      	frame.setVisible(true);
      ```
    ]
    #let fig = [
      #figure(image("../assets/img/2024_10_25_window_frame_vertical_buttons_rev01.png"))
    ]
    #grid(
      columns: (70%, 30%),
      gutter: 0.25em,
      body, fig,
    )
  ]
]

#slide[
  #text(size: 18pt)[

    - Horizontales BoxLayout:
    ```java
    	contentPane.setLayout(new BoxLayout(contentPane, BoxLayout.X_AXIS));
    ```
    #figure(image("../assets/img/2024_10_25_window_frame_horizontal_buttons_rev01.png"))

    - GridLayout:
    ```java
    	contentPane.setLayout(new GridLayout(2, 2));
    ```
    #figure(image("../assets/img/2024_10_25_window_frame_grid_buttons_rev01.png"))
  ]
]

#slide[
  #text(size: 18pt)[
    - Elemente lassen sich in Objekten der Klasse JPanel gruppieren.
    - Jedes JPanel-Objekt besitzt einen eigenen Layout-Manager.

      #question[
        - Welche Elemente beinhaltet das gezeigte Fenster?
        - Über welche Objekte und Layout-Manager sind diese angeordnet?
      ]

      #figure(image("../assets/img/2024_10_25_window_frame_groups_rev01.png"))
  ]
]

#slide[
  #text(size: 13pt)[
    #let body = [
      ```java
      JFrame frame = new JFrame("Layout example");

      JPanel panel1 = new JPanel();
      panel1.setLayout(new BoxLayout(panel1, BoxLayout.Y_AXIS));
      panel1.add(new JButton("Rechts"));
      panel1.add(new JButton("oben"));

      JPanel panel2 = new JPanel();
      panel2.setLayout(new BoxLayout(panel2, BoxLayout.X_AXIS));
      panel2.add(new JButton("Links"));
      panel2.add(new JButton("unten"));

      Container contentPane = frame.getContentPane();
      contentPane.setLayout(new GridLayout(2, 2));
      contentPane.add(new JLabel("Links oben", JLabel.CENTER));
      contentPane.add(panel1);
      contentPane.add(panel2);
      contentPane.add(new JLabel("Rechts unten", JLabel.CENTER));

      frame.pack();
      frame.setVisible(true);
      ```
    ]
    #let fig = figure(image("../assets/img/2024_10_25_window_frame_group_jframe_rev01.png"))
    #grid(
      columns: (70%, 30%),
      gutter: 0.25em,
      body, fig,
    )
  ]
]
= Zeichnen
== Zeichnen
#slide[
  #text(size: 18pt)[
    #let body = [
      - Klasse JPanel als Zeichenfläche:
        - Auf Panel lässt sich frei zeichnen.

      - Zeichenmethode:
        - System führt zum Zeichnen Methode paintComponent() aus
        - Wird automatisch bei Änderungen am Fenster aufgerufen
        - Methode erhält Parameter vom Typ Graphics (Grafik-Kontext)
        - Graphics besitzt Methoden zum Zeichnen (Texte, Linien, Rechtecke, Bögen, …)

      - Explizites Neuzeichnen:
        - Neuzeichnen kann auch über Methode repaint() veranlasst werden.
        - Diese ruft intern paintComponent() auf.
    ]
    #let fig = figure(image("../assets/img/2024_10_25_window_frame_jpanel_uml_rev01.png"))
    #grid(
      columns: (75%, 25%),
      gutter: 0.25em,
      body, fig,
    )
  ]
]

#slide[
  #text(size: 18pt)[
    #let body = [
      - Okay, es gibt also JPanel mit der Methode paintComponent().
      - Es wird gezeichnet, was in paintComponent() steht.
      - Aber wie kann man Zeichenbefehle zu dieser Methode hinzufügen?!

      - Lösung:
        - Leiten Sie von JPanel ab und überlagern Sie paintComponent().
        - Hierdurch: Panel-Klasse mit frei definierbarer Zeichenmethode

      ```java
      	class MyPaintPanel extends JPanel {
      	    public void paintComponent(Graphics g) {
      	        super.paintComponent(g);
      	        // Code for own drawings ...
      	    }
      	}
      ```
    ]
    #let fig = figure(image("../assets/img/2024_10_25_window_frame_jpanel_uml_inherit_rev01.png"))
    #grid(
      columns: (75%, 25%),
      gutter: 0.25em,
      body, fig,
    )
  ]
]

#slide[
  #text(size: 13pt)[
    #let body = [
      ```java
      class MyPaintPanel extends JPanel {
          public Dimension getPreferredSize() {
              return new Dimension(300, 200);
          }

          public void paintComponent(Graphics g) {
              super.paintComponent(g);

              g.setColor(Color.BLACK);
              g.drawRect(25, 50, 100, 30);	// Super class
              g.drawString("JPanel", 55, 70);
              g.drawRect(25, 120, 100, 30);	// Sub class
              g.drawString("MyPaintPanel", 40, 140);
              g.drawLine(75, 80, 75, 120);	// Arrow
              g.fillPolygon(new int[]{70, 75, 80}, new int[]{90, 80, 90}, 3);

              g.setColor(Color.RED);
              g.fillRect(202, 70, 12, 42);
              g.fillOval(200, 120, 16, 16);
          }
      }
      ```
    ]
    #let fig = figure(image("../assets/img/2024_10_25_window_frame_jpanel_uml_example_rev01.png"))
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
      - Einbinden in graphische Oberfläche:

      ```java
      public class PaintPanel {
      	    public PaintPanel() {
      	        JFrame frame = new JFrame("Panel example");
      	        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
      	        frame.setLocation(50, 50);

      	        frame.add(new MyPaintPanel());
      	        frame.pack();
      	        frame.setVisible(true);
      	    }

      	    public static void main(String[] args) {
      	        new PaintPanel();
      	    }
      	}
      ```
    ]
    #let fig = figure(image("../assets/img/2024_10_25_window_frame_jpanel_uml_example_rev01.png"))
    #grid(
      columns: (75%, 25%),
      gutter: 0.25em,
      body, fig,
    )
  ]
]

#slide[
  #text(size: 18pt)[
    #task[
      - Entdecken Sie Ihre künstlerische Ader!
      - Erstellen Sie ein Programm, das eine Ampel anzeigt.
    ]
    #figure(image("../assets/img/2024_10_25_window_frame_ampel_rev01.png"))
  ]
]

= Buttons & Ereignisse
== Aufgabe

#slide[
  #text(size: 18pt)[

    - Unser Ziel ist folgende Anwendung:
      - Fenster mit drei Buttons und einem Panel
      - Auswahl der Buttons färben das Panel rot, blau bzw. in zufälliger Farbe

    #figure(image("../assets/img/2024_10_29_button_color_rev01.png"), caption: [Buttons, die eine Farbe ändern])

    - Wir benötigen hierzu:
      - Buttons als Elemente
      - Möglichkeit auf gedrückten Button zu reagieren
  ]
]

#slide[
  #text(size: 18pt)[
    #task[
      - Erzeugen Sie zunächst die GUI mit ihren Elementen.
    ]

    #figure(image("../assets/img/2024_10_29_button_color_explain_rev01.png"))
  ]
]

#slide[
  #text(size: 13pt)[
    - Erzeugen von Elementen der Klasse JButton:
    ```java
    	public class ButtonEvent {
    	    public ButtonEvent() {
    	        JFrame frame = new JFrame("Button example");
    	        // Set frame properties ...

    	        // Create and layout contents
    	        frame.setLayout(new GridLayout(4, 1));  // 4 rows, 1 column
    	        Container contentPane = frame.getContentPane();
    	        contentPane.add(new JButton("Change color to red"));
    	        contentPane.add(new JButton("Change color to blue"));
    	        contentPane.add(new JButton("Change to random color"));
    	        contentPane.add(new JPanel());
    	        frame.pack();
    	        frame.setVisible(true);
    	    }

    	    public static void main(String[] args) {
    	        new ButtonEvent();
    	    }
    	}
    ```
  ]
]

#slide[
  #text(size: 18pt)[
    - Wie können wir aber darauf reagieren, wenn ein Button gedrückt wird?

    - Beteiligte Objekte:
      - Button mit Zustand (z.B. „nicht gedrückt“, „gedrückt“)
      - Objekt, das bei Änderungen des Buttons benachrichtigt werden soll
    - Prinzipielles Vorgehen:
      - Registrierung:
        - Objekt „sagt dem Button“, dass es bei Änderungen benachrichtigt werden möchte
        - Button merkt sich (z. B. in Liste), welche Objekte benachrichtigt werden sollen
      - Button wird gedrückt:
        - Button benachrichtigt Objekte in der Liste, dass sein Zustand geändert wurde
  ]
]

#slide[
  #text(size: 18pt)[
    - Mögliche Umsetzung:
      - Button: Methode register(), um Beobachter zur Liste hinzuzufügen
      - Observer: Methode notify(), die Button-Objekt zur Benachrichtigung aufruft

    #figure(image("../assets/img/2024_10_29_button_event_diagram_rev01.png", height: 70%))
  ]
]


#slide[
  #text(size: 18pt)[

    - Aaaaaaaber:
      - JButton kann von uns erstellte Klassen nicht kennen.
      - Kann daher auch nicht wissen, ob wir Methode notify() implementiert haben.
    - Lösung:
      - Beobachter implementieren ein definiertes Interface
      - Button braucht die Klasse des Beobachters nicht kennen, nur das Interface

    #figure(
      image("../assets/img/2024_10_29_observer_interface_rev01.png", height: 50%),
      caption: [Interface `Oberserver`],
    )
  ]
]

#slide[
  #text(size: 18pt)[
    - Ansatz wird auch Observer pattern genannt
    - Es können sich mehr als ein Beobachter registrieren.
    - In Swing Namen des Interfaces und der Methoden anders gewählt:

    #figure(image("../assets/img/2024_10_29_actionlistener_rev01.png"))
  ]
]

#slide[
  #text(size: 18pt)[
    #task[
      - Ausführbare Klasse implementiert Interface ActionListener
      - Objekt der ausführbaren Klasse registriert sich bei den Buttons
    ]

    #figure(image("../assets/img/2024_10_29_button_color_noexplain_rev01.png"))
  ]
]

#slide[
  #text(size: 14pt)[

    - Auszug aus Quelltext:
    ```java
    	public class ButtonEvent implements ActionListener {
    	    private JPanel panel;
    	    private JButton buttonRed, buttonBlue, buttonRandom;

    	    public ButtonEvent() {
    	        // ...

    	        // Buttons with event handling
    	        buttonRed = new JButton("Change color to red");
    	        buttonBlue = new JButton("Change color to blue");
    	        buttonRandom = new JButton("Change to random color");

    	        buttonRed.addActionListener(this);
    	        buttonBlue.addActionListener(this);
    	        buttonRandom.addActionListener(this);

    	        // ...
    	    }
    	}
    ```
  ]
]

#slide[
  #text(size: 15pt)[
    - Reaktion auf Ereignisse (Auszug aus Quelltext):
      - Button über Methode `getSource()` des Ereignisobjektes identifiziert
    ```java
    	public class ButtonEvent implements ActionListener {
    	    public void actionPerformed(ActionEvent event) {
    	        if (event.getSource() == buttonRed) {
    	            panel.setBackground(Color.RED);
    	        } else if (event.getSource() == buttonBlue) {
    	            panel.setBackground(Color.BLUE);
    	        } else if (event.getSource() == buttonRandom) {
    	            Random random = new Random();
    	            float red = random.nextFloat();
    	            float green = random.nextFloat();
    	            float blue = random.nextFloat();
    	            Color color = new Color(red, green, blue);
    	            panel.setBackground(color);
    	        }
    	    }
    	}
    ```
  ]
]

#slide[
  #text(size: 14pt)[
    - Alternativ (in actionPerformed() herausfinden, welcher Button gedrückt wurde):
    - Buttons mit einem String verbinden, z.B.:
    ```java
    	buttonRed.setActionCommand("Change color to red");
    	buttonBlue.setActionCommand("Change color to blue");
    	buttonRandom.setActionCommand("Change to random color");
    ```
    - String in Methode `actionPerformed()` abfragen und nutzen:
    ```java
    	public void actionPerformed(ActionEvent event) {
    	    String actionCommand = event.getActionCommand();

    	    if (actionCommand.equals("Change color to red")) {
    	        // ...
    	    } else if (actionCommand.equals("Change color to blue")) {
    	        // ...
    	    } else if (actionCommand.equals("Change to random color")) {
    	        // ...
    	    }
    	}
    ```
  ]
]

#slide[
  #text(size: 14pt)[
    - Neuen `ActionListener` mit Methode `actionPerformed()` inline definieren

    ```java
    public class ButtonEvent2 {
        private JPanel panel;

        public ButtonEvent2() {
            // ...

            buttonRed.addActionListener(new ActionListener() {
                public void actionPerformed(ActionEvent event) {
                    panel.setBackground(Color.RED);
                }
            });

            // ...
        }

        public static void main(String[] args) {
            new ButtonEvent2();
        }
    }
    ```
  ]
]
#slide[
  #text(size: 18pt)[
    - Alle Swing-Komponenten können folgende Beobachter registrieren:
      - Component listener: Änderungen der Größe, Position oder Sichtbarkeit
      - Focus listener: Komponente erhält oder verliert den Tastatur-Fokus
      - Key listener: Tastatur-Ereignisse (nur wenn die Komponente den Keyboard-Fokus hat)
      - Mouse listener: Maus-Klicks, Drücken, Loslassen und Mausbewegungen
      - Mouse motion listener: Änderungen der Cursor-Position über der Komponente
      - Mouse wheel listener: Änderung des Mausrads über der Komponente
  ]
]

= Einfache Dialoge
== Einfache Dialoge
#slide[
  #text(size: 13pt)[
    #let body = [
      - Beispiele für Dialoge über JOptionPane:
      ```java
      public class MessageDialogs {
          public MessageDialogs() {
              // Create and show frame
              JFrame frame = new JFrame("Message dialog example");
              frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
              frame.setSize(400, 300);
              frame.setLocationByPlatform(true);
              frame.setVisible(true);

              // Display dialogs
              JOptionPane.showMessageDialog(frame, "This is a plain message.", "Message",
                  JOptionPane.PLAIN_MESSAGE);
              JOptionPane.showMessageDialog(frame, "This is an information message.", "Message",
                  JOptionPane.INFORMATION_MESSAGE);
              JOptionPane.showMessageDialog(frame, "This is a warning.", "Message",
                  JOptionPane.WARNING_MESSAGE);
          }

          public static void main(String[] args) {
              new MessageDialogs();
          }
      }
      ```
    ]
    #let fig = figure(image("../assets/img/2024_10_29_simple_dialog_rev01.png"))
    #grid(
      columns: (70%, 30%),
      gutter: 0.25em,
      body, fig,
    )

  ]
]

= Anregungen
== Ideen zum Experimentieren

#slide[
  #text(size: 18pt)[
    - Einige weitere GUI-Elemente:
      - Textfelder über `JTextField`, `JPasswordField` und `JTextArea`
      - Auswahlboxen über `JCheckBox`
      - Listen über `JComboBox` und `JList`
      - Tooltips über Methode `setToolTipText()`
      - Datei auswählen über `JFileChooser`
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
