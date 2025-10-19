#import "@preview/grape-suite:3.1.0": exercise, german-dates
#import "@preview/gentle-clues:1.0.0": *

#import "@preview/gentle-clues:1.0.0": *
#set text(lang: "en")

#import "@preview/codly:1.0.0": *
#show: codly-init.with()

#let solution = true;


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

#show: exercise.project.with(
  title: "Lab 4 - Advanced Algorithms: Recursion, Backtracking, and GUI Programming",
  university: [HAW Hamburg],
  institute: [TI],
  seminar: [SO2],
  abstract: [
    This lab introduces arrays, recursion, GUI programming, and advanced algorithmic thinking through six progressive tasks.
    Students will learn two-dimensional array manipulation, recursive method design, event-driven programming, and backtracking algorithms.
    The exercises progress from maze pathfinding through Game of Life simulation, GUI calculator development, game AI implementation,
    fractal generation, and culminate with an optional Sudoku solver, emphasizing problem decomposition, visual programming,
    and advanced data structure manipulation.
  ],
  show-outline: true,
  author: "Emily Antosch & Furkan Yildirim & Julian Moldenhauer",
  show-solutions: false,
)

#memo[
  #heading(numbering: none)[Submission Deadline]
  Deadline to upload the solutions for all tasks is Saturday, 11:59 pm before the lab date.

  #heading(numbering: none)[General Information]
  The following tasks are to be worked on in fixed teams of two. Each team member must be able to explain all solutions. Please submit only one solution for each team of two. The submission must be a PDF file in our Moodle room with the name and matriculation number. Solutions must be in digital format with intermediate steps and detailed explanations (no handwritten scans). You can use any tool or drawing program of your choice to create the diagrams. If you have questions or need support, use the forum in our Moodle room and help each other.
]

= Task 1: Maze Pathfinding with Recursion

Create a recursive pathfinding algorithm to help a mouse navigate through a labyrinth to reach cheese. This task introduces two-dimensional arrays, recursion, and backtracking algorithms.

A poor, hungry mouse sits in the upper left corner of a labyrinth
(see sketch) and wants to reach a piece of cheese located in the lower
right corner of the labyrinth. It can enter all non-hatched
fields, but only via an edge shared by two adjacent fields.
Help the mouse reach the cheese. Write a recursive
method in Java that shows the mouse a path to the cheese.

#figure(image("../../assets/img/2024_11_04_maus_laby_rev01.png"))

#tip[
  Your method must try for every possible field to find a path to the cheese
  via each of the four neighboring fields.
]

Your program should:
1. Represent the labyrinth using a 2D character array
2. Implement a recursive `findPath(int row, int col)` method
3. Use backtracking when paths lead to dead ends
4. Mark visited cells to prevent infinite loops
5. Display the final path through the maze

== Preparation
Represent the labyrinth in a two-dimensional array. Use a method that checks all four directions and calls itself recursively to find the path. Tip: Use a marking character to mark the path that the mouse has taken, as the mouse should not go backwards. If you want, you can recreate the labyrinth with graphical methods and also enter the mouse's path to the cheese. A modification of the labyrinth or a larger number of fields is also possible.

== Assistance

*2D Array representation:*
```java
public class MazeSolver {
    private char[][] maze = {
        {'#', '#', '#', '#', '#', '#', '#'},
        {'#', ' ', ' ', '#', ' ', ' ', '#'},
        {'#', ' ', '#', '#', ' ', '#', '#'},
        {'#', ' ', ' ', ' ', ' ', '#', '#'},
        {'#', '#', '#', ' ', '#', ' ', '#'},
        {'#', ' ', ' ', ' ', ' ', ' ', '#'},
        {'#', '#', '#', '#', '#', '#', '#'}
    };

    private int startRow = 1, startCol = 1;
    private int endRow = 5, endCol = 5;
}
```

#if solution [
== Solution

```java
public class MazeSolver {
  private char[][] maze;
  private int startRow, startCol;
  private int endRow, endCol;
  private static final char WALL = '#';
  private static final char PATH = ' ';
  private static final char VISITED = '.';
  private static final char SOLUTION = '*';

  public MazeSolver() {
    // Initialize maze based on the lab image
    this.maze = new char[][] {
        {'#', '#', '#', '#', '#', '#', '#', '#', '#', '#'},
        {'#', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', '#'},
        {'#', ' ', '#', ' ', '#', ' ', '#', '#', ' ', '#'},
        {'#', ' ', '#', ' ', ' ', ' ', ' ', '#', ' ', '#'},
        {'#', ' ', '#', '#', '#', '#', ' ', '#', ' ', '#'},
        {'#', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', '#'},
        {'#', '#', '#', '#', '#', '#', '#', '#', '#', '#'}
    };

    // Mouse starts at top-left corner
    this.startRow = 1;
    this.startCol = 1;

    // Cheese is at bottom-right corner
    this.endRow = 5;
    this.endCol = 8;
  }

  // Display the current maze state
  public void displayMaze() {
    for (int i = 0; i < maze.length; i++) {
      for (int j = 0; j < maze[i].length; j++) {
        System.out.print(maze[i][j] + " ");
      }
      System.out.println();
    }
    System.out.println();
  }

  // Check if a position is valid and can be visited
  private boolean isValid(int row, int col) {
    // Check boundaries
    if (row < 0 || row >= maze.length || col < 0 || col >= maze[0].length) {
      return false;
    }

    // Check if it's not a wall and not already visited
    return maze[row][col] == PATH || maze[row][col] == SOLUTION;
  }

  // Recursive pathfinding method
  public boolean findPath(int row, int col) {
    // Base case: reached the cheese!
    if (row == endRow && col == endCol) {
      maze[row][col] = SOLUTION;
      return true;
    }

    // Check if current position is valid
    if (!isValid(row, col)) {
      return false;
    }

    // Mark current position as part of solution path
    maze[row][col] = SOLUTION;

    // Try all four directions: up, down, left, right
    // Try moving up
    if (findPath(row - 1, col)) {
      return true;
    }

    // Try moving down
    if (findPath(row + 1, col)) {
      return true;
    }

    // Try moving left
    if (findPath(row, col - 1)) {
      return true;
    }

    // Try moving right
    if (findPath(row, col + 1)) {
      return true;
    }

    // Backtrack: this path doesn't lead to cheese
    maze[row][col] = VISITED;
    return false;
  }

  // Solve the maze and display the solution
  public void solve() {
    System.out.println("=== Maze Pathfinding ===\n");
    System.out.println("Initial Maze:");
    displayMaze();

    System.out.println("Finding path from (" + startRow + ", " + startCol +
                       ") to (" + endRow + ", " + endCol + ")...\n");

    if (findPath(startRow, startCol)) {
      System.out.println("Path found! (* = solution path, . = tried but failed)");
      displayMaze();
    } else {
      System.out.println("No path found!");
    }
  }

  public static void main(String[] args) {
    MazeSolver solver = new MazeSolver();
    solver.solve();
  }
}
```
]

#pagebreak()

= Task 2: Conway's Game of Life Simulator

== Preparation
Before implementing the solution, you must:
1. Design a class structure for the Game of Life simulator
2. Create a UML class diagram showing:
  - Class name (GameOfLife)
  - All private attributes (grid, rows, cols, generation counter, etc.)
  - All public methods with their parameters and return types (printGrid, nextGeneration, countNeighbors, etc.)
  - Initialization methods for different patterns (initGlider, initRandom, etc.)
  - Constructor(s)
3. Consider what data structures you need (2D boolean array for the grid)
4. Transfer your implementation into this class structure
5. Only after completing the UML diagram should you begin coding

This preparation step ensures you think about the simulation architecture and state management before writing code.

== Task
Create a simulation of Conway's Game of Life, a cellular automaton that demonstrates how complex patterns emerge from simple rules. This task introduces 2D array manipulation, simulation loops, and pattern evolution.

Conway's Game of Life is a zero-player game where cells on a grid live, die, or reproduce based on their neighbors:
- A live cell with 2-3 live neighbors survives
- A dead cell with exactly 3 live neighbors becomes alive
- All other cells die or stay dead

Your program should:
1. Create a 2D boolean array to represent the grid (true = alive, false = dead)
2. Initialize the grid with a pattern (e.g., glider, blinker, or random)
3. Implement `countNeighbors(int row, int col)` to count live neighbors
4. Create `nextGeneration()` to compute the next state
5. Display each generation and pause between updates
6. Run for a specified number of generations or until stable

== Requirements
- Use a 2D array to represent the grid (minimum 20x20)
- Implement the four Game of Life rules correctly
- Display each generation in a readable format
- Handle edge cases at grid boundaries
- Allow user to choose initial pattern or use random seed

== Assistance

*Grid initialization and display:*
```java
public class GameOfLife {
    private boolean[][] grid;
    private int rows, cols;

    public GameOfLife(int rows, int cols) {
        this.rows = rows;
        this.cols = cols;
        grid = new boolean[rows][cols];
    }

    public void printGrid() {
        for (int i = 0; i < rows; i++) {
            for (int j = 0; j < cols; j++) {
                System.out.print(grid[i][j] ? "█ " : "· ");
            }
            System.out.println();
        }
        System.out.println();
    }

    // Initialize with glider pattern
    public void initGlider(int startRow, int startCol) {
        grid[startRow][startCol + 1] = true;
        grid[startRow + 1][startCol + 2] = true;
        grid[startRow + 2][startCol] = true;
        grid[startRow + 2][startCol + 1] = true;
        grid[startRow + 2][startCol + 2] = true;
    }
}
```

*Counting neighbors:*
```java
private int countNeighbors(int row, int col) {
    int count = 0;
    for (int i = -1; i <= 1; i++) {
        for (int j = -1; j <= 1; j++) {
            if (i == 0 && j == 0) continue;
            int newRow = row + i;
            int newCol = col + j;
            if (newRow >= 0 && newRow < rows &&
                newCol >= 0 && newCol < cols &&
                grid[newRow][newCol]) {
                count++;
            }
        }
    }
    return count;
}
```

#if solution [
== Solution

```java
public class GameOfLife {
  private boolean[][] grid;
  private int rows;
  private int cols;
  private int generation;

  // Constructor
  public GameOfLife(int rows, int cols) {
    this.rows = rows;
    this.cols = cols;
    this.grid = new boolean[rows][cols];
    this.generation = 0;
  }

  // Print the current grid
  public void printGrid() {
    System.out.println("Generation " + generation + ":");
    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < cols; j++) {
        System.out.print(grid[i][j] ? "█ " : "· ");
      }
      System.out.println();
    }
    System.out.println();
  }

  // Initialize with a glider pattern
  public void initGlider(int startRow, int startCol) {
    grid[startRow][startCol + 1] = true;
    grid[startRow + 1][startCol + 2] = true;
    grid[startRow + 2][startCol] = true;
    grid[startRow + 2][startCol + 1] = true;
    grid[startRow + 2][startCol + 2] = true;
  }

  // Initialize with a blinker pattern (oscillator)
  public void initBlinker(int startRow, int startCol) {
    grid[startRow][startCol] = true;
    grid[startRow][startCol + 1] = true;
    grid[startRow][startCol + 2] = true;
  }

  // Initialize with random pattern
  public void initRandom(double density) {
    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < cols; j++) {
        grid[i][j] = Math.random() < density;
      }
    }
  }

  // Count live neighbors for a cell
  private int countNeighbors(int row, int col) {
    int count = 0;

    // Check all 8 surrounding cells
    for (int i = -1; i <= 1; i++) {
      for (int j = -1; j <= 1; j++) {
        // Skip the cell itself
        if (i == 0 && j == 0) continue;

        int newRow = row + i;
        int newCol = col + j;

        // Check boundaries and count live neighbors
        if (newRow >= 0 && newRow < rows &&
            newCol >= 0 && newCol < cols &&
            grid[newRow][newCol]) {
          count++;
        }
      }
    }

    return count;
  }

  // Calculate next generation
  public void nextGeneration() {
    boolean[][] newGrid = new boolean[rows][cols];

    // Apply Conway's rules to each cell
    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < cols; j++) {
        int neighbors = countNeighbors(i, j);

        if (grid[i][j]) {
          // Cell is alive
          // Rule 1 & 3: Cell survives if it has 2 or 3 neighbors
          newGrid[i][j] = (neighbors == 2 || neighbors == 3);
        } else {
          // Cell is dead
          // Rule 4: Cell becomes alive if it has exactly 3 neighbors
          newGrid[i][j] = (neighbors == 3);
        }
      }
    }

    // Update grid
    grid = newGrid;
    generation++;
  }

  // Count total living cells
  public int countLivingCells() {
    int count = 0;
    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < cols; j++) {
        if (grid[i][j]) count++;
      }
    }
    return count;
  }

  // Run simulation for specified number of generations
  public void simulate(int generations, int delay) {
    for (int i = 0; i < generations; i++) {
      printGrid();
      System.out.println("Living cells: " + countLivingCells());

      // Pause between generations
      try {
        Thread.sleep(delay);
      } catch (InterruptedException e) {
        e.printStackTrace();
      }

      nextGeneration();
    }

    // Print final state
    printGrid();
    System.out.println("Living cells: " + countLivingCells());
  }

  public static void main(String[] args) {
    // Create a 25x25 grid
    GameOfLife game = new GameOfLife(25, 25);

    System.out.println("=== Conway's Game of Life ===\n");

    // Initialize with a glider
    System.out.println("Initializing with Glider pattern...\n");
    game.initGlider(5, 5);

    // Add a blinker
    game.initBlinker(10, 15);

    // Run simulation for 30 generations with 500ms delay
    game.simulate(30, 500);
  }
}
```
]

#pagebreak()

= Task 3: Simple GUI Calculator

== Preparation
Before implementing the solution, you must:
1. Design a class structure for the GUI calculator
2. Create a UML class diagram showing:
  - Class name (Calculator) extending JFrame and implementing ActionListener
  - All private attributes (display field, button arrays, operands, current operation, etc.)
  - All public methods with their parameters and return types
  - The actionPerformed method (from ActionListener interface)
  - Helper methods for calculations (add, subtract, multiply, divide)
  - Constructor that sets up the GUI
3. Consider the GUI component hierarchy (which panels contain which components)
4. Plan your event handling strategy (how button clicks update state)
5. Transfer your implementation into this class structure
6. Only after completing the UML diagram should you begin coding

This preparation step ensures you think about GUI architecture, state management, and event-driven design before writing code.

== Task
Create a graphical calculator application using Java Swing. This task introduces GUI programming, event handling, and building interactive applications.

Build a calculator with a graphical interface that performs basic arithmetic operations. This task helps you understand event-driven programming and user interface design.

Your program should:
1. Create a window with number buttons (0-9), operation buttons (`+`, `-`, `*`, `/`), equals, and clear
2. Display a text field showing the current input and result
3. Handle button clicks to build expressions
4. Evaluate expressions when equals is pressed
5. Clear the display when the clear button is pressed
6. Handle decimal numbers and basic error cases (division by zero)

== Requirements
- Use Java Swing components (JFrame, JButton, JTextField, JPanel)
- Use GridLayout or BorderLayout for component arrangement
- Implement ActionListener for button events
- Display results in a readable format
- Handle basic error cases gracefully

== Assistance

*Basic GUI structure:*
```java
import javax.swing.*;
import java.awt.*;
import java.awt.event.*;

public class Calculator extends JFrame implements ActionListener {
    private JTextField display;
    private JButton[] numberButtons;
    private JButton[] operationButtons;
    private double num1, num2, result;
    private char operation;

    public Calculator() {
        setTitle("Calculator");
        setSize(400, 500);
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setLayout(new BorderLayout());

        // Display field
        display = new JTextField();
        display.setEditable(false);
        display.setFont(new Font("Arial", Font.BOLD, 24));
        add(display, BorderLayout.NORTH);

        // Button panel
        JPanel buttonPanel = new JPanel();
        buttonPanel.setLayout(new GridLayout(4, 4, 5, 5));

        // Initialize buttons here
        numberButtons = new JButton[10];
        for (int i = 0; i < 10; i++) {
            numberButtons[i] = new JButton(String.valueOf(i));
            numberButtons[i].addActionListener(this);
            numberButtons[i].setFont(new Font("Arial", Font.PLAIN, 20));
        }

        add(buttonPanel, BorderLayout.CENTER);
        setVisible(true);
    }

    @Override
    public void actionPerformed(ActionEvent e) {
        // Handle button clicks
        String command = e.getActionCommand();
        // Implement logic here
    }

    public static void main(String[] args) {
        new Calculator();
    }
}
```

#if solution [
== Solution

```java
import javax.swing.*;
import java.awt.*;
import java.awt.event.*;

public class Calculator extends JFrame implements ActionListener {
  private JTextField display;
  private JButton[] numberButtons;
  private JButton[] operationButtons;
  private JButton addButton, subButton, mulButton, divButton;
  private JButton decimalButton, equalsButton, clearButton, deleteButton;
  private double num1 = 0, num2 = 0, result = 0;
  private char operator;

  public Calculator() {
    // Frame setup
    setTitle("Simple Calculator");
    setSize(420, 550);
    setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
    setLayout(null);
    setResizable(false);

    // Display field
    display = new JTextField();
    display.setBounds(50, 25, 300, 50);
    display.setFont(new Font("Arial", Font.BOLD, 24));
    display.setEditable(false);
    display.setHorizontalAlignment(JTextField.RIGHT);
    add(display);

    // Create number buttons (0-9)
    numberButtons = new JButton[10];
    for (int i = 0; i < 10; i++) {
      numberButtons[i] = new JButton(String.valueOf(i));
      numberButtons[i].addActionListener(this);
      numberButtons[i].setFont(new Font("Arial", Font.BOLD, 18));
      numberButtons[i].setFocusable(false);
    }

    // Create operation buttons
    addButton = new JButton("+");
    subButton = new JButton("-");
    mulButton = new JButton("*");
    divButton = new JButton("/");
    decimalButton = new JButton(".");
    equalsButton = new JButton("=");
    clearButton = new JButton("C");
    deleteButton = new JButton("Del");

    operationButtons = new JButton[] {
        addButton, subButton, mulButton, divButton,
        decimalButton, equalsButton, clearButton, deleteButton
    };

    // Add action listeners and formatting to operation buttons
    for (JButton button : operationButtons) {
      button.addActionListener(this);
      button.setFont(new Font("Arial", Font.BOLD, 18));
      button.setFocusable(false);
    }

    // Position delete and clear buttons
    deleteButton.setBounds(50, 90, 145, 50);
    clearButton.setBounds(205, 90, 145, 50);

    // Create button panel with GridLayout
    JPanel buttonPanel = new JPanel();
    buttonPanel.setBounds(50, 150, 300, 300);
    buttonPanel.setLayout(new GridLayout(4, 4, 10, 10));

    // Add buttons to panel in calculator layout
    buttonPanel.add(numberButtons[7]);
    buttonPanel.add(numberButtons[8]);
    buttonPanel.add(numberButtons[9]);
    buttonPanel.add(divButton);

    buttonPanel.add(numberButtons[4]);
    buttonPanel.add(numberButtons[5]);
    buttonPanel.add(numberButtons[6]);
    buttonPanel.add(mulButton);

    buttonPanel.add(numberButtons[1]);
    buttonPanel.add(numberButtons[2]);
    buttonPanel.add(numberButtons[3]);
    buttonPanel.add(subButton);

    buttonPanel.add(decimalButton);
    buttonPanel.add(numberButtons[0]);
    buttonPanel.add(equalsButton);
    buttonPanel.add(addButton);

    add(buttonPanel);
    add(deleteButton);
    add(clearButton);

    setVisible(true);
  }

  @Override
  public void actionPerformed(ActionEvent e) {
    // Handle number button clicks
    for (int i = 0; i < 10; i++) {
      if (e.getSource() == numberButtons[i]) {
        display.setText(display.getText() + i);
      }
    }

    // Handle decimal button
    if (e.getSource() == decimalButton) {
      if (!display.getText().contains(".")) {
        display.setText(display.getText() + ".");
      }
    }

    // Handle operation buttons
    if (e.getSource() == addButton) {
      num1 = Double.parseDouble(display.getText());
      operator = '+';
      display.setText("");
    }

    if (e.getSource() == subButton) {
      num1 = Double.parseDouble(display.getText());
      operator = '-';
      display.setText("");
    }

    if (e.getSource() == mulButton) {
      num1 = Double.parseDouble(display.getText());
      operator = '*';
      display.setText("");
    }

    if (e.getSource() == divButton) {
      num1 = Double.parseDouble(display.getText());
      operator = '/';
      display.setText("");
    }

    // Handle equals button
    if (e.getSource() == equalsButton) {
      num2 = Double.parseDouble(display.getText());

      switch (operator) {
        case '+':
          result = num1 + num2;
          break;
        case '-':
          result = num1 - num2;
          break;
        case '*':
          result = num1 * num2;
          break;
        case '/':
          if (num2 != 0) {
            result = num1 / num2;
          } else {
            display.setText("Error");
            return;
          }
          break;
      }

      display.setText(String.valueOf(result));
      num1 = result;
    }

    // Handle clear button
    if (e.getSource() == clearButton) {
      display.setText("");
      num1 = 0;
      num2 = 0;
      result = 0;
    }

    // Handle delete button
    if (e.getSource() == deleteButton) {
      String currentText = display.getText();
      if (currentText.length() > 0) {
        display.setText(currentText.substring(0, currentText.length() - 1));
      }
    }
  }

  public static void main(String[] args) {
    // Run on Event Dispatch Thread
    SwingUtilities.invokeLater(() -> new Calculator());
  }
}
```
]

#pagebreak()

= Task 4: Tic-Tac-Toe with AI Opponent

Create a Tic-Tac-Toe game with a computer opponent. This task combines 2D arrays, game logic, and basic AI using the minimax algorithm or simple heuristics.

Build a playable Tic-Tac-Toe game where a human player competes against the computer. The computer should make intelligent moves to challenge the player.

Your program should:
1. Use a 3x3 2D array to represent the game board
2. Display the board after each move
3. Allow the human player to choose positions
4. Implement computer AI that makes strategic moves
5. Check for win conditions (rows, columns, diagonals)
6. Detect draw conditions when the board is full
7. Allow replay after game ends

== Requirements
- Use a 2D character array for the board
- Validate user input (position must be empty and valid)
- Implement win detection for all 8 possible winning lines
- Computer should block player wins when possible
- Display clear game status (whose turn, winner, draw)

== Assistance

*Game board structure:*
```java
public class TicTacToe {
    private char[][] board;
    private static final char EMPTY = ' ';
    private static final char PLAYER = 'X';
    private static final char COMPUTER = 'O';

    public TicTacToe() {
        board = new char[3][3];
        for (int i = 0; i < 3; i++) {
            for (int j = 0; j < 3; j++) {
                board[i][j] = EMPTY;
            }
        }
    }

    public void printBoard() {
        System.out.println("  0 1 2");
        for (int i = 0; i < 3; i++) {
            System.out.print(i + " ");
            for (int j = 0; j < 3; j++) {
                System.out.print(board[i][j]);
                if (j < 2) System.out.print("|");
            }
            System.out.println();
            if (i < 2) System.out.println("  -----");
        }
        System.out.println();
    }

    public boolean checkWin(char player) {
        // Check rows
        for (int i = 0; i < 3; i++) {
            if (board[i][0] == player && board[i][1] == player &&
                board[i][2] == player) return true;
        }

        // Check columns
        for (int j = 0; j < 3; j++) {
            if (board[0][j] == player && board[1][j] == player &&
                board[2][j] == player) return true;
        }

        // Check diagonals
        if (board[0][0] == player && board[1][1] == player &&
            board[2][2] == player) return true;
        if (board[0][2] == player && board[1][1] == player &&
            board[2][0] == player) return true;

        return false;
    }

    // Simple AI: Find winning move, block opponent, or choose random
    public void computerMove() {
        // Try to win
        for (int i = 0; i < 3; i++) {
            for (int j = 0; j < 3; j++) {
                if (board[i][j] == EMPTY) {
                    board[i][j] = COMPUTER;
                    if (checkWin(COMPUTER)) return;
                    board[i][j] = EMPTY;
                }
            }
        }

        // Try to block player
        for (int i = 0; i < 3; i++) {
            for (int j = 0; j < 3; j++) {
                if (board[i][j] == EMPTY) {
                    board[i][j] = PLAYER;
                    if (checkWin(PLAYER)) {
                        board[i][j] = COMPUTER;
                        return;
                    }
                    board[i][j] = EMPTY;
                }
            }
        }

        // Choose center if available
        if (board[1][1] == EMPTY) {
            board[1][1] = COMPUTER;
            return;
        }

        // Choose random available position
        // Implementation here
    }
}
```

#if solution [
== Solution

```java
import java.util.Random;
import java.util.Scanner;

public class TicTacToe {
  private char[][] board;
  private static final char EMPTY = ' ';
  private static final char PLAYER = 'X';
  private static final char COMPUTER = 'O';
  private Random random;

  public TicTacToe() {
    board = new char[3][3];
    random = new Random();
    // Initialize empty board
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        board[i][j] = EMPTY;
      }
    }
  }

  // Print the current board
  public void printBoard() {
    System.out.println("\n  0 1 2");
    for (int i = 0; i < 3; i++) {
      System.out.print(i + " ");
      for (int j = 0; j < 3; j++) {
        System.out.print(board[i][j]);
        if (j < 2) System.out.print("|");
      }
      System.out.println();
      if (i < 2) System.out.println("  -----");
    }
    System.out.println();
  }

  // Check if a position is valid and empty
  public boolean isValidMove(int row, int col) {
    return row >= 0 && row < 3 && col >= 0 && col < 3 && board[row][col] == EMPTY;
  }

  // Make a move
  public void makeMove(int row, int col, char player) {
    board[row][col] = player;
  }

  // Check if someone won
  public boolean checkWin(char player) {
    // Check rows
    for (int i = 0; i < 3; i++) {
      if (board[i][0] == player && board[i][1] == player && board[i][2] == player) {
        return true;
      }
    }

    // Check columns
    for (int j = 0; j < 3; j++) {
      if (board[0][j] == player && board[1][j] == player && board[2][j] == player) {
        return true;
      }
    }

    // Check diagonals
    if (board[0][0] == player && board[1][1] == player && board[2][2] == player) {
      return true;
    }
    if (board[0][2] == player && board[1][1] == player && board[2][0] == player) {
      return true;
    }

    return false;
  }

  // Check if board is full (draw)
  public boolean isBoardFull() {
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (board[i][j] == EMPTY) {
          return false;
        }
      }
    }
    return true;
  }

  // Computer makes a move using simple AI
  public void computerMove() {
    // Strategy 1: Try to win
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (board[i][j] == EMPTY) {
          board[i][j] = COMPUTER;
          if (checkWin(COMPUTER)) {
            return; // Winning move found
          }
          board[i][j] = EMPTY; // Undo test move
        }
      }
    }

    // Strategy 2: Block player from winning
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (board[i][j] == EMPTY) {
          board[i][j] = PLAYER;
          if (checkWin(PLAYER)) {
            board[i][j] = COMPUTER; // Block the player
            return;
          }
          board[i][j] = EMPTY; // Undo test move
        }
      }
    }

    // Strategy 3: Take center if available
    if (board[1][1] == EMPTY) {
      board[1][1] = COMPUTER;
      return;
    }

    // Strategy 4: Take a corner
    int[][] corners = {{0, 0}, {0, 2}, {2, 0}, {2, 2}};
    for (int[] corner : corners) {
      if (board[corner[0]][corner[1]] == EMPTY) {
        board[corner[0]][corner[1]] = COMPUTER;
        return;
      }
    }

    // Strategy 5: Take any available position
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (board[i][j] == EMPTY) {
          board[i][j] = COMPUTER;
          return;
        }
      }
    }
  }

  // Play the game
  public void play() {
    Scanner scanner = new Scanner(System.in);
    boolean gameOver = false;

    System.out.println("=== Tic-Tac-Toe ===");
    System.out.println("You are X, Computer is O");
    printBoard();

    while (!gameOver) {
      // Player's turn
      boolean validMove = false;
      while (!validMove) {
        System.out.print("Enter row (0-2): ");
        int row = scanner.nextInt();
        System.out.print("Enter column (0-2): ");
        int col = scanner.nextInt();

        if (isValidMove(row, col)) {
          makeMove(row, col, PLAYER);
          validMove = true;
        } else {
          System.out.println("Invalid move! Try again.");
        }
      }

      printBoard();

      // Check if player won
      if (checkWin(PLAYER)) {
        System.out.println("Congratulations! You win!");
        gameOver = true;
        break;
      }

      // Check for draw
      if (isBoardFull()) {
        System.out.println("It's a draw!");
        gameOver = true;
        break;
      }

      // Computer's turn
      System.out.println("Computer's turn...");
      computerMove();
      printBoard();

      // Check if computer won
      if (checkWin(COMPUTER)) {
        System.out.println("Computer wins! Better luck next time.");
        gameOver = true;
        break;
      }

      // Check for draw
      if (isBoardFull()) {
        System.out.println("It's a draw!");
        gameOver = true;
        break;
      }
    }

    scanner.close();
  }

  public static void main(String[] args) {
    TicTacToe game = new TicTacToe();
    game.play();
  }
}
```
]

#pagebreak()

= Task 5: Recursive Fractal Tree Generator

Create a program that draws fractal trees using recursion. This task demonstrates recursive drawing, coordinate geometry, and visual pattern generation.

Implement a fractal tree generator that uses recursion to create beautiful branching patterns. Each branch spawns two smaller branches at angles, creating a tree-like structure.

Your program should:
1. Use Java graphics (JPanel, Graphics2D) to draw lines
2. Implement a recursive `drawBranch()` method
3. Start with a trunk and recursively draw smaller branches
4. Decrease branch length by a factor (e.g., 0.7) at each level
5. Split each branch into two branches at angles (e.g., ±30 degrees)
6. Stop recursion when branches become too small (base case)
7. Allow user to adjust parameters (angle, length factor, depth)

== Requirements
- Use recursive method for drawing branches
- Apply trigonometry to calculate branch endpoints
- Implement proper base case to stop recursion
- Create a visually appealing tree structure
- Allow customization of tree parameters

== Assistance

*Basic fractal tree structure:*
```java
import javax.swing.*;
import java.awt.*;

public class FractalTree extends JPanel {
    private int maxDepth = 10;

    @Override
    protected void paintComponent(Graphics g) {
        super.paintComponent(g);
        Graphics2D g2d = (Graphics2D) g;
        g2d.setRenderingHint(RenderingHints.KEY_ANTIALIASING,
                             RenderingHints.VALUE_ANTIALIAS_ON);

        // Start drawing from bottom center
        int startX = getWidth() / 2;
        int startY = getHeight() - 50;
        int length = 100;

        drawBranch(g2d, startX, startY, length, -90, maxDepth);
    }

    private void drawBranch(Graphics2D g2d, int x1, int y1,
                           double length, double angle, int depth) {
        if (depth == 0 || length < 2) return;

        // Calculate end point of current branch
        int x2 = x1 + (int)(length * Math.cos(Math.toRadians(angle)));
        int y2 = y1 + (int)(length * Math.sin(Math.toRadians(angle)));

        // Draw the branch
        g2d.setColor(new Color(139, 69, 19)); // Brown
        g2d.drawLine(x1, y1, x2, y2);

        // Recursively draw two smaller branches
        double newLength = length * 0.7;
        drawBranch(g2d, x2, y2, newLength, angle - 25, depth - 1);
        drawBranch(g2d, x2, y2, newLength, angle + 25, depth - 1);
    }

    public static void main(String[] args) {
        JFrame frame = new JFrame("Fractal Tree");
        FractalTree tree = new FractalTree();
        frame.add(tree);
        frame.setSize(800, 600);
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.setVisible(true);
    }
}
```

*Extending with user controls:*
```java
// Add sliders or input fields to control:
// - maxDepth (recursion depth)
// - angle spread (branch angle)
// - lengthFactor (how much branches shrink)
// - initial trunk length
```

#if solution [
== Solution

```java
import javax.swing.*;
import java.awt.*;

public class FractalTree extends JPanel {
  private int maxDepth = 10;
  private double angleSpread = 25.0; // degrees
  private double lengthFactor = 0.7;

  public FractalTree() {
    setPreferredSize(new Dimension(800, 600));
    setBackground(Color.WHITE);
  }

  @Override
  protected void paintComponent(Graphics g) {
    super.paintComponent(g);
    Graphics2D g2d = (Graphics2D) g;

    // Enable anti-aliasing for smooth lines
    g2d.setRenderingHint(RenderingHints.KEY_ANTIALIASING,
                         RenderingHints.VALUE_ANTIALIAS_ON);

    // Start drawing from bottom center
    int startX = getWidth() / 2;
    int startY = getHeight() - 50;
    int trunkLength = 120;

    // Draw the tree starting with trunk going upward (-90 degrees)
    drawBranch(g2d, startX, startY, trunkLength, -90, maxDepth);
  }

  /**
   * Recursively draw a branch
   * @param g2d Graphics context
   * @param x1 Starting x coordinate
   * @param y1 Starting y coordinate
   * @param length Length of the branch
   * @param angle Angle in degrees (0 = right, -90 = up)
   * @param depth Remaining recursion depth
   */
  private void drawBranch(Graphics2D g2d, int x1, int y1,
                          double length, double angle, int depth) {
    // Base case: stop when depth reaches 0 or branch too small
    if (depth == 0 || length < 2) {
      return;
    }

    // Calculate end point of current branch using trigonometry
    int x2 = x1 + (int)(length * Math.cos(Math.toRadians(angle)));
    int y2 = y1 + (int)(length * Math.sin(Math.toRadians(angle)));

    // Set color based on depth (brown for trunk, green for leaves)
    if (depth > 3) {
      // Brown for thicker branches
      int brownShade = 139 - (maxDepth - depth) * 10;
      brownShade = Math.max(50, Math.min(139, brownShade));
      g2d.setColor(new Color(brownShade, 69, 19));
    } else {
      // Green for thinner branches (leaves)
      g2d.setColor(new Color(34, 139, 34));
    }

    // Set stroke width based on depth
    int strokeWidth = Math.max(1, depth / 2);
    g2d.setStroke(new BasicStroke(strokeWidth));

    // Draw the branch
    g2d.drawLine(x1, y1, x2, y2);

    // Calculate new length for child branches
    double newLength = length * lengthFactor;

    // Recursively draw left branch (angle - angleSpread)
    drawBranch(g2d, x2, y2, newLength, angle - angleSpread, depth - 1);

    // Recursively draw right branch (angle + angleSpread)
    drawBranch(g2d, x2, y2, newLength, angle + angleSpread, depth - 1);
  }

  // Setters for parameters
  public void setMaxDepth(int maxDepth) {
    this.maxDepth = maxDepth;
    repaint();
  }

  public void setAngleSpread(double angleSpread) {
    this.angleSpread = angleSpread;
    repaint();
  }

  public void setLengthFactor(double lengthFactor) {
    this.lengthFactor = lengthFactor;
    repaint();
  }

  public static void main(String[] args) {
    SwingUtilities.invokeLater(() -> {
      JFrame frame = new JFrame("Recursive Fractal Tree");
      FractalTree tree = new FractalTree();

      // Create control panel
      JPanel controlPanel = new JPanel();
      controlPanel.setLayout(new FlowLayout());

      // Depth slider
      JLabel depthLabel = new JLabel("Depth: 10");
      JSlider depthSlider = new JSlider(1, 15, 10);
      depthSlider.addChangeListener(e -> {
        int value = depthSlider.getValue();
        depthLabel.setText("Depth: " + value);
        tree.setMaxDepth(value);
      });

      // Angle slider
      JLabel angleLabel = new JLabel("Angle: 25°");
      JSlider angleSlider = new JSlider(10, 45, 25);
      angleSlider.addChangeListener(e -> {
        int value = angleSlider.getValue();
        angleLabel.setText("Angle: " + value + "°");
        tree.setAngleSpread(value);
      });

      // Length factor slider
      JLabel lengthLabel = new JLabel("Length: 0.7");
      JSlider lengthSlider = new JSlider(50, 90, 70);
      lengthSlider.addChangeListener(e -> {
        double value = lengthSlider.getValue() / 100.0;
        lengthLabel.setText("Length: " + String.format("%.2f", value));
        tree.setLengthFactor(value);
      });

      // Add controls to panel
      controlPanel.add(new JLabel("Recursion "));
      controlPanel.add(depthSlider);
      controlPanel.add(depthLabel);

      controlPanel.add(new JLabel(" | Branch Angle "));
      controlPanel.add(angleSlider);
      controlPanel.add(angleLabel);

      controlPanel.add(new JLabel(" | Shrink Factor "));
      controlPanel.add(lengthSlider);
      controlPanel.add(lengthLabel);

      // Setup frame
      frame.setLayout(new BorderLayout());
      frame.add(tree, BorderLayout.CENTER);
      frame.add(controlPanel, BorderLayout.SOUTH);
      frame.pack();
      frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
      frame.setLocationRelativeTo(null);
      frame.setVisible(true);
    });
  }
}
```
]

#pagebreak()

= Task 6: Sudoku Solver with Backtracking (Optional)

Create a Sudoku solver using recursive backtracking. This task builds on the maze pathfinding concepts and applies them to constraint satisfaction problems.

Implement a program that can solve 9x9 Sudoku puzzles using recursive backtracking:
- Read a partially filled Sudoku grid (use 0 for empty cells)
- Find empty cells and try numbers 1-9
- Use recursion to explore all possible solutions
- Backtrack when constraints are violated
- Display the solved puzzle

Your program should:
1. Represent the Sudoku grid as a 2D integer array
2. Implement `isValid(int[][] grid, int row, int col, int num)` to check constraints
3. Create a recursive `solveSudoku(int[][] grid)` method
4. Handle backtracking when no valid numbers can be placed
5. Display the completed puzzle

== Requirements
- Check row, column, and 3x3 box constraints
- Use recursive backtracking algorithm
- Handle cases with no solution
- Display the grid in a readable format

== Assistance

*Sudoku grid representation:*
```java
public class SudokuSolver {
    private static final int SIZE = 9;
    private static final int EMPTY = 0;

    private int[][] grid = {
        {5, 3, 0, 0, 7, 0, 0, 0, 0},
        {6, 0, 0, 1, 9, 5, 0, 0, 0},
        {0, 9, 8, 0, 0, 0, 0, 6, 0},
        {8, 0, 0, 0, 6, 0, 0, 0, 3},
        {4, 0, 0, 8, 0, 3, 0, 0, 1},
        {7, 0, 0, 0, 2, 0, 0, 0, 6},
        {0, 6, 0, 0, 0, 0, 2, 8, 0},
        {0, 0, 0, 4, 1, 9, 0, 0, 5},
        {0, 0, 0, 0, 8, 0, 0, 7, 9}
    };
}
```

*Constraint checking:*
```java
private boolean isValid(int[][] grid, int row, int col, int num) {
    // Check row
    for (int x = 0; x < SIZE; x++) {
        if (grid[row][x] == num) return false;
    }

    // Check column
    for (int x = 0; x < SIZE; x++) {
        if (grid[x][col] == num) return false;
    }

    // Check 3x3 box
    int startRow = row - row % 3;
    int startCol = col - col % 3;
    for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 3; j++) {
            if (grid[i + startRow][j + startCol] == num) return false;
        }
    }
    return true;
}
```

#if solution [
== Solution

```java
public class SudokuSolver {
  private static final int SIZE = 9;
  private static final int EMPTY = 0;

  // Sample Sudoku puzzle (0 represents empty cells)
  private int[][] grid = {
      {5, 3, 0, 0, 7, 0, 0, 0, 0},
      {6, 0, 0, 1, 9, 5, 0, 0, 0},
      {0, 9, 8, 0, 0, 0, 0, 6, 0},
      {8, 0, 0, 0, 6, 0, 0, 0, 3},
      {4, 0, 0, 8, 0, 3, 0, 0, 1},
      {7, 0, 0, 0, 2, 0, 0, 0, 6},
      {0, 6, 0, 0, 0, 0, 2, 8, 0},
      {0, 0, 0, 4, 1, 9, 0, 0, 5},
      {0, 0, 0, 0, 8, 0, 0, 7, 9}
  };

  // Print the grid
  public void printGrid() {
    for (int row = 0; row < SIZE; row++) {
      if (row % 3 == 0 && row != 0) {
        System.out.println("------+-------+------");
      }

      for (int col = 0; col < SIZE; col++) {
        if (col % 3 == 0 && col != 0) {
          System.out.print("| ");
        }

        if (grid[row][col] == EMPTY) {
          System.out.print(". ");
        } else {
          System.out.print(grid[row][col] + " ");
        }
      }
      System.out.println();
    }
  }

  // Check if placing num at grid[row][col] is valid
  private boolean isValid(int row, int col, int num) {
    // Check row
    for (int x = 0; x < SIZE; x++) {
      if (grid[row][x] == num) {
        return false;
      }
    }

    // Check column
    for (int x = 0; x < SIZE; x++) {
      if (grid[x][col] == num) {
        return false;
      }
    }

    // Check 3x3 box
    int startRow = row - row % 3;
    int startCol = col - col % 3;
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (grid[i + startRow][j + startCol] == num) {
          return false;
        }
      }
    }

    return true;
  }

  // Find next empty cell
  private boolean findEmptyCell(int[] cell) {
    for (int row = 0; row < SIZE; row++) {
      for (int col = 0; col < SIZE; col++) {
        if (grid[row][col] == EMPTY) {
          cell[0] = row;
          cell[1] = col;
          return true;
        }
      }
    }
    return false; // No empty cell found
  }

  // Solve Sudoku using backtracking
  public boolean solve() {
    int[] cell = new int[2];

    // Find next empty cell
    if (!findEmptyCell(cell)) {
      return true; // Puzzle solved
    }

    int row = cell[0];
    int col = cell[1];

    // Try numbers 1 through 9
    for (int num = 1; num <= 9; num++) {
      if (isValid(row, col, num)) {
        // Place the number
        grid[row][col] = num;

        // Recursively try to solve the rest
        if (solve()) {
          return true;
        }

        // Backtrack if this number doesn't lead to solution
        grid[row][col] = EMPTY;
      }
    }

    // No valid number found, trigger backtracking
    return false;
  }

  // Solve and display
  public void solveAndDisplay() {
    System.out.println("=== Sudoku Solver ===\n");
    System.out.println("Original puzzle:");
    printGrid();

    System.out.println("\nSolving...\n");

    if (solve()) {
      System.out.println("Solution found:");
      printGrid();
    } else {
      System.out.println("No solution exists for this puzzle.");
    }
  }

  public static void main(String[] args) {
    SudokuSolver solver = new SudokuSolver();
    solver.solveAndDisplay();
  }
}
```
]

= Lab Execution
If your program is not yet working without issue, we will try to correct this during the course of the lab. With good preparation, this should not be a problem. Every student is required to be able to explain their thought process at the beginning of the lab. By the end of the lab, the task needs to be completed. Of course, we will support you, but your personal commitment must also be clearly recognizable! Julian Moldenhauer, Furkan Yildirim, and Emily Antosch wish you lots of fun and success!
