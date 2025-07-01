
#import "@preview/grape-suite:2.0.0": exercise, colors
#import "@preview/gentle-clues:1.0.0": *
#import exercise: project, task, subtask
#import colors: *

#import "@preview/codly:1.0.0": *
#show: codly-init.with()


#codly(
  languages: (
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

  message: (
    points-sum,
    extrapoints-sum,
  ) => [In total, you can achieve #points-sum + #extrapoints-sum points. You have achieved #box(line(stroke: purple, length: 1cm)) P. of #points-sum points.],

  solutions-title: [Suggestion for the Solution],
  timefield: time => [Time: #time min.],

  grade-scale: (([A], 0.9), ([B], 0.8), ([C], 0.7), ([D], 0.6), ([E], 0.51), ([F], 0.50)),
)

#set heading(numbering: none)

#task(
  points: 40,
  [
    Film Festival Management System
  ],
  [
    *Topic*: Design a system to manage a university library network with branches, collections, borrowers, and circulation services.

    *Context*: Design a system to manage a university library network with multiple branch libraries, diverse collections, academic materials, authors, publishers, and loan management.

    *Requirements*:
    - Track library materials with attributes including title, publication year, publisher, language, subject area, format type, and ISBN/ISSN
    - Associate materials with authors, editors, and contributing scholars
    - Track library patrons and their borrowing history
    - Manage which material is at which branch of the library in general. Extra Points, if you can also keep track of the stock at the current moment at time.
    - Document any assumptions you made during the development process
    - Generate reports on circulation statistics, popular materials, and overdue items

    *Deliverables*: Complete ERD with all entities, relationships, cardinalities, and a normalized relational model.
    #box(height: 60%, width: 100%, stroke: color.black)[]
  ],
  [],
  (),
)

#task(
  [
    Normalization
  ],
  [
    Consider the following schema:
    ```sql
    CREATE TABLE post_office_operations (
        postal_transaction_id INT,
        postal_service_date DATE,
        sender_customer_id INT,
        sender_full_name VARCHAR(100),
        sender_email_address VARCHAR(100),
        sender_street_address TEXT,
        sender_phone_number VARCHAR(20),
        postal_package_id INT,
        package_description VARCHAR(200),
        package_recipient_name VARCHAR(100),
        package_destination_city VARCHAR(100),
        package_tracking_number VARCHAR(20),
        postal_service_category VARCHAR(50),
        postal_service_base_cost DECIMAL(10, 2),
        package_quantity_count INT,
        payment_method_type VARCHAR(50),
        credit_card_number VARCHAR(20),
        credit_card_expiration_date VARCHAR(7),
        delivery_speed_method VARCHAR(50),
        delivery_surcharge_fee DECIMAL(10, 2),
        promotional_discount_code VARCHAR(20),
        discount_percentage_applied DECIMAL(5, 2),
        PRIMARY KEY (postal_transaction_id, postal_package_id)
    );
    ```
    #v(80%)
  ],
  [
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
  ],
  (
    (
      4,
      [
        1. Postal Data
        2. Discount data
        3. Payment data
        3. Sender data
        4. Shipping data
      ],
    ),
    (
      4,
      [
        1. Data Redundancy: Customer information is repeated for each book in an order
        2. Update Anomalies: Changing a customer's address requires updating multiple rows
        3. Insertion Anomalies: Cannot add a book without an order
        4. Deletion Anomalies: Deleting an order could lose book information
      ],
    ),
    (
      22,
      [
        1. Data Redundancy: Customer information is repeated for each book in an order
        2. Update Anomalies: Changing a customer's address requires updating multiple rows
        3. Insertion Anomalies: Cannot add a book without an order
        4. Deletion Anomalies: Deleting an order could lose book information
      ],
    ),
  ),
)

#task(
  points: 10,
  [General Terms of Databases],
  [
    Explain the following five terms that we encountered during the lecture in 2-3 sentences and give an example for each:
    - Indexing
    - Concurrency
    - Join
    - Aggregation
    - Denormalization
    #box(height: 75%, width: 100%, stroke: color.black)[]
  ],
  [],
  (
    (
      2,
      [Physical data structure optimization],
    ),
    (
      2,
      [Multi-user access management],
    ),
    (
      2,
      [Relational algebra operation combining relations],
    ),
    (
      2,
      [Data summarization operations],
    ),
    (
      2,
      [Strategic redundancy introduction],
    ),
  ),
)

#task(
  points: 16,
  [True or False],
  [
    For the following statements, decide whether each one is true or false and make a cross or checkmark in the respective column. For any correct answer, your point total will be increased by 2 points. For any wrong answer, your point total will be reduced by 2 points. You can receive negative points for this problem!

    #table(
      columns: (auto, auto, auto),
      inset: 10pt,
      align: horizon,
      table.header(
        [*Statement*],
        [*True*],
        [*False*],
      ),

      [A table can have multiple primary keys.], [], [],
      [Denormalization always improves query performance.], [], [],
      [Indexing always reduces the storage space required for a database.], [], [],
      [A database in Third Normal Form (3NF) is automatically in Second Normal Form (2NF).], [], [],
      [Concurrent transactions can never cause data inconsistency if they only perform read operations.], [], [],
      [A candidate key can contain NULL values.], [], [],
      [The UNION operation in SQL automatically removes duplicate rows.], [], [],
    )
  ],
  [],
  (
    (2, [False]),
    (2, [False]),
    (2, [False]),
    (2, [True]),
    (2, [False]),
    (2, [False]),
    (2, [True]),
  ),
)
#v(80%)

#task(
  [University Management System Database Project],
  [
    == Project Overview
    Please design and implement a complete database system for hospital management, covering medical, administrative, and operational aspects. The project is divided into three sequential stages:
    1. Conceptual Design (ERD),
    2. Logical Design (RM), and
    3. Physical Implementation (SQL).
  ],
  [
    #subtask(points: 20)[
      === Stage: Entity-Relationship Diagram (ERD) Design
      ==== Task Description
      Design a comprehensive Entity-Relationship Diagram for a hospital management system. Your ERD must capture all significant entities, relationships, attributes, cardinalities, and constraints necessary for managing medical departments, patient records, medical staff, treatments, appointments, medical equipment, and hospital administration.

      ==== Requirements
      - Identify all relevant entities with appropriate attributes
      - Define meaningful relationships with proper cardinalities
      - Specify primary keys and foreign keys
      - Include derived attributes where appropriate
      - Identify weak entities if necessary
      - Document any assumptions made during the design process
      - Use proper ERD notation (Chen, Crow's Foot, or UML)
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
      - Explain any denormalization decisions with justification

        #box(height: 65%, width: 100%, stroke: color.black)[]
    ]
    #subtask(points: 20)[
      === Stage: SQL Implementation
      ==== Task Description
      Implement your relational model as a PostgreSQL database. Write the SQL statements to create all tables with appropriate constraints, and populate them with sample data. Then, write SQL queries to demonstrate the functionality of your database for common hospital management operations.

      ==== Requirements:
      - Create DDL statements for all tables with proper constraints
      - Include foreign key constraints with appropriate actions (`CASCADE`, `SET NULL`, etc.)
      - Develop SQL queries for common operations like:
        - Patient admission and discharge
        - Medical treatment tracking
        - Doctor-patient assignment
        - Operating room scheduling
        - Patient medical history generation
        - Department resource allocation
        #box(height: 60%, width: 100%, stroke: color.black)[]
    ]
  ],
)

