-- Teaching queries for employee-management example.

-- Employees in department 5 who work at least 10 hours on any project.
SELECT e.fname, e.lname, p.pname, wo.hours
FROM employee AS e
JOIN works_on AS wo ON wo.essn = e.ssn
JOIN project AS p ON p.pnumber = wo.pno
WHERE e.dno = 5
  AND wo.hours >= 10
ORDER BY e.lname, p.pname;

-- Employees who have a dependent with same first name.
SELECT e.fname, e.lname, d.dependent_name
FROM employee AS e
JOIN dependent AS d ON d.essn = e.ssn
WHERE d.dependent_name = e.fname;

-- Employees directly supervised by Franklin Wong.
SELECT e.fname, e.lname
FROM employee AS e
JOIN employee AS supervisor ON supervisor.ssn = e.super_ssn
WHERE supervisor.fname = 'Franklin'
  AND supervisor.lname = 'Wong'
ORDER BY e.lname;

-- Total weekly hours per project.
SELECT p.pname, COALESCE(SUM(wo.hours), 0) AS total_hours
FROM project AS p
LEFT JOIN works_on AS wo ON wo.pno = p.pnumber
GROUP BY p.pnumber, p.pname
ORDER BY p.pnumber;

-- Department summary with manager and average salary.
SELECT
    d.dname,
    manager.fname || ' ' || manager.lname AS manager,
    COUNT(e.ssn) AS employee_count,
    ROUND(AVG(e.salary), 2) AS avg_salary
FROM department AS d
LEFT JOIN employee AS manager ON manager.ssn = d.mgr_ssn
LEFT JOIN employee AS e ON e.dno = d.dnumber
GROUP BY d.dnumber, d.dname, manager.fname, manager.lname
ORDER BY d.dnumber;
