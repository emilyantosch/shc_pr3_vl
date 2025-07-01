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
  title: "Lab 3 - Extension of Name Management Considering Realistic Student Numbers", university: [HAW Hamburg], institute: [Fakultät TI - SHC], seminar: [OOP], abstract: [
    In this lab, you should apply the principles of inheritance to make your
    name management even better. Additionally, realistically
    high numbers should be used when processing students.
  ], show-outline: true, author: "Emily Antosch", show-solutions: false,
)

= Introduction

Extend your Java program from experiment 2 with matriculation numbers and
implement it so that you can define using a single constant `MAX_ANZAHL`
how many students the program can manage at maximum.
This maximum number can be between 1 and several million. For the
lab, a default value of 500 should be chosen. Proceed as follows:
- Create a new class Students that inherits all aspects of the Person class
  in addition to the matriculation number. The
  matriculation number starts with 1001 and increases by one with each additional
  person. This matriculation number can also only be accessed via
  appropriate methods. Otherwise, everything remains as before,
  i.e., the program is terminated with input 0, with input `MAX_ANZAHL+1` all
  attributes of all students are displayed, and with `MAX_ANZAHL+2` the
  maximum number of students manageable by the program is output.

= Preparation
Again, first clarify the task by
drawing the Students and Person classes according to UML notation, considering
their correct relationships. Then define all
necessary classes, methods, and variables in Java.

= Lab Execution:
If your program is not yet working error-free, we will try to correct this during
the course of the lab. With good preparation, this should not be
a problem, as every student must be able to explain their solution at the beginning
of the lab and be able in principle to
handle the task alone, so that the task is satisfactorily solved by the end of the
lab at the latest. Of course, we will support you
again, but your personal commitment must also be clearly recognizable!
Philipp Krause and Emily Antosch wish you lots of fun and success!

