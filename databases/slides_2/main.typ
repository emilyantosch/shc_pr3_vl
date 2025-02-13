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

= DML: Data Manipulation Language

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
  #heading(numbering: none)[`LEFT JOIN`]
  - In practice, this is one of the most used join types. 
  #memo[
    While you also use just a `JOIN` and also just a comma to also execute an inner join, I ask you to always write `INNER JOIN` as it is by far easier to read what you are actually doing.
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
