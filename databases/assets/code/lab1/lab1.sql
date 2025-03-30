drop schema lab2022;

create schema lab2022;

use lab2022;

-- Aufgabe 1.1

CREATE TABLE Program
  (programID INT NOT NULL,
   name VARCHAR(32) NOT NULL,
   requiredCPs INT NOT NULL,
   PRIMARY KEY (programID) ); 

CREATE TABLE Student
  (studentID INT NOT NULL,
   firstName VARCHAR(32) NOT NULL,
   lastName  VARCHAR(32) NOT NULL,
   dob            DATE NOT NULL,
   programID INT NOT NULL,
   PRIMARY KEY (studentID),
   FOREIGN KEY (programID) REFERENCES Program(programID) );

CREATE TABLE Course
  (CourseID INT NOT NULL,
   name VARCHAR(32) NOT NULL,
   description VARCHAR(100) NOT NULL,
   creditPoints INT NOT NULL,
   programID INT NOT NULL,
   PRIMARY KEY (courseID),
   FOREIGN KEY (programID) REFERENCES Program(programID) );
 
CREATE TABLE Attempts
  (studentID INT NOT NULL,
   courseID INT NOT NULL,
   year INT NOT NULL,
   term INT NOT NULL,
   grade INT NOT NULL,
  PRIMARY KEY (studentID, courseID, year, term),
  FOREIGN KEY (studentID) REFERENCES Student(studentID),
  FOREIGN KEY (courseID) REFERENCES Course(courseID) );

CREATE TABLE Prerequisite
  (advancedCourse INT NOT NULL,
   prerequisiteCourse INT NOT NULL,
  PRIMARY KEY (advancedCourse, prerequisiteCourse),
  FOREIGN KEY (advancedCourse) REFERENCES Course(courseID),
  FOREIGN KEY (prerequisiteCourse) REFERENCES Course(courseID) );


-- Aufgabe 1.2

INSERT INTO Program
VALUES ( 1, 'Information Engineering',120); 

INSERT INTO Program
VALUES ( 2, 'Renewable Energies',110); 

INSERT INTO Student
VALUES ( 123456, 'John', 'Wayne', '1998-05-11',1); 

INSERT INTO Student
VALUES ( 234567, 'Anna', 'Meyer', '1999-02-13',1); 

INSERT INTO Course
VALUES ( 4, 'MA1', 'Mathematics 1', 8,1); 

INSERT INTO Course
VALUES ( 9, 'MA2', 'Mathematics 2', 8,1); 

INSERT INTO Course
VALUES ( 13, 'SS1', 'Signals and Systems 1', 6,1); 

INSERT INTO Course
VALUES ( 15, 'DB', 'Databases', 6,1); 

INSERT INTO Prerequisite
VALUES ( 9,4); 

INSERT INTO Prerequisite
VALUES ( 13,4); 

INSERT INTO Prerequisite
VALUES ( 13,9); 

INSERT INTO Attempts
VALUES (123456, 4, 2021, 1, 7);

INSERT INTO Attempts
VALUES (123456, 9, 2021, 2, 9);

INSERT INTO Attempts
VALUES (123456, 13, 2022, 1, 3);

INSERT INTO Attempts
VALUES (123456, 13, 2022, 2, 6);


-- Aufgabe 1.3

SELECT s.firstname, s.lastname
FROM student s, program p
WHERE p.name = 'Information Engineering' and p.programID = s.programID;


-- Aufgabe 1.4

SELECT DISTINCT c.name
FROM course c, prerequisite pre
WHERE c.courseID = pre.advancedCourse;


-- Aufgabe 1.5

SELECT SUM(c.creditPoints) AS SUM
FROM student s, course c, attempts a
WHERE s.firstname = 'John' AND s.lastname = 'Wayne' AND a.studentID = s.studentID
AND a.courseID = c.courseID AND a.grade > 4;


-- Aufgabe 1.6

DELETE FROM attempts a
   WHERE a.studentID IN (
      SELECT s.studentID FROM Student s
      WHERE s.firstName = 'John'
      AND s.lastName = 'Wayne');
      
DELETE FROM Student 
   WHERE firstName = 'John'
   AND lastName = 'Wayne';



-- Assignment 2

CREATE TABLE Harbour
  (harbourID INT NOT NULL,
   location VARCHAR(32) NOT NULL,
   establishedIn date,
   PRIMARY KEY (harbourID) ); 
   
CREATE TABLE Sailor
  (sailorID INT NOT NULL,
   lastName VARCHAR(32),
   dob date,
   trainedAt INT,
   primary key (sailorID),
   foreign key (trainedAT) references Harbour(harbourID));

CREATE TABLE Ship
  (shipID INT NOT NULL,
   name VARCHAR(32),
   grossWeight INT,
   launchDate date,
   baseHarbour INT,
   primary key (shipID),
   foreign key (baseHarbour) references Harbour(harbourID));
   
CREATE TABLE hire
  (sailorID INT NOT NULL,
  shipID INT NOT NULL,
   startOfService date,
   annualSalary INT,
   primary key (sailorID, shipID),
   foreign key (sailorID) references Sailor(sailorID),
   foreign key (shipID) references ship(shipID));
  

-- musste den Datentyp ändern wegen year...
ALTER TABLE Harbour
CHANGE COLUMN establishedIn establishedIn date;


INSERT INTO Harbour
VALUES ( 123, 'Hamburg','1189-01-01'); 

INSERT INTO Harbour
VALUES ( 234, 'Amsterdam','1200-01-01'); 

INSERT INTO Harbour
VALUES ( 345, 'Rotterdam','1898-01-01');

INSERT INTO Sailor
VALUES ( 12, 'Meyer','2002-02-03', 123);

INSERT INTO Sailor
VALUES ( 13, 'Smith','2005-02-03', 123);

INSERT INTO Sailor
VALUES ( 14, 'Jones','2012-02-08', 123);

INSERT INTO Sailor
VALUES ( 18, 'James','2015-02-08', 123);

INSERT INTO Sailor
VALUES ( 15, 'Ranger','2022-02-03', 234);

-- Weight in weight ton
INSERT INTO Ship
VALUES ( 45, 'Ship1',53.800, '2007-02-03',  123);

INSERT INTO Ship
VALUES ( 46, 'Ship2',55.800, '2015-02-03',  123);

INSERT INTO Ship
VALUES ( 47, 'Ship3',51.800, '2018-08-03',  234);

INSERT INTO Hire
VALUES ( 12, 45, '2010-08-03',  45000);

INSERT INTO Hire
VALUES ( 13, 45, '2012-08-03',  47000);

INSERT INTO Hire
VALUES ( 14, 45, '2012-08-03',  42000);

INSERT INTO Hire
VALUES ( 15, 47, '2012-08-03',  41000);

INSERT INTO Hire
VALUES ( 18, 46, '2011-08-03',  40500);


-- Ass 2.1

SELECT lastname, dob
from sailor s, hire h
where s.sailorID = h.sailorID AND
h.startOfService = '2012-08-03'
ORDER BY dob DESC;

-- Ass 2.2

SELECT *
from sailor s, hire h
where s.sailorID = h.sailorID AND
h.startOfService BETWEEN '2011-07-03' AND '2012-09-03'
AND lastname like 'J%';

-- Ass2.3

SELECT * from hire;

SELECT s.name, SUM(h.annualSalary)
FROM ship s, hire h
WHERE s.shipID = h.shipID
GROUP BY s.shipID;


-- Ass 2.4

Select h.location
FROM Harbour h
where h.harbourID NOT IN (SELECT s.baseharbour from Ship s);


-- Ass 2.5

SELECT * from hire;

select h.shipid, s.name, COUNT(h.sailorid)
FROM ship s, hire h
WHERE h.shipid = s.shipid
GROUP BY h.shipid
HAVING MAX(h.annualSalary) < 42000;



