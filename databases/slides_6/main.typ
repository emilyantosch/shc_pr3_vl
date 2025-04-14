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
    subtitle: [Lecture 6 - Design Guideline],
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

- Last time, we looked at constraints and notations.
- Today, we'll be discussing
  - what guidelines exists that allow you to design databases
  - how you can use a cookbook to always create great data storage in databases
  - what normalization is.

#slide[
  1. Introduction
  2. Basics
  3. SQL
  4. Entity-Relationship-Model
  5. Relationships
  6. Constraints
  7. *Notation & Guideline*
  8. More SQL
  9. Subqueries & Views
  10. Transactions
  11. Database Applications
  12. Integrity, Trigger & Security
]

== What is the goal of this chapter?
#slide[
  - At the end of this lesson, you will be able to
    - create databases based on guidelines
    - use normalization to design tables and relations.
]

= Relationships
== Assignment Journal
#slide[
  #heading(numbering: none)[Convert the ERD to a RM]
  #figure(image("../assets/img/slides_06/20250310_person_sub_journal_steps_rev01.png"))
]

#slide[
  #heading(numbering: none)[Implement RM with SQL]
  #figure(image("../assets/img/slides_06/20250309_code_person_subscribes_journal_rev01.png"))
]

== ERM
#slide[
  #heading(numbering: none)[MC Notation - Tenary Relationship]
  #example[
    - Manufacturers supply items for projects.
    - A manufacturer must supply at least one item.
    - An article from in-house production does not have to be supplied for a project but can be supplied for many projects.
    - A project uses at least one item.
    - An item is supplied by only one manufacturer for a project.
  ]
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
  #heading(numbering: none)[Tenary Relationship Types]
  #figure(image("../assets/img/slides_06/20250309_article_supp_manu_assign_rev01.png"))
]

#slide[
  #heading(numbering: none)[Tenary Relationship Types]
  #figure(image("../assets/img/slides_06/20250309_article_supplied_manu_binary_rel_rev01.png"))
]

#slide[
  #heading(numbering: none)[Mapping of N-ary Relationship Types]
  #figure(image("../assets/img/slides_05/20250306_supplier_supply_proj_arrow_rev01.jpeg"))
]

#slide[
  #heading(numbering: none)[UML Notation]
  #figure(image("../assets/img/slides_05/20250306_mc_schema_rev01.png"))
]

#slide[
  #heading(numbering: none)[Summary]
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
== Overview
#slide[
  #heading(numbering: none)[Basics]
  - Three categories
    1. Constraints that are inherent in the data model *inherent model-based constraints* or *implicit constraints* Example: no duplicate tuples in a relation
    2. Constraints that can be directly expressed in schemas of the data model *schema-based constraints* or *explicit constraints* Example: Domain constraints, key constraints, constraints on NULL, entity integrity constraints and referential integrity constraints
    3. Constraints that cannot be directly expressed in the schemas of the data model, and hence must be expressed and enforced by the application programs *application-based* or *semantic constraints* or *business rules*
]

#slide[
  #heading(numbering: none)[Basics]
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

= Notation & Guidelines
== ERM
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
  #heading(numbering: none)[MC Notation]
  - Every person owns no, one, or more bikes Every bike has exactly one owner.
    #figure(image("../assets/img/slides_05/20250306_person_owns_bike_rev01.jpeg"))
  - A person is married to no or exactly one person
    #figure(image("../assets/img/slides_05/20250306_person_married_to_rev01.jpeg"))
]

#slide[
  #heading(numbering: none)[MC Notation]
  - Binary 1:N Relationships
    - Chen Notation
    #figure(image("../assets/img/slides_05/20250310_person_livesin_house_n1_rev01.png"))
    - MC Notation
    #figure(image("../assets/img/slides_05/20250306_person_livesin_house_rev01.jpeg"))
]

#slide[
  #heading(numbering: none)[MC Notation]
  - CEO - Company ?:?
  - Country - King ?:?
  - University - Student ?:?
  - Person - Car ?:?
  - Student - Course ?:?
  - Customer - Article ?:?
  - Customer - Invoice ?:?
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
  #heading(numbering: none)[MC Notation]
  #figure(image("../assets/img/slides_05/20250306_head_visits_emp_rev01.jpeg"))
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
]

#slide[
  #heading(numbering: none)[Design Guidelines]
  - Guideline 2
    - Avoid schemas that cause insertion, deletion, or modification anomalies
    - If anomalies are present, note them clearly!
    - Someone must take care of them (application, triggers)
]

#slide[
  #heading(numbering: none)[Design Guideline]
  #let left = [

    - Guideline 3
      - Avoid attributes whose values are frequently NULL
      - NULL values should be the exception
      - Attributes that are NULL frequently could be placed in separate relations (with the primary key): 1:c
      #example[
        Attribute Office if only 15 percent of employees have individual offices
      ]
  ]
  #let right = [

    #figure(image("../assets/img/slides_06/20250309_circle_office_emp_rev01.png"))
  ]
  #grid(
    columns: (auto, auto),
    gutter: 0.25em,
    left, right,
  )
]


#slide[
  #heading(numbering: none)[Design Guideline]
  - Guideline 4
    - Avoid relations that contain matching attributes that are not (foreign key, primary key) combinations
    - Joining on such attributes may produce *spurious tuples*
    - Matching attributes in relations should be (foreign key, primary key) combinations Do not forget the Foreign Keys!
]

#slide[
  #heading(numbering: none)[Design Guideline - Spurious Tuples]
  - Combining relations should produce facts only
    #example[
      - Two relations
        - Employee
        - Project
      - When joining these relations, we want only tuples for real existing combinations of employees and projects
      - Other combinations: *Spurious tuples*
    ]
  - Spurious tuples are created when two tables are joined on attributes that are neither primary keys nor foreign keys
]

#slide[
  #heading(numbering: none)[Design Guidelines]
  Why don't we put everything in one big table?
  #figure(image("../assets/img/slides_06/20250309_all_table_prof.png"))
]

#slide[
  #heading(numbering: none)[Design Guidelines]
  - One problem is: Some data is the always the same (E.g., ISBN)
    - This problem occurs in nearly all applications
    - There are almost one or several attributes, which define the values of the remaining attributes
    - This fact is called *functional dependency*
    - Functional dependency is relevant in practical applications
    #figure(image("../assets/img/slides_06/20250309_all_table_prof.png"))
]

#slide[
  #heading(numbering: none)[Design Guidelines - Functional Dependencies]
  - Definition: There is a relational schema called R, and X and Y are any attribute sets of the attributes of R. Then Y is functional dependent on X, noted as X → Y, if and only if every value of X in R defines exactly one value of Y in R
  - In other words: Whenever two tuples of relation R match in their X values, then the Y values of these tuples match as well
    #figure(image("../assets/img/slides_06/20250309_brackets_y_x_rev01.png"))
]



#slide[
  #heading(numbering: none)[Design Guidelines - Functional Dependencies]
  - Are used to specify formal measures of the "goodness" of relational designs
  - Can help to identify redundancy and suggest refinements
  - FD: If for 2 tuples X is the same, then Y must also be the same
  - Notation: X → Y Read: "X determines Y"
  - Generalization of keys
  - A key determines all attributes: ൌ
]

#slide[
  #heading(numbering: none)[Design Guidelines - Functional Dependencies]
  - Actual data can help to identify FDs
  - Note: FD is a statement about *all allowable* tuples!
  - Based on semantics, NOT instances!
  - Full functional dependency:
    - X → Y holds only for complete X, not for subset of X
    - You cannot remove an element of X without destroying the FD
    - Opposite: Partial Functional Dependency
]

#slide[
  #heading(numbering: none)[Normalization]
  - Normal Forms provide quality statements on relations
  - The process of decomposing unsatisfactory "bad" relations by breaking up their attributes into smaller relations
  - There are different Normal Forms: 1NF, 2NF, 3NF, BCNF, ...
]

#slide[
  #heading(numbering: none)[Normalization]
  #figure(image("../assets/img/slides_06/20250309_no_circle_mysql_opti_rev01.png"))
]

#slide[
  #heading(numbering: none)[Normalization - 1NF]
  - The *First Normal Form* (1NF) defines that the values in each column of a table must be atomic
  - Solution: Separate the duplicities into multiple columns using repeating groups 'subject'
    #figure(image("../assets/img/slides_06/20250309_two_circle_subject_1_2_3_rev01.png"))
    #question[
      What are the disadvantages?
    ]
]

#slide[
  #heading(numbering: none)[Normalization - 1NF]
  - Alternative Solution:
    #figure(image("../assets/img/slides_06/20250309_three_circle_subject_title_rev01.png"))
]


#slide[
  #heading(numbering: none)[Normalization - 1NF]
  - Alternative Solution:
    #figure(image("../assets/img/slides_06/20250309_three_circle_subject_title_rev01.png"))
]

#slide[
  #heading(numbering: none)[Normalization - 1NF]
  - Decomposition to 1NF:
    - Composite Attributes
      - Split into single atomic attributes
    - Multi-valued Attributes
      - Decompose to new tuples
        - Results in redundancies
        - Further decomposition in following steps
  - or decompose to new relation with FK
]

#slide[
  #heading(numbering: none)[Normalization - 2NF]
  - A relation is in *Second Normal Form* (2NF), if
    - It is in 1NF and
    - Every attribute in R is fully functional dependent on every key in R (or is part of the key)
  - In other words: If there is a key with different attributes (e.g., title and format) and an attribute depends on just a part of this key (e.g., title), then the second Normal Form is violated
  - To create the Second Normal Form, you must decompose the relation: Depending attribute with part of key in new relation, delete depending attribute in old relation
]

#slide[
  #heading(numbering: none)[Normalization - 2NF]
  #figure(image("../assets/img/slides_06/20250309_circle_price_table_rev01.png"))
  - Primary key: Title + Format
  - Functional dependencies:
    - Title #sym.arrow Author
    - Title #sym.arrow Author Nationality
    - Title, Format #sym.arrow Price
    - Title #sym.arrow Pages
    - Title #sym.arrow Thickness
    - Title #sym.arrow GenreID
    - Title #sym.arrow GenreName
    - Title #sym.arrow PublisherID
]

#slide[
  #heading(numbering: none)[Normalization - 2NF]
  #figure(image("../assets/img/slides_06/20250309_two_circle_price_format_rev01.png"))
]

#slide[
  #heading(numbering: none)[Normalization - 2NF]
  - Decomposition to Second Normal Form
    - Has the relation in 1NF following design (keyPart1, keyPart2, noKey1, noKey2) and there is a functional dependency FD: keyPart2 → noKey2
    - Then the decomposition respecting this FD results in following schema: (keyPart1, keyPart2, noKey1) (keyPart2, noKey2)
]

#slide[
  #heading(numbering: none)[Normalization - 2NF]
  - Decomposition to Second Normal Form
    - Has the relation in 1NF following design (keyPart1, keyPart2, noKey1, noKey2) and there is a functional dependency FD: keyPart2 → noKey2
    #figure(image("../assets/img/slides_06/20250309_nocircle_book_title_table_rev01.png"))
]

#slide[
  #heading(numbering: none)[Normalization - 2NF]
  - Decomposition to Second Normal Form
    - Then the decomposition respecting this FD results in following schema: (keyPart1, keyPart2, noKey1) (keyPart2, noKey2)
    #figure(image("../assets/img/slides_06/20250309_two_circle_price_format_rev01.png"))
]

#slide[
  #heading(numbering: none)[Normalization - 3NF]
  - The *Third Normal Form* (3NF) describes the problem
    - Informal: A relation is in 3NF if every tuple consists of a primary key and a set of other attributes that are independent of each other
    - Formal: A relation is in 3NF if
      - It is in 2NF and
      - Every non-primary-key attribute is directly dependent on the primary key (especially no transitive dependencies)
    - In other words: A table in third normal form (3NF) is a table in 2NF that has no transitive dependencies
]

#slide[
  #heading(numbering: none)[Normalization - 3NF]
  Transitive Dependency
  - Z is transitive dependent on X, if
    - X → Y → Z
    - But not Y → X
  - Second condition important: not a transitive dependency if X and Y are both keys!
]

#slide[
  #heading(numbering: none)[Normalization - 3NF]
  Transitive Dependency
  - Z is transitive dependent on X, if
    - X → Y → Z
    - But not Y → X
  - Second condition important: not a transitive dependency if X and Y are both keys!
]

#slide[
  #heading(numbering: none)[Normalization - 3NF]
  #figure(image("../assets/img/slides_06/20250309_circle_genre_id_genre_name_rev01.png"))
  - Functional dependencies:
    - Title #sym.arrow Author
    - Title #sym.arrow Author Nationality #sym.arrow Author
    - Title, Format #sym.arrow Price
    - Title #sym.arrow Pages
    - Title #sym.arrow Thickness
    - Title #sym.arrow GenreID
    - Title #sym.arrow GenreName #sym.arrow GenreID
    - Title #sym.arrow PublisherID
]

#slide[
  #heading(numbering: none)[Normalization - 3NF]
  #figure(image("../assets/img/slides_06/20250309_two_circle_genre_id_genre_name_rev01.png"))
]

#slide[
  #heading(numbering: none)[Normalization - 3NF]
  - Decomposition to Third Normal Form
    - The relation in 2NF has the schema (KeyPart1, NonKey1, NonKey2) and there is a functional dependency FD: NonKey1 → NonKey2
    - Then the decomposition results in a new schema, which is in Third Normal Form (KeyPart1, NonKey1) (NonKey1, NonKey2)
]

#slide[
  #heading(numbering: none)[Normalization - 3NF]
  - Decomposition to Third Normal Form
    - The relation in 2NF has the schema (KeyPart1, NonKey1, NonKey2) and there is a functional dependency FD: NonKey1 → NonKey2
    #figure(image("../assets/img/slides_06/20250309_circle_genre_id_genre_name_rev01.png"))
]

#slide[
  #heading(numbering: none)[Normalization - 3NF]
  - Decomposition to Third Normal Form
    - Then the decomposition results in a new schema, which is in Third Normal Form (KeyPart1, NonKey1) (NonKey1, NonKey2)
    #figure(image("../assets/img/slides_06/20250309_circle_genre_id_genre_name_rev01.png"))
]

#slide[
  #heading(numbering: none)[Normalization]
  #memo[
    *For normalization, use functional dependencies. And not the semantics of the attributes!*
  ]
]

#slide[
  #heading(numbering: none)[Normalization - BCNF]
  #let left = [
    - A relational schema R is in Boyce-Codd normal form (BCNF) if, for every one of its dependencies X → Y, one of the following conditions hold true:
      - X → Y is a trivial functional dependency (i.e., Y is a subset of X)
      - X is a super key for schema R
    - Focusses on FDs within key attributes
    - Every relation in BCNF is in 3NF, too ... but not the other way round
    - Informally: To test whether a relation is in BCNF, identify all the determinants and make sure that they are candidate keys
  ]
  #let right = [
    #figure(image("../assets/img/slides_06/20250309_1nf_2nf_bcnf_rev01.jpeg"))
  ]
  #grid(
    columns: (auto, auto),
    gutter: 0.25em,
    left, right,
  )
]

#slide[
  #heading(numbering: none)[Normalization - BCNF]
  #figure(image("../assets/img/slides_06/20250309_1nf_2nf_rev01.png"))
]

#slide[
  #heading(numbering: none)[Normalization - 1NF]
  - *There should be atomic attribute values only!*
  - Disallows:
    - composite attributes
    - multivalued attributes
    - nested relations
  - PK determines every atomic attribute value
  - In SQL-92 it's not possible to have relations in Non First Normal Form (NFNF)
]
#slide[
  #heading(numbering: none)[Normalization - 2NF]
  - *Relation is in 1NF and every nonkey attribute is full functional dependent on the key!*
    - No nonkey attribute should be functionally dependent on a part of the primary key
    - Applies only to relations where the PK contains multiple attributes
]

#slide[
  #heading(numbering: none)[Normalization - 3NF]
  - *There should be no transitive dependency of a nonkey attribute on the primary key!*
    - No nonkey attribute has a FD on another nonkey attribute
    - Relation needs to be in 1NF and 2NF
]

#slide[
  #heading(numbering: none)[Normalization - Rules for Decomposition]
  - Should be lossless
  - Tuples of the original relation can be restored when joining the decomposed relations
  - Functional dependencies should be preserved in one of the decomposed relations, so that original FDs can be restored
]

#slide[
  #heading(numbering: none)[Assignment: Table into 1NF, 2NF, and 3NF]
  #figure(image("../assets/img/slides_06/20250309_studentno_studentname_major_rev01.png"))
]

#slide[
  #heading(numbering: none)[Assignment: Table into 1NF, 2NF, and 3NF]
  #figure(image("../assets/img/slides_06/20250309_fullname_address_movies_rev01.png"))
]


= License Notice
== Attribution
#slide[
  The basis of this course stems from: Professor Dr. Ulrike Herster
  The following license applies to all unmodified and modified material used throughout this course.
  #memo(title: [License])[
    The publication or sharing of slides, image and sound recordings of this course are not permitted.

    © Professor Dr. Ulrike Herster

    This video and the presented script are protected by copyright.
    The use is only permitted in relation with the course of study.
    It is not permitted to forward or republish it in other places (especially in the internet).
  ]
]

