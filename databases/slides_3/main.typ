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
  - A relation (or relational state) $r$ of the relation schema $R(A_1, A_2, ..., A_n$), also denoted by $r(R)$, is a set of $m$-tuples
  #align(center)[
    $r = (t_1, t_2, ..., t_m)$
  ]
  - Each $n$-tuple $t$ is an ordered list of $n$ values $t = <v_1, v_2, ..., v_n>$, where each value $v_1$, $1 lt.eq i lt.eq n$, is an element of $"dom"(A_i)$ or is a special `NULL` value.
  - The $i^"th"$ value in tuple $t$, which corresponds to the attribute $A_i$, is referred to as $t[A_i]$ or $t.A_i$ (or $t[i]$ if we use the positional notation).
]

#slide[
  #heading(numbering: none)[RM: The math behind it]
  #memo[
    - A relation is a set of rows.
      - meaning: no order, no row number
      - no duplicates
  ]
]

#slide[
  #heading(numbering: none)[RM: The math behind it]
  //TODO: Image wechseln
  #figure(image("../assets/img/slides_03/2024_12_31_s1_db_inventor_rev01.png"))
]

#slide[
  #heading(numbering: none)[RM: The math behind it]
  - A relation (or relational state) $r(R)$ is a mathematical relation of degree $n$ on the domains $"dom"(A_1), "dom"(A_2), ..., "dom"(A_n)$, which is a subset of the Cartesian product (denoted by $times$) of the domains that define $R$:
  #align(center)[
    $r(R) subset.eq ("dom"(A_1) times "dom"(A_2) times ... times "dom"(A_n))$
  ]
  - If $|D|$ is the total number of values in a domain $D$, the total number of tuples in the Cartesian product is
  #align(center)[
    $|"dom"(A_1)| times |"dom"(A_2)| times ... times |"dom"(A_n)|$
  ]
]

#slide[
  #heading(numbering: none)[RM: The math behind it]
  - Ordering of tuples
    - A relation is defined as a set of tuples
    - Thus, tuples in a relation do not have any order
    - In a file, records are physically stored on disk and thus have an order

  - Ordering of values within tuples
    - An $n$-tuple is an ordered list of $n$ values, so the ordering of values in a tuple is important
]

#slide[
  #heading(numbering: none)[Relations and Values]
  - Values and `NULL`s in tuples
    - Each value in a tuple is an atomic value.
    - Hence, composite (and multivalued) attributes are not allowed.
    - This model is something called the _flat relational model_.
    #sym.arrow multivalued attributes must be represented by separate relations, and composite
    are represented only by their simple component attributes in the basic relational model
    - `NULL` values are used for values that may be unknown or may not apply to a tuple
  - Relations may represent entity types and relationship types from ERM.
  #figure(image("../assets/img/slides_03/20250224_value_null_tuples_rev01.png"))
]

#slide[
  #heading(numbering: none)[Notation]
  - A relational schema $R$ of degree $n$ is denoted by $R$ $(A_1, A_2, ..., A_n)$
  - The uppercase letters $Q$, $R$, $S$ denote relational names
  - The lowercase letters $q$, $r$, $s$ denote relation states
  - The letters $t$, $u$, $v$ denote tuples
  - In general, the name of a relation schema such as `BOOK` also indicates the current set of tuples in that relation (the current relation state) whereas `STUDENT`(`Name`, `Ssn`, ...) refers only to the relation schema
  - An attribute $A$ can be qualified with the relation's name $R$ to which it belongs by using the dot notation $R.A$ - for example, `BOOK.title`
  - An $n$-tuple $t$ in a relation $r(R)$ is denoted by $t = <v_1, v_2, ..., v_n>$
  - $t[A_i]$ and $t.A_i$ refer to the value $v_i$ in $t$.
  - $t[A_u, A_w, ..., A_z]$ and $t.(A_u, A_w, ..., A_z)$ refer to a subtuple in $t$
]

#slide[
  #heading(numbering: none)[Constraints]
  Three categories
  1. Constraints that are inherent in the data model
  #sym.arrow _inherent model-based constraints or implicit constraints_
  Example: no duplicate tuples in a relation
  2. Constraints that can be directly expressed in schemas of the data model
  #sym.arrow _schema-based constraints or explicit constraints_
  Example: Domain constraints, *key constraints*, constraints on NULL, entity integrity constraints and referential integrity constraints
  3. Constraints that cannot be directly expressed in the schemas of the data model, and hence must be expressed and enforced by the application programs
  #sym.arrow _application-based or semantic constraints or business rules_
]

#slide[
  #heading(numbering: none)[Constraints - Keys]
  #text(size: 24pt)[
    - There are subsets of attributes of a relation schema R with the property that no two tuples in any relation state $r$ of $R$ should have the same combination of values for these attributes $t_1["SK"] eq.not t_2["SK"]$.
    - Any such set of attributes SK is called a super key of a relation #sym.arrow A super key specifies a uniqueness constraint.
    - A minimal super key, that is, a superkey from which we cannot remove any attributes and still have the uniqueness constraint in condition 1 hold, is called candidate key.
    - For every relation, one of the candidate keys is chosen as the primary key of the relation
  ]
]

#slide[
  #heading(numbering: none)[Constraints - Key Attributes]
  #let left = [
    #text(size: 24pt)[
      - *Super Key*: An attribute or a set of attributes that uniquely identifies a tuple within a relation.
      - *Candidate Key (CK)*: A super key, so that no proper subset is a super key within the relationship.
      - *Primary Key (PK)*: The candidate key that is selected to identify tuples uniquely within the relation; The candidate keys which are not selected as PKs are called "Alternate Keys".
    ]
  ]
  #let right = [
    #figure(image("../assets/img/slides_03/20250224_sk_ck_pk_rev01.png"))
  ]
  #grid(
    columns: (auto, 40%),
    gutter: 0.25em,
    left, right,
  )
]

#slide[
  #heading(numbering: none)[Constraints - Key Attributes]
  - Primary Key
    - Also called _Entity Integrity Constraint_
    - PK values must be unique and cannot be `NULL`!
    - Notation: #underline()[underlined]
  #figure(image("../assets/img/slides_03/20250224_isbn_example_rev01.png"))
]

#slide[
  #heading(numbering: none)[Constraints - Artificial Keys]
  #text(size: 24pt)[
    - PNo is an example for an artificial key
    - Also called: surrogate key, technical key
    - Key is an attribute not natural for the entity
    - Many RDBMS offer identity/serial data types:
      - Number
      - Automatically inserted values
      - Values taken from sequences
    - In most cases, business keys are needed, too!
      - A business key is a natural key, i.e., something unique about each tuple
      - Artificial key should be no excuse for not defining unique attributes!
    - Artificial Keys may evolve to business keys
      - ISBN, Social Security Number / Passport Number
  ]
]

#slide[
  #heading(numbering: none)[Database Design]
  #figure(image("../assets/img/slides_03/20250224_impl_rev01.png"))
]

#slide[
  #heading(numbering: none)[Physical Database Design]
  - Physical Database Design
    - The primary goal of physical database design is data processing efficiency (as costs for computer technology are decreasing).
    - Implementation of the logical database design in a concrete schema by using SQL including the relational database schema and external views.
]

#slide[
  #heading(numbering: none)[Codd's Twelve Rules]
  #let left = [
    - Define the criteria for a DBMS to be a relational DBMS (RDBMS)
    - Very strict (maybe too strict?)
    - None of the popular DBMS fulfils all rules
      - Especially rules 6, 9, 10, 11, and 12 are difficult to fulfill
      - Therefore, many manufacturers describe their database as relational if it meets only some of the most important criteria
  ]
  #let right = [
    #figure(image("../assets/img/slides_03/2024_12_31_s1_db_inventor_rev01.png"))
  ]
  #grid(
    columns: (auto, auto),
    gutter: 0.25em,
    left, right,
  )
]

#slide[
  #heading(numbering: none)[Codd's Twelve Rules]
  #figure(image("../assets/img/slides_03/20250224_rules_db_design_rev01.png"))
]


#slide[
  #heading(numbering: none)[SQL History]
  - SQL may commercial be considered one of the major reasons
  for the commercial success relational databases
  - SEQUEL: In 1981, SEQUEL was designed and implemented at IBM Research as the interface
  for an experimental relational database system called SYSTEM R
  - SQL-86 or SQL1: developed by ANSI and ISO
    - Standardized data types, query syntax
    - `BOOLEAN`, structured types (classes), recursive queries, ...
  - SQL-92 or SQL2
    - `BLOBS`, `VARCHAR`, `DATE`, `TIME`, `TIMESTAMP`
    - consistence checks
    - modifications of data structures
]

#slide[
  #heading(numbering: none)[SQL History]
  - SQL-1999 or SQL3
    - User defined types, object concepts (analogues to classes,…)
  - SQL:2003
    - Java: SQLJ + JDBC
    - Stored Procedures (PSM)
    - sequence generator, auto-generated values, MERGE
  - SQL-2008
    - SQL:2008: `TRUNCATE TABLE`, XML/XQuery support,...
  - SQL:2011
    - improved support for temporal databases, Roles, OLAP-Supporting
    - requests: `ROLLUP`, `GROUPING SETS`, `CUBE`
]

#slide[
  #heading(numbering: none)[SQL Basics]
  - SQL has facilities for
    - Defining views on the database
    - Specifying security and authorization
    - Defining integrity constraints
    - Specifying transaction controls
  - It also has rules for embedding SQL statements into a general-purpose programming
  language such as Java, COBOL, or C/C++
]



#slide[
  #heading(numbering: none)[SQL Basics]
  - Interactive
    - SQL*PLUS, psql, ... GUI: sqldeveloper, pgadmin, squirrel SQL...
  - Embedded SQL
    - SQL commands embedded in 3GL (C, Java)
    - Native libraries (vendor specific)
  - ODBC (Open Database Connectivity)
    - very popular in MS Windows
    - but can be used under Unix, too
  - JDBC (Java Database Connectivity)
    - Part of the standard Java API
]

#slide[
  #heading(numbering: none)[SQL Basics - SQL commands]
  #let left = [
    ```sql
      CREATE VIEW
      DROP VIEW
    ```
    ```sql
      CREATE database
      DROP database
      OPEN database
    ```
    ```sql
      CREATE domain
      DROP domain
      OPEN domain
    ```
  ]
  #let right = [
    #figure(image("../assets/img/slides_03/20250224_conceptual_schema_rev01.png", height: 90%))
  ]
  #grid(
    columns: (auto, auto),
    gutter: 0.25em,
    left, right,
  )
]

#slide[
  #heading(numbering: none)[SQL Basics]
  - SQL Keywords: case insensitive
  - Convention: Upper Case (e.g., `SELECT`, `UPDATE`)
  - Commands end with ;
  (when entered interactively)
  - Comments:
    - line comment: −− this is a comment
    - multiline comment: ```/* comment */```
]

#slide[
  #heading(numbering: none)[SQL Basics]
  #figure(image("../assets/img/slides_03/20250224_relational_sql_rev01.png"))
]

#slide[
  #heading(numbering: none)[SQL Basics]
  - Syntax Definition: BNF (Backus-Naur Form)
  #figure(image("../assets/img/slides_03/20250224_symbol_semantics_rev01.png"))
]

#slide[
  #heading(numbering: none)[SQL Basics]
  - Syntax Definition: BNF (Backus-Naur Form)
  #figure(image("../assets/img/slides_03/20250224_digit_hexit_rev01.png"))
]

#slide[
  #heading(numbering: none)[Create Schema]
  - A schema
    - groups together tables and other constructs that belong to the same database application
    - is identified by a schema name
    - includes an authorization identifier and descriptors for each element
  - A schema is essentially a namespace
  - Schema elements include tables, constraints, views, domains, and other constructs (such as authorization grants) that describe the schema
]

#slide[
  #heading(numbering: none)[Create Schema]
  - Syntax:
    ```sql
    CREATE [ OR REPLACE ]
    { DATABASE | SCHEMA }
    [ IF NOT EXISTS ]
    db_name
    [ create_specification ] ...
    ```
  - Example:
  ```sql
  CREATE SCHEMA COMPANY;
  ```
  - Attention: User must be authorized to create schema and schema elements
]

#slide[
  #heading(numbering: none)[Create Table]
  - A new relation with a name, its attributes and initial constraints
  - Each attribute is defined by a name, a data type and constraints (e.g., `NOT NULL`)
  - Following the attributes, the primary key, entity integrity, and referential integrity constraint can be specified(alternatively, they can be specified with `ALTER TABLE`)
  - All relations created by `CREATE TABLE` are called base tables, i.e., the relation and its tuples are created and stored as a file by the DBMS
]

#slide[
  #heading(numbering: none)[Create Table]
  - Syntax for creating an empty table:
    ```sql
    CREATE TABLE <relationname>
    (<column> <type> [ DEFAULT expr]
    [ [NOT] NULL ] [ colconstraint ] *
    [,{<column> <type> [ DEFAULT expr ]
    [ [NOT] NULL ] [ colconstraint ] *
    | <tableconstraint> } ] *
    );
    ```
]

#slide[
  #heading(numbering: none)[Mapping of ERM to Relational Model]
  #text(size: 22pt)[
    Seven steps are involved in mapping the ERM to the RM:
    1. Mapping of regular entity types
    2. Mapping of weak entity types
    3. Mapping of binary 1:1 relationships
    4. Mapping of binary 1:n relationships
    5. Mapping of binary m:n relationships
    6. Mapping of multivalued attributes
    7. Mapping of n-ary relationships
    #info[
      We will only look at step 1 here!
    ]

  ]
]

#slide[
  #heading(numbering: none)[Mapping: Step 1]
  - For each regular (strong) entity type $E$ in the ER schema, create a relation $R$ that includes all the simple attributes of $E$
  - Include only the simple component attributes of a composite attribute
  - Choose one of the key attributes of $E$ as the primary key for $R$
  - If the chosen key of $E$ is a composite, then the set of simple attributes that form it will together form the primary key of $R$
]

#slide[
  #heading(numbering: none)[Mapping: Step 1]
  #figure(image("../assets/img/slides_03/20250226_mapping_1_rev01.png"))
]

#slide[
  #heading(numbering: none)[Mapping: Step 1]
  #example[
    ```sql
    CREATE TABLE COMPANY.Employee ... ;
    or
    USE DATABASE COMPANY ;
    CREATE TABLE Employee ... ;
    ```
  ]
]

#slide[
  #heading(numbering: none)[Create Table `EMP`]
  #figure(image("../assets/img/slides_03/20250226_emp_table_creation_rev01.png"))
]


#slide[
  #heading(numbering: none)[Data Types: Overview]
  - Numeric
  - Strings
  - Temporal
  - SQL-99: `CLOB`, `BLOB`, `BOOLEAN`
]



#slide[
  #heading(numbering: none)[Data Types: Numeric]
  - Numeric
    - Integer: ```sql INTEGER``` or ```sql INT```, ```sql SMALLINT```, ```sql BIGINT```
    - Floating-point: ```sql FLOAT``` or ```sql REAL```, ```sql DOUBLE PRECISION```
  - Formatted numbers: `DECIMAL(i,j)` or `NUMERIC(i,j)` where
  - `i` #sym.arrow precision (total number of decimal digits)
  - `j` #sym.arrow (digits after the decimal point)
  - Example:
    - `DECIMAL` (10,2) : values up to 99,999,999.99
    - `NUMERIC` (9,2) : 1746352.32
    - `NUMERIC` (6) : not possible
]


#slide[
  #heading(numbering: none)[Data Types: Character]
  - Fixed length:
    - `CHARACTER(n)` or `CHAR(n)`
    - fills up with spaces if not full length is used
  - Variable length:
    - CHARACTER `VARYING(n)` or `CHAR VARYING(n)` or `VARCHAR(n)`
    - Oracle: `VARCHAR2(n)`
    - Example: `VARCHAR(15)`
  - Value is placed between apostrophes, e.g., ‘abc’
  - `CHARACTER SET` / `CHARSET` has to be defined or standard charset of DBMS is used → e.g., `UNICODE UTF-8`
]

#slide[
  #heading(numbering: none)[Data Types: Date and Time]
  - `DATE` (10 positions): `YYYY‐MM‐DD`
  - `TIME` (8 positons): `HH:MM:SS`
  - `DATETIME`: `YYYY‐MM‐DD HH:MM:SS`
  - `TIMESTAMP`: `YYYY‐MM‐DD HH:MM:SS.ssssss`
  - Example:
  ```sql
    DATE ‘2008‐09‐27’
    TIME ‘09:12:47’
    TIMESTAMP [(precision)] [WITH TIME ZONE]
  ```
]

#slide[
  #heading(numbering: none)[Data Types: Additional]
  - `CLOB`: Character Large Object
    - Very long texts
    - in KB, MB, GB
  - `BLOB`: Binary Large Object
    - Long Binary Data (e.g, pictures, video)
  - `BOOLEAN`
]

#slide[
  #heading(numbering: none)[Data Types: Additional]
  #figure(image("../assets/img/slides_03/20250226_sqlserver_oracle_types_rev01.png"))
]

#slide[
  #heading(numbering: none)[Primary Keys]
  - PK identifies every tuple uniquely
  - Entity Integrity
  - One PK for each table
  - PK is (implicit)
    - `NOT NULL`
    - `UNIQUE` (no duplicates)
]

#slide[
  #heading(numbering: none)[Constraint Syntax]
  - As Column Constraint(Only if the primary key is one single attribute (not combined)):
  ```sql
  [ CONSTRAINT <constraintname> ] PRIMARY KEY
  ```
  - As Table Constraint:
    ```sql
    [ CONSTRAINT <constraintname>] PRIMARY KEY
    ( <column>[ , <column>] * )
    ```
]


#slide[
  #heading(numbering: none)[Column Constraint Example]
  Example Column Constraint:

  ```sql
  CREATE TABLE Department
  (
    Dname VARCHAR(15) NOT NULL,
    Dnumber INT PRIMARY KEY,
    Mgr_ssn CHAR(9) NOT NULL,
    Mgr_start_date DATE
  );
  ```
]

#slide[
  #heading(numbering: none)[Table Constraint Example]
  Example Table Constraint:
  ```sql
  CREATE TABLE Department
  (
    Dname VARCHAR(15) NOT NULL,
    Dnumber INT NOT NULL,
    Mgr_ssn CHAR(9) NOT NULL,
    Mgr_start_date DATE,
    PRIMARY KEY ( Dnumber )
  );
  ```

]

== Homework
#slide[
  #heading(numbering: none)[Company Example]
  #text(size: 24pt)[
    - Create for every entity type with its attributes a relation in your DB
    - Insert some sample data in the relations
    - Write some queries to retrieve the data, e.g.,
      - Get all female employees
      - Get all projects located in Hamburg
    - Think about your own, individual example (e.g. contact list)
      - Create for every entity type with its attributes a relation in your DB
      - Insert some sample data in the relations
      - Write some queries to retrieve the data
  ]
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
