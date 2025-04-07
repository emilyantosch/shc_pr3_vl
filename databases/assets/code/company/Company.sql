-- drop database COMPANY;
Create SCHEMA IF NOT EXISTS COMPANY;
SET SEARCH_PATH TO COMPANY;

-- STEP 1: Create tables without foreign keys -----------------------------------------

CREATE TABLE IF NOT EXISTS EMPLOYEE
( 
Fname VARCHAR(15) NOT NULL ,
Minit CHAR,
Lname VARCHAR(15) NOT NULL ,
Ssn CHAR(9) NOT NULL,
Bdate DATE,
Address VARCHAR(50),
Sex CHAR,
Salary DECIMAL(10,2), 
Super_ssn CHAR(9),
Dno INT NOT NULL,
CONSTRAINT EMPPK PRIMARY KEY (Ssn));

CREATE TABLE IF NOT EXISTS DEPARTMENT
( 
Dname VARCHAR(15) NOT NULL,
Dnumber INT NOT NULL,
Mgr_ssn CHAR(9) NOT NULL,
Mgr_start_date DATE,
Doverhead INT NOT NULL, 
CONSTRAINT DEPTPK PRIMARY KEY (Dnumber) ,
CONSTRAINT DEPTUDNAME UNIQUE (Dname));

CREATE TABLE IF NOT EXISTS DEPT_LOCATIONS
( Dnumber INT NOT NULL,
Dlocation VARCHAR(15) NOT NULL,
CONSTRAINT DEPTLOCPK PRIMARY KEY (Dnumber, Dlocation),
FOREIGN KEY (Dnumber) REFERENCES DEPARTMENT(Dnumber) );

CREATE TABLE IF NOT EXISTS PROJECT
( Pname VARCHAR(15) NOT NULL,
Pnumber INT ,
Plocation VARCHAR(15),
Dnum INT NOT NULL,
PRIMARY KEY (Pnumber),
CONSTRAINT PROJECTUPNAME UNIQUE (Pname),
CONSTRAINT PROJECTFKDNUM FOREIGN KEY (Dnum) REFERENCES DEPARTMENT(Dnumber) );

CREATE TABLE IF NOT EXISTS WORKS_ON
( Essn CHAR(9) NOT NULL,
Pno INT NOT NULL,
Hours DECIMAL(3 ,1),
PRIMARY KEY (Essn , Pno),
FOREIGN KEY (Essn) REFERENCES EMPLOYEE(Ssn),
CONSTRAINT WORKSONFKPNO FOREIGN KEY (Pno) REFERENCES PROJECT(Pnumber) );

CREATE TABLE IF NOT EXISTS DEPENDENT
( Essn CHAR(9) NOT NULL,
Dependent_name VARCHAR(15) NOT NULL,
Sex CHAR,
Bdate DATE,
Relationship VARCHAR(15),
PRIMARY KEY (Essn , Dependent_name),
CONSTRAINT DEPFKESSN FOREIGN KEY (Essn) REFERENCES EMPLOYEE(Ssn) );

-- change column Sex
ALTER TABLE EMPLOYEE
CHANGE COLUMN Sex Sex ENUM('f', 'm', 'd') ;

-- STEP 2: Import Data -----------------------------------------
-- Provided csv-files must be contained in the file system of your Database, e.g., C:\ProgramData\MySQL\MySQL Server 8.0\Data\Company
COPY employee (Fname, Minit, Lname, Ssn, Bdate, Address, Sex, Salary, NULLIF(Superssn, ""), Dno)
FROM './Employee.csv'
DELIMITER ';' (FORMAT csv);

COPY department (Dname, Dnumber, Mgr_start_date, Mgr_ssn)
FROM './Department.csv'
DELIMITER ';' (FORMAT csv);

COPY projects (Pname, Pnumber, Plocation, Dnum)
FROM './Projects.csv'
DELIMITER ';' (FORMAT csv);

COPY dept_locations (Dnumber, Dlocation)
FROM './Dept_locations.csv'
DELIMITER ';' (FORMAT csv);

COPY works_on (Essn, Pno, NULLIF(hours, ""))
FROM './works_on.csv'
DELIMITER ';' (FORMAT csv);

COPY dependent (Essn, Dependent_name, Sex, Bdate, relationship)
FROM './dependent.csv'
DELIMITER ';' (FORMAT csv);


-- STEP 3: Add Foreign Keys -----------------------------------------

ALTER TABLE DEPARTMENT
ADD CONSTRAINT DEPTMGRFK FOREIGN KEY (Mgr_ssn) REFERENCES EMPLOYEE(Ssn) 
ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE EMPLOYEE
ADD CONSTRAINT EMPFKDNO FOREIGN KEY (Dno) REFERENCES DEPARTMENT(Dnumber) 
ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE EMPLOYEE 
ADD CONSTRAINT EMPFKSUPERSSN
FOREIGN KEY (Super_ssn) REFERENCES EMPLOYEE(Ssn)
ON DELETE SET NULL ON UPDATE CASCADE ;
