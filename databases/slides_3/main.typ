#import "@preview/touying:0.5.2": *
#import themes.university: *

#import "@preview/fletcher:0.5.1" as flechter: diagram, node, edge

#import "@preview/gentle-clues:1.0.0": *
#import "@preview/pinit:0.2.0": *
#import "@preview/codly:1.0.0": *
#show: codly-init.with()

#import "@preview/numbly:0.1.0": numbly

#set text(lang: "de", font: "Roboto")
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
    title: [Databases], subtitle: [Lecture 3 - Entity-Relationship-Model], author: [Emily Lucia Antosch], date: datetime.today().display("[day].[month].[year]"), institution: [HAW Hamburg],
  ),
)

#codly(
  languages: (
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

- Last time, we looked at SQL as the language in which we define our database. 
- We learnt about different database objects and how they can help us achieve our business requirements.
- Today, we'll look at
  - what an ERM (Entity-Relationship-Model) is,
  - how we can use it to effectively conceptually design databases and
  - why conceptually designing a database prior to implementation can save us a lot of headache.

#slide[
  1. Introduction
  2. Basics
  3. SQL
  4. *Entity-Relationship-Model*
  5. Relationships
  6. Constraints
  7. More SQL
  8. Subqueries & Views
  9. Transactions
  10. Database Applications
  11. Integrity, Trigger & Security
]

== What is the goal of this chapter?
#slide[
  - At the end of this lesson, you should be able to
    - design a database using the ER-model,
    - decide about which attributes, constraints and relations will help you achieve your requirements.
]



= Entity-Relationship-Model

== Basics
#slide[
  #heading(numbering: none)[What is an ERM]
  - Entity-Relationship-Model is model/diagram for the logical draft of the database  
  - The focus is on the business requirements 
  - This language is not implemented in any DBMS 
]

#slide[
#heading(numbering: none)[A quick history of the ERM]
  - Introduced by Peter Chen in 1976 
  - An ERM describes interrelated things of  interest in a specific domain of knowledge 
  - A basic ERM is composed of entity types  (which classify the things of interest) and  specifies relationships that can exist  between entities (instances of those entity types) 
  - Elements: 
    - Entity: A distinguishable thing existing (physically or conceptually) in the real world. 
    - Relationship: Between entities 
    - Attribute: Property of an entity or relationship 
]


= License Notice

== Attribution

- This work is shared under the CC BY-NC-SA 4.0 License and the respective Public
  License
- #link("https://creativecommons.org/licenses/by-nc-sa/4.0/")
- This work is based off of the work Prof. Dr. Marc Hensel.
- Some of the images and texts, as well as the layout were changed.
- The base material was supplied in private, therefore the link to the source
  cannot be shared with the audience.
