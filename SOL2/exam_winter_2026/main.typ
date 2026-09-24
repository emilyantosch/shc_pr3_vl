#import "../hestia/exam.typ": answer, choices, completion, exam-theme, task
#show: exam-theme.with()

#task(1, [Basic Concepts])
For each situation, explain the relevant Java concept and give one short Java example.
Each item earns *1 point for the explanation and 1 point for the example*.

*a) Object references (2 points).* Two variables should refer to the same `Lamp` object rather than two separate lamps. Explain what reference assignment copies.
#answer(height: 28mm)[
  Assignment copies the reference, not the object (1). Example: `Lamp a = new Lamp(); Lamp b = a;` (1).
  Changes to that object's state are observable through either reference.
]

*b) Encapsulation (2 points).* A thermostat must reject target temperatures outside its allowed range. Explain why its temperature field should not be public.
#answer(height: 28mm)[
  A private field prevents callers from bypassing validation (1).
  Example: `private int target;` with `public void setTarget(int t) { if (t < 5 || t > 30) throw new IllegalArgumentException(); target = t; }` (1).
]

*c) Constructors (2 points).* A `Room` must receive its name when it is created. Explain the constructor's role and show the constructor declaration.
#answer(height: 28mm)[
  The constructor initializes a new instance (1). Example inside `Room`:
  `private String name; public Room(String name) { this.name = name; }` (1).
  A constructor has the class name and no return type.
]

*d) Static members (2 points).* All `Room` objects share the same maximum permitted occupancy. Explain why a class constant is suitable.
#answer(height: 28mm)[
  A static member belongs to the class rather than each instance (1).
  Example: `public static final int MAX_OCCUPANCY = 20;` (1). `final` prevents reassignment.
]

*e) Immutable strings (2 points).* Explain why calling `name.toUpperCase()` alone does not change the string stored in `name`. Show how to retain the result.
#answer(height: 28mm)[
  Strings are immutable; the method returns a string rather than modifying the original (1).
  `name = name.toUpperCase();` (1).
]

#task(2, [Object-Oriented Reasoning])
*a) Inheritance and `super` (5 points).* Given the superclass below, write a subclass `Bicycle` with a constructor `Bicycle(String id)` that initializes the inherited state. Override `label()` to return `Bike: ` followed by the superclass label. Keep the field private and use `super` in both places.

```java
class Vehicle {
    private String id;
    public Vehicle(String id) { this.id = id; }
    public String label() { return id; }
}
```
#answer(height: 30mm)[
  ```java
  class Bicycle extends Vehicle {
      public Bicycle(String id) { super(id); }
      @Override
      public String label() { return "Bike: " + super.label(); }
  }
  ```
  Subclass declaration (1); constructor and `super(id)` (2); public override with the required result and `super.label()` (2).
]

*b) Overloading and overriding (5 points).* Read this separate program. State its two output lines (2 points). Identify the overloaded methods (1 point), the overridden method (1 point), and explain why the first line uses `Bell.sound()` (1 point).

```java
class Signal {
    public String sound() { return "beep"; }
    public String sound(int count) { return "count=" + count; }
}
class Bell extends Signal {
    @Override
    public String sound() { return "ding"; }
}
// Inside main:
Signal signal = new Bell();
System.out.println(signal.sound());
System.out.println(signal.sound(2));
```
#answer(height: 20mm)[
  Output: `ding`, then `count=2` (1 each).
  `Signal.sound()` and `Signal.sound(int)` are overloaded (1).
  `Bell.sound()` overrides `Signal.sound()` (1).
  Runtime dispatch uses the actual object's type, `Bell`, for the no-argument instance method (1).
]

*c) Interface or abstract class? (5 points).* Unrelated classes must all offer `double energyUse()`. Give a suitable interface declaration (2 points). A family of appliances additionally shares a private name field, a constructor, and a concrete getter. Explain why an abstract superclass can hold this shared implementation (2 points). Can that abstract superclass be instantiated directly (1 point)?
#answer(height: 20mm)[
  `interface EnergyUser { double energyUse(); }` (2).
  An abstract class can contain instance state (1), constructors and implemented methods shared by subclasses (1).
  It cannot be instantiated directly (1).
]

#task(3, [True or False])
Mark exactly one column for each statement. Each correct answer earns *2 points*.
A missing, or double-marked answer earns 0 points. An incorrect answer yields *-2 points*; the minimum number of points for this task remains 0.

#choices((
  ([A local variable of a class type stores a reference to an object, or `null`.], true),
  ([Declaring an array reference `final` prevents changes to its elements.], false),
  ([A subclass inherits its superclass's constructors.], false),
  ([A class can implement two interfaces while extending one class.], true),
  ([A static method can read an instance field if it has a suitable object reference and access is permitted.], true),
  ([`String.equals` compares the text content of two strings.], true),
  ([The first valid index of a nonempty Java array is 1.], false),
  ([A method declared `void` must end with `return null;`.], false),
))
#answer(height: 0mm)[
  1. True: a class-typed variable stores a reference value.
  2. False: `final` prevents reassignment of the reference, not mutation of the array.
  3. False: constructors are not inherited.
  4. True: Java permits multiple implemented interfaces and one direct superclass.
  5. True: static methods can use an accessible field via an object.
  6. True: `equals` compares string contents.
  7. False: indices start at 0.
  8. False: a void method can fall through or use `return;`, not return a value.
]

#task(4, [Code Completion])
Complete gaps *A–F* directly in the listing (*2 points per gap*). `WaterTank` stores an integer water level from *0 through 100 inclusive*. Invalid constructor or setter arguments must throw `IllegalArgumentException` without changing an existing level. The constructor must reuse the setter. `freeCapacity()` returns `100 - level`. The string format is exactly `WaterTank[level=25]` when the level is 25.

#completion[
  ```java
  public class WaterTank {
      // A: declare the private int field


      public WaterTank(int level) {
          // B: initialize through the setter

      }
      public int getLevel() {
          // C

      }
      public void setLevel(int level) {
          // D: validate first, then update the field




      }
      public int freeCapacity() {
          // E

      }
      @Override
      public String toString() {
          // F

      }
  }
  ```
]
#answer(height: 0mm, new-page: true)[
  ```java
  public class WaterTank {
      private int level;
      public WaterTank(int level) { setLevel(level); }
      public int getLevel() { return level; }
      public void setLevel(int level) {
          if (level < 0 || level > 100) {
              throw new IllegalArgumentException();
          }
          this.level = level;
      }
      public int freeCapacity() { return 100 - level; }
      @Override
      public String toString() {
          return "WaterTank[level=" + level + "]";
      }
  }
  ```
  A: correct type/name (1), private (1). B: calls `setLevel` (1) with its parameter (1).
  C: returns the field (2). D: rejects both invalid ranges before assignment (1), assigns valid input (1).
  E: correct result (2). F: exact string using the field (2).
]

#task(5, [Code Debugging])
Find *six independent defects*. For each, identify the location, explain the problem, and give a correction (*1 point for the explanation, 1 for the correction*).
The specification requires all instance fields to be private; the constructor to retain its arguments;
`hasName` to compare text content; and `sum` to add every array element exactly once.
Assume names and arrays are non-null. An empty array must sum to 0.
Missing getters, formatting choices, and Java's default field initialization are *not* defects.

```java
public class ScoreCard {
    public String name;
    private int bonus;

    public ScoreCard(String name, int bonus) {
        this.name = name
        bonus = bonus;
    }
    public static int getBonus() {
        return bonus;
    }
    public boolean hasName(String other) {
        return name == other;
    }
    public int sum(int[] scores) {
        int total = 0;
        for (int i = 0; i <= scores.length; i++) {
            total += scores[i];
        }
        return total;
    }
}
```
#answer(height: 68mm, new-page: true)[
  1. `name` is public, contrary to the specification; declare it private.
  2. `this.name = name` lacks a semicolon; add `;`.
  3. `bonus = bonus` assigns the parameter to itself; use `this.bonus = bonus;`.
  4. `getBonus` is static but accesses an instance field without an object; remove `static`.
  5. `==` tests reference equality; use `name.equals(other)`.
  6. `i <= scores.length` accesses index `scores.length`; use `i < scores.length`.

  Corrected reference implementation:
  ```java
  public class ScoreCard {
      private String name;
      private int bonus;
      public ScoreCard(String name, int bonus) {
          this.name = name;
          this.bonus = bonus;
      }
      public int getBonus() { return bonus; }
      public boolean hasName(String other) {
          return name.equals(other);
      }
      public int sum(int[] scores) {
          int total = 0;
          for (int i = 0; i < scores.length; i++) {
              total += scores[i];
          }
          return total;
      }
  }
  ```
]

#task(6, [Room Sensor Log])
Build a small console application that stores room measurements and calculates a summary.
Use three files: `Reading.java`, `SensorLog.java`, and `Demo.java`.
You do *not* need to implement keyboard input, editing, searching, or deletion.

== Data and behavior
- A `Reading` has a room name (`String`) and an integer temperature in °C (`int`). Once created, it has no methods that change these values.
- The `Reading` constructor receives valid values; validation is the responsibility of `SensorLog.addReading`.
- A valid room name is non-null and not empty after `trim()`. Store the trimmed name. Temperatures must be between *−20 and 50 inclusive*.
- Repeated room names are allowed: they represent separate measurements.
- `addReading(String room, int temperature)` returns `true` after adding a valid reading. Otherwise it returns `false` and leaves the list unchanged.
- `countAbove(int limit)` returns the number of readings *strictly greater than* the limit.
- `averageTemperature()` returns a `double` average over all stored readings. It returns `0.0` when there are none. Avoid integer division.
- `displayAll()` prints each reading in insertion order, or `No readings` when empty.

== Implementation and points
#table(
  columns: (auto, 1fr, auto),
  inset: 6pt,
  table.header([*Part*], [*Deliverable*], [*Points*]),
  [a], [Create the named project folder and the three Java files with matching public classes.], [3],
  [b],
  [`Reading`: two private fields, constructor, both getters, and a readable `toString()` containing both values.],
  [5],

  [c], [`SensorLog`: private `ArrayList<Reading>` initialized as an empty list.], [4],
  [d], [Implement `boolean addReading(String room, int temperature)` with the specified validation.], [6],
  [e], [Implement `int countAbove(int limit)`; an empty log returns 0.], [5],
  [f], [Implement `double averageTemperature()` including its empty-log behavior.], [6],
  [g], [Implement `void displayAll()` including the empty message.], [3],
  [h], [`Demo.main`: demonstrate the acceptance checks on the next page with labelled output or assertions.], [5],
  [i],
  [Use clear names, consistent indentation, and encapsulation; keep log operations in `SensorLog`, not `Demo`.],
  [3],
)

#pagebreak()
== Task 6: Acceptance checks and API reminder
Use a fresh log for this sequence:
1. Display it while empty; check that its average is `0.0` and `countAbove(20)` is 0.
2. Add `(" Kitchen ", 20)` and `("Kitchen", 21)`; both calls must return `true`. The displayed room names must have no surrounding spaces.
3. Check that the average is `20.5`, `countAbove(20)` is 1, and `countAbove(21)` is 0.
4. Try a null room name, a spaces-only room name, and a temperature of 51; all must return `false`. The average and counts must remain unchanged.
5. Display the two valid readings in their insertion order.

`ArrayList` needs `import java.util.ArrayList;`. These operations may help:
```java
ArrayList<Reading> readings = new ArrayList<>();
readings.add(new Reading("Hall", 18));
int size = readings.size();
boolean empty = readings.isEmpty();
for (Reading reading : readings) {
    System.out.println(reading);
}
// For non-null text:
boolean blank = text.trim().isEmpty();
```
Submit all three `.java` files. A compiling partial solution can earn credit for the parts it implements correctly.

#answer(height: 50mm, new-page: true)[
  *Reading.java*
  ```java
  public class Reading {
      private final String room;
      private final int temperature;
      public Reading(String room, int temperature) {
          this.room = room;
          this.temperature = temperature;
      }
      public String getRoom() { return room; }
      public int getTemperature() { return temperature; }
      @Override
      public String toString() { return room + ": " + temperature + " C"; }
  }
  ```
  *SensorLog.java*
  ```java
  import java.util.ArrayList;
  public class SensorLog {
      private final ArrayList<Reading> readings = new ArrayList<>();
      public boolean addReading(String room, int temperature) {
          if (room == null || room.trim().isEmpty()
                  || temperature < -20 || temperature > 50) {
              return false;
          }
          readings.add(new Reading(room.trim(), temperature));
          return true;
      }
      public int countAbove(int limit) {
          int count = 0;
          for (Reading r : readings) {
              if (r.getTemperature() > limit) count++;
          }
          return count;
      }
      public double averageTemperature() {
          if (readings.isEmpty()) return 0.0;
          double sum = 0;
          for (Reading r : readings) sum += r.getTemperature();
          return sum / readings.size();
      }
      public void displayAll() {
          if (readings.isEmpty()) System.out.println("No readings");
          for (Reading r : readings) System.out.println(r);
      }
  }
  ```
  #block(sticky: true)[*Demo.java* (run with `java -ea Demo` to enable assertions).]
  ```java
  public class Demo {
      public static void main(String[] args) {
          SensorLog log = new SensorLog();
          log.displayAll();
          assert log.averageTemperature() == 0.0;
          assert log.countAbove(20) == 0;
          assert log.addReading(" Kitchen ", 20);
          assert log.addReading("Kitchen", 21);
          assert log.averageTemperature() == 20.5;
          assert log.countAbove(20) == 1;
          assert log.countAbove(21) == 0;
          assert !log.addReading(null, 20);
          assert !log.addReading("   ", 20);
          assert !log.addReading("Hall", 51);
          assert log.averageTemperature() == 20.5;
          assert log.countAbove(20) == 1;
          assert log.countAbove(21) == 0;
          log.displayAll();
      }
  }
  ```
  *Marking (40 points):* a: folder (1), classes/files (2). b: private fields (1), constructor (1), getters (2), string (1).
  c: private typed list (2), empty initialization (2). d: name validation including null (2), bounds (1), trim (1), add/true (1), unchanged/false (1).
  e: traversal (2), strict comparison (2), count/empty return (1). f: empty guard (2), sum (2), floating-point division (2).
  g: all readings in order (2), empty message (1). h: one point for each of the five acceptance checks.
  i: naming (1), formatting (1), responsibility separation/encapsulation (1). Do not deduct twice for one underlying error.
]
