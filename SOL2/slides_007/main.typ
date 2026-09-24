#import "@preview/touying:0.7.4": *
#import "@preview/codly:1.3.0": *
#show: codly-init.with()
#import "@preview/numbly:0.1.0": numbly
#import "../hestia/theme.typ": *
#import "diagrams.typ": diagram

#set text(lang: "en")
#set heading(numbering: numbly("{1}.", default: "1.1"))

#show: hestia-theme.with(
  compact: true,
  config-info(
    title: [Object-Oriented\ Programming in Java],
    short-title: [Java · Lecture 7],
    subtitle: [Lecture 7 - Graphical User Interfaces],
    author: [Emily Lucia Antosch],
    date: datetime.today().display("[day].[month].[year]"),
    institution: [HAW Hamburg],
  ),
)

// Codly lays out grid rows: vertical inset controls code line spacing.
#show raw.where(block: true): it => {
  codly(inset: (x: .32em, y: .22em))
  it
}

#title-slide(authors: [Emily Lucia Antosch])
#outline-slide()

= Introduction
== From Contracts to User Interfaces
#slide[
  #diagram("roadmap", height: 190pt)
]

== What You Will Build
#slide[
  #diagram("goals", height: 190pt)
]

= Basic Structure
== Read a Graphical Interface
#slide[
  #question[Which controls do you recognize? How does one control affect another?]
  #diagram("explorer", height: 210pt)
]

== AWT and Swing
#slide[
  #diagram("toolkits", height: 230pt)
  #text(18pt)[Swing uses AWT events, graphics and top-level windows.]
]

== Anatomy of a Frame
#slide[
  #diagram("frame", height: 260pt)
]

== Components Form a Tree
#slide[
  #diagram("hierarchy", height: 270pt)
]

= Creating Graphical User Interfaces
== Create, Configure, Show
#slide[
  #diagram("startup", height: 120pt)
  #text(18pt)[
    Swing components are created and updated on the *event dispatch thread (EDT)*.
    The following examples omit imports (`javax.swing.*`, `java.awt.*`, `java.awt.event.*`).
  ]
]

== A Minimal Window
#slide[
  #text(20pt)[
    ```java
    public class HelloWorld {
        public HelloWorld() {
            JFrame frame = new JFrame("GUI example");
            frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
            frame.setVisible(true);
        }
        public static void main(String[] args) {
            SwingUtilities.invokeLater(HelloWorld::new);
        }
    }
    ```
    Use the same EDT startup pattern for the later GUI classes.
  ]
]

== Size and Position
#slide[
  #question[What happens without EXIT_ON_CLOSE? Why call setVisible(true)?]
  #task[Make the frame 400 × 300 pixels. Place its top-left corner at (50, 50).]
  #text(18pt)[Inspect JFrame's methods. Set size and location before showing the frame.]
]

#slide[
  #grid(columns: (1fr, 1fr), gutter: 22pt,
    [
      #text(18pt)[
        ```java
        frame.setSize(400, 300);
        frame.setLocation(50, 50);
        frame.setVisible(true);
        ```
        A new JFrame is initially hidden. The default close operation hides it; it does not exit the application.
      ]
    ],
    [#diagram("geometry", height: 260pt)],
  )
]

== Menus Are Components Too
#slide[
  #task[Add File → Open, Save, Exit and Help → Help, About.]
  #diagram("menu-tree", height: 215pt)
]

== Build the Menu Bar
#slide[
  #text(20pt)[
    ```java
    JMenuBar menuBar = new JMenuBar();
    frame.setJMenuBar(menuBar);
    JMenu menuFile = new JMenu("File");
    menuBar.add(menuFile);
    menuFile.add(new JMenuItem("Open"));
    menuFile.add(new JMenuItem("Save"));
    menuFile.addSeparator();
    menuFile.add(new JMenuItem("Exit"));
    ```
    Add the Help menu in the same way, then show the frame.
    Menu items need listeners before they perform an action.
  ]
]

#slide[
  #diagram("menu-output", height: 260pt)
]

== JLabel: Text, Images and Borders
#slide[
  #diagram("labels", height: 240pt)
  #text(18pt)[Recreate this window with two non-editable labels. Supply your own `icon.png`.]
]

== Configure the Labels
#slide[
  #text(20pt)[
    ```java
    frame.setLayout(new GridLayout(2, 1));
    ImageIcon image = new ImageIcon("icon.png");
    JLabel label1 = new JLabel("Icon", image, JLabel.CENTER);
    label1.setHorizontalTextPosition(JLabel.CENTER);
    label1.setVerticalTextPosition(JLabel.BOTTOM);
    JLabel label2 = new JLabel("Right-aligned text");
    label2.setHorizontalAlignment(JLabel.RIGHT);
    label2.setBorder(BorderFactory.createEtchedBorder(
        Color.RED, Color.ORANGE));
    frame.add(label1);
    frame.add(label2);
    ```
    `frame.add(...)` forwards to the content pane. Set the frame size before showing it.
  ]
]

= Layout
== Choose a Layout Manager
#slide[
  #diagram("layouts", height: 285pt)
]

== BoxLayout: Stack Components
#slide[
  #text(20pt)[
    ```java
    Container contentPane = frame.getContentPane();
    contentPane.setLayout(
        new BoxLayout(contentPane, BoxLayout.Y_AXIS));
    contentPane.add(new JButton("Ready"));
    contentPane.add(new JButton("Set"));
    contentPane.add(new JButton("Go"));
    contentPane.add(new JButton("Again"));
    frame.pack();
    frame.setVisible(true);
    ```
    `pack()` sizes the window from its components' preferred sizes.
  ]
]

== Change the Arrangement
#slide[
  #text(20pt)[
    Horizontal row:
    ```java
    contentPane.setLayout(
        new BoxLayout(contentPane, BoxLayout.X_AXIS));
    ```
    Equal-sized cells:
    ```java
    contentPane.setLayout(new GridLayout(2, 2));
    ```
    Rows that wrap:
    ```java
    contentPane.setLayout(new FlowLayout());
    ```
  ]
]

== Combine Layouts with JPanel
#slide[
  #question[Which components and layout managers produce this window?]
  #diagram("nested-layout", height: 210pt)
]

#slide[
  #diagram("nested-annotated", height: 260pt)
]

== Build the Inner Panels
#slide[
  #text(20pt)[
    ```java
    JPanel panel1 = new JPanel();
    panel1.setLayout(new BoxLayout(panel1, BoxLayout.Y_AXIS));
    panel1.add(new JButton("Right"));
    panel1.add(new JButton("top"));

    JPanel panel2 = new JPanel();
    panel2.setLayout(new BoxLayout(panel2, BoxLayout.X_AXIS));
    panel2.add(new JButton("Left"));
    panel2.add(new JButton("bottom"));
    ```
  ]
]

== Place the Panels in the Frame
#slide[
  #text(20pt)[
    ```java
    frame.setLayout(new GridLayout(2, 2));
    frame.add(new JLabel("Top left", JLabel.CENTER));
    frame.add(panel1);
    frame.add(panel2);
    frame.add(new JLabel("Bottom right", JLabel.CENTER));
    frame.pack();
    frame.setVisible(true);
    ```
    Each panel has its own layout manager.
  ]
]

= Drawing
== Swing Controls When Painting Happens
#slide[
  #diagram("painting", height: 240pt)
  #text(18pt)[`repaint()` schedules a paint; it does not call `paintComponent()` immediately.]
]

== Override paintComponent()
#slide[
  #grid(columns: (1fr, 1fr), gutter: 22pt,
    [
      #text(18pt)[
        ```java
        class MyPaintPanel
                extends JPanel {
            @Override
            protected void paintComponent(
                    Graphics g) {
                super.paintComponent(g);
                // Draw here.
            }
        }
        ```
      ]
    ],
    [#diagram("paint-uml", height: 245pt)],
  )
]

== Drawing Commands Use Pixel Coordinates
#slide[
  #text(20pt)[
    Inside `paintComponent()`, after the call to `super`:
    ```java
    g.setColor(Color.BLACK);
    g.drawRect(25, 50, 100, 30);
    g.drawString("JPanel", 55, 70);
    g.drawRect(25, 120, 100, 30);
    g.drawString("MyPaintPanel", 40, 140);
    g.drawLine(75, 80, 75, 120);
    g.fillPolygon(new int[]{70, 75, 80},
                  new int[]{90, 80, 90}, 3);
    g.setColor(Color.RED);
    g.fillRect(202, 70, 12, 42);
    g.fillOval(200, 120, 16, 16);
    ```
  ]
]

== Give the Drawing a Preferred Size
#slide[
  #grid(columns: (1.2fr, 1fr), gutter: 22pt,
    [
      #text(18pt)[
        In `MyPaintPanel`:
        ```java
        @Override
        public Dimension getPreferredSize() {
            return new Dimension(300, 200);
        }
        ```
        In the frame's setup:
        ```java
        frame.add(new MyPaintPanel());
        frame.pack();
        frame.setVisible(true);
        ```
      ]
    ],
    [#diagram("painted-output", height: 250pt)],
  )
]

== Task: Draw a Traffic Light
#slide[
  #task[Draw a traffic light with rectangles and circles. Choose one of the two states.]
  #diagram("traffic-lights", height: 210pt)
]

= Buttons & Events
== A Click Changes State
#slide[
  #diagram("color-window", height: 265pt)
]

== Build the Interface First
#slide[
  #task[Create three buttons and a panel. Arrange them in four equal rows.]
  #diagram("color-components", height: 215pt)
]

#slide[
  #text(20pt)[
    Fields of `ButtonEvent`:
    ```java
    private JPanel panel;
    private JButton buttonRed, buttonBlue, buttonRandom;
    ```
    In its constructor, after creating the frame:
    ```java
    frame.setLayout(new GridLayout(4, 1));
    frame.add(buttonRed = new JButton("Change color to red"));
    frame.add(buttonBlue = new JButton("Change color to blue"));
    frame.add(buttonRandom = new JButton("Change to random color"));
    frame.add(panel = new JPanel());
    frame.pack();
    frame.setVisible(true);
    ```
  ]
]

== Register Once, React Many Times
#slide[
  #diagram("event-sequence", height: 275pt)
]

== Observer: Depend on a Contract
#slide[
  #diagram("observer", height: 260pt)
  #text(18pt)[`update()` is a conceptual callback here, not Java's `Object.notify()`.]
]

== Swing's Observer Contract
#slide[
  #task[Make ButtonEvent implement ActionListener. Register this object with all three buttons.]
  #diagram("action-listener", height: 215pt)
]

== Register the Listener
#slide[
  #text(20pt)[
    ```java
    public class ButtonEvent implements ActionListener {
        // Fields and constructor as before.
        @Override
        public void actionPerformed(ActionEvent event) {
            // Choose the panel's new color.
        }
    }
    ```
    In the constructor, after creating the buttons:
    ```java
    buttonRed.addActionListener(this);
    buttonBlue.addActionListener(this);
    buttonRandom.addActionListener(this);
    ```
  ]
]

== Identify the Action
#slide[
  #diagram("dispatch", height: 230pt)
]

== Respond to the Event Source
#slide[
  #text(20pt)[
    ```java
    @Override
    public void actionPerformed(ActionEvent event) {
        if (event.getSource() == buttonRed) {
            panel.setBackground(Color.RED);
        } else if (event.getSource() == buttonBlue) {
            panel.setBackground(Color.BLUE);
        } else if (event.getSource() == buttonRandom) {
            java.util.Random random = new java.util.Random();
            panel.setBackground(new Color(random.nextFloat(),
                random.nextFloat(), random.nextFloat()));
        }
    }
    ```
    Callbacks run on the EDT. Keep them short so the interface stays responsive.
  ]
]

== Alternative: Command Strings
#slide[
  #text(20pt)[
    In the constructor:
    ```java
    buttonRed.setActionCommand("red");
    buttonBlue.setActionCommand("blue");
    buttonRandom.setActionCommand("random");
    ```
    In `actionPerformed()`:
    ```java
    String command = event.getActionCommand();
    if ("red".equals(command)) {
        panel.setBackground(Color.RED);
    } else if ("blue".equals(command)) {
        panel.setBackground(Color.BLUE);
    } else if ("random".equals(command)) {
        // Set a random color as before.
    }
    ```
  ]
]

== Alternative: One Listener per Button
#slide[
  #text(20pt)[
    Anonymous class inside the constructor:
    ```java
    buttonRed.addActionListener(new ActionListener() {
        @Override
        public void actionPerformed(ActionEvent event) {
            panel.setBackground(Color.RED);
        }
    });
    ```
    The enclosing class no longer needs to implement `ActionListener`.
    No source check: this listener belongs only to the red button.
  ]
]

== More Events, More Listener Interfaces
#slide[
  #diagram("listeners", height: 290pt)
]

= Simple Dialogs
== JOptionPane: A Ready-Made Dialog
#slide[
  #diagram("dialog", height: 270pt)
]

== Choose a Message Type
#slide[
  #text(20pt)[
    After showing the parent frame, on the EDT:
    ```java
    JOptionPane.showMessageDialog(frame,
        "This is a plain message.", "Message",
        JOptionPane.PLAIN_MESSAGE);
    JOptionPane.showMessageDialog(frame,
        "This is an information message.", "Message",
        JOptionPane.INFORMATION_MESSAGE);
    JOptionPane.showMessageDialog(frame,
        "This is a warning.", "Message",
        JOptionPane.WARNING_MESSAGE);
    ```
    Each call waits until its dialog is dismissed.
  ]
]

= Suggestions
== Match a Control to the Task
#slide[
  #diagram("controls", height: 260pt)
]

= License Notice
== Attribution
#slide[
  #text(18pt)[
    - Shared under #link("https://creativecommons.org/licenses/by-nc-sa/4.0/")[CC BY-NC-SA 4.0].
    - Based on teaching material by Prof. Dr. Marc Hensel, supplied privately.
    - Text, diagrams and layout adapted; the private source cannot be linked.
  ]
]
