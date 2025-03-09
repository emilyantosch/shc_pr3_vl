![](_page_0_Picture_0.jpeg)

Source: https://en.itpedia.nl/2017/11/26/wat-is-een-database/

**DATABASES**

Prof. Dr. Ulrike Herster Hamburg University of Applied Sciences

![](_page_0_Picture_4.jpeg)

## **COPYRIGHT**

![](_page_1_Picture_1.jpeg)

The publication and sharing of slides, images and sound recordings of this course is not permitted

© Professor Dr. Ulrike Herster

The slides and assignments are protected by copyright. The use is only permitted in relation with the course of study. It is not permitted to forward or republish it in other places (e.g., on the internet).

**Databases, © Ulrike Herster, partially © Elmasri "Fundamentals of Database Systems – For personal use only** .

![](_page_1_Picture_6.jpeg)

#### **SUBQUERIES AND VIEWS VIEWS – UPDATING VIEWS**

 Views are Relations ... just like tables

- Should make no difference to users
- Question: **Can we modify the view's data?** Depends on type of view!

**Databases, © Ulrike Herster, partially © Elmasri "Fundamentals of Database Systems – For personal use only**

![](_page_2_Picture_5.jpeg)

![](_page_2_Picture_6.jpeg)

#### **SUBQUERIES AND VIEWS VIEWS – UPDATING VIEWS**

![](_page_3_Picture_1.jpeg)

- *Projection View*
	- **SELECT** a, b, c …
- *Selection View*
	- … **WHERE** < condition > …
- *Join View*

- … **FROM** tab\_a **JOIN** tab\_b …
- *Aggregation View*
	- **SELECT MAX**(x) …
- Other types and combinations exist

![](_page_3_Picture_12.jpeg)

![](_page_3_Picture_13.jpeg)

#### **SUBQUERIES AND VIEWS VIEWS – UPDATING VIEWS**

![](_page_4_Picture_1.jpeg)

- A view with a single defining table is updatable if
	- the view attributes contain the primary key of the base relation,
	- as well as all attributes with the NOT NULL constraint that have a default value specified
- Views defined on multiple tables using joins are only updatable in special cases E.g., **INSERT** and **UPDATE** for Join Views, if join condition is based on PK-FK
- Views defined using grouping and aggregate functions are not updatable

4 Source: Elmasri, Fundamentals of Database Systems, Page 115ff

![](_page_4_Picture_8.jpeg)

![](_page_4_Picture_9.jpeg)

#### **SUBQUERIES AND VIEWS GENERATED TABLES**

![](_page_5_Picture_1.jpeg)

- Syntax: **CREATE TABLE** <name> **AS SELECT** …
- Can create new table based on query
- New table is independent from old table
- Use cases:
	- Copy table
	- Copy parts of table
- Attention: New table does not have all constraints of the parent table!

![](_page_5_Picture_9.jpeg)

#### **SUBQUERIES AND VIEWS GENERATED TABLES**

![](_page_6_Picture_1.jpeg)

Example from before:

**CREATE TABLE** Underpaid ( lname , fname ) **AS SELECT** lname , fname **FROM** Employee **WHERE** salary < 1000 ;

![](_page_6_Picture_4.jpeg)

**Databases, © Ulrike Herster, partially © Elmasri "Fundamentals of Database Systems – For personal use only**

## **ORGANIZATION OUR JOURNEY IN THIS SEMESTER**

![](_page_7_Picture_1.jpeg)

**© Elmasri**

**"Fundamentals**

**Databases, © Ulrike Herster, partially**

- Integrity, Trigger & Security
- Database Applications
- **Transactions**
- Subqueries & Views
- More SQL
- Notations & Guidelines
- Constraints
- Relationships

**Database Systems –**

Simple Entities and Attributes

> **For**

**personal use**

 **only**

Basics

> **of**

7 Source: Foto von Justin Kauffman auf Unsplash

![](_page_7_Picture_13.jpeg)

![](_page_7_Picture_14.jpeg)

## **TRANSACTIONS BASICS**

![](_page_8_Picture_1.jpeg)

- A transaction bundles several operations into one logical unit
	- Unit of Work

- Includes one or more database access operations E.g., **INSERT**, **DELETE**, **UPDATE**, **SELECT**
- Operations must be executed all or none
- Example: Order a hotel room over the internet
	- Choose and reserve room
	- Payment
	- Final booking of the hotel room

![](_page_8_Picture_10.jpeg)

## **TRANSACTIONS ACID**

![](_page_9_Picture_1.jpeg)

- Key features of transactions
	- *Atomicity*: Transaction is executed in whole or not at all
	- *Consistency*: State of the DB is consistent before and after a transaction
	- *Isolation*: Transactions do not interfere with other concurrent transactions
	- *Durability*: Changes are stored permanently in the database and will not get lost

![](_page_9_Picture_7.jpeg)

### **TRANSACTIONS ACID - ATOMICITY**

- Begin of Transaction (*BoT*)
	- SQL99: **START TRANSACTION**
	- mySQL: **BEGIN**
	- Oracle: transaction is started automatically
- Commit a transaction: **COMMIT;**
	- All operations are made persistent
	- All changes are visible to other users
- Rollback transaction: **ROLLBACK;**
	- DB is in state at *BoT* again

**Databases, © Ulrike Herster, partially © Elmasri "Fundamentals of Database Systems – For personal use only**

![](_page_10_Picture_11.jpeg)

![](_page_10_Picture_12.jpeg)

## **TRANSACTIONS ACID - CONSISTENCY**

![](_page_11_Picture_1.jpeg)

- DB: in consistent state before transaction Also, in consistent state after transaction
- Integrity constraints assure that
- Constraints can be defined as
	- **IMMEDIATE** (default in mySQL)
		- are checked immediately after operation
	- **DEFERRED**

Check at time of commit

![](_page_11_Picture_9.jpeg)

![](_page_11_Picture_10.jpeg)

![](_page_11_Picture_11.jpeg)

### **TRANSACTIONS ACID - ISOLATION**

![](_page_12_Picture_1.jpeg)

- Transactions are isolated from other concurrent transactions
- Concurrent transactions shall behave well

![](_page_12_Picture_4.jpeg)

![](_page_12_Picture_5.jpeg)

### **TRANSACTIONS ACID – ISOLATION: CONCURRENCY CONTROL**

![](_page_13_Picture_1.jpeg)

- Concurrent operations can lead to problems
	- Lost Update
	- Dirty Read

- Unrepeatable read
- Phantom tuples

![](_page_13_Picture_7.jpeg)

![](_page_13_Picture_8.jpeg)

### **TRANSACTIONS ACID – ISOLATION: CONCURRENCY CONTROL – ISOLATION LEVELS IN SQL** Repetition

- Lost Update is prevented by SQL
- Transactions: may choose *Isolation Level*
	- **SERIALIZABLE**

- no problems
- **REPEATABLE READ** (default in mySQL)
	- Open for phantom tuples
- **READ COMMITTED** (default in Oracle, SQL Server) Open for phantom tuples and unrepeatable read
- **READ UNCOMMITTED**
	- Open for all problems

![](_page_14_Picture_10.jpeg)

#### **TRANSACTIONS ACID – ISOLATION: CONCURRENCY CONTROL – ISOLATION LEVELS IN SQL**

 **© Elmasri "Fundamentals of Database Systems – For personal use only** Source: https://www.bitesizedengineering.com/p/ database-isolation-levels-explained

![](_page_15_Picture_2.jpeg)

**Databases, © Ulrike Herster, partially**

15

Repetition

#### **TRANSACTIONS ACID – ISOLATION: CONCURRENCY CONTROL – IMPLEMENTATION**

![](_page_16_Picture_1.jpeg)

 Deadlocks may occur!!!

- Especially when using isolation leven **SERIALIZABLE**
- Usually are resolved automatically by aborting one transaction

![](_page_16_Figure_5.jpeg)

Source: https://blog.nodeswat.com/concurrency-mysql-andnode-js-a-journey-of-discovery-31281e53572e

**Databases, © Ulrike Herster, partially © Elmasri "Fundamentals of Database Systems – For personal use only**

![](_page_16_Picture_8.jpeg)

## **TRANSACTIONS ACID - DURABILITY**

- Once committed, changed data is safe
- Error types
	- 1. Computer failure
	- 2. Transaction or system error (constraint violation, ௫, blackout, system crash)
	- 3. Local Errors
	- 4. Concurrency control enforcement
	- 5. Disk error (harddisk broken)
	- 6. Physical problems and catastrophes (fire, earthquake, robbery, ...)

705 Source: Elmasri, Fundamentals of Database Systems, Page 750ff

![](_page_17_Picture_10.jpeg)

![](_page_17_Picture_11.jpeg)

## **TRANSACTIONS ACID – DURABILITY: ERROR HANDLING**

- Recovery from transaction failures usually means that the database is *restored* to the most recent consistent state just before the time of failure
- Minor damages due to error types 1-4 from slide "ACID – Durability"
	- DBMS provides handling

- Recovery strategy is to identify any changes that may cause an inconsistency in the database
	- Changes are first written to redo logs (files on disk)
	- Written to database files after commit

706 Source: Elmasri, Fundamentals of Database Systems, Page 808ff

![](_page_18_Picture_8.jpeg)

![](_page_18_Picture_9.jpeg)

## **TRANSACTIONS ACID – DURABILITY: ERROR HANDLING**

 Extensive damage due to error types 5-6 from slide "ACID – Durability"

- recovery handling restores a past copy of the database from archival storage
- reconstructs a more current state by redoing the operations
- Last transactions are lost!
- Solution: Redundancy
	- RAID

(**r**edundant **a**rray of **i**ndependent **d**isks)

Data Replication by DBMS

> 707 Source: Elmasri, Fundamentals of Database Systems, Page 808ff

![](_page_19_Picture_10.jpeg)

![](_page_19_Picture_11.jpeg)

### **TRANSACTIONS ACID – DURABILITY: ERROR HANDLING – DATA REPLICATION**

- Changes are performed on (replicated to) several database instances
	- Master/Slave

- Updates only on one instance (master)
- Slave: synchronous or asynchronous
- Multi-Master
	- Updates on different instances
	- Needs conflict resolution strategy

![](_page_20_Figure_8.jpeg)

![](_page_20_Picture_9.jpeg)

#### **TRANSACTIONS ACID – DURABILITY: ERROR HANDLING – DATA REPLICATION**

#### *Synchronous*

- Transaction valid only when committed on all DBs
- Safest, but performance impact
- May reduce availability of the system

**© Elmasri**

**"Fundamentals**

#### *Asynchronous*

**Databases, © Ulrike Herster, partially**

 Transaction valid when committed locally

![](_page_21_Picture_7.jpeg)

![](_page_21_Picture_8.jpeg)

### **TRANSACTIONS ACID – DURABILITY: ERROR HANDLING – DATA REPLICATION METHODS**

![](_page_22_Picture_1.jpeg)

- Low level (disk device)
- Trigger based
	- Update triggers the replication (SQL level)
- Logfile shipping
	- Changes are stored in redo logs (as usual)
	- redo logs are copied to standby DB

![](_page_22_Picture_8.jpeg)

**Databases, © Ulrike Herster, partially © Elmasri "Fundamentals of Database Systems – For personal use only**

## **TRANSACTIONS**

**ACID – DURABILITY: ERROR HANDLING – DATA REPLICATION METHODS**

#### Oracle

Data Guard

> Replication on second server, can be used to answer

Read-Only queries

![](_page_23_Figure_6.jpeg)

Source: https://docs.oracle.com/cd/B19306\_01/server.102/b14239/concepts.htm#i1033808

- Real Application Cluster (RAC)
	- Several servers share the same DB

**Databases, © Ulrike Herster, partially © Elmasri "Fundamentals of Database Systems – For personal use only**

![](_page_23_Picture_11.jpeg)

## **TRANSACTIONS DISTRIBUTED TRANSACTIONS**

- Transactions not only in a single DBS
- Standardized by X/Open

- Transaction Manager: A software component that guarantees transaction properties
- Resource Manager:
- Every resource (e.g., DBS, GUI) that is able to work in a transactional mode without providing a transaction control structure itself

![](_page_24_Figure_6.jpeg)

 The Transaction manager coordinates the Resource Manager that take part in the transaction. E.g., different DBS (distributed transactions) that appear as one DBS from outside (transparency!) 712

![](_page_24_Picture_9.jpeg)

![](_page_24_Picture_10.jpeg)

## **TRANSACTIONS DISTRIBUTED TRANSACTIONS**

 To ensure interoperability between the participating resource managers the *2-phase commit protocol*  is realized

![](_page_25_Figure_2.jpeg)

- It defines the final synchronization of different parts of a transaction of a global transaction
- In the first phase the transaction manager asks participating resource managers to announce the results of their local transaction part
- This leads to a global result (commit or rollback) that is then in the second phase announced to the participants

713 Source: https://medium.com/@balrajasubbiah/ consensus-two-phase-and-three-phasecommits-4e35c1a435ac

![](_page_25_Picture_7.jpeg)

**Databases, © Ulrike Herster, partially © Elmasri "Fundamentals of Database Systems – For personal use only**

![](_page_26_Picture_1.jpeg)

- There are operations that may be expensive to execute time consuming
- If certain constraints fail within transaction execution, then maybe these constraints may not fail in a second attempt (e.g., time dependent)
- So "fall back" points can be defined, which are called *savepoints*
- It is possible to rollback up to a savepoint and restart transaction execution from this point on

![](_page_26_Picture_6.jpeg)

## **TRANSACTIONS SAVEPOINTS**

![](_page_27_Picture_1.jpeg)

## Example:

|         |                                 |                  |     |         |                                 |                  | Sarepoint<br>2 |
|---------|---------------------------------|------------------|-----|---------|---------------------------------|------------------|----------------|
| STUDENT |                                 |                  |     | STUDENT |                                 |                  |                |
|         | STUDENT ID STUDENT NAME Address |                  | Age |         | STUDENT ID STUDENT NAME Address |                  | Age            |
|         | 100 Joseph                      | Troy             | 22  |         | 100 Joseph                      | Troy             | 22             |
|         | 101 Mahtwe                      | Lakeside Village | 23  |         | 101 Mathew                      | Lakeside Village | 22             |
|         | 102 Jacob                       | Fraser Town      | 22  |         | 102 Jacob                       | Fraser Town      | 22             |

![](_page_27_Figure_6.jpeg)

715 Source: https://www.tutorialcup.com/ dbms/transaction-control-language.htm

![](_page_27_Picture_8.jpeg)

![](_page_27_Picture_9.jpeg)

## **ORGANIZATION OUR JOURNEY IN THIS SEMESTER**

![](_page_28_Picture_1.jpeg)

- **Integrity, Trigger & Security**
- Database Applications
- Transactions
- Subqueries & Views
- More SQL
- Notations & Guidelines
- Constraints
- Relationships
- Simple Entities and Attributes
- Basics

762 Source: Foto von Justin Kauffman auf Unsplash

![](_page_28_Picture_13.jpeg)

**Databases, © Ulrike Herster, partially © Elmasri "Fundamentals of Database Systems – For personal use only**

## **INTEGRITY, TRIGGER & SECURITY INTEGRITY CONSTRAINTS**

 Static Constraints

- Conditions on states
- Conditions must be fulfilled before and after operations
- Used until now
	- Primary Key
	- Foreign Key
	- **UNIQUE**, **NOT NULL**, **CHECK**

Dynamic Constraints (*Assertions*)

- Integrity conditions that affect multiple tables
- Conditions on state transitions Example: status of order

new payed processing shipped

![](_page_29_Picture_12.jpeg)

**Databases, © Ulrike Herster, partially © Elmasri "Fundamentals of Database Systems – For personal use only**

## **INTEGRITY, TRIGGER & SECURITY INTEGRITY CONSTRAINTS**

- Assertions have been part of the SQL since SQL-92 (DDL)
- Not supported by most DBMS (e.g., MySQL, Postgres and Oracle)
- If the concept of assertions is to be simulated **TRIGGER**
- Concept:
	- Whenever anything is modified in the database, the assertion checks its condition
	- If the **SELECT**-statement gives a non-empty result, the operation that has triggered the assertion is denied

![](_page_30_Picture_7.jpeg)

## **INTEGRITY, TRIGGER & SECURITY TRIGGER – ECA RULE**

#### *ECA* rules

![](_page_31_Figure_2.jpeg)

765 Quelle: https://dev.acquia.com/blog/drupal-8-module-of-the-week/ drupal-8-module-of-the-week-rules/15/06/2016/15681

**Databases, © Ulrike Herster, partially © Elmasri "Fundamentals of Database Systems – For personal use only**

## **INTEGRITY, TRIGGER & SECURITY TRIGGER**

![](_page_32_Picture_1.jpeg)

Source: https://www.youtube.com/ watch?v=gpthfJnvzY8

**Databases, © Ulrike Herster, partially © Elmasri "Fundamentals of Database Systems – For personal use only**

![](_page_32_Picture_4.jpeg)

## **INTEGRITY, TRIGGER & SECURITY TRIGGER – SYNTAX IN MYSQL**

```
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
![](_page_33_Picture_3.jpeg)

## **INTEGRITY, TRIGGER & SECURITY TRIGGER – EXCURSION: DELIMITER**

- A MySQL client program such as MySQL Workbench or mysql program uses the delimiter (";") to separate statements and executes each statement separately
- However, a stored procedure consists of multiple statements separated by a semicolon (";")
- If you use a MySQL client program to define a stored procedure that contains semicolon characters, the MySQL client program will not treat the whole stored procedure as a single statement, but many statements.
- Therefore, you must redefine the delimiter temporarily so that you can pass the whole stored procedure to the server as a single statement.
- To redefine the default delimiter, you use the delimiter command

768 Source: https://www.mysqltutorial.org/ mysql-stored-procedure/mysql-delimiter/

![](_page_34_Picture_8.jpeg)

## **INTEGRITY, TRIGGER & SECURITY TRIGGER – EXCURSION: DELIMITER**

- Shortly: A delimiter is a separator between commands
- For example:

```
delimiter |
…
|
delimiter ;
```
 In the code block between "delimiter" and "delimiter;" the delimiter is changed to "|" (instead of ";")

![](_page_35_Picture_5.jpeg)

#### **INTEGRITY, TRIGGER & SECURITY TRIGGER – EXAMPLE IN MYSQL**

```
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
delimiter;Source: Elmasri, Fundamentals ofDatabase Systems
```
![](_page_36_Picture_2.jpeg)

770

**Databases, © Ulrike Herster, partially © Elmasri "Fundamentals of Database Systems – For personal use only**

## **INTEGRITY, TRIGGER & SECURITY TRIGGER – SYNTAX IN ORACLE**

```
CREATE [OR REPLACE] TRIGGER trigger_name
{BEFORE | AFTER } triggering_event ON table_name
[FOR EACH ROW]
[FOLLOWS | PRECEDES another_trigger]
[ENABLE/DISABLE]
```

```
 [WHEN condition]
```
## **DECLARE**

declaration statements

## **BEGIN**

executable statements

## **EXCEPTION**

exception\_handling statements

**END**;

**Databases, © Ulrike Herster, partially © Elmasri "Fundamentals of Database Systems – For personal use only**

![](_page_37_Picture_11.jpeg)

## **INTEGRITY, TRIGGER & SECURITY TRIGGER – EVENTS**

- Triggers can react on events
	- DML: **INSERT**, **UPDATE**, **DELETE**
		- Most common trigger types
	- DDL: **CREATE**, **ALTER**, **DROP**
	- DB: startup, shutdown, logon of a user
- No **COMMIT** triggers

![](_page_38_Picture_7.jpeg)

**Databases, © Ulrike Herster, partially © Elmasri "Fundamentals of Database Systems – For personal use only**

## **INTEGRITY, TRIGGER & SECURITY TRIGGER – TYPES**

- Time of execution, relative to event
	- **BEFORE**
	- **AFTER**

- **INSTEAD OF**
- Statement trigger
	- Once per statement
	- Even if no row is affected!
	- Default trigger type
- Row trigger

- For every affected row
- Syntax: **FOR EACH ROW**

![](_page_39_Picture_12.jpeg)

![](_page_39_Picture_13.jpeg)

**Databases, © Ulrike Herster, partially © Elmasri "Fundamentals of Database Systems – For personal use only**

## **INTEGRITY, TRIGGER & SECURITY TRIGGER – ORDER OF TRIGGER EXECUTION**

 Before Statement Trigger (once!)

- For every row affected:
	- Before row trigger
	- DML operation
	- Immediate integrity checks
	- After row trigger
- After Statement Trigger (once!)

![](_page_40_Picture_8.jpeg)

## **INTEGRITY, TRIGGER & SECURITY TRIGGER – TRANSITION VARIABLES**

- Row triggers can access old and new tuples MySQL
	- :old or oldNULLfor **INSERT**s

 :new or new NULL for **DELETE**s

 Oracle

- NEW and OLD
- Before row triggers:
	- Can even modify new!

![](_page_41_Picture_8.jpeg)

## **INTEGRITY, TRIGGER & SECURITY TRIGGER – USE CASES**

- Constraints on state transitions
- Audit

- When was a record last modified?
- Integrity checks with error correction Change :**new**
- Maintain redundant data
- Updateable views **INSTEAD OF**

![](_page_42_Picture_7.jpeg)

### **INTEGRITY, TRIGGER & SECURITY TRIGGER – EXAMPLE IN MYSQL**

Example: Audit insertion of new persons

```
DROP TRIGGER IF EXISTS emp_insert;
```

```
CREATE TRIGGER emp_insert
```
**AFTER INSERT ON** employee

```
FOR EACH ROW
```

```
INSERT INTO EMPLOYEE_LOG (ESSN, INSERT_DATE)
```

```
VALUES ( NEW.ssn , NOW() ) ;
```
![](_page_43_Picture_8.jpeg)

![](_page_43_Picture_9.jpeg)

![](_page_43_Picture_10.jpeg)

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