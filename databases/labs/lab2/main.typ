#import "@preview/grape-suite:2.0.0": exercise, german-dates
#import "@preview/gentle-clues:1.2.0": *

#set text(lang: "en")

#import "@preview/codly:1.0.0": *
#show: codly-init.with()

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
      color: rgb("#7c3aed"),
    ),
  ),
)

#let is_solution = true


#show: exercise.project.with(
  title: "Databases Lab 02",
  university: [HAW Hamburg],
  institute: [TI IE4],
  seminar: [DBL],
  abstract: [
    This is the second lab of Databases. Here you will learn the basics of database design using the ERD (Entity-Relationship-Diagram) and the RM (Relational Model).
  ],
  show-outline: true,
  author: "Emily Antosch",
  show-solutions: false,
)

= Assignment 1: Student Information System

A university wants to store information about its students and their courses in a database. The following requirements have been identified:

The university offers one or more study programs. Every study program has a program id, a name, and the required credit points to finish it.
A study program is made up of one or more courses. A course belongs to exactly one study program and has a course id, a name, a description, semester hours and credit points. A course can have none, one or more other courses as a prerequisite.
A student has a student id, first name, last name, date of birth and a year of enrollment. A student is enrolled in exactly one study program.
A student attempts courses, that are part of his/her study program. If a student attempts a course the year and term (summer or winter semester) and grade (between 0 and 15 points) are recorded.
1. Create an Entity-Relationship-Diagram in Chen notation according to these requirements. Add attributes where necessary. Take special care that you identify the entity types, relationship types, and key attributes.
2. Draw an Entity-Relationship-Diagram in MC notation.
3. Name two semantic integrity requirements, which make sense for the described model, but cannot be described in the Entity-Relationship-Diagram (e.g., a student cannot attempt a course he/she has already passed).
4. Can you think of adding some additional composite, multivalued, or derived attributes in this example?

#if is_solution [
  #conclusion(title: [Solution])[
    #figure(image("../../assets/img/labs/20250401_lab2_sol_sis_rev01.png"))
  ]
  /*
    #canvas({
      import draw: *
      rect((0, 0), (2, 1), anchor: "west", name: "student")
      circle((0, 0), name: "studentID", radius: (30pt, 15pt), anchor: "east")
      line((name: "student", anchor: "west"), (name: "studentID", anchor: "east"))
      circle((0, 2), name: "FirstName", radius: (30pt, 15pt), anchor: "east")
      line((name: "student", anchor: "west"), (name: "FirstName", anchor: "east"))
      content((name: "student"), [Student])
      content((name: "FirstName"), [first_name])
      content((name: "studentID"), [studentID])
    })
  */
]

= Assignment 2: ERD for an Online Shopping Platform

The following entity-relationship-diagram is given. Assume that the database is filled with data according to the ERM. Decide whether the following statements are either true (T), false (F), or undecidable/maybe (U). "U" is used for statements that can be either T or F depending on the stored data. Evaluate the statements based exclusively on the ERM and the restrictions it contains.

#figure(image("../../assets/img/labs/2024_11_14_lab01_erd_shopping_rev01.png"))

#table(
  columns: (auto, auto, auto),
  inset: 0.5em,
  [*Number*], [*Statement*], [*Answer*],
  [01], [A customer can have multiple shopping carts.], [],
  [02], [A product can be included in multiple orders.], [],
  [03], [Each shopping cart is associated with a specific order.], [],
  [04], [An order can at most contain only one product.], [],
  [05], [A customer can place multiple orders.], [],
  [06], [Each order has a unique order number.], [],
  [07], [Each order must be associated with a customer.], [],
  [08], [A customer can place an order without a shopping cart.], [],
  [09], [There are some customers who have placed more then ten orders.], [],
  [10], [Every product can be contained several times in the same order.], [],
  [11], [A product can be uniquely identified by the combination of the Product name and Product ID.], [],
)

#if is_solution [
  #conclusion(title: [Solution])[
    #table(
      columns: (auto, auto, auto),
      inset: 0.5em,
      [*Number*], [*Statement*], [*Answer*],
      [01], [A customer can have multiple shopping carts.], [F],
      [02], [A product can be included in multiple orders.], [T],
      [03], [Each shopping cart is associated with a specific order.], [U],
      [04], [An order can at most contain only one product.], [F],
      [05], [A customer can place multiple orders.], [T],
      [06], [Each order has a unique order number.], [T],
      [07], [Each order must be associated with a customer.], [T],
      [08], [A customer can place an order without a shopping cart.], [U],
      [09], [There are some customers who have placed more then ten orders.], [U],
      [10], [Every product can be contained several times in the same order.], [T],
      [11], [A product can be uniquely identified by the combination of the Product name and Product ID.], [T],
    )
  ]
]

= Assignment 3 ERD for a Technology Support Company
A technology company is developing a support ticket management system to handle customer complaints efficiently and track the support staff's work. The system must store information about support requests, customers, support staff and their interactions.
1. Create an entity-relationship-diagram in Chen notation according to these requirements. Add attributes where necessary. Take special care that you identify the entity types, relationship types, and key attributes.
2. Can you think of adding some additional composite, multivalued, or derived attributes in this example?
3. How does the ERM looks like in MC notation?
4. Convert the ERD into a relational schema.

#if is_solution [
  #conclusion(title: [Solution])[
    #figure(image("../../assets/img/labs/20250217_erm_service_chen_rev01.png"))

  ]
  #conclusion(title: [Solution])[
    #figure(image("../../assets/img/labs/20250217_erm_service_mcchen_rev01.png"))
  ]
  #conclusion(title: [Solution])[
    *CUSTOMER*(#underline[CustomerID] (PK), name, joinDate)\
    *REQUESTS*(#underline[RequestID] (PK), CustomerID (FK), topic)\
    *SUPPORT STAFF*(#underline[SupportStaffID] (PK), supportLevel, name)\
    *CALLS*(#underline[CallID] (PK), time, RequestID (FK), CustomerID (FK))\
    #figure(image("../../assets/img/labs/20250401_chen_tech_requests_rev01.png", height: 69%))
  ]
]



= Assignment 4 – RM for Favorite Books
Transform given the ERD to an equivalent relational model.
#figure(image("../../assets/img/labs/2024_11_14_lab01_erd_favorite_books_rev01.png"))

#if is_solution [
  #conclusion(title: [Solution])[
    *BOOK*(#underline[BookID], title, author, ISBNID (FK), GenreID (FK))\
    *GENRE*(#underline[GenreID] (PK), name)\
    *ISBN*(#underline[ISBNID] (PK), no, registerDate)\
    *READER*(#underline[ReaderID] (PK), GenreID (FK), name)\
    *READERFOLLOWSREADER*(#underline[ReaderOneID] (FK), #underline[ReaderTwoID] (FK))\
    #figure(image("../../assets/img/labs/20250401_reader_rm_rev01.png"))
  ]
]
