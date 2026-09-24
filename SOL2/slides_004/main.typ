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
    short-title: [Java · Lecture 4],
    subtitle: [Lecture 4 - Class Libraries],
    author: [Emily Lucia Antosch],
    date: datetime.today().display("[day].[month].[year]"),
    institution: [HAW Hamburg],
  ),
)

// Codly uses grid rows; vertical inset controls code line spacing.
#show raw.where(block: true): it => {
  codly(inset: (x: .32em, y: .22em))
  it
}

#title-slide(authors: [Emily Lucia Antosch])
#outline-slide()

= Introduction
== Where Are We Now?
#slide[
  #diagram("roadmap", height: 190pt)
]

== The Goal of This Chapter
#slide[
  - Create, compare, and format strings.
  - Organize data in arrays, matrices, and lists.
  - Convert text to numbers and use mathematical functions.
]

= Strings
== Strings: C and Java
#slide[
  #diagram("strings-c-java", height: 280pt)
]

== Creating Strings
#slide[
  Prefer a literal. Use `new` when you need a distinct String object.
  ```java
  String name = "Lena";
  String copy = new String("Lena");
  ```
  Reassignment changes the reference, not the original String.
  ```java
  name = "Birgit";
  ```
]

== Strings Are Immutable
#slide[
  #diagram("immutable", height: 210pt)
]

#slide[
  #question[What will this print?]
  #text(17pt)[
    ```java
    String lena1 = new String("Lena");
    String lena2 = lena1;
    System.out.println(lena1 + " / " + lena2);
    System.out.println(lena1 == lena2);

    lena2 += " B.";
    System.out.println(lena1 + " / " + lena2);
    System.out.println(lena1 == lena2);
    ```
  ]
]

#slide[
  ```java
  String lena1 = new String("Lena");
  String lena2 = lena1;
  ```
  #diagram("strings-shared", height: 180pt)
  `lena1 == lena2` → `true`
]

#slide[
  ```java
  lena2 += " B.";
  ```
  #diagram("strings-changed", height: 190pt)
  `lena1 == lena2` → `false`
]

== String Concatenation
#slide[
  Use `+` to concatenate text; `+=` reassigns the result.
  ```java
  String name = "Lena " + "or " + "then ";
  name = name + "after all " + "again ";
  name += "Birgit?";
  ```
]

#slide[
  #question[What will this print?]
  ```java
  int a = 20;
  int b = 22;
  System.out.println("Year: " + a + b);
  System.out.println(a + b + " (Year)");
  ```
]

#slide[
  #diagram("concatenation", height: 220pt)
]

== The `toString()` Method
#slide[
  #diagram("to-string", height: 190pt)
]

#slide[
  #task[Create a Person class with `toString()`. Test its implicit call in console output.]
]

#slide[
  #text(18pt)[
    ```java
    public class Person {
        String firstName, surname;

        public Person(String firstName, String surname) {
            this.firstName = firstName;
            this.surname = surname;
        }

        public String toString() {
            return firstName + " " + surname;
        }
    }
    ```
  ]
]

#slide[
  ```java
  Person lena = new Person("Lena", "Jensen");
  String name = "Name: " + lena;
  System.out.println(lena);
  System.out.println(name);
  ```
]

== String Methods
#slide[
  #diagram("string-methods", height: 280pt)
  `charAt(0)` returns the first character. Indices start at zero.
]

#slide[
  #task[Replace “Humbug” with “Hamburg”.]
  ```java
  String hamburg = "Welcome to Humbug!";
  hamburg = hamburg.replace("Humbug", "Hamburg");
  System.out.println(hamburg);
  ```
]

#slide[
  #question[What will this print?]
  #text(18pt)[
    ```java
    String upper = "Welcome to Hamburg!";
    String lower = "welcome to hamburg!";

    System.out.println(lower.equals(upper));
    System.out.println(lower.equals(upper.toLowerCase()));
    System.out.println(lower.equalsIgnoreCase(upper));
    ```
  ]
  `equals` compares contents; `==` compares references.
]

== String Formatting
#slide[
  #diagram("formatting", height: 230pt)
  Java format strings use syntax similar to C’s `printf`.
]

#slide[
  #question[What will this print?]
  #text(18pt)[
    ```java
    import java.util.Locale;
    // Inside main():
    double wind = 21.4532;
    String weather = String.format(Locale.US,
        "%s %d: %.1f km/h", "Station", 7, wind);
    System.out.println(weather);
    ```
  ]
  #pause
  *Output:* `Station 7: 21.5 km/h`
]

#slide[
  #diagram("format-parts", height: 200pt)
]

#slide[
  #set text(size: 19pt)
  #grid(columns: (1fr, 1fr), gutter: 24pt,
    table(
      columns: (auto, 1fr), inset: 9pt,
      fill: (_, y) => if calc.odd(y) { palette.surface },
      table.header([*Conversion*], [*Meaning*]),
      [`f`, `e`, `g`], [Floating point],
      [`d`], [Decimal integer],
      [`o`], [Octal integer],
      [`x`, `X`], [Hexadecimal integer],
      [`s`], [String],
      [`t`, `T` + suffix], [Date / time],
      [`b`], [Boolean],
    ),
    table(
      columns: (auto, 1fr), inset: 9pt,
      fill: (_, y) => if calc.odd(y) { palette.surface },
      table.header([*Flag*], [*Meaning*]),
      [`-`], [Left-align],
      [`+`], [Always show sign],
      [`0`], [Pad with zeros],
      [`,`], [Group thousands],
      [`(`], [Parentheses for negatives],
    ),
  )
]

#slide[
  #question[How do width and precision affect the output?]
  #text(18pt)[
    ```java
    double wind = 21.4532;
    System.out.println(String.format(Locale.US, "%2.2f km/h", wind));
    System.out.println(String.format(Locale.US, "%8.2f km/h", wind));
    System.out.println(String.format(Locale.US, "%08.2f km/h", wind));
    ```
  ]
]

#slide[
  #diagram("format-width", height: 270pt)
]

== Formatting and Locale
#slide[
  #diagram("locales", height: 220pt)
]

#slide[
  #text(18pt)[
    ```java
    double wind = 21.4532;
    System.out.println(String.format(Locale.US, "%.2f km/h", wind));
    System.out.println(String.format(Locale.GERMAN, "%.2f km/h", wind));
    ```
  ]
  *Output:*
  ```text
  21.45 km/h
  21,45 km/h
  ```
]

= Arrays
== Arrays: C and Java
#slide[
  #diagram("arrays-c-java", height: 280pt)
]

== Creating Arrays
#slide[
  #diagram("array-creation", height: 190pt)
  Use brackets after the type: `int[] filter`, not `int filter[]`.
]

== Creation with `new`
#slide[
  ```java
  int[] filter = new int[3];
  ```
  #diagram("array-empty", height: 150pt)
  Default elements: `0`, `0.0`, `false`, `'\u0000'`, or `null`, depending on type.
]

== Assigning Elements
#slide[
  ```java
  int[] filter = new int[3];
  filter[0] = 1;
  filter[1] = 2;
  filter[2] = 1;
  ```
  #diagram("array-filled", height: 130pt)
]

== Array Initializers
#slide[
  These alternatives create the same contents:
  ```java
  int[] filter = {1, 2, 1};
  ```
  ```java
  int[] filter = new int[] {1, 2, 1};
  ```
  #diagram("array-filled", height: 140pt)
]

== Array Length and Indices
#slide[
  #question[Which values does the loop store?]
  ```java
  int[] filter = new int[3];
  for (int i = 0; i < filter.length; i++) {
      filter[i] = i * i;
  }
  ```
  #diagram("array-question", height: 110pt)
]

#slide[
  #diagram("array-bounds", height: 260pt)
  `filter[-1]` and `filter[3]` are outside this array.
]

== Arrays of Objects
#slide[
  #text(18pt)[
    ```java
    Person[] friends = new Person[3];
    friends[0] = new Person("Lena", "Jensen");
    friends[1] = new Person("Birgit", "Meyer");
    friends[2] = new Person("Jan", "Schmidt");
    ```
  ]
  #diagram("friends", height: 200pt)
]

== Array References
#slide[
  #question[What will this print?]
  ```java
  int[] a = {1, 2, 3, 4, 5};
  int[] b = a;
  b[3] = 0;
  System.out.println(b[2]);
  System.out.println(a[3]);
  ```
]

#slide[
  #diagram("array-alias", height: 230pt)
  *Output:* `3`, then `0`.
]

#slide[
  #question[What will this print?]
  ```java
  int[] a = {1, 2, 3, 4, 5};
  int[] b = {1, 2, 3, 4, 5};
  System.out.println(a == b);
  ```
]

#slide[
  #diagram("arrays-separate", height: 260pt)
]

== Returning Arrays
#slide[
  #question[What will this print?]
  #text(17pt)[
    ```java
    static int[] createSortedArray(int a, int b) {
        if (a < b) {
            return new int[] {a, b};
        } else {
            return new int[] {b, a};
        }
    }

    public static void main(String[] args) {
        System.out.println(createSortedArray(7, 4)[1]);
    }
    ```
  ]
]

== Sorting an Array
#slide[
  #task[
    Write a method that sorts an `int[]` in ascending order.
    Test it with `{10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 7}`.
  ]
]

#slide[
  #text(17pt)[
    ```java
    public static void sort(int[] a) {
        int i = 0;
        while (i < a.length - 1) {
            if (a[i] > a[i + 1]) {
                int temp = a[i];
                a[i] = a[i + 1];
                a[i + 1] = temp;
                if (i > 0) i--;
            } else {
                i++;
            }
        }
    }
    ```
  ]
]

= Multidimensional Arrays
== Arrays of Arrays
#slide[
  ```java
  int[][] filter = {
      {1, 2, 3}, {4, 5, 6}, {7, 8, 9}
  };
  ```
]

#slide[
  #diagram("matrix", height: 290pt)
]

#slide[
  ```java
  int[][] filter = new int[3][4];
  ```
  #diagram("matrix-zero", height: 240pt)
]

#slide[
  #question[What will this print?]
  ```java
  int[][] a = {{1, 2}, {3, 4}, {5, 6}};
  System.out.println(a.length);
  System.out.println(a[2].length);
  System.out.println(a[1][1]);
  System.out.println(a[2][0]);
  ```
]

#slide[
  #diagram("matrix-values", height: 270pt)
  *Output:* `3`, `2`, `4`, `5`.
]

== Row References and Copied Values
#slide[
  #question[What will this print?]
  ```java
  int[][] a = {{1, 2}, {3, 4}, {5, 6}};
  int[] b = a[0];
  int c = b[1];

  b[1] = 7;
  System.out.println(a[0][1]);
  System.out.println(c);
  ```
]

#slide[
  #diagram("matrix-alias", height: 290pt)
]

== Jagged Arrays
#slide[
  #task[Use a `for` loop to create three rows with lengths 1, 2, and 3.]
  ```java
  int[][] a = new int[3][];
  ```
]

#slide[
  ```java
  int[][] a = new int[3][];
  for (int i = 0; i < a.length; i++) {
      a[i] = new int[i + 1];
  }
  ```
]

#slide[
  #diagram("triangle", height: 280pt)
]

= Lists
== Array vs. ArrayList
#slide[
  #diagram("list-growth", height: 260pt)
]

== Creating an ArrayList
#slide[
  The type in angle brackets specifies the element type.
  #text(18pt)[
    ```java
    import java.util.ArrayList;

    public class ArrayListDemo {
        public static void main(String[] args) {
            ArrayList<String> names = new ArrayList<>();
            names.add("Lena");
            names.add("Birgit");
            names.add("Jan");
            names.add(new String("Jan"));
        }
    }
    ```
  ]
  Lists allow duplicates. This list has four elements.
]

== ArrayList Methods
#slide[
  #diagram("list-methods", height: 260pt)
]

#slide[
  #text(18pt)[
    ```java
    ArrayList<String> names = new ArrayList<>();
    String birgit = "Birgit";
    names.add("Lena");
    names.add(birgit);

    for (int i = 0; i < names.size(); i++) {
        System.out.println(names.get(i));
    }
    if (names.contains(birgit)) {
        names.remove(birgit);
    }
    ```
  ]
]

= foreach Loop
== foreach Loop
#slide[
  Use foreach when you need every element, but not its index.
  ```java
  for (DataType element : arrayOrList) {
      // Use element
  }
  ```
]

#slide[
  #question[What will this print?]
  ```java
  int[] a = {7, 1, 3, 8};
  for (int element : a) {
      System.out.println("Element: " + element);
  }
  ```
]

#slide[
  #diagram("foreach", height: 230pt)
  For primitive elements, the loop variable receives a copy of each value.
]

== Task: Average
#slide[
  #task[
    Use foreach to calculate the average of a non-empty `double[]`.
    Write a program that calls the method.
  ]
]

#slide[
  ```java
  static double average(double[] numbers) {
      double sum = 0.0;
      for (double number : numbers) {
          sum += number;
      }
      return sum / numbers.length;
  }
  ```
  Precondition: `numbers` is non-null and non-empty.
]

#slide[
  ```java
  public static void main(String[] args) {
      double[] a = {1.43, 2, .2, 6.32, 7.1, 8.1};
      System.out.println("Average = " + average(a));
  }
  ```
]

= Wrapper Classes & `Math` Class
== Wrapper Classes
#slide[
  Wrappers represent primitive values as objects and provide conversion methods.
  #v(12pt)
  #text(20pt)[
    #table(
      columns: (1fr, 1fr, 1fr, 1fr), inset: 10pt,
      fill: (_, y) => if calc.odd(y) { palette.surface },
      table.header([*Primitive*], [*Wrapper*], [*Primitive*], [*Wrapper*]),
      [`boolean`], [`Boolean`], [`long`], [`Long`],
      [`byte`], [`Byte`], [`char`], [`Character`],
      [`short`], [`Short`], [`float`], [`Float`],
      [`int`], [`Integer`], [`double`], [`Double`],
    )
  ]
  Generic types require reference types: `ArrayList<Integer>`, not `ArrayList<int>`.
]

== Numbers and Strings
#slide[
  #diagram("conversions", height: 230pt)
]

#slide[
  ```java
  int a = 7;
  Integer b = Integer.valueOf(a);
  String c = b.toString();
  ```
  Or use the class method directly:
  ```java
  String text = Integer.toString(7);
  int number = Integer.parseInt(text);
  ```
]

== Boxing and Unboxing
#slide[
  #diagram("boxing", height: 270pt)
]

#slide[
  *Explicit conversion*
  ```java
  Integer object = Integer.valueOf(24);
  int value = object.intValue();
  ```
  *Automatic conversion*
  ```java
  Integer object = 24;
  int value = object;
  ```
]

== The `Math` Class
#slide[
  #diagram("math-methods", height: 250pt)
]

#slide[
  Trigonometric methods use radians.
  ```java
  double angleDeg = 127.5;
  double angleRad = Math.toRadians(angleDeg);
  System.out.printf("cos(%.2f) = %.2f\n",
      angleRad, Math.cos(angleRad));
  ```
]

= License Notice
== Attribution
#slide[
  - Shared under #link("https://creativecommons.org/licenses/by-nc-sa/4.0/")[CC BY-NC-SA 4.0] and the applicable public license.
  - Based on teaching material by Prof. Dr. Marc Hensel.
  - Text, diagrams, and layout adapted. Original material supplied privately; no public source link is available.
]
