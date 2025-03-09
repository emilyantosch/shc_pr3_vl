#import "@preview/touying:0.5.2": *
#import themes.university: *

#import "@preview/fletcher:0.5.1" as flechter: diagram, node, edge
#import "@preview/wrap-it:0.1.0": wrap-content

#import "@preview/gentle-clues:1.0.0": *
#import "@preview/pinit:0.2.0": *
#import "@preview/codly:1.0.0": *
#show: codly-init.with()

#import "@preview/numbly:0.1.0": numbly

#set text(lang: "en", font: "Roboto", size: 18pt)
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
  aspect-ratio: "16-9", config-info(
    title: [Databases], subtitle: [Lecture 7 - Subqueries and Views], author: [Emily Lucia Antosch], date: datetime.today().display("[day].[month].[year]"), institution: [HAW Hamburg],
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
  //TODO: Add what we did last time
  - Last time, we looked at the
  - Today, we'll be discussing
    - how you can work with subqueries and views,
    - how subqueries and views are powerful tools that you can use to design complex databases and
    - how stacking views can enable complex solutions.
]

#slide[
  1. Introduction
  2. Basics
  3. SQL
  4. Entity-Relationship-Model
  5. Relationships
  6. Constraints
  8. *Subqueries & Views*
  9. Transactions
  10. Database Applications
  11. Integrity, Trigger & Security
]

== What is the goal of this chapter?
#slide[
  - At the end of this lesson, you should be able to
    - create views in PostgresQL and use them effectively
    - use subqueries in different points in the development of your database to enable your ideas and
    - know best practices and tricks that allow for complex data structures.
]

= Views
== Relational Algebra
#slide[
  #heading(numbering: none)[Overview]
  - While SQL is the what, Relational Algebra is the how!
  - In mathematics an algebra is a values range combined with defined operations
  - Relational Algebra: The values range is the content of the database; operations are functions to calculate the query results
    - a set of operations for the relational model
  - Relational Calculus: Descriptive approach that is based on mathematical logic
    - higher-level declarative language for specifying relational queries, e.g., no order of operations, only what information the result should contain
]

#slide[
  #heading(numbering: none)[Overview]
  - Algebra operations produce new relations
  - These can be further manipulated using operations of the same algebra
  - Sequence of relational algebra operations: relational algebra expression
  - The result of a relational algebra expression is also a relation representing the result of a database query (retrieval request)
]

#slide[
  #heading(numbering: none)[Overview]
  - Algebra operations can be divided into two groups
    - First group consists of operations developed specifically for relational databases
      - i.e., Selection, Projection, and Join
    - Second group includes set operations from mathematical set theory
      - i.e., Union, Intersection, Set Difference, and Cartesian Product
]

#slide[
  #heading(numbering: none)[Overview]
  - Order of explanation
    1. Selection
    2. Projection
    3. Renaming
    4. Union, Intersection, Set Difference
    5. Cartesian Product
    6. Join (Equijoin, Natural Join)
]

#slide[
  #heading(numbering: none)[Queries]
  #figure(image("../assets/img/slides_07/20250221_proj_sel_rev01.png"))
  - `<attribute list>` is a list of attribute names (columns) whose values are to be retrieved by the query
  - `<table list>` is a list of the relation names (e.g., tables) required to process the query
  - `<condition>`: optional conditional (Boolean) expression that identifies the tuples to be retrieved by the query
]

#slide[
  #heading(numbering: none)[Selection]
  - *Selection*($sigma$): mask out rows
    - Specify, which rows should remain (subset of the tuple)
      - Usage of selection: Specify, which tuples are interesting
      - Selection condition is a Boolean expression (condition)
      - The condition may contain complex expressions (combinations)
    - Specify, which relation is meant
      - Notice that $R$ is generally a relational algebra expression whose result is a relation, e.g., a relation
    - Syntax: $sigma_"selection condition"(R)$
    #example[
      $sigma_"Salary>30,000"("Employee")$
      $sigma_"(DNr=4 AND Salary>30,000)OR(DNr=5 AND Salary > 25,000)"("Employee")$
    ]
]

#slide[
  #heading(numbering: none)[Selection]
  //TODO: Add img here
  #example[

  ]
]

#slide[
  #heading(numbering: none)[Selection]
  #info[
    - Selection is unary (apply to a single relation)
    - The degree of the relation resulting from a Selection is the same as the degree of $R$
    - The number of tuples in the resulting relation is always less than or equal to the number of tuples in $R$
  ]
]

#slide[
  #heading(numbering: none)[Selection]
  - Selection condition is typically specified in the `WHERE` clause of a SQL query
    #example[
      $sigma_"salary>30,000"("Employee")$
      ```sql
        SELECT * FROM Employee WHERE Salary > 30,000
      ```
    ]
]

#slide[
  #heading(numbering: none)[Projection]
  - Projection ($pi$): mask out columns
    - Specify, which columns should remain
    - Specify, which relation is meant
    - Syntax: $pi_"attribute list"(R)$
    #example[
      $pi_"SSN,lastName"("Person")$
    ]
]
#slide[
  #heading(numbering: none)[Projection]
  #info[
    - The degree of the result is equal to the number of attributes in attribute list
    - If the attribute list includes only non-key attributes of 𝑅, duplicate tuples are likely to occur
      - The Projection removes any duplicate tuples, so, the result of the Projection is a set of distinct tuples, and hence a valid relation
    - The number of tuples in a relation resulting from a Projection is always less than or equal to the number of tuples in 𝑅
  ]
]

#slide[
  #heading(numbering: none)[Projection]
  The Projection attribute list is specified in the SELECT clause of a SQL query.
  #example[
    $pi_"LastName"("Person")$
    ```sql
      SELECT
        LASTNAME
      FROM
        PERSON
    ```
  ]
  #figure(image("../assets/img/slides_07/20250227_lastname_miller_rev01.png"))
]

#slide[
  #heading(numbering: none)[Renaming]
  - Renaming ($rho$): Column gets new name
    - Specify, which column
    - Specify, which new name
    - Specify, which relation
    - Set theory: Union (∪), Intersection (∩) and Set Difference (−) are only defined for the same relation schema
      - To achieve similar relation schema use projection and renaming
    - Renaming allows the renaming of attributes and relations
]

#slide[
  #heading(numbering: none)[Renaming]
  - Renaming in SQL is done using the keyword ```sql AS```
  #example[
    $rho_"surname<-LastName"("Person")$
    ```sql
      SELECT SSN, LastName AS Surname
      FROM PERSON;
    ```
  ]
  #figure(image("../assets/img/slides_07/20250227_person_projection_ssn_lastname_rev01.png"))
]

== Union, Intersection and Difference
#slide[
  #heading(numbering: none)[Union]
  - Union, intersection, and set difference can only be applied on two relations that are union compatible
    - Union compatible means that the two relations have the same number of attributes and
    - each corresponding pair of attributes has the same domain
]


#slide[
  #heading(numbering: none)[Union]
  - Union $union$
    - Example: Retrieve the Social Security numbers of all employees who
      - either work in department 5
      - or directly supervise an employee who works in department 5
  #example[
    $"DEP5_EMPS <-"sigma_"DNr=5"("Employees")$
    $"RESULT1 <-"pi_"SSN"("DEP5_EMPS")$
    $"RESULT2 <-"pi_"Superssn"("DEP5_EMPS")$
    $"RESULT <- RESULT1" union "RESULT2"$
  ]
  #figure(image("../assets/img/slides_07/20250227_employee_example_table_rev01.png"))
]

#slide[
  #heading(numbering: none)[Union]
  - Union $union$
    - Example: Retrieve the Social Security numbers of all employees who
      - either work in department 5
      - or directly supervise an employee who works in department 5
  #example[
    ```sql
      (SELECT ssn FROM EMPLOYEE
      WHERE DEPARTMENT_NUM = 5)
      UNION
      (SELECT Superssn FROM EMPLOYEE
      WHERE DEPARTMENT_NUM = 5)
    ```
  ]
]


#slide[
  #heading(numbering: none)[Union]
  #figure(image("../assets/img/slides_07/20250227_student_instructor_union_rev01.png"))
]

#slide[
  #heading(numbering: none)[Intersection]
  - Intersection $inter$
    - The result is a relation that includes all tuples in both $R$ and $S$
    - Commutative $R inter S = S inter R$
    - Duplicate tuples are eliminated

  #example[
    ```sql
    SELECT supplier_id FROM SUPPLIERS
    INTERSECT
    SELECT SUPPLIER_ID FROM ORDERS;
    ```
  ]
]

#slide[
  #heading(numbering: none)[Union, Intersection and Difference]
  #figure(image("../assets/img/slides_07/20250227_student_instructor_intersection_rev01.png"))
]

#slide[
  #heading(numbering: none)[Union, Intersection and Difference]
  - Set Difference (-)
    - The result ($R - S$) is a relation that includes all tuples that are in $R$ but not in $S$
    - Not commutative: $R - S eq.not S - R$
    - Duplicate tuples are eliminated
  #example[
    ```sql
      STUDENT except INSTRUCTOR;
      STUDENT MINUS INSTRUCTOR;
    ```
  ]
]

#slide[
  #heading(numbering: none)[Union, Intersection and Difference]
  #figure(image("../assets/img/slides_07/20250227_student_instr_minus_rev01.png"))
]

#slide[
  #heading(numbering: none)[Union, Intersection and Difference]
  #figure(image("../assets/img/slides_07/20250227_student_instr_overview_rev01.png"))
]

#slide[
  #heading(numbering: none)[Union, Intersection and Difference]
  - In SQL, there are three operations — `UNION`, `INTERSECT`, and `EXCEPT` — that correspond to the set operations described here
  - In addition, there are multiset operations — `UNION ALL`, `INTERSECT ALL`, and `EXCEPT ALL` — that do not eliminate duplicates
]

#slide[
  #heading(numbering: none)[Cartesian Product]
  - Cartesian Product
    - This is also a binary set operation
    - Relations do not have to be union compatible
    - The result ($A times B$) is the combination of each tuple of the first relation $A$ with each tuple of the second one $B$
    - In general, the result of $R(A_1, A_2, ... A_n) times S(B_1, B_2, ... B_m)$ is a relation $Q$ with degree $n + m$ attributes $Q(A_1, A_2, ... A_n, B_1, B_2, ... B_m)$
    - If $R$ has $n_R$-tuples, and S has $n_S$-tuples, then $Q$ will have $n_R dot n_S$-tuples
    - In SQL, the Cartesian Product can be realized by using the `CROSS JOIN` option in joined tables.
]

#slide[
  #heading(numbering: none)[Cartesian Product]
  #figure(image("../assets/img/slides_07/20250227_person_house_product_rev01.png"))
]

#slide[
  #heading(numbering: none)[Cartesian Product]
  #example[
    Retrieve a list of names of each female employee and her dependents
    $"FEMALE_EMPS" <- sigma_"sex=F"("EMPLOYEE")$
    $"EMPNAMES" <- pi_"FName, LName, SSN"("FEMALE_EMPS")$
    $"EMP_DEPENDENTS" <- "EMPNAMES" times "DEPENDENT"$
    $"ACTUAL_DEPENDENTS" <- sigma_"SSN=ESSN"("EMP_DEPENDENTS")$
    $"RESULT" <- pi_"Fname, Lname, Dependent_name"("ACTUAL_DEPENDENTS")$
  ]
  #figure(image("../assets/img/slides_07/20250227_female_emps_empnames_rev01.png"))
]

#slide[
  #heading(numbering: none)[Cartesian Product]
  #figure(image("../assets/img/slides_07/20250227_emp_dependents_rev01.png"))
]

#slide[
  #heading(numbering: none)[Cartesian Product]
  #example[
    $"FEMALE_EMPS" <- sigma_"sex=F"("EMPLOYEE")$
    $"EMPNAMES" <- pi_"FName, LName, SSN"("FEMALE_EMPS")$
    $"EMP_DEPENDENTS" <- "EMPNAMES" times "DEPENDENT"$
    $"ACTUAL_DEPENDENTS" <- sigma_"SSN=ESSN"("EMP_DEPENDENTS")$
    $"RESULT" <- pi_"Fname, Lname, Dependent_name"("ACTUAL_DEPENDENTS")$
  ]
  #figure(image("../assets/img/slides_07/20250227_actual_dependents_rev01.png"))
]

#slide[
  #heading(numbering: none)[Join]
  - Join ($join$):
    - Combine related tuples from two relations into single “longer” tuples
    - *Very important concept!*
    - Specify, which tables should be combined
    - The same attribute name merges
    - Without same attributes: the join is the cartesian product
    - There are different types of joins, which are presented later in more detail
    - Comparison to Cartesian Product: The result has one tuple for each combination of tuples of the two relations whenever the combination satisfies the join condition
]

#slide[
  #heading(numbering: none)[Join]
  #example[
    Retrieve all attributes of the managers of each department.
    $"DEPT_MGR" <- "DEPARTMENT" join_"Mgr_SSN = SSN"("EMPLOYEE")$
  ]
  #figure(image("../assets/img/slides_07/20250227_dept_mgr_rev01.png"))
]

#slide[
  #heading(numbering: none)[Join]

  #example[
    With Cartesian Product:
    $"EMP_DEPENDENTS" <- "EMPNAMES" times "DEPENDENT"$
    $"ACTUAL_DEPENDENT" <- sigma_"SSN=ESSN"("EMP_DEPENDENTS")$

    - With Equijoin:
    $"ACTUAL_DEPENDENTS" <- "EMPNAMES" join_"SSN=ESSN"("DEPENDENT")$
  ]
]

#slide[
  #heading(numbering: none)[Join]
  - Variations of JOIN:
    - Equijoin
      - Used comparison operator is = only
      - Two attributes requires the values to be identical in every tuple in the result
    - Natural Join
      - Two join attributes (or each pair of join attributes) have the same name in both relations.
      - If this is not the case, a renaming operation is applied first
]

#slide[
  #heading(numbering: none)[Join]
  #figure(image("../assets/img/slides_07/20250227_sql_joins_rev01.png"))
]

#slide[
  #heading(numbering: none)[Size of Result]
  - How many tuples are in my result set (cardinality)?
    - Interesting question for end user (”I‘ll just print it!”)
    - Interesting question for programmer (”Program is running forever?!”)
    - Interesting question for DBMS creator (”I‘ll start with operation 1 and do operation 2 afterwards”)
  - The answer to this question depends on involved operations...
]

#slide[
  #heading(numbering: none)[Size of Result]
  - The answer to this question depends on involved operations:

  - Projection
    - Upper bounds: number of tuples in the projected relation
    - Lower bounds: 1 (for not empty original relation)
    - Rule: If the projected attribute contains a key candidate, then the cardinality of the result is equal to the amount of tuples
    - This rule also applies if the attributes of the current database state are coincidentally a key candidate
]

#slide[
  #heading(numbering: none)[Size of Result]
  - The answer to this question depends on involved operations:

  - Selection
    - The cardinality of the selection depends on the selection conditions
    - Upper bounds: amount of tuples
    - Lower bounds: 0
    - Selection is used to restrict the number of tuples, thus, the upper bounds is rarely present in practice
]

#slide[
  #heading(numbering: none)[Size of Result]
  - The answer to this question depends on involved operations:
  - Cartesian Product
    - Cardinality is the product of the cardinalities of participating relations
    - Thus, the cartesian product is always an ”expensive” operation
  - Join
    - Upper bounds: Product of cardinalities of participating relations
    - Lower bounds: 0
    - Thus, the join operation may be an ”expensive” operation
]

#slide[
  #heading(numbering: none)[Operations]
  - Minimal set of operations
    - It‘s sufficient if a language provides the operations $rho, sigma, pi, union, -, times$
      - The language is then "relational complete", meaning "everything" is requestable
      - The operations are also independent, therefore none of it are dispensable
    - Other operations are representable by these operations:
      - Example: $R inter S <=> (R union S) - ((R - S) union (S - R))$
    - Important for the implementation of a DBMS and for the optimization of queries
]

#slide[
  #heading(numbering: none)[Operations]
  - Selection ($sigma$ (sigma))
  - Projection ($pi$ (pi))
  - Renaming ($rho$ (rho))
  - Union ( $inter$ )
  - Set Difference (or Except, Minus, − )
  - Cartesian Product ( $times$ )
  - All other operations can be built from these!
]

#slide[
  #heading(numbering: none)[Operations]
  #figure(image("../assets/img/slides_07/20250227_sql_operation_overview_rev01.png"))
]

#slide[
  #heading(numbering: none)[Operations]
  #figure(image("../assets/img/slides_07/20250227_set_operation_overview_rev01.png"))
]

#slide[
  #heading(numbering: none)[Relational Calculus]
  - The relational algebra constructs the query result by applying operations and an order (project on $X$, select the $Y$ and combine that with $R_2$,. . . )
  - In contrast, the relational calculus are using a descriptive approach
  - Calculus are logic-based approaches like the predicate logic
  - Therefore, sets are characterized that correspond with the query result
  - Calculus has variables, constants, comparison operations, logical operations and quantifier
]

#slide[
  #heading(numbering: none)[Relational Calculus]
  - Two types of relational calculus
    - Tuple relational calculus: variables declare tuples (are bounded to them)
    - Domain relational calculus: variables declare domain elements (thus, values range of attributes)
  - Expressions in the calculus are called formula
  - A result tuple is more or less an assignment of constants to variables, so that the formula is evaluated as TRUE
]

#slide[
  #heading(numbering: none)[Relational Calculus]
  #example[
    - In mathematics:
      - ${x^2 | x in N and x^3 < 1000 and x^3 > 0}$
      - This defines the set of all square numbers that cube number is between $0$ and $1000$.
    - Relational calculus:
      - $A = {x |"Person"(x,y) and y = "'Jones'"} = {2}$
      - By usage of complex expressions (formula), the calculus has the same expressiveness as the relational algebra
  ]
]

#slide[
  #heading(numbering: none)[Relational Calculus]
  - Query languages for relational database schemas are mathematical substantiated
  - The mathematical basis are the relational algebra and the relational calculus
  - The relational algebra defines few operations, with that every request is expressible: Projection, Selection, Join, Renaming, Union, Set difference
  - The relational calculus characterizes sets, which corresponds with the query result
  - The relational calculus is descriptive, because it doesn’t have to define an order of operations that construct the result
  - Relational algebra and relational calculus have the same expressiveness
]


= Subqueries & Views
== Subqueries
#slide[
  #heading(numbering: none)[Nested Queries]
  - SELECT returns relation: a (multi-)set
  - Result of SELECT can be included in query
    - `WHERE` clause
    - also, for `UPDATE`, `DELETE`
    - `HAVING` clause
    - `FROM` clause
    - SELECT clause (in column list)
  - So, we have two (or more) `SELECT`s:
    - Outer `SELECT`
    - Nested (or inner) `SELECT`: subquery

]

#slide[
  #heading(numbering: none)[Nested Queries]
  ```sql
  INSERT INTO UNDERPAID (lname, fname) SELECT lname, fname FROM Employee WHERE salary < 1000;
  ```
  - `WHERE` clause belongs to `SELECT`
]

#slide[
  #heading(numbering: none)[`WHERE` x in]
  - In general, the nested query will return a table (relation), which is a set or multiset of tuples
  - Check if value is a member of set
  ```sql WHERE a IN (1,4,9) ```
  - Set can be result of query
  ```sql WHERE a IN (SELECT x FROM y)```
]

#slide[
  #heading(numbering: none)[`WHERE` x in]
  ```sql
    SELECT DISTINCT Essn FROM WORKS_ON WHERE (Pno) IN (SELECT Pno FROM WORKS_ON WHERE Essn='123456789');
  ```
]

#slide[
  #heading(numbering: none)[`WHERE` x in]
  ```sql
    SELECT title  FROM books  WHERE isbn IN  (SELECT isbn FROM recommended_books)
  ```
  - The subqueries are independent of each other, because they do not access the same tables

]

#slide[
  #heading(numbering: none)[`WHERE` x in]
  ```sql
    SELECT lastname FROM person WHERE 1.0 IN (SELECT grade  FROM exam WHERE person.no = exam.no)
  ```
  - In this example both queries depend on each other, because the second query references a part of the first relation ("person").
]

#slide[
  #heading(numbering: none)[WHERE x in]
  ```sql
    SELECT E.Fname, E.Lname FROM EMPLOYEE AS E WHERE E.Ssn IN ( SELECT Essn FROM DEPENDENT AS D WHERE E.Sex = D.Sex );
  ```
]

#slide[
  #heading(numbering: none)[WHERE x in]
  - The operator IN can also be used for explicit enumerations
  ```sql
   WHERE value IN ( value1 , value2 , value3 , … );
   WHERE colour IN ( 'red' , 'blue’ );

   SELECT DISTINCT Essn FROM WORKS_ON WHERE  Pno IN (1, 2, 3);
  ```
]

#slide[
  #heading(numbering: none)[WHERE x in]
  - Example from last chapter (about set operations):
    ```sql
    (SELECT DISTINCT Pnumber
    FROM PROJECT, DEPARTMENT, EMPLOYEE
    WHERE Dnum=Dno AND Mgr_ssn=Ssn AND Lname="Wong")
    UNION
    (SELECT DISTINCT Pnumber
    FROM  PROJECT, WORKS_ON, EMPLOYEE
    WHERE Pnumber= Pno AND Essn= Ssn AND Lname="Wong");
    ```
]

#slide[
  #heading(numbering: none)[WHERE x in]
  - Example from last chapter (alternative statement using subqueries):
  ```sql
  SELECT DISTINCT Pnumber
  FROM PROJECT
  WHERE Pnumber IN
  (SELECT Pnumber FROM PROJECT, DEPARTMENT, EMPLOYEE WHERE Dnum=Dnumber AND Mgr_ssn=Ssn AND Lname="Wong")
  OR Pnumber IN
  (SELECT Pno FROM WORKS_ON, EMPLOYEE WHERE Essn=Ssn AND Lname="Wong" );
  ```
]

#slide[
  #heading(numbering: none)[WHERE x in]
  - Special case: Nested query returns only one value
    - In such cases, it is permissible to use `=` instead of `IN` for the comparison operator
  - Example: ```sql SELECT *  FROM y  WHERE x = ( SELECT MAX(x) FROM y );```
]

#slide[
  #heading(numbering: none)[WHERE x in]

  - In general, a query written with nested `SELECT‐FROM‐WHERE` blocks and using the `=` or `IN` comparison operators can always be expressed as a single block query.
  - Example from before:
  ```sql SELECT E.Fname, E.Lname
  FROM EMPLOYEE AS E
  WHERE E.Ssn IN
  (SELECT Essn FROM DEPENDENT AS D WHERE E.Sex=D.Sex);
  ```
]

#slide[
  #heading(numbering: none)[WHERE x in]
  - Example from last slide (Alternative statement without a subquery)
    ```sql
    SELECT E.Fname, E.Lname FROM EMPLOYEE AS E, DEPENDENT AS D WHERE E.Ssn=D.Essn AND E.Sex=D.Sex;
    ```
]

#slide[
  #heading(numbering: none)[Other Comparison Operators]
  - `=ANY` (`=SOME`)
    - operator returns `TRUE` if the value $v$ is equal to some value in the set $V$
    - is equivalent to `IN`
    - Other operations can be combined with ANY, e.g., `>,` `>=,` `<,` `<=,` and `<>`
  - Example: Persons who have borrowed a book: ```sql SELECT name FROM Person WHERE PNr = ANY (SELECT PNr FROM book );```
]

#slide[
  #heading(numbering: none)[Other Comparison Operators]
  - `ALL`
    - Comparison operations can be combined with ALL, e.g., >, >=, <, <=, and <>
    - Example: Employees earning more money as the employees of department 5
    ```sql
    SELECT Lname, Fname FROM EMPLOYEE WHERE Salary > ALL (SELECT Salary FROM EMPLOYEE WHERE Dno=5) ;
    ```
]
#slide[
  #heading(numbering: none)[Other Comparison Operators]

  - Often several queries give the same result
    - but might have difference in the performance!
  ```sql

  SELECT * FROM book WHERE price <= ALL (SELECT price FROM book);
  SELECT * FROM book WHERE price = (SELECT MIN(price) FROM book);
  SELECT * FROM book WHERE price >= ALL (SELECT price FROM book);
  SELECT * FROM book WHERE price = (SELECT MAX(price) FROM book);
  SELECT * FROM book WHERE price > ANY (SELECT price FROM book);
  SELECT * FROM book WHERE price > (SELECT MIN(price) FROM book);
  ```

]

#slide[
  #heading(numbering: none)[Other Comparison Operators]
  - Often several queries give the same result
    - but might have difference in the performance!

    - Strategy depends on DBMS, probably equivalent if no index on price, otherwise, the second version will be (much) faster

]

#slide[
  #heading(numbering: none)[Correlated Nested Queries]

  - Uncorrelated
    - Outer and nested query are independent
    - Nested query must be computed only once
  - Correlated
    - Nested query depends on columns of outer query
    - Result of a correlated nested query is different for each tuple of the relation(s) outer query
    - A nested query is evaluated once for each tuple (or combination of tuples) in the outer query
  #question[But what about performance?]

]

#slide[
  #heading(numbering: none)[Correlated Nested Queries]
  #example[
    Who has borrowed books for 9.99\$ ?
  ]
  ```sql
  SELECT name  FROM pers  WHERE 9.99 IN (SELECT price FROM book  WHERE pers.PNr = book.PNr ) ; SELECT name  FROM pers, book WHERE pers.PNr = book.PNr AND  book.price = 9.99;
  ```
]

#slide[
  #heading(numbering: none)[Correlated Nested Queries]
  #example[
    From Before: Who is lead by a female superior?
  ]
  ```sql
  SELECT E.Fname, E.Lname FROM EMPLOYEE AS E WHERE E.Ssn IN ( SELECT Essn FROM DEPENDENT AS D WHERE D.Sex='F');
  ```
]

#slide[
  #heading(numbering: none)[Correlated Nested Queries]

  - In general, we can have several levels of nested queries
    - possible ambiguity among attribute names if attributes of the same name exist:
    - one in a relation in the FROM clause of the outer query, and
    - another in a relation in the FROM clause of the nested query
  - The rule is that a reference to an unqualified attribute refers to the relation declared in the *innermost nested query*.

]

#slide[
  #heading(numbering: none)[Ambiguity of Attributes]

  - Example: Retrieve the name of each employee who has a female dependent:
  ```sql
  SELECT E.Fname, E.Lname FROM EMPLOYEE AS E WHERE E.Ssn IN ( SELECT Essn FROM DEPENDENT AS D WHERE D.Sex='F');
  ```

]

#slide[
  #heading(numbering: none)[Ambiguity of Attributes]
  #memo[
    It is generally advisable to create tuple variables (aliases) for all the tables referenced in an SQL query to avoid potential errors and ambiguities!!!
  ]
]

#slide[
  #heading(numbering: none)[`EXISTS`]
  - The operator `EXISTS (NOT EXISTS)` provides the possibility to check if the result of another query is empty (`FALSE`) or not (`TRUE`)
  ```sql
   SELECT isbn FROM book WHERE EXISTS (SELECT * FROM borrowed WHERE book.libraryno = borrowed.libraryno)
  ```
  - This example provides as result a set of all borrowed books
  - Typically, the usage is so that the DBMS may decide, which column should be examined:
  ```sql
  ... EXISTS (SELECT *...
  ```
]

#slide[
  #heading(numbering: none)[`EXISTS`]
  Alternative SQL-statement from before:
  ```sql
  SELECT E.Fname, E.Lname FROM EMPLOYEE AS E WHERE EXISTS (SELECT * FROM DEPENDENT AS D WHERE E.Ssn = D.Essn AND E.Sex = D.Sex);
  ```

]

#slide[
  #heading(numbering: none)[`EXISTS`]
  - `EXISTS` and `NOT EXISTS` are typically used in conjunction with a correlated nested query
  #example[
    Retrieve the names of employees who have no dependents
  ]
  ```sql
   SELECT Fname, Lname FROM EMPLOYEE WHERE NOT EXISTS ( SELECT * FROM DEPENDENT WHERE Ssn=Essn );
  ```
]

#slide[
  #heading(numbering: none)[`EXISTS`]
  #example[
    List the names of managers who have at least one dependent
  ]
  ```sql
  SELECT Fname, Lname FROM EMPLOYEE WHERE EXISTS ( SELECT * FROM DEPENDENT WHERE Ssn=Essn ) AND EXISTS ( SELECT * FROM DEPARTMENT WHERE Ssn=Mgr_ssn );
  ```
]

#slide[
  #heading(numbering: none)[In `FROM`]
  - `SELECT` returns a new relation so that, we can select values from it
  - Necessary: give a name to the relation
  #example[Set an alias for a `SELECT` statement in the `FROM` statement]
  ```sql
  SELECT tab_a.x , newtab_b.y FROM tab_a , (SELECT v1, v2 FROM tab_b) AS newtab_b;
  ```
]

#slide[
  #heading(numbering: none)[ANSI-SPARC Model]
  #figure(image("../assets/img/slides_07/20250227_ansi_sparc_schema_rev01.png"))
]

== Views
#slide[
  #heading(numbering: none)[Basics]
  - User or application specific views on data
  - Only relevant portions of the data
  - A view in SQL terminology is a single table that is derived from other tables
    - Other tables can be base tables or previously defined views
  - A view is considered to be a virtual table
    - In contrast to base tables
    - Limits the possible update operations
    - No limitations on querying a view
]

#slide[
  #heading(numbering: none)[Use Cases]

  - Hide some information
    - Example: Salary not viewable for colleagues
    - Can see only employees of same department?
  - Convert data for different users
    - Price in \$, EUR, etc.
  - Backward Compatibility
    - Example: Add some columns, but old applications do ```sql SELECT * ```
  - Simplification: Hide away complex queries
    - Example: Data Dictionary Views (all tables)
]

#slide[
  #heading(numbering: none)[Syntax]
  ```sql
  CREATE [OR REPLACE] VIEW <vname> AS <query> ;
  ```
  - `<query>` is an arbitrary `SELECT` statement
]

#slide[
  #heading(numbering: none)[Syntax]
  - Example for a sample view:
    ```sql
    CREATE VIEW vPerson AS
    SELECT Name , Id , BirthDate FROM person ;
    ```
  - Can rename columns in view:
  ```sql
  CREATE VIEW vPerson ( lname , pnr , bd ) AS
  SELECT Name , Id , BirthDate FROM person
  ```
]

#slide[
  #heading(numbering: none)[Syntax]
  ```sql
  CREATE VIEW v_WORKS_ON1 AS
  SELECT Fname, Lname, Pname, Hours
  FROM EMPLOYEE, PROJECT, WORKS_ON
  WHERE Ssn=Essn AND Pno=Pnumber;
  ```
]

#slide[
  #heading(numbering: none)[Syntax]
  ```sql
  CREATE VIEW v_DEPT_INFO
  (Dept_name, No_of_emps, Total_sal) AS
  SELECT Dname, COUNT(*), SUM(Salary)
  FROM
  DEPARTMENT, EMPLOYEE
  WHERE
  Dnumber=Dno
  GROUP BY Dname;
  ```
]

#slide[
  #heading(numbering: none)[Queries]
  - A view is supposed to be always up-to-date
    - If we modify the tuples in the base tables on which the view is defined, the view must automatically reflect these changes
    - View realized at the time when we specify a query on the view
  ```sql
  SELECT Fname, Lname
  FROM
  v_WORKS_ON1
  WHERE
  Pname="ProductX";
  ```

]

#slide[
  #heading(numbering: none)[`DROP`]
  - Views can be dropped
  ```sql
  DROP VIEW v_WORKS_ON1;
  ```
]


#slide[
  #heading(numbering: none)[Implementation]
  - Two strategies:
    1. Query Modification
      - Transforming the view query into a query on the underlying base tables
  ```sql
  SELECT Fname, Lname
  FROM EMPLOYEE, PROJECT, WORKS_ON
  WHERE Ssn=Essn
  AND Pno=Pnumber
  AND Pname= "ProductX";
  ```
]

#slide[
  #heading(numbering: none)[Implementation]
  - Two strategies:
    2. View Materialization
      - Physically creating a temporary view
      - Incremental update of materialized view
      - If the view is not queried for a certain period of time, the system may then automatically remove the physical table and recompute it from scratch on new queries
]

#slide[
  #heading(numbering: none)[Materialized Views]
  #let left = [
    ```sql
    CREATE MATERIALIZED VIEW <name> AS SELECT …
    ```
    - Traditional views
    - `SELECT` is performed when needed
    - Performance penalty
  ]

  #let right = [
    - Materialized view
      - Store select statement and selected data
      - Problems
        - Store data twice
        - When to update selected data?
      - Rules for updating: event vs. time triggered
      - Selected data can be updated
        - manually
        - on a regular basis (every night)
        - event triggered (update to base table)
  ]
  #grid(
    columns: (auto, auto),
    gutter: 0.25em,
    left, right,
  )
]

= License Notice
== Attribution

- This work is shared under the CC BY-NC-SA 4.0 License and the respective Public License.
- #link("https://creativecommons.org/licenses/by-nc-sa/4.0/")
- This work is based off of the work by Prof. Dr. Ulrike Herster.
- Some of the images and texts, as well as the layout were changed.
- The base material was supplied in private, therefore the link to the source
  cannot be shared with the audience.
