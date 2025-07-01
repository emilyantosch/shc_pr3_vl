-- Create Tables
-- Dep value 1000 means no dep is assigned
CREATETABLEIFNOTEXISTSEMPLOYEE(
  FIRST_NAMEVARCHAR(15)NOTNULL,
  LAST_NAMEVARCHAR(15)NOTNULL,
  SSNCHAR(9),
  BIRTHDATEDATE,
  ADDRESSVARCHAR(30),
  SEXCHAR,
  SALARYDECIMAL(10,2),
  SUPER_SSNCHAR(9),
  DEPT_NUMINTNOTNULLDEFAULT1000PRIMARYKEY(
    Ssn
  )
);
CREATETABLEIFNOTEXISTSDEPARTMENT(
DEPT_NAMEVARCHAR(15)NOTNULL,
DEPT_NUMINTNOTNULLAUTO_INCREMENT,
MANAGER_SSNCHAR(9)NOTNULLDEFAULT'888665555',
MANAGER_START_DATEDATE,
CONSTRAINTDEPTPKPRIMARYKEY(
  Dnumber
),
CONSTRAINTDEPTSKUNIQUE(
  Dname
)
);
CREATETABLEIFNOTEXISTSDEPT_LOCATIONS(
DEPT_NUMINTNOTNULL,
DEPT_LOCATIONVARCHAR(15)NOTNULLPRIMARYKEY(
Dnumber,
Dlocation
),
FOREIGNKEY(
Dnumber
)REFERENCESDEPARTMENT(Dnumber)
ON DELETECASCADE
  ON UPDATECASCADE
);
CREATETABLEIFNOTEXISTSPROJECT(
PROJECT_NAMEVARCHAR(15)NOTNULL,
PROJECT_NUMINTNOTNULL,
PROJECT_LOCATIONVARCHAR(15),
DEPT_NUMINTNOTNULLPRIMARYKEY(
Pnumber,
Plocation
),
UNIQUE(
Pname
),
FOREIGNKEY(
Dnum
)REFERENCESDEPARTMENT(Dnumber)
);
CREATETABLEIFNOTEXISTSWORKS_ON(
EssnCHAR(9)NOTNULL,
PnoINTNOTNULL,
HoursDECIMAL(3 ,1)NOTNULLPRIMARYKEY(
Essn,
Pno
),
FOREIGNKEY(
Essn
)REFERENCESEMPLOYEE(Ssn)FOREIGNKEY(
Pno
)REFERENCESPROJECT(Pnumber)
);
CREATETABLEIFNOTEXISTSDEPENDENT(
EssnCHAR(9)NOTNULL,
Dependent_nameVARCHAR(15)NOTNULL,
SexCHAR,
BdateDATE,
RelationshipVARCHAR(15)PRIMARYKEY(
Essn,
Dependent_name
),
FOREIGNKEY(
Essn
)REFERENCESEMPLOYEE(Ssn)
);
-- change column Sex
ALTERTABLEEMPLOYEE CHANGECOLUMNSex SexENUM('f', 'm', 'd');
-- Load data into the database
-- Provided csv-files must be contained in Database C:\ProgramData\MySQL\MySQL Server 8.0\Data\company_wise_2024
load datainfile'employee.csv'INTOTABLEemployee fieldsterminatedBY';'lines terminatedBY'\n'ignore1lines(
Fname,
Minit,
Lname,
Ssn,
Bdate,
Address,
Sex,
Salary,
Super_ssn,
Dno
);
load datainfile'department.csv'INTOTABLEdepartment fieldsterminatedBY';'lines terminatedBY'\n'ignore1lines(
Dname,
Dnumber,
Mgr_ssn,
Mgr_start_date
);
load datainfile'Projects.csv'INTOTABLEproject fieldsterminatedBY';'lines terminatedBY'\n'ignore1lines(
Pname,
Pnumber,
Plocation,
Dnum
);
load datainfile'dept_locations.csv'INTOTABLEdept_locations fieldsterminatedBY';'lines terminatedBY'\n'ignore1lines(
Dnumber,
Dlocation
);
load datainfile'Works_on.csv'INTOTABLEworks_on fieldsterminatedBY';'lines terminatedBY'\n'ignore1lines(
Essn,
Pno,
Hours
);
load datainfile'dependent.csv'INTOTABLEdependent fieldsterminatedBY';'lines terminatedBY'\n'ignore1lines(
Essn,
Dependent_name,
Sex,
Bdate,
relationship
);
-- add some additional foreign keys
ALTERTABLEDEPARTMENTADDCONSTRAINTDEPTMGRFKFOREIGNKEY(
Mgr_ssn
)REFERENCESEMPLOYEE(Ssn)
ON DELETERESTRICT
ON UPDATECASCADE;
ALTERTABLEEMPLOYEEADDCONSTRAINTEMPDEPTFKFOREIGNKEY(
Dno
)REFERENCESDEPARTMENT(Dnumber)
ON DELETERESTRICT
ON UPDATECASCADE;
ALTERTABLEEMPLOYEEADDCONSTRAINTEMPSUPERFKFOREIGNKEY(
Super_ssn
)REFERENCESEMPLOYEE(Ssn)
ON DELETE
SETNULL
ON UPDATECASCADE;
-- Some experiments from the lecture
SELECT
*
FROM
Employee;
SELECT
*
FROM
PROJECT;
SELECT
*
FROM
department;
SELECT
*
FROM
EMPLOYEE
WHERE
super_ssn = '333445555';
DELETE FROMemployee
WHERE
ssn = '333445555';
INSERT INTO employee
VALUES(
'Test2',
'T',
'TEST2',
'111111111',
'1999-03-03',
'Test street',
'm',
30000,
'666884444',
5
);
DELETE FROMemployee
WHERE
ssn = '888665555';
