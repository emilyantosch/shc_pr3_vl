#import "@preview/touying:0.5.2": *
#import themes.university: *

#import "@preview/fletcher:0.5.1" as flechter: diagram, node, edge
#import "@preview/tiaoma:0.2.1"
#import "@preview/gentle-clues:1.0.0": *
#import "@preview/pinit:0.2.0": *
#import "@preview/codly:1.0.0": *
#show: codly-init.with()
#import "@preview/numbly:0.1.0": numbly

#set text(lang: "en")
#set heading(numbering: numbly("{1}.", default: "1.1"))
#set align(left + top)

#show raw: it => {
  show regex("pin\d"): it => pin(eval(it.text.slice(3)))
  it
}

#show: university-theme.with(
  aspect-ratio: "16-9",
  config-info(
    title: [Databases],
    subtitle: [Lecture 2: SQL - Structured Query Language],
    author: [Emily Lucia Antosch],
    date: datetime.today().display("[day].[month].[year]"),
    institution: [HAW Hamburg],
  ),
)

#set text(size: 20pt)

#codly(
  languages: (
    sql: (
      name: text(font: "JetBrainsMono NFM", " SQL", weight: "bold"),
      icon: text(font: "JetBrainsMono NFM", "\u{e76e}", weight: "bold"),
      color: rgb("#2563eb"),
    ),
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

= SQL: Structured Query Language
== What is SQL?
#slide[
  - Standard language for managing relational databases
  - Used for querying, updating, and managing data
]
== Basic SQL Commands
#slide[
  - SELECT: Retrieve data
  - INSERT: Add new records
  - UPDATE: Modify existing records
  - DELETE: Remove records
]
== SQL Example: SELECT Statement

#slide[
  ```sql
  SELECT Name, Major
  FROM Students
  WHERE GPA > 3.5;
  ```
]
== SQL Example: INSERT Statement
#slide[
  ```sql
  INSERT INTO Students (Student_ID, Name, Major, GPA)
  VALUES (104, 'David', 'Biology', 3.7);
  ```
]
