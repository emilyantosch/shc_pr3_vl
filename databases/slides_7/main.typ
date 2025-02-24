#import "@preview/touying:0.5.2": *
#import themes.university: *

#import "@preview/fletcher:0.5.1" as flechter: diagram, node, edge
#import "@preview/wrap-it:0.1.0": wrap-content

#import "@preview/gentle-clues:1.0.0": *
#import "@preview/pinit:0.2.0": *
#import "@preview/codly:1.0.0": *
#show: codly-init.with()

#import "@preview/numbly:0.1.0": numbly

#set text(lang: "de", font: "Roboto", size: 18pt)
#set heading(numbering: numbly("{1}.", default: "1.1"))

#set align(left + top)

#show raw: it => {
  show regex("pin\d"): it => pin(eval(it.text.slice(3)))
  it
}
#let pinit-rect-from(height: 2em, pos: bottom, fill: rgb(0, 180, 255), point-pin, body) = {
  pinit-point-from(
    fill: fill, pin-dx: 0em, pin-dy: if pos == bottom { 0em } else { -0.6em }, body-dx: 0pt, body-dy: if pos == bottom { -1.7em } else { -1.6em }, offset-dx: 0em, offset-dy: if pos == bottom { 1.2em + height } else { -0.6em - height }, point-pin, rect(inset: 0.5em, stroke: (bottom: 0.12em + fill), {
      set text(fill: fill)
      body
    }),
  )
}
#show: university-theme.with(
  aspect-ratio: "16-9", config-info(
    title: [Objektorientierte Programmierung in Java], subtitle: [Vorlesung 6 - Abstrakte Elemente], author: [Emily Lucia Antosch], date: datetime.today().display("[day].[month].[year]"), institution: [HAW Hamburg],
  ),
)

#codly(
  languages: (
    sql: (
      name: text(font: "JetBrainsMono NFM", " SQL", weight: "bold"),
      icon: text(font: "JetBrainsMono NFM", "\u{e76e}", weight: "bold"),
      color: rgb("#2563eb"),
    ),
    java: (
      name: text(font: "JetBrainsMono NFM", " Java", weight: "bold"), icon: text(font: "JetBrainsMono NFM", "\u{e738}", weight: "bold"), color: rgb("#CE412B"),
    ), c: (
      name: text(font: "JetBrainsMono NFM", " C", weight: "bold"), icon: text(font: "JetBrainsMono NFM", "\u{e61e}", weight: "bold"), color: rgb("#5612EC"),
    ),
  ),
)

#title-slide(authors: ([Emily Lucia Antosch]))

#outline(depth: 1)

= Introduction

== Where are we right now?
#slide[
  //TODO: Add what we did last time
- Last time, we looked at the
- Today, we'll be discussing
  - how you can work with subqueries and views, 
  - how subqueries and views are powerful tools that you can use to design complex databases and
  - how stacking views can enable complex solutions.
]

#slide[
  1. Introduction
  2. Basics
  3. SQL
  4. Entity-Relationship-Model
  5. Relationships
  6. Constraints
  8. *Subqueries & Views*
  9. Transactions
  10. Database Applications
  11. Integrity, Trigger & Security
]

== What is the goal of this chapter?
#slide[
  - At the end of this lesson, you should be able to
    - create views in PostgresQL and use them effectively
    - use subqueries in different points in the development of your database to enable your ideas and 
    - know best practices and tricks that allow for complex data structures.
]

= Views
== Relational Algebra
#slide[
#heading(numbering: none)[Overview]
- While SQL is the what, Relational Algebra is the how! 
- In mathematics an algebra is a values range combined with defined operations 
- Relational Algebra: The values range is the content of the database;  operations are functions to calculate the query results 
  - a set of operations for the relational model 
- Relational Calculus: Descriptive approach that is based on mathematical logic 
  - higher-level declarative language for specifying relational queries,  e.g., no order of operations, only what information the result should contain 
]

#slide[
#heading(numbering: none)[Overview]
- Algebra operations produce new relations 
- These can be further manipulated using operations of the same algebra 
- Sequence of relational algebra operations: relational algebra expression 
- The result of a relational algebra expression is also a relation representing the result of a database query (retrieval request)
]

#slide[
#heading(numbering: none)[Overview]
- Algebra operations can be divided into two groups 
  - First group consists of operations developed specifically for relational databases 
    - i.e., Selection, Projection, and Join 
  - Second group includes set operations from mathematical set theory 
    - i.e.,  Union, Intersection, Set Difference, and Cartesian Product 
]

#slide[
#heading(numbering: none)[Overview]
- Order of explanation 
  1. Selection 
  2. Projection 
  3. Renaming 
  4. Union, Intersection, Set Difference 
  5. Cartesian Product 
  6. Join (Equijoin, Natural Join) 
]

#slide[
#heading(numbering: none)[Selection]
  #figure(image("../assets/img/slides_07/20250221_proj_sel_rev01.png"))
- `<attribute list>` is a list of attribute names (columns)  whose values are to be retrieved by the query 
- `<table list>` is a list of the relation names (e.g., tables) required to process the query 
- `<condition>`: optional conditional (Boolean) expression that identifies the tuples to be  retrieved by the query 
]


= License Notice
== Attribution

- This work is shared under the CC BY-NC-SA 4.0 License and the respective Public
  License.
- #link("https://creativecommons.org/licenses/by-nc-sa/4.0/")
- This work is based off of the work by Prof. Dr. Ulrike Herster.
- Some of the images and texts, as well as the layout were changed.
- The base material was supplied in private, therefore the link to the source
  cannot be shared with the audience.
