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
  title: "Lab 2 - Extension of Name Management with Methods, Class Variables and Arrays", university: [HAW Hamburg], institute: [Fakultät TI - SHC], seminar: [OOP], abstract: [
    In this lab, you should use class methods, libraries, and other
    features of Java to make your program even better.
    Your program should become more dynamic and better able to respond to more
    students. Additionally, you should encapsulate the data in the objects.
  ], show-outline: true, author: "Emily Antosch", show-solutions: false,
)

= Introduction

Extend your Java program to protect the instance variables with
so-called getter and setter methods. (For this, the month input should be
exemplarily checked for plausibility.) Furthermore, introduce a class variable that
counts the number of persons and outputs it on request. Store the
individual persons now in an array and no longer in separate variables.
Proceed as follows:
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

= Preparation
Again, first clarify the task by
drawing the Person class according to UML notation and then creating a structure chart
or flowchart that solves this task. Then define
all necessary classes, methods, and variables in Java.

= Lab Execution
If your program is not yet working error-free, we will try to correct this during
the course of the lab. With good preparation, this should not be
a problem, as every student must be able to explain their solution at the beginning
of the lab and be able in principle to
handle the task alone, so that the task is satisfactorily solved by the end of the
lab at the latest. Of course, we will support you
again, but your personal commitment must also be clearly recognizable!

#pagebreak()

= Lab Report
This time also prepare a written report that you show to Mr.
Krause at the next lab appointment, so that you can also work on your
written expression. Philipp Krause and Emily Antosch wish you
lots of fun and success!

