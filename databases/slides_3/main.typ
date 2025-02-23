#import "@preview/touying:0.5.2": *
#import themes.university: *

#import "@preview/fletcher:0.5.1" as flechter: diagram, node, edge

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
    title: [Databases],
    subtitle: [Lecture 3 - Entity-Relationship-Model],
    author: [Emily Lucia Antosch],
    date: datetime.today().display("[day].[month].[year]"),
    institution: [HAW Hamburg],
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
  - Introduced by Peter Chen in 1976.
  - An ERM describes interrelated things of interest in a specific domain of knowledge.
  - A basic ERM is composed of entity types (which classify the things of interest) and specifies relationships that can exist between entities (instances of those entity types).
  - Elements:
    - Entity: A distinguishable thing existing in the real world.
    - Relationship: Between entities.
    - Attribute: Property of an entity or relationship.
]

#slide[
  #heading(numbering: none)[Conceptual Design with ERM]
  #figure(image("../assets/img/slides_03/20250217_erm_concept_rev01.png"))
]

#slide[
  #heading(numbering: none)[Conceptual Design with ERM]
  #let left = [
    - Entity Type
      - Represented as a rectangle
      - Singular Noun
    - Attribute Type
      - Represented as ovals
      - Noun
    - Relationship Type
      - Represented as diamond
      - Always between entities
      - Verb & has cardinalities
  ]
  #let right = [
    #figure(image("../assets/img/slides_03/20250217_erm_elem_rev01.png", height: 80%))
  ]
  #grid(
    columns: (70%, auto),
    gutter: 0.25em,
    left, right,
  )
]

#slide[
  #heading(numbering: none)[Online-Tools for ERM]
  #let left = [
    - Creating ERMs can be done by using any drawing tool or just a piece of paper and a pen.
    - Examples of drawing tools:
      - Excalidraw (Recommended)
      - Draw.io
      - Lucidchart
      - Creately
  ]
  #let right = [
    #figure(image("../assets/img/slides_03/20250217_drawio_rev01.png"))
  ]
  #grid(
    columns: (auto, auto),
    gutter: 3em,
    left, right,
  )
]

#slide[
  #heading(numbering: none)[Entity Abstraction]
  #figure(image("../assets/img/slides_03/20250217_entities_types_rev01.png"))
]

#slide[
  #heading(numbering: none)[Entity Abstraction]
  #memo[
    - An *entity* is a distinguishable thing that exists in the real world.
  ]
  - An abstraction of entities would be an *entity type* (comparable to classes in OOP)
  - Several entities make up an *entity set*
  - An abstraction of relationships is called a *relationship type*
]

#slide[
  #heading(numbering: none)[Entity Abstraction]
  #example[
    Imagine a company:
    - A company is made-up of departments and each department has a unique name, a number and a manager.
    - Each employee's name, social security number, address, salary and birth date is stored within our database.
    - We also want to keep track of the hours per week per project, keep track of the supervisor.
  ]
]

#slide[
  #heading(numbering: none)[ERM: Company Example]
  #figure(image("../assets/img/slides_03/20250217_emp_example.png", height: 89%))
]

#slide[
  #heading(numbering: none)[Entity Type]
  - An *entity type* is a basic object in an ERM.
  - Represents a thing in the real world, like a car, a job or a person.
  - An entity type has attributes, such as a name, an address or an age.
  - A particular entity of that type will have values for each of these attributes.
]

#slide[
  #heading(numbering: none)[Entity Type]
  #memo[
    - An entity type therefore defines a collection of entities, that have the same attributes.
    - Each entity type can be defined by its name and its attributes.
    - The collection of all entities of a particular entity type, so all the instances of this entity type, is called an *entity set*.
  ]
]

#slide[
  #heading(numbering: none)[ERM: Entity Example]
  - Categories for entities could be
    - actual physical objects, people, roles, organizations,
    - actions, interfaces or general information
  - An element is not an entity type
    - if it has neither attributes nor relationships,
    - only contains attributes that another entity type already has
  #question[
    What is a good name for an entity type?
  ]
]

#slide[
  #heading(numbering: none)[ERM: Entity Example]
  #task[
    What are the entity types in the following examples?
  ]
  - A company is organized in departments.
  - Departments have a unique name, a unique number, a manager.
  - A department oversees a number of projects, each with a name and a number.
  - The company may store information about each employee like their name, their social security number and their salary.
]

#slide[
  #heading(numbering: none)[Entity Type]
  #figure(image("../assets/img/slides_03/20250217_entities_vs_types_rev01.png"))
]

#slide[
  #heading(numbering: none)[Attributes]
  - Is the attribute relevant to the problem you are trying to solve?
  - An attribute must belong to an entity type (or a relationship type).
  - Some of the attributes of an entity are important in identifying the entity. These are called *key attributes*.
  - A good name for an attribute is unique within the entity type, but not necessarily across the entire model.
]

#slide[
  #heading(numbering: none)[Attributes]
  #task[
    When you look at the attributes of the entity project, what could be identifying or key attributes?
    - A department controls a number of projects, each with a unique name, unique number and a single location.
  ]
]

#slide[
  #heading(numbering: none)[Attributes]
  #figure(image("../assets/img/slides_03/20250220_attribute_ex_rev01.png"))
]

#slide[
  #heading(numbering: none)[Attributes]
  #figure(image("../assets/img/slides_03/20250220_attribute_ex_rev01.png"))
  - Composite vs. Simple (atomic) attributes
    - Attributes which are not divisible are called simple or atomic attributes
    - Composite attributes can form a hierarchy
    - Composite attributes are useful to model situations in which a user sometimes refers to the composite attribute as a unit but at other times refers specifically to its components
    - If the composite attribute is referenced only as a whole, there is no need to subdivide it into component attributes
    - Composite attributes are attached to their component attributes by straight lines
]


#slide[
  #heading(numbering: none)[Attributes in Entity Types]
  #figure(image("../assets/img/slides_03/20250220_entity_type_detail_rev01.png"))
]

#slide[
  #heading(numbering: none)[Key Attributes in entity sets]
  - How can we identify an actual entity within an entity set?
  - Attributes must be used
    → Key Attributes (also called identifying attributes)
  - Sometimes several attributes together form a key attribute (identifying attribute), meaning that the combination of the attribute values must be distinct for each entity
    - If a set of attributes possesses this property, the proper way to represent this in the ER model that is to define a composite attribute and designate it as a key attribute of the entity type
    - Notice that such a composite key attributes must be minimal; that is, all component attributes must be included in the composite attribute to have the uniqueness property
  - Key attributes are underlined
  - If two attributes are underlined separately, then each is an identifying attribute on its own
]

#slide[
  #heading(numbering: none)[Key Attributes in entity sets]
  #task[
    What are key attributes for entity type `EMPLOYEE` and `DEPARTMENT`?
  ]
  - A company is organized in departments.
  - Departments have a unique name, a unique number, a manager.
  - A department oversees a number of projects, each with a name and a number.
  - The company may store information about each employee like their name, their social security number and their salary.
]

#slide[
  #heading(numbering: none)[Key attributes in entity sets]
  #figure(image("../assets/img/slides_03/20250220_attribute_emp_dept_rev01.png"))
]

#slide[
  #heading(numbering: none)[Key attributes in entity sets]
  #task[
    What are key attributes for `BOOK`?
  ]
  #figure(image("../assets/img/slides_03/20250220_attribute_book_rev01.png", height: 53%))
]

#slide[
  #heading(numbering: none)[Key attributes in entity sets]
  #task[
    What are key attributes for `PERSON` and `HOUSE`?
  ]
  #figure(image("../assets/img/slides_03/20250220_attribute_person_house_rev01.png", height: 53%))
]

//TODO: Add more sections to the above chapter

= The relational model
== What is the relational model
#slide[
  #heading(numbering: none)[RM: A quick history]

  #let left = [
    - Edgar F. Codd invented the relational model in 1970 and won the Turing price for it.
    - The model has become widely accepted.
    - The model is based on relations, that are subset of the Cartesian product.
    - Everything is modelled in tables.

  ]
  #let right = [
    #figure(image("../assets/img/slides_03/2024_12_31_s1_db_inventor_rev01.png"))
    #figure(image("../assets/img/slides_03/20250220_relational_table_rev01.png"))

  ]
  #grid(
    columns: (auto, auto),
    gutter: 0.25em,
    left, right,
  )
]

#slide[
  #heading(numbering: none)[RM: The model]
  - The relational schema describes objects and relationships as a relational schema.
  - A relational schema consists of a set of attributes
  - Each attribute belongs to a value range/type
  - A database schema consists of a set of relational schemas
  - A relation displays the current data for the relational schema
  - The set of relations is called the database (or the state of the DB)
  - An element of a relation is called a tuple, which is simply a row
]

#slide[
  #heading(numbering: none)[RM: The model]
  #figure(image("../assets/img/slides_03/20250220_relational_model_rev01.png"))
]

#slide[
  #heading(numbering: none)[RM: The model]
  #figure(image("../assets/img/slides_03/20250220_relational_model_cartesian_rev01.png"))
]

#slide[
  #heading(numbering: none)[RM: The model]
  - Objects are described using relations
    - Relations can be viewed as tables
    - But: Not like a spreadsheet table!
  - There can be links between relations
  - Attributes describe properties
  - Possible attribute values are defined by the domain
]

#slide[
  #heading(numbering: none)[RM: The model]
  Informally:
  - A relational model represents the database as a collection of relations
  - Each relation resembles a table of values or, to some extent, a flat file of records
  - When a relation is thought of as a table of values, each row in the table represents a collection of related data values
  - A row represents a fact that typically corresponds to a real-world entity or relationship
  - The table name and column names are used to help to interpret the meaning of the values in each row
  - All values in a column are of the same data type
]

#slide[
  #heading(numbering: none)[RM: The model]
  Formally:
  - A row is called a tuple
  - A column header is called an attribute
  - The table is called a relation
  - The data type describing the types of values that can appear in each column is represented by a domain of possible values
]

#slide[
  #heading(numbering: none)[RM: The math behind it]
  - Example:
    - `ROOM(room_num, function, seats)`
    - where $"function" = {"auditorium, lab, office, administration"}$
  //TODO: Add img
]

#slide[
  #heading(numbering: none)[RM: The math behind it]
  #idea[
    - A Relation Schema $R$ is a set of attributes $(A_1, A_2, ..., A_n)$.
    - Each attribute $A_i$ is the name of a role played by a certain domain $D$ in the relational schema $R$.
    - A domain $D$ of attribute $A_i$ is denoted as $"dom"(A_i)$.
    - The $"degree"$ (or $"arity"$) of a relation is the number of attributes $n$ of its relational schema.
  ]
]

#slide[
  #heading(numbering: none)[RM: The math behind it]
  //TODO: Add image
]

#slide[
  #heading(numbering: none)[RM: The math behind it]
  #let left = [
    - Relational Schema:
      ```sql
        BOOK
        (ISBN,
        title,
        author,
        publisher,
        year,
        price)
      ```
  ]
  #let right = [
    - Relational Schema with types:
      ```sql
        BOOK
        (ISBN: integer,
        title: string,
        author: string,
        publisher: string,
        year: integer,
        price: real)
      ```
  ]
  #grid(
    columns: (auto, auto),
    gutter: 0.25em,
    left, right,
  )
  #sym.arrow Relation `BOOK` is of degree six.
]

#slide[
  #heading(numbering: none)[RM: The math behind it]
  //TODO: Continue here with page 126
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
