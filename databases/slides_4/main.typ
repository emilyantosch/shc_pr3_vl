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
    subtitle: [Lecture 4 - Relationships],
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
#slide[
  - Last time, we looked at how to logically and conceptually design databases.
  - You also learned about how to use simple SQL language to map a conceptually designed database to an actual one.
  - Today, we'll look at
    - what relationships are in terms of databases,
    - how we can use constraints to enforce our relationships and,
    - how we can implement that in SQL.
]

#slide[
  1. Introduction
  2. Basics
  3. SQL
  4. Entity-Relationship-Model
  5. *Relationships*
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
    - define relationships and identify which type of relationship that is and,
    - decide how to implement that relationship in SQL.
]

= Relationships
== Relationship Types
#slide[
  #heading(numbering: none)[Basics]
  #text(size: 22pt)[
    - Describe relationships between entity types characterized by a verb
    - Often 2 naming possibilities:
      - teaches vs. is taught by
      - Relationship has always two (or more) directions
    - May have attributes
    - Number of participating entity types (degree):
      1. Unary relationship type (e.g., Employee supervises another employee)
      2. Binary relationship type (e.g., Employee works for one department)
      3. Ternary relationship type (e.g., Lecturer recommends books for one specific course)
      4. Higher degrees...
  ]
]

#slide[
  #heading(numbering: none)[Basics]
  #text(size: 22pt)[
    - Each relationship instance in R is an association of entities, where the association includes exactly one entity from each participating entity type
    - In an ERM, relationship types are displayed as diamond-shaped boxes, which are connected by straight lines to the entity types
      #figure(image("../assets/img/slides_04/20250305_emp_depart_worksfor_rev01.jpeg", height: 50%))
  ]
]

#slide[
  #heading(numbering: none)[Entity Type]
  - Represented as rectangle in ERM
  - Singular noun
  - Attribute Type
    - Represented as ovals
    - Noun
  - Relationship Type
    - Represented as diamond in ERM
    - Always between entity types
    - Verb
    - Has cardinalities
      #figure(image("../assets/img/slides_04/20250305_emp_depart_worksfor_rev01.jpeg"))
]

#slide[
  #heading(numbering: none)[Company Example]
  #figure(image("../assets/img/slides_04/20250305_circle_emp_dept_worksfor_rev01.png", height: 90%))
]

#slide[
  #heading(numbering: none)[Abstraction]
  #figure(image("../assets/img/slides_04/20250305_entity_types_relation_rev01.png"))
]

#slide[
  #heading(numbering: none)[Role Names]
  - The *role name* signifies the role that a participating entity from the entity type plays in each relationship instance, and helps to explain what the relationship means
]

#slide[
  #heading(numbering: none)[Recursive Relationship Types]
  - In some cases, the same entity type participates more than once in a relationship type in different roles
  - In such cases the *role name* becomes essential for distinguishing the meaning of the role that each participating entity plays
  - Such relationship types are called *recursive relationship types*
]

#slide[
  #heading(numbering: none)[Recursive Relationship Types]
  #figure(image("../assets/img/slides_04/20250305_circle_emp_supervision_rev01.png", height: 90%))
]

#slide[
  #example(title: [Example: Employee in 2 roles])[
    - Supervisor (boss) role name 1
    - Supervisee (subordinate) role name 2
      #figure(image("../assets/img/slides_04/20250305_emp_supervis_rev01.jpeg", height: 75%))
  ]

]


#slide[
  #heading(numbering: none)[Constraints]
  - Cardinality
  - Specifies the maximum number of relationship instances that an entity can participate in
  - Cardinality ratios
    - 1:1
    - 1:N
    - M:N
  - Cardinality ratios for binary relationships are represented on ER diagrams by displaying 1, M, and N on the diamonds
  - Notice that in this notation, we can either specify no maximum (N) or a maximum of one (1) on participation
]

#slide[
  #heading(numbering: none)[Company Example]
  #figure(image("../assets/img/slides_04/20250305_double_circle_manages_works_on_rev01.png", height: 90%))

]

#slide[
  #heading(numbering: none)[Constraints]
  #text(size: 22pt)[
    - Cardinality
    - (min,max) Notation
    - Example
      - A car has at least 3 and at most 5 wheels Every wheel is associated to exactly one car
        #figure(image("../assets/img/slides_04/20250305_car_has_wheel_rev01.jpeg"))

    - Attention: In UML, (min,max) is placed on the opposite sites!
    - Problem: General case cannot be easily implemented in RDBMS
  ]
]

#slide[
  #heading(numbering: none)[Constraints]
  - Other notations (e.g., in tools like draw.io)
    #figure(image("../assets/img/slides_04/20250305_relationship_rev01.jpeg", height: 70%))
]



#slide[
  #heading(numbering: none)[Constraints]
  #text(size: 20pt)[
    - Participation
    - Specifies whether the existence of an entity depends on its being related to another entity via the relationship type
    - Also called *minimum cardinality constraint*
    - Two types
    - Total: every entity in the total set of all entities of an entity type A must be related to an entity of entity type B via a relationship
      - Total participation is also called *existence dependency*
        - Is displayed as a double line connecting the participating entity type to the relationship
    - Partial: some or part of the entities of an entity type A are related to some entities of an entity type B via a relationship
      - Is displayed by a single line connecting the participating entity type to the relationship
  ]
]

#slide[
  #heading(numbering: none)[Constraints]
  - Cardinality: specifies the maximum number of relationship instances that an entity can participate in

  - Participation: specifies if the existence of an entity depends on its being related to another entity via the relationship type
    - *minimum cardinality constraint*
]



#slide[
  #heading(numbering: none)[Company Example]
  #figure(image("../assets/img/slides_04/20250305_circle_emp_dept_worksfor_rev01.png", height: 90%))

]

#slide[
  #heading(numbering: none)[Attributes]
  - Relationship types can also have attributes
  - Notice that attributes of 1:1 or 1:N relationship types can be migrated to one of the participating entity types
  - For M:N relationship types, some attributes may be determined by the combination of participating entities in a relationship instance, not by any single entity Such attributes must be specified as relationship attributes
]

#slide[
  #heading(numbering: none)[Company Example]
  #figure(image("../assets/img/slides_04/20250305_double_circle_manages_works_on_rev01.png", height: 90%))

]

#slide[
  #heading(numbering: none)[How to define them?]
  - Relationship between entity types
  - Good naming
  - More than one relationship?
    - Maybe different meanings, roles
    - Example for role: Supervisor, Supervisee
  - Cardinalities
  - Mandatory/optional
  - Attributes for Relationship Type?
]


== Relational Model
#slide[
  #heading(numbering: none)[Constraints]
  #text(size: 20pt)[
    - Three categories
      1. Constraints that are inherent in the data model *inherent model-based constraints* or *implicit constraints* Example: no duplicate tuples in a relation
      2. Constraints that can be directly expressed in schemas of the data model *schema-based constraints* or *explicit constraints* Example: Domain constraints, primary key (entity integrity constraints), constraints on NULL, and *referential integrity constraints*
      3. Constraints that cannot be directly expressed in the schemas of the data model, and hence must be expressed and enforced by the application programs *application-based* or *semantic constraints* or *business rules*
  ]
]


#slide[
  #heading(numbering: none)[Referential Integrity Constraint]
  #text(size: 20pt)[
    - It is defined between two relations
    - It is used to maintain the consistency among tules in the two relations: a tuple in one relation that refers to another relation must refer to an existing tuple in that relation
    - *Foreign key*: a set of attributes FK in relation schema $R_1$ is a foreign key of $R_1$ that references relation $R_2$ if it satisfies the following rules:
      - 1. The attributes in FK have the same domain(s) as the primary key attributes PK of $R_2$; the attributes FK are said to *reference* or *refer to* the relation $R_2$
      - 2. A value of FK in a tuple $t_1$ of the current state$r_1(R_1)$ either occurs as a value of PK for some tuple $t_2$ in the current state $r_2(R_2)$ or is `NULL`. In the former case, we have $t_1["FK"] = t_2["FK"]$ , and we say that the tuple $t_1$ references or refers to the tuple $t_2$
  ]
]

#slide[
  #heading(numbering: none)[Referential Integrity Constraints]
  - A foreign key can refer to its own relation
  - Foreign keys are depicted with a directed arrow: The arrowhead may point to the primary key
  - All integrity constraints can be defined with the DDL, thus the DBMS can automatically enforce them
]

#slide[
  #heading(numbering: none)[Company Example]
  #figure(image("../assets/img/slides_04/20250305_circle_emp_dept_worksfor_rev01.png", height: 90%))
]

#slide[
  #heading(numbering: none)[Company Example]
  #figure(image("../assets/img/slides_04/20250305_emp_dept_proj_rev01.png", height: 90%))
]

#slide[
  #heading(numbering: none)[Notation of Foreign Keys]
  #text(size: 20pt)[
    - There are several ways for the notation of relational schemas, especially for representing foreign keys
      - Option 1:
        - Foreign Keys can be represented with arrows
        - This notation is used in the lecture slides and in the book "Fundamentals of Database Systems" from Elmasri and Navathe
        - Advantage: Each FK-arrow connects the referencing attribute and referenced attribute, so the involved relations are obvious
        - Option 2:
          - Foreign Keys can be represented with addition (FK) within the referencing attribute
          - This notation is used in the laboratory of Mr. Ocker
          - Advantage: This notation is more readable for large, complex schemas
    - Both notations are correct and may be used within the examination
  ]
]

#slide[
  #heading(numbering: none)[Notation of Foreign Keys]
  #figure(image("../assets/img/slides_04/20250305_table_relationship_exam_rev01.jpeg"))
]

#slide[
  #heading(numbering: none)[Notation of Foreign Keys]
  #figure(image("../assets/img/slides_04/20250305_emp_dept_option2_rev01.png"))
]

#slide[
  #heading(numbering: none)[Mapping of ERM]
  - 1. Mapping of regular entity types
  - 2. Mapping of weak entity types
  - *3. Mapping of binary 1:1 relationships*
  - *4. Mapping of binary 1:n relationships*
  - *5. Mapping of binary m:n relationships*
  - 6. Mapping of multivalued attributes
  - 7. Mapping of n-ary relationships
]

#slide[
  #heading(numbering: none)[Mapping of Binary 1:1]
  - For each binary 1:1 relationship type R in the ER schema, identify the relations S and T that correspond to the entity types participating in R
  - There are three possible approaches:
    - 1. The foreign key approach
    - 2. The merged relationship approach
    - 3. The cross-reference or relationship relation approach
]

#slide[
  #heading(numbering: none)[Mapping of Binary 1:1]
  1. The foreign key approach
    - Choose one of the relations S and include as a foreign key in S the primary key of T
    - It is better to choose an entity type with total participation in R in the role of S
    - Include all the simple attributes (or simple components of composite attributes) of the 1:1 relationship type R as attributes of S
]

#slide[
  #heading(numbering: none)[Mapping of Binary 1:1]
  #figure(image("../assets/img/slides_04/20250305_emp_dept_table_rev01.jpeg"))
  #text(size: 22pt)[
    - Mapping of relationship type MANAGES
      - DEPARTMENT serves as S
      - EMPLOYEE serves as T
    - Attribute `SSN` is renamed in `MGR_SSN` in `DEPARTMENT`
    - Attribute `START_DATE` is renamed in `Mgr_start_date` in `DEPARTMENT`
    - It is also possible to include primary key of S as foreign key in T
    - For the mapping, a *UNIQUE-Constraint* must be used!
      - Otherwise, an employee could manage several departments!
  ]
]

#slide[
  #heading(numbering: none)[Mapping of Binary 1:1]
  - For the mapping, a `UNIQUE`-Constraint must be used!
    #figure(image("../assets/img/slides_04/20250305_person_has_drive_lice_rev01.png"))
]

#slide[
  #heading(numbering: none)[Mapping of Binary 1:1]
  2. Merged relation approach
    - Merge the two entity types and the relationship into a single relation
    - This is possible when both participations are total, as this would indicate that the two tables will always have the exact same number of tuples
      #figure(image("../assets/img/slides_04/20250305_emp_in_dept_rev01.jpeg"))
]

#slide[
  #heading(numbering: none)[Mapping of Binary 1:1]
  #text(size: 22pt)[
    3. The cross-reference or relationship relation approach
      - Set up a third relation R for the purpose of cross-referencing the primary keys of the two relations S and T representing the entity types
      - This approach is required for binary M:N relationships
      - The relation R will include the primary key attributes of S and T as foreign keys to S and T
      - The primary key of R will be one of the two foreign keys, and the other foreign key will be a unique key of R
      #figure(image("../assets/img/slides_04/20250305_manages_rev01.jpeg"))
  ]
]

#slide[
  #heading(numbering: none)[Mapping of Binary 1:N]
  - For each regular binary 1:N relationship type R, identify the relation S that represents the participating entity type at the N-side of the relationship type
  - Include as foreign key in S the primary key of the relation T that represents the other entity type participating in R
  - Include any simple attributes (or simple components of composite attributes) of the 1:N relationship type as attributes of S
  - An alternative approach: use the relationship relation and create a separate relation
]

#slide[
  #heading(numbering: none)[Mapping of Binary 1:N]
  #figure(image("../assets/img/slides_04/20250305_three_circle_rev01.png", height: 50%))
  #text(size: 22pt)[
    - Relationship type `WORKS_FOR`: Attribute `Dno` as foreign key in `EMPLOYEE`
    - Relationship type `SUPERVISION`: Attribute `Super_ssn` as foreign key in `EMPLOYEE`
    - Relationship type `CONTROLS`: Attribute `Dnum` as foreign key in `PROJECT`
  ]
]

#slide[
  #heading(numbering: none)[Mapping of Binary 1:N - Total Participation]
  Total and Partial Participation should be mapped as well
  - For participation definitions on the "1" side, a constraint assures the requirement
    - Total Participation 1:m → NOT NULL on FK
    - Partial Participation "0:m" → NULL on FK
  - For participation definitions on the "m" side, there is a problem
    - These types (1:n vs. "1:0n") are not distinguishable in Relational Model
    - These types of Total Participation cannot be implemented / enforced using SQL-DDL!
]

#slide[
  #heading(numbering: none)[Mapping of Binary M:N]
  - For each binary M:N relationship type R, create a new relation S to represent R
  - Include as foreign key attributes in S the primary keys of the relations that represent the participating entity types; their combination will form the primary key of S
  - Also include any simple attributes of the M:N relationship type (or simple components of composite attributes) as attributes of S
  - Notice that a M:N relationship type can not be represented by a single foreign key attribute in one of the participating relations (as in 1:1 or 1:N relationship types) because of the M:N cardinality ratio
]

#slide[
  #heading(numbering: none)[Mapping of Binary M:N]
  #figure(image("../assets/img/slides_04/20250305_circle_workson_rev01.png", height: 90%))
]

#slide[
  #heading(numbering: none)[Mapping of Binary M:N]
  #text(size: 20pt)[
    - Attribute `Ssn` is renamed in `Essn` in WORKS\_ON
    - Attribute `Pname` is renamed in `Pno` in DEPARTMENT
    - Primary key is the combination `{Essn, Pno}`
      #info[
        The existence dependency between `EMPLOYEE` and `PROJECT` should be specified on the foreign keys in the relation corresponding to the relationship `R` (`ON UPDATE` and `ON DELETE`)
      ]
  ]
]

#slide[
  #heading(numbering: none)[Example Company]
  #figure(image("../assets/img/slides_04/20250305_no_circle_rev01.png"))
]

#slide[
  #heading(numbering: none)[Example Company]
  #figure(image("../assets/img/slides_04/20250305_emp_dept_proj_rev01.png"))
]

#slide[
  #heading(numbering: none)[Assignment Office - Convert ERD to RM]

  - Departments, identified by ID, operate a variety of printers, each located in a particular room in a particular building. Printers are supplied by a number of suppliers, identified by name, with each supplier charging a different price for a given printer, but also providing different delivery delays, measured in days. A given room can have any number of printers, including none.
  #figure(image("../assets/img/slides_04/20250305_dept_operates_printer_rev01.png"))
]

#slide[
  #heading(numbering: none)[Mapping of ERM to RM]
  1. Mapping of regular entity types #sym.checkmark
  2. Mapping of weak entity types
  3. Mapping of binary 1:1 relationships #sym.checkmark
  4. Mapping of binary 1:n relationships #sym.checkmark
  5. Mapping of binary m:n relationships #sym.checkmark
  6. Mapping of multivalued attributes
  7. Mapping of n-ary relationships

]

#slide[
  #heading(numbering: none)[Create Table - Constraints]
  - Referential integrity is specified via the *FOREIGN KEY*
  - FK relates two tables
  - Referenced table must exist already
  - Referenced column must be *UNIQUE*
    - Best to use PK
    - If not PK: need to specify (column)
]

#slide[
  #heading(numbering: none)[Create Table - Constraints Syntax]
  - As Column Constraint
    - Only if the foreign key is one single attribute (and not combined)
  ```sql
  [CONSTRAINT < constraintname > ]
     REFERENCES < tablename >[( column )] [< action >]
  ```
  - As Table Constraint:
  ```sql
  [CONSTRAINT < constraintname >]
     FOREIGN KEY (< column list >)
     REFERENCES < tablename >[(< column list >)]
             [< action >]
  ```
]
#slide[
  #heading(numbering: none)[Create Table - Constraints Syntax]
  - Example column constraint:
    ```sql
    CREATE TABLE Department
    ( Dname VARCHAR(15) NOT NULL,
    Dnumber INT NOT NULL,
    Mgr_ssn CHAR(9) REFERENCES Employee(Ssn) ,
    Mgr_start_date DATE,
    PRIMARY KEY (Dnumber) ,
    UNIQUE (Dname));
    ```
]
#slide[
  #heading(numbering: none)[Create Table - Constraints Syntax]

  - Example table constraint:
  ```sql
  CREATE TABLE Department
  ( Dname VARCHAR(15) NOT NULL,
  Dnumber INT NOT NULL,
  Mgr_ssn CHAR(9) NOT NULL,
  Mgr_start_date DATE,
  PRIMARY KEY ( Dnumber ),
  UNIQUE ( Dname ),
  FOREIGN KEY ( Mgr_ssn ) REFERENCES Employee ( Ssn ) );
  ```

]

#slide[
  #heading(numbering: none)[Create Table - Constraints]


  - `<action>`:
    - How to react on changes to the referenced table

  - The default action: reject the update operation (*RESTRICT* option)
    ```sql
      action ::= ON {UPDATE | DELETE}
      {NO ACTION | SET NULL | SET DEFAULT | CASCADE}
    ```
]


#slide[
  #heading(numbering: none)[Create Table - Constraints]
  - Options:
    - *SET NULL* Value of foreign key is set to NULL
    - *SET DEFAULT* Value of foreign key is set to a default value
    - *CASCADE* Value of foreign key is updated
  - For example:
    - *ON DELETE CASCADE* Delete all referencing tuples
    - *ON UPDATE CASCADE* Change Value of the foreign key attribute(s)
  - General Rule for using *CASCADE*:
    - For "relationship" relations
    - For multivalued attributes
    - For relations that represent weak entity types
]

#slide[
  #heading(numbering: none)[Create Table - Constraints]
  ```sql
    CREATE TABLE Employee
  ( . . . ,
  Dno INT NOT NULL DEFAULT 1,
  CONSTRAINT EMPPK PRIMARY KEY (Ssn),
  CONSTRAINT EMPSUPERFK FOREIGN KEY (Super_ssn) REFERENCES Employee(Ssn)
  ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT EMPDEPTFK FOREIGN KEY(Dno) REFERENCES Department(Dnumber)
      ON DELETE SET DEFAULT ON UPDATE CASCADE
    );
  ```
]


#slide[
  #heading(numbering: none)[`ALTER TABLE`]
  - For modifying an existing relation
    - COLUMN: *ADD, DROP, MODIFY*
    - CONSTRAINT: *ADD, DROP*
    - TABLE: *RENAME*
]

#slide[
  #heading(numbering: none)[`ALTER TABLE` - Column]
  Syntax for altering a table:
  ```sql
  ALTER TABLE < relationname > . . .
  ```
  ```sql
  ADD [ COLUMN ] < column > < type >
          [ < col\_constraint > [ . . .]
  ```
  ```sql
    DROP [COLUMN] <column> [RESTRICT | CASCADE]
  ```
  ```sql
    RENAME COLUMN <column> TO <new_column>
  ```
]


#slide[
  #heading(numbering: none)[`ALTER TABLE` - Column]
  - Syntax for altering a table:
  ```sql
  ALTER TABLE < relationname > . . .
  ```
  Modification of columns vendor-specific:
  Oracle:
  ```sql
  ... MODIFY < column > < type > [< col\_constraints > [...]]
  ```

  MySQL:
  ```sql
  ... CHANGE [ COLUMN ] < column > < type > ...
  ```
]

#slide[
  #heading(numbering: none)[`ALTER TABLE` - Column]
  ```sql
    ALTER TABLE COMPANY.EMPLOYEE ADD COLUMN Job TEXT(12);
  ```
  - Inserting values for the new column:
    - Default is `NULL` #sym.arrow `NOT NULL` constraint is not allowed
    - Using default clause
    - Using `UPDATE` individually on each tuple
]


#slide[
  #heading(numbering: none)[`ALTER TABLE` - Constraints]
  Syntax for adding a new constraint:

  ```sql
  ALTER table ADD < tableconstraint > ;
  ```
  - Add a foreign key (instead of within create table statement):
    ```sql
      ALTER TABLE DEPARTMENT
      ADD CONSTRAINT DEPTMGRFK  FOREIGN KEY (Mgr_ssn) REFERENCES EMPLOYEE(Ssn)
      ON DELETE RESTRICT ON UPDATE CASCADE;
    ```

]



#slide[
  #heading(numbering: none)[`ALTER TABLE` - Constraints]
  Syntax for dropping an existing constraint:
  ```sql
  ALTER TABLE < tablename > < alterstatement >
  ```

  ```sql
  < alterstatement > ::=
        DROP PRIMARY KEY |
        DROP FOREIGN KEY < keyname > |
  ```
]


#slide[
  #heading(numbering: none)[`ALTER TABLE` - Rename]
  - Syntax for renaming an existing table:

  - Oracle, MySQL:
  ```sql
  RENAME TABLE < relationname > TO < newrelationname >
  ```

  - PostgreSQL, MySQL:
  ```sql
  ALTER TABLE < name > RENAME TO < new_name >
  ```
]

#slide[
  #heading(numbering: none)[Homework]
  - Company Example
    - Implement all relationship types from the ERM in your database
    - Think also about the cardinalities and participation constraints of these relationship types
    - What should be the behavior of these relations if data changes?
    - Try SQL statements for inserting, updating, and deleting data
  - Implement the printer example in your database
  - Think about your own, individual example (e.g., contact list)
    - Implement all relationship types from the ERM in your database
    - Think also about the cardinalities and participation constraints
    - What should be the behavior of these relations if data changes?
    - Try SQL statements for inserting, updating, and deleting data
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
