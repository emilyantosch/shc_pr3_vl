#import "@preview/grape-suite:3.1.0": exercise, german-dates
#import "@preview/gentle-clues:1.0.0": *

#import "@preview/gentle-clues:1.0.0": *
#set text(lang: "en")

#import "@preview/codly:1.0.0": *
#show: codly-init.with()

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
  title: "Lab 4 - Creation of a Labyrinth using Arrays and Recursion",
  university: [HAW Hamburg],
  institute: [TI],
  seminar: [SOL2],
  abstract: [
    This lab introduces arrays, recursion, GUI programming, and advanced algorithmic thinking through six progressive tasks.
    Students will learn two-dimensional array manipulation, recursive method design, event-driven programming, and backtracking algorithms.
    The exercises progress from maze pathfinding through Game of Life simulation, GUI calculator development, game AI implementation,
    fractal generation, and culminate with an optional Sudoku solver, emphasizing problem decomposition, visual programming,
    and advanced data structure manipulation.
  ],
  show-outline: true,
  author: "Emily Antosch",
  show-solutions: false,
)

#memo[
  == Submission Deadline
  Deadline to upload the solutions for all tasks is Saturday, 11:59 pm before the lab date.

  == General Information
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

= Lab Execution
If your program is not yet working without issue, we will try to correct this during the course of the lab. With good preparation, this should not be a problem. Every student is required to be able to explain their thought process at the beginning of the lab. By the end of the lab, the task needs to be completed. Of course, we will support you, but your personal commitment must also be clearly recognizable! Julian Moldenhauer, Furkan Yildirim, and Emily Antosch wish you lots of fun and success!
