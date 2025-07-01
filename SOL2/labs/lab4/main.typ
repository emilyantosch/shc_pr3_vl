#import "@preview/grape-suite:1.0.0": exercise, german-dates

#import "@preview/gentle-clues:1.0.0": *
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
  title: "Lab 4 - Creation of a Labyrinth using Arrays and Recursion", university: [HAW Hamburg], institute: [Fakultät TI - SHC], seminar: [OOP], abstract: [
    In this lab, you will learn to work with arrays and recursion in Java.
    You will implement a pathfinding algorithm to help a mouse navigate through
    a labyrinth to reach cheese. This exercise consolidates your knowledge of
    arrays, recursive methods, and algorithmic thinking.
  ], show-outline: true, author: "Emily Antosch", show-solutions: false,
)

= Introduction

A poor, hungry mouse sits in the upper left corner of a labyrinth
(see sketch) and wants to reach a piece of cheese located in the lower
right corner of the labyrinth. It can enter all non-hatched
fields, but only via an edge shared by two adjacent fields.
Help the mouse reach the cheese. Write a recursive
method in Java that shows the mouse a path to the cheese.

#figure(image("../../assets/img/2024_11_04_maus_laby_rev01.png"))

#tip[
  Your method must try for every possible field to find a path to the cheese
  via each of the four neighboring fields.
]

#pagebreak()
= Preparation
Represent the labyrinth in a two-dimensional array. Use
two more fields than specified by the labyrinth and fill
the border fields with walls (corresponding to the hatched elements in the
labyrinth). Since the mouse is located in the upper left, there are initially only two
meaningful paths. However, from the second step onward, use a method that checks all
four directions and calls itself recursively to find the
path. Tip: Use a marking character to mark the path that
the mouse has taken, as the mouse should not go backwards.
(This will be helpful when implementing the algorithm. If
the chosen path was not successful, the mouse goes back along this path,
deletes the marking again, and starts the search anew.) At the end, the path through the labyrinth should be drawn. If you
want, you can recreate the labyrinth with graphical methods and also
enter the mouse's path to the cheese. A modification of the labyrinth
or a larger number of fields is also possible.

= Lab Execution
If your program is not yet working error-free, we will try to correct this during
the course of the lab. With good preparation, this should not be
a problem, as every student must be able to explain their solution at the beginning
of the lab and be able in principle to
handle the task alone, so that the task is satisfactorily solved by the end of the
lab at the latest.
#memo[
  A time extension is excluded for this experiment!
]
Of course, we will support you again, but your personal
commitment must also be clearly recognizable! Philipp Krause and Emily Antosch
wish you lots of fun and success!