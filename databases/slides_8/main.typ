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
  aspect-ratio: "16-9",
  config-info(
    title: [Databases],
    subtitle: [Lecture 8 - Views and Transactions],
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
  - Last time, we looked at the basics of subqueries and views
  - Today, we'll be discussing
    - how we can expand our knowledge of views,
    - how we can use transactions to increase the safety of our data manipulation statements
    - how transactions are executed.
]

#slide[
  1. Introduction
  2. Basics
  3. SQL
  4. Entity-Relationship-Model
  5. Relationships
  6. Constraints
  8. *Subqueries & Views*
  9. *Transactions*
  10. Database Applications
  11. Integrity, Trigger & Security
]

== What is the goal of this chapter?
#slide[
  - At the end of this lesson, you should be able to
    - create views in PostgresQL and use them effectively and
    - use transactions to make safe changes, that can be undone if necessary.
]

= Repetition
== Relational Algebra
#slide[
  #heading(numbering: none)[Basics]
  - SQL is the What, while the Relational Algebra is the How!
  - In mathematics an algebra is a values range combined with defined operations
  - *Relational Algebra*: The values range is the content of the database; operations are functions to calculate the query results a set of operations for the relational model
  - *Relational Calculus*: Descriptive approach that is based on mathematical logic
    - higher-level declarative language for specifying relational queries,
    - e.g., no order of operations, only what information the result should contain
]

#slide[
  #heading(numbering: none)[Operations]
  #figure(image("../assets/img/slides_08/20250309_operation_sel_proj_rev01.png"))
]

#slide[
  #heading(numbering: none)[Operations]
  #figure(image("../assets/img/slides_08/20250309_operation_union_inter_rev01.png"))
]

== Subqueries
#slide[
  #heading(numbering: none)[Basics]
  - `SELECT` returns relation: a (multi-)set
  - Result of `SELECT` can be included in query
    - `WHERE` clause
      - also, for `UPDATE`, `DELETE`
    - `HAVING` clause
    - `FROM` clause
  - `SELECT` clause (in column list)
  - So, we have two (or more) `SELECT`s:
    - Outer `SELECT`
    - Nested (or inner) `SELECT`: *subquery*
]

#slide[
  #heading(numbering: none)[Operations in `WHERE`]
  #figure(image("../assets/img/slides_08/20250309_in_all_any_exists_rev01.png"))
]

#slide[
  #heading(numbering: none)[In `FROM`]
  - `SELECT` returns a new relation
  - ... so, we can select values from it
  - Necessary: give a name to the relation
  - Example: Alias name `newtab_b`

  ```sql SELECT tab_a.x , newtab_b.y FROM tab_a , (SELECT v1, v2 FROM tab_b) AS newtab_b;```
]

#slide[
  #heading(numbering: none)[Assignment]
  #let left = [
    - Suppose that we want the department name number of employees in each department whose departments have an average income of more than 30,000 \$. How can we specify this query in SQL?
    - Retrieve the names of all employees with the smallest salary.
    - Retrieve the names of all employees whose supervisor's supervisor has ssn '888665555'.
    - Retrieve the names of employees who make at least \$10,000 more than the employee who is paid the least in the company.
  ]
  #let right = [
    #figure(image("../assets/img/slides_08/20250309_emp_dept_ep_workson_rev01.png"))
  ]
  #grid(
    columns: (auto, auto),
    gutter: 0.25em,
    left, right,
  )
]

== Views
#slide[
  #heading(numbering: none)[ANSI-SPARC]
  #figure(image("../assets/img/slides_08/20250309_ansi_sparc_arch_rev01.jpeg"))
]

#slide[
  #heading(numbering: none)[Basics]
  - User or application specific views on data
  - Only relevant portions of the data
  - A *view* in SQL terminology is a single table that is derived from other tables Other tables can be *base tables* or previously defined views
  - A view is considered to be a *virtual table*
    - In contrast to base tables

  - Limits the possible update operations
  - No limitations on querying a view
]

#slide[
  #heading(numbering: none)[Example]

  ```sql
  CREATE VIEW vPerson AS
  SELECT Name , Id , BirthDate FROM person;
  ```
  #figure(image("../assets/img/slides_08/20250309_vPerson_rev01.jpeg", height: auto))

  Can rename columns in view:

  ```sql
  CREATE VIEW vPerson (lname, pnr, bd) AS
  SELECT Name , Id , BirthDate FROM person;
  ```
]

= Views
== Updating Views
#slide[
  #heading(numbering: none)[Basics]
  - Views are Relations, just like tables!
  - Should make no difference to users
  #question[
    Can we modify the view's data?
  ]
  - Depends on type of view!
]

#slide[
  #heading(numbering: none)[Basics]
  #figure(image("../assets/img/slides_08/20250309_emp_proj_workson_rev01.png"))
  ```sql
  UPDATE v_WORKS_ON1
  SET Pname = "Project2"
  WHERE Lname= "Borg"
  AND Fname= "James"
  AND Pname= "Project2";
  ```
]

#slide[
  #heading(numbering: none)[Basics]
  - Possibility 1
  ```sql
    UPDATE WORKS_ON SET
    Pno= SELECT Pnumber FROM PROJECT
    WHERE Pname= "Project2")
    WHERE Essn IN (SELECT Ssn FROM
    EMPLOYEE WHERE Lname= "Borg" AND Fname= "James")
    AND Pno = ( SELECT Pnumber FROM PROJECT WHERE Pname= "Project1");
  ```
]

#slide[
  #heading(numbering: none)[Basics]
  - Possibility 2
  ```sql
  UPDATE PROJECT
  SET Pname = "Project2"
  WHERE Pname = "Project1";
  ```
]

#slide[
  #heading(numbering: none)[Basics]
  - Classify views based on the select:
    - *Projection View*
      - ```sql SELECT a, b, c ...```
    - *Selection View*
      - ```sql ... WHERE <condition> ...```
    - *Join View*
      - ```sql FROM tab_a JOIN tab_b ...```
      - *Aggregation View*
        - ```sql SELECT MAX(x) ...```
  - Other types and combinations exist
]

#slide[
  #heading(numbering: none)[Basics]
  - Projection View
    #example[
      ```sql
      ... AS SELECT a , b , c FROM ...
      ```
    ]
  - Manipulations can be transformed to base table quite easily
  - Problems:
    - INSERT
      - NOT NULL columns in base table
    - DELETE
      - Problem if projection does not contain primary key
    - In general: Can violate integrity constraints of base table
]

#slide[
  #heading(numbering: none)[Basics]
  - *Selection View*
    #example[
      ```sql
      CREATE VIEW v_top AS SELECT * FROM employee WHERE salary > 20000;
      ```
    ]
  - Problem:
    - Update can move tuples out of selection condition
    - So, the update looks like a delete!
    #example[
      ```sql
      UPDATE v_top SET salary = 100;
      ```
    ]
  - This phenomenon is called "*tuple migration*"
]


#slide[
  #heading(numbering: none)[Basics]
  - *Join View*
  #example[
    ```sql
      CREATE VIEW v_depman AS
         SELECT *
         FROM employee , department
         WHERE employee.ssn = department.mgr_ssn ;
    ```
  ]
  - Data manipulation cannot be transformed to base tables in general case!
  ```sql
  DELETE FROM v_depman WHERE id =11;
  ```
  - Transformation to base tables employee and department?
  ```sql
  DELETE FROM employee?
  DELETE FROM department?
  ```
]

#slide[
  #heading(numbering: none)[Basics]
  - *Aggregation View*
  #example[
    ```sql
    CREATE VIEW v_astats AS
      SELECT MAX(i) , MIN(i) , COUNT(*)
      FROM a ;
    ```
  ]
  - Update of the aggregated columns not possible!
    #info[
      Aggregation may depend on other columns (`GROUP BY`)
    ]
]

#slide[
  #heading(numbering: none)[Basics]
  - A view with a single defining table is updatable if
    - the view attributes contain the primary key of the base relation,
    - as well as all attributes with the NOT NULL constraint that have a default value specified
  - Views defined on multiple tables using joins are only updatable in special cases
    - E.g., INSERT and UPDATE for Join Views, if join condition is based on PK-FK
  - Views defined using grouping and aggregate functions are not updatable
]


#slide[
  #heading(numbering: none)[Basics]
  - Oracle and standard SQL allow certain options at end of **VIEW** definition:
    - `WITH READ ONLY;`
      - Read only view, no data manipulation allowed
    - `WITH CHECK OPTION;`
      - Updates leading to tuple migration are denied
]

#slide[
  #heading(numbering: none)[Generated Tables]
  ```sql
  CREATE TABLE <name> AS SELECT
  ```
  - Can create new table based on query
  - New table is independent from old table
  - Use cases:
    - Copy table
    - Copy parts of table
      #memo[
        New table does not have all constraints of the parent table!
      ]
]

#slide[
  #heading(numbering: none)[Generated Tables]
  #example[
    ```sql
    INSERT INTO Underpaid ( lname , fname )
      SELECT lname , fname **FROM** Employee WHERE salary < 1000 ;
    ```
  ]
  - `WHERE` clause belongs to `SELECT`
]

#slide[
  #heading(numbering: none)[Views: Assignment]
  #let left = [
    - Create a view that has the department name, manager name, and manager salary for every department.
    - Create a view that has the project name, controlling department name, number of employees, and total hours worked per week on the project for each project.
    - Create a view that has the project name, controlling department name, number of employees, and total hours worked per week on the project for each project with more than one employee working on it.
  ]
  #let right = [
    #figure(image("../assets/img/slides_08/20250309_emp_dept_ep_workson_rev01.png"))
  ]
  #grid(
    columns: (auto, auto),
    gutter: 0.25em,
    left, right,
  )
]

#slide[
  #heading(numbering: none)[Views: Assignment]
  #let left = [

    Consider the following view `v_DEPT_SUMMARY` defined on the `COMPANY` database:
    ```sql
    CREATE VIEW v_DEPT_SUMMARY (DNO, COUNT_EMPS, SUM_SALARY, AVG_SALARY) AS
    SELECT Dno, COUNT(*), SUM(Salary), AVG(Salary) FROM EMPLOYEE GROUP BY Dno;
    ```
  ]
  #let right = [
    #figure(image("../assets/img/slides_08/20250309_emp_dept_ep_workson_rev01.png"))
  ]
  #grid(
    columns: (auto, auto),
    gutter: 0.25em,
    left, right,
  )
]

#slide[
  #heading(numbering: none)[Views: Assignment]
  Describe the semantics oft he following SQL -statements. State which of the following queries and updates would be allowed on the view. If a query or update would be allowed, show what the corresponding query or update on the base relations would look like, and give its result when applied to the database.
  ```sql
  SELECT * FROM v_DEPT_SUMMARY;
  SELECT DNO, COUNT_EMPS FROM V_DEPT_SUMMARY WHERE SUM_SALARY > 100000;
  SELECT DNO, AVG_SALARY FROM V_DEPT_SUMMARY WHERE COUNT_EMPS > (SELECT COUNT_EMPS FROM V_DEPT_SUMMARY WHERE DNO=4);
  UPDATE v_DEPT_SUMMARY SET DNO=3 WHERE DNO=4;
  DELETE FROM v\_DEPT\_SUMMARY WHERE COUNT\_EMPS > 4;
  ```
]


#slide[
  #heading(numbering: none)[Views: Assignment]
  #let left = [
    ```sql
    CREATE VIEW v_DEPT_SUMMARY (DNO, COUNT_EMPS, SUM_SALARY, AVG_SALARY)
    AS SELECT Dno, COUNT(*), SUM(Salary), AVG(Salary)
    FROM EMPLOYEE GROUP BY Dno;

    SELECT * FROM v_DEPT_SUMMARY;
    SELECT DNO, COUNT_EMPS FROM v_DEPT_SUMMARY WHERE SUM_SALARY > 100000;
    SELECT DNO, AVG_SALARY FROM v_DEPT_SUMMARY WHERE COUNT_EMPS >
    (SELECT COUNT_EMPS FROM v_DEPT_SUMMARY WHERE DNO=4);

    UPDATE v_DEPT_SUMMARY SET DNO=3 WHERE DNO=4;
    DELETE FROM v_DEPT_SUMMARY WHERE COUNT_EMPS > 4;
    ```
  ]
  #let right = [
    #figure(image("../assets/img/slides_08/20250309_emp_dept_ep_workson_rev01.png"))
  ]
  #grid(
    columns: (auto, auto),
    gutter: 0.25em,
    left, right,
  )
]

= Transactions
== Basics
#slide[
  #heading(numbering: none)[Operations]
  - A transaction bundles several operations into one logical unit
    - Unit of Work

  - Includes one or more database access operations E.g., `INSERT`, `DELETE`, `UPDATE`, `SELECT`
  - Operations must be executed all or none
  - Example: Order a hotel room over the internet
    - Choose and reserve room
    - Payment
    - Final booking of the hotel room
]

#slide[
  #heading(numbering: none)[Concurrency]
  - DBMS allow
    - many users &
    - concurrent access
  - May lead to funny results if actions interfere
    #example[
      Donald and Daisy withdraw money from their shared bank account
    ]
]
#slide[
  #heading(numbering: none)[Languages]
  #let left = [
    TCL for performing or rollbacking of changes in the database that we made using DML commands
    - `BEGIN`
    - `COMMIT` To persist the changes made by DML commands in database
    - `ROLLBACK` To rollback the changes made to the database
    - `SAVEPOINTS`
  ]
  #let right = [
    #figure(image("../assets/img/slides_08/20250309_dbms_lang_rev01.jpeg"))
  ]
  #grid(
    columns: (auto, auto),
    gutter: 0.25em,
    left, right,
  )
]
#slide[
  #heading(numbering: none)[ACID]
  - Key features of transactions
    - *#text(blue)[A]tomicity*: Transaction is executed in whole or not at all
    - *#text(blue)[C]onsistency*: State of the DB is consistent before and after a transaction
    - *#text(blue)[I]solation*: Transactions do not interfere with other concurrent transactions
    - *#text(blue)[D]urability*: Changes are stored permanently in the database and will not get lost
]

#slide[
  #heading(numbering: none)[ACID - Atomicity]
  - A transaction can consist of many operations
    - `SELECT`

  - `INSERT`, `UPDATE`, `DELETE`
  - Note: statements for data definition (e.g., `CREATE TABLE`) usually outside transaction!
  - Single operations are always atomic
    - Not trivial when looking at the implementation!
  - In a transaction, all operations or none are performed
]

#slide[
  #heading(numbering: none)[ACID - Atomicity]
  - Begin of Transaction (*BoT*)
    - SQL99: **START TRANSACTION**
    - PostgresQL:
      ```sql
        BEGIN;
      ```
  - Commit a transaction: `COMMIT;`
    - All operations are made persistent
    - All changes are visible to other users
  - Rollback transaction: `ROLLBACK;`
    - DB is in state at *BoT* again
]

#slide[
  #heading(numbering: none)[ACID - Atomicity]
  - Autocommit
    - On some systems:
    - Single operations are committed automatically
    - Called `autocommit` mode
  - May be turned off
    - ... by disabling it
    - ... by explicitly starting a transaction
      #info[
        Method depends on system!
      ]
]

#slide[
  #heading(numbering: none)[ACID - Consistency]
  - DB: in consistent state before transaction Also, in consistent state after transaction
  - Integrity constraints assure that
  - Constraints can be defined as
    - `IMMEDIATE` (default in mySQL)
      - are checked immediately after operation
    - `DEFERRED`
      - Check at time of commit
]

#slide[
  #heading(numbering: none)[ACID - Consistency]
  #example[
    Employee #sym.arrow.l.r.double Department
    If the relationship "*employee works in department*" is mandatory, so that an employee should only exist, if he/she is working in a department, then how can that be assured?
    - We must introduce a deferred constraint!
  ]
  - PostgresQL: ```sql SET CONSTRAINTS { ALL | name [, ...] } { DEFERRED | IMMEDIATE }```
  #figure(image("../assets/img/slides_08/20250314_emp_worksin_dept_id_rev01.png"))
]

#slide[
  #heading(numbering: none)[ACID - Isolation]
  - Transactions are isolated from other concurrent transactions
  - Concurrent transactions shall behave well
]

#slide[
  #heading(numbering: none)[ACID - Isolation: Concurrency Control]
  - Concurrent operations can lead to problems
    - Lost Update
    - Dirty Read
      - Unrepeatable read
      - Phantom tuples
]

#slide[
  #heading(numbering: none)[ACID - Isolation: Concurrency Control]
  - Several transactions change the same value
    #figure(image("../assets/img/slides_08/20250309_time_trans1_trans2_article_price_rev01.png"))
]

#slide[
  #heading(numbering: none)[ACID - Isolation: Concurrency Control]
  - Transaction reads temporary value
  #figure(image("../assets/img/slides_08/20250309_time_trans1_trans2_article_price_type2_rev01.png"))
  - A dirty read (also uncommitted dependency) occurs when a transaction is allowed to read data from a row that has been modified by another running transaction and not yet committed
]

#slide[
  #heading(numbering: none)[ACID - Isolation: Concurrency Control]
  - Transaction receives inconsistent value due to interfering transaction
  - Credit account and debit account have to match with their values!
    #figure(image("../assets/img/slides_08/20250309_time_trans_1_2_rev01.png"))
]

#slide[
  #heading(numbering: none)[ACID - Isolation: Concurrency Control]
  #let left = [

    - When doing the same `SELECT` twice, new tuples may appear that are inserted by another transaction
    - Basically, same problem as Unrepeatable Read
      #figure(image("../assets/img/slides_08/20250309_time_trans1_2_type2_rev01.png"))
  ]
  #let right = [
    #figure(image("../assets/img/slides_08/20250309_pen_eraser_ruler_rev01.jpeg"))
  ]
  #grid(
    columns: (auto, auto),
    gutter: 0.25em,
    left, right,
  )
]


#slide[
  #heading(numbering: none)[ACID - Isolation: Concurrency Control]
  - Lost Update is prevented by SQL
  - Transactions: may choose *Isolation Level*
    - `SERIALIZABLE`
      - no problems
      - `REPEATABLE READ` (default in mySQL)
        - Open for phantom tuples
      - `READ COMMITTED` (default in Oracle, SQL Server)
        - Open for phantom tuples and unrepeatable read
      - `READ UNCOMMITTED`
        - Open for all problems
]


#slide[
  #heading(numbering: none)[ACID - Isolation: Concurrency Control]
  #figure(image("../assets/img/slides_08/20250309_iso_level_read_pheno_rev01.png"))
]

#slide[
  #heading(numbering: none)[ACID - Isolation: Concurrency Control]
  #figure(image("../assets/img/slides_08/20250309_trans_iso_level_rev01.png"))

]

#slide[
  #heading(numbering: none)[ACID - Isolation: Concurrency Control]
  - Isolation levels can be set
  - Syntax:
  ```sql
  SET TRANSACTION < transaction_mode > [, …]
  <transaction_mode> ::= ISOLATION LEVEL {
                              SERIALIZABLE |
                               REPEATABLE READS |
                               READ COMMIT |
                               READUNCOMMITED}
  ```
  - Transactions can be *read only* if it contains only retrieval operations
]

#slide[
  #heading(numbering: none)[ACID - Isolation: Concurrency Control]
  - Locks
    - Read Lock (share)
    - Write Lock (exclusive)
  - Locks may hold for
    - Row
    - Table
    - Also: Memory page, Disk block
]

#slide[
  #heading(numbering: none)[ACID - Isolation: Concurrency Control]
  - Deadlocks may occur!
    - Usually are resolved automatically by aborting one transaction
  #figure(image("../assets/img/slides_08/20250309_start_trans_mod_table_rev01.jpeg"))
]

#slide[
  #heading(numbering: none)[ACID - Isolation: Concurrency Control]
  - Multiversion Concurrency Control
    - Transactions see state of the database at *BoT* (begin of transaction)
    - Can reduce number of locks
    - DB has to store different versions of tuples
      #figure(image("../assets/img/slides_08/20250309_object1_object2_rev01.png"))
  - Conceptually similar to Subversion or Git
]

#slide[
  #heading(numbering: none)[ACID - Durability]
  - Once committed, changed data is safe
  - Error types
    1. Computer failure
    2. Transaction or system error (constraint violation, $x/0$, blackout, system crash)
    3. Local Errors
    4. Concurrency control enforcement
    5. Disk error (harddisk broken)
    6. Physical problems and catastrophes (fire, earthquake, robbery, ...)
]


#slide[
  #heading(numbering: none)[ACID - Durability: Error Handling]
  - Recovery from transaction failures usually means that the database is *restored* to the most recent consistent state just before the time of failure
  - Minor damages due to error types 1-4 from slide "ACID – Durability"
    - DBMS provides handling
      - Recovery strategy is to identify any changes that may cause an inconsistency in the database
        - Changes are first written to redo logs (files on disk)
        - Written to database files after commit
]

#slide[
  #heading(numbering: none)[ACID - Durability: Error Handling]
  - Extensive damage due to error types 5-6 from slide "ACID – Durability"
    - Recovery handling restores a past copy of the database from archival storage
    - Reconstructs a more current state by redoing the operations
    - Last transactions are lost!
  - Solution: Redundancy
    - RAID (*r* edundant *a* rray of *i* ndependent *d* isks)
      - Data Replication by DBMS
]

#slide[
  #heading(numbering: none)[ACID - Durability: Error Handling]
  - Changes are performed on (replicated to) several database instances

  - Master/Slave
    - Updates only on one instance (master)
    - Slave: Read only vs. Standby

  - Multi-Master
    - Updates on different instances
    - Needs conflict resolution strategy
]

#slide[
  #heading(numbering: none)[ACID - Durability: Error Handling]
  - *Synchronous*
    - Transaction valid only when committed on all DBs
    - Safest, but performance impact
    - May reduce availability of the system

  - *Asynchronous*
    - Transaction valid when committed locally
]

#slide[
  #heading(numbering: none)[ACID - Durability: Error Handling]
  - Low level (disk device)

  - Trigger based
    - Update triggers the replication (SQL level)

  - Logfile shipping
    - Changes are stored in redo logs (as usual)
    - redo logs are copied to standby DB
]

#slide[
  #heading(numbering: none)[ACID - Durability: Error Handling]
  - Oracle
    - Data Guard
      - Replication on second server, can be used to answer Read-Only queries
    #figure(image("../assets/img/slides_08/20250309_trans_apply_redo_rev01.jpeg"))
  - Real Application Cluster (RAC)
    - Several servers share the same DB
]

#slide[
  #heading(numbering: none)[Distributed Transactions]
  #let left = [
    - Transactions not only in a single DBS
    - Standardized by X/Open
      - Transaction Manager: A software component that guarantees transaction properties
      - Resource Manager: Every resource (e.g., DBS, GUI) that is able to work in a transactional mode without providing a transaction control structure itself
    - The Transaction manager coordinates the Resource Manager that take part in the transaction. E.g., different DBS (distributed transactions) that appear as one DBS from outside (transparency!)
  ]
  #let right = [
    #figure(image("../assets/img/slides_08/20250309_ap_rms_tm_rev01.jpeg"))
  ]
  #grid(
    columns: (auto, auto),
    gutter: 0.25em,
    left, right,
  )
]


#slide[
  #heading(numbering: none)[Distributed Transactions]
  #let left = [
    - To ensure interoperability between the participating resource managers the *2-phase commit protocol* is realized
    - It defines the final synchronization of different parts of a transaction of a global transaction
    - In the first phase the transaction manager asks participating resource managers to announce the results of their local transaction part
    - This leads to a global result (commit or rollback) that is then in the second phase announced to the participants
  ]
  #let right = [
    #figure(image("../assets/img/slides_08/20250309_trans_coord_res_man_rev01.jpeg"))
  ]
]

#slide[
  #heading(numbering: none)[Savepoints]
  - There are operations that may be expensive to execute time consuming
  - If certain constraints fail within transaction execution, then maybe these constraints may not fail in a second attempt (e.g., time dependent)
  - So "fall back" points can be defined, which are called *savepoints*
  - It is possible to rollback up to a savepoint and restart transaction execution from this point on
]

#slide[
  #heading(numbering: none)[Savepoints]
  #figure(image("../assets/img/slides_08/20250309_code_tables_rev01.png"))
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

