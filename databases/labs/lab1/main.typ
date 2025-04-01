#import "@preview/grape-suite:2.0.0": exercise, german-dates
#import "@preview/gentle-clues:1.2.0": *

#set text(lang: "en")

#import "@preview/codly:1.0.0": *
#show: codly-init.with()

#let is_solution = true

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
      color: rgb("#7c3aed"),
    ),
  ),
)

#show: exercise.project.with(
  title: "Databases Lab 01",
  university: [HAW Hamburg],
  institute: [TI IE4],
  seminar: [DBL],
  abstract: [
    This is the first lab of Databases. This lab focuses on improving your skills in
    dealing with SQL queries. There are tasks for both DDL and DML statements. If you have questions or need any
    support, help each other, ask your tutor or use the forum in our moodle room.
  ],
  show-outline: true,
  author: "Emily Antosch & Furkan Yildirim & Julian Moldenhauer",
  show-solutions: false,
)

= Assignment 1: SQL-statements for the Student Information System
A schema essentially is a collection of tables and their relations to each other. Schemas are commonly implemented by SQL.
Consider the following schema for the Student Information System:

- *STUDENT*(studentID, fistName, lastName, dob, programID(FK))
- *PROGRAM*(programID, name, requiredCPs)
- *COURSE*(courseID, name, description, creditPoints, programID(FK))
- *ATTEMPTS*(studentID(FK),courseID(FK), year, term, grade)
- *PREREQUISITE*(advancedCourseID(FK), prerequisiteCourseID (FK))

1. Write SQL-statements that create the corresponding tables. Come up with
  reasonable constraints and datatypes for the fields of the tables.
#if is_solution [
  #let program = [```sql
    CREATE TABLE Program
      (programID INT NOT NULL,
       name VARCHAR(32) NOT NULL,
       requiredCPs INT NOT NULL,
       PRIMARY KEY (programID) );
    ```
    #v(1em)
  ]
  #let student = [```sql
    CREATE TABLE Student
      (studentID INT NOT NULL,
       firstName VARCHAR(32) NOT NULL,
       lastName  VARCHAR(32) NOT NULL,
       dob            DATE NOT NULL,
       programID INT NOT NULL,
       PRIMARY KEY (studentID),
       FOREIGN KEY (programID) REFERENCES Program(programID) );
    ```
    #v(1em)
  ]
  #let course = [```sql
    CREATE TABLE Course
      (CourseID INT NOT NULL,
       name VARCHAR(32) NOT NULL,
       description VARCHAR(100) NOT NULL,
       creditPoints INT NOT NULL,
       programID INT NOT NULL,
       PRIMARY KEY (courseID),
       FOREIGN KEY (programID) REFERENCES Program(programID) );
    ```

    #v(1em)
  ]
  #let attempts = [```sql
      CREATE TABLE Attempts
        (studentID INT NOT NULL,
         courseID INT NOT NULL,
         year INT NOT NULL,
         term INT NOT NULL,
         grade INT NOT NULL,
        PRIMARY KEY (studentID, courseID, year, term),
        FOREIGN KEY (studentID) REFERENCES Student(studentID),
        FOREIGN KEY (courseID) REFERENCES Course(courseID) );
    ```
    #v(1em)
  ]
  #let prerequisite = [```sql
    CREATE TABLE Prerequisite
      (advancedCourse INT NOT NULL,
       prerequisiteCourse INT NOT NULL,
      PRIMARY KEY (advancedCourse, prerequisiteCourse),
      FOREIGN KEY (advancedCourse) REFERENCES Course(courseID),
      FOREIGN KEY (prerequisiteCourse) REFERENCES Course(courseID) );
    ```
  ]
  #conclusion(title: [Solution])[
    #grid(columns: auto, gutter: 0.25em, program, student, course, attempts, prerequisite)
  ]
]
2. Write SQL-queries that insert example data into your created tables. Make sure
  that each table contains at least 2 rows of data. Here are some sample data.
#let table_student = [
  #figure(
    table(
      columns: (auto, auto, auto, auto, auto),
      inset: 0.5em,
      [*studentID*], [*firstName*], [*lastName*], [*dob*], [*programID*],
      [123456], [John], [Wayne], [11.05.1998], [1],
      [234567], [Anna], [Meyer], [13.02.1999], [1],
    ),
    caption: [Table *STUDENT*],
  )
]

#let table_program = [
  #figure(
    table(
      columns: (auto, auto, auto),
      inset: 0.5em,
      [*programID*], [*Name*], [*requiredCPs*],
      [1], [Information Engineering], [120],
      [2], [Renewable Energies], [110],
    ),
    caption: [Table *PROGRAM*],
  )
]


#let table_course = [
  #figure(
    table(
      columns: (auto, auto, auto, auto, auto),
      inset: 0.5em,
      [*courseID*], [*Name*], [*Description*], [*creditPoints*], [*programID*],
      [4], [MA1], [Mathematics 1], [8], [1],
      [9], [MA2], [Mathematics 2], [8], [1],
      [13], [SS1], [Signals and Systems 1], [6], [1],
      [15], [DB], [Databases], [6], [1],
    ),
    caption: [Table *COURSE*],
  )
]

#let table_prerequisite = [
  #figure(
    table(
      columns: (auto, auto),
      inset: 0.5em,
      [*advancedCourseID*], [*prerequisiteCourseID*],
      [9], [4],
      [13], [9],
      [13], [4],
    ),
    caption: [Table *PREREQUISITE*],
  )
]

#let table_attempts = [
  #figure(
    table(
      columns: (auto, auto, auto, auto, auto),
      inset: 0.5em,
      [*studentID*], [*courseID*], [*Year*], [*Term*], [*grade*],
      [123456], [4], [2021], [1], [7],
      [234567], [9], [2021], [2], [9],
      [234567], [13], [2022], [1], [3],
      [234567], [13], [2022], [2], [6],
    ),
    caption: [Table *ATTEMPTS*],
  )
]
//#grid(columns: (auto, auto), gutter: 0.25em, table_student, table_program, table_course, table_attempts, table_prerequisite)
#table_program
#table_student
#table_course
#table_attempts
#table_prerequisite

#if is_solution [
  #conclusion(title: [Solution])[
    ```sql
    INSERT INTO Program
    VALUES ( 1, 'Information Engineering',120);

    INSERT INTO Program
    VALUES ( 2, 'Renewable Energies',110);
    ```
    ```sql
    INSERT INTO Student
    VALUES ( 123456, 'John', 'Wayne', '1998-05-11',1);

    INSERT INTO Student
    VALUES ( 234567, 'Anna', 'Meyer', '1999-02-13',1);
    ```

    ```sql
    INSERT INTO Course
    VALUES ( 4, 'MA1', 'Mathematics 1', 8,1);

    INSERT INTO Course
    VALUES ( 9, 'MA2', 'Mathematics 2', 8,1);

    INSERT INTO Course
    VALUES ( 13, 'SS1', 'Signals and Systems 1', 6,1);

    INSERT INTO Course
    VALUES ( 15, 'DB', 'Databases', 6,1);
    ```


    ```sql
    INSERT INTO Prerequisite
    VALUES ( 9,4);

    INSERT INTO Prerequisite
    VALUES ( 13,4);

    INSERT INTO Prerequisite
    VALUES ( 13,9);
    ```
  ]
  #conclusion(title: [Solution])[
    ```sql
    INSERT INTO Attempts
    VALUES (123456, 4, 2021, 1, 7);

    INSERT INTO Attempts
    VALUES (123456, 9, 2021, 2, 9);

    INSERT INTO Attempts
    VALUES (123456, 13, 2022, 1, 3);

    INSERT INTO Attempts
    VALUES (123456, 13, 2022, 2, 6);
    ```
  ]
]

3. Write a SQL-query for the created database that returns all students (first name
  and last name) that study the program “Information Engineering”.

#if is_solution [
  #conclusion(title: [Solution])[
    ```sql
    SELECT s.firstname, s.lastname
    FROM student s, program p
    WHERE p.name = 'Information Engineering' and p.programID = s.programID;
    ```
  ]
]


4. Write a SQL-query that returns the name of all courses that have prerequisite courses.

#if is_solution [
  #conclusion(title: [Solution])[
    ```sql
    SELECT DISTINCT c.name
    FROM course c, prerequisite pre
    WHERE c.courseID = pre.advancedCourse;
    ```
  ]
]

5. Write a SQL-query that returns the sum of all credit points successfully
  achieved by student “John Wayne”. Keep in mind that the credit points only count
  when the student has an attempt with a grade of 5 or more points.

#if is_solution [
  #conclusion(title: [Solution])[
    ```sql
    SELECT SUM(c.creditPoints) AS SUM
    FROM student s, course c, attempts a
    WHERE s.firstname = 'John' AND s.lastname = 'Wayne' AND a.studentID = s.studentID
    AND a.courseID = c.courseID AND a.grade > 4;
    ```
  ]
]

6. A student needs to be removed from the database. Write SQL-statements to remove
  the student with the name “John Wayne” from the database.

#if is_solution [
  #conclusion(title: [Solution])[
    ```sql
    DELETE FROM attempts a
       WHERE a.studentID IN (
          SELECT s.studentID FROM Student s
          WHERE s.firstName = 'John'
          AND s.lastName = 'Wayne');

    DELETE FROM Student
       WHERE firstName = 'John'
       AND lastName = 'Wayne';
    ```
  ]
]

#v(80%)
= Assignment 2: SQL-statements for a Shipping company
A shipping company wants to use a SQL-database to keep track of its ships and
employed sailors based on the following relation schema:
- *HARBOR* (harborID, location, establishedIn)
- *SAILOR* (sailorID, lastName, dob, trainedAt(FK -> harborID))
- *SHIP* (shipID, name, grossWeight, launchDate, baseHarbor(FK -> harborID))
- *HIRE* (sailor(FK -> sailorID), ship(FK -> shipID), startOfService,
  annualSalary)

You can use the provided SQL-script for creating the tables and inserting some
data in the tables.
1. Create a SQL-query that returns the dob (date of birth) of sailors in descending order that were hired on August 3rd, 2012.

#if is_solution [
  #conclusion(title: [Solution])[
    ```sql
    SELECT lastname, dob
    from sailor s, hire h
    where s.sailorID = h.sailorID AND
    h.startOfService = '2012-08-03'
    ORDER BY dob DESC;
    ```
  ]
]

2. Create a SQL-query that returns all information of sailors that were hired between July 3rd, 2011, and September 3rd, 2012, and whose last name starts with a ‘J’.
#if is_solution [
  #conclusion(title: [Solution])[
    ```sql
    SELECT *
    from sailor s, hire h
    where s.sailorID = h.sailorID AND
    h.startOfService BETWEEN '2011-07-03' AND '2012-09-03'
    AND lastname like 'J%';
    ```
  ]
]
3. Create a SQL-query that returns for each ship the sum of the annual salary of every sailor who is hired for that ship.
#if is_solution [
  #conclusion(title: [Solution])[
    ```sql
    SELECT * from hire;

    SELECT s.name, SUM(h.annualSalary)
    FROM ship s, hire h
    WHERE s.shipID = h.shipID
    GROUP BY s.shipID;
    ```
  ]
]
4. Create a SQL-query that returns the location of all harbors that are not base harbor to any ship in the database.
#if is_solution [
  #conclusion(title: [Solution])[
    ```sql
    Select h.location
    FROM Harbour h
    where h.harbourID NOT IN (SELECT s.baseharbour from Ship s);
    ```
  ]
]
5. Create a SQL-query that returns the shipId, ship name and the number of sailors who are hired on the ship and earn maximum 42.000\$.
#if is_solution [
  #conclusion(title: [Solution])[
    ```sql
    SELECT * from hire;

    select h.shipid, s.name, COUNT(h.sailorid)
    FROM ship s, hire h
    WHERE h.shipid = s.shipid
    GROUP BY h.shipid
    HAVING MAX(h.annualSalary) < 42000;
    ```
  ]
]
6. Describe in your own words the result of the following query:

```sql
SELECT DISTINCT h1.location
FROM SHIP s1, SHIP s2, HARBOR h1, HARBOR h2
WHERE s1.baseHarbor = h1.harborID
AND s2.baseHarbor = h2.harborID
AND s1.launchDate = s2.launchDate
AND h1.location = h2.location
AND h1.harborID != h2.harborID;
```
#if is_solution [
  #conclusion(title: [Solution])[
    A correct answer would include:
    - This query outputs the distinct (or deduplicated) locations from the harbours
    - Four tables, with all ships and harbours are selected twice each.
    - Only harbours are selected that are home to a ship.
    - Only ships that have the same launch date are selected.
    - Only harbours that are in the same location, but are different harbours are selected.

    - The result is a list of locations that have two distinct harbours, that are the home harbour of two different ship, with those two different ships that having the same launch date.
  ]
]
#v(80%)
= Assignment 3: SQL-statements for the COMPANY example from Elmasri also used in the lecture
Let’s have a look on the COPMPANY example from the book „Fundamentals of Database Systems“ from Elmasri which is also used in the lecture. Given is the database schema in Figure 1 and the database state in Figure 2.

#figure(image("../../assets/img/labs/2024_11_18_lab3_employee_table_columns_rev01.png"))

#figure(image("../../assets/img/labs/2024_11_18_lab3_employee_tables_rev01.png"))

Write SQL statement for the following tasks:
1. Retrieve the names of all employees in department 5 who work more than 10 hours per week on a project.
#if is_solution [
  #conclusion(title: [Solution])[
    ```sql
      SELECT first_name, last_name
      FROM employee e
      LEFT JOIN works_on wo ON e.ssn = wo.essn
      WHERE e.dno = 5
      AND wo.hours >= 10;
    ```
  ]]
2. List the names of all employees who have a dependent with the same first name as themselves.
#if is_solution [
  #conclusion(title: [Solution])[
    ```sql
      SELECT first_name, last_name
      FROM employee e
      LEFT JOIN DEPENDENT d ON e.ssn = d.essn
      WHERE d.dependent_name = e.first_name;
    ```
  ]
]
3. Find the names of all employees who are directly supervised by ‘Franklin Wong’.
#if is_solution [
  #conclusion(title: [Solution])[
    ```sql
      SELECT first_name, last_name
      FROM employee e
      WHERE super_ssn = 333445555;
    ```
  ]
]
4. Suppose that the EMPLOYEE table’s constraint EMPSUPERFK as specified below is changed to read as follows:
```sql
CONSTRAINT EMPSUPERFK  FOREIGN KEY (Super_ssn) REFERENCES EMPLOYEE(Ssn)  ON DELETE CASCADE ON UPDATE CASCADE;
```
Answer the following questions:
- What happens when the following command is run on the database state?
```sql
DELETE FROM EMPLOYEE WHERE Lname = ‘Borg’ ;
```
#if is_solution [
  #conclusion(title: [Solution])[
    The entire database entries of employee would get deleted, since Borg does not have a supervisor and everyone else does (provided there is no other constraint to the table).
    However, since there is a foreign key constraint on the department table that references employee, the operation will return an error.
  ]
]
- Is it better to ```sql CASCADE``` or ```sql SET NULL``` in case of ```sql EMPSUPERFK``` constraint ```sql ON DELETE```?
#if is_solution [
  #conclusion(title: [ Solution ])[
    In this case, it would be better to ```sql SET NULL```, since when only the head of the company changes, the res of the employees will probably still remain.
  ]
]

5. For each project, list the project name and the total hours per week (by all
  employees) spent on that project.
#if is_solution [
  #conclusion(title: [Solution])[
    ```sql
      SELECT
        pname,
        SUM(hours)
      FROM project p
      LEFT JOIN works_on wo ON wo.pno = p.pnumber
      GROUP BY pname;
    ```
  ]
]
6. Retrieve the average salary of all female employees.
#if is_solution [
  #conclusion(title: [Solution])[
    ```sql
      SELECT
        AVG(Salary)
      FROM employee e
      WHERE SEX = 'F'
      GROUP BY SEX;
    ```
  ]
]
7. Write SQL statements to create a table EMPLOYEE_BACKUP to back up the EMPLOYEE
  table shown.
#if is_solution [
  #conclusion(title: [Solution])[
    ```sql
      CREATE TABLE employee_backup SELECT * FROM employee;
    ```
  ]
]
8. For each department, whose average employee salary is more than \$30,000,
  retrieve the department name and the number of employees working for that
  department.
#if is_solution [
  #conclusion(title: [Solution])[
    ```sql
      SELECT d.dname, d.dno, COUNT(e.lname), AVG(salary)
      FROM department d
      LEFT JOIN employee e ON e.dno = d.dnumber
      GROUP BY dno, dname
      HAVING AVG(salary) > 30000;
    ```
  ]
]

#v(80%)
= Assignment 4: Relational Algebra vs. SQL query for a Cinema Database
The following excerpt from a database schema models a database about a cinema.
The following assignments are to be answered in the form of an SQL query.
- *Movies* (FilmID (PK), Title, Director, Release Year, Genre)
- *MovieHasActor* (MovieHasActorID (PK), FilmID (FK), ActorID (FK), RoleName)
- *Actors* (ActorID (PK), First Name, Last Name, Birthdate)
- *Screenings* (ScreeningID (PK), FilmID (FK), Cinema Hall, Date, Time)
- *Reservations* (ReservationID (PK), ScreeningID (FK), Seat, Customer Name,
  Booking Date)
1. Display a list of actors (first name, last name) and their roles in a specific
  movie (e.g., "FilmXYZ").
#if is_solution [
  #conclusion(title: [Solution])[
    ```sql
    SELECT a.first_name, a.last_name, ma.role_name, m.title
    FROM actors a
    LEFT JOIN movie_has_actor ma ON ma.actor_id = a.actor_id
    LEFT JOIN movies m ON m.film_id = ma.film_id
    WHERE m.title = 'FilmXYZ';
    ```
  ]
]
2. Find all movies that will be shown in the screenings (ScreeningID) for the movie theater "HallA" on 2024-01-30 at 19:00.
#if is_solution [
  #conclusion(title: [Solution])[
    ```sql
    SELECT ScreeningID
    FROM Screenings s
    WHERE cinema_hall = 'HallA'
    AND date = '2024-01-30'
    AND time = '19:00';
    ```
  ]
]
3. Create a table with information about all reservations made by customers with the last name "Schmidt", including the movie title and seat number.
#if is_solution [
  #conclusion(title: [Solution])[
    ```sql
    CREATE TABLE CUSTOMER_SCHMIDT
    SELECT
      r.reservation_id,
      r.seat,
      r.customer_name,
      r.booking_date,
      m.title
    FROM RESERVATIONS r
    LEFT JOIN screenings s ON s.screening_id = r.screening_id
    LEFT JOIN movies m ON m.film_id = s.film_id
    WHERE r.customer_name like '%Schmidt';
    ```
  ]
]

