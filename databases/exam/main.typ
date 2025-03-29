
#import "@preview/grape-suite:2.0.0": exercise, colors
#import "@preview/gentle-clues:1.0.0": *
#import exercise: project, task, subtask
#import colors: *

#import "@preview/codly:1.0.0": *
#show: codly-init.with()


#codly(
  languages: (
    java: (
      name: text(font: "JetBrainsMono NFM", " Java", weight: "bold"), icon: text(font: "JetBrainsMono NFM", "\u{e738}", weight: "bold"), color: rgb("#CE412B"),
    ), c: (
      name: text(font: "JetBrainsMono NFM", " C", weight: "bold"), icon: text(font: "JetBrainsMono NFM", "\u{e61e}", weight: "bold"), color: rgb("#5612EC"),
    ),
    sql: (
      name: text(font: "JetBrainsMono NFM", " SQL", weight: "bold"),
      icon: text(font: "JetBrainsMono NFM", "\u{e76e}", weight: "bold"),
      color: rgb("#2563eb"),
    ),
  ),
)

#show: project.with(
    type: [Exam],
    suffix-title: [Databases],

    show-point-distribution-in-tasks: true,
    show-namefield: true,
    show-timefield: true,

    max-time: 90,
    show-lines: true,

    show-solutions: true,
    solutions-as-matrix: true,

    university: [HAW Hamburg],
    institute: [HAW - TI IE4],
    seminar: [Databases],

    task-type: [Tasks],
    extra-task-type: [Extra tasks],

    solution-matrix-task-header: [Task],
    solution-matrix-achieved-points-header: [Achieved Points],

    distribution-header-point-value: [Points],
    distribution-header-point-grade: [Value],

    message: (points-sum, extrapoints-sum) => [In total, you can achieve #points-sum + #extrapoints-sum points. You have achieved #box(line(stroke: purple, length: 1cm)) P. of #points-sum points.],

    solutions-title: [Suggestion for the Solution],
    timefield: (time) => [Time: #time min.],

    grade-scale: (([A], 0.9), ([B], 0.8), ([C], 0.7), ([D], 0.6), ([E], 0.51), ([F], 0.50))
)

#set heading(numbering: none)

#task(points: 40, [
  Film Festival Management System
],
[
- *Context*: Design a system to manage an international film festival with multiple venues, screenings, films, directors, actors, and ticket sales.

- *Requirements*:
  1. Track films with attributes including title, release year, country, language, genre, and runtime
  2. Associate films with directors, producers, and cast members
  3. Manage multiple festival venues with different seating capacities
  4. Schedule film screenings across venues with no conflicts
  5. Handle ticket reservations and sales with different pricing tiers
  6. Track festival attendees and their ticket purchases
  7. Generate reports on attendance, popularity, and revenue

- *Deliverables*: Complete ERD with all entities, relationships, cardinalities, and a normalized relational schema\
  #box(height: 60%, width: 100%, stroke: color.black)[]
], [], ())

#task(
  [
    Normalization
  ],
  [
    Consider the following schema:
    ```sql
CREATE TABLE bookstore (
    order_id INT,
    order_date DATE,
    customer_id INT,
    customer_name VARCHAR(100),
    customer_email VARCHAR(100),
    customer_address TEXT,
    customer_phone VARCHAR(20),
    book_id INT,
    book_title VARCHAR(200),
    book_author VARCHAR(100),
    book_publisher VARCHAR(100),
    book_isbn VARCHAR(20),
    book_category VARCHAR(50),
    book_price DECIMAL(10, 2),
    quantity INT,
    payment_method VARCHAR(50),
    card_number VARCHAR(20),
    card_expiry VARCHAR(7),
    shipping_method VARCHAR(50),
    shipping_cost DECIMAL(10, 2),
    discount_code VARCHAR(20),
    discount_percentage DECIMAL(5, 2),
    PRIMARY KEY (order_id, book_id)
);
    ```
  #v(80%)
], [
  #subtask(points: 4)[
    Describe what the type of data the schema contains and what the context of the schema most likely is. Give an example for both aspects.\
    #box(height: 40%, width: 100%, stroke: color.black)[]
  ]
  #subtask(points: 4)[
    What is the problem with this schema? What kinds of issues does this type of schema have? How would you try to combat that? Give an example for an improvement!\
    #box(height: 47%, width: 100%, stroke: color.black)[]
  ]
  #subtask(points: 22)[
    Improve the schema! Explain your decisions and implement at least 3 improvements for the schema in SQL.\
    #box(height: 90%, width: 100%, stroke: color.black)[]
  ]
  ], (
  (
    4, 
    [
      1. Book data: Title, Publisher, Author
      2. Discount data: Code, Percentage
      3. Customer data: Name, Email, Address
      4. Shipping data: Costs, Method
    ]
  ),
  (
    4, 
    [
      1. Data Redundancy: Customer information is repeated for each book in an order
      2. Update Anomalies: Changing a customer's address requires updating multiple rows
      3. Insertion Anomalies: Cannot add a book without an order
      4. Deletion Anomalies: Deleting an order could lose book information
    ]
  ),
  (
    22, 
    [
      1. Data Redundancy: Customer information is repeated for each book in an order
      2. Update Anomalies: Changing a customer's address requires updating multiple rows
      3. Insertion Anomalies: Cannot add a book without an order
      4. Deletion Anomalies: Deleting an order could lose book information
    ]
  ),
)
)

#task(points: 10, [General Terms of Databases], [
    Explain the following five terms that we encountered during the lecture in 2-3 sentences and give an example for each:
    - Normalization
    - Transaction
    - ACID
    - Selection
    - Projection\
  #box(height: 75%, width: 100%, stroke: color.black)[]
], [], (
    (2, [Normalization is the systematic process of organizing database tables to minimize redundancy and dependency by dividing larger tables into smaller ones and defining relationships between them. It involves applying a series of rules (normal forms) that progressively eliminate anomalies and ensure data integrity.]),
    (2, [A transaction is a logical unit of work that contains one or more database operations (read, write, update, delete) which must be executed as a single atomic entity. Transactions ensure that the database remains in a consistent state by either committing all operations if successful or rolling back all changes if any operation fails.]),
    (2, [ACID is an acronym representing the four essential properties that guarantee reliable processing of database transactions: Atomicity (all operations complete or none do), Consistency (data remains valid according to defined rules), Isolation (concurrent transactions don't interfere), and Durability (committed changes survive system failures). These properties collectively ensure database integrity even during system failures, concurrent access, and other potential disruptions.]),
    (2, [Selection is a relational algebra operation that produces a horizontal subset of a relation by filtering rows based on a specified condition. It returns only those tuples from a relation that satisfy the given predicate, maintaining the original schema while reducing the number of records.]),
    (2, [Projection is a relational algebra operation that creates a vertical subset of a relation by extracting specified columns and eliminating duplicates. It reduces the number of attributes in the result set while preserving all distinct rows based on the selected columns.]),
))

#task(points: 16, [True or False], [
  For the following statements, decide whether each one is true or false and make a cross or checkmark in the respective column. For any correct answer, your point total will be increased by 2 points. For any wrong answer, your point total will be reduced by 2 points. You can receive negative points for this problem!

#table(
  columns: (auto, auto, auto),
  inset: 10pt,
  align: horizon,
  table.header(
    [*Statement*], [*True*], [*False*],
  ),
    [The SQL keyword `HAVING` is used to filter records before they are grouped by the `GROUP BY` clause.], [], [],
    [Denormalization is always a poor design choice as it introduces data redundancy.], [], [],
    [The ACID properties (Atomicity, Collaboration, Iteration, Durability) are primarily relevant to transactions in databases because they describe how transactions are supposed to be.], [], [],
    [In an Entity-Relationship Diagram, a weak entity can exist independently of its identifying relationship.], [], [],
    [A relation is in Third Normal Form (3NF) if it is in Second Normal Form (2NF) and no non-prime attribute is transitively dependent on the primary key.], [], [],
    [A composite primary key can never contain a foreign key as one of its components.], [], [],
    [Database indexes always improve query performance regardless of the database size or query patterns.], [], [], 
    [In PostgreSQL, a materialized view stores the query results physically and must be manually refreshed to update its data.], [], []
)
], [], (
    (2, [False]),
    (2, [False]),
    (2, [False]),
    (2, [True]),
    (2, [False]),
    (2, [False]),
    (2, [True]),
))
#v(80%)

#task([University Management System Database Project],
[
== Project Overview
Please design and implement a complete database system for university management, covering academic, administrative, and operational aspects. The project is divided into three sequential stages: 
  1. Conceptual Design (ERD), 
  2. Logical Design (RM), and 
  3. Physical Implementation (SQL).
], 
  [
    #subtask(points: 20)[
=== Stage: Entity-Relationship Diagram (ERD) Design
==== Task Description
Design a comprehensive Entity-Relationship Diagram for a university management system. Your ERD must capture all significant entities, relationships, attributes, cardinalities, and constraints necessary for managing academic programs, student records, faculty, courses, registration, facilities, and departmental administration.

==== Requirements
- Identify all relevant entities with appropriate attributes
- Define meaningful relationships with proper cardinalities
- Specify primary keys and foreign keys
- Include derived attributes where appropriate
- Identify weak entities if necessary
- Document any assumptions made during the design process
- Use proper ERD notation (Chen, Crow's Foot, or UML)\
    #v(80%)
  #box(height: 100%, width: 100%, stroke: color.black)[]
  ]
  #subtask(points: 20)[
=== Stage: Relational Model (RM) Design
==== Task Description
Transform your ERD into a complete Relational Model. For each entity in your ERD, define a corresponding relation with attributes, primary keys, foreign keys, and any additional constraints. Ensure your design is properly normalized (at least to 3NF) and document any denormalization decisions if applicable.

==== Requirements
- Transform all entities and relationships into appropriate tables
- Properly handle many-to-many relationships with junction tables
- Define all primary keys, foreign keys, and constraints
- Specify attribute domains and data types
- Document functional dependencies
- Ensure the design is normalized to at least 3NF
- Explain any denormalization decisions with justification\

  #box(height: 65%, width: 100%, stroke: color.black)[]
  ]
  #subtask(points: 20)[
  === Stage: SQL Implementation
==== Task Description
Implement your relational model as a PostgreSQL database. Write the SQL statements to create all tables with appropriate constraints, and populate them with sample data. Then, write SQL queries to demonstrate the functionality of your database for common university management operations.

==== Requirements:
- Create DDL statements for all tables with proper constraints
- Include foreign key constraints with appropriate actions (`CASCADE`, `SET NULL`, etc.)
- Develop SQL queries for common operations like:
  - Course registration
  - Grade reporting
  - Faculty teaching assignments
  - Room scheduling
  - Student transcript generation
  - Department budget analysis\
  #box(height: 60%, width: 100%, stroke: color.black)[]
  ]
  ])

