#import "@preview/touying:0.5.2": *
#import themes.university: *

#import "@preview/fletcher:0.5.1" as flechter: diagram, node, edge
#import "@preview/wrap-it:0.1.0": wrap-content

#import "@preview/gentle-clues:1.0.0": *
#import "@preview/pinit:0.2.0": *
#import "@preview/codly:1.0.0": *
#show: codly-init.with()

#import "@preview/numbly:0.1.0": numbly

#set text(lang: "en", font: "Roboto", size: 18pt)
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
    subtitle: [Lecture 7 - Graphical User Interfaces],
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

== Where Are We Currently?

- The last lecture was about interfaces and abstract classes
- You can now
  - use abstract classes to structure your code more precisely,
  - implement interfaces to represent properties of classes,
  - assign classes and objects with an order using `Comparable`,
- Today we continue with *graphical user interfaces*.

#slide[
  1. Imperative Concepts
  2. Classes and Objects
  3. Class Library
  4. Inheritance
  5. Interfaces
  6. *Graphical User Interfaces*
  7. Exception Handling
  8. Input and Output
  9. Multithreading (Parallel Computing)
]

== The Goal of This Chapter
- You create graphical user interfaces with e.g. menus, buttons and text fields.
- You draw diagrams from simple geometric shapes (e.g. lines, circles).
- You respond to events (e.g. pressing a button) by connecting graphical elements with methods to be executed on user input.
- You use the Observer pattern so that objects of any data type can react to events.


= Basic Structure
== Graphical UI

#slide[
  #text(size: 18pt)[
    #question[
      - What types of elements do you see?
      - How do the elements react? Do elements interact with each other?
    ]
  ]
  #figure(image("../assets/img/slides_7/2024_10_25_windows_explorer_rev01.png", height: 50%), caption: [Windows 7 Explorer])
]

#slide[
  #text(size: 18pt)[

    - Graphical user interface: Graphical user interface (GUI)
    - Class libraries AWT and Swing already included in the Java SDK

    - Abstract Window Toolkit (AWT):
      - Already introduced with Java 1.0
      - Only basic interface elements to support as many operating systems as possible ("Lowest common denominator")
      - Uses the native elements ("widgets") of the operating system
      - Originally full of design errors, as it was created under great pressure in just under two months

    - Swing:
      - Extension of AWT
      - No more direct addressing of window functions of the current platform
      - Complete control over display elements
  ]
]

#slide[
  #text(size: 18pt)[
    - Base element: Frame
    - Contains window bar with title and control elements (e.g. "Close")
    - Contains area where elements can be placed (Content pane)
    - Can additionally contain menu bar

    #figure(
      image("../assets/img/slides_7/2024_10_25_window_frame_aufbau_rev01.png", height: 50%),
      caption: [Structure of a frame],
    )
  ]
]

#slide[
  #text(size: 18pt)[
    - Elements are added hierarchically.
    - For elements that contain other elements, the layout can be specified.
    #figure(
      image("../assets/img/slides_7/2024_10_25_window_frame_hierarchie_rev01.png", height: 70%),
      caption: [Hierarchy of a window],
    )
  ]
]


= Creating Graphical User Interfaces
== Simple Program

#slide[
  #text(size: 18pt)[
    - Executable main() method creates object of the class
    - Class creates frame with graphical interface in constructor
    - Specify "Close Operation" so that application terminates when window is closed

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
      - What happens if the "Close Operation" is not set to "Exit on close"?
      - Why do you have to explicitly display the window via setVisible(true)?
    ]
    #let left = [
      - And it doesn't look really nice:
        - The window is too small!
        - The window "sticks" in the upper left corner!
    ]
    #let right = figure(image("../assets/img/slides_7/2024_10_25_window_frame_mini_rev01.png", height: 20%))
    #grid(
      columns: (60%, 40%),
      gutter: 0.25em,
      left, right,
    )

    #task[
      - Enlarge it to 400 x 300 pixels (width x height).
      - Place it 50 pixels from the left and top edge respectively.
      - Hint: Display the methods of frame.
    ]
  ]
]


#slide[
  #text(size: 18pt)[
    #let body = [
      - Corrected size and position:

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
    #let fig = figure(image("../assets/img/slides_7/2024_10_25_window_frame_empty_rev01.png"))
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
        - JMenuBar: Menu bar
        - JMenu: Menu in menu bar (e.g. File, Help)
        - JMenuItem: Entry in a menu (e.g. New, Save as)

      - Add the following menus to our program:
        - Menu File with menu items Open, Save and Exit
        - Menu Help with menu items Help and About

      #tip[
        - Elements are usually added via add().
        - The menu bar is added via setJMenuBar().
      ]
    ]
    #let fig = figure(image("../assets/img/slides_7/2024_10_25_window_frame_tree_rev01.png"))
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
      #figure(image("../assets/img/slides_7/2024_10_25_window_frame_file_menu_rev01.png"))
      #figure(image("../assets/img/slides_7/2024_10_25_window_frame_help_menu_rev01.png"))
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
      - Class JLabel displays non-editable text
        - Can be aligned horizontally and vertically (e.g. centered)
        - Can draw borders
        - Can also display images

      - Let's create the window shown on the right:
        - Load image via new ImageIcon()
        - Border via BorderFactory.createEtchedBorder()
        - Add label to content pane via add()
        - Layout via frame.setLayout(new GridLayout(2, 1))
    ]
    #let fig = [
      #figure(image("../assets/img/slides_7/2024_10_25_window_frame_lena_rev01.png"))
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
      #figure(image("../assets/img/slides_7/2024_10_25_window_frame_lena_rev01.png"))
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

    - Define the arrangement of GUI elements

    - Various layout managers defined, e.g.:
      - BoxLayout:
        - Elements on top of each other ("vertical") or next to each other ("horizontal")
      - GridLayout:
        - Elements placed in uniform grid
        - All cells have the same size
      - FlowLayout:
        - Elements placed in row like horizontal BoxLayout
        - However, line break as soon as a line is "full"
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
      	contentPane.add(new JButton("Ready"));
      	contentPane.add(new JButton("Set"));
      	contentPane.add(new JButton("Go"));
      	contentPane.add(new JButton("los!"));

      	frame.pack();
      	frame.setVisible(true);
      ```
    ]
    #let fig = [
      #figure(image("../assets/img/slides_7/2024_10_25_window_frame_vertical_buttons_rev01.png"))
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

    - Horizontal BoxLayout:
    ```java
    	contentPane.setLayout(new BoxLayout(contentPane, BoxLayout.X_AXIS));
    ```
    #figure(image("../assets/img/slides_7/2024_10_25_window_frame_horizontal_buttons_rev01.png"))

    - GridLayout:
    ```java
    	contentPane.setLayout(new GridLayout(2, 2));
    ```
    #figure(image("../assets/img/slides_7/2024_10_25_window_frame_grid_buttons_rev01.png"))
  ]
]

#slide[
  #text(size: 18pt)[
    - Elements can be grouped in objects of class JPanel.
    - Each JPanel object has its own layout manager.

      #question[
        - Which elements does the shown window contain?
        - Via which objects and layout managers are these arranged?
      ]

      #figure(image("../assets/img/slides_7/2024_10_25_window_frame_groups_rev01.png"))
  ]
]

#slide[
  #text(size: 13pt)[
    #let body = [
      ```java
      JFrame frame = new JFrame("Layout example");

      JPanel panel1 = new JPanel();
      panel1.setLayout(new BoxLayout(panel1, BoxLayout.Y_AXIS));
      panel1.add(new JButton("Right"));
      panel1.add(new JButton("top"));

      JPanel panel2 = new JPanel();
      panel2.setLayout(new BoxLayout(panel2, BoxLayout.X_AXIS));
      panel2.add(new JButton("Left"));
      panel2.add(new JButton("bottom"));

      Container contentPane = frame.getContentPane();
      contentPane.setLayout(new GridLayout(2, 2));
      contentPane.add(new JLabel("Top left", JLabel.CENTER));
      contentPane.add(panel1);
      contentPane.add(panel2);
      contentPane.add(new JLabel("Bottom right", JLabel.CENTER));

      frame.pack();
      frame.setVisible(true);
      ```
    ]
    #let fig = figure(image("../assets/img/slides_7/2024_10_25_window_frame_group_jframe_rev01.png"))
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
      - Class JPanel as drawing surface:
        - Can draw freely on panel.

      - Drawing method:
        - System executes paintComponent() method for drawing
        - Is automatically called when window changes
        - Method receives parameter of type Graphics (graphics context)
        - Graphics has methods for drawing (texts, lines, rectangles, arcs, ...)

      - Explicit redrawing:
        - Redrawing can also be initiated via repaint() method.
        - This internally calls paintComponent().
    ]
    #let fig = figure(image("../assets/img/slides_7/2024_10_25_window_frame_jpanel_uml_rev01.png"))
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
      - Okay, so there is JPanel with the paintComponent() method.
      - What is drawn is what is in paintComponent().
      - But how can you add drawing commands to this method?!

      - Solution:
        - Derive from JPanel and override paintComponent().
        - This results in: Panel class with freely definable drawing method

      ```java
      	class MyPaintPanel extends JPanel {
      	    public void paintComponent(Graphics g) {
      	        super.paintComponent(g);
      	        // Code for own drawings ...
      	    }
      	}
      ```
    ]
    #let fig = figure(image("../assets/img/slides_7/2024_10_25_window_frame_jpanel_uml_inherit_rev01.png"))
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
    #let fig = figure(image("../assets/img/slides_7/2024_10_25_window_frame_jpanel_uml_example_rev01.png"))
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
      - Integration into graphical interface:

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
    #let fig = figure(image("../assets/img/slides_7/2024_10_25_window_frame_jpanel_uml_example_rev01.png"))
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
      - Discover your artistic streak!
      - Create a program that displays a traffic light.
    ]
    #figure(image("../assets/img/slides_7/2024_10_25_window_frame_ampel_rev01.png"))
  ]
]

= Buttons & Events
== Task

#slide[
  #text(size: 18pt)[

    - Our goal is the following application:
      - Window with three buttons and one panel
      - Selection of buttons color the panel red, blue or in random color

    #figure(image("../assets/img/slides_7/2024_10_29_button_color_rev01.png"), caption: [Buttons that change a color])

    - We need for this:
      - Buttons as elements
      - Possibility to react to pressed button
  ]
]

#slide[
  #text(size: 18pt)[
    #task[
      - First create the GUI with its elements.
    ]

    #figure(image("../assets/img/slides_7/2024_10_29_button_color_explain_rev01.png"))
  ]
]

#slide[
  #text(size: 13pt)[
    - Creating elements of class JButton:
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
    - But how can we react when a button is pressed?

    - Involved objects:
      - Button with state (e.g. "not pressed", "pressed")
      - Object that should be notified when the button changes
    - Basic approach:
      - Registration:
        - Object "tells the button" that it wants to be notified of changes
        - Button remembers (e.g. in list) which objects should be notified
      - Button is pressed:
        - Button notifies objects in the list that its state has changed
  ]
]

#slide[
  #text(size: 18pt)[
    - Possible implementation:
      - Button: Method register() to add observers to the list
      - Observer: Method notify() that button object calls for notification

    #figure(image("../assets/img/slides_7/2024_10_29_button_event_diagram_rev01.png", height: 70%))
  ]
]


#slide[
  #text(size: 18pt)[

    - Buuuuuut:
      - JButton cannot know classes we created.
      - Therefore cannot know if we implemented method notify().
    - Solution:
      - Observers implement a defined interface
      - Button doesn't need to know the observer's class, only the interface

    #figure(
      image("../assets/img/slides_7/2024_10_29_observer_interface_rev01.png", height: 50%),
      caption: [Interface `Observer`],
    )
  ]
]

#slide[
  #text(size: 18pt)[
    - Approach is also called Observer pattern
    - More than one observer can register.
    - In Swing, names of interface and methods chosen differently:

    #figure(image("../assets/img/slides_7/2024_10_29_actionlistener_rev01.png"))
  ]
]

#slide[
  #text(size: 18pt)[
    #task[
      - Executable class implements interface ActionListener
      - Object of executable class registers itself with the buttons
    ]

    #figure(image("../assets/img/slides_7/2024_10_29_button_color_noexplain_rev01.png"))
  ]
]

#slide[
  #text(size: 14pt)[

    - Excerpt from source code:
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
    - Reaction to events (excerpt from source code):
      - Button identified via `getSource()` method of event object
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
    - Alternatively (find out in actionPerformed() which button was pressed):
    - Connect buttons with a string, e.g.:
    ```java
    	buttonRed.setActionCommand("Change color to red");
    	buttonBlue.setActionCommand("Change color to blue");
    	buttonRandom.setActionCommand("Change to random color");
    ```
    - Query and use string in `actionPerformed()` method:
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
    - Define new `ActionListener` with `actionPerformed()` method inline

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
    - All Swing components can register the following observers:
      - Component listener: Changes in size, position or visibility
      - Focus listener: Component gains or loses keyboard focus
      - Key listener: Keyboard events (only when component has keyboard focus)
      - Mouse listener: Mouse clicks, pressing, releasing and mouse movements
      - Mouse motion listener: Changes in cursor position over the component
      - Mouse wheel listener: Changes of mouse wheel over the component
  ]
]

= Simple Dialogs
== Simple Dialogs
#slide[
  #text(size: 13pt)[
    #let body = [
      - Examples for dialogs via JOptionPane:
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
    #let fig = figure(image("../assets/img/slides_7/2024_10_29_simple_dialog_rev01.png"))
    #grid(
      columns: (70%, 30%),
      gutter: 0.25em,
      body, fig,
    )

  ]
]

= Suggestions
== Ideas for Experimenting

#slide[
  #text(size: 18pt)[
    - Some additional GUI elements:
      - Text fields via `JTextField`, `JPasswordField` and `JTextArea`
      - Selection boxes via `JCheckBox`
      - Lists via `JComboBox` and `JList`
      - Tooltips via method `setToolTipText()`
      - File selection via `JFileChooser`
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
