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
    subtitle: [Lecture 9 - Views and Transactions],
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
== Views

#slide[
#heading(numbering: none)[Updating Views]
  - Views are Relations, just like tables!
  - Should make no difference to users
  #question[
    Can we modify the view's data?
  ]
  - Depends on type of view!
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
  - A view with a single defining table is updatable if
    - the view attributes contain the primary key of the base relation,
    - as well as all attributes with the NOT NULL constraint that have a default value specified
  - Views defined on multiple tables using joins are only updatable in special cases
    - E.g., INSERT and UPDATE for Join Views, if join condition is based on PK-FK
  - Views defined using grouping and aggregate functions are not updatable
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

== Transactions
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
  #heading(numbering: none)[ACID]
  - Key features of transactions
    - *#text(blue)[A]tomicity*: Transaction is executed in whole or not at all
    - *#text(blue)[C]onsistency*: State of the DB is consistent before and after a transaction
    - *#text(blue)[I]solation*: Transactions do not interfere with other concurrent transactions
    - *#text(blue)[D]urability*: Changes are stored permanently in the database and will not get lost
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
  #figure(image("../assets/img/slides_08/20250309_trans_iso_level_rev01.png"))

]

#slide[
  #heading(numbering: none)[ACID - Isolation: Concurrency Control]
  - Deadlocks may occur!
    - Usually are resolved automatically by aborting one transaction
  #figure(image("../assets/img/slides_08/20250309_start_trans_mod_table_rev01.jpeg"))
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
    - The Transaction manager coordinates the Resource Manager that take part in the transaction. E.g., different DBS (distributed transactions) that appear as one DBS from outside (transparency!)]
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
    - This leads to a global result (commit or rollback) that is then in the second phase announced to the participants]
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

= Integrity, Trigger and Security
== Basics

#slide[
#heading(numbering: none)[Integrity Constraints]
#let left = [
- Static Constraints
  - Conditions on states
  - Conditions must be fulfilled before and after operations
  - Used until now
    - Primary Key
    - Foreign Key
    - `UNIQUE`, `NOT NULL`, `CHECK`
]
#let right = [
- Dynamic Constraints (*Assertions*)
  - Integrity conditions that affect multiple tables
  - Conditions on state transitions 

    #example[
     status of order #sym.arrow new #sym.arrow payed #sym.arrow processing #sym.arrow shipped
    ]
]
  #grid(columns: (auto, auto), gutter: 0.25em, left, right)
]


#slide[
#heading(numbering: none)[Integrity Constraints]
- Assertions have been part of the SQL since SQL-92 (DDL)
- Not supported by most DBMS (e.g., MySQL, Postgres and Oracle)
- If the concept of assertions is to be simulated `TRIGGER`
- Concept:
	- Whenever anything is modified in the database, the assertion checks its condition
	- If the `SELECT`-statement gives a non-empty result, the operation that has triggered the assertion is denied
]

#slide[
#heading(numbering: none)[Integrity Constraints - ECA]
#let left = [
  - ECA rules
    - on event (E)
    - under certain conditions (C)
    - perform actions (A)
]
#let right = [
#figure(image("../assets/img/slides_09/20250309_action_event_cond_rev01.png", height: auto))
]
  #grid(columns: (auto, auto), gutter: 0.25em, left, right)
]


#slide[
#heading(numbering: none)[Trigger Syntax]
```sql
CREATE
   [DEFINER = user]
   TRIGGER trigger_name
   trigger_time trigger_event
   ON tbl_name FOR EACH ROW
   [trigger_order]
   trigger_body
trigger_time: { BEFORE | AFTER }
trigger_event: { INSERT | UPDATE | DELETE }
trigger_order: { FOLLOWS | PRECEDES } other_trigger_name
```
]

#slide[
#heading(numbering: none)[Excursion Delimiter]
- A PostgresQL client program such as pgadmin or psql program uses the delimiter (";") to separate statements and executes each statement separately
- However, a stored procedure consists of multiple statements separated by a semicolon (";")
- If you use a PostgresQL client program to define a stored procedure that contains semicolon characters, the PostgresQL client program will not treat the whole stored procedure as a single statement, but many statements.
- Therefore, you must redefine the delimiter temporarily so that you can pass the whole stored procedure to the server as a single statement.
- To redefine the default delimiter, you use the delimiter command
]

#slide[
#heading(numbering: none)[Excursion Delimiter]

- In short: A delimiter is a separator between commands
  #example[

```sql
delimiter |
…
|
delimiter ;
```
    
 In the code block between "delimiter" and "delimiter;" the delimiter is changed to "|" (instead of ";")
  ]
]

#slide[
#heading(numbering: none)[Excursion Delimiter: Example]
```sql
delimiter |
CREATE TRIGGER SALARY_VIOLATION
BEFORE INSERT ON EMPLOYEE
FOR EACH ROW
   BEGIN
       IF NEW.SALARY > (SELECT SALARY
                        FROM EMPLOYEE
                        WHERE SSN = NEW.SUPER_SSN )
       THEN SET NEW.Salary = (SELECT SALARY
                                 FROM EMPLOYEE
                                WHERE SSN = NEW.SUPER_SSN )‐1;
       END IF;
END;
|
delimiter;
```
]

#slide[
#heading(numbering: none)[Events]
- Triggers can react on events
	- DML: `INSERT`, `UPDATE`, `DELETE`
		- Most common trigger types
	- DDL: `CREATE`, `ALTER`, `DROP`
	- DB: startup, shutdown, logon of a user
- No `COMMIT` triggers
]

#slide[
#heading(numbering: none)[Types]
- Time of execution, relative to event
	- `BEFORE`
	- `AFTER`

- `INSTEAD OF`
- Statement trigger
	- Once per statement
	- Even if no row is affected!
	- Default trigger type
- Row trigger
- For every affected row
- Syntax: `FOR EACH ROW`
]

#slide[
#heading(numbering: none)[Order of Trigger]

- Before Statement Trigger (once!)
- For every row affected:
	- Before row trigger
	- DML operation
	- Immediate integrity checks
	- After row trigger
- After Statement Trigger (once!)
]

#slide[
#heading(numbering: none)[Transition Variables]
- Row triggers can access old and new tuples 
  - PostgresQL
    - `:old` or `old` #sym.arrow `NULL` for `INSERT`
    - `:new` or `new` #sym.arrow `NULL` for `DELETE`
- Oracle
  - `NEW` and `OLD`
  - Before row triggers:
    - Can even modify new!
]

#slide[
#heading(numbering: none)[Use Cases]
- Constraints on state transitions
- Audit
  - When was a record last modified?
- Integrity checks with error correction 
  - Change `:new`
- Maintain redundant data
- Updateable views 
  - `INSTEAD OF`
]

#slide[
#heading(numbering: none)[Trigger: Example]
- Audit insertion of new persons
  ```sql
DROP TRIGGER IF EXISTS emp_insert; 
CREATE TRIGGER emp_insert AFTER INSERT ON employee 
FOR EACH ROW 
INSERT INTO EMPLOYEE_LOG (ESSN, INSERT_DATE) VALUES ( NEW.ssn , NOW() ) ; 
  ```
]


### **INTEGRITY, TRIGGER & SECURITY TRIGGER – EXAMPLE IN ORACLE**

Example: Audit insertion of new persons

```
CREATE OR REPLACE TRIGGER emp_insert
BEFORE INSERT ON employee
FOR EACH ROW
BEGIN
   INSERT INTO EMPLOYEE_LOG (ESSN, INSERT_DATE)
   VALUES( :NEW.Name , current_timestamp ) ;
END;
```
![](_page_44_Picture_3.jpeg)

![](_page_44_Picture_4.jpeg)

### **INTEGRITY, TRIGGER & SECURITY TRIGGER – EXAMPLE IN MYSQL**

Example: Salary of new persons 

```
delimiter |
CREATE PROCEDURE output
   (in ssn char(9), in old_sal DECIMAL(10,2),
    in new_sal DECIMAL(10,2), in diff_sal DECIMAL(10,2))
BEGIN
   INSERT INTO EMPLOYEE_SALDIFF VALUES ( ssn , old_sal , new_sal, diff_sal);
END
|
```

```
delimiter ;
```
![](_page_45_Picture_5.jpeg)

### **INTEGRITY, TRIGGER & SECURITY TRIGGER – EXAMPLE IN MYSQL**

```
Example: Salary of new persons 
delimiter |
CREATE TRIGGER Print_salary_changes
BEFORE UPDATE ON EMPLOYEE
FOR EACH ROW
   BEGIN
       DECLARE sal_diff DECIMAL(10,2);
       IF (NEW.salary != OLD.salary)
       THEN
          BEGIN
          SET sal_diff = NEW.salary ‐ OLD.salary ;
          CALL output(NEW.ssn, OLD.salary, NEW.salary, sal_diff);
          END;
       END IF;
   END;
|
delimiter ;
```
![](_page_46_Picture_2.jpeg)

![](_page_46_Picture_3.jpeg)

### **INTEGRITY, TRIGGER & SECURITY TRIGGER – EXAMPLE IN ORACLE**

**/**

```
Example: Salary of new persons 
   CREATE OR REPLACE TRIGGER Print_salary_changes
   BEFORE DELETE OR INSERT OR UPDATE ON Emp_tab
   FOR EACH ROW
   WHEN (NEW.empno > 0)
   DECLARE
          sal_diff number ;
   BEGIN
         sal_diff := :NEW.sal ‐ :OLD.sal ;
         dbms_output.put ('Old salary : ' || :old.sal ) ;
         dbms_output.put ('New salary : ' || :new.sal ) ;
         dbms_output.put_line ('Difference ' || sal_diff ) ;
   END;
```
![](_page_47_Picture_2.jpeg)

![](_page_47_Picture_3.jpeg)

## **INTEGRITY, TRIGGER & SECURITY TRIGGER – PROBLEMS**

#### Problems

- Cascading triggers
	- Trigger actions cause other triggers to fire
- Execution order
	- Result of high-level operation must be independent hereof!
- "Mutating Tables"

![](_page_48_Picture_7.jpeg)

**Databases, © Ulrike Herster, partially © Elmasri "Fundamentals of Database Systems – For personal use only**

## **INTEGRITY, TRIGGER & SECURITY TRIGGER – PROBLEMS**

#### Problems

- Hard to implement
	- Transaction save!
	- Multi-session save
- Hard to debug
	- Update may lead to insert in another table
	- ... can cause for example constraint violation
	- Which statement failed?

![](_page_49_Picture_9.jpeg)

### **INTEGRITY, TRIGGER & SECURITY TRIGGER – ASSIGNMENT WEBSHOP**

- Suppose the following relations in your database
- In the table Price\_History we want to track on how the prices of the products of table Product develop over time. Table Price\_History has four attributes:
	- The record ID PHID
	- The reference to table Product with the foreign key PID
	- The current price Price
	- The date Change\_Date, where we store the date of the change

| T<br>b<br>l<br>d<br>P<br>a<br>e<br>r<br>o<br>c<br>u | t |  |
|-----------------------------------------------------|---|--|
|-----------------------------------------------------|---|--|

| P<br>I<br>D | P<br>i<br>r<br>c<br>e | D<br>i<br>i<br>t<br>e<br>s<br>c<br>r<br>p<br>o<br>n |  |
|-------------|-----------------------|-----------------------------------------------------|--|
| 1           | 0<br>5<br>0           | d<br>l<br>r<br>e<br>a<br>p<br>p<br>e                |  |
| 2           | 0<br>6<br>0           | l<br>g<br>r<br>e<br>e<br>n<br>a<br>p<br>p<br>e      |  |
| 3           | 1.<br>2<br>0          | d<br>r<br>e<br>p<br>e<br>p<br>p<br>e<br>r           |  |
| 4           | 1.<br>1<br>0          | g<br>r<br>e<br>e<br>n<br>p<br>e<br>p<br>p<br>e<br>r |  |
| …           | …                     | …                                                   |  |

# Table Product\_History

| P<br>H<br>I<br>D | (<br>)<br>P<br>I<br>D<br>F<br>K | P<br>i<br>r<br>c<br>e | C<br>h<br>D<br>t<br>a<br>n<br>g<br>e_<br>a<br>e |
|------------------|---------------------------------|-----------------------|-------------------------------------------------|
| 1                | 1                               | 0<br>0<br>5           | 0<br>2<br>0<br>6<br>2<br>0<br>2<br>1            |
| 2                | 3                               | 1.<br>2<br>0          | 0<br>2<br>0<br>6<br>2<br>0<br>2<br>1            |
| 3                | 2                               | 0<br>6<br>0           | 0<br>3<br>0<br>6<br>2<br>0<br>2<br>1            |
| 4                | 4                               | 1.<br>1<br>0          | 0<br>4<br>0<br>6<br>2<br>0<br>2<br>1            |
| …                | …                               | …                     | …                                               |

![](_page_50_Picture_11.jpeg)

**Databases, © Ulrike Herster, partially © Elmasri "Fundamentals of Database Systems – For personal use only**

### **INTEGRITY, TRIGGER & SECURITY TRIGGER – ASSIGNMENT WEBSHOP**

#### **1. INSERT** trigger:

We want to get an **INSERT** with the current (start) price in table Price\_History when we do an **INSERT** in the table Product. This is triggered when an **INSERT** on our table product is done (**AFTER**). 

**2. DELETE** trigger:

> Furthermore, in case of a **DELETE**, all records of the deleted product in the table Price\_History should be deleted as well.

**3. UPDATE** trigger:

> If a price of a product is changed, this change should also result in an entry in the table Price\_History.

### Table Product

| P<br>I<br>D | P<br>i<br>r<br>c<br>e | D<br>i<br>t<br>i<br>e<br>s<br>c<br>r<br>p<br>o<br>n |  |  |
|-------------|-----------------------|-----------------------------------------------------|--|--|
| 1           | 0<br>5<br>0           | d<br>l<br>r<br>e<br>a<br>p<br>p<br>e                |  |  |
| 2           | 0<br>6<br>0           | l<br>g<br>r<br>e<br>e<br>n<br>a<br>p<br>p<br>e      |  |  |
| 3           | 1.<br>2<br>0          | d<br>r<br>e<br>p<br>e<br>p<br>p<br>e<br>r           |  |  |
| 4           | 1.<br>1<br>0          | g<br>r<br>e<br>e<br>n<br>p<br>e<br>p<br>p<br>e<br>r |  |  |
| …           | …                     | …                                                   |  |  |

# Table Product\_History

| P<br>H<br>I<br>D | (<br>)<br>P<br>I<br>D<br>F<br>K | P<br>i<br>r<br>c<br>e | C<br>h<br>D<br>t<br>a<br>n<br>g<br>e_<br>a<br>e |
|------------------|---------------------------------|-----------------------|-------------------------------------------------|
| 1                | 1                               | 0<br>0<br>5           | 0<br>2<br>0<br>6<br>2<br>0<br>2<br>1            |
| 2                | 3                               | 1.<br>2<br>0          | 0<br>2<br>0<br>6<br>2<br>0<br>2<br>1            |
| 3                | 2                               | 0<br>6<br>0           | 0<br>3<br>0<br>6<br>2<br>0<br>2<br>1            |
| 4                | 4                               | 1.<br>1<br>0          | 0<br>4<br>0<br>6<br>2<br>0<br>2<br>1            |
| …                | …                               | …                     | …                                               |

![](_page_51_Picture_11.jpeg)

**Databases, © Ulrike Herster, partially © Elmasri "Fundamentals of Database Systems – For personal use only**

### **INTEGRITY, TRIGGER & SECURITY PERMISSIONS – BASICS**

- DBMS are multi-user systems
- You need permissions to do anything with the DB:
	- login
	- **CREATE** table, **DROP** table, etc.
	- **SELECT**
	- **INSERT**, **UPDATE**, **DELETE**
- Permissions can be **GRANT**ed and **REVOKE**d

![](_page_52_Picture_8.jpeg)

#### **INTEGRITY, TRIGGER & SECURITY PERMISSIONS – BASICS**

![](_page_53_Picture_1.jpeg)

Source: https://www.youtube.com/ watch?v=QmRQ9OvBVZQ

**Databases, © Ulrike Herster, partially © Elmasri "Fundamentals of Database Systems – For personal use only**

![](_page_53_Picture_4.jpeg)

#### **INTEGRITY, TRIGGER & SECURITY PERMISSIONS – GRANT AND REVOKE**

 Permissions can be **GRANT**ed and **REVOKE**d

 Syntax:

```
GRANT <privilege_name> ON <object_name>
TO { <user_name> | PUBLIC | <role_name>} [ WITH GRANT OPTION ] ;
```
 Example: **GRANT**

> **GRANT SELECT ON** tab\_a **TO** user\_a ; **GRANT UPDATE ON** tab\_b **TO** user\_a ;

 Example: **REVOKE**

> **REVOKE SELECT ON** tab\_a **FROM** user\_a ;

**Databases, © Ulrike Herster, partially © Elmasri "Fundamentals of Database Systems – For personal use only**

![](_page_54_Picture_9.jpeg)

### **INTEGRITY, TRIGGER & SECURITY PERMISSIONS - LEAST PRIVILEGE PRINCIPLE**

- A user should have exactly the permissions necessary to do the work
	- … and not more!

- Important for web applications
	- anonymous end users
	- not trustworthy

**Databases, © Ulrike Herster, partially**

 Limit the possible damage of attacks

![](_page_55_Picture_7.jpeg)

#### **INTEGRITY, TRIGGER & SECURITY PERMISSIONS – ASSIGNMENT WEBSHOP**

- 1. Create a user student which is allowed to query and insert the table Product.
- 2. Revoke the insert privilege from a user student.

![](_page_56_Picture_3.jpeg)

![](_page_56_Picture_4.jpeg)

= License Notice
== Attribution
- This work is shared under the CC BY-NC-SA 4.0 License and the respective Public License.
- #link("https://creativecommons.org/licenses/by-nc-sa/4.0/")
- This work is based off of the work by Prof. Dr. Ulrike Herster.
- Some of the images and texts, as well as the layout were changed.
- The base material was supplied in private, therefore the link to the source
  cannot be shared with the audience.
