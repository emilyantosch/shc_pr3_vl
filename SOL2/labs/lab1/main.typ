#import "@preview/grape-suite:3.1.0": exercise, german-dates

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
  title: "Lab 1 - Introduction to Classes, Objects, and Basic Control Structures",
  university: [HAW Hamburg],
  institute: [TI - IE],
  seminar: [SO2],
  abstract: [
    This lab introduces fundamental Java programming concepts through six progressive tasks.
    Students will learn basic object-oriented programming by creating classes and objects,
    practice user input handling and control structures, and work with strings and character processing.
    The exercises progress from building a name management system to implementing a number guessing game,
    creating a Roman numeral converter, developing a simple grade calculator, building a basic calculator with methods, and implementing a word counting program, establishing core programming skills essential for software development.
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


= Task 1: Name Management System

This program allows different people to change their name every three years.
The program to be created should be able to run on different
hardware platforms without recompilation. Therefore, create a Java program that
makes this possible. Proceed as follows:
- First, create a class called Person that contains the following attributes:
  first_name, last_name, name_change_date (separated by day, month, and year).
- Now write a Java program that first outputs the Hamburg greeting
  for "Good day!" on the console.
- Then your program creates three objects of the Person class, named: `person_1`, `person_2`, and `person_3`.
- Then your program asks which person (1, 2, or 3) wants to change their name.
- Inputting 0 leads to program termination and input 4 displays the
  stored attributes of all objects. If the input is 1, 2, or 3, it asks for
  the new first and last name and the day, month, and year from when this change
  should be valid. This date must be checked regarding the three-year limit.
  If the check is successful, the change is made in the corresponding
  object and the result is displayed. If it is not successful, an
  error message is output and the program continues.
- The inputs in the individual input fields themselves do not need to be checked
  for correctness, i.e., letters, numbers, special characters, meaning the
  inputs in the individual input fields must be meaningful and do not need
  to be checked by your program. In a real project, this
  preprocessing would be checked by another program and is therefore not
  the subject of this task.

== Preparation
First clarify the task by drawing the Person class according to UML notation and then creating a structure chart or flowchart that solves this task. Then define all necessary classes in Java.

== Assistance
The following program, which demonstrates console input, can be used to
solve this task:

```java
import java.util.Scanner;

public class InputExample {
  public static void main(String[] args) {
    // Console input
    Scanner scanner = new Scanner(System.in);

    System.out.print("Enter something here: ");
    String input = scanner.nextLine();
    System.out.println("You entered \"" + input + "\"");

    // If a number is needed for case distinction (e.g., age of majority):
    System.out.print("Enter your age: ");
    int age = scanner.nextInt();
    if (age >= 18) {
      System.out.println("Of age.");
    } else {
      System.out.println("Not yet of age.");
    }

    scanner.close();
  }
}
```
#if solution [
== Solution

*Person.java:*
```java
public class Person {
  String first_name;
  String last_name;
  int day;
  int month;
  int year;

  // Constructor to initialize a person
  public Person(String firstName, String lastName, int d, int m, int y) {
    this.first_name = firstName;
    this.last_name = lastName;
    this.day = d;
    this.month = m;
    this.year = y;
  }

  // Display person information
  public void displayInfo() {
    System.out.println("Name: " + first_name + " " + last_name);
    System.out.println("Name change date: " + day + "." + month + "." + year);
  }

  // Check if three years have passed since last name change
  public boolean canChangeName(int newDay, int newMonth, int newYear) {
    // Calculate years difference
    int yearsDiff = newYear - this.year;

    // If less than 3 years, return false
    if (yearsDiff < 3) {
      return false;
    }

    // If exactly 3 years, check month and day
    if (yearsDiff == 3) {
      if (newMonth < this.month) {
        return false;
      }
      if (newMonth == this.month && newDay < this.day) {
        return false;
      }
    }

    return true;
  }

  // Change person's name
  public void changeName(String newFirst, String newLast, int d, int m, int y) {
    this.first_name = newFirst;
    this.last_name = newLast;
    this.day = d;
    this.month = m;
    this.year = y;
  }
}
```

*NameManagement.java:*
```java
import java.util.Scanner;

public class NameManagement {
  public static void main(String[] args) {
    Scanner scanner = new Scanner(System.in);

    // Hamburg greeting
    System.out.println("Moin!");

    // Create three Person objects with initial data
    Person person_1 = new Person("Max", "Mustermann", 1, 1, 2020);
    Person person_2 = new Person("Anna", "Schmidt", 15, 6, 2019);
    Person person_3 = new Person("Peter", "Mueller", 20, 12, 2021);

    boolean running = true;

    while (running) {
      System.out.println("\n=== Name Management System ===");
      System.out.println("Which person wants to change their name?");
      System.out.println("Enter 1, 2, or 3 for the person");
      System.out.println("Enter 4 to display all persons");
      System.out.println("Enter 0 to exit");
      System.out.print("Your choice: ");

      int choice = scanner.nextInt();
      scanner.nextLine(); // Consume newline

      if (choice == 0) {
        System.out.println("Program terminated.");
        running = false;
      } else if (choice == 4) {
        // Display all persons
        System.out.println("\n=== All Persons ===");
        System.out.println("\nPerson 1:");
        person_1.displayInfo();
        System.out.println("\nPerson 2:");
        person_2.displayInfo();
        System.out.println("\nPerson 3:");
        person_3.displayInfo();
      } else if (choice >= 1 && choice <= 3) {
        // Select the person to change
        Person selectedPerson = null;
        if (choice == 1) selectedPerson = person_1;
        else if (choice == 2) selectedPerson = person_2;
        else if (choice == 3) selectedPerson = person_3;

        // Get new name information
        System.out.print("Enter new first name: ");
        String newFirst = scanner.nextLine();

        System.out.print("Enter new last name: ");
        String newLast = scanner.nextLine();

        System.out.print("Enter day of name change: ");
        int newDay = scanner.nextInt();

        System.out.print("Enter month of name change: ");
        int newMonth = scanner.nextInt();

        System.out.print("Enter year of name change: ");
        int newYear = scanner.nextInt();
        scanner.nextLine(); // Consume newline

        // Check if three years have passed
        if (selectedPerson.canChangeName(newDay, newMonth, newYear)) {
          selectedPerson.changeName(newFirst, newLast, newDay, newMonth, newYear);
          System.out.println("\nName change successful!");
          selectedPerson.displayInfo();
        } else {
          System.out.println("\nError: Three years have not passed since last name change!");
        }
      } else {
        System.out.println("Invalid choice!");
      }
    }

    scanner.close();
  }
}
```
]

#pagebreak()

= Task 2: Number Guessing Game

Create a Java program that implements a number guessing game where the computer generates a random number and the player tries to guess it. This task will help you practice loops, conditionals, random number generation, and user input handling in Java.

The program should work as follows:
- Generate a random number between 1 and 100 (inclusive)
- Display a welcome message explaining the game rules
- Repeatedly ask the user to guess the number
- For each guess, provide feedback:
  - "Too small!" if the guess is lower than the target number
  - "Too big!" if the guess is higher than the target number
  - "You guessed it!" if the guess is correct
- Keep track of the number of attempts
- When the correct number is guessed, display a congratulatory message and the number of attempts it took
- The program ends when the correct number is guessed

== Requirements
- Use the `Random` class for generating random numbers
- Use `Scanner` class for user input
- Use a loop structure to keep asking for guesses until correct
- Display clear and user-friendly messages
- Assume the user will always enter valid integers (no input validation needed)

== Assistance
The following code snippets demonstrate key concepts needed for this task:

*Random number generation:*
```java
import java.util.Random;

Random rand = new Random();
int randomNumber = rand.nextInt(100) + 1; // generates 1-100
```

*Simple user input with Scanner:*
```java
import java.util.Scanner;

Scanner scanner = new Scanner(System.in);
System.out.print("Enter your guess: ");
int userGuess = scanner.nextInt();
```

*Basic loop structure:*
```java
boolean gameRunning = true;
while (gameRunning) {
    // Game logic here
    if (userGuess == randomNumber) {
        gameRunning = false; // End the game
    }
}
```

#if solution [
== Solution

```java
import java.util.Random;
import java.util.Scanner;

public class NumberGuessingGame {
  public static void main(String[] args) {
    Scanner scanner = new Scanner(System.in);
    Random random = new Random();

    // Generate random number between 1 and 100
    int targetNumber = random.nextInt(100) + 1;
    int attempts = 0;
    boolean guessedCorrectly = false;

    // Welcome message
    System.out.println("=== Number Guessing Game ===");
    System.out.println("I have chosen a number between 1 and 100.");
    System.out.println("Try to guess it!");

    // Game loop
    while (!guessedCorrectly) {
      System.out.print("\nEnter your guess: ");
      int userGuess = scanner.nextInt();
      attempts++;

      // Check the guess
      if (userGuess < targetNumber) {
        System.out.println("Too small!");
      } else if (userGuess > targetNumber) {
        System.out.println("Too big!");
      } else {
        System.out.println("You guessed it!");
        guessedCorrectly = true;
      }
    }

    // Display final message
    System.out.println("\nCongratulations! You found the number " + targetNumber);
    System.out.println("It took you " + attempts + " attempts.");

    scanner.close();
  }
}
```
]


#pagebreak()

= Task 3: Roman Numeral Converter

Create a Java program that converts Roman numerals to integers. This task will help you practice working with strings, character processing, and conditional logic.

Roman numerals use seven different symbols with specific values:
- I = 1
- V = 5
- X = 10
- L = 50
- C = 100
- D = 500
- M = 1000

== How Roman Numerals Work

Most of the time, Roman numerals are written from largest to smallest (left to right) and you simply add up the values:
- "III" = 1 + 1 + 1 = 3
- "XII" = 10 + 1 + 1 = 12
- "LVIII" = 50 + 5 + 1 + 1 + 1 = 58

However, there are special cases where a smaller numeral appears before a larger one, meaning you subtract instead of add:
- "IV" = 5 - 1 = 4 (not "IIII")
- "IX" = 10 - 1 = 9
- "XL" = 50 - 10 = 40
- "XC" = 100 - 10 = 90
- "CD" = 500 - 100 = 400
- "CM" = 1000 - 100 = 900

== Your Task

Write a program that:
1. Asks the user to enter a Roman numeral as a string
2. Converts it to an integer using the rules above
3. Displays the result

Test your program with these examples:
- "III" should give 3
- "IV" should give 4
- "IX" should give 9
- "LVIII" should give 58
- "MCMXCIV" should give 1994

== Requirements
- Use `Scanner` for input
- Process the string character by character
- Handle both normal addition and subtraction cases
- Display clear output

== Assistance

*Getting individual characters from a string:*
```java
String roman = "XIV";
char firstChar = roman.charAt(0);  // Gets 'X'
int length = roman.length();       // Gets 3
```

*Simple approach - check current and next character:*
```java
String roman = "IV";
int total = 0;

for (int i = 0; i < roman.length(); i++) {
    char current = roman.charAt(i);

    // Check if we need to subtract (when current < next)
    if (i < roman.length() - 1) {
        char next = roman.charAt(i + 1);
        // Add your logic here to compare current and next
    }
}
```

*Getting the value of a Roman numeral character:*
```java
// You can use if-else statements or a switch
int getValue(char c) {
    if (c == 'I') return 1;
    if (c == 'V') return 5;
    if (c == 'X') return 10;
    // ... continue for other characters
    return 0;
}
```

== Solution
#if solution [
```java
import java.util.Scanner;

public class RomanNumeralConverter {
  public static void main(String[] args) {
    Scanner scanner = new Scanner(System.in);

    System.out.println("=== Roman Numeral Converter ===");
    System.out.print("Enter a Roman numeral: ");
    String roman = scanner.nextLine().toUpperCase();

    int result = convertRomanToInteger(roman);
    System.out.println(roman + " = " + result);

    scanner.close();
  }

  // Convert a Roman numeral character to its integer value
  public static int getValue(char romanChar) {
    switch (romanChar) {
      case 'I': return 1;
      case 'V': return 5;
      case 'X': return 10;
      case 'L': return 50;
      case 'C': return 100;
      case 'D': return 500;
      case 'M': return 1000;
      default: return 0;
    }
  }

  // Convert a full Roman numeral string to an integer
  public static int convertRomanToInteger(String roman) {
    int total = 0;

    for (int i = 0; i < roman.length(); i++) {
      int currentValue = getValue(roman.charAt(i));

      // Check if we need to subtract (when current < next)
      if (i < roman.length() - 1) {
        int nextValue = getValue(roman.charAt(i + 1));

        if (currentValue < nextValue) {
          // Subtraction case (e.g., IV, IX, XL)
          total -= currentValue;
        } else {
          // Normal addition
          total += currentValue;
        }
      } else {
        // Last character, always add
        total += currentValue;
      }
    }

    return total;
  }
}
```
]

#pagebreak()

= Task 4: Grade Manager

Create a Java program that calculates and manages student grades. This task will help you practice working with arrays, loops, mathematical operations, and basic data processing in Java.

Your program should implement a simple grade management system that:
- Stores grades for multiple students
- Calculates statistics like average, highest, and lowest grades
- Determines letter grades based on numerical scores
- Provides a summary report

== Program Requirements

Your program should:
1. Ask the user how many students they want to enter grades for
2. Create an array to store the grades
3. Prompt the user to enter each student's grade (0-100)
4. Calculate and display:
  - The average grade
  - The highest grade
  - The lowest grade
  - How many students passed (grade >= 60)
  - How many students failed (grade < 60)
5. Display each student's numerical grade along with their letter grade

== Letter Grade Scale
Use the following grading scale:
- A: 90-100
- B: 80-89
- C: 70-79
- D: 60-69
- F: 0-59

== Requirements
- Use an array to store the grades
- Use loops to process the data
- Use the `Scanner` class for user input
- Display results in a clear, formatted way
- Assume the user will always enter valid numbers between 0-100

== Assistance

*Creating and working with arrays:*
```java
// Create an array to hold grades
int numberOfStudents = 5;
double[] grades = new double[numberOfStudents];

// Store a grade in the array
grades[0] = 85.5;  // First student's grade

// Get a grade from the array
double firstGrade = grades[0];
```

*Sample output format:*
```
=== Grade Report ===
Student 1: 85.5 (B)
Student 2: 92.0 (A)
Student 3: 78.5 (C)
Student 4: 67.0 (D)
Student 5: 88.5 (B)

=== Statistics ===
Average Grade: 82.3
Highest Grade: 92.0
Lowest Grade: 67.0
Students Passed: 5
Students Failed: 0
```

== Solution
#if solution [
```java
import java.util.Scanner;

public class GradeManager {
  public static void main(String[] args) {
    Scanner scanner = new Scanner(System.in);

    // Ask for number of students
    System.out.print("How many students do you want to enter grades for? ");
    int numStudents = scanner.nextInt();

    // Create array to store grades
    double[] grades = new double[numStudents];

    // Input grades
    for (int i = 0; i < numStudents; i++) {
      System.out.print("Enter grade for student " + (i + 1) + ": ");
      grades[i] = scanner.nextDouble();
    }

    // Calculate statistics
    double sum = 0;
    double highest = grades[0];
    double lowest = grades[0];
    int passed = 0;
    int failed = 0;

    for (int i = 0; i < numStudents; i++) {
      sum += grades[i];

      if (grades[i] > highest) {
        highest = grades[i];
      }

      if (grades[i] < lowest) {
        lowest = grades[i];
      }

      if (grades[i] >= 60) {
        passed++;
      } else {
        failed++;
      }
    }

    double average = sum / numStudents;

    // Display grade report
    System.out.println("\n=== Grade Report ===");
    for (int i = 0; i < numStudents; i++) {
      String letterGrade = getLetterGrade(grades[i]);
      System.out.println("Student " + (i + 1) + ": " + grades[i] + " (" + letterGrade + ")");
    }

    // Display statistics
    System.out.println("\n=== Statistics ===");
    System.out.println("Average Grade: " + average);
    System.out.println("Highest Grade: " + highest);
    System.out.println("Lowest Grade: " + lowest);
    System.out.println("Students Passed: " + passed);
    System.out.println("Students Failed: " + failed);

    scanner.close();
  }

  // Convert numerical grade to letter grade
  public static String getLetterGrade(double grade) {
    if (grade >= 90) {
      return "A";
    } else if (grade >= 80) {
      return "B";
    } else if (grade >= 70) {
      return "C";
    } else if (grade >= 60) {
      return "D";
    } else {
      return "F";
    }
  }
}
```
]


#pagebreak()

= Task 5: Simple Calculator with Methods

Create a Java program that implements a basic calculator using methods. This task will help you practice method creation, parameter passing, return values, and program organization in Java.

Your calculator should be able to perform basic arithmetic operations (addition, subtraction, multiplication, division) and be organized using separate methods for each operation.

== Program Requirements

Your program should:
1. Display a menu of available operations to the user
2. Ask the user to select an operation
3. Prompt for two numbers
4. Perform the calculation using the appropriate method
5. Display the result
6. Allow the user to perform multiple calculations
7. Exit when the user chooses to quit

== Menu Options
```
=== Simple Calculator ===
1. Addition (+)
2. Subtraction (-)
3. Multiplication (*)
4. Division (/)
5. Exit
Choose an operation (1-5):
```

== Requirements
- Create separate methods for each arithmetic operation
- Each method should take two parameters and return the result
- Handle division by zero appropriately
- Use a loop to allow multiple calculations
- Use the `Scanner` class for user input
- Display results in a clear format

== Assistance

*Sample program execution:*
```
=== Simple Calculator ===
1. Addition (+)
2. Subtraction (-)
3. Multiplication (*)
4. Division (/)
5. Exit
Choose an operation (1-5): 1
Enter first number: 15.5
Enter second number: 8.3
Result: 15.5 + 8.3 = 23.8

=== Simple Calculator ===
1. Addition (+)
2. Subtraction (-)
3. Multiplication (*)
4. Division (/)
5. Exit
Choose an operation (1-5): 4
Enter first number: 10
Enter second number: 0
Error: Division by zero!
Result: 10.0 / 0.0 = 0.0

=== Simple Calculator ===
1. Addition (+)
2. Subtraction (-)
3. Multiplication (*)
4. Division (/)
5. Exit
Choose an operation (1-5): 5
Thank you for using the calculator!
```

== Solution
#if solution [
```java
import java.util.Scanner;

public class SimpleCalculator {
  public static void main(String[] args) {
    Scanner scanner = new Scanner(System.in);
    boolean running = true;

    while (running) {
      // Display menu
      System.out.println("\n=== Simple Calculator ===");
      System.out.println("1. Addition (+)");
      System.out.println("2. Subtraction (-)");
      System.out.println("3. Multiplication (*)");
      System.out.println("4. Division (/)");
      System.out.println("5. Exit");
      System.out.print("Choose an operation (1-5): ");

      int choice = scanner.nextInt();

      // Exit if user chooses 5
      if (choice == 5) {
        System.out.println("Thank you for using the calculator!");
        running = false;
        continue;
      }

      // Get numbers from user
      System.out.print("Enter first number: ");
      double num1 = scanner.nextDouble();

      System.out.print("Enter second number: ");
      double num2 = scanner.nextDouble();

      // Perform operation based on choice
      double result = 0;
      String operation = "";

      switch (choice) {
        case 1:
          result = add(num1, num2);
          operation = "+";
          break;
        case 2:
          result = subtract(num1, num2);
          operation = "-";
          break;
        case 3:
          result = multiply(num1, num2);
          operation = "*";
          break;
        case 4:
          if (num2 == 0) {
            System.out.println("Error: Division by zero!");
            result = 0;
          } else {
            result = divide(num1, num2);
          }
          operation = "/";
          break;
        default:
          System.out.println("Invalid choice!");
          continue;
      }

      // Display result
      System.out.println("Result: " + num1 + " " + operation + " " + num2 + " = " + result);
    }

    scanner.close();
  }

  // Method for addition
  public static double add(double a, double b) {
    return a + b;
  }

  // Method for subtraction
  public static double subtract(double a, double b) {
    return a - b;
  }

  // Method for multiplication
  public static double multiply(double a, double b) {
    return a * b;
  }

  // Method for division
  public static double divide(double a, double b) {
    return a / b;
  }
}
```
]

#pagebreak()

= Task 6: Word Counter Program

Create a Java program that analyzes text input and counts various statistics about words and characters. This task will help you practice string manipulation, character analysis, and data processing in Java.

Your program should analyze a sentence or paragraph entered by the user and provide detailed statistics about the text.

== Program Requirements

Your program should:
1. Ask the user to enter a sentence or paragraph
2. Count and display:
  - Total number of characters (including spaces)
  - Total number of characters (excluding spaces)
  - Total number of words
  - Total number of sentences (based on periods, exclamation marks, question marks)
  - Number of vowels (a, e, i, o, u - case insensitive)
  - Number of consonants
  - The longest word in the text
3. Display all results in a clear, formatted report

== Requirements
- Use string methods for text processing
- Handle both uppercase and lowercase letters
- Consider punctuation appropriately
- Display results in a well-formatted report
- Use the `Scanner` class for user input

== Assistance

*Character analysis loop:*
```java
String text = "Hello World!";
int vowelCount = 0;
int consonantCount = 0;
int totalChars = text.length();
int charsWithoutSpaces = 0;

for (int i = 0; i < text.length(); i++) {
    char c = text.charAt(i);

    if (Character.isLetter(c)) {
        charsWithoutSpaces++;
        if (isVowel(c)) {
            vowelCount++;
        } else {
            consonantCount++;
        }
    } else if (c != ' ') {
        charsWithoutSpaces++; // Count non-space, non-letter characters
    }
}
```

*Sample program output:*
```
Enter a sentence or paragraph to analyze:
Hello world! This is a great example of text analysis. How cool is that?

=== TEXT ANALYSIS REPORT ===
Original text: "Hello world! This is a great example of text analysis. How cool is that?"

Character Statistics:
- Total characters (with spaces): 78
- Total characters (without spaces): 64
- Number of vowels: 24
- Number of consonants: 40

Word Statistics:
- Total number of words: 14
- Longest word: "analysis"

Sentence Statistics:
- Total number of sentences: 2
```

== Solution
#if solution [
```java
import java.util.Scanner;

public class WordCounter {
  public static void main(String[] args) {
    Scanner scanner = new Scanner(System.in);

    System.out.println("Enter a sentence or paragraph to analyze:");
    String text = scanner.nextLine();

    // Initialize counters
    int totalChars = text.length();
    int charsWithoutSpaces = 0;
    int vowelCount = 0;
    int consonantCount = 0;
    int wordCount = 0;
    int sentenceCount = 0;
    String longestWord = "";

    // Count characters, vowels, and consonants
    for (int i = 0; i < text.length(); i++) {
      char c = text.charAt(i);

      // Count characters without spaces
      if (c != ' ') {
        charsWithoutSpaces++;
      }

      // Count vowels and consonants
      if (Character.isLetter(c)) {
        char lowerChar = Character.toLowerCase(c);
        if (isVowel(lowerChar)) {
          vowelCount++;
        } else {
          consonantCount++;
        }
      }

      // Count sentences (., !, ?)
      if (c == '.' || c == '!' || c == '?') {
        sentenceCount++;
      }
    }

    // Count words and find longest word
    String[] words = text.split("\\s+");
    wordCount = words.length;

    for (String word : words) {
      // Remove punctuation from word for comparison
      String cleanWord = word.replaceAll("[^a-zA-Z]", "");

      if (cleanWord.length() > longestWord.length()) {
        longestWord = cleanWord;
      }
    }

    // Display results
    System.out.println("\n=== TEXT ANALYSIS REPORT ===");
    System.out.println("Original text: \"" + text + "\"");

    System.out.println("\nCharacter Statistics:");
    System.out.println("- Total characters (with spaces): " + totalChars);
    System.out.println("- Total characters (without spaces): " + charsWithoutSpaces);
    System.out.println("- Number of vowels: " + vowelCount);
    System.out.println("- Number of consonants: " + consonantCount);

    System.out.println("\nWord Statistics:");
    System.out.println("- Total number of words: " + wordCount);
    System.out.println("- Longest word: \"" + longestWord + "\"");

    System.out.println("\nSentence Statistics:");
    System.out.println("- Total number of sentences: " + sentenceCount);

    scanner.close();
  }

  // Check if a character is a vowel
  public static boolean isVowel(char c) {
    return c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u';
  }
}
```
]



= Lab Execution
If your program is not yet working without issue, we will try to correct this during the course of the lab. With good preparation, this should not be a problem. Every student is required to be able to explain their thought process at the beginning of the lab. By the end of the lab, the task needs to be completed. Of course, we will support you, but your personal commitment must also be clearly recognizable! Julian Moldenhauer, Furkan Yildirim, and Emily Antosch wish you lots of fun and success!
