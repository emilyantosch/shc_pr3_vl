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
  title: "Lab 3 - Inheritance, Polymorphism, and Class Hierarchies",
  university: [HAW Hamburg],
  institute: [TI],
  seminar: [SO2],
  abstract: [
    This lab introduces inheritance and advanced object-oriented programming concepts through three progressive tasks.
    Students will learn class inheritance by extending the Person class to create a Student class,
    practice polymorphism and method overriding, and work with scalable data structures for realistic applications.
    The exercises progress from student management systems to vehicle hierarchies and animal classification,
    emphasizing inheritance relationships, code reusability, and polymorphic behavior.
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

= Task 1: Student Management with Inheritance
Extend your Java program from Lab 2 to demonstrate inheritance by creating a Student class that inherits from the Person class. This task introduces class inheritance, scalability, and advanced object management.

Extend your name management program as follows:
- Create a new `Student` class that inherits all aspects of the `Person` class
- Add a matriculation number attribute that starts at 1001 and increments automatically
- Use a constant `MAX_ANZAHL` to define maximum students (default: 500, scalable to millions)
- Implement proper encapsulation for the matriculation number (private with getter/setter)
- Extend the menu system:
  - Input 0: Exit program
  - Input `MAX_ANZAHL+1`: Display all student attributes
  - Input `MAX_ANZAHL+2`: Display maximum manageable students

Detailed requirements:
- Create a new class Students that inherits all aspects of the Person class
  in addition to the matriculation number. The
  matriculation number starts with 1001 and increases by one with each additional
  person. This matriculation number can also only be accessed via
  appropriate methods. Otherwise, everything remains as before,
  i.e., the program is terminated with input 0, with input `MAX_ANZAHL+1` all
  attributes of all students are displayed, and with `MAX_ANZAHL+2` the
  maximum number of students manageable by the program is output.

== Preparation
First clarify the task by drawing the Student and Person classes according to UML notation, considering their inheritance relationship. Then define all necessary classes, methods, and variables in Java.

== Assistance
The following code snippets demonstrate key inheritance concepts:

*Basic inheritance structure:*
```java
public class Person {
    protected String firstName;
    protected String lastName;
    protected int day, month, year;
    private static int personCount = 0;

    public Person(String firstName, String lastName) {
        this.firstName = firstName;
        this.lastName = lastName;
        personCount++;
    }

    // Getter and setter methods...
}

public class Student extends Person {
    private int matriculationNumber;
    private static int nextMatriculationNumber = 1001;

    public Student(String firstName, String lastName) {
        super(firstName, lastName); // Call parent constructor
        this.matriculationNumber = nextMatriculationNumber++;
    }

    public int getMatriculationNumber() {
        return matriculationNumber;
    }
}
```

*Using constants for scalability:*
```java
public class StudentManager {
    private static final int MAX_ANZAHL = 500;
    private Student[] students = new Student[MAX_ANZAHL];

    // Menu options based on MAX_ANZAHL
    if (choice == MAX_ANZAHL + 1) {
        displayAllStudents();
    } else if (choice == MAX_ANZAHL + 2) {
        System.out.println("Maximum students: " + MAX_ANZAHL);
    }
}
```

#if solution [
== Solution

*Person.java:*
```java
public class Person {
  protected String firstName;
  protected String lastName;
  protected int day;
  protected int month;
  protected int year;
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

  public static int getPersonCount() {
    return personCount;
  }

  // Display person information
  public void displayInfo() {
    System.out.println("Name: " + firstName + " " + lastName);
    System.out.println("Date: " + day + "." + month + "." + year);
  }

  // Check if three years have passed
  public boolean canChangeName(int newDay, int newMonth, int newYear) {
    int yearsDiff = newYear - this.year;
    if (yearsDiff < 3) return false;
    if (yearsDiff == 3) {
      if (newMonth < this.month) return false;
      if (newMonth == this.month && newDay < this.day) return false;
    }
    return true;
  }
}
```

*Student.java:*
```java
public class Student extends Person {
  private int matriculationNumber;
  private static int nextMatriculationNumber = 1001;

  // Constructor
  public Student(String firstName, String lastName, int day, int month, int year) {
    super(firstName, lastName, day, month, year);
    this.matriculationNumber = nextMatriculationNumber++;
  }

  // Getter for matriculation number
  public int getMatriculationNumber() {
    return matriculationNumber;
  }

  // Override displayInfo to include matriculation number
  @Override
  public void displayInfo() {
    System.out.println("Matriculation Number: " + matriculationNumber);
    super.displayInfo();
  }
}
```

*StudentManagementSystem.java:*
```java
import java.util.Scanner;

public class StudentManagementSystem {
  private static final int MAX_ANZAHL = 500;

  public static void main(String[] args) {
    Scanner scanner = new Scanner(System.in);

    // Create array of Student objects
    Student[] students = new Student[MAX_ANZAHL];
    int studentCount = 0;

    // Initialize with some students
    students[studentCount++] = new Student("Max", "Mustermann", 1, 1, 2020);
    students[studentCount++] = new Student("Anna", "Schmidt", 15, 6, 2019);
    students[studentCount++] = new Student("Peter", "Mueller", 20, 12, 2021);

    boolean running = true;

    while (running) {
      System.out.println("\n=== Student Management System ===");
      System.out.println("Enter student number (1-" + studentCount + ") to modify");
      System.out.println("Enter " + (MAX_ANZAHL + 1) + " to display all students");
      System.out.println("Enter " + (MAX_ANZAHL + 2) + " to display maximum capacity");
      System.out.println("Enter 0 to exit");
      System.out.print("Your choice: ");

      int choice = scanner.nextInt();
      scanner.nextLine();

      if (choice == 0) {
        System.out.println("Program terminated.");
        running = false;
      } else if (choice == MAX_ANZAHL + 1) {
        // Display all students
        System.out.println("\n=== All Students ===");
        for (int i = 0; i < studentCount; i++) {
          System.out.println("\nStudent " + (i + 1) + ":");
          students[i].displayInfo();
        }
      } else if (choice == MAX_ANZAHL + 2) {
        // Display maximum capacity
        System.out.println("\nMaximum students manageable: " + MAX_ANZAHL);
        System.out.println("Current students: " + studentCount);
      } else if (choice >= 1 && choice <= studentCount) {
        // Modify selected student
        Student selectedStudent = students[choice - 1];

        System.out.print("Enter new first name: ");
        String newFirst = scanner.nextLine();
        selectedStudent.setFirstName(newFirst);

        System.out.print("Enter new last name: ");
        String newLast = scanner.nextLine();
        selectedStudent.setLastName(newLast);

        System.out.print("Enter day: ");
        int newDay = scanner.nextInt();
        selectedStudent.setDay(newDay);

        System.out.print("Enter month (1-12): ");
        int newMonth = scanner.nextInt();
        selectedStudent.setMonth(newMonth);

        System.out.print("Enter year: ");
        int newYear = scanner.nextInt();
        scanner.nextLine();

        if (selectedStudent.canChangeName(newDay, newMonth, newYear)) {
          selectedStudent.setYear(newYear);
          System.out.println("\nUpdate successful!");
          selectedStudent.displayInfo();
        } else {
          System.out.println("\nError: Three years have not passed!");
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

= Task 2: Vehicle Hierarchy with Polymorphism
Create a vehicle management system that demonstrates inheritance and polymorphism. This task will help you understand method overriding and polymorphic behavior.

Create a class hierarchy for different types of vehicles:
- Base class `Vehicle` with common properties (brand, model, year)
- Subclasses `Car`, `Motorcycle`, and `Truck` that extend Vehicle
- Each subclass should have specific attributes and override methods appropriately

Your program should:
1. Create a base `Vehicle` class with:
  - Protected attributes: brand, model, year
  - Constructor and getter methods
  - A `displayInfo()` method that shows basic vehicle information
  - An abstract or overridable `calculateMaintenanceCost()` method
2. Create subclasses that:
  - Add specific attributes (e.g., `numberOfDoors` for Car, `cargoCapacity` for Truck)
  - Override `displayInfo()` to include subclass-specific information
  - Implement `calculateMaintenanceCost()` with different formulas
3. Create an array of Vehicle objects containing different types
4. Use polymorphism to call methods on all vehicles in the array

== Requirements
- Use inheritance with `extends` keyword
- Demonstrate method overriding with `@Override` annotation
- Create polymorphic behavior using Vehicle array containing different subclasses
- Use `protected` access modifiers appropriately

*Note about `@Override`:* The `@Override` annotation is a helpful tool that tells Java you intend to override a method from the parent class. While not strictly required, it's considered good practice because it helps catch errors at compile time. If you misspell a method name or get the parameters wrong, Java will give you an error instead of accidentally creating a new method.

== Assistance

*Basic vehicle hierarchy:*
```java
public abstract class Vehicle {
    protected String brand;
    protected String model;
    protected int year;

    public Vehicle(String brand, String model, int year) {
        this.brand = brand;
        this.model = model;
        this.year = year;
    }

    public void displayInfo() {
        System.out.println(year + " " + brand + " " + model);
    }

    public abstract double calculateMaintenanceCost();
}

public class Car extends Vehicle {
    private int numberOfDoors;

    public Car(String brand, String model, int year, int doors) {
        super(brand, model, year);
        this.numberOfDoors = doors;
    }

    @Override
    public void displayInfo() {
        super.displayInfo();
        System.out.println("Doors: " + numberOfDoors);
    }

    @Override
    public double calculateMaintenanceCost() {
        return (2025 - year) * 150.0; // Older cars cost more
    }
}
```

*Polymorphic array usage:*
```java
Vehicle[] vehicles = {
    new Car("Toyota", "Camry", 2020, 4),
    new Motorcycle("Honda", "CBR", 2021, 600),
    new Truck("Ford", "F-150", 2019, 1500)
};

for (Vehicle v : vehicles) {
    v.displayInfo(); // Calls overridden method
    System.out.println("Maintenance: $" + v.calculateMaintenanceCost());
}
```

#if solution [
== Solution

*Vehicle.java (Abstract Base Class):*
```java
public abstract class Vehicle {
  protected String brand;
  protected String model;
  protected int year;

  // Constructor
  public Vehicle(String brand, String model, int year) {
    this.brand = brand;
    this.model = model;
    this.year = year;
  }

  // Getters
  public String getBrand() {
    return brand;
  }

  public String getModel() {
    return model;
  }

  public int getYear() {
    return year;
  }

  // Display basic vehicle information
  public void displayInfo() {
    System.out.println(year + " " + brand + " " + model);
  }

  // Abstract method - must be implemented by subclasses
  public abstract double calculateMaintenanceCost();
}
```

*Car.java:*
```java
public class Car extends Vehicle {
  private int numberOfDoors;

  // Constructor
  public Car(String brand, String model, int year, int numberOfDoors) {
    super(brand, model, year);
    this.numberOfDoors = numberOfDoors;
  }

  public int getNumberOfDoors() {
    return numberOfDoors;
  }

  // Override displayInfo to include car-specific information
  @Override
  public void displayInfo() {
    super.displayInfo();
    System.out.println("Type: Car");
    System.out.println("Number of doors: " + numberOfDoors);
  }

  // Implement abstract method
  @Override
  public double calculateMaintenanceCost() {
    // Cars: base cost + age factor
    int age = 2025 - year;
    return 200.0 + (age * 50.0);
  }
}
```

*Motorcycle.java:*
```java
public class Motorcycle extends Vehicle {
  private int engineCapacity; // in cc

  // Constructor
  public Motorcycle(String brand, String model, int year, int engineCapacity) {
    super(brand, model, year);
    this.engineCapacity = engineCapacity;
  }

  public int getEngineCapacity() {
    return engineCapacity;
  }

  @Override
  public void displayInfo() {
    super.displayInfo();
    System.out.println("Type: Motorcycle");
    System.out.println("Engine capacity: " + engineCapacity + "cc");
  }

  @Override
  public double calculateMaintenanceCost() {
    // Motorcycles: lower base cost but engine size affects maintenance
    int age = 2025 - year;
    return 100.0 + (age * 30.0) + (engineCapacity / 100.0);
  }
}
```

*Truck.java:*
```java
public class Truck extends Vehicle {
  private int cargoCapacity; // in kg

  // Constructor
  public Truck(String brand, String model, int year, int cargoCapacity) {
    super(brand, model, year);
    this.cargoCapacity = cargoCapacity;
  }

  public int getCargoCapacity() {
    return cargoCapacity;
  }

  @Override
  public void displayInfo() {
    super.displayInfo();
    System.out.println("Type: Truck");
    System.out.println("Cargo capacity: " + cargoCapacity + "kg");
  }

  @Override
  public double calculateMaintenanceCost() {
    // Trucks: higher maintenance due to heavy use
    int age = 2025 - year;
    return 400.0 + (age * 80.0) + (cargoCapacity / 10.0);
  }
}
```

*VehicleManagementDemo.java:*
```java
public class VehicleManagementDemo {
  public static void main(String[] args) {
    // Create polymorphic array of vehicles
    Vehicle[] vehicles = new Vehicle[5];
    vehicles[0] = new Car("Toyota", "Camry", 2020, 4);
    vehicles[1] = new Motorcycle("Honda", "CBR600RR", 2021, 600);
    vehicles[2] = new Truck("Ford", "F-150", 2019, 1500);
    vehicles[3] = new Car("BMW", "X5", 2022, 5);
    vehicles[4] = new Motorcycle("Yamaha", "R1", 2018, 1000);

    System.out.println("=== Vehicle Fleet Management ===\n");

    // Demonstrate polymorphism
    double totalMaintenanceCost = 0;

    for (int i = 0; i < vehicles.length; i++) {
      System.out.println("Vehicle " + (i + 1) + ":");
      vehicles[i].displayInfo(); // Polymorphic call
      double cost = vehicles[i].calculateMaintenanceCost(); // Polymorphic call
      System.out.printf("Annual Maintenance Cost: $%.2f\n", cost);
      totalMaintenanceCost += cost;
      System.out.println();
    }

    System.out.printf("=== Total Fleet Maintenance Cost: $%.2f ===\n", totalMaintenanceCost);
  }
}
```
]

#pagebreak()

= Task 3: Animal Classification System
Create an animal classification system that demonstrates advanced inheritance concepts including abstract classes and interfaces. This task focuses on designing hierarchical relationships.

Design a system that models different types of animals with their behaviors:
- Abstract base class `Animal` with common properties
- Interface `Flyable` for animals that can fly
- Interface `Swimmable` for animals that can swim
- Concrete animal classes that implement appropriate interfaces

Your program should:
1. Create an abstract `Animal` class with:
  - Protected attributes: name, species, age
  - Abstract method `makeSound()`
  - Concrete method `displayInfo()`
2. Create interfaces:
  - `Flyable` with method `fly()`
  - `Swimmable` with method `swim()`
3. Create concrete animal classes:
  - `Bird` (extends Animal, implements Flyable)
  - `Fish` (extends Animal, implements Swimmable)
  - `Duck` (extends Animal, implements both Flyable and Swimmable)
  - `Dog` (extends Animal, no additional interfaces)
4. Demonstrate multiple inheritance through interfaces

== Requirements
- Use abstract classes and methods
- Implement multiple interfaces in same class
- Override abstract methods in concrete classes
- Demonstrate interface polymorphism

== Assistance

*Abstract class and interface structure:*
```java
public abstract class Animal {
    protected String name;
    protected String species;
    protected int age;

    public Animal(String name, String species, int age) {
        this.name = name;
        this.species = species;
        this.age = age;
    }

    public void displayInfo() {
        System.out.println(name + " is a " + age + " year old " + species);
    }

    public abstract void makeSound();
}

public interface Flyable {
    void fly();
    default int getMaxAltitude() { return 1000; } // Default method
}

public interface Swimmable {
    void swim();
}

public class Duck extends Animal implements Flyable, Swimmable {
    public Duck(String name, int age) {
        super(name, "Duck", age);
    }

    @Override
    public void makeSound() {
        System.out.println("Quack!");
    }

    @Override
    public void fly() {
        System.out.println(name + " is flying over the pond!");
    }

    @Override
    public void swim() {
        System.out.println(name + " is swimming in the water!");
    }
}
```

#if solution [
== Solution

*Animal.java (Abstract Base Class):*
```java
public abstract class Animal {
  protected String name;
  protected String species;
  protected int age;

  // Constructor
  public Animal(String name, String species, int age) {
    this.name = name;
    this.species = species;
    this.age = age;
  }

  // Concrete method
  public void displayInfo() {
    System.out.println(name + " is a " + age + " year old " + species);
  }

  // Getters
  public String getName() {
    return name;
  }

  public String getSpecies() {
    return species;
  }

  public int getAge() {
    return age;
  }

  // Abstract method - must be implemented by subclasses
  public abstract void makeSound();
}
```

*Flyable.java (Interface):*
```java
public interface Flyable {
  void fly();

  // Default method with default implementation
  default int getMaxAltitude() {
    return 1000; // Default altitude in meters
  }
}
```

*Swimmable.java (Interface):*
```java
public interface Swimmable {
  void swim();

  // Default method
  default int getMaxDepth() {
    return 10; // Default depth in meters
  }
}
```

*Bird.java:*
```java
public class Bird extends Animal implements Flyable {
  private String wingSpan;

  public Bird(String name, int age, String wingSpan) {
    super(name, "Bird", age);
    this.wingSpan = wingSpan;
  }

  @Override
  public void makeSound() {
    System.out.println(name + " says: Tweet tweet!");
  }

  @Override
  public void fly() {
    System.out.println(name + " is flying through the air!");
  }

  @Override
  public int getMaxAltitude() {
    return 3000; // Birds can fly higher
  }

  public String getWingSpan() {
    return wingSpan;
  }
}
```

*Fish.java:*
```java
public class Fish extends Animal implements Swimmable {
  private String waterType;

  public Fish(String name, int age, String waterType) {
    super(name, "Fish", age);
    this.waterType = waterType;
  }

  @Override
  public void makeSound() {
    System.out.println(name + " makes bubble sounds...");
  }

  @Override
  public void swim() {
    System.out.println(name + " is swimming in " + waterType + " water!");
  }

  @Override
  public int getMaxDepth() {
    return 100; // Fish can dive deeper
  }

  public String getWaterType() {
    return waterType;
  }
}
```

*Duck.java (Multiple Interfaces):*
```java
public class Duck extends Animal implements Flyable, Swimmable {

  public Duck(String name, int age) {
    super(name, "Duck", age);
  }

  @Override
  public void makeSound() {
    System.out.println(name + " says: Quack quack!");
  }

  @Override
  public void fly() {
    System.out.println(name + " is flying over the pond!");
  }

  @Override
  public void swim() {
    System.out.println(name + " is swimming gracefully!");
  }

  @Override
  public int getMaxAltitude() {
    return 1500; // Ducks fly at moderate altitude
  }

  @Override
  public int getMaxDepth() {
    return 5; // Ducks dive shallow
  }
}
```

*Dog.java:*
```java
public class Dog extends Animal {
  private String breed;

  public Dog(String name, int age, String breed) {
    super(name, "Dog", age);
    this.breed = breed;
  }

  @Override
  public void makeSound() {
    System.out.println(name + " says: Woof woof!");
  }

  public String getBreed() {
    return breed;
  }

  public void fetch() {
    System.out.println(name + " is fetching the ball!");
  }
}
```

*AnimalClassificationDemo.java:*
```java
public class AnimalClassificationDemo {
  public static void main(String[] args) {
    // Create various animals
    Animal[] animals = new Animal[5];
    animals[0] = new Bird("Eagle", 5, "2 meters");
    animals[1] = new Fish("Salmon", 3, "fresh");
    animals[2] = new Duck("Donald", 2);
    animals[3] = new Dog("Buddy", 4, "Golden Retriever");
    animals[4] = new Bird("Sparrow", 1, "20 cm");

    System.out.println("=== Animal Classification System ===\n");

    // Demonstrate polymorphism
    for (Animal animal : animals) {
      animal.displayInfo();
      animal.makeSound();
      System.out.println();
    }

    // Demonstrate interface polymorphism
    System.out.println("=== Flying Animals ===");
    for (Animal animal : animals) {
      if (animal instanceof Flyable) {
        Flyable flyer = (Flyable) animal;
        flyer.fly();
        System.out.println("Max altitude: " + flyer.getMaxAltitude() + " meters");
      }
    }

    System.out.println("\n=== Swimming Animals ===");
    for (Animal animal : animals) {
      if (animal instanceof Swimmable) {
        Swimmable swimmer = (Swimmable) animal;
        swimmer.swim();
        System.out.println("Max depth: " + swimmer.getMaxDepth() + " meters");
      }
    }

    // Duck can both fly and swim
    System.out.println("\n=== Special: Duck can do both! ===");
    Duck duck = (Duck) animals[2];
    duck.fly();
    duck.swim();
  }
}
```
]

#pagebreak()

= Task 4: Collections in Java Programming
Enhance your student management system by implementing generic collections and data structures. This task introduces Java Collections Framework, generics, and advanced data manipulation techniques.

Create a comprehensive student management system using Java collections:
- Replace arrays with appropriate Collection class called ArrayList
- Add search and sorting functionality
- Create custom comparators for different sorting criteria

Your program should:
1. Convert your Student array to use `ArrayList<Student>`
2. Implement a `StudentRegistry` class that uses:
  - `ArrayList<Student>` for maintaining insertion order
4. Implement multiple sorting options with your favorite sorting algorithm (refer to the last lab):
  - Sort by name (alphabetical)
  - Sort by matriculation number
  - Sort by age (if birth date is available)
5. Add advanced search functionality with your favorite search algortihm:
  - Find students by partial name match
  - Find students by matriculation number range
  - Find students older/younger than specific age

== Requirements
- Use appropriate Collection interfaces and implementations
- Implement generic methods with proper type parameters
- Use lambda expressions for predicates and comparators
- Demonstrate the difference between List, Set, and Map usage
- Handle duplicate prevention using Set characteristics

== Assistance

*Collection usage patterns:*
```java
public class StudentRegistry {
    private List<Student> students = new ArrayList<>();

    public void addStudent(Student student) {
        students.add(student);
    }
}
```

#if solution [
== Solution

*Student.java (Updated for Collections):*
```java
public class Student {
  private String firstName;
  private String lastName;
  private int matriculationNumber;
  private int age;
  private static int nextMatriculationNumber = 1001;

  public Student(String firstName, String lastName, int age) {
    this.firstName = firstName;
    this.lastName = lastName;
    this.age = age;
    this.matriculationNumber = nextMatriculationNumber++;
  }

  public String getFirstName() {
    return firstName;
  }

  public String getLastName() {
    return lastName;
  }

  public int getMatriculationNumber() {
    return matriculationNumber;
  }

  public int getAge() {
    return age;
  }

  public String getFullName() {
    return firstName + " " + lastName;
  }

  @Override
  public String toString() {
    return "Student{" +
           "matricNo=" + matriculationNumber +
           ", name='" + getFullName() + '\'' +
           ", age=" + age +
           '}';
  }
}
```

*StudentRegistry.java:*
```java
import java.util.ArrayList;
import java.util.List;

public class StudentRegistry {
  private List<Student> students;

  public StudentRegistry() {
    this.students = new ArrayList<>();
  }

  // Add student
  public void addStudent(Student student) {
    students.add(student);
    System.out.println("Student added: " + student.getFullName());
  }

  // Display all students
  public void displayAllStudents() {
    if (students.isEmpty()) {
      System.out.println("No students in registry.");
      return;
    }

    System.out.println("\n=== All Students ===");
    for (Student student : students) {
      System.out.println(student);
    }
  }

  // Sort by name (Bubble Sort)
  public void sortByName() {
    for (int i = 0; i < students.size() - 1; i++) {
      for (int j = 0; j < students.size() - i - 1; j++) {
        if (students.get(j).getFullName()
            .compareTo(students.get(j + 1).getFullName()) > 0) {
          // Swap
          Student temp = students.get(j);
          students.set(j, students.get(j + 1));
          students.set(j + 1, temp);
        }
      }
    }
    System.out.println("Students sorted by name.");
  }

  // Sort by matriculation number (Bubble Sort)
  public void sortByMatriculationNumber() {
    for (int i = 0; i < students.size() - 1; i++) {
      for (int j = 0; j < students.size() - i - 1; j++) {
        if (students.get(j).getMatriculationNumber() >
            students.get(j + 1).getMatriculationNumber()) {
          // Swap
          Student temp = students.get(j);
          students.set(j, students.get(j + 1));
          students.set(j + 1, temp);
        }
      }
    }
    System.out.println("Students sorted by matriculation number.");
  }

  // Sort by age (Bubble Sort)
  public void sortByAge() {
    for (int i = 0; i < students.size() - 1; i++) {
      for (int j = 0; j < students.size() - i - 1; j++) {
        if (students.get(j).getAge() > students.get(j + 1).getAge()) {
          // Swap
          Student temp = students.get(j);
          students.set(j, students.get(j + 1));
          students.set(j + 1, temp);
        }
      }
    }
    System.out.println("Students sorted by age.");
  }

  // Search by partial name match (Linear Search)
  public List<Student> searchByPartialName(String partialName) {
    List<Student> results = new ArrayList<>();
    String searchTerm = partialName.toLowerCase();

    for (Student student : students) {
      if (student.getFullName().toLowerCase().contains(searchTerm)) {
        results.add(student);
      }
    }
    return results;
  }

  // Search by matriculation number (Linear Search)
  public Student searchByMatriculationNumber(int matricNo) {
    for (Student student : students) {
      if (student.getMatriculationNumber() == matricNo) {
        return student;
      }
    }
    return null;
  }

  // Find students in matriculation number range
  public List<Student> findByMatriculationRange(int min, int max) {
    List<Student> results = new ArrayList<>();
    for (Student student : students) {
      int matricNo = student.getMatriculationNumber();
      if (matricNo >= min && matricNo <= max) {
        results.add(student);
      }
    }
    return results;
  }

  // Find students older than age
  public List<Student> findOlderThan(int age) {
    List<Student> results = new ArrayList<>();
    for (Student student : students) {
      if (student.getAge() > age) {
        results.add(student);
      }
    }
    return results;
  }

  // Find students younger than age
  public List<Student> findYoungerThan(int age) {
    List<Student> results = new ArrayList<>();
    for (Student student : students) {
      if (student.getAge() < age) {
        results.add(student);
      }
    }
    return results;
  }

  public int getStudentCount() {
    return students.size();
  }
}
```

*CollectionsDemo.java:*
```java
import java.util.List;
import java.util.Scanner;

public class CollectionsDemo {
  public static void main(String[] args) {
    Scanner scanner = new Scanner(System.in);
    StudentRegistry registry = new StudentRegistry();

    // Add sample students
    registry.addStudent(new Student("Alice", "Johnson", 22));
    registry.addStudent(new Student("Bob", "Smith", 20));
    registry.addStudent(new Student("Charlie", "Brown", 23));
    registry.addStudent(new Student("Diana", "Prince", 21));
    registry.addStudent(new Student("Eve", "Anderson", 19));

    boolean running = true;

    while (running) {
      System.out.println("\n=== Student Registry with Collections ===");
      System.out.println("1: Add student");
      System.out.println("2: Display all students");
      System.out.println("3: Sort by name");
      System.out.println("4: Sort by matriculation number");
      System.out.println("5: Sort by age");
      System.out.println("6: Search by name");
      System.out.println("7: Search by matriculation number");
      System.out.println("8: Find by matriculation range");
      System.out.println("9: Find by age filter");
      System.out.println("0: Exit");
      System.out.print("Your choice: ");

      int choice = scanner.nextInt();
      scanner.nextLine();

      switch (choice) {
        case 0:
          running = false;
          System.out.println("Exiting...");
          break;

        case 1:
          System.out.print("First name: ");
          String firstName = scanner.nextLine();
          System.out.print("Last name: ");
          String lastName = scanner.nextLine();
          System.out.print("Age: ");
          int age = scanner.nextInt();
          registry.addStudent(new Student(firstName, lastName, age));
          break;

        case 2:
          registry.displayAllStudents();
          break;

        case 3:
          registry.sortByName();
          registry.displayAllStudents();
          break;

        case 4:
          registry.sortByMatriculationNumber();
          registry.displayAllStudents();
          break;

        case 5:
          registry.sortByAge();
          registry.displayAllStudents();
          break;

        case 6:
          System.out.print("Enter name to search: ");
          String searchName = scanner.nextLine();
          List<Student> nameResults = registry.searchByPartialName(searchName);
          System.out.println("Found " + nameResults.size() + " students:");
          for (Student s : nameResults) {
            System.out.println(s);
          }
          break;

        case 7:
          System.out.print("Enter matriculation number: ");
          int matricNo = scanner.nextInt();
          Student found = registry.searchByMatriculationNumber(matricNo);
          if (found != null) {
            System.out.println("Found: " + found);
          } else {
            System.out.println("Student not found.");
          }
          break;

        case 8:
          System.out.print("Enter minimum matriculation number: ");
          int min = scanner.nextInt();
          System.out.print("Enter maximum matriculation number: ");
          int max = scanner.nextInt();
          List<Student> rangeResults = registry.findByMatriculationRange(min, max);
          System.out.println("Found " + rangeResults.size() + " students:");
          for (Student s : rangeResults) {
            System.out.println(s);
          }
          break;

        case 9:
          System.out.println("1: Older than");
          System.out.println("2: Younger than");
          System.out.print("Choice: ");
          int ageChoice = scanner.nextInt();
          System.out.print("Enter age: ");
          int ageFilter = scanner.nextInt();

          List<Student> ageResults;
          if (ageChoice == 1) {
            ageResults = registry.findOlderThan(ageFilter);
            System.out.println("Students older than " + ageFilter + ":");
          } else {
            ageResults = registry.findYoungerThan(ageFilter);
            System.out.println("Students younger than " + ageFilter + ":");
          }
          for (Student s : ageResults) {
            System.out.println(s);
          }
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

= Task 5: Design Patterns Implementation
Implement common design patterns to improve your student management system's architecture. This task introduces Singleton, Observer, and Factory patterns in a practical context.

Apply design patterns to create a robust and maintainable system:
- Observer pattern for real-time notifications
- Factory pattern for creating different types of academic entities
- Strategy pattern for different grading systems

Your program should:
1. Create Observer pattern for student events:
  - `StudentObserver` interface for notifications
  - `StudentSubject` for managing observers
  - Notify observers when students are added, removed, or modified
2. Use Factory pattern for academic entities:
  - `PersonFactory` that creates different types (Student, Professor, Staff)
  - `CourseFactory` for different course types (Lecture, Lab, Seminar)
3. Implement Strategy pattern for grading:
  - Different grading strategies (German grades, ECTS, Pass/Fail)
  - Allow runtime switching between grading systems

== Requirements
- Implement at least three different design patterns
- Demonstrate loose coupling between components
- Use interfaces to define contracts between classes
- Show how patterns improve code maintainability and extensibility

== Assistance

*Observer pattern structure:*
```java
public interface StudentObserver {
    void onStudentAdded(Student student);
    void onStudentRemoved(Student student);
    void onStudentModified(Student student);
}

public class StudentRegistry {
    private List<StudentObserver> observers = new ArrayList<>();
    private List<Student> students = new ArrayList<>();

    public void addObserver(StudentObserver observer) {
        observers.add(observer);
    }

    public void addStudent(Student student) {
        students.add(student);
        notifyObservers(observer -> observer.onStudentAdded(student));
    }

    private void notifyObservers(Consumer<StudentObserver> action) {
        observers.forEach(action);
    }
}
```

*Factory pattern example:*
```java
public abstract class PersonFactory {
    public static Person createPerson(String type, String firstName, String lastName) {
        switch (type.toLowerCase()) {
            case "student":
                return new Student(firstName, lastName);
            case "professor":
                return new Professor(firstName, lastName);
            case "staff":
                return new Staff(firstName, lastName);
            default:
                throw new IllegalArgumentException("Unknown person type: " + type);
        }
    }
}
```

#if solution [
== Solution
*StudentObserver.java (Observer Pattern - Interface):*
```java
public interface StudentObserver {
  void onStudentAdded(Student student);
  void onStudentRemoved(Student student);
  void onStudentModified(Student student);
}
```

*ConsoleLogger.java (Observer Pattern - Concrete Observer):*
```java
public class ConsoleLogger implements StudentObserver {
  @Override
  public void onStudentAdded(Student student) {
    System.out.println("[LOG] Student added: " + student.getFullName());
  }

  @Override
  public void onStudentRemoved(Student student) {
    System.out.println("[LOG] Student removed: " + student.getFullName());
  }

  @Override
  public void onStudentModified(Student student) {
    System.out.println("[LOG] Student modified: " + student.getFullName());
  }
}
```

*ObservableStudentRegistry.java (Observer Pattern - Subject):*
```java
import java.util.ArrayList;
import java.util.List;

public class ObservableStudentRegistry {
  private List<Student> students;
  private List<StudentObserver> observers;

  public ObservableStudentRegistry() {
    this.students = new ArrayList<>();
    this.observers = new ArrayList<>();
  }

  // Register observer
  public void addObserver(StudentObserver observer) {
    observers.add(observer);
  }

  // Remove observer
  public void removeObserver(StudentObserver observer) {
    observers.remove(observer);
  }

  // Notify all observers
  private void notifyStudentAdded(Student student) {
    for (StudentObserver observer : observers) {
      observer.onStudentAdded(student);
    }
  }

  private void notifyStudentRemoved(Student student) {
    for (StudentObserver observer : observers) {
      observer.onStudentRemoved(student);
    }
  }

  private void notifyStudentModified(Student student) {
    for (StudentObserver observer : observers) {
      observer.onStudentModified(student);
    }
  }

  // Student operations
  public void addStudent(Student student) {
    students.add(student);
    notifyStudentAdded(student);
  }

  public void removeStudent(Student student) {
    if (students.remove(student)) {
      notifyStudentRemoved(student);
    }
  }

  public void modifyStudent(Student student) {
    notifyStudentModified(student);
  }

  public List<Student> getStudents() {
    return new ArrayList<>(students);
  }
}
```

*PersonFactory.java (Factory Pattern):*
```java
public class PersonFactory {
  public static Person createPerson(String type, String firstName, String lastName, int age) {
    switch (type.toLowerCase()) {
      case "student":
        return new Student(firstName, lastName, age);
      case "professor":
        return new Professor(firstName, lastName, age);
      case "staff":
        return new Staff(firstName, lastName, age);
      default:
        throw new IllegalArgumentException("Unknown person type: " + type);
    }
  }
}
```

*Professor.java (For Factory Pattern):*
```java
public class Professor extends Person {
  private String department;

  public Professor(String firstName, String lastName, int age) {
    super(firstName, lastName, 1, 1, 2020);
    this.department = "Computer Science";
  }

  public String getDepartment() {
    return department;
  }

  public void setDepartment(String department) {
    this.department = department;
  }

  @Override
  public void displayInfo() {
    System.out.println("Professor: " + getFirstName() + " " + getLastName());
    System.out.println("Department: " + department);
  }
}
```

*Staff.java (For Factory Pattern):*
```java
public class Staff extends Person {
  private String role;

  public Staff(String firstName, String lastName, int age) {
    super(firstName, lastName, 1, 1, 2020);
    this.role = "Administrative Staff";
  }

  public String getRole() {
    return role;
  }

  public void setRole(String role) {
    this.role = role;
  }

  @Override
  public void displayInfo() {
    System.out.println("Staff: " + getFirstName() + " " + getLastName());
    System.out.println("Role: " + role);
  }
}
```

*GradingStrategy.java (Strategy Pattern - Interface):*
```java
public interface GradingStrategy {
  String calculateGrade(double score);
  String getGradingSystemName();
}
```

*GermanGradingStrategy.java:*
```java
public class GermanGradingStrategy implements GradingStrategy {
  @Override
  public String calculateGrade(double score) {
    if (score >= 90) return "1.0 (Sehr gut)";
    else if (score >= 80) return "2.0 (Gut)";
    else if (score >= 70) return "3.0 (Befriedigend)";
    else if (score >= 60) return "4.0 (Ausreichend)";
    else return "5.0 (Nicht bestanden)";
  }

  @Override
  public String getGradingSystemName() {
    return "German Grading System";
  }
}
```

*ECTSGradingStrategy.java:*
```java
public class ECTSGradingStrategy implements GradingStrategy {
  @Override
  public String calculateGrade(double score) {
    if (score >= 90) return "A (Excellent)";
    else if (score >= 80) return "B (Very Good)";
    else if (score >= 70) return "C (Good)";
    else if (score >= 60) return "D (Satisfactory)";
    else if (score >= 50) return "E (Sufficient)";
    else return "F (Fail)";
  }

  @Override
  public String getGradingSystemName() {
    return "ECTS Grading System";
  }
}
```

*PassFailGradingStrategy.java:*
```java
public class PassFailGradingStrategy implements GradingStrategy {
  @Override
  public String calculateGrade(double score) {
    return score >= 60 ? "Pass" : "Fail";
  }

  @Override
  public String getGradingSystemName() {
    return "Pass/Fail System";
  }
}
```

*GradeCalculator.java (Uses Strategy Pattern):*
```java
public class GradeCalculator {
  private GradingStrategy strategy;

  public GradeCalculator(GradingStrategy strategy) {
    this.strategy = strategy;
  }

  public void setStrategy(GradingStrategy strategy) {
    this.strategy = strategy;
  }

  public String calculateGrade(double score) {
    return strategy.calculateGrade(score);
  }

  public String getGradingSystemName() {
    return strategy.getGradingSystemName();
  }
}
```

*DesignPatternsDemo.java:*
```java
public class DesignPatternsDemo {
  public static void main(String[] args) {
    System.out.println("=== Design Patterns Demo ===\n");

    // 1. Singleton Pattern
    System.out.println("--- Singleton Pattern ---");
    ConfigurationManager config1 = ConfigurationManager.getInstance();
    ConfigurationManager config2 = ConfigurationManager.getInstance();
    System.out.println("Same instance? " + (config1 == config2));
    System.out.println("University: " + config1.getUniversityName());
    System.out.println("Max Students: " + config1.getMaxStudents());

    // 2. Observer Pattern
    System.out.println("\n--- Observer Pattern ---");
    ObservableStudentRegistry registry = new ObservableStudentRegistry();
    ConsoleLogger logger = new ConsoleLogger();
    registry.addObserver(logger);

    Student s1 = new Student("Alice", "Smith", 22);
    registry.addStudent(s1);
    registry.modifyStudent(s1);
    registry.removeStudent(s1);

    // 3. Factory Pattern
    System.out.println("\n--- Factory Pattern ---");
    Person student = PersonFactory.createPerson("student", "Bob", "Jones", 21);
    Person professor = PersonFactory.createPerson("professor", "Dr. Smith", "Brown", 45);
    Person staff = PersonFactory.createPerson("staff", "Jane", "Doe", 35);

    student.displayInfo();
    System.out.println();
    professor.displayInfo();
    System.out.println();
    staff.displayInfo();

    // 4. Strategy Pattern
    System.out.println("\n--- Strategy Pattern ---");
    double score = 85.0;

    GradeCalculator calculator = new GradeCalculator(new GermanGradingStrategy());
    System.out.println(calculator.getGradingSystemName() + ": " + calculator.calculateGrade(score));

    calculator.setStrategy(new ECTSGradingStrategy());
    System.out.println(calculator.getGradingSystemName() + ": " + calculator.calculateGrade(score));

    calculator.setStrategy(new PassFailGradingStrategy());
    System.out.println(calculator.getGradingSystemName() + ": " + calculator.calculateGrade(score));
  }
}
```
]

#pagebreak()

= Task 6: Exception Handling and File I/O
Implement comprehensive error handling and data persistence for your student management system. This task covers exception handling, file operations, and data serialization.

Add robust error handling and file-based data persistence:
- Custom exception classes for domain-specific errors
- File I/O operations for saving and loading student data
- Data validation with appropriate exception handling
- Logging system for tracking system events

Your program should:
1. Create custom exception classes:
  - `StudentNotFoundException` for lookup failures
  - `InvalidMatriculationNumberException` for number conflicts
  - `StudentRegistryFullException` when capacity is exceeded
  - `DataPersistenceException` for file operation errors
2. Implement file-based persistence:
  - Save student data to CSV and JSON formats
  - Load student data from files with error recovery
  - Backup and restore functionality
3. Add comprehensive input validation:
  - Validate name formats, matriculation numbers, dates
  - Handle malformed input gracefully
  - Provide meaningful error messages to users
4. Implement logging system:
  - Log system events, errors, and user actions
  - Different log levels (INFO, WARNING, ERROR)
  - Configurable log output (console, file)

== Requirements
- Create custom exception hierarchy with meaningful inheritance
- Use try-with-resources for proper resource management
- Implement both checked and unchecked exceptions appropriately
- Demonstrate exception propagation and handling at different levels
- Use proper file I/O with error recovery mechanisms

== Assistance

*Custom exception hierarchy:*
```java
public class StudentManagementException extends Exception {
    public StudentManagementException(String message) {
        super(message);
    }

    public StudentManagementException(String message, Throwable cause) {
        super(message, cause);
    }
}

public class StudentNotFoundException extends StudentManagementException {
    public StudentNotFoundException(int matriculationNumber) {
        super("Student with matriculation number " + matriculationNumber + " not found");
    }
}

public class StudentRegistryFullException extends StudentManagementException {
    public StudentRegistryFullException(int maxCapacity) {
        super("Student registry is full. Maximum capacity: " + maxCapacity);
    }
}
```

*File I/O with exception handling:*
```java
public class StudentDataManager {
    public void saveToFile(List<Student> students, String filename)
            throws DataPersistenceException {
        try (PrintWriter writer = new PrintWriter(new FileWriter(filename))) {
            writer.println("MatriculationNumber,FirstName,LastName,Age");
            for (Student student : students) {
                writer.printf("%d,%s,%s,%d%n",
                    student.getMatriculationNumber(),
                    student.getFirstName(),
                    student.getLastName(),
                    student.getAge());
            }
        } catch (IOException e) {
            throw new DataPersistenceException("Failed to save student data", e);
        }
    }

    public List<Student> loadFromFile(String filename)
            throws DataPersistenceException {
        List<Student> students = new ArrayList<>();
        try (BufferedReader reader = new BufferedReader(new FileReader(filename))) {
            String line = reader.readLine(); // Skip header
            while ((line = reader.readLine()) != null) {
                try {
                    Student student = parseStudentLine(line);
                    students.add(student);
                } catch (IllegalArgumentException e) {
                    System.err.println("Skipping invalid line: " + line);
                }
            }
        } catch (IOException e) {
            throw new DataPersistenceException("Failed to load student data", e);
        }
        return students;
    }

    private Student parseStudentLine(String line) {
        String[] parts = line.split(",");
        if (parts.length != 4) {
            throw new IllegalArgumentException("Invalid data format");
        }
        // Parse and validate data, throw exceptions for invalid formats
        return new Student(parts[1], parts[2]);
    }
}
```

*Input validation with exceptions:*
```java
public class InputValidator {
    public static void validateName(String name) throws IllegalArgumentException {
        if (name == null || name.trim().isEmpty()) {
            throw new IllegalArgumentException("Name cannot be empty");
        }
        if (!name.matches("[a-zA-ZäöüÄÖÜß\\s-]+")) {
            throw new IllegalArgumentException("Name contains invalid characters");
        }
    }

    public static void validateMatriculationNumber(int number)
            throws InvalidMatriculationNumberException {
        if (number < 1001 || number > 999999) {
            throw new InvalidMatriculationNumberException(
                "Matriculation number must be between 1001 and 999999");
        }
    }
}
```

#if solution [
== Solution

*StudentManagementException.java (Base Exception):*
```java
public class StudentManagementException extends Exception {
  public StudentManagementException(String message) {
    super(message);
  }

  public StudentManagementException(String message, Throwable cause) {
    super(message, cause);
  }
}
```

*StudentNotFoundException.java:*
```java
public class StudentNotFoundException extends StudentManagementException {
  public StudentNotFoundException(int matriculationNumber) {
    super("Student with matriculation number " + matriculationNumber + " not found");
  }
}
```

*InvalidMatriculationNumberException.java:*
```java
public class InvalidMatriculationNumberException extends StudentManagementException {
  public InvalidMatriculationNumberException(String message) {
    super(message);
  }
}
```

*StudentRegistryFullException.java:*
```java
public class StudentRegistryFullException extends StudentManagementException {
  public StudentRegistryFullException(int maxCapacity) {
    super("Student registry is full. Maximum capacity: " + maxCapacity);
  }
}
```

*DataPersistenceException.java:*
```java
public class DataPersistenceException extends StudentManagementException {
  public DataPersistenceException(String message) {
    super(message);
  }

  public DataPersistenceException(String message, Throwable cause) {
    super(message, cause);
  }
}
```

*InputValidator.java:*
```java
public class InputValidator {
  public static void validateName(String name) throws IllegalArgumentException {
    if (name == null || name.trim().isEmpty()) {
      throw new IllegalArgumentException("Name cannot be empty");
    }
    if (!name.matches("[a-zA-ZäöüÄÖÜß\\s-]+")) {
      throw new IllegalArgumentException("Name contains invalid characters");
    }
  }

  public static void validateMatriculationNumber(int number)
      throws InvalidMatriculationNumberException {
    if (number < 1001 || number > 999999) {
      throw new InvalidMatriculationNumberException(
          "Matriculation number must be between 1001 and 999999");
    }
  }

  public static void validateAge(int age) throws IllegalArgumentException {
    if (age < 16 || age > 100) {
      throw new IllegalArgumentException("Age must be between 16 and 100");
    }
  }
}
```

*StudentDataManager.java (File I/O with Exception Handling):*
```java
import java.io.*;
import java.util.ArrayList;
import java.util.List;

public class StudentDataManager {

  // Save students to CSV file
  public void saveToCSV(List<Student> students, String filename)
      throws DataPersistenceException {
    try (PrintWriter writer = new PrintWriter(new FileWriter(filename))) {
      // Write header
      writer.println("MatriculationNumber,FirstName,LastName,Age");

      // Write student data
      for (Student student : students) {
        writer.printf("%d,%s,%s,%d%n",
            student.getMatriculationNumber(),
            student.getFirstName(),
            student.getLastName(),
            student.getAge());
      }

      System.out.println("Successfully saved " + students.size() + " students to " + filename);

    } catch (IOException e) {
      throw new DataPersistenceException("Failed to save student data to " + filename, e);
    }
  }

  // Load students from CSV file
  public List<Student> loadFromCSV(String filename) throws DataPersistenceException {
    List<Student> students = new ArrayList<>();
    int lineNumber = 0;

    try (BufferedReader reader = new BufferedReader(new FileReader(filename))) {
      String line = reader.readLine(); // Skip header
      lineNumber++;

      while ((line = reader.readLine()) != null) {
        lineNumber++;
        try {
          Student student = parseStudentLine(line);
          students.add(student);
        } catch (IllegalArgumentException e) {
          System.err.println("Warning: Skipping invalid line " + lineNumber + ": " + line);
          System.err.println("  Reason: " + e.getMessage());
        }
      }

      System.out.println("Successfully loaded " + students.size() + " students from " + filename);

    } catch (FileNotFoundException e) {
      throw new DataPersistenceException("File not found: " + filename, e);
    } catch (IOException e) {
      throw new DataPersistenceException("Failed to load student data from " + filename, e);
    }

    return students;
  }

  // Parse a single CSV line into a Student object
  private Student parseStudentLine(String line) throws IllegalArgumentException {
    String[] parts = line.split(",");

    if (parts.length != 4) {
      throw new IllegalArgumentException("Invalid data format: expected 4 fields, got " + parts.length);
    }

    try {
      int matricNo = Integer.parseInt(parts[0].trim());
      String firstName = parts[1].trim();
      String lastName = parts[2].trim();
      int age = Integer.parseInt(parts[3].trim());

      // Validate data
      InputValidator.validateName(firstName);
      InputValidator.validateName(lastName);
      InputValidator.validateAge(age);

      // Create student (note: this will auto-assign a new matriculation number)
      return new Student(firstName, lastName, age);

    } catch (NumberFormatException e) {
      throw new IllegalArgumentException("Invalid number format in data", e);
    } catch (Exception e) {
      throw new IllegalArgumentException("Validation failed: " + e.getMessage(), e);
    }
  }

  // Backup file
  public void backup(String sourceFile, String backupFile) throws DataPersistenceException {
    try (FileInputStream input = new FileInputStream(sourceFile);
         FileOutputStream output = new FileOutputStream(backupFile)) {

      byte[] buffer = new byte[1024];
      int bytesRead;

      while ((bytesRead = input.read(buffer)) != -1) {
        output.write(buffer, 0, bytesRead);
      }

      System.out.println("Backup created: " + backupFile);

    } catch (IOException e) {
      throw new DataPersistenceException("Failed to create backup", e);
    }
  }
}
```

*ExceptionHandlingDemo.java:*
```java
import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

public class ExceptionHandlingDemo {
  public static void main(String[] args) {
    Scanner scanner = new Scanner(System.in);
    List<Student> students = new ArrayList<>();
    StudentDataManager dataManager = new StudentDataManager();
    String filename = "students.csv";

    System.out.println("=== Student Management with Exception Handling ===\n");

    // Try to load existing data
    try {
      students = dataManager.loadFromCSV(filename);
    } catch (DataPersistenceException e) {
      System.out.println("Could not load existing data: " + e.getMessage());
      System.out.println("Starting with empty registry.");
    }

    boolean running = true;

    while (running) {
      System.out.println("\n=== Menu ===");
      System.out.println("1: Add student");
      System.out.println("2: Display all students");
      System.out.println("3: Find student by matriculation number");
      System.out.println("4: Save to file");
      System.out.println("5: Load from file");
      System.out.println("6: Create backup");
      System.out.println("0: Exit");
      System.out.print("Your choice: ");

      try {
        int choice = scanner.nextInt();
        scanner.nextLine();

        switch (choice) {
          case 0:
            running = false;
            System.out.println("Exiting...");
            break;

          case 1:
            // Add student with validation
            try {
              System.out.print("First name: ");
              String firstName = scanner.nextLine();
              InputValidator.validateName(firstName);

              System.out.print("Last name: ");
              String lastName = scanner.nextLine();
              InputValidator.validateName(lastName);

              System.out.print("Age: ");
              int age = scanner.nextInt();
              InputValidator.validateAge(age);

              Student student = new Student(firstName, lastName, age);
              students.add(student);
              System.out.println("Student added successfully!");
              System.out.println(student);

            } catch (IllegalArgumentException e) {
              System.err.println("Validation error: " + e.getMessage());
            }
            break;

          case 2:
            // Display all students
            if (students.isEmpty()) {
              System.out.println("No students in registry.");
            } else {
              System.out.println("\n=== All Students ===");
              for (Student s : students) {
                System.out.println(s);
              }
            }
            break;

          case 3:
            // Find student
            try {
              System.out.print("Enter matriculation number: ");
              int matricNo = scanner.nextInt();
              InputValidator.validateMatriculationNumber(matricNo);

              Student found = null;
              for (Student s : students) {
                if (s.getMatriculationNumber() == matricNo) {
                  found = s;
                  break;
                }
              }

              if (found != null) {
                System.out.println("Found: " + found);
              } else {
                throw new StudentNotFoundException(matricNo);
              }

            } catch (InvalidMatriculationNumberException | StudentNotFoundException e) {
              System.err.println("Error: " + e.getMessage());
            }
            break;

          case 4:
            // Save to file
            try {
              dataManager.saveToCSV(students, filename);
            } catch (DataPersistenceException e) {
              System.err.println("Error saving data: " + e.getMessage());
            }
            break;

          case 5:
            // Load from file
            try {
              students = dataManager.loadFromCSV(filename);
            } catch (DataPersistenceException e) {
              System.err.println("Error loading data: " + e.getMessage());
            }
            break;

          case 6:
            // Create backup
            try {
              dataManager.backup(filename, filename + ".backup");
            } catch (DataPersistenceException e) {
              System.err.println("Error creating backup: " + e.getMessage());
            }
            break;

          default:
            System.out.println("Invalid choice!");
        }

      } catch (Exception e) {
        System.err.println("Unexpected error: " + e.getMessage());
        scanner.nextLine(); // Clear buffer
      }
    }

    // Auto-save on exit
    try {
      dataManager.saveToCSV(students, filename);
      System.out.println("Data saved automatically.");
    } catch (DataPersistenceException e) {
      System.err.println("Warning: Could not save data on exit: " + e.getMessage());
    }

    scanner.close();
  }
}
```
]

= Lab Execution:
If your program is not yet working without issue, we will try to correct this during the course of the lab. With good preparation, this should not be a problem. Every student is required to be able to explain their thought process at the beginning of the lab. By the end of the lab, the task needs to be completed. Of course, we will support you, but your personal commitment must also be clearly recognizable! Julian Moldenhauer, Furkan Yildirim, and Emily Antosch wish you lots of fun and success!
