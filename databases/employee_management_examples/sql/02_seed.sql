-- Example data from recurring COMPANY employee-management example.
-- Run in database: employee_management, after 01_schema.sql

BEGIN;
SET CONSTRAINTS ALL DEFERRED;

TRUNCATE TABLE dependent, works_on, project, dept_locations, employee, department;

INSERT INTO department (dname, dnumber, mgr_ssn, mgr_start_date) VALUES
    ('Research', 5, '333445555', DATE '1988-05-22'),
    ('Administration', 4, '987654321', DATE '1995-01-01'),
    ('Headquarters', 1, '888665555', DATE '1981-06-19');

INSERT INTO employee (fname, minit, lname, ssn, bdate, address, sex, salary, super_ssn, dno) VALUES
    ('John', 'B', 'Smith', '123456789', DATE '1965-01-09', '731 Fondren, Houston, TX', 'M', 30000, '333445555', 5),
    ('Franklin', 'T', 'Wong', '333445555', DATE '1955-12-08', '638 Voss, Houston, TX', 'M', 40000, '888665555', 5),
    ('Alicia', 'J', 'Zelaya', '999887777', DATE '1968-01-19', '3321 Castle, Spring, TX', 'F', 25000, '987654321', 4),
    ('Jennifer', 'S', 'Wallace', '987654321', DATE '1941-06-20', '291 Berry, Bellaire, TX', 'F', 43000, '888665555', 4),
    ('Ramesh', 'K', 'Narayan', '666884444', DATE '1962-09-15', '975 Fire Oak, Humble, TX', 'M', 38000, '333445555', 5),
    ('Joyce', 'A', 'English', '453453453', DATE '1972-07-31', '5631 Rice, Houston, TX', 'F', 25000, '333445555', 5),
    ('Ahmad', 'V', 'Jabbar', '987987987', DATE '1969-03-29', '980 Dallas, Houston, TX', 'M', 25000, '987654321', 4),
    ('James', 'E', 'Borg', '888665555', DATE '1937-11-10', '450 Stone, Houston, TX', 'M', 55000, NULL, 1);

INSERT INTO dept_locations (dnumber, dlocation) VALUES
    (1, 'Houston'),
    (4, 'Stafford'),
    (5, 'Bellaire'),
    (5, 'Sugarland'),
    (5, 'Houston');

INSERT INTO project (pname, pnumber, plocation, dnum) VALUES
    ('ProductX', 1, 'Bellaire', 5),
    ('ProductY', 2, 'Sugarland', 5),
    ('ProductZ', 3, 'Houston', 5),
    ('Computerization', 10, 'Stafford', 4),
    ('Reorganization', 20, 'Houston', 1),
    ('Newbenefits', 30, 'Stafford', 4);

INSERT INTO works_on (essn, pno, hours) VALUES
    ('123456789', 1, 32.5),
    ('123456789', 2, 7.5),
    ('666884444', 3, 40.0),
    ('453453453', 1, 20.0),
    ('453453453', 2, 20.0),
    ('333445555', 2, 10.0),
    ('333445555', 3, 10.0),
    ('333445555', 10, 10.0),
    ('333445555', 20, 10.0),
    ('999887777', 30, 30.0),
    ('999887777', 10, 10.0),
    ('987987987', 10, 35.0),
    ('987987987', 30, 5.0),
    ('987654321', 30, 20.0),
    ('987654321', 20, 15.0),
    ('888665555', 20, NULL);

INSERT INTO dependent (essn, dependent_name, sex, bdate, relationship) VALUES
    ('333445555', 'Alice', 'F', DATE '1986-04-05', 'Daughter'),
    ('333445555', 'Theodore', 'M', DATE '1983-10-25', 'Son'),
    ('333445555', 'Joy', 'F', DATE '1958-05-03', 'Spouse'),
    ('987654321', 'Abner', 'M', DATE '1942-02-28', 'Spouse'),
    ('123456789', 'Michael', 'M', DATE '1988-01-04', 'Son'),
    ('123456789', 'Alice', 'F', DATE '1988-12-30', 'Daughter'),
    ('123456789', 'Elizabeth', 'F', DATE '1967-05-05', 'Spouse');

COMMIT;
