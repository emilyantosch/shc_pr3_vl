#import "@preview/grape-suite:3.1.0": exercise, german-dates

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
  title: "Lab 2 - Extension of Name Management with Methods, Class Variables and Arrays",
  university: [HAW Hamburg],
  institute: [TI],
  seminar: [SOL2],
  abstract: [
    This lab introduces essential object-oriented programming concepts in Java through three progressive tasks.
    Students will learn encapsulation by implementing private variables with getter/setter methods,
    work with arrays and static variables for data management, and practice method design with validation.
    The exercises build from enhancing the Lab 1 name management system to creating grade calculators
    and bank account simulators, emphasizing proper class design, data protection, and modular programming principles.
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

= Lab Execution
If your program is not yet working without issue, we will try to correct this during the course of the lab. With good preparation, this should not be a problem. Every student is required to be able to explain their thought process at the beginning of the lab. By the end of the lab, the task needs to be completed. Of course, we will support you, but your personal commitment must also be clearly recognizable! Julian Moldenhauer, Furkan Yildirim, and Emily Antosch wish you lots of fun and success!
