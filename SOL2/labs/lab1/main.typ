#import "@preview/grape-suite:1.0.0": exercise, german-dates

#set text(lang: "en")

#import "@preview/codly:1.0.0": *
#show: codly-init.with()

#codly(
  languages: (
    java: (
      name: text(font: "JetBrainsMono NFM", " Java", weight: "bold"), icon: text(font: "JetBrainsMono NFM", "\u{e738}", weight: "bold"), color: rgb("#CE412B"),
    ), c: (
      name: text(font: "JetBrainsMono NFM", " C", weight: "bold"), icon: text(font: "JetBrainsMono NFM", "\u{e61e}", weight: "bold"), color: rgb("#5612EC"),
    ),
  ),
)

#show: exercise.project.with(
  title: "Lab 1 - Name Management with Java", university: [HAW Hamburg], institute: [Fakultät TI - SHC], seminar: [OOP], abstract: [
    In this lab, the first knowledge in the Java programming language
    should be consolidated. You need the first four lectures to be able to
    complete this lab. A name management system should be programmed with which
    you can modify a list of names according to certain rules.
  ], show-outline: true, author: "Emily Antosch", show-solutions: false,
)

= Introduction

In China, there is the possibility to change one's name every three years.
The program to be created should be able to run on different
hardware platforms without recompilation. Therefore, create a Java program that
makes this possible. Proceed as follows:
- First, create a class called Person that contains the following attributes:
  first name, last name, name change date (separated by day, month, and year).
- Now write a Java program that first outputs the Hamburg greeting
  for "Good day!" on the console.
- Then your program creates three objects of the Person class, named: `person_1`, `person_2`, and `person_3`.
- Then your program asks which person (1, 2, or 3) wants to change their name.
- Input 0 leads to program termination and input 4 displays the
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

#pagebreak()

= Preparation
First clarify the task by drawing the Person class
according to UML notation and then creating a structure chart or flowchart
that solves this task. Then define all necessary
classes in Java.

= Assistance
The following program, which demonstrates console input, can be used to
solve this task:

```java
import java.io.*;
public class Eingabe{
  public static void main(String[] args) throws IOException {
  // Console input
  InputStreamReader isr = new InputStreamReader(System.in);
  BufferedReader br = new BufferedReader(isr);
  System.out.print("Enter something here: ");
  String eingabe = br.readLine();

  System.out.println("You entered \"" + eingabe + "\"");

  // If a number is needed for case distinction (e.g., age of majority):
  int zahl = Integer.parseInt(eingabe);
  if (zahl >= 18){
    System.out.println("Of age.");
  } else {
    System.out.println("Not yet of age.");
  }
 }
}
```

= Lab Execution

If your program is not yet working error-free, we will try to correct this during
the course of the lab. With good preparation, this should not be
a problem, as every student must be able to explain their solution at the beginning
of the lab and be able in principle to
handle the task alone, so that the task is satisfactorily solved by the end of the
lab at the latest. Of course, we will support you,
but your personal commitment must also be clearly recognizable!
Philipp Krause and Emily Antosch wish you lots of fun and success!
