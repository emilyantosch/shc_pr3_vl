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
  title: "Lab 2 - Encapsulation, Methods, Arrays, and Static Variables",
  university: [HAW Hamburg],
  institute: [TI],
  seminar: [SO2],
  abstract: [
    This lab introduces essential object-oriented programming concepts in Java through three progressive tasks.
    Students will learn encapsulation by implementing private variables with getter/setter methods,
    work with arrays and static variables for data management, and practice method design with validation.
    The exercises build from enhancing the Lab 1 name management system to creating grade calculators
    and bank account simulators, emphasizing proper class design, data protection, and modular programming principles.
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

= Task 1: Enhanced Name Management System

Extend your Java program from Lab 1 to use proper object-oriented programming principles. This task builds on the Person class you created and adds encapsulation, class variables, and arrays.

Modify your name management program as follows:
- Make all instance variables in the Person class private
- Create getter and setter methods to access these variables
- Add validation in the setter for month (must be between 1-12)
- Replace the three separate person variables with an array of Person objects
- Add a static class variable to count the total number of Person objects
- Extend the menu to include option 5: display the total person count

Detailed requirements:
- The inputs in the individual input fields themselves do not need to be checked again
  for correctness, i.e., letters, numbers, special characters, meaning the
  inputs in the individual input fields must be meaningful and do not need
  to be checked by your program. However, all
  instance variables must now be protected from direct external access, i.e., they
  get the private attribute and access to them is done via
  so-called getter and setter methods. Only the month input needs to be
  exemplarily checked for plausibility.
- Introduce a class variable that counts the number of persons and
  outputs it on request, i.e., with the input of the number 5 in the selection menu,
  the number of persons is output. (This is still constant in this task,
  but could become significant in a later extension.)
- Furthermore, the individual persons are now to be stored in an array and no longer in
  separate variables, to enable an extension to a realistic
  number of persons.

== Preparation
Again, first clarify the task by
drawing the Person class according to UML notation and then creating a structure chart
or flowchart that solves this task. Then define
all necessary classes, methods, and variables in Java.

== Assistance
The following code snippets demonstrate key concepts needed for this task:

*Private variables and getter/setter methods:*
```java
public class Person {
    private String firstName;
    private String lastName;
    private int day, month, year;
    private static int personCount = 0;

    // Constructor
    public Person(String firstName, String lastName) {
        this.firstName = firstName;
        this.lastName = lastName;
        personCount++; // Increment when new person is created
    }

    // Getter methods
    public String getFirstName() {
        return firstName;
    }

    // Setter with validation
    public void setMonth(int month) {
        if (month >= 1 && month <= 12) {
            this.month = month;
        } else {
            System.out.println("Invalid month! Must be between 1-12.");
        }
    }

    // Static method to get person count
    public static int getPersonCount() {
        return personCount;
    }
}
```

*Using arrays instead of separate variables:*
```java
Person[] persons = new Person[3];
persons[0] = new Person("John", "Doe");
persons[1] = new Person("Jane", "Smith");
persons[2] = new Person("Bob", "Johnson");
```

== Solution
#if solution [
*Person.java:*
```java
public class Person {
  private String firstName;
  private String lastName;
  private int day;
  private int month;
  private int year;
  private static int personCount = 0;

  // Constructor
  public Person(String firstName, String lastName, int day, int month, int year) {
    this.firstName = firstName;
    this.lastName = lastName;
    this.day = day;
    this.month = month;
    this.year = year;
    personCount++;
  }

  // Getter methods
  public String getFirstName() {
    return firstName;
  }

  public String getLastName() {
    return lastName;
  }

  public int getDay() {
    return day;
  }

  public int getMonth() {
    return month;
  }

  public int getYear() {
    return year;
  }

  // Setter methods
  public void setFirstName(String firstName) {
    this.firstName = firstName;
  }

  public void setLastName(String lastName) {
    this.lastName = lastName;
  }

  public void setDay(int day) {
    this.day = day;
  }

  // Setter with validation for month
  public void setMonth(int month) {
    if (month >= 1 && month <= 12) {
      this.month = month;
    } else {
      System.out.println("Invalid month! Must be between 1-12.");
    }
  }

  public void setYear(int year) {
    this.year = year;
  }

  // Static method to get person count
  public static int getPersonCount() {
    return personCount;
  }

  // Display person information
  public void displayInfo() {
    System.out.println("Name: " + firstName + " " + lastName);
    System.out.println("Name change date: " + day + "." + month + "." + year);
  }

  // Check if three years have passed
  public boolean canChangeName(int newDay, int newMonth, int newYear) {
    int yearsDiff = newYear - this.year;

    if (yearsDiff < 3) {
      return false;
    }

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
}
```

*EnhancedNameManagement.java:*
```java
import java.util.Scanner;

public class EnhancedNameManagement {
  public static void main(String[] args) {
    Scanner scanner = new Scanner(System.in);

    // Hamburg greeting
    System.out.println("Moin!");

    // Create array of Person objects
    Person[] persons = new Person[3];
    persons[0] = new Person("Max", "Mustermann", 1, 1, 2020);
    persons[1] = new Person("Anna", "Schmidt", 15, 6, 2019);
    persons[2] = new Person("Peter", "Mueller", 20, 12, 2021);

    boolean running = true;

    while (running) {
      System.out.println("\n=== Enhanced Name Management System ===");
      System.out.println("Which person wants to change their name?");
      System.out.println("Enter 1, 2, or 3 for the person");
      System.out.println("Enter 4 to display all persons");
      System.out.println("Enter 5 to display total person count");
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
        for (int i = 0; i < persons.length; i++) {
          System.out.println("\nPerson " + (i + 1) + ":");
          persons[i].displayInfo();
        }
      } else if (choice == 5) {
        // Display person count
        System.out.println("\nTotal number of persons: " + Person.getPersonCount());
      } else if (choice >= 1 && choice <= 3) {
        // Select the person to change
        Person selectedPerson = persons[choice - 1];

        // Get new name information
        System.out.print("Enter new first name: ");
        String newFirst = scanner.nextLine();
        selectedPerson.setFirstName(newFirst);

        System.out.print("Enter new last name: ");
        String newLast = scanner.nextLine();
        selectedPerson.setLastName(newLast);

        System.out.print("Enter day of name change: ");
        int newDay = scanner.nextInt();
        selectedPerson.setDay(newDay);

        System.out.print("Enter month of name change (1-12): ");
        int newMonth = scanner.nextInt();
        selectedPerson.setMonth(newMonth); // Validates month automatically

        System.out.print("Enter year of name change: ");
        int newYear = scanner.nextInt();
        scanner.nextLine(); // Consume newline

        // Check if three years have passed
        if (selectedPerson.canChangeName(newDay, newMonth, newYear)) {
          selectedPerson.setYear(newYear);
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

= Task 2: Student Grade Calculator (Continuation of Lab 1, Task 4)

== Preparation
Before implementing the solution, you must:
1. Design a class structure for the grade calculator system
2. Create a UML class diagram showing:
  - Class name (e.g., GradeCalculator)
  - All methods with their parameters and return types
  - Any necessary attributes/fields
3. Transfer your implementation into this class structure
4. Only after completing the UML diagram should you begin coding

This preparation step ensures you think about the object-oriented design before writing code.

== Task
This task continues the grade management system from Lab 1, Task 4. Create a Java program that manages student grades using arrays and methods. This task will help you practice working with arrays, methods, and calculations.

Write a program that:
- Stores grades for 5 students in an array
- Calculates the average grade
- Finds the highest and lowest grades
- Counts how many students passed (grade >= 60)
- Displays all results in a clear format

Your program should:
1. Ask the user to enter 5 student grades (0-100)
2. Store these grades in an array
3. Use separate methods for each calculation:
  - `int calculateAverage(int[] grades)` - returns the average
  - `int findHighest(int[] grades)` - returns the highest grade
  - `int findLowest(int[] grades)` - returns the lowest grade
  - `int countPassing(int[] grades)` - returns number of passing grades
  - `int[] deduplicatedGrades(int[] grades)` - returns a deduplicated array of occurred grades
4. Display all results with appropriate labels

== Requirements
- Use an array to store the grades
- Create separate methods for each calculation
- Use loops to process the array
- Display results with clear formatting


== Assistance
*Array declaration and initialization:*
```java
int[] grades = new int[5];

// Reading grades into array
Scanner scanner = new Scanner(System.in);
for (int i = 0; i < grades.length; i++) {
    System.out.print("Enter grade for student " + (i + 1) + ": ");
    grades[i] = scanner.nextInt();
}
```

*Method example for calculating average:*
```java
public static double calculateAverage(int[] grades) {
    int sum = 0;
    for (int grade : grades) {
        sum += grade;
    }
    return (double) sum / grades.length;
}
```

== Solution
#if solution [
```java
import java.util.Scanner;

public class GradeCalculator {
  public static void main(String[] args) {
    Scanner scanner = new Scanner(System.in);

    // Create array for 5 students
    int[] grades = new int[5];

    // Input grades
    System.out.println("=== Student Grade Calculator ===");
    for (int i = 0; i < grades.length; i++) {
      System.out.print("Enter grade for student " + (i + 1) + ": ");
      grades[i] = scanner.nextInt();
    }

    // Calculate statistics using methods
    double average = calculateAverage(grades);
    int highest = findHighest(grades);
    int lowest = findLowest(grades);
    int passingCount = countPassing(grades);
    int[] uniqueGrades = deduplicatedGrades(grades);

    // Display results
    System.out.println("\n=== Grade Statistics ===");
    System.out.println("Average: " + average);
    System.out.println("Highest: " + highest);
    System.out.println("Lowest: " + lowest);
    System.out.println("Passing (>= 60): " + passingCount);
    System.out.println("Failing (< 60): " + (grades.length - passingCount));

    System.out.print("Unique grades occurred: ");
    for (int i = 0; i < uniqueGrades.length; i++) {
      System.out.print(uniqueGrades[i]);
      if (i < uniqueGrades.length - 1) {
        System.out.print(", ");
      }
    }
    System.out.println();

    scanner.close();
  }

  // Calculate average grade
  public static double calculateAverage(int[] grades) {
    int sum = 0;
    for (int grade : grades) {
      sum += grade;
    }
    return (double) sum / grades.length;
  }

  // Find highest grade
  public static int findHighest(int[] grades) {
    int highest = grades[0];
    for (int grade : grades) {
      if (grade > highest) {
        highest = grade;
      }
    }
    return highest;
  }

  // Find lowest grade
  public static int findLowest(int[] grades) {
    int lowest = grades[0];
    for (int grade : grades) {
      if (grade < lowest) {
        lowest = grade;
      }
    }
    return lowest;
  }

  // Count passing grades (>= 60)
  public static int countPassing(int[] grades) {
    int count = 0;
    for (int grade : grades) {
      if (grade >= 60) {
        count++;
      }
    }
    return count;
  }

  // Return deduplicated array of grades
  public static int[] deduplicatedGrades(int[] grades) {
    // First, count unique grades
    int uniqueCount = 0;
    int[] temp = new int[grades.length];

    for (int i = 0; i < grades.length; i++) {
      boolean isDuplicate = false;
      // Check if grade already exists in temp
      for (int j = 0; j < uniqueCount; j++) {
        if (grades[i] == temp[j]) {
          isDuplicate = true;
          break;
        }
      }
      // If not duplicate, add it
      if (!isDuplicate) {
        temp[uniqueCount] = grades[i];
        uniqueCount++;
      }
    }

    // Create result array with correct size
    int[] result = new int[uniqueCount];
    for (int i = 0; i < uniqueCount; i++) {
      result[i] = temp[i];
    }

    return result;
  }
}
```
]

#pagebreak()

= Task 3: Simple Bank Account Simulator

== Preparation
Before implementing the solution, you must:
1. Design a class structure for the bank account system
2. Create a UML class diagram showing:
  - Class name (BankAccount)
  - All private attributes (balance, accountHolder, etc.)
  - All public methods with their parameters and return types
  - Constructor(s)
3. Transfer your implementation into this class structure
4. Only after completing the UML diagram should you begin coding

This preparation step ensures you think about encapsulation and class design before writing code.

== Task
Create a simple bank account class that demonstrates encapsulation and method design. This task focuses on object-oriented programming principles.

Create a `BankAccount` class with the following features:
- Private balance variable
- Account holder name
- Methods for deposit, withdrawal, and balance inquiry
- Transaction validation (no negative deposits, sufficient funds for withdrawal)

Your program should:
1. Create a BankAccount object
2. Display a menu with options:
  - 1: Check balance
  - 2: Make deposit
  - 3: Make withdrawal
  - 4: Display account info
  - 0: Exit
3. Handle user input and call appropriate methods
4. Validate all transactions and display appropriate messages

== Requirements
- Use private variables with public methods
- Validate all inputs (positive deposits, sufficient funds)
- Display clear success/error messages
- Use proper encapsulation principles

== Assistance

*Basic BankAccount class structure:*
```java
public class BankAccount {
    private double balance;
    private String accountHolder;

    public BankAccount(String name, double initialBalance) {
        this.accountHolder = name;
        this.balance = initialBalance;
    }

    public boolean deposit(double amount) {
        if (amount > 0) {
            balance += amount;
            return true;
        }
        return false;
    }

    public boolean withdraw(double amount) {
        if (amount > 0 && amount <= balance) {
            balance -= amount;
            return true;
        }
        return false;
    }

    public double getBalance() {
        return balance;
    }
}
```

== Solution
#if solution [
*BankAccount.java:*
```java
public class BankAccount {
  private double balance;
  private String accountHolder;

  // Constructor
  public BankAccount(String accountHolder, double initialBalance) {
    this.accountHolder = accountHolder;
    if (initialBalance >= 0) {
      this.balance = initialBalance;
    } else {
      this.balance = 0;
      System.out.println("Initial balance cannot be negative. Set to 0.");
    }
  }

  // Getter for balance
  public double getBalance() {
    return balance;
  }

  // Getter for account holder
  public String getAccountHolder() {
    return accountHolder;
  }

  // Deposit money
  public boolean deposit(double amount) {
    if (amount > 0) {
      balance += amount;
      System.out.println("Successfully deposited: $" + amount);
      return true;
    } else {
      System.out.println("Deposit amount must be positive!");
      return false;
    }
  }

  // Withdraw money
  public boolean withdraw(double amount) {
    if (amount <= 0) {
      System.out.println("Withdrawal amount must be positive!");
      return false;
    }

    if (amount > balance) {
      System.out.println("Insufficient funds! Current balance: $" + balance);
      return false;
    }

    balance -= amount;
    System.out.println("Successfully withdrew: $" + amount);
    return true;
  }

  // Display account information
  public void displayAccountInfo() {
    System.out.println("\n=== Account Information ===");
    System.out.println("Account Holder: " + accountHolder);
    System.out.println("Current Balance: $" + balance);
  }
}
```

*BankAccountSimulator.java:*
```java
import java.util.Scanner;

public class BankAccountSimulator {
  public static void main(String[] args) {
    Scanner scanner = new Scanner(System.in);

    // Create a bank account
    System.out.print("Enter account holder name: ");
    String name = scanner.nextLine();

    System.out.print("Enter initial balance: $");
    double initialBalance = scanner.nextDouble();

    BankAccount account = new BankAccount(name, initialBalance);

    boolean running = true;

    while (running) {
      System.out.println("\n=== Bank Account Menu ===");
      System.out.println("1: Check balance");
      System.out.println("2: Make deposit");
      System.out.println("3: Make withdrawal");
      System.out.println("4: Display account info");
      System.out.println("0: Exit");
      System.out.print("Your choice: ");

      int choice = scanner.nextInt();

      switch (choice) {
        case 0:
          System.out.println("Thank you for using our bank!");
          running = false;
          break;

        case 1:
          System.out.println("Current balance: $" + account.getBalance());
          break;

        case 2:
          System.out.print("Enter deposit amount: $");
          double depositAmount = scanner.nextDouble();
          account.deposit(depositAmount);
          break;

        case 3:
          System.out.print("Enter withdrawal amount: $");
          double withdrawAmount = scanner.nextDouble();
          account.withdraw(withdrawAmount);
          break;

        case 4:
          account.displayAccountInfo();
          break;

        default:
          System.out.println("Invalid choice!");
      }
    }

    scanner.close();
  }
}
```
]

#pagebreak()


= Task 4: Array Sorting and Searching
Create a Java program that demonstrates array manipulation techniques including sorting and searching. This task will help you understand algorithm implementation and array processing.

- *Bubble sort*
  - Bubble Sort works by repeatedly stepping through the array, comparing adjacent elements and swapping them if they are in the wrong order, with larger elements "bubbling" to the end after each pass.
- *Linear Search*
  - Linear Search is a simple algorithm that examines each element in an array sequentially from the beginning until it finds the target value or reaches the end of the array, making it straightforward to implement but less efficient for large datasets.
- *Binary search*
  - Binary Search is an efficient algorithm that works on sorted arrays by repeatedly dividing the search space in half, comparing the target with the middle element to determine which half to search next. Both algorithms demonstrate different approaches to common programming problems with varying time complexities.

Write a program that:
- Creates an array of 10 random integers (1-100)
- Implements bubble sort to sort the array
- Implements linear search to find specific values
- Implements binary search (on sorted array)
- Displays arrays before/after sorting and search results

Your program should:
1. Generate and display an array of 10 random integers
2. Implement the following methods:
  - `void bubbleSort(int[] arr)` - sorts array using bubble sort
  - `int linearSearch(int[] arr, int target)` - returns index or -1
  - `int binarySearch(int[] arr, int target)` - returns index or -1 (requires sorted array)
  - `void printArray(int[] arr)` - displays array contents
3. Demonstrate all methods with user input for search values
4. Compare performance by counting comparisons in each search method

== Requirements
- Use bubble sort algorithm for sorting
- Implement both linear and binary search
- Count and display number of comparisons for each search
- Handle cases where target value is not found

== Assistance

*Random array generation:*
```java
import java.util.Random;

Random random = new Random();
int[] numbers = new int[10];
for (int i = 0; i < numbers.length; i++) {
    numbers[i] = random.nextInt(100) + 1; // 1-100
}
```

== Solution
#if solution [
```java
import java.util.Random;
import java.util.Scanner;

public class ArraySortingSearching {
  public static void main(String[] args) {
    Scanner scanner = new Scanner(System.in);
    Random random = new Random();

    // Generate random array
    int[] numbers = new int[10];
    System.out.println("=== Random Array Generation ===");
    System.out.print("Original array: ");
    for (int i = 0; i < numbers.length; i++) {
      numbers[i] = random.nextInt(100) + 1;
      System.out.print(numbers[i] + " ");
    }
    System.out.println();

    // Bubble sort
    System.out.println("\n=== Sorting with Bubble Sort ===");
    bubbleSort(numbers);
    System.out.print("Sorted array: ");
    printArray(numbers);

    // Search operations
    boolean searching = true;
    while (searching) {
      System.out.println("\n=== Search Menu ===");
      System.out.println("1: Linear Search");
      System.out.println("2: Binary Search");
      System.out.println("0: Exit");
      System.out.print("Your choice: ");

      int choice = scanner.nextInt();

      if (choice == 0) {
        searching = false;
        continue;
      }

      System.out.print("Enter number to search for: ");
      int target = scanner.nextInt();

      if (choice == 1) {
        // Linear search
        int[] result = linearSearch(numbers, target);
        int index = result[0];
        int comparisons = result[1];

        if (index != -1) {
          System.out.println("Linear Search: Found at index " + index);
        } else {
          System.out.println("Linear Search: Not found");
        }
        System.out.println("Comparisons made: " + comparisons);

      } else if (choice == 2) {
        // Binary search
        int[] result = binarySearch(numbers, target);
        int index = result[0];
        int comparisons = result[1];

        if (index != -1) {
          System.out.println("Binary Search: Found at index " + index);
        } else {
          System.out.println("Binary Search: Not found");
        }
        System.out.println("Comparisons made: " + comparisons);
      }
    }

    scanner.close();
  }

  // Bubble sort algorithm
  public static void bubbleSort(int[] arr) {
    int n = arr.length;
    for (int i = 0; i < n - 1; i++) {
      for (int j = 0; j < n - i - 1; j++) {
        if (arr[j] > arr[j + 1]) {
          // Swap elements
          int temp = arr[j];
          arr[j] = arr[j + 1];
          arr[j + 1] = temp;
        }
      }
    }
  }

  // Linear search - returns [index, comparisons]
  public static int[] linearSearch(int[] arr, int target) {
    int comparisons = 0;
    for (int i = 0; i < arr.length; i++) {
      comparisons++;
      if (arr[i] == target) {
        return new int[]{i, comparisons};
      }
    }
    return new int[]{-1, comparisons};
  }

  // Binary search - returns [index, comparisons]
  public static int[] binarySearch(int[] arr, int target) {
    int left = 0;
    int right = arr.length - 1;
    int comparisons = 0;

    while (left <= right) {
      comparisons++;
      int mid = left + (right - left) / 2;

      if (arr[mid] == target) {
        return new int[]{mid, comparisons};
      }

      if (arr[mid] < target) {
        left = mid + 1;
      } else {
        right = mid - 1;
      }
    }

    return new int[]{-1, comparisons};
  }

  // Print array
  public static void printArray(int[] arr) {
    for (int num : arr) {
      System.out.print(num + " ");
    }
    System.out.println();
  }
}
```
]

#pagebreak()

= Task 5: Object Comparison and Equality
Develop a comprehensive understanding of object comparison in Java by creating a Student class that implements proper equality checking and comparison methods.

Create a `Student` class with the following features:
- Private fields: studentID (int), name (String), grade (double)
- Override `equals()` and `hashCode()` methods
- Create methods to compare students by different criteria

Your program should:
1. Create an array of Student objects with sample data
2. Demonstrate equality checking between students
3. Sort students by grade (natural ordering)
4. Sort students by name using a custom comparator
5. Find duplicate students and display them
6. Search for students by ID and name

== Requirements
- Override `equals()` correctly
- Create custom comparators for different sorting criteria
- Demonstrate all comparison methods with test data

== Assistance

*Example Student class with equals:*
```java
public class Student {
    private int studentID;
    private String name;
    private double grade;

    public Student(int studentID, String name, double grade) {
        this.studentID = studentID;
        this.name = name;
        this.grade = grade;
    }

}
```

== Solution
#if solution [
*Student.java:*
```java
public class Student {
  private int studentID;
  private String name;
  private double grade;

  // Constructor
  public Student(int studentID, String name, double grade) {
    this.studentID = studentID;
    this.name = name;
    this.grade = grade;
  }

  // Getters
  public int getStudentID() {
    return studentID;
  }

  public String getName() {
    return name;
  }

  public double getGrade() {
    return grade;
  }

  // Override equals method - students are equal if they have the same ID
  @Override
  public boolean equals(Object obj) {
    if (this == obj) return true;
    if (obj == null || getClass() != obj.getClass()) return false;

    Student student = (Student) obj;
    return studentID == student.studentID;
  }

  // Override hashCode method
  @Override
  public int hashCode() {
    return studentID;
  }

  // Display student info
  public void displayInfo() {
    System.out.println("ID: " + studentID + ", Name: " + name + ", Grade: " + grade);
  }
}
```

*StudentComparison.java:*
```java
public class StudentComparison {
  public static void main(String[] args) {
    // Create array of students
    Student[] students = new Student[5];
    students[0] = new Student(101, "Alice", 85.5);
    students[1] = new Student(102, "Bob", 92.0);
    students[2] = new Student(103, "Charlie", 78.5);
    students[3] = new Student(101, "Alice Duplicate", 90.0); // Same ID as student 0
    students[4] = new Student(104, "Diana", 88.0);

    System.out.println("=== Original Student List ===");
    displayAllStudents(students);

    // Test equality
    System.out.println("\n=== Testing Equality ===");
    System.out.println("Student 0 equals Student 3? " + students[0].equals(students[3]));
    System.out.println("Student 0 equals Student 1? " + students[0].equals(students[1]));

    // Find duplicates
    System.out.println("\n=== Finding Duplicates ===");
    findDuplicates(students);

    // Sort by grade
    System.out.println("\n=== Sorted by Grade (Ascending) ===");
    sortByGrade(students);
    displayAllStudents(students);

    // Sort by name
    System.out.println("\n=== Sorted by Name (Alphabetically) ===");
    sortByName(students);
    displayAllStudents(students);

    // Search by ID
    System.out.println("\n=== Search by ID ===");
    Student found = searchByID(students, 103);
    if (found != null) {
      System.out.print("Found: ");
      found.displayInfo();
    } else {
      System.out.println("Not found");
    }

    // Search by name
    System.out.println("\n=== Search by Name ===");
    found = searchByName(students, "Bob");
    if (found != null) {
      System.out.print("Found: ");
      found.displayInfo();
    } else {
      System.out.println("Not found");
    }
  }

  // Display all students
  public static void displayAllStudents(Student[] students) {
    for (Student s : students) {
      s.displayInfo();
    }
  }

  // Find and display duplicate students
  public static void findDuplicates(Student[] students) {
    for (int i = 0; i < students.length; i++) {
      for (int j = i + 1; j < students.length; j++) {
        if (students[i].equals(students[j])) {
          System.out.println("Duplicate found:");
          System.out.print("  ");
          students[i].displayInfo();
          System.out.print("  ");
          students[j].displayInfo();
        }
      }
    }
  }

  // Sort students by grade (bubble sort)
  public static void sortByGrade(Student[] students) {
    for (int i = 0; i < students.length - 1; i++) {
      for (int j = 0; j < students.length - i - 1; j++) {
        if (students[j].getGrade() > students[j + 1].getGrade()) {
          Student temp = students[j];
          students[j] = students[j + 1];
          students[j + 1] = temp;
        }
      }
    }
  }

  // Sort students by name (bubble sort)
  public static void sortByName(Student[] students) {
    for (int i = 0; i < students.length - 1; i++) {
      for (int j = 0; j < students.length - i - 1; j++) {
        if (students[j].getName().compareTo(students[j + 1].getName()) > 0) {
          Student temp = students[j];
          students[j] = students[j + 1];
          students[j + 1] = temp;
        }
      }
    }
  }

  // Search for student by ID
  public static Student searchByID(Student[] students, int id) {
    for (Student s : students) {
      if (s.getStudentID() == id) {
        return s;
      }
    }
    return null;
  }

  // Search for student by name
  public static Student searchByName(Student[] students, String name) {
    for (Student s : students) {
      if (s.getName().equals(name)) {
        return s;
      }
    }
    return null;
  }
}
```
]

#pagebreak()

= Task 6: Simple Inventory Management System

== Preparation
Before implementing the solution, you must:
1. Design the complete class structure for the inventory management system
2. Create UML class diagrams for both classes showing:
  - *Item class*:
    - All private attributes (name, itemID, quantity, price, static variables)
    - All public methods with their parameters and return types
    - Constructor(s)
  - *Inventory class*:
    - All private attributes (items array, itemCount, etc.)
    - All public methods with their parameters and return types
    - Private helper methods (e.g., resizeArray)
    - Constructor(s)
3. Show the relationship between the two classes (composition/aggregation)
4. Transfer your implementation into this class structure
5. Only after completing the UML diagrams should you begin coding

This preparation step ensures you think about multi-class system design and relationships before writing code.

== Task
Create a comprehensive inventory management system that combines all concepts learned in previous tasks. This capstone task integrates arrays, methods, encapsulation, and object-oriented design.

Develop an `Item` class and `Inventory` class to manage a collection of items with the following features:
- Item class with name, ID, quantity, and price
- Inventory class to manage multiple items
- Methods for adding, removing, updating, and searching items
- Generate reports and handle low stock warnings

Your program should:
1. Create an Inventory system with Item objects
2. Implement the following functionality:
  - Add new items to inventory
  - Update item quantities (restock/sell)
  - Search items by name or ID
  - Display low stock warnings (quantity < 5)
  - Calculate total inventory value
  - Generate inventory reports
3. Use arrays to store items and implement dynamic resizing
4. Provide a menu-driven interface for all operations

== Requirements
- Use proper encapsulation with private variables
- Implement input validation for all operations
- Handle array resizing when adding new items
- Calculate and display inventory statistics
- Use static variables to track total number of items

== Assistance

*Item class structure:*
```java
public class Item {
    private String name;
    private int itemID;
    private int quantity;
    private double price;
    private static int totalItems = 0;

    public Item(String name, int itemID, int quantity, double price) {
        this.name = name;
        this.itemID = itemID;
        this.quantity = quantity;
        this.price = price;
        totalItems++;
    }

    public double getTotalValue() {
        return quantity * price;
    }

    public boolean isLowStock() {
        return quantity < 5;
    }

    // Getters and setters...
}
```

*Inventory class with dynamic array:*
```java
public class Inventory {
    private Item[] items;
    private int itemCount;
    private static final int INITIAL_CAPACITY = 10;

    public Inventory() {
        items = new Item[INITIAL_CAPACITY];
        itemCount = 0;
    }

    public void addItem(Item item) {
        if (itemCount >= items.length) {
            resizeArray();
        }
        items[itemCount++] = item;
    }

    private void resizeArray() {
        Item[] newItems = new Item[items.length * 2];
        System.arraycopy(items, 0, newItems, 0, itemCount);
        items = newItems;
    }

    public Item findItemByID(int id) {
        for (int i = 0; i < itemCount; i++) {
            if (items[i].getItemID() == id) {
                return items[i];
            }
        }
        return null;
    }
}
```

== Solution
#if solution [
*Item.java:*
```java
public class Item {
  private String name;
  private int itemID;
  private int quantity;
  private double price;
  private static int totalItems = 0;

  // Constructor
  public Item(String name, int itemID, int quantity, double price) {
    this.name = name;
    this.itemID = itemID;
    this.quantity = quantity;
    this.price = price;
    totalItems++;
  }

  // Getters
  public String getName() {
    return name;
  }

  public int getItemID() {
    return itemID;
  }

  public int getQuantity() {
    return quantity;
  }

  public double getPrice() {
    return price;
  }

  public static int getTotalItems() {
    return totalItems;
  }

  // Setters
  public void setName(String name) {
    this.name = name;
  }

  public void setQuantity(int quantity) {
    if (quantity >= 0) {
      this.quantity = quantity;
    } else {
      System.out.println("Quantity cannot be negative!");
    }
  }

  public void setPrice(double price) {
    if (price >= 0) {
      this.price = price;
    } else {
      System.out.println("Price cannot be negative!");
    }
  }

  // Calculate total value of this item
  public double getTotalValue() {
    return quantity * price;
  }

  // Check if item is low stock
  public boolean isLowStock() {
    return quantity < 5;
  }

  // Add stock
  public void restock(int amount) {
    if (amount > 0) {
      quantity += amount;
      System.out.println("Restocked " + amount + " units of " + name);
    }
  }

  // Sell item (reduce stock)
  public boolean sell(int amount) {
    if (amount <= 0) {
      System.out.println("Amount must be positive!");
      return false;
    }
    if (amount > quantity) {
      System.out.println("Insufficient stock! Available: " + quantity);
      return false;
    }
    quantity -= amount;
    System.out.println("Sold " + amount + " units of " + name);
    return true;
  }

  // Display item info
  public void displayInfo() {
    System.out.printf("ID: %d | Name: %-15s | Qty: %3d | Price: $%.2f | Value: $%.2f%s\n",
        itemID, name, quantity, price, getTotalValue(),
        isLowStock() ? " [LOW STOCK]" : "");
  }
}
```

*Inventory.java:*
```java
public class Inventory {
  private Item[] items;
  private int itemCount;
  private static final int INITIAL_CAPACITY = 10;

  // Constructor
  public Inventory() {
    items = new Item[INITIAL_CAPACITY];
    itemCount = 0;
  }

  // Add item to inventory
  public void addItem(Item item) {
    // Check if item already exists
    Item existing = findItemByID(item.getItemID());
    if (existing != null) {
      System.out.println("Item with ID " + item.getItemID() + " already exists!");
      return;
    }

    // Resize if necessary
    if (itemCount >= items.length) {
      resizeArray();
    }

    items[itemCount++] = item;
    System.out.println("Item added successfully!");
  }

  // Resize array when full
  private void resizeArray() {
    Item[] newItems = new Item[items.length * 2];
    System.arraycopy(items, 0, newItems, 0, itemCount);
    items = newItems;
    System.out.println("Inventory capacity expanded to " + items.length);
  }

  // Find item by ID
  public Item findItemByID(int id) {
    for (int i = 0; i < itemCount; i++) {
      if (items[i].getItemID() == id) {
        return items[i];
      }
    }
    return null;
  }

  // Find item by name
  public Item findItemByName(String name) {
    for (int i = 0; i < itemCount; i++) {
      if (items[i].getName().equalsIgnoreCase(name)) {
        return items[i];
      }
    }
    return null;
  }

  // Remove item by ID
  public boolean removeItem(int id) {
    for (int i = 0; i < itemCount; i++) {
      if (items[i].getItemID() == id) {
        // Shift elements left
        for (int j = i; j < itemCount - 1; j++) {
          items[j] = items[j + 1];
        }
        items[--itemCount] = null;
        System.out.println("Item removed successfully!");
        return true;
      }
    }
    System.out.println("Item not found!");
    return false;
  }

  // Display all items
  public void displayInventory() {
    if (itemCount == 0) {
      System.out.println("Inventory is empty!");
      return;
    }

    System.out.println("\n=== Current Inventory ===");
    for (int i = 0; i < itemCount; i++) {
      items[i].displayInfo();
    }
  }

  // Display low stock warnings
  public void displayLowStockWarnings() {
    System.out.println("\n=== Low Stock Warnings ===");
    boolean foundLowStock = false;

    for (int i = 0; i < itemCount; i++) {
      if (items[i].isLowStock()) {
        items[i].displayInfo();
        foundLowStock = true;
      }
    }

    if (!foundLowStock) {
      System.out.println("No items with low stock!");
    }
  }

  // Calculate total inventory value
  public double calculateTotalValue() {
    double total = 0;
    for (int i = 0; i < itemCount; i++) {
      total += items[i].getTotalValue();
    }
    return total;
  }

  // Generate inventory report
  public void generateReport() {
    System.out.println("\n=== Inventory Report ===");
    System.out.println("Total Items: " + itemCount);
    System.out.println("Total Inventory Value: $" + calculateTotalValue());
    System.out.println("Inventory Capacity: " + items.length);

    displayInventory();
    displayLowStockWarnings();
  }

  public int getItemCount() {
    return itemCount;
  }
}
```

*InventoryManagementSystem.java:*
```java
import java.util.Scanner;

public class InventoryManagementSystem {
  public static void main(String[] args) {
    Scanner scanner = new Scanner(System.in);
    Inventory inventory = new Inventory();

    // Add some sample items
    inventory.addItem(new Item("Laptop", 1001, 15, 899.99));
    inventory.addItem(new Item("Mouse", 1002, 50, 19.99));
    inventory.addItem(new Item("Keyboard", 1003, 3, 49.99));
    inventory.addItem(new Item("Monitor", 1004, 8, 299.99));

    boolean running = true;

    while (running) {
      System.out.println("\n=== Inventory Management System ===");
      System.out.println("1: Add new item");
      System.out.println("2: Update item quantity (restock)");
      System.out.println("3: Sell item");
      System.out.println("4: Search item by ID");
      System.out.println("5: Search item by name");
      System.out.println("6: Display all items");
      System.out.println("7: Display low stock warnings");
      System.out.println("8: Generate inventory report");
      System.out.println("9: Remove item");
      System.out.println("0: Exit");
      System.out.print("Your choice: ");

      int choice = scanner.nextInt();
      scanner.nextLine(); // Consume newline

      switch (choice) {
        case 0:
          System.out.println("Exiting system...");
          running = false;
          break;

        case 1:
          // Add new item
          System.out.print("Enter item name: ");
          String name = scanner.nextLine();
          System.out.print("Enter item ID: ");
          int id = scanner.nextInt();
          System.out.print("Enter quantity: ");
          int quantity = scanner.nextInt();
          System.out.print("Enter price: $");
          double price = scanner.nextDouble();
          scanner.nextLine();

          inventory.addItem(new Item(name, id, quantity, price));
          break;

        case 2:
          // Restock item
          System.out.print("Enter item ID to restock: ");
          int restockID = scanner.nextInt();
          Item restockItem = inventory.findItemByID(restockID);
          if (restockItem != null) {
            System.out.print("Enter quantity to add: ");
            int restockAmount = scanner.nextInt();
            restockItem.restock(restockAmount);
          } else {
            System.out.println("Item not found!");
          }
          break;

        case 3:
          // Sell item
          System.out.print("Enter item ID to sell: ");
          int sellID = scanner.nextInt();
          Item sellItem = inventory.findItemByID(sellID);
          if (sellItem != null) {
            System.out.print("Enter quantity to sell: ");
            int sellAmount = scanner.nextInt();
            sellItem.sell(sellAmount);
          } else {
            System.out.println("Item not found!");
          }
          break;

        case 4:
          // Search by ID
          System.out.print("Enter item ID: ");
          int searchID = scanner.nextInt();
          Item foundByID = inventory.findItemByID(searchID);
          if (foundByID != null) {
            System.out.println("\nItem found:");
            foundByID.displayInfo();
          } else {
            System.out.println("Item not found!");
          }
          break;

        case 5:
          // Search by name
          System.out.print("Enter item name: ");
          String searchName = scanner.nextLine();
          Item foundByName = inventory.findItemByName(searchName);
          if (foundByName != null) {
            System.out.println("\nItem found:");
            foundByName.displayInfo();
          } else {
            System.out.println("Item not found!");
          }
          break;

        case 6:
          // Display all items
          inventory.displayInventory();
          break;

        case 7:
          // Display low stock warnings
          inventory.displayLowStockWarnings();
          break;

        case 8:
          // Generate report
          inventory.generateReport();
          break;

        case 9:
          // Remove item
          System.out.print("Enter item ID to remove: ");
          int removeID = scanner.nextInt();
          inventory.removeItem(removeID);
          break;

        default:
          System.out.println("Invalid choice!");
      }
    }

    scanner.close();
  }
}
```
]

= Lab Execution
If your program is not yet working without issue, we will try to correct this during the course of the lab. With good preparation, this should not be a problem. Every student is required to be able to explain their thought process at the beginning of the lab. By the end of the lab, the task needs to be completed. Of course, we will support you, but your personal commitment must also be clearly recognizable! Julian Moldenhauer, Furkan Yildirim, and Emily Antosch wish you lots of fun and success!
