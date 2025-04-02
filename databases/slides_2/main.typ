#import "@preview/touying:0.5.2": *
#import themes.university: *

#import "@preview/fletcher:0.5.1" as flechter: diagram, node, edge
#import "@preview/tiaoma:0.2.1"
#import "@preview/gentle-clues:1.0.0": *
#import "@preview/pinit:0.2.0": *
#import "@preview/codly:1.0.0": *
#show: codly-init.with()
#import "@preview/numbly:0.1.0": numbly

#set text(lang: "en")
#set heading(numbering: numbly("{1}.", default: "1.1"))
#set align(left + top)

#show raw: it => {
  show regex("pin\d"): it => pin(eval(it.text.slice(3)))
  it
}

#show: university-theme.with(
  aspect-ratio: "16-9",
  config-info(
    title: [Databases],
    subtitle: [Lecture 2: SQL - Structured Query Language],
    author: [Emily Lucia Antosch],
    date: datetime.today().display("[day].[month].[year]"),
    institution: [HAW Hamburg],
  ),
)

#set text(size: 20pt)

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

= Introduction

== Where are we right now?

- Last time, we looked at the bare basics of databases and why we should use databases at all.
- Today, we'll be discussing
  - working with the main language of databases: SQL,
  - how to create a small relational database in PostgreSQL,
  - simple design pattern that we will build upon in the future!

#slide[
  1. Introduction
  2. Basics
  3. *SQL*
  4. Entity-Relationship-Model
  5. Relationships
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
    - create a small database example using an installation of PostgreSQL,
    - create, update, remove and delete elements from your database (CRUD)
    - use simple design patterns to design a good database.
]


= SQL: Structured Query Language
== What is SQL?
#slide[
  - Standard language for managing relational databases
  - Used for querying, updating, and managing data
]

#slide[
  - SQL comes in different flavours, depending on the DBMS you use it in.
    - You'll find that some small things work differently in PostgreSQL, mySQL and SQLite.
    - However once you know one flavour, you can easily navigate writing code in another.
]

== How can we use SQL right now?
#slide[
  - Depending on your installation of SQL and your OS, you have different ways to use SQL.

  - In our case, we have installed PostgreSQL, which leaves us with multiple options:
    - Interacting with your database can be done using the CLI (command-line interface).
    - You can use Postgres' own database manager called pgAdmin.
    - In your editor of choice, you can most likely install a database interface to connect to your database (VSCode, JetBrains, NeoVim).
]

#slide[
  #question[
    - Since passing this lecture requires you to install a DBMS on your system, I would like to ask you:
      - What OS are you using?
      - What Editor are you using?
      - Do you think you need help with installing a DBMS?
  ]
]

== Basic SQL Commands
#slide[
  #align(center + horizon)[
    #idea[
      - `CREATE`: Create a database element, like a table or view
      - `SELECT`: Retrieve data from an element
      - `INSERT`: Add new records or rows into a table
      - `UPDATE`: Modify existing records or rows in a table
      - `DELETE`: Remove records or rows from a table
    ]
  ]
]

= First Steps
== SQL: Step-by-Step Walkthrough

#slide[
  #heading(numbering: none)[`CREATE`-Statement]
  - To begin working with SQL, make sure to connect to your database in order to run your commands.
  - Next, let's create a table, the most basic building block of our database:
  ```sql
  CREATE TABLE EMP
  (
    _ID INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    NAME TEXT NOT NULL,
    DEPARTMENT TEXT,
    SALARY INT DEFAULT 0
  );
  ```
]

#slide[
  #heading(numbering: none)[`CREATE`-Statement]
  Let's look at the `_ID` column a little more in detail:
  ```sql
  _ID INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY
  ```
  - `_ID`: Name of the column

  #question[
    If you're wondering why I named the identifier of the table `_ID` and not `ID`: I do this in order to denote that the identifier is an internal value to the database and will not be shown to the user!
  ]
]

#slide[
  #heading(numbering: none)[`CREATE`-Statement]
  Let's look at the `_ID` column a little more in detail:
  ```sql
  _ID INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY
  ```
  - `INTEGER`: The data type of the column. We'll explore data types a more in-depth very shortly
]

#slide[
  #heading(numbering: none)[`CREATE`-Statement]
  Let's look at the `_ID` column a little more in detail:
  ```sql
  _ID INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY
  ```
  - `PRIMARY KEY`: This denotes that is column is used to unique identify each row of the table. This column has a unique value for each row. We'll look more closely at PKs (primary keys) in the near future.
]

#slide[
  #heading(numbering: none)[`CREATE`-Statement]
  Let's look at the `_ID` column a little more in detail:
  ```sql
  _ID INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY
  ```
  - `GENERATED ALWAYS AS IDENTITY`: In order to achieve this, we'll let PostgreSQL auto generate the identifier for us.
]

#slide[
  #heading(numbering: none)[`CREATE`-Statement]
  - You might have noticed, that each of the columns of a table has a data type.
  - Data types, like in conventional programming, denote what type of data the column can contain.
  #example[
    - `INTEGER`: Integer number data (`int` in C)
    - `REAL`: Real number data (`double` in C)
    - `TEXT`: String data (`char[]` in C)
    - `DATE`: Dedicated date type (no direct equivalent in C)
  ]
]

#slide[
  #heading(numbering: none)[`CREATE`-Statement]
  - Furthermore, columns can be defined as `NULL` or `NOT NULL`. This defines if the column can be left empty or not.
  - Also, by using `DEFAULT` you can define the default value of a column if let empty.
]

#slide[
  #heading(numbering: none)[`INSERT`-Statement]
  - Next, we need some form of data that our table can hold.
  - Let's insert three employees. I'll show you the easiest method to do so:
  ```sql
  INSERT INTO EMP
  (
    _ID, NAME, DEPARTMENT, SALARY
  )
  VALUES
  (
    100, 'Max Power', 'HR', 3500
  );
  ```
  - Alternatively you also use a `SELECT`-Statement, but more on that later!
]

#slide[
  #heading(numbering: none)[`INSERT`-Statement]
  ```sql
  INSERT INTO EMP
  (
    _ID, NAME, DEPARTMENT, SALARY
  )
  VALUES
  (
    101, 'Tim Maxwell', 'Engineering', 5000
  );
  ```
]

#slide[
  #heading(numbering: none)[`INSERT`-Statement]
  ```sql
  INSERT INTO EMP
  (
    _ID, NAME, DEPARTMENT, SALARY
  )
  VALUES
  (
    102, 'Rachel Smith', 'IT', 5500
  );
  ```
]


#slide[
  #heading(numbering: none)[`SELECT`-Statement]
  - Now, we want to look at the data we just inserted into our database:
  ```sql
  SELECT
    _ID, NAME, DEPARTMENT, SALARY
  FROM
    EMP;
  ```
  #align(center + horizon)[
    #table(
      align: center,
      columns: (auto, auto, auto, auto, auto),
      table.header([`ROW_NUM`], [`_ID`], [`NAME`], [`DEPARTMENT`], [`SALARY`]),
      [1], [100], [Max Power], [HR], [3500],
      [2], [101], [Tim Maxwell], [Engineering], [5000],
      [3], [102], [Rachel Smith], [IT], [5500],
    )
  ]
]
#slide[
  #tip[
    - Alternatively you can use `*` to select all columns of the table:
    ```sql
    SELECT
      *
    FROM
      EMP;
    ```
  ]
]

#slide[
  #heading(numbering: none)[`UPDATE`-Statement]
  - Let's say we want to update the salary of an employee. Maybe they got a raise?
  ```sql
  UPDATE emp
  SET
  SALARY = 6000
  WHERE NAME = 'Max Power';
  ```
  #align(center + horizon)[
    #table(
      align: center,
      columns: (auto, auto, auto, auto, auto),
      table.header([`ROW_NUM`], [`_ID`], [`NAME`], [`DEPARTMENT`], [`SALARY`]),
      [1], [100], [Max Power], [HR], [6000],
      [2], [101], [Tim Maxwell], [Engineering], [5000],
      [3], [102], [Rachel Smith], [IT], [5500],
    )
  ]
]

#slide[
  #heading(numbering: none)[`WHERE`-Clause]
  - You may have noticed in the last example, that we used the keyword `WHERE`.
  - It's one of the most important keywords, that you won't be able to live without.
  - It defines conditions for the query to be executed.
  ```sql
  SELECT
    *
  FROM
    EMP
  WHERE
    SALARY <= 5000;
  ```
  #align(center + horizon)[
    #table(
      align: center,
      columns: (auto, auto, auto, auto, auto),
      table.header([`ROW_NUM`], [`_ID`], [`NAME`], [`DEPARTMENT`], [`SALARY`]),
      [2], [101], [Tim Maxwell], [Engineering], [5000],
    )
  ]
]

#slide[
  #heading(numbering: none)[`DELETE`-Statement]
  - Now that we know about the `WHERE`-Clause, we can also use it to delete a record in the table.
  - Let's say one of the employees has left the company:
  ```sql
  DELETE FROM EMP
  WHERE NAME = 'Rachel Smith';
  ```
  #align(center + horizon)[
    #table(
      align: center,
      columns: (auto, auto, auto, auto, auto),
      table.header([`ROW_NUM`], [`_ID`], [`NAME`], [`DEPARTMENT`], [`SALARY`]),
      [1], [100], [Max Power], [HR], [3500],
      [2], [101], [Tim Maxwell], [Engineering], [5000],
    )
  ]
]

#slide[
  #heading(numbering: none)[CRUD]
  - Using our knowledge, we are now able to design very simple databases!
]

= DDL: Data Definition Language
== Sequences
#slide[
  #heading(numbering: none)[Using Sequences]
  - Apart from tables, we can also use the `CREATE`-statement to create other database objects.
  - One of those objects is the Sequence
  ```sql
    CREATE SEQUENCE <seqname> [ INCREMENT BY < integer >] [ START WITH < integer > ] [...];
  ```
  - Sequences allow the developer to define a special sequence. This is useful if your `PRIMARY KEY` follows a special sequence of values.
]

#slide[
  #heading(numbering: none)[Using Sequences]
  - These can be used in the `DEFAULT` definition of the column or later used in triggers.
  ```sql
    CREATE SEQUENCE S_USERS INCREMENT BY 5 START WITH 100;
    CREATE TABLE USERS (
      _ID INTEGER DEFAULT nextval('S_USERS'),
      NAME TEXT
    )
  ```
  #info[
    I tend to prefix sequences with an `S` (I also do this for other special database objects, we'll learn about later like Views and Trigger!)
  ]
]

== Altering our database
#slide[
  #heading(numbering: none)[`ALTER`-Statement]
  #question[
    - But what if our data changes? How can we adapt our database to suit our needs?
  ]
  - Answer: The `ALTER`-Statement!
]

#slide[
  #heading(numbering: none)[`ALTER`-Statement]
  - Using the alter statement, we can add and remove columns, as well as change their data type.
]

#slide[
  #heading(numbering: none)[`ALTER`-Statement]
  - Let's say we want to record, when our employees have joined the company.
  ```sql
  ALTER TABLE EMP
  ADD JOIN_DATE TEXT;
  ```
]

#slide[
  #heading(numbering: none)[`ALTER`-Statement]
  - Oh, darn, we have assigned the wrong data type! The `DATE` data type is a better fit for this column.
  - Let's correct our mistake.
  ```sql
  ALTER TABLE EMP
  MODIFY COLUMN JOIN_DATE DATE;
  ```
]

#slide[
  #heading(numbering: none)[`ALTER`-Statement]
  - And now, the `DEPARTMENT` of each employee is meant to be stored in a different table. We'll remove it for now.
  ```sql
  ALTER TABLE EMP
  DROP COLUMN DEPARTMENT;
  ```
]

#slide[
  #heading(numbering: none)[`DROP`-Statement]
  - In the last example, you saw how we can delete a column from a table, by using the `DROP` statement.
  - We can also apply this to tables:
  ```sql
  DROP TABLE EMP;
  ```
  #memo[
    If there is no problem with the deletion, this will delete the table and all of the records inside!
  ]
]

#slide[
  #heading(numbering: none)[`DROP`-Statement]
  - Delete named schema elements, e.g., tables, constraints, schema, indexes, triggers
  - `DROP` needs to observe referential integrity, in order to drop tables in correct order
  - Two drop behavior options:
    #sym.arrow CASCADE
    #sym.arrow RESTRICT
  - `DROP` deletes all data AND the data definition
    - if you want to delete only the data then use `DELETE`
]

#slide[
  #heading(numbering: none)[`DROP`-Statement: Syntax]
  - Syntax:
  ```sql
  DROP TABLE < relationname > [( CASCADE | RESTRICT )]
  ```

  #example[
    ```sql
    DROP TABLE Dependent RESTRICT;
    ```
    #sym.arrow The table is dropped only if it is not referenced in any constraint or view or by another element

    ```sql
    DROP TABLE Dependent CASCADE;
    ```
    #sym.arrow The table is dropped even if there are references 436 S
  ]
]

#slide[
  #heading(numbering: none)[`DROP`-Statement: Columns]
  - Here, you can also define the drop behavior:
    - `CASCADE`
    - `RESTRICT`

  #example[
    ```sql
    ALTER TABLE COMPANY.Employee DROP COLUMN Address CASCADE;
    ```
  ]
]

#slide[
  #heading(numbering: none)[`DROP`-Statement: Columns]
  ```sql
   ALTER TABLE COMPANY.Department ALTER COLUMN Mgr_ssn DROP DEFAULT; -- Drop the default value

   ALTER TABLE COMPANY.Department ALTER COLUMN Mgr_ssn SET DEFAULT ‘333445555’; -- Set a new default value

   ALTER TABLE COMPANY.Employee DROP CONSTRAINT EMPSUPERFK CASCADE; -- Drop all constraints that depend on EMPSUPERFK
  ```
]
]

== Index
#slide[
  #heading(numbering: none)[Using `INDEX`]
  - Internal structure to increase speed of queries
  - Speed up the search for and retrieval of records (access paths)
    #sym.arrow But slow down inserts and updates
    #sym.arrow Memory consumption!
  - Earlier versions of SQL had commands for creating indexes, but these were removed because they were not at the conceptual schema level
  - Many systems still have the CREATE INDEX commands.
  ```sql
  CREATE [ UNIQUE ] INDEX <name> ON < table > ( < column > [ , . . . ] )
  ```
]

#slide[
  #heading(numbering: none)[When to use `INDEX`]

  - Column is used often for searches or sorting
  - Many different values, `NULL` seldom
  - Many rows in table
  - More reads than writes on data
  - Might be used as join condition
  - RDBMS must check value for referential integrity
  - Column is an FK
  - Referenced column (PK) usually already has an index
]

== More Objects
#slide[
  #heading(numbering: none)[More Database Objects]

  - DB Objects can be `CREATE`d, `ALTER`ed, `DROP`ped
  - `USER`, `ROLE`
    - DB users and groups
  ```sql
    CREATE USER user [ IDENTIFIED BY [PASSWORD] ’ passwd ’ ] [ , user [ IDENTIFIED BY [PASSWORD] ’ passwd ’ ] ];
  ```
  - VIEW
    - User view on table (external layer)
  ```sql
    CREATE OR REPLACE VIEW view [SELECT ... FROM ...];
  ```
  #memo[
    While on first glance views might not seem all that powerful, they are one of the most used database objects, offering a wid variety of uses in application development.
]
]

#slide[
  #heading(numbering: none)[`USER` and `ROLE`]
  - Example: User
    - Either owner of a relation or the DBA can grant (or revoke) selected users the privileges to use a SQL statement (e.g., `SELECT`, `INSERT`, `DELETE`)
    ```sql
    CREATE USER ‘student' IDENTIFIED BY ‘123’;
    GRANT ALL PRIVILEGES ON COMPANY.Employee TO ‘student’;

    REVOKE DROP ON COMPANY.Employee FROM ‘student’;
    SHOW GRANTS FOR student;
    ```
]

#slide[
  #heading(numbering: none)[More examples]
  - `TABLESPACE`
    #sym.arrow Grouping of tables based on physical storage
  - `SYNONYM`
    #sym.arrow Alias name for tables, views, sequences
  - `FUNCTION`, PROCEDURE
    #sym.arrow Stored Procedure, Persistent Stored Module (PSM)
  - `TRIGGER`
    #sym.arrow Active rule for certain events
]

= DML: Data Manipulation Language
== Simple Data Manipulation
#slide[
  #heading(numbering: none)[`INSERT`, `UPDATE`, `DELETE`]
  - INSERT, UPDATE, DELETE
    - All operations work on a set of tuples
      - Special case(!): work on one tuple
    - Example for modifications of sets of tuples:
      - Increase the wage of all employees by 10
      - Delete stock with price below 1€
      - Set the academic title of some students to ’BSc’
]

== Transactions in a nutshell
#slide[
  #heading(numbering: none)[What is a transaction?]
  - Start a transaction
    #sym.arrow While some DBMS (e.g. PostgreSQL) need to explicitly start a transaction, some others (e.g. Oracle) do not
  - After starting a transaction, you can make changes to the db that stay local to your session.
  - Whenever you feel ready, you can use `COMMIT;` to commit those changes to the database.
  - If you make a mistake, you can use `ROLLBACK;` while in a transaction to undo your changes.
  #memo[
    If you forget to explicitly commit your changes, you will lose those changes when quitting the transaction.
  ]
]
== Inserting into tables
#slide[
  #heading(numbering: none)[`INSERT`-statement]
  ```sql
   INSERT INTO < table > [ ( < column > [ , … ] ) ] VALUES ( < expression > [ , ...] );
  ```
  - The column list is optional
    - If omitted, values list must match table’s attributes
    - If given, we don’t have to specify values for all columns. Other columns will get the `DEFAULT` value (or `NULL`).
]

#slide[
  #heading(numbering: none)[`INSERT`-statement]
  - In general, you have two possibilities for inserting into a table using the `INSERT`-statement
    - *value list*
    - tuples returned by a query
  #example[
    ```sql
    INSERT INTO EMPLOYEE VALUES ( ‘Arthur’ , ‘C’, ‘Brown’ , 323232323,  ‘1970−12−31’, ‘London’, ‘m’, 45000, 3334455555, 5 );
    INSERT INTO EMPLOYEE ( first_name, last_name, emp_num, superior_num, dept_num) VALUES ( ‘Andi’ , ’Red’, 343434343, 333445555, 5);
    ```
  ]
  #info[
    You may define what columns to fill. You must fill all `NOT NULL` columns.
  ]
]

#slide[
  #heading(numbering: none)[`INSERT`-statement]
  #let left = [
    #example[
      ```sql
      INSERT INTO Book  VALUES ( 1 , 1 , 4712 , ’DBS’ );
      INSERT INTO Book  VALUES ( 2 , 2 , 9991 , ‘DB1‘);
      COMMIT;
      INSERT INTO Book  VALUES ( 3 , NULL , 4242 , ’Hitch’ );
      ROLLBACK;
      INSERT INTO Book ( BNr, ISBN , Title ) VALUES ( 3 , 4242, ‘Hitchhiker‘);
      ```
    ]
  ]
  #let right = figure(image("../assets/img/slides_02/20250215_insert_const_tuple_rev01.png"))
  #grid(
    columns: (auto, auto),
    gutter: 0.25em,
    left, right,
  )
]

#slide[
  #heading(numbering: none)[`INSERT`-statement]
  - In general, you have two possibilities for inserting into a table using the `INSERT`-statement
    - value list
    - *tuples returned by a query*
  #example[
    ```sql
    INSERT INTO USERS ( last_name, first_name ) SELECT last_name, first_name FROM EMP WHERE IS_USER = 1;
    ```
  ]
]

#slide[
  #heading(numbering: none)[Date formats]
  - Inserting dates into the DB requires to use the format that depends on the flavor of DBMS
    ```sql
     UPDATE Person SET birthdate = ’2008−12−31’
    ```
  - A date-function can also be used:
    ```sql
    INSERT INTO Person (name, birthdate) VALUES (’Anna’, ’02−FEB−1955’);
    INSERT INTO Person (name, birthdate) VALUES (’Anna’, TO_DATE(’02.02.1955’));
    INSERT INTO Person (name, birthdate) VALUES (’Anna’, TO_DATE( ’02−02−1955’, ’DD−MM−YYYY’));
    ```
]

#slide[
  #heading(numbering: none)[Constraints]
  - All modifications need to observe constraints:
    - Domain Constraints meaning the data types must match
      - If type conversion are implicit or are required to be explicit is vendor-specific
    - Entity Integrity, so whether or not the Primary Key value is not null and unique
    - Referential Integrity (Foreign Key), so if the master table has a row that matches the referenced data
    - Semantical Integrity (check constraints)
]

== Updating table data
#slide[
  #heading(numbering: none)[`UPDATE`-statement]
  ```sql
   UPDATE < table > SET < column > = < expression >  [ WHERE < condition >];
  ```
  - Used to modify attribute values of one or more selected tuples
  - Can modify only tuples of one table at a time
  - `WHERE`-clause is optional and if left out updates all tuples of the table
  #info[
    Updating a primary key value may propagate to the foreign key values of tuples in other relations if such a referential triggered action is specified in the referential integrity constraints of the DDL.
  ]
]

#slide[
  #heading(numbering: none)[`UPDATE`-statement: examples]
  ```sql
    UPDATE Person SET lname= ’Brown’, married = TRUE WHERE id = 45;
    UPDATE Employee SET salary = salary ∗ 1.1;
    UPDATE Person SET email = NULL WHERE email IS NOT NULL;
  ```
]
]

== Deleting table data
#slide[
  #heading(numbering: none)[`DELETE`-statement]
  - Removes tuples from a relation, the relation stays in the database
  ```sql
   DELETE FROM < table > [WHERE < condition >]
  ```
  - Again, the `WHERE`-clause is optional and, if left out, will delete all tuples!
  #memo[
    It is imperative to observe the referential integrity!
  ]
]

#slide[
  #heading(numbering: none)[`DELETE`-statement]
  #let left = [
    - Insert a new student `<‘Johnson’, 25, 1,‘Math’>` into the database.
    - Change the class of `STUDENT` ‘Smith’ to 2.
    - Insert a new course: `<‘Knowledge Engineering’, ‘CS4390’, 3, ‘CS’>`.
    - Delete the record for the student whose name is ‘Smith’ and whose student number is 17.
  ]
  #let right = [
    #figure(image("../assets/img/slides_02/20250211_cs_assignment_rev01.png"))
  ]
  #grid(
    columns: (auto, auto),
    gutter: 0.25em,
    left, right,
  )
]



= Queries: An in-depth look
== What are queries?
#slide[
  - Ad-hoc-formula: No programs, requests!
  - Descriptiveness: "What do I want", not "How do I get it"
  - Set-orientation: Much data at once, not only a single tuple
  - Seclusion: All results are relations again and can be queried again
  - Adequate: All data model constructs are supported
  - Orthogonal: There are view independent commands that can be combined
]

== What is a good Query Language?
#slide[
  - Performant: The language is transformable, so that the user may use simple queries that are substituted into fast ones (with the same result!).
  - Efficient: Each operation can be executed efficiently.
  - Secure: All queries lead to finite result sets in finite time.
  - Complete: Everything that is requestable, can be formulated by a query.
  - Definitive: The same request on the same data always yields the same result.
]

== Queries in SQL
#slide[
  #let left = [
    #heading(numbering: none)[DML: Data Manipulation Language]
    ```sql
      INSERT INTO (...) VALUES (...);
      DELETE FROM ...;
      UPDATE ... SET ...;
    ```
  ]
  #let right = [
    #heading(numbering: none)[DQL: Data Query Language]
    ```sql
      SELECT ... FROM ...;
    ```
  ]
  #grid(
    columns: (auto, auto),
    gutter: 0.25em,
    left, right,
  )
  #memo[
    - DQL is only used to retrieve data that is already there.
    - It does not modify data.
    - It only uses one basic keyword: `SELECT`
  ]
]

#slide[
  #heading(numbering: none)[Relational Model vs. SQL]
#memo[
    SQL allows, in contrast to the Relational Model, a table to have two or more tuples to be identical in all of their attributes.
    This makes SQL tables multi sets by design.
  ]
  - There are ways to enforce tables to follow certain rules using SQL constraints.
  - We'll check these out later in the lecture.
]

#slide[
  #heading(numbering: none)[Query Syntax]
  ```sql
  SELECT [ DISTINCT | ALL ] < attribute_list >
  FROM < table list >
  [ WHERE < condition > ]
  [ <group by clause > ] [ <having clause > ]
  [ UNION [ ALL ] < query specification> ]
  [ < order by clause > ]
  ```
]

#slide[
  #heading(numbering: none)[Basic Syntax]
  ```sql
    SELECT <attribute list>
    FROM <table list>
    WHERE <condition>
  ```
  - `<attribute list>` is a list of attribute names (columns) whose values are to be retrieved by the query
  - `<table list>` is a list of the relation names (e.g.,tables) required to process the query
  - `<condition>` is an optional conditional (Boolean) expression that identifies the tuples to be retrieved by the query
]

#slide[
  #heading(numbering: none)[Examples]
  #example[
    ```sql
    SELECT Bdate, Address
    FROM Employee
    WHERE Fname = ‘John’ AND Minit = ‘B’ AND Lname = ‘Smith’;

    SELECT Fname, Lname, Address
    FROM Employee, Department
    WHERE Dname = ‘Research’ AND Dnumber = Dno;
    ```
  ]
  #question[
    What do these queries mean?
  ]
]

#slide[
  #heading(numbering: none)[Attribute List]
  - The `<attribute list>` represents the selected columns, whose values are supposed to be retrieved.
  ```sql
  SELECT NAME, SALARY
  FROM EMP
  ```
  - Using the `*`, you can select all columns at once.
  #info[
    You can also use aggregate functions, arithmetic expressions as well as constants in your queries:
    ```sql
      SELECT 'Hello World!' as HELLO_WORLD FROM EMP;
    ```
  ]
]

#slide[
  #heading(numbering: none)[Attribute List]
  - When the column names are unambiguous, you can just write their name
  - If the same column could be attributed to multiple columns, you need to write the table or table alias in front of the name:
  ```sql
  SELECT d._ID, e.NAME, e.SALARY as sal
  FROM EMP e
  LEFT JOIN DEPARTMENT d ON d._ID = e.DEPARTMENT_ID
  ```
  #info[
    As seen in the previous example, both tables and attributes can be given an alias either by using `AS` or by simply writing the alias after the table name.
  ]
]

#slide[
  #heading(numbering: none)[Using `DISTINCT`]
  - When you want to retrieve all unique values for a data set, you can use the keyword `DISTINCT`.
  - This will deduplicate the results, depending on the set of attributes you selected in your `SELECT` statement.
    ```sql
    SELECT DISTINCT e.NAME
    FROM EMP e
    ```
  - This query will only retrieve all unique names of all employees. If an employee is listed more than once due to some reason, their name will only appear once in the result of the query.
]

// FIXME:Table list with two tables matched with a comma are a cross join, not an inner join, this is still incorrect in the part about joins

#slide[
  #heading(numbering: none)[Table List]
  - The `<table list>` is a list of relation names (tables) required to process the query.
    ```sql
    SELECT * FROM EMP;
    SELECT * FROM EMP, DEPT;
    ```
  #memo[
    - If there is more than one table, then the resulting relation is the Cartesian Product of all of these tables.
      - This may lead to very huge result list if used without a `<condition>`!
  ]
]

#slide[
  #heading(numbering: none)[Condition]
  - The `<condition>` is a boolean expression that identifies the tuples to be retrieved by the query.
    ```sql
    SELECT * FROM EMP WHERE _ID = 100;
    SELECT * FROM EMP WHERE NAME is not null;
    ```
  #info[
    The `WHERE`-clause is *optional*:
    - If left out #sym.arrow retrieves all tuples
    - If there is two or more relations in the `<table list>` #sym.arrow SQL selects the Cartesian Product
  ]
]

#slide[
  #heading(numbering: none)[WHERE: Logic Basics]
  - The `WHERE`-clause allows you to compare two expressions
    - Comparison is done using: `<`, `>`, `<=`, `>=`, `=`, `<>`
    - Both literals and columns are allowed
    ```sql
    SELECT * FROM USERS WHERE age >= 18;
    SELECT * FROM USERS WHERE NAME <> 'Miller';
    ```
    - Checking for `NULL`: `IS (NOT) NULL`
    - Logical Operators like `AND`, `OR` and `NOT` can add more nuance to the `WHERE`-clause.
    ```sql
    SELECT * FROM USERS WHERE age >= 18 AND NAME <> 'Miller';
    ```
]

#slide[
  #heading(numbering: none)[WHERE: `NULL`]
#question[
    - What is `42 < NULL`?
  ]
  - Comparisons with `NULL` are never true
  - Therefore, we need a third boolean state #sym.arrow `TRUE`, `FALSE` and `NULL`
    ```sql
    NOT NULL -> NULL

    TRUE AND NULL -> NULL
    FALSE AND NULL -> FALSE

    TRUE OR NULL -> TRUE
    FALSE OR NULL -> NULL
    ```
]

#slide[
  #heading(numbering: none)[WHERE: `NULL`]
  #figure(image("../assets/img/slides_02/20250214_boolean_table_rev01.png"))
]

== Set Operations
#slide[
  #heading(numbering: none)[Set Operations]
  - SQL allows for some of the basic set operations:
    - Union (`UNION`)
    - Set Difference (`EXCEPT`)
    - Intersection (`INTERSECT`)

  #info[
    Set Operations apply only to union-compatible relations:
    - the two relations need to have the same number of attributes
    - each corresponding set of attributes has the same domain
  ]
]

#slide[
  #heading(numbering: none)[Set Operations: Example]
  ```sql
    (SELECT DISTINCT USER_NAME FROM USERS WHERE age >= 18)
    UNION
    (SELECT DISTINCT USER_NAME FROM USERS WHERE LAST_NAME = 'Miller');
  ```
#question[
    What does the above statement do?
  ]
]


#slide[
  #heading(numbering: none)[Multiset Operations]
  - SQL allows for certain multiset operations using the keyword `ALL`.
  ```sql
    UNION ALL
    EXCEPT ALL
    INTERSECT ALL
```
]

#slide[
  #heading(numbering: none)[Assignment]
  #let left = [
    - Retrieve the names of all students with Class 2 majoring in “CS” (computer science).
    - Retrieve the names of all courses taught by Professor King in 2007 and 2008.
    - For each section taught by Professor King, retrieve the course number, semester, year, and name of students who took the section.
    - Retrieve the name and transcript of each student with Class 2 majoring in CS. A transcript includes course name, course number, credit hours, semester, year, and grade for each course completed by the student.
  ]
  #let right = [
    #figure(image("../assets/img/slides_02/20250211_cs_assignment_rev01.png"))
  ]

  #grid(
    columns: (auto, auto),
    gutter: 0.25em,
    left, right,
  )
]


= The `JOIN` statement
== Joining tables
#slide[
  #heading(numbering: none)[What is joining two tables?]
  - More often than not, the magic of SQL happens when you join two tables together.
  - This is done using the SQL statement `JOIN`, which combines two tables either
  by building the cartesian product or by connecting them based on certain criteria.
  - There are multiple types of joins available, which we will explore in the following slides.
#memo[
    It can be difficult to wrap your head around, how different tables will end up looking after a join:
    1. Don't fret, this is a difficult subject!
    2. It is often very useful to try different types of joins and to look at the entire result of the unfiltered query.
  ]
]

#slide[
  #heading(numbering: none)[Overview]
  #figure(image("../assets/img/slides_02/20250213_join_overview_rev01.png", height: 90%))
]

#slide[
  #heading(numbering: none)[`(INNER) JOIN`]
  - The simplest form of joining two tables is the `INNER JOIN`.
  - Only rows that match the condition defined in the join are returned.
  ```sql
    SELECT *
    FROM EMP e
    INNER JOIN DEPARTMENT d ON e.DEPARTMENT_ID = d._ID;
  ```
  #memo[
    While you also use just a `JOIN` and also just a comma to also execute an inner join, I ask you to always write `INNER JOIN` as it is by far easier to read what you are actually doing.
  ]
]

#slide[
  #let left = [
    #heading(numbering: none)[`LEFT (OUTER) JOIN`]
    - In practice, this is one of the most used join types. This join type will retain all rows of the left (main) table, while appending the rows of the right to that.
    - If a row on the left table cannot be matched to a row in the right table, then the values of the right table will be left empty with the columns still attached.
    ```sql
    SELECT * FROM CUSTOMERS c
    LEFT JOIN BOOKS b ON c._ID = b.BORROWER_ID;
    ```
    #info[
      - You will also find the name `LEFT OUTER JOIN`, but I'll keep using `LEFT JOIN`.
    ]
  ]
  #let right = figure(image("../assets/img/slides_02/2025_01_21_book_cust_rev01.png"))
  #grid(
    columns: (70%, 30%),
    gutter: 0.25em,
    left, right,
  )
]

#slide[
  #let left = [
    #heading(numbering: none)[`RIGHT (OUTER) JOIN`]
    - This join type does the same as the `LEFT JOIN` but for the right-hand table instead.
    ```sql
    SELECT * FROM CUSTOMERS c
    RIGHT JOIN BOOKS b ON c._ID = b.BORROWER_ID;
    ```

    #info[
      You will, similarly to the previous example, find the term `RIGHT OUTER JOIN`.
    ]
  ]
  #let right = figure(image("../assets/img/slides_02/2025_01_21_book_cust_rev01.png"))
  #grid(
    columns: (70%, 30%),
    gutter: 0.25em,
    left, right,
  )
]

#slide[
  #let left = [
    #heading(numbering: none)[`FULL (OUTER) JOIN`]
    - This join type combines the `LEFT JOIN` and `RIGHT JOIN` and selects all records from both tables, even if there are rows that do not match.
    ```sql
    SELECT * FROM CUSTOMERS c
    FULL JOIN BOOKS b ON c._ID = b.BORROWER_ID;
    ```
    #info[
      You can also achieve the same behaviour by using `UNION` on two queries, one with a `LEFT JOIN` and the other with a `RIGHT JOIN`.
      ```sql
      SELECT * FROM CUSTOMERS c
      LEFT JOIN BOOKS b ON c._ID = b.BORROWER_ID;
      UNION
      SELECT * FROM CUSTOMERS c
      RIGHT JOIN BOOKS b ON c._ID = b.BORROWER_ID;
      ```
    ]
  ]
  #let right = figure(image("../assets/img/slides_02/2025_01_21_book_cust_rev01.png"))
  #grid(
    columns: (70%, 30%),
    gutter: 0.25em,
    left, right,
  )
]

#slide[
  #heading(numbering: none)[`CROSS JOIN`]
  - Using `CROSS JOIN` allows the developer to build the Cartesian Product of the two tables, so that each column is matched to each column of the right-hand table once.
  ```sql
    SELECT * FROM CUSTOMERS c
    CROSS JOIN BOOKS b;
  ```
  #info[
    In this example, this does not make a lot of sense, but in certain cases this can be a life-saver!
  ]
]

== Why use `JOIN`?
#slide[
  #heading(numbering: none)[Using `JOIN` to combine tables]
  - The power of relational database comes from its ability to connect different tables using well-defined connections
  - Any column can be used to combine tables, but there are also `FOREIGN KEYS` that allow these connections to be more complex.
  - This helps normalizing databases and to remove duplicate data sets.
  #info[
    We'll look at these concepts more in-depth in the one of the next lectures, so stay tuned for that!
  ]
]

= SQL: Advanced features
== SELECT without a table
#slide[
  - Sometimes, you might want to select data, such as the current date, without accessing a table.
  - In PostgreSQL you can just write:
  ```sql
  SELECT NOW();
  ```
  ```
  OUTPUT: 2023-04-15 13:56:51.120277+02
  ```
  #memo[
    - In some other flavours, there is a dummy table called `dual`. They serve the same purpose!
  ]
]

== WHERE clause
#slide[
  #info[
    - We discussed the `WHERE`-clause earlier:
      - It contains logical operators to filter the query.
      - The `WHERE`-clause is optional.
  ]
  #heading(numbering: none)[Querying `NULL` values]
  ```sql
  WHERE a IS NULL;
  WHERE a IS NOT NULL;
  ```
]

#slide[
  #heading(numbering: none)[Using `BETWEEN`]
  #example[
    Let's say you want to query for all your employees between the ages of 18 and 21.
  ]
  ```sql
  WHERE age >= 18 AND age <= 21;
  WHERE age BETWEEN 18 AND 21;
  ```

  #heading(numbering: none)[Using `IN`]
  #example[
    Let's say you want to check if the person entering data into the form is one of three special employees.
  ]
  ```sql
  WHERE _ID = 102 OR _ID = 304 OR _ID = 201;
  WHERE _ID IN (102, 304, 201);
  ```
  - The `IN`-clause checks whether a value is part of a set.
  - Improves the readability of the code!
]

#slide[
  #heading(numbering: none)[String Patterns using `LIKE`]
  #example[
    Imagine you only save the full name of each employee. Now you want to query of all employees, whose last name is Smith.
  ]
  ```sql
  WHERE NAME LIKE '%SMITH';
  ```
  - `%`: Replaces an arbitrary number of letters and numbers
  - `_`: Replaces a single character
  - `\`: Escapes one of the wildcard characters (`AB\_CD` #sym.arrow.r `AB_CD`)

  ```sql `
  'abc' LIKE 'abc' -> TRUE
  'abc' LIKE 'a%' -> TRUE
  'abc' LIKE '_b_' -> TRUE
  'abc' LIKE 'b' -> FALSE
  ```

]

#slide[
  #heading(numbering: none)[Comparison with `DATE`]
  #example[
    Let's say you want to congratulate all employees who have started in the founding year of your company. Let's take 2018 as an example.
  ]
  ```sql
  WHERE JOIN_DATE >= '2018-01-01' AND JOIN_DATE <= '2018-12-31';
  WHERE JOIN_DATE BETWEEN '2018-01-01' AND '2018-12-31';
  WHERE JOIN_DATE::TEXT LIKE '2018%';
  ```
  #memo[
    The example of date comparisons are DBMS dependant. Example for Oracle:
    ```sql
    WHERE JOIN_DATE >= TO_DATE('2018-01-01', 'yyyy.mm.dd') AND JOIN_DATE <= TO_DATE('2018-12-31', 'yyyy.mm.dd')
    ```
  ]
]

== Sorting query results
#slide[
  #heading(numbering: none)[Using `ORDER BY`]
  - The results of queries are sets, meaning they have no order applied to them
  - Using `ORDER BY`, you can impose an order on the result of a query
  - You can order by more than one column.
  ```sql
  SELECT
    NAME
  FROM
    EMP
  ORDER BY
    _ID;
  ```
  #memo[
    You can change the direction of the sort by using `ASC` (ascending) and `DESC` (descending).
    ```sql
    ORDER BY _ID ASC;
    ORDER BY _ID DESC;
    ```
  ]
]

== Aggregate Functions
#slide[
  #heading(numbering: none)[Using Aggregate Functions]
  - Using aggregate functions, you can analyze your data and create summaries of the shape of your data.
  - For instance, you can count the number of rows that match your condition or simply return the maximum value of a set of values.
  ```sql
  SELECT
    COUNT(NAME)
  FROM
    EMP
  WHERE
    NAME LIKE '%SMITH'
  ORDER BY
    _ID;
  ```
  #memo[
    You can change the direction of the sort by using `ASC` (ascending) and `DESC` (descending).
    ```sql
    ORDER BY _ID ASC;
    ORDER BY _ID DESC;
    ```
  ]
]

#slide[
  #heading(numbering: none)[Using Aggregate Functions]
  ```sql
  SELECT COUNT(∗) FROM Book; -> 4
  SELECT COUNT(PNr) FROM Book; -> 3
  SELECT COUNT(DISTINCT PNr) FROM Book; -> 2
  SELECT MIN(Price), MAX(Price) FROM Book; -> 9.99
  SELECT SUM(Price) FROM Book; -> 64.87
  SELECT AVG(Price) FROM Book; -> 16.22
  ```
]
//TODO: Add additional examples as per template slide 06
== GROUP BY & HAVING
#slide[
  #heading(numbering: none)[Using `GROUP BY`]
  - Grouping is used to create subgroups of tuples before summarization
    - partition the relation into nonoverlapping subsets (or groups) of tuples
    - Using a grouping attribute
    - Grouping attribute should appear in the SELECT clause
    - If NULLs exist in the grouping attribute, then a separate group is created for all tuples with a NULL value
    #example[
      For each department, we want to retrieve the department number, the number of employees in the department, and their average salary.
    ]
    ```sql
    SELECT
      DEPARTMENT, COUNT(*), AVG(SALARY)
    FROM EMP
    GROUP BY DEPARTMENT;
    ```
]

#slide[
  #heading(numbering: none)[Using `HAVING`]
  - `HAVING` provides a condition on the summary information regarding the group of tuples associated with each value of the grouping attributes
  - Only the groups that satisfy the condition are retrieved in the result of the query
  - `HAVING` clause appears in conjunction with `GROUP BY` clause
  #info[
    - Selection conditions in `WHERE` clause limit the tuples
    - `HAVING` clause serves to choose whole groups
  ]
]

#slide[
  #heading(numbering: none)[Using `HAVING`]
  - Imagine you have a whole lot of employees in your company and you want to find the name and amount of employees per department, but only take into account those department that have 10 or more employees.
  ```sql
  SELECT NAME, count(*) as emp_amount
  FROM EMP
  GROUP BY DEPARTMENT
  HAVING count(*) >= 10;
  ```
]

#slide[
  #heading(numbering: none)[Using `HAVING`]
  - Let's say you wanna retrieve all projects in your company that have more than 2 employees working on it. The PROJECTS table contains all projects and the EMP_PROJECT_RESPONSIBILITY matches employees to projects.
  ```sql
  SELECT p.PROJECT_NUM, p.PROJECT_NAME, count(*) as emp_amount
  FROM PROJECTS p
  LEFT JOIN EMP_PROJECT_RESPONSIBILITY e ON e.project_id = p._id
  GROUP BY p.PROJECT_NUM, p.PROJECT_NAME
  HAVING count(*) > 2;
  ```
]

#slide[
  #heading(numbering: none)[Using `HAVING`]
  #info[
    - When using groups, only two types of things are allowed in a `SELECT`-clause:
      - Aggregate Functions
      - Columns contained in a `GROUP BY`-statement
    - And while `HAVING` allows aggregate functions, `WHERE` does not.
  ]
]

== Special Features
#slide[
  #heading(numbering: none)[Special Features not covered]
  - `ANY` and `SOME`
  - `ALL` in comparisons of a `WHERE`-clause
  - `EXISTS` in a `WHERE`-clause
  - `UNIQUE` in a `WHERE`-clause
  - Nested queries
]

#slide[
  #heading(numbering: none)[Assignment]
  - How many students are studying CS?
  - List all course names and how often they have been taught.
  - For each section taught by Professor Anderson, retrieve the course number, semester, year and number of students who took the section.
]

== Query: Summary
#slide[
  ```sql
    SELECT <attribute and function list>
    FROM <table list>
  [ WHERE <condition> ]
  [ GROUP BY <grouping attribute(s)> ]
  [ HAVING <group condition> ]
  [ ORDER BY <attribute list> ];
  ```
]

== Query: Execution Order
#slide[
  - Order of Execution:
    - `FROM` (cartesian product, `JOIN`)
    - `WHERE` (selection)
    - `GROUP BY` (grouping)
    - `HAVING` (condition on group)
    - `ORDER BY` (sorting)
    - `SELECT` (projection)
  #info[
    - The optimizer might build a different execution order if that would speed up the query.
  ]
]

= License Notice

== Attribution

- This work is shared under the CC BY-NC-SA 4.0 License and the respective Public
  License.
- #link("https://creativecommons.org/licenses/by-nc-sa/4.0/")
- This work is based off of the work by Prof. Dr. Ulrike Herster.
- Some of the images and texts, as well as the layout were changed.
- The base material was supplied in private, therefore the link to the source
  cannot be shared with the audience.
