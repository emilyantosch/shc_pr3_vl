#import "../hestia/exam.typ": exam-theme, task, answer, choices, completion
#show: exam-theme.with(mock: true)

#task(1, [Basic Concepts])
Each item earns *1 point for the result or decision and 1 point for the explanation*.
The short snippets are independent and occur inside otherwise valid programs.

*a) Pass-by-value (2 points).* `Box` has a public integer field `value`. What does `b.value` contain after the call, and why?
```java
static void change(Box box) {
    box.value = 7;
    box = new Box();
    box.value = 9;
}
// Inside main:
Box b = new Box(); b.value = 2;
change(b);
```
#answer(height: 18mm)[
`7` (1). The parameter receives a copy of the reference: the first assignment changes the shared object, but rebinding the parameter does not rebind `b` (1).
]

*b) Class state (2 points).* `Counter` declares `static int created = 0;` and its constructor runs `created++;`. In a fresh run, two instances are constructed and one reference is set to `null`. What is `Counter.created` now, and why?
#answer(height: 18mm)[
`2` (1). Both constructors update one shared class field; dropping a reference does not decrement it (1).
]

*c) `final` references (2 points).* Given `final int[] values = {3, 4};`, which is allowed: `values[0] = 8;` or `values = new int[2];`? Explain the distinction.
#answer(height: 18mm)[
Only changing the element is allowed (1). `final` prevents reassignment of the variable, not mutation of the referenced array (1).
]

*d) Strings (2 points).* What text is printed, and why?
```java
String code = "ab";
String alias = code;
code = code.toUpperCase();
System.out.println(alias + "/" + code);
```
#answer(height: 18mm)[
`ab/AB` (1). Strings are immutable; only `code` is assigned the uppercase result, while `alias` retains the original reference (1).
]

*e) Encapsulation (2 points).* A class stores a private `int[]` and its getter returns that array directly. Does `private` alone prevent callers from changing its elements? Explain one way to prevent this exposure.
#answer(height: 18mm)[
No (1). Return a copy such as `return values.clone();` so callers do not receive the internal array (1).
An explanation of copying into a new array is also sufficient.
]

#task(2, [Object-Oriented Reasoning])
*a) Abstract superclass and `super` (5 points).* Implement a concrete subclass `ExpressTicket` with a constructor `ExpressTicket(int base)` and a `price()` that returns the base price plus 3. Reuse the superclass constructor and getter; do not duplicate the field.
```java
abstract class Ticket {
    private int base;
    public Ticket(int base) { this.base = base; }
    public int getBase() { return base; }
    public abstract int price();
}
```
#answer(height: 30mm)[
```java
class ExpressTicket extends Ticket {
    public ExpressTicket(int base) { super(base); }
    @Override
    public int price() { return getBase() + 3; }
}
```
Concrete subclass declaration (1); constructor and superclass initialization (2); correct public implementation and result (2).
]

*b) Overload selection and runtime dispatch (5 points).* State the two output lines (2 points). Explain which overload is selected at compile time for each call (2 points) and why the first call still runs code in `Loud` (1 point).
```java
class Announcer {
    public String say(Object x) { return "A-object"; }
    public String say(String x) { return "A-string"; }
}
class Loud extends Announcer {
    @Override
    public String say(Object x) { return "L-object"; }
}
// Inside main:
Announcer a = new Loud();
Object message = "hello";
System.out.println(a.say(message));
System.out.println(a.say("hello"));
```
#answer(height: 20mm)[
Output: `L-object`, then `A-string` (1 each).
The argument's declared type selects `say(Object)` for `message` (1).
The string literal selects the more specific `say(String)` (1).
The selected `say(Object)` instance method is overridden in the runtime type `Loud` (1).
]

*c) Interface reference (5 points).* An interface `Resettable` declares only `void reset()`.
The concrete class `Meter implements Resettable` has public methods `void reset()` and `int level()`.
Given `Resettable r = new Meter();`, does `r.reset()` compile? Does `r.level()` compile?
Explain each decision (2 points each). Give a reference declaration that lets you call both methods on a new `Meter` *without a cast* (1 point).
#answer(height: 20mm)[
`r.reset()` compiles because the declared interface includes it (2).
`r.level()` does not: `Resettable` does not declare `level`, even though the object is a `Meter` (2).
`Meter m = new Meter();` makes both methods available (1).
]

#task(3, [True or False])
Mark exactly one column for each statement. Each correct answer earns *2 points*.
An incorrect, missing, or double-marked answer earns 0 points; there are no deductions.

#choices((
  ([A concrete subclass may satisfy an interface's abstract method by inheriting a matching public implementation from its superclass.], true),
  ([If a variable has an interface type, it can call every public method of the object's concrete class without a cast.], false),
  ([A class can be abstract even if it declares no abstract methods.], true),
  ([Declaring a field `private` makes the referenced object immutable.], false),
  ([Outside the declaring package, every class may access a `protected` instance field through any superclass reference.], false),
  ([Two overloads may differ in parameter types while having the same return type.], true),
  ([An overriding instance method may reduce visibility from `public` to `protected`.], false),
  ([If both operands of `/` are integers, assigning the result to a `double` does not restore a discarded fractional part.], true),
))
#answer(height: 0mm)[
1. True: an inherited public implementation can satisfy the contract.
2. False: the declared reference type limits compile-time member access.
3. True: the `abstract` modifier alone prevents direct instantiation.
4. False: `private` controls field access, not the mutability of its value.
5. False: cross-package protected access is restricted to subclass contexts, with receiver restrictions for instance members.
6. True: different parameter types distinguish the overloads.
7. False: an override cannot reduce access.
8. True: integer division occurs before widening to `double`.
]

#task(4, [Code Completion])
Complete gaps *A–F* directly in the listing (*2 points per gap*).
`ScoreRange` represents an inclusive integer interval. Both constructor arguments are guaranteed to lie between −1000 and 1000, but may arrive in the wrong order.
Reject `low > high` with `IllegalArgumentException`; equal endpoints are valid.
`contains` includes both endpoints. `clamp` returns the nearest endpoint for an out-of-range value, or the value itself when it is inside.
The exact string format is `ScoreRange[2..5]` for endpoints 2 and 5.

#completion[
```java
public class ScoreRange {
    // A: declare two private final int fields
    ________________________________________________
    ________________________________________________
    public ScoreRange(int low, int high) {
        // B: reject reversed endpoints
        ____________________________________________
        ____________________________________________
        // C: initialize both fields
        ____________________________________________
        ____________________________________________
    }
    public boolean contains(int value) {
        // D
        ____________________________________________
    }
    public int clamp(int value) {
        // E
        ____________________________________________
        ____________________________________________
        ____________________________________________
    }
    @Override
    public String toString() {
        // F
        ____________________________________________
    }
}
```
]
#answer(height: 0mm, new-page: true)[
```java
public class ScoreRange {
    private final int low;
    private final int high;
    public ScoreRange(int low, int high) {
        if (low > high) throw new IllegalArgumentException();
        this.low = low;
        this.high = high;
    }
    public boolean contains(int value) {
        return value >= low && value <= high;
    }
    public int clamp(int value) {
        if (value < low) return low;
        if (value > high) return high;
        return value;
    }
    @Override
    public String toString() {
        return "ScoreRange[" + low + ".." + high + "]";
    }
}
```
A: one point per private final field. B: correct condition (1), exception (1).
C: one point per field assignment. D: inclusive comparisons (1), conjunction (1).
E: correct behavior below/above the range (1), unchanged in-range value (1).
F: both field values (1), exact punctuation/order (1).
]

#task(5, [Code Debugging])
Find *six independent defects*. For each, identify the location, explain the problem, and give a correction (*1 point for the explanation, 1 for the correction*).
All fields must be private. The constructor must retain the code and initial number of seats.
`matches` must compare code text, and `reserve` must return `false` for zero remaining seats without changing state; otherwise it must remove exactly one seat and return `true`.
Assume non-null codes and a nonnegative initial seat count. No additional validation or getters are required.

```java
public class Booking {
    public String code;
    private int remaining;
    public Booking(String code, int remaining) {
        code = code;
        this.remaining = remaining;
    }
    public static int getRemaining() {
        return remaining;
    }
    public boolean matches(String other) {
        return code == other;
    }
    public boolean reserve() {
        if (remaining < 0) {
            return false;
        }
        remaining++;
        return true;
    }
}
```
#answer(height: 72mm, new-page: true)[
1. `code` is public, contrary to the specification; declare it private.
2. `code = code` assigns the parameter to itself; use `this.code = code;`.
3. A static `getRemaining` cannot access this instance's field directly; remove `static`.
4. `==` tests references rather than text; use `code.equals(other)`.
5. The guard misses zero seats; use `remaining <= 0` (or `== 0` under the stated invariant).
6. Incrementing adds a seat; use `remaining--;`.

Corrected reference implementation:
```java
public class Booking {
    private String code;
    private int remaining;
    public Booking(String code, int remaining) {
        this.code = code;
        this.remaining = remaining;
    }
    public int getRemaining() { return remaining; }
    public boolean matches(String other) { return code.equals(other); }
    public boolean reserve() {
        if (remaining <= 0) return false;
        remaining--;
        return true;
    }
}
```
]

#task(6, [Priority Parcel Queue])
Build a console application that stores parcels awaiting dispatch. Use three files:
`Parcel.java`, `ParcelQueue.java`, and `Demo.java`. Use an `ArrayList`, not a priority-queue library.
No keyboard input, sorting, persistence, or delivery-history collection is required.

== Data and behavior
- A `Parcel` stores an ID (`String`) and priority (`int`, *1 through 3 inclusive*). Higher numbers mean higher priority. It has no methods that change those values after construction.
- The `Parcel` constructor receives valid values. `ParcelQueue.addParcel` performs validation.
- A valid ID is non-null and not empty after `trim()`. Store the trimmed ID. IDs in the current queue must be unique *ignoring case*. After dispatch, an ID may be used again.
- `addParcel(String id, int priority)` returns `false` for invalid input or a duplicate ID, leaving the queue unchanged. Otherwise it appends a parcel and returns `true`.
- `findParcel(String id)` trims the search ID and matches ignoring case. It returns the stored parcel or `null` if no match exists or the ID is null/blank. It must not remove anything.
- `dispatchNext()` removes and returns the highest-priority parcel, or returns `null` when empty. For equal priorities, dispatch the one added *earliest*.
- `displayAll()` prints the parcels in insertion order, or `No parcels` when empty.

== Implementation and points
#table(columns: (auto, 1fr, auto), inset: 6pt,
  table.header([*Part*], [*Deliverable*], [*Points*]),
  [a], [Create the named project folder and three Java files with matching public classes.], [3],
  [b], [`Parcel`: two private fields, constructor, both getters, and a readable `toString()` containing both values.], [5],
  [c], [`ParcelQueue`: private `ArrayList<Parcel>` initialized as an empty list.], [4],
  [d], [Implement `boolean addParcel(String id, int priority)` including validation and duplicate rejection.], [6],
  [e], [Implement `Parcel findParcel(String id)` with normalization, case-insensitive matching, and no-match behavior.], [5],
  [f], [Implement `Parcel dispatchNext()` including ties and empty-queue behavior.], [6],
  [g], [Implement `void displayAll()` including the empty message.], [3],
  [h], [`Demo.main`: demonstrate the acceptance checks on the next page using labelled output or assertions.], [5],
  [i], [Use clear names, consistent indentation, and encapsulation; keep queue operations in `ParcelQueue`, not `Demo`.], [3],
)

#pagebreak()
== Task 6: Acceptance checks and API reminder
Use a fresh queue for this sequence:
1. Display the empty queue. Searching and dispatching must return `null`.
2. Add `(" P1 ", 2)`, `("P2", 3)`, and `("P3", 3)` successfully, then display them in insertion order. The first stored ID must be `P1` without surrounding spaces.
3. Reject `("p1", 1)`, a null ID, a spaces-only ID, and priority 4. Finding `" p2 "` must return the stored `P2` parcel without removing it; an unknown ID must return `null`.
4. Dispatch all parcels: the IDs must be `P2`, then `P3`, then `P1`. The next dispatch must return `null`. Invalid additions must not have changed the dispatch order or parcel count.
5. Add `("p1", 1)` again successfully and check that it can now be found and dispatched.

`ArrayList` needs `import java.util.ArrayList;`. These operations may help:
```java
ArrayList<Parcel> parcels = new ArrayList<>();
parcels.add(new Parcel("X", 1));
Parcel first = parcels.get(0);
Parcel removed = parcels.remove(0); // removes by index and returns it
int size = parcels.size();
boolean empty = parcels.isEmpty();
// For non-null strings:
boolean same = "P1".equalsIgnoreCase("p1");
String trimmed = " P1 ".trim();
```
When choosing a parcel, remember the index of the best candidate. Do not modify the list while searching for that candidate.
Submit all three `.java` files. A compiling partial solution can earn credit for the parts it implements correctly.

#answer(height: 42mm, new-page: true)[
*Parcel.java*
```java
public class Parcel {
    private final String id;
    private final int priority;
    public Parcel(String id, int priority) {
        this.id = id;
        this.priority = priority;
    }
    public String getId() { return id; }
    public int getPriority() { return priority; }
    @Override
    public String toString() { return id + ": priority " + priority; }
}
```
*ParcelQueue.java*
```java
import java.util.ArrayList;
public class ParcelQueue {
    private final ArrayList<Parcel> parcels = new ArrayList<>();
    public boolean addParcel(String id, int priority) {
        if (id == null || id.trim().isEmpty()
                || priority < 1 || priority > 3
                || findParcel(id) != null) {
            return false;
        }
        parcels.add(new Parcel(id.trim(), priority));
        return true;
    }
    public Parcel findParcel(String id) {
        if (id == null || id.trim().isEmpty()) return null;
        for (Parcel p : parcels) {
            if (p.getId().equalsIgnoreCase(id.trim())) return p;
        }
        return null;
    }
    public Parcel dispatchNext() {
        if (parcels.isEmpty()) return null;
        int best = 0;
        for (int i = 1; i < parcels.size(); i++) {
            if (parcels.get(i).getPriority()
                    > parcels.get(best).getPriority()) {
                best = i;
            }
        }
        return parcels.remove(best);
    }
    public void displayAll() {
        if (parcels.isEmpty()) System.out.println("No parcels");
        for (Parcel p : parcels) System.out.println(p);
    }
}
```
#block(sticky: true)[*Demo.java* (run with `java -ea Demo` to enable assertions).]
```java
public class Demo {
    public static void main(String[] args) {
        ParcelQueue queue = new ParcelQueue();
        queue.displayAll();
        assert queue.findParcel("none") == null;
        assert queue.dispatchNext() == null;
        assert queue.addParcel(" P1 ", 2);
        assert queue.addParcel("P2", 3);
        assert queue.addParcel("P3", 3);
        assert queue.findParcel("P1").getId().equals("P1");
        queue.displayAll();
        assert !queue.addParcel("p1", 1);
        assert !queue.addParcel(null, 2);
        assert !queue.addParcel("   ", 2);
        assert !queue.addParcel("P4", 4);
        assert queue.findParcel(" p2 ").getId().equals("P2");
        assert queue.findParcel("missing") == null;
        assert queue.dispatchNext().getId().equals("P2");
        assert queue.dispatchNext().getId().equals("P3");
        assert queue.dispatchNext().getId().equals("P1");
        assert queue.dispatchNext() == null;
        assert queue.addParcel("p1", 1);
        assert queue.findParcel("P1") != null;
        assert queue.dispatchNext().getId().equals("p1");
    }
}
```
*Marking (40 points):* a: folder (1), classes/files (2). b: private fields (1), constructor (1), getters (2), string (1).
c: private typed list (2), empty initialization (2). d: null/blank validation (1), bounds (1), trim (1), duplicate rejection (1), add/true (1), unchanged/false (1).
e: null/blank guard (1), trimmed case-insensitive comparison (2), stored object/no-match returns (2).
f: empty guard (1), maximum selection (2), stable ties (1), removal and returned parcel (2).
g: all parcels in order (2), empty message (1). h: one point for each of the five acceptance checks.
i: naming (1), formatting (1), responsibility separation/encapsulation (1). Accept equivalent loop solutions; no sorting is required. Do not deduct twice for one underlying error.
]
