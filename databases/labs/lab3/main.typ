#import "@preview/grape-suite:1.0.0": exercise, german-dates

#set text(lang: "en")

#import "@preview/codly:1.0.0": *
#show: codly-init.with()

#codly(
  languages: (
    sql: (
      name: text(font: "JetBrainsMono NFM", " SQL", weight: "bold"), icon: text(font: "JetBrainsMono NFM", "\u{e76e}", weight: "bold"), color: rgb("#2563eb"),
    ), java: (
      name: text(font: "JetBrainsMono NFM", " Java", weight: "bold"), icon: text(font: "JetBrainsMono NFM", "\u{e738}", weight: "bold"), color: rgb("#CE412B"),
    ), c: (
      name: text(font: "JetBrainsMono NFM", " C", weight: "bold"), icon: text(font: "JetBrainsMono NFM", "\u{e61e}", weight: "bold"), color: rgb("#7c3aed"),
    ),
  ),
)

#show: exercise.project.with(
  title: "Databases Lab 03", university: [HAW Hamburg], institute: [TI IE4], seminar: [DBL], abstract: [
    This is the third lab of Databases. This lab focuses on improving your skills in
    dealing with SQL queries. There are tasks for both DDL and DML statements. It is
    recommended that you familiarize yourself with the assignments to allow a more
    effective participation in Laboratory 3. If you have questions or need any
    support, help each other, or use the forum in our moodle room.
  ], show-outline: true, author: "Emily Antosch", show-solutions: false,
)

= Assignment 1: SQL-statements for the Student Information System
Consider the following relational schema for the Student Information System
(analogous to the Assignments from Lab 1):

- *STUDENT*(studentID, fistName, lastName, dob, programID(FK))
- *PROGRAM*(programID, name, requiredCPs)
- *COURSE*(courseID, name, description, creditPoints, programID(FK))
- *ATTEMPTS*(studentID(FK),courseID(FK), year, term, grade)
- *PREREQUISITE*(advancedCourseID(FK), prerequisiteCourseID (FK))

1. Write SQL-statements that create the corresponding tables. Come up with
  reasonable constraints and datatypes for the fields of the tables.
2. Write SQL-queries that insert example data into your created tables. Make sure
  that each table contains at least 2 rows of data. Here are some sample data.
#figure(
  table(
    columns: (auto, auto, auto, auto, auto), inset: 0.5em, [*studentID*], [*firstName*], [*lastName*], [*dob*], [*programID*], [123456], [John], [Wayne], [11.05.1998], [1], [234567], [Anna], [Meyer], [13.02.1999], [1],
  ), caption: [Table *STUDENT*],
)

#figure(
  table(
    columns: (auto, auto, auto, auto, auto), inset: 0.5em, [*studentID*], [*firstName*], [*lastName*], [*dob*], [*programID*], [123456], [John], [Wayne], [11.05.1998], [1], [234567], [Anna], [Meyer], [13.02.1999], [1],
  ), caption: [Table *STUDENT*],
)

#figure(
  table(
    columns: (auto, auto, auto), inset: 0.5em, [*programID*], [*Name*], [*requiredCPs*], [1], [Information Engineering], [120], [2], [Renewable Energies], [110],
  ), caption: [Table *PROGRAM*],
)

#figure(
  table(
    columns: (auto, auto, auto, auto, auto), inset: 0.5em, [*courseID*], [*Name*], [*Description*], [*creditPoints*], [*programID*], [4], [MA1], [Mathematics 1], [8], [1], [9], [MA2], [Mathematics 2], [8], [1], [13], [SS1], [Signals and Systems 1], [6], [1], [15], [DB], [Databases], [6], [1],
  ), caption: [Table *COURSE*],
)

#figure(
  table(
    columns: (auto, auto), inset: 0.5em, [*advancedCourseID*], [*prerequisiteCourseID*], [9], [4], [13], [9], [13], [4],
  ), caption: [Table *PREREQUISITE*],
)

#figure(
  table(
    columns: (auto, auto, auto, auto, auto), inset: 0.5em, [*studentID*], [*courseID*], [*Year*], [*Term*], [*grade*], [123456], [4], [2021], [1], [7], [234567], [9], [2021], [2], [9], [234567], [13], [2022], [1], [3], [234567], [13], [2022], [2], [6],
  ), caption: [Table *ATTEMPTS*],
)

3. Write a SQL-query for the created database that returns all students (first name
  + last name) that study the program “Information Engineering”.
4. Write a SQL-query that returns the name of all courses that have prerequisite
  courses.
5. Write a SQL-query that returns the sum of all credit points successfully
  achieved by student “John Wayne”. Keep in mind that the credit points only count
  when the student has an attempt with a grade of 5 or more points.
6. A student needs to be removed from the database. Write SQL-statements to remove
  the student with the name “John Wayne” from the database.

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
1. Create a SQL-query that returns the dob (date of birth) of sailors in descending
  order that were hired on August 3rd, 2012.
2. Create a SQL-query that returns all information of sailors that were hired
  between July 3rd, 2011, and September 3rd, 2012, and whose last name starts with
  a ‘J’.
3. Create a SQL-query that returns for each ship the sum of the annual salary of
  every sailor who is hired for that ship.
4. Create a SQL-query that returns the location of all harbors that are not base
  harbor to any ship in the database.
5. Create a SQL-query that returns the shipId, ship name and the number of sailors
  who are hired on the ship and earn maximum 42.000\$.
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

= Assignment 3: SQL-statements for the COMPANY example from Elmasri also used in the lecture
Let’s have a look on the COPMPANY example from the book „Fundamentals of
Database Systems“ from Elmasri which is also used in the lecture. Given is the
database schema in Figure 1 and the database state in Figure 2.

#figure(
  image("../../assets/img/2024_11_18_lab3_employee_table_columns_rev01.png"),
)

#figure(image("../../assets/img/2024_11_18_lab3_employee_tables_rev01.png"))

Write SQL statement for the following tasks:
1. Retrieve the names of all employees in department 5 who work more than 10 hours
  per week on a project.
2. List the names of all employees who have a dependent with the same first name as
  themselves.
3. Find the names of all employees who are directly supervised by ‘Franklin Wong’.
4. Suppose that the EMPLOYEE table’s constraint EMPSUPERFK as specified in Figure 3
  on the next page is changed to read as follows:
```sql
CONSTRAINT EMPSUPERFK  FOREIGN KEY (Super_ssn) REFERENCES EMPLOYEE(Ssn)  ON DELETE CASCADE ON UPDATE CASCADE;
```
Answer the following questions:
- What happens when the following command is run on the database state shown in
  Figure 2?
```sql
DELETE FROM EMPLOYEE WHERE Lname = ‘Borg’ ;
```
- Is it better to ```sql CASCADE``` or ```sql SET NULL``` in case of ```sql EMPSUPERFK``` constraint ```sql ON DELETE```?

#figure(image("../../assets/img/2024_11_18_lab03_database_schema_rev01.png"))

5. For each project, list the project name and the total hours per week (by all
  employees) spent on that project.
6. Retrieve the average salary of all female employees.
7. Write SQL statements to create a table EMPLOYEE_BACKUP to back up the EMPLOYEE
  table shown.
8. For each department, whose average employee salary is more than \$30,000,
  retrieve the department name and the number of employees working for that
  department.

= Assignment 4: Relational Algebra vs. SQL query for a Cinema Database
The following excerpt from a database schema models a database about a cinema.
The following assignments are to be answered in the form of relational algebra
AND additionally in the form of an SQL query.
- *Movies* (FilmID (PK), Title, Director, Release Year, Genre)
- *Actors* (ActorID (PK), First Name, Last Name, Birthdate)
- *Screenings* (ScreeningID (PK), FilmID (FK), Cinema Hall, Date, Time)
- *Reservations* (ReservationID (PK), ScreeningID (FK), Seat, Customer Name,
  Booking Date)
1. Do a projection to see a list of all movie titles and their directors.
2. Display a list of actors (first name, last name) and their roles in a specific
  movie (e.g., "FilmXYZ").
3. Find all movies that will be shown in the screenings (ScreeningID) for the movie
  theater "HallA" on 2024-01-30 at 19:00.
4. Create a table with information about all reservations made by customers with
  the last name "Schmidt", including the movie title and seat number.

= Assignment 5: Relational Algebra vs. SQL query for a Weather Database

The following excerpt from a database schema models a database about a weather
station. The following assignments are to be answered in the form of relational
algebra AND additionally in the form of an SQL query.
- *CITY* (CityID, Name, Country)
- *WEATHER_DATA* (DataID, CityID (FK), Date, Temperature, Humidity,
- *Precipitation*, WindSpeed)
1. Which cities have an average daily temperature above 25°C in August 2023?
2. Which cities experienced no precipitation on any day in July 2023?
3. On which particular day did the cities have the highest wind speed?
4. Which cities recorded the highest temperature?
5. Which cities had the lowest humidity in May 2023?

