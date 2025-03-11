#import "@preview/touying:0.5.2": *
#import themes.university: *

#import "@preview/fletcher:0.5.1" as flechter: diagram, node, edge
#import "@preview/wrap-it:0.1.0": wrap-content

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
    subtitle: [Lecture 5 - Constraints & Notations],
    author: [Emily Lucia Antosch],
    date: datetime.today().display("[day].[month].[year]"),
    institution: [HAW Hamburg],
  ),
)

#codly(
  languages: (
    java: (
      name: text(font: "JetBrainsMono NFM", " Java", weight: "bold"),
      icon: text(font: "JetBrainsMono NFM", "\u{e738}", weight: "bold"),
      color: rgb("#CE412B"),
    ),
    sql: (
      name: text(font: "JetBrainsMono NFM", " SQL", weight: "bold"),
      icon: text(font: "JetBrainsMono NFM", "\u{e76e}", weight: "bold"),
      color: rgb("#2563eb"),
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

- Last time, we looked at how we can use relationships in the database design stages
- Today, we'll be discussing
  - how we can expand on that knowledge
  - what multivalued and derived attributes are
  - the syntax for creating constraints more in-depth.

#slide[
  1. Introduction
  2. Basics
  3. SQL
  4. Entity-Relationship-Model
  5. *Relationships*
  6. *Constraints*
  7. More SQL
  8. Subqueries & Views
  9. Transactions
  10. Database Applications
  11. Integrity, Trigger & Security
]

== What is the goal of this chapter?
#slide[
  - At the end of this lesson, you should be able to
    - create constraints based on your logical and conceptual design
    - use domains
    - and pivot the type of constraints to fit your need.
]

= Relationships
== ERM
#slide[
  #heading(numbering: none)[Convert ERD to RM]
  #figure(image("../assets/img/slides_05/20250306_customer_places_order_map_rev01.jpeg"))
]

#slide[
  #heading(numbering: none)[Convert ERD to RM: SQL]
  #figure(image("../assets/img/slides_05/20250306_customer_places_order_code_rev01.jpeg"))
]

#slide[
  #heading(numbering: none)[Weak Entity Types]

  - An entity type without a key attribute is called a *weak entity type*
  - Weak entities are identified by being related to specific entities from another entity type in combination with one of their attribute values;
  - This other entity type is called *the identifying or owner entity type*, and the relationship type that relates a weak entity type to its owner *the identifying relationship*
  - A weak entity type always has a total participation constraint (existence dependency) with respect to its identifying relationship
  - Represented by double rectangles and by having their identifying relationship placed in double diamonds
    - The partial key attribute is underlined with a dashed or dotted line
  - Example: Room vs. Building
    - Need for identify room: Room number and Building number!
]


#slide[
  #heading(numbering: none)[Weak Entity Types]
  #figure(image("../assets/img/slides_05/20250306_building_has_room_rev01.jpeg"))
]

#slide[
  #heading(numbering: none)[Weak Entity Types]
  - The company is organized into departments
  - Each department has a unique name, a unique number, a manager (employee) with start date, and several locations
  - A department controls a number of projects, each with unique name, unique number, single location
  - We store each employee's name, ssn, address, salary, sex, birthdate
  - An employee is assigned to one department, but may work on several projects, also from other departments
  - We keep track of the hours per week per project
  - We also keep track of the supervisor
  - We want to keep track of each employee's dependents for insurance purposes, namely first name, sex, birth date, and relationship to employee. Source: Elmasri, Fundamentals
]

#slide[
  #heading(numbering: none)[Weak Entity Types]
  #question[
    What could be a weak entity type?
  ]
  #figure(image("../assets/img/slides_05/20250306_emp_dep_dept_proj_rev01.png"))
]

#slide[
  #heading(numbering: none)[Weak Entity Types]
  #figure(image("../assets/img/slides_05/20250306_circle_dependents_rev01.png"))
]

#slide[
  #heading(numbering: none)[Multivalued Attributes]
  - Single-valued vs multivalued attributes
    - Single-valued: Most attributes have a single value for a particular entity
    - Multivalued: In some cases, an attribute can have a set of values for the same entity
    - Multivalued attributes are displayed in double ovals
]

#slide[
  #heading(numbering: none)[Multivalued Attributes]
  #question[
    What could be a multivalued attribute?
  ]
  - The company is organized into departments
  - Each department has a unique name, a unique number, a manager (employee) with start date, and several locations
  - A department controls a number of projects, each with unique name, unique number, single location
  - We store each employee's name, ssn, address, salary, sex, birthdate
  - An employee is assigned to one department, but may work on several projects, also from other departments
  - We keep track of the hours per week per project
  - We also keep track of the supervisor
  - We want to keep track of each employee's dependents for insurance purposes, namely first name, sex, birth date, and relationship to employee. Source: Elmasri, Fundamentals
]

#slide[
  #heading(numbering: none)[Multivalued Attributes]
  #figure(image("../assets/img/slides_05/20250306_circle_locations_rev01.png"))
]

#slide[
  #heading(numbering: none)[Complex Attributes]

  - Composite and multivalued attributes can be nested arbitrarily
  - The combination of composite and multivalued attributes is called *Complex Attribute*
    #example[
      Person can have more than one residence and each residence can have a single address and multiple phones
    ]
]

#slide[
  #heading(numbering: none)[Derived Attributes]
  - Stored vs. derived attributes
    - Some attribute values can be derived from related entities
    - For example: Age can by derived from birthdate
]

#slide[
  #heading(numbering: none)[Derived Attributes]
  #question[
    Can you think of a derived attribute?
  ]
  - The company is organized into departments
  - Each department has a unique name, a unique number, a manager (employee) with start date, and several locations
  - A department controls a number of projects, each with unique name, unique number, single location
  - We store each employee's name, ssn, address, salary, sex, birthdate
  - An employee is assigned to one department, but may work on several projects, also from other departments
  - We keep track of the hours per week per project
  - We also keep track of the supervisor
  - We want to keep track of each employee's dependents for insurance purposes, namely first name, sex, birth date, and relationship to employee. Source: Elmasri, Fundamentals
]

#slide[
  #heading(numbering: none)[Derived Attributes]
  #figure(image("../assets/img/slides_05/20250306_circle_num_of_emp_rev01.png"))
]

#slide[
  #heading(numbering: none)[Mapping of ERM]
  - Seven Steps
    1. Mapping of regular entity types #sym.checkmark
    2. Mapping of weak entity types
    3. Mapping of binary 1:1 relationships #sym.checkmark
    4. Mapping of binary 1:n relationships #sym.checkmark
    5. Mapping of binary m:n relationships #sym.checkmark
    6. Mapping of multivalued attributes
    7. Mapping of n-ary relationships
]

#slide[
  #heading(numbering: none)[Mapping of ERM: Weak Entity Types]
  - For each weak entity type W in the ER schema with owner entity type E, create a relation R and include all simple attributes (or simple components of composite attributes) of W as attributes of R
  - In addition, include as foreign key attributes of R, the primary key attribute(s) of the relation(s) that correspond to the owner entity type(s); this takes care of mapping the identifying relationship type of W
  - The primary key of R is the combination of the primary key(s) of the owner(s) and the partial key of the weak entity type W, if any
]

#slide[
  #heading(numbering: none)[Mapping of ERM: Weak Entity Types]
  #figure(image("../assets/img/slides_05/20250306_circle_emp_dep_rev01.png"))
  #info[
    - The attribute `SSN` is renamed to `ESSN`, although this is not necessary.
    - The primary key is the combination `{ESSN, DEPENDENT_NAME}`
  ]
]
#slide[
  #heading(numbering: none)[Mapping of ERM: Multivalued Attributes]
  - For each multivalued attribute A, create a new relation R
  - This relation R will include an attribute corresponding to A, plus the primary key attribute K - as a foreign key in R - of the relation that represents the entity type or relationship type that has A as a multivalued attribute
  - The primary key of R is the combination of A and K
  - If the multivalued attribute is composite, we include its simple components
]

#slide[
  #heading(numbering: none)[Mapping of ERM: Multivalued Attributes]
  #figure(image("../assets/img/slides_05/20250306_dept_locations_rev01.png"))
  - Attribute `Dlocation` represents the multivalued attribute `LOCATIONS` of `DEPARTMENT`
  - Attribute `Dnumber` represents the primary key of `DEPARTMENT`
  - The primary key of `DEPT_LOCATIONS` is the combination of `{Dnumber, Dlocation}`
  - A separate tuple will exist in `DEPT_LOCATIONS` for each location that a department has
]

#slide[
  #heading(numbering: none)[Mapping of ERM]
  - Seven Steps
    1. Mapping of regular entity types #sym.checkmark
    2. Mapping of weak entity types #sym.checkmark
    3. Mapping of binary 1:1 relationships #sym.checkmark
    4. Mapping of binary 1:n relationships #sym.checkmark
    5. Mapping of binary m:n relationships #sym.checkmark
    6. Mapping of multivalued attributes #sym.checkmark
    7. Mapping of n-ary relationships
]

#slide[
  #heading(numbering: none)[Ternary Relationship Types]
  - Example:
    - Manufacturers supply items for projects.
    - A manufacturer must supply at least one item.
    - An article from in-house production does not have to be supplied for a project but can be supplied for many projects.
    - A project uses at least one item.
    - An item is supplied by only one manufacturer for a project.
  #figure(image("../assets/img/slides_05/20251003_article_supplied_manu_rev01.png"))
]

#slide[
  #heading(numbering: none)[Ternary Relationship Types]
  #question[
    Cardinality: Can an entity of entity type A and an entity of entity type B be related to multiple entities of entity type C?
  ]
  #question[
    Participation: Must an entity type A be related to at least one entity type B and one entity type C?
  ]
]
#slide[
  #heading(numbering: none)[Ternary Relationship Types]
  - Example:
    - To prevent students from concentrating on one professor, they may only work with one professor on one seminar topic.
    - In addition, a student can only work on a seminar topic with one professor.
    - However, a professor may assign a seminar topic more than once.
    - Students must attend seminars, but seminar topics do not have to be chosen.
]


#slide[
  #heading(numbering: none)[Ternary Relationship Types]
  #figure(image("../assets/img/slides_05/20250306_head_visits_emp_rev01.jpeg"))
]

#slide[
  #heading(numbering: none)[Ternary Relationship Types]
  - Higher degree relationship type: Literature recommendations for specific courses
    #figure(image("../assets/img/slides_05/20250306_lecturer_teaches_course_rev01.jpeg"))
]

#slide[
  #heading(numbering: none)[Ternary Relationship Types]
  - In many CASE tools, only binary relationship types can be represented
  - Ternary relationship type is replaced by (weak) entity type + relationship types
  #figure(image("../assets/img/slides_05/20250306_lecturer_teaches_course_recomm_rev01.jpeg"))
]


#slide[
  #heading(numbering: none)[Mapping of ERM]
  - Seven Steps
    1. Mapping of regular entity types #sym.checkmark
    2. Mapping of weak entity types #sym.checkmark
    3. Mapping of binary 1:1 relationships #sym.checkmark
    4. Mapping of binary 1:n relationships #sym.checkmark
    5. Mapping of binary m:n relationships #sym.checkmark
    6. Mapping of multivalued attributes #sym.checkmark
    7. Mapping of n-ary relationships
]

#slide[
  #heading(numbering: none)[Mapping of ERM: Mapping of n-ary relationships]
  - For each n-ary relationship type R, where $n > 2$, create a new relation S to represent R
  - Include as foreign key attributes in S the primary keys of the relations that represent the participating entity types
  - Also include any simple attributes of the n-ary relationship type (or simple components of composite attributes) as attributes of S
  - The primary key of S is usually a combination of all the foreign keys that reference the relations representing the participating entity types
]

#slide[
  #heading(numbering: none)[Mapping of ERM: Mapping of n-ary relationships]
  #figure(image("../assets/img/slides_05/20250306_supplier_supply_proj_arrow_rev01.jpeg"))
]

#slide[
  #heading(numbering: none)[Mapping of ERM]
  - Seven Steps
    1. Mapping of regular entity types #sym.checkmark
    2. Mapping of weak entity types #sym.checkmark
    3. Mapping of binary 1:1 relationships #sym.checkmark
    4. Mapping of binary 1:n relationships #sym.checkmark
    5. Mapping of binary m:n relationships #sym.checkmark
    6. Mapping of multivalued attributes #sym.checkmark
    7. Mapping of n-ary relationships #sym.checkmark
]

#slide[
  #heading(numbering: none)[Mapping of ERM: Summary]
  #align(center + horizon)[
    #table(
      columns: (auto, auto),
      align: (center, center),
      fill: (_, y) => if calc.odd(y) { rgb("#438C94").lighten(90%) },
      table.header[*ER Model*][*Relational Model*],
      [Entity type], [Relation],
      [1:1 or 1:N relationship type], [Foreign key (or relationship relation)],
      [M:N relationship type], [Relationship relation and two foreign keys],
      [N-ary relationship type], [Relationship relation and n foreign keys],
      [Simple attribute], [Attribute],
      [Composite attribute], [Set of simple attributes],
      [Multivalued attribute], [Relation and foreign key],
      [Value set], [Domain],
      [Key attribute], [Primary key],
    )
  ]
]

= Constraints
== Theory
#slide[
  #heading(numbering: none)[Basics]
  - Three categories
    1. Constraints that are inherent in the data model *inherent model-based constraints* or *implicit constraints* Example: no duplicate tuples in a relation
    2. Constraints that can be directly expressed in schemas of the data model *schema-based constraints* or *explicit constraints* Example: Domain constraints, key constraints, constraints on NULL, entity integrity constraints and referential integrity constraints
    3. Constraints that cannot be directly expressed in the schemas of the data model, and hence must be expressed and enforced by the application programs *application-based* or *semantic constraints* or *business rules*
]

== SQL
#slide[
  #heading(numbering: none)[Basics]
  - Syntax for creating an empty table
  ```sql
  CREATE TABLE < relationname >
           (<column> <type> [ DEFAULT expr ]
                    [ [NOT] NULL ] [ colconstraint ] *
           [,{<column> <type> [ DEFAULT expr ]
                    [ [NOT] NULL ] [ colconstraint ] *
            | <tableconstraint> } ] *
           );
  ```
  - Some constraints (e.g., `UNIQUE`, `NOT NULL`) can be defined as column constraints or as table constraints
]

== ERM
#slide[
  #heading(numbering: none)[Key Attributes]
  - How can we identify an actual entity within an entity set?
  - Attributes must be used
    - Key Attributes (also called identifying attributes)
  - Sometimes several attributes together form a key attribute (identifying attribute), meaning that the combination of the attribute values must be distinct for each entity
    - If a set of attributes possesses this property, the proper way to represent this in the ER model that is to define a *composite attribute* and designate it as a key attribute of the entity type
    - Notice that such a composite key attributes must be minimal; that is, all component attributes must be included in the composite attribute to have the uniqueness property
  - Key attributes are underlined
  - If two attributes are underlined separately, then each is an identifying attribute on its own
]

== RM
#slide[
  #heading(numbering: none)[Primary Key]
  - Primary Key
    - Also called *Entity Integrity Constraint*
    - PK values must be unique and cannot be NULL!
    - Notation: #underline[underlined]

    #table(
      columns: (auto, auto, auto, auto, auto, auto),
      align: (center, center, center, center, center, center),
      fill: (_, y) => if calc.odd(y) { rgb("#438C94").lighten(90%) },
      table.header[*ISBN*][*Title*][*Author*][*Publisher*][*Year*][*Price*],
      [978-1-292-09761-9], [Fundamentals of Database Systems], [Ramez Elmasri], [Prentice Hall], [2016], [59.99],
      [978-0321197849], [An Introduction to Database Systems], [C. J. Date], [Pearson], [2003], [69.92],
    )
]

== Domains
#slide[
  #heading(numbering: none)[Basics]
  - A domain D is a set of atomic values
  - Atomic means that each value is indivisible
  - A common method of specifying a domain is to specify a data type from which the data values forming the domain are drawn
  - It is also useful to specify a name for the domain, to help in interpreting its values
    #example[
      - `Names`: The set of character strings that represent names of persons
      - `Employee_age`: Possible ages of employees in a company; each must be an integer value between 16 and 70
    ]
]

#slide[
  #heading(numbering: none)[Basics]
  - Domain constraints specify that within each tuple, the value of each attribute A must be an atomic value from the domain $"dom"(A)$
  - Data types
    - Numeric data types: short integer, integer, long integer
    - Real numbers: float, double
    - Characters
    - Booleans
    - Fixed-length or variable-length strings
    - Date
  - Also, possible subrange of values from a data types and enumerated data types
]



#slide[
  #heading(numbering: none)[Basics]
  - For example: Employee must be between 16 and 70 years old
  - Value sets are not displayed in ER diagrams, and are typically specified using the basic data types available in most programming languages
    #figure(image("../assets/img/slides_05/20250306_circle_bdate_rev01.jpeg"))
]

#slide[
  #heading(numbering: none)[Basics]
  - Example:
    - `Employee_age`: integer number between 16 and 70
    - `Mobile_Number`: (dd)ddd-ddddddd d is a decimal digit
  - A domain is thus given a name, data type, and format
]

#slide[
  #heading(numbering: none)[Basics]
  - `CREATE DOMAIN` is part of the ANSI Standard But almost all RDBMS ignore this command
  - A domain is simply a self-defined data type More precise it is a limitation of the values range of a data type
    #example[
      - You want to save the age of a person, you could use `INTEGER`
      - Now you could save a value from -2,147,483,648 to 2,147,483,647
      - No person will reach an age of 2,147,483,647 years, neither can someone be younger than 0
    ]
  - By creating a domain, you could design a useful value range (e.g., 0 => column =< 100).
  - For using a domain, you just type the domain-name instead of a data type
]

#slide[
  #heading(numbering: none)[Basics]
  - Based on base data type ... with additional constraints
    ```sql
    CREATE DOMAIN <name> [ AS ] datatype [ DEFAULT expession] [ constraint [ . . . ] ] ; [ CONSTRAINT constraint\_name] { NOT NULL | NULL | CHECK ( expression )
    ```
    #example[
      ```sql
      CREATE DOMAIN nnint AS INT NOT NULL ;
      CREATE DOMAIN posint AS INT CHECK ( VALUE >= 0 ) ;
      CREATE DOMAIN dayofweek AS VARCHAR CHECK ( VALUE IN ( 'Monday' , 'Tuesday' , ...)) ;
      CREATE DOMAIN SSN TYPE AS CHAR(9);
      ```
    ]
]


#slide[
  #heading(numbering: none)[SQL - Check]
  - One option to implement domains in mySQL
  - `colconstraint` = Column constraint
    - `CHECK`
      - Constraint can restrict attribute or domain values using the `CHECK` clause following an attribute or domain definition
      #example[
        ```sql
        Dnumber INT NOT NULL CHECK (Dnumber > 0 AND Dnumber < 21);
        ```
      ]
]

#slide[
  #heading(numbering: none)[SQL - Check]
  - Tuple-based constraints
    - Semantical Integrity
    - Apply to each tuple individually and are checked whenever a tuple is inserted or modified
  - Makes sure that condition is met ... or `NULL`!
  - Typical use case: Range checking
    #example[
      ```sql
      CONSTRAINT chk\_age CHECK (age ≥ 18)
      ```
    ]
  - Also, complex conditions possible (verify relationships with other rows and/or tables)
    #example[
      ```sql
        CHECK (Dept_create_date <= Mgr_start_date);
      ```
    ]
]

#slide[
  #heading(numbering: none)[SQL - Check]

  - The `CHECK` clause can also be used in conjunction with the `CREATE DOMAIN` statement if supported by the DBMS

  - For example, we can write the following statement:
    ```sql
    CREATE DOMAIN D_NUM AS INTEGER CHECK (D_NUM > 0 AND D\_NUM < 21 );
    ```
]

#slide[
  #heading(numbering: none)[Constraints on `NULL`]
  - Constraint on attributes specifies whether NULL values are or are not permitted
  - `NULL`: special attribute value
    - Value unknown (exists but is intentionally withheld)
      - A person's date of birth is not known, so it is represented by NULL in the data base
    - Unavailable or withheld value (exists but is not known)
      - A person has a home phone but does not want it to be listed, so it is withheld and represented as `NULL` in the database.
    - Not applicable (the attribute is undefined for this tupel)
      - Student's name has no middle initials, student has no academic degree, ...
  - Example: primary key
]

#slide[
  #heading(numbering: none)[Constraints on `NULL`]
  - `NULL` values
    - A particular entity may not have an applicable value for an attribute, e.g. apartment number in address
      #figure(image("../assets/img/slides_05/20250306_circle_apt_number_rev01.png"))
    - `NULL` can also be used if we do not know the value of an attribute for a particular entity
]

#slide[
  #heading(numbering: none)[Constraints on `NULL`]
  - Syntax for creating an empty table:
  ```sql
  CREATE TABLE < relationname >
           (<column> <type> [ DEFAULT expr ]
                    [ [NOT] NULL ] [ colconstraint ] *
           [,{<column> <type> [ DEFAULT expr ]
                    [ [NOT] NULL ] [ colconstraint ] *
            | <tableconstraint> } ] *
           ) ;
  ```
]

#slide[
  #heading(numbering: none)[Constraints on `NULL`]
  - `NULL`:
    - "no information available"
    - "no information available yet"
    - "unknown"
    - "not applicable"

  - Examples:
    - Birthdate
    - Apartment Number
    - Minit
]

#slide[
  #heading(numbering: none)[Constraints on `NULL`]
  - `NOT NULL` mandatory field, a value is needed
  - Default: `NULL` optional field, `NULL` is allowed
  - This is always implicitly specified for the attributes of the primary key of each relation
  #memo[
    Attention: Most attributes should be `NOT NULL`!
  ]
]

#slide[
  #heading(numbering: none)[`UNIQUE`]
  - UNIQUE constraint prevents duplicates in a column, i.e., a duplicate entry is not valid in a unique column
  - A *unique key* is a candidate key
  - All the candidate keys of a relation can uniquely identify the records of the relation, but only one of them is used as the primary key of the relation
  - Example: primary key
]

#slide[
  #heading(numbering: none)[`UNIQUE`]
  - Additional identifying attributes: alternate (secondary) keys
  - In SQL: `UNIQUE`
  - Unique elements can be `NULL`
    - ... in some implementations
    - Thinking of key: should not be nullable
      - Unique: could be null (several nulls allowed!)
]


- As column constraint
```sql
Dname VARCHAR(15) UNIQUE;
```

- As table constraint
```sql
CREATE TABLE Department
( Dname VARCHAR(15) NOT NULL Dnumber INT NOT NULL …
PRIMARY KEY ( Dnumber ) ,
UNIQUE ( Dname ),
...);
```
#slide[
  #heading(numbering: none)[Relationship Types]
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
  #heading(numbering: none)[Relationship Types]
  - Participation
    - Specifies whether the existence of an entity depends on its being related to another entity via the relationship type
    - Also called *minimum cardinality constraint*
    - Two types
      - Total: every entity in the total set of all entities of an entity type A must be related to an entity of entity type B via a relationship
        - Total participation is also called *existence dependency*
        - Is displayed as a double line connecting the participating entity type to the relationship
      - Partial: some or part of the entities of an entity type A are related to some entities of an entity type B via a relationship
        - Is displayed by a single line connecting the participating entity type to the relationship336
]

#slide[
  #heading(numbering: none)[Relationship Types]
  - Cardinality
    - specifies the maximum number of relationship instances that an entity can participate in
  - Participation
    - specifies if the existence of an entity depends on its being related to another entity via the relationship type
    - *minimum cardinality constraint*
]

#slide[
  #heading(numbering: none)[Referential Integrity Constraint]
  - It is defined between two relations
  - It is used to maintain the consistency among tules in the two relations: a tuple in one relation that refers to another relation must refer to an existing tuple in that relation
  - *Foreign key*: a set of attributes FK in relation schema $R_1$ is a foreign key of $R_1$ that references relation $R_2$ if it satisfies the following rules:
    1. The attributes in FK have the same domain(s) as the primary key attributes PK of $R_2$; the attributes FK are said to *reference* or *refer to* the relation $R_2$.
    2. A value of FK in a tuple $t_1$ of the current state $r_1(R_1)$ either occurs as a value of PK for some tuple $t_2$ in the current state $r_2(R_2)$ or is `NULL`. In the former case, we have $t_1["FK"] = t_2["FK"]$ , and we say that the tuple $t_1$ references or refers to the tuple $t_2$.
]

#slide[
  #heading(numbering: none)[Foreign Key - Syntax]
  - As Column Constraint
    - Only if the foreign key is one single attribute (and not combined)
  ```sql
  [CONSTRAINT < constraintname > ]
       REFERENCES < tablename >[( column )] [< action >]
  ```

  - As Table Constraint
  ```sql
  [CONSTRAINT < constraintname >]
       FOREIGN KEY (< column list >)
       REFERENCES < tablename >[(< column list >)]
               [< action >]
  ```
]

#slide[
  #heading(numbering: none)[Foreign Key - Syntax]
  ```sql
  CREATE TABLE Department
  ( Dname VARCHAR(15) NOT NULL,
  Dnumber INT NOT NULL,
  Mgr_ssn CHAR(9) REFERENCES Employee(Ssn),
  Mgr_start_date DATE,
  PRIMARY KEY (Dnumber),
  UNIQUE (Dname));
  ```
]

#slide[
  #heading(numbering: none)[Foreign Key - Syntax]
  ```sql
  CREATE TABLE Department
  ( Dname VARCHAR(15) NOT NULL,
  Dnumber INT NOT NULL,
  Mgr_ssn CHAR(9) NOT NULL,
  Mgr_start_date DATE,
  PRIMARY KEY(Dnumber),
  UNIQUE(Dname),
  FOREIGN KEY (Mgr_ssn) REFERENCES Employee (Ssn));
  ```
]

#slide[
  #heading(numbering: none)[Foreign Key - Syntax]
  - `< action >`:
    - How to react on changes to the referenced table
  - The default action: reject the update operation (`RESTRICT` option)
    ```sql
    action ::= ON {UPDATE | DELETE}
    {NO ACTION | SET NULL | SET DEFAULT | CASCADE}
    ```
]

#slide[
  #heading(numbering: none)[Foreign Key]

  - Options:
    - `SET NULL` Value of foreign key is set to `NULL`
    - `SET DEFAULT` Value of foreign key is set to a default value
    - `CASCADE` Value of foreign key is updated
  - For example:
    - `ON DELETE CASCADE` Delete all referencing tuples
    - `ON UPDATE CASCADE` Change Value of the foreign key attribute(s)
  - General Rule for using `CASCADE`:
    - For "relationship" relations
    - For multivalued attributes
    - For relations that represent weak entity types
]

#slide[
  #heading(numbering: none)[Foreign Key]
  ```sql
    CREATE TABLE Employee
  (...,
    Dno INT NOT NULL DEFAULT 1,
    CONSTRAINT EMPPK PRIMARY KEY (Ssn),
    CONSTRAINT EMPSUPERFK FOREIGN KEY (Super_ssn) REFERENCES Employee(Ssn)
      ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT EMPDEPTFK FOREIGN KEY(Dno) REFERENCES Department(Dnumber)
      ON DELETE SET DEFAULT
      ON UPDATE CASCADE);
  ```
]

#slide[
  #heading(numbering: none)[Foreign Key]
  - All constraints get an identifier ... if not by you, then by the system
  - Problems with system generated identifiers Bad error messages
  - Maybe we want to alter or drop the constraint later? Then we need its name!
  - Exception: `NOT NULL` constraints no need for identifier
  - The names of all constraints within a particular schema must be unique
]

#slide[
  #heading(numbering: none)[Foreign Key]
  ```sql
   CREATE TABLE Employee
  (...,
    Dno INT NOT NULL DEFAULT 1,
    CONSTRAINT EMPPK PRIMARY KEY (Ssn),
    CONSTRAINT EMPSUPERFK FOREIGN KEY (Super_ssn) REFERENCES EMPLOYEE(Ssn)
      ON DELETE SET NULL
      ON UPDATE CASCADE,
    CONSTRAINT EMPDEPTFK FOREIGN KEY(Dno) REFERENCES Department(Dnumber)
      ON DELETE SET DEFAULT
      ON UPDATE CASCADE
   );
  ```

]
#slide[
  #heading(numbering: none)[Other Constraints]
  - Semantic integrity constraints
    - Example: The maximum number of hours an employee can work on all projects per week is 56
    - Realization:
      - Within the application programs or
      - Constraint specification language, e.g., trigger and assertions
  - Functional dependencies constraint
    - It establishes a functional relationship among two sets of attributes X and Y
    - This constraint specifies that the value of X determines a unique value of Y in all states of a relation
    - It is denoted as a functional dependency X #sym.arrow Y
]

#slide[
  #heading(numbering: none)[Overview]
  #align(center + horizon)[
    #table(
      columns: (auto, auto),
      align: (center, center),
      fill: (_, y) => if calc.odd(y) { rgb("#438C94").lighten(90%) },
      table.header[*Constraint*][*Number of affected Relations*],
      [Domain constraints], [1],
      [Constraints on `NULL`], [1],
      [Entity integrity constraints (primary key)], [1],
      [Referential integrity constraints], [$eq.lt 1$],
      [Semantic integrity constraints], [$eq.lt 1$],
      [Functional dependencies constraint], [$eq.lt 1$],
    )
  ]
]
= Notation and Guidelines
== ERM
#slide[
  #heading(numbering: none)[Basics]
  #figure(image("../assets/img/slides_05/20250306_symbol_meaning_rev01.jpeg"))
]

#slide[
  #heading(numbering: none)[Basics]
  #figure(image("../assets/img/slides_05/20250306_symbol_meaning_entity_rm_rev01.png"))
]

#slide[
  #heading(numbering: none)[Basics]
  - Names
    - Entity type and relationship type names:
      - uppercase letters
    - Attribute names
      - initial letter capitalized
    - Role names
      - lowercase letters
  - Binary relationship names to make the ER diagram of the schema readable from left to right and from top to bottom
]

#slide[
  #heading(numbering: none)[Basics]
  - In general, the schema design process should be considered an iterative refinement process
  - An attribute may be refined to a relationship if it is a reference to another entity type
  - If an attribute exists in several entity types, it may be promoted to an independent entity type
  - If an entity type A exists in the initial design with a single attribute and is related to only one other entity type B, the entity type A may be reduced or demoted to an attribute of entity type B
]
#slide[
  #heading(numbering: none)[Basics]
  #figure(image("../assets/img/slides_05/20250306_no_circle_emp_dept_rev01.png"))
]

#slide[
  #heading(numbering: none)[UML Notation]
  #figure(image("../assets/img/slides_05/20250306_mc_schema_rev01.png"))
]

#slide[
  #heading(numbering: none)[MC Notation]
  - Participation constraints
  - Relationships can be mandatory or optional
  - Types
    - Exactly one element: 1
    - One or no element: c (or 1c)
    - No or many elements: mc (or nc)
    - One or many elements: m (or n)
      #info[
        Also called must-can notation!
      ]
]

#slide[
  #heading(numbering: none)[MC Notation - Tenary Relationship]
  #example[
    - Manufacturers supply items for projects.
    - A manufacturer must supply at least one item.
    - An article from in-house production does not have to be supplied for a project but can be supplied for many projects.
    - A project uses at least one item.
    - An item is supplied by only one manufacturer for a project.]
  #figure(image("../assets/img/slides_05/20250310_article_supplied_manu_proj_nc_rev01.png"))
]

#slide[
  #heading(numbering: none)[MC Notation - Tenary Relationship]
  #question[
    Cardinality: Can an entity of entity type A and an entity of entity type B be related to multiple entities of entity type C?
  ]
  #question[
    Participation: Must an entity type A be related to at least one entity type B and one entity type C?
  ]
]

#slide[
  #heading(numbering: none)[MC Notation]
  - To prevent students from concentrating on one professor, they may only work with one professor on one seminar topic.
  - In addition, a student can only work on a seminar topic with one professor.
  - However, a professor may assign a seminar topic more than once.
  - Students must attend seminars, but seminar topics do not have to be chosen.
    #figure(image("../assets/img/slides_05/20250310_professor_supp_student_rev01.png"))
]

#slide[
  #heading(numbering: none)[MC Notation - Tenary Relationship]
  #figure(image("../assets/img/slides_06/20250309_head_visits_emp_qual_rev01.jpeg"))
]


#slide[
  #heading(numbering: none)[Comparison ERM and RM]
  - ERM:
    - Conceptual Database Design
    - Describes a collection of *entities*, also called as real-world *objects* and *relations* between those entities
    - Basic elements: *entity type*, *relationship type* and *attributes*
    - *Constraints* like *Cardinality*, *Participation ratio* and *Keys*
    #figure(image("../assets/img/slides_05/20250306_erm_person_livesin_house_rev01.png"))
]

#slide[
  #heading(numbering: none)[Comparison ERM and RM]
  - Relational Model:
    - Logical Database Design
    - Describes data and relation among those data by tables
    - Basic elements: Relations and Attributes
    - Constraints: Domain constraints, key constraints, constraints on `NULL`, entity integrity constraints and referential integrity constraints
    #figure(image("../assets/img/slides_05/20250306_rm_person_house_arrow_rev01.png"))
]

#slide[
  #heading(numbering: none)[Comparison ERM and RM]
  #figure(image("../assets/img/slides_05/20250306_erm_person_livesin_house_rev01.png"))
  #figure(image("../assets/img/slides_05/20250306_rm_person_house_arrow_rev01.png"))
]


#slide[
  #heading(numbering: none)[Comparison ERM and RM]
  #table(
    columns: (auto, auto, auto),
    align: (left, left, left),
    fill: (_, y) => if calc.odd(y) { rgb("#438C94").lighten(90%) },
    table.header[*Aspect*][*ERM*][*RM*],
    [Basic],
    [It represents the collection of objects called entities and relation between those entities],
    [It represents the collection of tables and the relation between those tables],

    [Describe],
    [ERMs describe data as entity set, relationship set and attributes],
    [Relational model describes data in a table as domains, attributes, tuples],

    [Relationship],
    [In an ERM, it is easier to understand the relationships between entities],
    [Comparatively, it is less easy to derive a relation between tables in relational model],

    [Mapping], [ERM describes mapping cardinalities], [Relational model does not describe mapping cardinalities],
  )
]

#slide[
  #heading(numbering: none)[Mapping of ERM to RM]
  Main rules
  - Entity types
    - Mapped to relations
    - Relations contain the attributes
    - Composite attributes: set of simple attributes
  - Relationship Types
    - Foreign keys or
      - Relations plus Foreign keys
]

#slide[
  #heading(numbering: none)[Mapping of ERM to RM]
  - Seven Steps
    1. Mapping of regular entity types
    2. Mapping of weak entity types
    3. Mapping of binary 1:1 relationships
    4. Mapping of binary 1:n relationships
    5. Mapping of binary m:n relationships
    6. Mapping of multivalued attributes
    7. Mapping of n-ary relationships
]

#slide[
  #heading(numbering: none)[Design Guidelines]
- Guideline 1
  - Clear semantics of relation attributes
  - Meaning of attributes should be easy to explain
  - Do not mix attributes from different entity types or relationship types into one relation
  #figure(image("../assets/img/slides_06/20250309_three_circle_bdate_salary_rev01.png"))
]


|                                                                         |                                     |                         |                               |                         |                      |                          |                    |                       | S<br>D   | E<br>o<br>r<br>c<br>e<br>u<br>:<br>t<br>b<br>a<br>a<br>a<br>s<br>e | l<br>i,<br>F<br>m<br>a<br>s<br>r<br>u<br>S<br>t<br>y<br>s<br>e<br>m<br>s, | d<br>t<br>n<br>a<br>m<br>e<br>n<br>a<br>2<br>8<br>6<br>P<br>a<br>g<br>e | f<br>l<br>s<br>o<br>f<br>f<br>38<br>6 |
|-------------------------------------------------------------------------|-------------------------------------|-------------------------|-------------------------------|-------------------------|----------------------|--------------------------|--------------------|-----------------------|----------|--------------------------------------------------------------------|---------------------------------------------------------------------------|-------------------------------------------------------------------------|---------------------------------------|
| Da<br>ba<br>©<br>U<br>lr<br>i<br>ke<br>He<br>ta<br>te<br>se<br>s,<br>rs | ia<br>l<br>ly<br>t<br>r,<br>p<br>ar | ©<br>E<br>lm<br>as<br>r | i<br>Fu<br>da<br>n<br>me<br>" | ls<br>f<br>ta<br>n<br>o | Da<br>ba<br>ta<br>se | Sy<br>te<br>s<br>ms<br>– | Fo<br>r<br>p<br>er | l u<br>so<br>na<br>se | ly<br>on |                                                                    |                                                                           |                                                                         |                                       |

### Guideline 2

- Avoid schemas that cause insertion, deletion, or modification anomalies
- If anomalies are present, note them clearly!
- Someone must take care of them (application, triggers)

![](_page_27_Figure_5.jpeg)

![](_page_28_Figure_1.jpeg)

### Guideline 4

- Avoid relations that contain matching attributes that are not (foreign key, primary key) combinations
- Joining on such attributes may produce *spurious tuples*
- Matching attributes in relations should be (foreign key, primary key) combinations Do not forget the Foreign Keys!

![](_page_29_Picture_5.jpeg)

#### Spurious Tuples

- Combining relations should produce facts only
	- Example:

- Two relations
	- Employee
	- Project
- When joining these relations, we want only tuples for real existing combinations of employees and projects
- Other combinations: *Spurious tuples*
- Spurious tuples are created when two tables are joined on attributes that are neither primary keys nor foreign keys

![](_page_30_Figure_11.jpeg)

**Databases, © Ulrike Herster, partially © Elmasri "Fundamentals of Database Systems – For personal use only**

390 Source: Elmasri, Fundamentals of Database Systems, Page 286ff

![](_page_30_Picture_14.jpeg)

Why don't we put everything in one big table?

| A<br>L<br>L | f<br>P<br>r<br>o<br>e<br>s<br>s<br>o<br>r | L<br>t<br>e<br>c<br>u<br>r<br>e | S<br>t<br>d<br>t<br>u<br>e<br>n | L<br>i<br>t<br>T<br>i<br>t<br>l<br>e<br>r<br>a<br>c<br>y<br>e | S<br>I<br>B<br>N      | S<br>t<br>e<br>m<br>e<br>s<br>e<br>r | … |
|-------------|-------------------------------------------|---------------------------------|---------------------------------|---------------------------------------------------------------|-----------------------|--------------------------------------|---|
|             | S<br>i<br>h<br>t<br>m                     | C<br>+<br>+                     | J<br>h<br>o<br>n                | L<br>C<br>+<br>+<br>e<br>a<br>r<br>n                          | 1<br>2<br>3<br>4<br>5 | 4                                    | … |
|             | S<br>i<br>t<br>h<br>m                     | C<br>+<br>+                     | J<br>l<br>i<br>u<br>e           | C<br>L<br>+<br>+<br>e<br>a<br>r<br>n                          | 1<br>2<br>3<br>4<br>5 | 4                                    | … |
|             | C<br>l<br>l<br>i<br>o<br>n<br>s           | D<br>B<br>M<br>S                | J<br>l<br>i<br>e<br>u           | D<br>b<br>t<br>a<br>a<br>a<br>s<br>e<br>s                     | 2<br>3<br>4<br>6<br>5 | 4                                    | … |
|             | C<br>l<br>l<br>i<br>o<br>n<br>s           | S<br>D<br>B<br>M                | A<br>n<br>n<br>a                | D<br>t<br>b<br>a<br>a<br>a<br>s<br>e<br>s                     | 2<br>3<br>4<br>5<br>6 | 4                                    | … |
|             | …                                         | …                               | …                               | …                                                             | …                     | …                                    | … |

**Databases, © Ulrike Herster, partially © Elmasri "Fundamentals of Database Systems – For personal use only**

![](_page_31_Picture_4.jpeg)

One problem is: Some data is the always the same (E.g., ISBN)

- This problem occurs in nearly all applications
- There are almost one or several attributes, which define the values of the remaining attributes
- This fact is called *functional dependency*
- Functional dependency is relevant in practical applications

| A<br>L<br>L | f<br>P<br>r<br>o<br>e<br>s<br>s<br>o<br>r | L<br>t<br>e<br>c<br>u<br>r<br>e | S<br>t<br>d<br>t<br>u<br>e<br>n | L<br>i<br>t<br>T<br>i<br>t<br>l<br>e<br>r<br>a<br>c<br>y<br>e | S<br>I<br>B<br>N      | S<br>t<br>e<br>m<br>e<br>s<br>e<br>r | … |
|-------------|-------------------------------------------|---------------------------------|---------------------------------|---------------------------------------------------------------|-----------------------|--------------------------------------|---|
|             | S<br>i<br>h<br>t<br>m                     | C<br>+<br>+                     | J<br>h<br>o<br>n                | L<br>C<br>+<br>+<br>e<br>a<br>r<br>n                          | 1<br>2<br>3<br>4<br>5 | 4                                    | … |
|             | S<br>i<br>t<br>h<br>m                     | C<br>+<br>+                     | J<br>l<br>i<br>u<br>e           | C<br>L<br>+<br>+<br>e<br>a<br>r<br>n                          | 1<br>2<br>3<br>4<br>5 | 4                                    | … |
|             | C<br>l<br>l<br>i<br>o<br>n<br>s           | D<br>B<br>M<br>S                | J<br>l<br>i<br>u<br>e           | D<br>b<br>t<br>a<br>a<br>a<br>s<br>e<br>s                     | 2<br>3<br>4<br>6<br>5 | 4                                    | … |
|             | C<br>l<br>l<br>i<br>o<br>n<br>s           | D<br>B<br>M<br>S                | A<br>n<br>n<br>a                | D<br>t<br>b<br>a<br>a<br>a<br>s<br>e<br>s                     | 2<br>3<br>4<br>5<br>6 | 4                                    | … |
|             | …                                         | …                               | …                               | …                                                             | …                     | …                                    | … |

![](_page_32_Picture_7.jpeg)

**Databases, © Ulrike Herster, partially © Elmasri "Fundamentals of Database Systems – For personal use only**

Functional dependencies

- Definition: There is a relational schema called R, and X and Y are any attribute sets of the attributes of R. Then Y is functional dependent on X, noted as X → Y, if and only if every value of X in R defines exactly one value of Y in R
- In other words: Whenever two tuples of relation R match in their X values, then the Y values of these tuples match as well **YX**

| A<br>L<br>L<br>P<br>f<br>S<br>d<br>i<br>T<br>i<br>l<br>I<br>S<br>B<br>N<br>S<br>L<br>t<br>t<br>t<br>L<br>t<br>t<br>t<br>r<br>o<br>e<br>s<br>s<br>o<br>r<br>e<br>c<br>u<br>r<br>e<br>u<br>e<br>n<br>e<br>r<br>a<br>c<br>y<br>e<br>e<br>m<br>e<br>s<br>e<br>r |   |
|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|---|
|                                                                                                                                                                                                                                                             | … |
| S<br>i<br>h<br>C<br>J<br>h<br>L<br>C<br>1<br>2<br>3<br>4<br>5<br>4<br>t<br>+<br>+<br>+<br>+<br>m<br>o<br>n<br>e<br>a<br>r<br>n                                                                                                                              | … |
| S<br>C<br>C<br>i<br>t<br>h<br>J<br>l<br>i<br>L<br>1<br>2<br>3<br>4<br>5<br>4<br>+<br>+<br>+<br>+<br>m<br>u<br>e<br>e<br>a<br>r<br>n                                                                                                                         | … |
| C<br>l<br>l<br>i<br>D<br>B<br>M<br>S<br>J<br>l<br>i<br>D<br>b<br>2<br>3<br>4<br>5<br>6<br>4<br>t<br>o<br>n<br>s<br>e<br>a<br>a<br>a<br>s<br>e<br>s<br>u                                                                                                     | … |
| C<br>S<br>l<br>l<br>i<br>D<br>B<br>M<br>A<br>D<br>t<br>b<br>2<br>3<br>4<br>5<br>6<br>4<br>o<br>n<br>s<br>n<br>n<br>a<br>a<br>a<br>a<br>s<br>e<br>s                                                                                                          | … |
| …<br>…<br>…<br>…<br>…<br>…                                                                                                                                                                                                                                  | … |
|                                                                                                                                                                                                                                                             |   |

**Databases, © Ulrike Herster, partially © Elmasri "Fundamentals of Database Systems – For personal use only**

![](_page_33_Picture_6.jpeg)

Functional dependencies

- Are used to specify formal measures of the "goodness" of relational designs
- Can help to identify redundancy and suggest refinements
- FD: If for 2 tuples X is the same, then Y must also be the same
- Notation: X → Y Read: "X determines Y"
- Generalization of keys
- A key determines all attributes: ൌ

![](_page_34_Picture_8.jpeg)

**Databases, © Ulrike Herster, partially © Elmasri "Fundamentals of Database Systems – For personal use only**

Functional dependencies

- Actual data can help to identify FDs
- Note: FD is a statement about *all allowable* tuples!
- Based on semantics, NOT instances!
- Full functional dependency:
	- X → Y holds only for complete X, not for subset of X
	- You cannot remove an element of X without destroying the FD
	- Opposite: Partial Functional Dependency

![](_page_35_Picture_9.jpeg)

![](_page_36_Picture_1.jpeg)

Source: https://www.youtube.com/ watch?v=Nq91b4TQ29Q

**Databases, © Ulrike Herster, partially © Elmasri "Fundamentals of Database Systems – For personal use only**

![](_page_36_Picture_4.jpeg)

- Normal Forms provide quality statements on relations
- The process of decomposing unsatisfactory "bad" relations by breaking up their attributes into smaller relations
- There are different Normal Forms: 1NF, 2NF, 3NF, BCNF, ...

![](_page_37_Picture_4.jpeg)

#### Example:

| Title                                                    | Author  | Author<br>Nationality | Format                        |                  |     | Price Subject Pages Thickness Publisher |        | Publisher<br>Country | Publication<br>Type | Genre<br>ID | Genre<br>Name |
|----------------------------------------------------------|---------|-----------------------|-------------------------------|------------------|-----|-----------------------------------------|--------|----------------------|---------------------|-------------|---------------|
| Beginning MySQL Database Design and Chad<br>Optimization | Russell | American              | Hardcover 49.99 Database,   . | MySQL,<br>Design | 520 | Thick                                   | Apress | USA                  | E-book              |             | Tutorial      |

Source: https://en.wikipedia.org/wiki/Database\_normalization 398

![](_page_38_Picture_4.jpeg)

![](_page_38_Picture_5.jpeg)

 The *First Normal Form* (1NF) defines that the values in each column of a table must be atomic

 Solution: Separate the duplicities into multiple columns using repeating groups 'subject'

| Title                                               | Author          | Author<br>Nationality | Format                | Price | Subject                           | Pages             | Thickness   Publisher |               | Publisher<br>Country |                       | Publication<br>Type  | Genre<br>ID | Genre<br>Name |
|-----------------------------------------------------|-----------------|-----------------------|-----------------------|-------|-----------------------------------|-------------------|-----------------------|---------------|----------------------|-----------------------|----------------------|-------------|---------------|
| Beginning MySQL Database Design and<br>Optimization | Chad<br>Russell | American              | Hardcover 49.99       |       | MySQL,<br>Database, 520<br>Design |                   | Thick                 | Apress        | USA                  |                       | E-book               | 1           | Tutorial      |
|                                                     |                 |                       |                       |       |                                   |                   |                       |               |                      |                       |                      |             |               |
| Title                                               | Format          | Author                | Author<br>Nationality | Pric  | Subject                           | Subject<br>2      | Subject<br>3          | lages         |                      | Thickness   Publisher | Publisher<br>country | Genre<br>ID | Genre<br>Name |
| Beginning MySQL Database Design<br>and Optimization | Hardcover       | Chad<br>Russell       | American              | 49.9  | MySQL                             | Database   Design |                       | 5 20<br>Thick |                      | Apress                | USA                  | 1           | Tutorial      |

 Disadvantages? 

> Source: https://en.wikipedia.org/wiki/Database\_normalization 399

![](_page_39_Picture_6.jpeg)

#### Alternative Solution:

|  |  |  |                       | W<br>h<br>i<br>i<br>i<br>?<br>t<br>a<br>s<br>m<br>s<br>s<br>n<br>g |                                 |                        |                            |                       |                            |                  |                        |  |  |
|--|--|--|-----------------------|--------------------------------------------------------------------|---------------------------------|------------------------|----------------------------|-----------------------|----------------------------|------------------|------------------------|--|--|
|  |  |  |                       |                                                                    |                                 |                        |                            |                       |                            |                  |                        |  |  |
|  |  |  |                       |                                                                    |                                 |                        |                            |                       |                            |                  |                        |  |  |
|  |  |  | S<br>o<br>u<br>r<br>c | h<br>t<br>e<br>:                                                   | /<br>/<br>t<br>p<br>s<br>:<br>e | i<br>k<br>i<br>n.<br>w | d<br>i<br>p<br>e<br>a<br>o | /<br>i<br>r<br>g<br>w | k<br>i<br>/<br>D<br>t<br>a | b<br>a<br>a<br>s | e_<br>n<br>o<br>r<br>m |  |  |

400

Decomposition to 1NF:

- Composite Attributes
	- Split into single atomic attributes
- Multi-valued Attributes
	- Decompose to new tuples
		- Results in redundancies
		- Further decomposition in following steps

-or

Decompose to new relation with FK

![](_page_41_Picture_10.jpeg)

![](_page_41_Picture_11.jpeg)

- A relation is in Second Normal Form (2NF), if
	- It is in 1NF and

- Every attribute in R is fully functional dependent on every key in R (or is part of the key)
- In other words: If there is a key with different attributes (e.g., title and format) and an attribute depends on just a part of this key (e.g., title), then the second Normal Form is violated
- To create the Second Normal Form, you must decompose the relation: Depending attribute with part of key in new relation, delete depending attribute in old relation

![](_page_42_Picture_6.jpeg)

| Book                                                                           |           |              |                                                   |  |            |        |  |       |   |                     |              |  |  |  |
|--------------------------------------------------------------------------------|-----------|--------------|---------------------------------------------------|--|------------|--------|--|-------|---|---------------------|--------------|--|--|--|
| Title                                                                          | Format    | Author       | Author Nationalty Price Frages Thickness Genre ID |  |            |        |  |       |   | Genre Name          | Publisher ID |  |  |  |
| Beginning MySQL Database Design and Optimization                               | Hardcover | Chad Russell | American                                          |  | 49.99 520  |        |  | Thick |   | Tutorial            |              |  |  |  |
| Beginning MySQL Database Design and Optimization                               | E-book    | Chad Russell | American                                          |  | 22.34 520  |        |  | Thick |   | Tutorial            |              |  |  |  |
| The Relational Model for Database Management: Version 2   E-book               |           | E.F.Codd     | British                                           |  | 13.88 5 38 |        |  | Thick | 2 | Popular science   2 |              |  |  |  |
| The Relational Model for Database Management: Version 2   Paperback   E.F.Codd |           |              | British                                           |  | 39.99      | 1 5 38 |  | Thick | 2 | Popular science   2 |              |  |  |  |

#### Primary key: Title + Format

#### Functional dependencies: Title Author

 Title Author NationalityTitle, Format Price Title Pages Title Thickness Title GenreID Title Genre Name Title Publisher ID

403Source: https://en.wikipedia.org/wiki/ Database\_normalization

![](_page_43_Picture_6.jpeg)

![](_page_43_Picture_7.jpeg)

| Book                                                                           |           |                         |                                                   |  |            |      |  |       |   |                 |              |  |  |
|--------------------------------------------------------------------------------|-----------|-------------------------|---------------------------------------------------|--|------------|------|--|-------|---|-----------------|--------------|--|--|
| Title                                                                          | Format    | Author                  | Author Nationalty Price Plages Thickness Genre ID |  |            |      |  |       |   | Genre Name      | Publisher ID |  |  |
| Beginning MySQL Database Design and Optimization                               | Hardcover | Chad Russell American   |                                                   |  | 49.99      | 5 20 |  | Thick |   | Tutorial        |              |  |  |
| Beginning MySQL Database Design and Optimization                               | E-book    | Chad Russell   American |                                                   |  | 22.34      | 5 20 |  | Thick |   | Tutorial        |              |  |  |
| The Relational Model for Database Management: Version 2   E-book               |           | E.F.Codd                | British                                           |  | 13.88 5 88 |      |  | Thick | 2 | Popular science |              |  |  |
| The Relational Model for Database Management: Version 2   Paperback   E.F.Codd |           |                         | British                                           |  | 39.99      | 588  |  | Thick | 2 | Popular science | 2            |  |  |

![](_page_44_Figure_2.jpeg)

Source: https://en.wikipedia.org/wiki/Database\_normalization 404

![](_page_44_Picture_4.jpeg)

![](_page_44_Picture_5.jpeg)

Decomposition to Second Normal Form

- Has the relation in 1NF following design (keyPart1, keyPart2, noKey1, noKey2) and there is a functional dependency FD: keyPart2 → noKey2
- Then the decomposition respecting this FD results in following schema: (keyPart1, keyPart2, noKey1) (keyPart2, noKey2)

![](_page_45_Picture_4.jpeg)

Decomposition to Second Normal Form

 Has the relation in 1NF following design (keyPart1, keyPart2, noKey1, noKey2) and there is a functional dependency FD: keyPart2 → noKey2 

| Book                                                                           |           |                         |                                                   |           |  |       |   |                     |              |  |
|--------------------------------------------------------------------------------|-----------|-------------------------|---------------------------------------------------|-----------|--|-------|---|---------------------|--------------|--|
| Title                                                                          | Format    | Author                  | Author Nationality Price Pages Thickness Genre ID |           |  |       |   | Genre Name          | Publisher ID |  |
| Beginning MySQL Database Design and Optimization                               | Hardcover | Chad Russell   American |                                                   | 49.99 520 |  | Thick |   | Tutorial            |              |  |
| Beginning MySQL Database Design and Optimization                               | E-book    | Chad Russell   American |                                                   | 22.34 520 |  | Thick |   | Tutorial            |              |  |
| The Relational Model for Database Management: Version 2   E-book               |           | E.F.Codd                | British                                           | 13.88 538 |  | Thick | 2 | Popular science     |              |  |
| The Relational Model for Database Management: Version 2   Paperback   E.F.Codd |           |                         | British                                           | 39.99 538 |  | Thick | 2 | Popular science   2 |              |  |

Source: https://en.wikipedia.org/wiki/Database\_normalization

**Databases, © Ulrike Herster, partially © Elmasri "Fundamentals of Database Systems – For personal use only**

![](_page_46_Picture_6.jpeg)

Decomposition to Second Normal Form

 Then the decomposition respecting this FD results in following schema: (keyPart1, keyPart2, noKey1) (keyPart2, noKey2) 

![](_page_47_Figure_3.jpeg)

The Third Normal Form (3NF) describes the problem 

- Informal: A relation is in 3NF if every tuple consists of a primary key and a set of other attributes that are independent of each other
- Formal: A relation is in 3NF if
	- It is in 2NF and
	- Every non-primary-key attribute is directly dependent on the primary key (especially no transitive dependencies)
- In other words: A table in third normal form (3NF) is a table in 2NF that has no transitive dependencies

![](_page_48_Picture_7.jpeg)

Transitive Dependency

- Z is transitive dependent on X, if
	- X → Y → Z

- But not Y → X
- Second condition important: not a transitive dependency if X and Y are both keys!

![](_page_49_Picture_6.jpeg)

409

| Book                                                               |                             |                                                   |     |       |   |                 |              |  |  |
|--------------------------------------------------------------------|-----------------------------|---------------------------------------------------|-----|-------|---|-----------------|--------------|--|--|
| Title                                                              | Author                      | Author Nationality   Pages   Thickness   Genre ID |     |       |   | Genre Name      | Publisher ID |  |  |
| Beginning MySQL Database Design and Optimization                   | Chad Russell                | American                                          | 520 | Thick |   | Tutorial        |              |  |  |
| The Relational Model for Database Management: Version 2   E.F.Codd |                             | British                                           | 538 | Thick | 2 | Popular science |              |  |  |
| Learning SQL                                                       | Alan Beaulieu               | American                                          | 338 | Slim  |   | Tutorial        |              |  |  |
| SQL Cookbook                                                       | Anthony Molinaro   American |                                                   | 636 | Thick |   | Tutorial        |              |  |  |

#### Functional dependencies:

![](_page_50_Picture_3.jpeg)

Source: https://en.wikipedia.org/wiki/Database\_normalization

**Databases, © Ulrike Herster, partially © Elmasri "Fundamentals of Database Systems – For personal use only**

![](_page_50_Picture_6.jpeg)

|                                                                    |                  | Book                                        |     |       |   |                 |              |
|--------------------------------------------------------------------|------------------|---------------------------------------------|-----|-------|---|-----------------|--------------|
| Title                                                              | Author           | Author Nationality Pages Thickness Genre ID |     |       |   | Genre Name      | Publisher ID |
| Beginning MySQL Database Design and Optimization                   | Chad Russell     | American                                    | 520 | Thick |   | Tutorial        |              |
| The Relational Model for Database Management: Version 2   E.F.Codd |                  | British                                     | 538 | Thick | 2 | Popular science |              |
| Learning SQL                                                       | Alan Beaulieu    | American                                    | 338 | Slim  |   | Tutorial        |              |
| SQL Cookbook                                                       | Anthony Molinaro | American                                    | 636 | Thick |   | Tutorial        |              |

![](_page_51_Picture_2.jpeg)

| Title                                                              | Author                      | Author Nationality Pages Thickness Genre ID Publisher ID |     |       |   |   |          | Book Genres     |
|--------------------------------------------------------------------|-----------------------------|----------------------------------------------------------|-----|-------|---|---|----------|-----------------|
| Beginning MySQL Database Design and Optimization                   | Chad Russell                | American                                                 | 520 | Thick |   |   | Genre ID | Genre Name      |
| The Relational Model for Database Management: Version 2   E.F.Codd |                             | British                                                  | 538 | Thick | 2 | 2 |          | Tutorial        |
| Learning SQL                                                       | Alan Beaulieu               | American                                                 | 338 | Slim  |   | 3 |          | Popular science |
| SQL Cookbook                                                       | Anthony Molinaro   American |                                                          | 636 | Thick |   | 3 |          |                 |

Source: https://en.wikipedia.org/wiki/Database\_normalization

![](_page_51_Picture_5.jpeg)

411

Decomposition to Third Normal Form

- The relation in 2NF has the schema (KeyPart1, NonKey1, NonKey2) and there is a functional dependency FD: NonKey1 → NonKey2
- Then the decomposition results in a new schema, which is in Third Normal Form (KeyPart1, NonKey1) (NonKey1, NonKey2)

![](_page_52_Picture_4.jpeg)

Decomposition to Third Normal Form

 The relation in 2NF has the schema (KeyPart1, NonKey1, NonKey2) and there is a functional dependency FD: NonKey1 → NonKey2 

|                                                                    | Book             |                                                   |     |       |   |                 |              |  |
|--------------------------------------------------------------------|------------------|---------------------------------------------------|-----|-------|---|-----------------|--------------|--|
| Title                                                              | Author           | Author Nationality   Pages   Thickness   Genre ID |     |       |   | Genre Name      | Publisher ID |  |
| Beginning MySQL Database Design and Optimization                   | Chad Russell     | American                                          | 520 | Thick |   | Tutorial        |              |  |
| The Relational Model for Database Management: Version 2   E.F.Codd |                  | British                                           | 538 | Thick | 2 | Popular science |              |  |
| Learning SQL                                                       | Alan Beaulieu    | American                                          | 338 | Slim  |   | Tutorial        |              |  |
| SQL Cookbook                                                       | Anthony Molinaro | American                                          | 636 | Thick |   | Tutorial        | 3            |  |

Source: https://en.wikipedia.org/wiki/Database\_normalization

![](_page_53_Picture_7.jpeg)

### Decomposition to Third Normal Form

 Then the decomposition results in a new schema, which is in Third Normal Form (KeyPart1, NonKey1) (NonKey1, NonKey2) 

| Title                                                              | Author                      | Author Nationality Pages Thickness   Genre ID |     |       |   | Genre Name      | Publisher ID |
|--------------------------------------------------------------------|-----------------------------|-----------------------------------------------|-----|-------|---|-----------------|--------------|
| Beginning MySQL Database Design and Optimization                   | Chad Russell                | American                                      | 520 | Thick |   | Tutorial        |              |
| The Relational Model for Database Management: Version 2   E.F.Codd |                             | British                                       | 538 | Thick | 2 | Popular science |              |
| Learning SQL                                                       | Alan Beaulieu               | American                                      | 338 | Slim  |   | Tutorial        | 3            |
| SQL Cookbook                                                       | Anthony Molinaro   American |                                               | 636 | Thick |   | Tutorial        | 3            |

![](_page_54_Picture_4.jpeg)

|  |  |  |  |  |  |  |  |  |  | 41<br>4 |  |  |  |  |
|--|--|--|--|--|--|--|--|--|--|---------|--|--|--|--|
|  |  |  |  |  |  |  |  |  |  |         |  |  |  |  |

**Databases, © Ulrike Herster, partially © Elmasri "Fundamentals of Database Systems – For personal use only** Source: https://en.wikipedia.org/wiki/Database\_normalization

**For normalization, use functional dependencies!!!**

**And not the semantics of the attributes!!!**

![](_page_55_Picture_3.jpeg)

**Databases, © Ulrike Herster, partially © Elmasri "Fundamentals of Database Systems – For personal use only**

![](_page_55_Picture_5.jpeg)

- A relational schema R is in Boyce-Codd normal form (BCNF) if, for every one of its dependencies X → Y, one of the following conditions hold true:
	- X → Y is a trivial functional dependency (i.e., Y is a subset of X)
	- X is a super key for schema R

- Focusses on FDs within key attributes
- Every relation in BCNF is in 3NF, too ... but not the other way round
- Informally: To test whether a relation is in BCNF, identify all the determinants and make sure that they are candidate keys

![](_page_56_Figure_7.jpeg)

Source: https://www.geeksforgeeks.org/boyce-codd-normal-form-bcnf/ 416

![](_page_56_Picture_9.jpeg)

![](_page_56_Picture_11.jpeg)

|                                                                                                                                                                                                                              | UNF    | 1NF    | 2NF    | 3NF    |
|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|--------|--------|--------|--------|
|                                                                                                                                                                                                                              | (1970) | (1970) | (1971) | (1971) |
| Primary key (no duplicate tuples)                                                                                                                                                                                            | 1      | V      | S      | 1      |
| No repeating groups                                                                                                                                                                                                          | >      | 1      | 1      | 1      |
| Atomic columns (cells have single value)[8]                                                                                                                                                                                  | 23     | 1      | 1      | 1      |
| Every non-trivial functional dependency either does not begin with a proper subset of a candidate key<br>or ends with a prime attribute (no partial functional dependencies of non-prime attributes on<br>candidate keys)18] | X      | 24     | 1      | 1      |
| Every non-trivial functional dependency either begins with a superkey or ends with a prime attribute<br>(no transitive functional dependencies of non-prime attributes on candidate keys)181                                 | X      | 24     | X      | 1      |
| Every non-trivial functional dependency either begins with a superkey or ends with an elementary<br>prime attributel8]                                                                                                       | X      | X      | X      | X      |
| Every non-trivial functional dependency begins with a superkey(8)                                                                                                                                                            | X      | X      | X      | X      |
| Every non-trivial multivalued dependency begins with a superkey(8)                                                                                                                                                           | X      | X      | X      | X      |
| Every join dependency has a superkey component®]                                                                                                                                                                             | X      | X      | X      | X      |
| Every join dependency has only superkey components(8)                                                                                                                                                                        | X      | X      | X      | X      |
| Every constraint is a consequence of domain constraints and key constraints 101                                                                                                                                              | X      | X      | X      | X      |
| Every join dependency is trivial(8]                                                                                                                                                                                          | X      | X      | X      | X      |

Source: https://en.wikipedia.org/wiki/Database\_normalization 417

![](_page_57_Picture_3.jpeg)

#### **There should be atomic attribute values only!**

#### Disallows:

- composite attributes
- multivalued attributes
- nested relations
- PK determines every atomic attribute value
- In SQL-92 it's not possible to have relations in Non First Normal Form (NFNF)

![](_page_58_Picture_8.jpeg)

#### **Relation is in 1NF and every nonkey attribute is full functional dependent on the key!**

- No nonkey attribute should be functionally dependent on a part of the primary key
- Applies only to relations where the PK contains multiple attributes

![](_page_59_Picture_5.jpeg)

#### **There should be no transitive dependency of a nonkey attribute on the primary key!**

- No nonkey attribute has a FD on another nonkey attribute
- Relation needs to be in 1NF and 2NF

![](_page_60_Picture_4.jpeg)

![](_page_60_Picture_5.jpeg)

#### **NOTATIONS AND GUIDELINES NORMALIZATION – RULES FOR DECOMPOSITION**

- Should be lossless
- Tuples of the original relation can be restored when joining the decomposed relations
- Functional dependencies should be preserved in one of the decomposed relations
- ... so original FDs can be restored

![](_page_61_Picture_6.jpeg)

#### **NOTATIONS AND GUIDELINES ASSIGNMENT: TRANSFORM THE TABLE INTO 1NF, 2NF, AND 3NF**

| Student<br>No | Student<br>Name | Major | Course   Course<br>No | Name                  | Instr Instr<br>No | Name                        | Instr<br>LOC      | Grade       |
|---------------|-----------------|-------|-----------------------|-----------------------|-------------------|-----------------------------|-------------------|-------------|
| 123           | Smith           | DB    | 1<br>2<br>3           | DB<br>Math<br>Physics | 456<br>567<br>678 | Jason<br>Meyer<br>Fish      | R04<br>R01<br>R02 | 1<br>1<br>2 |
| 234           | Jones           | Math  | 1<br>2<br>4           | DB<br>Math<br>OP      | 456<br>567<br>789 | Jason<br>Meyer<br>Dench R07 | R04<br>R01        | 2<br>1<br>3 |

**Databases, © Ulrike Herster, partially © Elmasri "Fundamentals of Database Systems – For personal use only**

![](_page_62_Picture_3.jpeg)

#### **NOTATIONS AND GUIDELINES ASSIGNMENT: TRANSFORM THE TABLE INTO 1NF, 2NF, AND 3NF**

| Fu<br>l<br>l_<br>Na<br>m<br>e          | P<br>hy<br>ica<br>l<br>A<br>d<br>dr<br>s<br>es<br>s            | Mo<br>ies<br>Re<br>te<br>d<br>v<br>n                                                                                                      | Sa<br>lu<br>ta<br>t<br>io<br>n |
|----------------------------------------|----------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------|--------------------------------|
| Ja<br>t<br>Jo<br>ne<br>ne<br>s         | S<br>F<br>irs<br>t<br>tre<br>t<br>P<br>lo<br>t<br>No<br>4<br>e | f<br>Ca<br>P<br>ira<br>te<br>t<br>he<br>i<br>b<br>be<br>s o<br>r<br>an<br>,<br>C<br>f<br>las<br>h o<br>t<br>he<br>T<br>i<br>ta<br>ns      | Ms                             |
| Ro<br>be<br>P<br>h<br>i<br>l<br>t<br>r | rd<br>3<br>S<br>No<br>3<br>4<br>tre<br>t<br>e                  | Fo<br>ing<br>Sa<br>h<br>Ma<br>ha<br>l,<br>t<br>t<br>rg<br>e<br>ra<br>rs<br>Da<br>d<br>dy<br>'s<br>L<br>i<br>le<br>G<br>ir<br>ls<br>t<br>t | M<br>r.                        |
| Ro<br>be<br>t<br>P<br>h<br>i<br>l<br>r | th<br>5<br>Av<br>No<br>4<br>en<br>ue                           | C<br>las<br>h o<br>f<br>t<br>he<br>T<br>i<br>ta<br>ns                                                                                     | M<br>r.                        |

**Databases, © Ulrike Herster, partially © Elmasri "Fundamentals of Database Systems – For personal use only**

![](_page_63_Picture_3.jpeg)
= License Notice

== Attribution

- This work is shared under the CC BY-NC-SA 4.0 License and the respective Public
  License.
- #link("https://creativecommons.org/licenses/by-nc-sa/4.0/")
- This work is based off of the work by Prof. Dr. Ulrike Herster.
- Some of the images and texts, as well as the layout were changed.
- The base material was supplied in private, therefore the link to the source
  cannot be shared with the audience.
