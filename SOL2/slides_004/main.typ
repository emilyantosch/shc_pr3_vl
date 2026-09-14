#import "@preview/touying:0.5.2": *
#import themes.university: *

#import "@preview/fletcher:0.5.1" as flechter: diagram, edge, node

#import "@preview/gentle-clues:1.0.0": *
#import "@preview/pinit:0.2.0": *
#import "@preview/codly:1.0.0": *
#show: codly-init.with()

#import "@preview/numbly:0.1.0": numbly

#set text(lang: "en", font: "Roboto")
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
    subtitle: [Lecture 4 - Class Libraries],
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
#slide[
  - Last time we dealt with classes and objects.
  - You can now
    - write simple classes in Java,
    - create objects from classes, use attributes and call methods and
    - use class variables and class methods.
  - Today we continue with *Class Libraries*.
]

#slide[
  1. Imperative Concepts
  2. Classes and Objects
  3. *Class Library*
  4. Inheritance
  5. Interfaces
  6. Graphical User Interfaces
  7. Exception Handling
  8. Input and Output
  9. Multithreading (Parallel Computing)
]

== The Goal of This Chapter
#slide[
  - You apply strings, for example, for formatted output of data.
  - You organize similar data in fields, matrices and lists.
  - You convert strings to numerical values and apply mathematical functions to
    numerical values.
]

= Strings
== Strings
#slide[
  - Strings in C
    - Variables: Pointer to array of primitive data type `char`
    - Memory size managed by programmer
    - Data type has no methods
  - Strings in Java:
    - Strings are objects of class String.
    - Variables reference objects
    - Memory size managed by object
    - Data type provides methods
]

#slide[
  #figure(
    image("../assets/img/slides_4/2024_10_16_strings_c_java_rev01.png"),
    caption: [Strings: Differences between C and Java],
  )
]

== Creating Strings
#slide[
  - Creation also using the `new` operator:
  ```java
  String name = new String("Lena");
  ```
  - Alternatively by assigning a literal:
  ```java
  String name = "Lena";
  ```
  - Assignment of a literal also possible after creation:
  ```java
  String name = new String("Lena");
  name = "Birgit";
  ```
]

== Strings as Immutable
#slide[
  #memo[
    - As in many object-oriented languages:
      - Objects of class String are immutable.
      - Their value cannot be modified after creation.
      - For multi-stage construction, the StringBuilder class exists
  ]
]

#slide[
  #question[What output does the following program produce?]
  #text(size: 16pt)[

    ```java
    public static void main(String[] args) {
        String lena1 = new String("Lena");
        String lena2 = lena1;

        System.out.println("lena1: " + lena1 + "\nlena2: " + lena2);
        System.out.println("References equal: " + (lena1 == lena2));

        lena2 += " B.";
        System.out.println("\nlena1: " + lena1 + "\nlena2: " + lena2);
        System.out.println("References equal: " + (lena1 == lena2));
    }
    ```
  ]
]

#slide[
  - For illustration

  ```java
  String lena1 = new String("Lena");
  String lena2 = lena1;
  ```

  #figure(
    image("../assets/img/slides_4/2024_10_16_string_immut_objects_rev01.png"),
    caption: [Reference to string],
  )
]

#slide[
  ```java
  lena2 += " B.";
  ```
  #figure(
    image("../assets/img/slides_4/2024_10_16_string_immut_two_objects_rev01.png"),
    caption: [Changing the string leads to new object],
  )
]

== String Concatenation
#slide[
  - Strings can be concatenated using the plus operator:
  ```java
  String name = "Lena " + "or " + "then ";
    name = name + "after all " + "again ";
    name += "Birgit?";
  ```
  - Implicit conversion of other data types to a String object:
    - Evaluation of plus operators from left to right
    - Conversion to String if the other operand is not of type String
]

#slide[
  #question[What will be output?]
  ```java
  int a = 20;
  int b = 22;
  System.out.println("Year: " + a + b);
  System.out.println(a + b + " (Year)");
  ```
]

== `toString()` Method
#slide[
  ```java
  public String toString() {
        // Method body
        // Return of an object of type String
    }
  ```
  - Method header prescribed
  - Method body freely programmable
  - Returns a String for objects that should describe the object
  - Is called during implicit conversion of an object to a String
]

#slide[
  #task[Let's try this out!
    - Create a Person class and implement the `toString()` method
  ]
  - Check the implicit call using console output.
]

#slide[
  #text(size: 22pt)[
    ```
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
  ```
  Person lena = new Person("Lena", "Jensen");
  String name = "Name: " + lena;
  System.out.println(lena);
  System.out.println(name);
  ```
]

== String Methods
#slide[
  - Additional methods include, for example:
    - Length of the string
    - Character at specific position (First character has index 0!)
    - Replace specific character
    - Search for specific character or substring
    - Split string
    - Conversion to lowercase or uppercase
    - Comparison of two strings
    - And several more!
]

#slide[
  #task[
    - Replace "Humbug" with "Hamburg".
  ]
  ```java
  String hamburg = "Welcome to Humbug!";
  hamburg = hamburg.replace("Humbug", "Hamburg");
  System.out.println(hamburg);
  ```
]

#slide[
  #question[What will be output?]
  ```java
  String upper = "Welcome to Hamburg!";
  String lower = "welcome to hamburg!";

  System.out.println(lower.equals(upper));
  System.out.println(lower.equals(upper.toLowerCase()));
  System.out.println(lower.equalsIgnoreCase(upper));
  ```
]

== String Formatting
#slide[
  - Often asked:
    - Can you also adjust the format of the string during output? *Yes, of course!*

  - Class method `format()`:
    - Creates a formatted string
    - No output to console occurs.
    - Syntax (almost) identical to printf() from C/C++
]

#slide[
  #question[What will be output?]

  ```java
    double wind = 21.4532;
    String weather = String.format("%s %d: %.1f km/h", "Station", 7, wind);
    System.out.println(weather);
  ```
  #pause
  - *Output:* Station 7: 21.5 km/h
]

#slide[
  - Format specifications:

  ```java %[ArgumentNo.] [Flags] [MinimumNumberCharacters] [.Precision] Format```

  #text(size: 20pt)[
    #align(center + horizon)[
      #figure(
        grid(
          columns: (auto, auto),
          gutter: 30pt,
          table(
            columns: (auto, auto),
            inset: 7pt,
            align: left + horizon,
            fill: (_, y) => if calc.odd(y) { green.lighten(90%) },
            table.header([*Format*], [*Meaning*]),
            [`f,e,g`], [float],
            [`d`], [Integer],
            [`o`], [Octal],
            [`x, X`], [Hexadecimal],
            [`s`], [String],
            [`t`], [time],
            [`b`], [boolean],
          ),
          table(
            columns: (auto, auto),
            inset: 10pt,
            align: left + horizon,
            fill: (_, y) => if calc.odd(y) { green.lighten(90%) },
            table.header([*Flag*], [*Meaning*]),
            [`-`], [Left Alignment],
            [`+`], [Print Prefix],
            [`0`], [Fill empty space with 0],
            [`,`], [Add commas for thousands],
            [`(`], [Add parentheses for negative numbers],
          ),
        ),
        caption: [Formats and Flags],
      )
    ]
  ]
]

#slide[
  #text(size: 22pt)[
    #question[What will be the output?]
    ```java
    double wind = 21.4532;
    System.out.println(String.format("%2.2f km/h", wind));
    System.out.println(String.format("%8.2f km/h", wind));
    System.out.println(String.format("%08.2f km/h", wind));
    ```
    #pause
    - Output:
      - 21.45 km/h
      - 21.45 km/h
      - 00021.45 km/h
  ]
]


#slide[
  #memo[
    - Minimum number of characters:
      - Includes decimal places as well as the comma
      - Does not cut off any digits before the decimal point
  ]
]

#slide[
  #question[
    - What do you notice?
  ]
  ```java
  double wind = 21.4532;
  System.out.println(String.format("%2.2f km/h", wind));
  ```
  - Output: 21.45 km/h
    #pause
  - Above in output "German decimal comma" instead of "English point"
  - Specified by localization
]

#slide[
  #example[
    ```java
      double wind = 21.4532;
      System.out.println(String.format(Locale.US, "%2.2f km/h", wind));
      System.out.println(String.format(Locale.GERMAN, "%2.2f km/h", wind));
    ```
    - Output: 21.45 km/h 21.45 km/h
  ]
]

= Arrays
== Arrays
#slide[
  - Arrays in C:
    - Variables: Pointer to first element of the array in memory
    - Memory size managed by programmer
    - Data type has no methods

  - Arrays in Java:
    - Arrays are objects.
    - Variables reference objects
    - Memory size managed by object
    - Data type provides methods
]

#slide[
  #figure(
    image("../assets/img/slides_4/2024_10_16_arrays_c_java_rev01.png"),
    caption: [Arrays in Java and C],
  )
]

== Creating Arrays
#slide[
  - Collection of elements with the same data type
  - Data type becomes array through square brackets (e.g. `int[]`, `String[]`)
  - Array classes are separate (additional) data types

  - Declaration:
    - Does not require specification of length
    - Variable can reference arrays of any length
    - Declaration does not create object, but reference variable
]

#slide[
  ```java
  int[] filter;
  ```
  #memo[- Brackets after variable names allowed, but not recommended (Why?)]
  ```java
  int filter[];
  ```
]

== Creation: Dynamic Declaration
#slide[
  - Create array object using new operator
  - Number of fields in square brackets
  - Note: No round "constructor brackets" after data type
  - Values in array are initialized with 0, 0.0, false or null

  ```java
  int[] filter = new int[];
  ```
  #figure(
    image("../assets/img/slides_4/2024_10_16_filter_array_empty_rev01.png"),
    caption: [Creation of an array],
  )
]


== Creation: Assigning Elements
#slide[
  - Access to array element via index in square brackets
  - First element has index 0

  ```java
  int[] filter = new int[3];
    filter[0] = 1;
    filter[1] = 2;
    filter[2] = 1;
  ```

  #figure(
    image("../assets/img/slides_4/2024_10_16_filter_array_filled_single_rev01.png"),
    caption: [Assigning values through index access],
  )
]

== Creation: Static Declaration
#slide[
  - You can assign values to an array already when creating the object.
  - Values in curly braces and separated by commas
  - Allowed with and without use of the new operator

  ```java
  int[] filter = {1, 2, 1};
  int[] filter = new int[] {1, 2, 1};
  ```

  #figure(
    image("../assets/img/slides_4/2024_10_16_filter_array_filled_single_rev01.png"),
    caption: [Filling during declaration],
  )
]

== Properties: Array Classes
#slide[
  - Arrays are objects of the corresponding class:
    - Arrays have methods.
    - Number of elements via instance variable length

  #question[Which array is created by the code?]

  #text(size: 22pt)[

    ```java
    int[] filter = new int[3];
      for (int i = 0; i < filter.length; i++) {
          filter[i] = i * i;
      }
    ```
  ]

  #figure(
    image("../assets/img/slides_4/2024_10_16_filter_array_question_rev01.png"),
    caption: [Filling through `for` loop],
  )
]

#slide[
  - Indices:
    - When accessing element, checks whether index is in allowed range
    - More in chapter on exceptions and error handling

    #example[
      Examples of allowed and disallowed indices:
      ```java
      int[] filter = new int[3];
      filter[0] = -1;
      filter[2] = 4;
      filter[-1] = 1;
      filter[3] = 2;
      ```
    ]
    #figure(
      image("../assets/img/slides_4/2024_10_16_filter_array_index_rev01.png"),
      caption: [Indices of array `filter`],
    )
]

#slide[
  - Arrays can be declared for any data types (including custom classes)
  - Objects must be of the same type (or subtype, more on this with inheritance)
  - Not the objects stored, but references to the objects

  ```java
  Person[] friends = new Person[3];
  friends[0] = new Person("Lena");
  friends[1] = new Person("Birgit");
  friends[2] = new Person("Jan");
  ```

  #figure(
    image("../assets/img/slides_4/2024_10_16_friends_array_classes_rev01.png"),
    caption: [Arrays of objects],
  )
]

== Questions
#slide[
  #question[
    What will be output?
  ]

  ```java
  int[] a = {1, 2, 3, 4, 5};
  int[] b = a;
  b[3] = 0;
  System.out.println(b[2]);
  System.out.println(a[3]);
  ```
]

#slide[
  #question[What will be output?]

  ```java
  int[] a = {1, 2, 3, 4, 5};
  int[] b = {1, 2, 3, 4, 5};
  System.out.println(a == b);
  ```
]

#slide[
  #question[What will be output?]
  #text(size: 18pt)[

    ```java
    public class ArrayDemo {
          static int[] createSortedArray(int a, int b) {
              if (a < b) {
                  return new int[] {a, b};
              } else {
                  return new int[] {b, a};
              }
          }

          public static void main(String[] args) {
              System.out.println( createSortedArray(7, 4)[1] );
          }
      }
    ```
  ]
]

#slide[
  #task[
    - Write a method that sorts the elements of an `int[]` array in ascending order.
    - Test the method using the array `{10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 7}`.
  ]

]

#slide[
  #text(size: 18pt)[
    ```java
    public static void sort(int[] a) {
        int i = 0;
        while (i <= a.length - 2) {
            if (a[i] > a[i+1]) {
                // Swap elements and shift index to left element
                int temp = a[i];
                a[i] = a[i+1];
                a[i+1] = temp;
                if (i > 0)
                    i--;
            } else {
                i++;
            }
        }
    }
    ```
  ]
]

= Multidimensional Arrays
== Multidimensional Arrays
#slide[
  - Multidimensional arrays are "arrays of arrays".
  - Example: `int[][]` is array whose elements are of data type `int[]`.

  Dynamic declaration:
  ```java
    int[][] filter = new int[3][4];
  ```
  Static declaration:
  ```java
    int[][] filter = {{1,2,3}, {4,5,6}, {7,8,9}};
  ```

  #figure(
    image("../assets/img/slides_4/2024_10_16_filter_array_dim_rev01.png"),
    caption: [Multidimensional array],
  )
]

#slide[
  #question[What will be output?]

  ```java
   int[][] a = {{1,2}, {3,4}, {5,6}};

  System.out.println(a.length);
  System.out.println(a[2].length);

  System.out.println(a[1][1]);
  System.out.println(a[2][0]);
  ```

]
#slide[
  #figure(
    image("../assets/img/slides_4/2024_10_16_a_array_question_dim_rev01.png"),
    caption: [Multidimensional arrays with values],
  )
]

#slide[
  #question[What will be output?]

  ```java
  int[][] a = {{1,2}, {3,4}, {5,6}};
  int[] b = a[0];
  int c = b[1];

  b[1] = 7;
  System.out.println(a[0][1]);
  System.out.println(c);
  ```
]

#slide[
  #figure(
    image("../assets/img/slides_4/2024_10_16_a_b_c_array_question_rev01.png"),
    caption: [Complex multidimensional arrays],
  )
]

#slide[
  - Multidimensional arrays do not have to be rectangular
  - Example: Assign own array to each row of a two-dimensional array

  #task[Create a triangle matrix using a `for` loop!]

  #pause

  #text(size: 18pt)[
    ```java
    int[][] a = new int[3][];
    	for (int i = 0; i < a.length; i++) {
    	    a[i] = new int[i + 1];
    	}
    ```
  ]
]
#slide[
  #figure(
    image("../assets/img/slides_4/2024_10_17_triangle_array_rev01.png"),
    caption: [Multidimensional array in the shape of a triangle],
  )
]

= Lists
== ArrayList
#slide[
  - Arrays: Size cannot be changed after creation ("semi-dynamic")
  - Lists: Elements can be added or removed ("dynamic")
    - Data type of elements to be stored in angle brackets (see below: String)
]

#slide[
  #text(size: 18pt)[
    ```java
    public class ArrayListDemo {
    	    public static void main(String[] args) {
    	        ArrayList<String> names = new ArrayList<String>();
    	        names.add("Lena");
    	        names.add("Birgit");
    	        names.add("Jan");
    	        names.add(new String("Jan"));
    	    }
    	}
    ```
  ]
]

#slide[
  - Examples:
    - Number of elements (`size()`)
    - Access to elements (`get()`)
    - Query whether specific element is in list (`contains()`)
    - Remove element from list (`remove()`)
]

#slide[
  #text(size: 18pt)[

    ```java
    ArrayList<String> names = new ArrayList<String>();
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
  ```java
  for (DataType Variable : IterationObject) {
      Statements
  }
  ```

  - Motivation:
    - Sometimes every element e.g. of an array or a list is needed
    - But: Position within the array or list is not needed
    - Therefore no loop counter as index needed
]

#slide[
  - Loop iterates through array (or list) from first to last element:
  - On first pass, variable has the value of the 1st element
  - On second pass, variable has the value of the 2nd element and so on
  - On last pass, variable has the value of the last element
]

#slide[
  #question[What will be output?]
  ```java
  int[] a = {7, 1, 3, 8};

  	for (int element : a) {
  	    System.out.println("Element: " + element);
  	}
  ```
  #figure(image("../assets/img/slides_4/2024_10_16_foreach_rev01.png"), caption: [Result of foreach loop])
]

#slide[
  #task[
    - Create the following using a foreach loop:
    - Method that returns the average of the numbers contained in an array
    - Program that uses the method
  ]
]

#slide[
  #text(size: 20pt)[
    ```java
    static double average(double[] numbers) {
    	    double sum = 0.0;

    	    for(double number : numbers) {
    	        sum += number;
    	    }
    	    return sum / numbers.length;
    	}

    	public static void main(String[] args) {
    	    double[] a = {1.43, 2, .2, 6.32, 7.1, 8.1};
    	    System.out.println("Average = " + average(a));
    	}
    ```
  ]
]

= Wrapper Classes & `Math` Class
== Wrapper Classes
#slide[
  - Primitive data types:
    - Store value (e.g. integer) directly
    - Have no methods

  - Wrapper classes:
    - "Wrap" primitive data types into classes
    - Provide methods (e.g. for integers)

  #text(size: 20pt)[
    #align(center + horizon)[
      #figure(
        table(
          columns: (auto, auto),
          inset: 10pt,
          align: left + horizon,
          fill: (_, y) => if calc.odd(y) { green.lighten(90%) },
          table.header([*Primitive*], [*Wrapper Class*]),
          [`boolean`], [Boolean],
          [`byte`], [Byte],
          [`short`], [Short],
          [`int`], [Integer],
          [`long`], [Long],
          [`char`], [Character],
          [`float`], [Float],
          [`double`], [Double],
        ),
        caption: [Formats and Flags],
      )
    ]
  ]
]

#slide[
  #text(size: 22pt)[
    - Convert primitive data types to String
    ```java
    	int a = 7;
    	Integer b = new Integer(a);
    	String c = b.toString();
    ```
    - Shorter alternative via class method:
    ```java
    	String a = Integer.toString(7);
    ```
    - Convert String to primitive data types:
    ```java
    	String a = "7";
    	int b = Integer.parseInt(a);
    ```
  ]
]

#slide[
  #text(size: 22pt)[
    - Conversions:
      - Boxing: Conversion of primitive data type to object of wrapper class
      - Unboxing: Conversion of object of wrapper class to primitive data type
    ```java
    	Integer object = new Integer(24); //Boxing of int value
    	int noObject = object.intValue(); //Unboxing of object
    ```

    - Autoboxing: Automatic conversions (both directions)
    ```java
    	Integer object = 24; //Automatic boxing of int value
    	int noObject = object; //Automatic unboxing of object
    ```
  ]
]

#slide[
  #figure(
    image("../assets/img/slides_4/2024_10_16_wrapper_conversion_rev01.png"),
    caption: [Type conversion with wrapper classes],
  )
]

== `Math` Class
#slide[
  - Mathematical constants: Euler's number e, pi $pi$
  - Mathematical functions (as class methods), e.g.:
    - Trigonometric functions
    - Rounding
    - Absolute value
    - Exponential function and logarithm
    - Maximum and minimum
    - Roots
    - Random numbers
    #example[
      ```java
      double angleDeg = 127.5;
      double angleRad = Math.toRadians(angleDeg);
      System.out.printf("cos(%.2f) = %.2f\n", angleRad, Math.cos(angleRad));
      ```
    ]
]

= License Notice
== Attribution
#slide[
  - This work is shared under the CC BY-NC-SA 4.0 License and the respective Public
    License
  - #link("https://creativecommons.org/licenses/by-nc-sa/4.0/")
  - This work is based off of the work Prof. Dr. Marc Hensel.
  - Some of the images and texts, as well as the layout were changed.
  - The base material was supplied in private, therefore the link to the source
    cannot be shared with the audience.
]
