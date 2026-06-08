-- Employee Management / COMPANY schema for PostgreSQL.
-- Run in database: employee_management

DROP TABLE IF EXISTS dependent CASCADE;
DROP TABLE IF EXISTS works_on CASCADE;
DROP TABLE IF EXISTS project CASCADE;
DROP TABLE IF EXISTS dept_locations CASCADE;
DROP TABLE IF EXISTS employee CASCADE;
DROP TABLE IF EXISTS department CASCADE;

CREATE TABLE department (
    dnumber INTEGER PRIMARY KEY,
    dname VARCHAR(30) NOT NULL UNIQUE,
    mgr_ssn CHAR(9),
    mgr_start_date DATE
);

CREATE TABLE employee (
    ssn CHAR(9) PRIMARY KEY,
    fname VARCHAR(20) NOT NULL,
    minit CHAR(1),
    lname VARCHAR(20) NOT NULL,
    bdate DATE,
    address VARCHAR(80),
    sex CHAR(1) CHECK (sex IN ('M', 'F') OR sex IS NULL),
    salary INTEGER NOT NULL CHECK (salary >= 0),
    super_ssn CHAR(9),
    dno INTEGER NOT NULL,
    CONSTRAINT employee_department_fk
        FOREIGN KEY (dno)
        REFERENCES department (dnumber)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT employee_supervisor_fk
        FOREIGN KEY (super_ssn)
        REFERENCES employee (ssn)
        ON DELETE SET NULL
        ON UPDATE CASCADE
        DEFERRABLE INITIALLY DEFERRED
);

ALTER TABLE department
    ADD CONSTRAINT department_manager_fk
    FOREIGN KEY (mgr_ssn)
    REFERENCES employee (ssn)
    ON DELETE SET NULL
    ON UPDATE CASCADE
    DEFERRABLE INITIALLY DEFERRED;

CREATE TABLE dept_locations (
    dnumber INTEGER NOT NULL,
    dlocation VARCHAR(30) NOT NULL,
    PRIMARY KEY (dnumber, dlocation),
    CONSTRAINT dept_locations_department_fk
        FOREIGN KEY (dnumber)
        REFERENCES department (dnumber)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE project (
    pnumber INTEGER PRIMARY KEY,
    pname VARCHAR(30) NOT NULL UNIQUE,
    plocation VARCHAR(30),
    dnum INTEGER NOT NULL,
    CONSTRAINT project_department_fk
        FOREIGN KEY (dnum)
        REFERENCES department (dnumber)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

CREATE TABLE works_on (
    essn CHAR(9) NOT NULL,
    pno INTEGER NOT NULL,
    hours DOUBLE PRECISION CHECK (hours IS NULL OR hours >= 0),
    PRIMARY KEY (essn, pno),
    CONSTRAINT works_on_employee_fk
        FOREIGN KEY (essn)
        REFERENCES employee (ssn)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT works_on_project_fk
        FOREIGN KEY (pno)
        REFERENCES project (pnumber)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE dependent (
    essn CHAR(9) NOT NULL,
    dependent_name VARCHAR(30) NOT NULL,
    sex CHAR(1) CHECK (sex IN ('M', 'F') OR sex IS NULL),
    bdate DATE,
    relationship VARCHAR(30),
    PRIMARY KEY (essn, dependent_name),
    CONSTRAINT dependent_employee_fk
        FOREIGN KEY (essn)
        REFERENCES employee (ssn)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE INDEX employee_dno_idx ON employee (dno);
CREATE INDEX employee_supervisor_idx ON employee (super_ssn);
CREATE INDEX project_dnum_idx ON project (dnum);
CREATE INDEX works_on_pno_idx ON works_on (pno);
