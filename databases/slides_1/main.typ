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
    title: [Databases], subtitle: [Lecture 1 - Organisation and Introduction to Databases], author: [Emily Lucia Antosch], date: datetime.today().display("[day].[month].[year]"), institution: [HAW Hamburg],
  ),
)

#set text(size: 20pt)

#codly(
  languages: (
    sql: (
      name: text(font: "JetBrainsMono NFM", " SQL", weight: "bold"), icon: text(font: "JetBrainsMono NFM", "\u{e76e}", weight: "bold"), color: rgb("#2563eb"),
    ), java: (
      name: text(font: "JetBrainsMono NFM", " Java", weight: "bold"), icon: text(font: "JetBrainsMono NFM", "\u{e738}", weight: "bold"), color: rgb("#CE412B"),
    ), c: (
      name: text(font: "JetBrainsMono NFM", " C", weight: "bold"), icon: text(font: "JetBrainsMono NFM", "\u{e61e}", weight: "bold"), color: rgb("#5612EC"),
    ),
  ),
)

#title-slide(authors: ([Emily Lucia Antosch]))

#outline(depth: 1)

= Organisation

== Where are we right now?

- This is the first chapter of "Databases" in this semester. Welcome!
- Today, we'll be discussing
  - the way this lecture is going to work,
  - what we are going to learn during this semester,
  - and what databases are and why you learning about them!

#slide[
  1. *Introduction*
  2. Basics
  3. SQL
  4. Entity-Relationship-Model
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
  - I want to introduce myself to you and maybe also learn a bit about you!
  - I want to tell you about what is in store for you this semester.
  - We'll also discuss the structure of the course, including assignments and exams.
  - The importance of participation and collaboration in class.
]

== About me
#slide[
  - Emily Lucia Antosch
  - I did my bachelor's degree in Electrical Engineering
  - Software Engineer in the marine industry
  - Looking to start my master degree in the near future
  - Mail: #link("emilylucia.antosch@haw-hamburg.de")
]

== How is this lecture going to work?
#slide[
  //TODO: Add additional parts about how the lectures are going to work
  - I would like to kindly ask you to participate in the lectures ahead, it'll make
    the whole thing more fun.
  - All parts of this course will split into lectures and labs.
  #memo[I would ask you to please let me know if you find that you were not able to
    follow the lecture. I'm more than happy to repeat certain parts.]
]

== Moodle
#slide[
  - Lecture material can be found at: #link("moodle.haw-hamburg.de")
  - Enrollment key: db_2025
  - The slides are also the script.
  - *Thus your notes are essential!*
]

== Labs

#slide[
  //TODO: Add time and date for the teams to be decided
  - Assignments should be worked on in teams
    - Work in fixed teams of two. Division of the teams of two in lab on XXX
    - Working together means discussing things, explaining each other, helping each
      other out
    - Every team member must be ability to explain the solution of each assignment
  - For PVL (precondition for examination):
    - Presence in all laboratories is obligatory!
    In case of illness: Send a sick note and make up the Lab on another date
    - All assignments for the labs must be successfully solved
    - Each student must present at least two assignments on blackboard
]

#slide[
  - Assignments are published before laboratory
  - Each laboratory consists of two parts:
  1. Upfront assignments
    - Submitting the solutions Friday before lab date e.g., solution of lab on
      06.05.2024 must be submitted until 03.05.2024 11:59 p.m. via moodle
      - Only one submission per team of two
      - No re-submission after a laboratory
      - Submit only PDF-files
  2. Live assignments
    - They can be solved in advance or during the Lab
    - Discussion during the laboratory
]

#slide[
  - Each lab requires
    - punctual participation
    - each team member to be able to explain the solution to all upfront assignments

  - You'll receive a yellow card for your first violation of the rules.
  - *In case of a second infringement: Exclusion from exercise!*
  - *Participation of all laboratory dates is mandatory, unexcused absence leads to
    immediate exclusion from the laboratory*
]

== First Lab
#slide[
  //TODO: Check data after dates and plan has been shared
  - Joint lab with all three lab groups
  - Attendance is mandatory!
  - Division of the teams of two to work on the lab assignments
  - Bring your own device *with a working PostgreSQL database*!
  - You do not have to submit solutions in moodle or implement the assignments in
    advance
  - Start time: 8:30 am
  - I strongly recommend that you look at and solve the assignments in advance! This
    will make the laboratory much more effective for you.
]

== Important people in this lecture
#slide[
  //TODO: Add information after talking to all the other lecturers
  - Emily Antosch: Lecture #link("mailto:emilylucia.antosch@haw-hamburg.de")
  - Julian Moldenhauer: Lab group 01 or group 2 #link("mailto:julian.moldenhauer@haw-hamburg.de")
  - Furkan Yildirim: Lab group 01 or group 2 #link("mailto:furkan.yildirim@haw-hamburg.de")
  - Ulrike Herster: Lecture and Lab group 03 #link("mailto:Ulrike.Herster@haw-hamburg.de")
]

== Focus of these lectures
#slide[
  - At the end of this semester, you'll be able to
    - create database systems to effectively store data.
    - design complex databases solutions using Entity-Relationship-Models.
    - secure your database with advanced and modern techniques.
]

== Requirements
#slide[
  #memo[
    You will need an installation of *PostgreSQL 16*.
  ]
  - It's open source software and the main database system that will look at.
  - Depending on your system and how you want to install PostgreSQL, there are
    multiple ways to go about it. There are detailed descriptions in the Moodle-Room
    for you to follow.
  - It's totally up to you, but I would suggest you also download pgAdmin4, because
    it allows you to use an UI to interact with your database. pgAdmin4 is also
    free.
]

== Who are you?
#slide[
  #question[
    - Do you already have experience regarding databases?
    - What is the expectation of this lecture?
    - Do you have any wishes regarding the lecture and potentially also the exam?
  ]
]

= Introduction to Databases

== Where are we right now?
#slide[
  - You just learnt how this lecture is going to work and what you can expect going
    forward.
  - Next, we'll be discussing the basics of databases and the differences to
    database management systems.
  - We'll learn about the history of databases.
  - And we'll find out, why we should be using databases in the first place.
]

#slide[
  1. Introduction
  2. *Basics*
  3. SQL
  4. Entity-Relationship-Model
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
  - Today, we'll be discussing
    - what databases are and why you learning about them,
    - the history of databases,
    - and the differences between databases and database management systems.
]

== What is a Database?
#slide[
  #memo[
    - A *database* refers to a set of data and how it it organized.
    - Access is granted via a *database management system* (DBMS) consisting of
      integrated software that allows for interaction with one or databases and
      provides access to the data.
    - Supports storage, manipulation, and querying of information.
  ]
]

== What is a Database Management System (DBMS)?
#slide[
  - Software system that manages databases.
  - A DBMS provides a systematic approach of creating, updating, storing and
    retrieving data stored in a database.
  - It enables the end user and programmers to share data, and it allows for data to
    be shared among multiple applications.
  - It eliminates the need for data to be stored in new files and being propagated.
]

#slide[
  The essential functions of a DBMS:

  - Storing, changing, and deleting data
  - Managing metadata (data about the data)
  - Keeping your data safe and secure
  - Making sure your data is correct and consistent
  - Allowing multiple users to work with the data at the same time (transactions)
  - Optimizing queries (finding the fastest way to get the data you need)
  - Enabling triggers (automatic actions when certain events happen) and stored
    procedures (pre-written SQL code)
  - Providing key metrics about the DBMS technology and how it's running
]

== In essence: DB vs DBMS
#slide[
  #let body = [
    #heading(numbering: none)[In Essence]
    - A database manages data logically and physically
    - A DBMS offers tools for managing, editing and evaluating data

    #heading(numbering: none)[Database Examples]
    - Customer Relationship Management (CRM) (keeping track of your customers)
    - Controlling and Accounting (managing your finances)
    - Merchandise Management System (organizing your products)
    - Enterprise Resource Planning (ERP) (managing your entire business e.g. SAP)
    - Content Management Systems (CMS) (managing your website content e.g. WordPress)
  ]
  #let fig = figure(image("../assets/img/slides_01/2024_12_31_s1_rdmbs_db_rev01.png"))
  #grid(columns: (70%, 30%), gutter: 0.5em, body, fig)
]

== Difference between data and information
#slide[
  #let data = [
    #heading(numbering: none)[Data]
    - Data is raw, uncategorised facts such as numbers, text or images.
    - More often than not, data does not make sense on its own and requires some form
      of context.
  ]
  #let information = [
    #heading(numbering: none)[Information]
    - Information is born when data is given context, meaning and/or relevance.
    - Information is able to actively serve us by providing insight in how decisions
      should be made.
  ]
  #grid(columns: (auto, auto), gutter: 0.5em, data, information)
  #figure(image("../assets/img/slides_01/2025_01_19_data_vs_info_rev01.png"))
]

== History of the Database
#slide[
  - In the 1960s, people used files to store data. This wasn't ideal because files
    are designed for specific applications, and it was a lot of work to manage them.
  - In the 1970s, Edgar F. Codd, came up with the idea of relational databases.
  - He developed the first relational database system called "System R."
  - Oracle took Codd's ideas and made SQL (Structured Query Language) a big success.
  - IBM followed with their own SQL databases (SQL/DS and DB2).
  - Today, relational databases are the most common type of database.
    #figure(
      image(
        "../assets/img/slides_01/2024_12_31_s1_db_inventor_rev01.png", height: 50%,
      ),
    )
]

== Why even use a DB?
#slide[
  #question[
    - What are the alternatives for storing data?
  ]
  #pause
  #figure(image("../assets/img/slides_01/2025_01_24_data_storage_rev01.png"))
]

#slide[
  Disadvantages of alternatives like text files, Excel, and Access:

  - *Data organization* Can be tricky to structure your data properly.
  - *Data types:* Limited options for different kinds of data.
  - *Large datasets:* Can't handle huge amounts of data efficiently.
  - *Data validation:* Hard to make sure the data is accurate.
  - *Security:* Not very secure.
  - *Performance & querying:* Can be slow to search and get the data you need.
  - *Backup & maintenance:* Can be difficult to back up and maintain your data.
  - *Sharing:* Can be hard to share the data with others.
  - *Performance with large datasets:* Access can struggle with thousands of
    entries.
  - *Concurrency & control features:* Limited ability for multiple users to work
    with the data at the same time.
]

== Database vs. Spreadsheet
#slide[
  - It's easy to accidentally change data in spreadsheets.
  - It's hard to repeat old analyses on new data in spreadsheets.
  - Spreadsheets are slow with large datasets.
  - It's difficult to share huge spreadsheets.
]

== Database vs. Excel: What are they best used for?
#slide[
  #heading(numbering: none)[Databases are good for:]
  - Larger datasets (databases can handle a lot more data than Excel)
  - Organization/structure (databases are stricter about how data is organized)
  - Collaborative work (databases are better for teams working together)
  - Preparing data for analysis in other software

    #heading(numbering: none)[Excel is good for:]
  - Smaller datasets (Excel can slow down with large datasets)
  - Manually entering data
  - Flexible structure (Excel is more forgiving about how data is organized)
  - Creating graphs and visualizations
  - Consistent reports or calculations
  - Built-in spell check and other helpful tools
  - Working independently
]

== Database vs. Excel vs. MS Access
#slide[
  #table(
    columns: (auto, auto, auto, auto, auto), inset: 0.25em, table.header([*Aspect*], [*DB*], [*MS Excel*], [*MS Access*], [*Comment*]), [Initial Training], [], [++], [+], [Initial Training is necessary, since presentation and editing data is separated.], [Large data sets], [++], [], [+], [Access has performance problems starting from several thousand entries.], [Access by multiple Users], [++], [], [+], [Using a database together is easy and works out-of-the-box.], [Database Design], [++], [], [+], [It's way easier to design a data storage solution by profiting off dedicated
      features.], [Platform Independence], [++], [+], [], [While DBMS work on any system, MS products are limited to Windows and MacOS.], [Application Development], [+], [+], [+], [While you can't really develop applications using SQL only, the other two choices aren't preferable either.], [Integration with MS Office], [], [++], [++], [],
  )
]

== Database vs. MS Access: Technical Comparison
#slide[
  #table(
    columns: (auto, auto, auto), inset: 0.25em, table.header([*Aspect*], [*DB*], [*MS Access*]), [Database Size], [16TB], [2GB], [Simultaneous users], [32.767 users], [255 users], [Number of objects], [2.147483.647 objects per database], [32.768 objects per database],
  )
]

== Different DB-Models
#slide[
  There are a number of different database models available. These include:
  - Relational model
  - Hierarchical model
  - Network model
  - Object relational model
  - Object oriented model
  - XML-based model
]

== RDBMS vs. ODBMS
#slide[
  There are (in general) two types of DBMS used in production:
  - RDBMS (Relational Database Management System) stores data in tables with rows
    and columns, kind of like a spreadsheet.
  - ODBMS (Object-Oriented Database Management System) stores data as objects, which
    can be more complex and have their own properties and methods.
]

== Most Popular Databases 2024
#slide[
  #align(
    center + horizon,
  )[
    #figure(
      image(
        "../assets/img/slides_01/2025_01_09_stackoverflow_most_admired_db.png", height: 80%,
      ), caption: [Most admired databases (Source: StackOverflow Developer Survey 2024)],
    )
  ]
]

#slide[
  #align(
    center + horizon,
  )[
    #figure(
      image(
        "../assets/img/slides_01/2025_01_09_stackoverflow_most_popular_db.png", height: 80%,
      ), caption: [Most popular technologies (Source: StackOverflow Developer Survey 2024)],
    )
  ]
]

== Why PostgreSQL
#slide[
  - Why PostgreSQL instead of MySQL, SQLite or Oracle?
    - SQLite is easy but limited in its feature set.
    - Oracle is used in many enterprises, but it's not free.
    - MySQL is also a very valid option, but I like PostgresQL more.
]

== Database Design
#slide[
  To design a database, you typically follow these steps:
  1. *Requirements:* Figure out what you need the database to do.
  2. *Conceptual Database Design:* Come up with a high-level plan for your database
    using an ER Model (Entity-Relationship Model). This is like a rough sketch of
    your database.
  3. *Logical Database Design:* Refine your plan and choose a specific type of
    database (like a relational database). You'll also use a more formal model here,
    like the Relational Model.
  4. *Physical Database Design:* Get into the technical details of how the data will
    be stored and organized.
  5. *Database Implementation:* Build the actual database using SQL (Structured Query
    Language).
]

#slide[
  #figure(image("../assets/img/slides_01/2025_01_18_detail_db_design_rev01.png"))
]

#slide[
  - *Conceptual Design:* A high-level plan for the database. This is where you use
    the ER Model to map out the entities (things) and their relationships.
  - *Logical Design:* A more detailed, formal plan. Here, you use the Relational
    Model to structure the database into tables and relationships.
  - *Implementation & Usage:* Building and using the database. This is where you use
    SQL to create the database and work with the data.
]

#slide[
  #figure(image("../assets/img/slides_01/2025_01_18_db_design_rev01.png"))
]

== Example: Contact List
#slide[
  - *What things exist in the real world?* (e.g., people, houses)
  - *What properties do they have?* (e.g., names, addresses, phone numbers)
  - *How do they relate to each other?* (e.g., people live in houses)
]

#slide[
  #figure(image("../assets/img/slides_01/2025_01_18_database_example_contacts_rev01.png"))
]

#slide[
  *Option 1: Conceptual design with a Class Diagram*
  - You can use a class diagram to model your database conceptually.
  - This involves defining classes (like blueprints) for the things in your database
    (e.g., a Person class, a House class).
  - Each class has properties (attributes) to describe those things (e.g., a Person
    has a name, a House has an address).
  - You also define relationships between the classes (e.g., a Person "lives in" a
    House).

  #figure(image("../assets/img/slides_01/2025_01_18_class_diagram_example_rev01.png"))
]

#slide[
  *Option 2: Conceptual design with ER Model*
  - You can also use an ER Model (Entity-Relationship Model) for the conceptual
    design.
  - This is a more visual way to model your database, where you use boxes to
    represent entities (things) and diamonds to represent relationships between
    them.
  - Each entity has attributes (properties) that describe it.
  - You also indicate how many entities can be related to each other
    (cardinalities).
]

#slide[
  #figure(image("../assets/img/slides_01/2025_01_18_er_diagram_example_rev01.png"))
]


#slide[
  1. *Conceptual design: Class diagram vs. ERM*
    - You can easily translate a class diagram into an ERM.
    - There are a few differences between ERMs and Class Diagrams:
      - ERMs don't have methods (actions).
      - ERMs allow for multivalued attributes (attributes that can have multiple
        values).
]

#slide[
  #figure(image("../assets/img/slides_01/2025_01_18_erm_vs_class_rev01.png"))
]

#slide[ 
  #figure(image("../assets/img/slides_01/2025_01_18_table_definiton_example_rev01.png")) 
]


#slide[
  #figure(image("../assets/img/slides_01/2025_01_18_full_table_overview_rev01.png"))
]


#slide[
  - Creating the tables with the correct columns:
  ```sql
CREATE TABLE Person( SSN  CHAR(9) NOT NULL , FirstName VARCHAR(15) NOT NULL , LastName VARCHAR(15) NOT NULL, Mobile VARCHAR(30), PhoneWork VARCHAR(30), Birthdate DATE, PRIMARY KEY ( SSN )); 
  ```
]

#slide[
  - Selecting data from the database:
  ```sql
SELECT FirstName, LastName FROM Person WHERE LastName = ‘Miller’; 

SELECT FirstName, LastName FROM Person P, lives_in L, House H WHERE Phone = ‘0044 20  7946 0000’ AND H.Address = L.Address AND L.SSN = P.SSN ; 
  ```
]

#slide[
  #question[
    - What are the disadvantages of this approach?
  ]
  #figure(image("../assets/img/slides_01/2025_01_18_denormalized_rev01.png"))
]

#slide[
  - Selecting data from the database:
  ```sql
SELECT FirstName, LastName FROM Person WHERE LastName = ‘Miller’; 

SELECT FirstName, LastName FROM Person P, lives_in L, House H WHERE Phone = ‘0044 20  7946 0000’ AND H.Address = L.Address AND L.SSN = P.SSN ; 
  ```
]

== Development Cycle
#slide[
  #let left = [
1. Design database by logic  
 - What must be in the database? 
2. Design database for system
  - How should the data be saved? 
3. Develop database applications
  - How is the data processed?  
4. Fill database 
  - How to insert the data? 
5. Maintain database
  - the database runs and runs and runs… 
]
  #let right = figure(image("../assets/img/slides_01/2025_02_03_dev_cycle_rev01.png"))

  #grid(columns: (auto, auto), gutter: 0.25em, left, right)
]

#slide[
  #figure(image("../assets/img/slides_01/2025_01_18_dev_process_rev01.png"))
]

== ANSI-SPARC Architecture

#slide[
  #let left = [
- The *external schemas* describe the different external views of the data 
  and there may be many external  schemas for a given database 
- The *conceptual schema* describes all the data items and relationships between them, together with integrity  constraints  
  - There is only one conceptual schema per database 
- The *internal schema* at the lowest level contains definitions of the stored records, the methods of representation, the data fields, and indexes 
  - There is only one internal schema per database 
  ]
  #let right = figure(image("../assets/img/slides_01/"))
]

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

= License Notice

== Attribution

- This work is shared under the CC BY-NC-SA 4.0 License and the respective Public
  License.
- #link("https://creativecommons.org/licenses/by-nc-sa/4.0/")
- This work is based off of the work by Prof. Dr. Ulrike Herster.
- Some of the images and texts, as well as the layout were changed.
- The base material was supplied in private, therefore the link to the source
  cannot be shared with the audience.
