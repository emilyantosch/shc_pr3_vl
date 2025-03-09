![](_page_0_Picture_0.jpeg)

Source: https://en.itpedia.nl/2017/11/26/wat-is-een-database/

**DATABASES**

Prof. Dr. Ulrike Herster Hamburg University of Applied Sciences

![](_page_0_Picture_4.jpeg)

# **COPYRIGHT**

![](_page_1_Picture_1.jpeg)

The publication and sharing of slides, images and sound recordings of this course is not permitted

© Professor Dr. Ulrike Herster

The slides and assignments are protected by copyright. The use is only permitted in relation with the course of study. It is not permitted to forward or republish it in other places (e.g., on the internet).

**Databases, © Ulrike Herster, partially © Elmasri "Fundamentals of Database Systems – For personal use only** .

![](_page_1_Picture_6.jpeg)

# **ORGANIZATION OUR JOURNEY IN THIS SEMESTER**

![](_page_2_Picture_1.jpeg)

- Integrity, Trigger & Security
- Database Applications
- Transactions
- Subqueries & Views
- **More SQL**
- Notations & Guidelines
- Constraints
- Relationships
- Simple Entities and Attributes
- Basics

2 Source: Foto von Justin Kauffman auf Unsplash

![](_page_2_Picture_13.jpeg)

![](_page_2_Picture_14.jpeg)

# **MORE SQL RELATIONAL ALGEBRA**

![](_page_3_Picture_1.jpeg)

3

 SQL What! Relational Algebra How!

- In mathematics an algebra is a values range combined with defined operations
- *Relational Algebra*: The values range is the content of the database; operations are functions to calculate the query results a set of operations for the relational model
- *Relational Calculus*: Descriptive approach that is based on mathematical logic
	- higher-level declarative language for specifying relational queries,
	- e.g., no order of operations, only what information the result should contain

Source: Elmasri, Fundamentals of

Database Systems, Page 145ff

# **MORE SQL RELATIONAL ALGEBRA: OPERATIONS**

![](_page_4_Picture_1.jpeg)

| O<br>t<br>i<br>p<br>e<br>r<br>a<br>o<br>n      | P<br>r<br>p<br>o<br>s<br>e<br>u                                                                                                                                                                                                                                                                                                                                                                                                                                                                             | N<br>t<br>t<br>i<br>o<br>a<br>o<br>n                                                                                                                                                                                                                               |
|------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| S<br>l<br>i<br>t<br>e<br>e<br>c<br>o<br>n      | S<br>l<br>l<br>l<br>l<br>h<br>i<br>f<br>h<br>l<br>i<br>d<br>i<br>i<br>t<br>t<br>t<br>t<br>t<br>t<br>t<br>t<br>e<br>e<br>c<br>s<br>a<br>u<br>p<br>e<br>s<br>a<br>s<br>a<br>s<br>y<br>e<br>s<br>e<br>e<br>c<br>o<br>n<br>c<br>o<br>n<br>o<br>n<br>f<br>l<br>t<br>i<br>�<br>�<br>r<br>o<br>m<br>a<br>r<br>e<br>a<br>o<br>n                                                                                                                                                                                     | ሺ<br>ሻ<br>�<br>�<br>�<br>�ழ<br>௜௢<br>௜<br>௜௢<br>௟௘<br>ௗ<br>௧<br>௧<br>வ<br>௦௘<br>௖<br>௡<br>௖௢<br>௡<br>௡                                                                                                                                                             |
| P<br>j<br>t<br>i<br>r<br>o<br>e<br>c<br>o<br>n | f<br>P<br>d<br>l<br>t<br>i<br>i<br>t<br>h<br>l<br>t<br>h<br>t<br>t<br>i<br>b<br>t<br>r<br>o<br>u<br>c<br>e<br>s<br>a<br>n<br>e<br>w<br>r<br>e<br>a<br>o<br>n<br>w<br>o<br>n<br>y<br>s<br>o<br>m<br>e<br>o<br>e<br>a<br>r<br>u<br>e<br>s<br>f<br>d<br>d<br>l<br>i<br>t<br>t<br>l<br>�<br>�<br>o<br>a<br>n<br>r<br>e<br>m<br>o<br>e<br>s<br>p<br>c<br>a<br>e<br>p<br>e<br>s<br>v<br>u<br>u<br>,                                                                                                               | ሺ<br>ሻ<br>�<br>�<br>�<br>�<br>௜<br>௜௦<br>௕௨<br>௟<br>௧<br>௧௥<br>௧௘<br>௧<br>ழ<br>வ<br>௔                                                                                                                                                                              |
| R<br>i<br>e<br>n<br>a<br>m<br>n<br>g           | C<br>l<br>i<br>t<br>h<br>l<br>t<br>l<br>t<br>i<br>t<br>o<br>m<br>n<br>n<br>e<br>r<br>e<br>s<br>r<br>e<br>a<br>o<br>n<br>g<br>e<br>s<br>n<br>e<br>n<br>a<br>m<br>e<br>u<br>u<br>w                                                                                                                                                                                                                                                                                                                            | ሺ<br>ሻ<br>�<br>�<br>�<br>�<br>௜<br>௕௨<br>௧<br>௧௥<br>௧௘<br>௡௘<br>௡௔<br>௠<br>௘<br>௔<br>௡௔<br>௠<br>௘<br>௪<br>←                                                                                                                                                        |
| J<br>i<br>o<br>n                               | f<br>f<br>P<br>d<br>l<br>l<br>b<br>i<br>t<br>i<br>t<br>l<br>d<br>�<br>�<br>�<br>�<br>r<br>o<br>u<br>c<br>e<br>s<br>a<br>c<br>o<br>m<br>n<br>a<br>o<br>n<br>s<br>o<br>u<br>p<br>e<br>s<br>r<br>o<br>m<br>a<br>n<br>ଵ<br>ଶ<br>f<br>t<br>h<br>t<br>t<br>i<br>t<br>h<br>j<br>i<br>d<br>i<br>t<br>i<br>a<br>s<br>a<br>s<br>y<br>e<br>o<br>n<br>c<br>o<br>n<br>o<br>n                                                                                                                                             | �<br>�<br>�<br>�<br>⋈<br>௝<br>௜௡<br>ௗ<br>௜<br>௜௢<br>ଵ<br>ଶ<br>ழ<br>௧<br>வ<br>௢<br>௖௢<br>௡<br>௡                                                                                                                                                                     |
| E<br>i<br>j<br>i<br>q<br>u<br>o<br>n           | f<br>f<br>P<br>d<br>l<br>l<br>t<br>h<br>b<br>i<br>t<br>i<br>t<br>l<br>d<br>�<br>�<br>r<br>o<br>u<br>c<br>e<br>s<br>a<br>e<br>c<br>o<br>m<br>n<br>a<br>o<br>n<br>s<br>o<br>u<br>p<br>e<br>s<br>r<br>o<br>m<br>a<br>n<br>ଵ<br>t<br>h<br>t<br>t<br>i<br>f<br>j<br>i<br>d<br>i<br>t<br>i<br>i<br>t<br>h<br>l<br>l<br>i<br>t<br>�<br>�<br>a<br>s<br>a<br>s<br>a<br>o<br>n<br>c<br>o<br>n<br>o<br>n<br>o<br>n<br>e<br>q<br>a<br>y<br>w<br>y<br>u<br>y<br>ଶ<br>i<br>c<br>o<br>m<br>p<br>a<br>r<br>s<br>o<br>n<br>s | �<br>�<br>�<br>�<br>∗ழ<br>௝<br>௜௡<br>ௗ<br>௜<br>௜௢<br>ଵ<br>ଶ<br>௧<br>வ<br>௢<br>௖௢<br>௡<br>௡                                                                                                                                                                         |
|                                                |                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             | S<br>E<br>l<br>i,<br>F<br>d<br>l<br>f<br>t<br>o<br>u<br>r<br>c<br>e<br>:<br>m<br>a<br>s<br>r<br>u<br>n<br>a<br>m<br>e<br>n<br>a<br>s<br>o<br>D<br>b<br>S<br>P<br>1<br>4<br>5<br>f<br>f<br>t<br>t<br>a<br>a<br>a<br>s<br>e<br>y<br>s<br>e<br>m<br>s,<br>a<br>g<br>e |

**Databases, © Ulrike Herster, partially © Elmasri "Fundamentals of Database Systems – For personal use only**

![](_page_4_Picture_4.jpeg)

# **MORE SQL RELATIONAL ALGEBRA: OPERATIONS**

![](_page_5_Picture_1.jpeg)

| O<br>i<br>t<br>p<br>e<br>r<br>a<br>o<br>n                                    | P<br>u<br>r<br>p<br>o<br>s<br>e                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         | N<br>i<br>t<br>t<br>o<br>a<br>o<br>n |
|------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|--------------------------------------|
| U<br>i<br>n<br>o<br>n                                                        | P<br>d<br>l<br>i<br>h<br>i<br>l<br>d<br>l<br>l<br>h<br>l<br>i<br>t<br>t<br>t<br>t<br>t<br>�<br>�<br>�<br>�<br>r<br>o<br>c<br>e<br>s<br>a<br>r<br>e<br>a<br>o<br>n<br>a<br>n<br>c<br>e<br>s<br>a<br>e<br>p<br>e<br>s<br>n<br>o<br>r<br>o<br>r<br>u<br>u<br>u<br>ଵ<br>ଶ<br>b<br>h<br>d<br>d<br>b<br>i<br>i<br>b<br>l<br>t<br>t<br>t<br>�<br>�<br>�<br>�<br>�<br>�<br>�<br>�<br>o<br>a<br>n<br>;<br>a<br>n<br>m<br>u<br>s<br>e<br>u<br>n<br>o<br>n<br>c<br>o<br>m<br>p<br>a<br>e<br>ଵ<br>ଶ<br>ଵ<br>ଶ                                                                       | �<br>�<br>�<br>�<br>∪<br>ଵ<br>ଶ      |
| I<br>i<br>t<br>t<br>n<br>e<br>r<br>s<br>e<br>c<br>o<br>n                     | P<br>d<br>l<br>i<br>h<br>i<br>l<br>d<br>l<br>l<br>h<br>l<br>i<br>b<br>h<br>d<br>t<br>t<br>t<br>t<br>t<br>t<br>�<br>�<br>r<br>o<br>c<br>e<br>s<br>a<br>r<br>e<br>a<br>o<br>n<br>a<br>n<br>c<br>e<br>s<br>a<br>e<br>p<br>e<br>s<br>n<br>o<br>a<br>n<br>u<br>u<br>u<br>ଵ<br>d<br>t<br>b<br>i<br>t<br>i<br>b<br>l<br>�<br>�<br>�<br>�<br>�<br>�<br>;<br>a<br>n<br>m<br>u<br>s<br>e<br>u<br>n<br>o<br>n<br>c<br>o<br>m<br>p<br>a<br>e<br>ଶ<br>ଵ<br>ଶ                                                                                                                         | �<br>�<br>�<br>�<br>∩<br>ଶ<br>ଵ      |
| S<br>D<br>i<br>f<br>f<br>t<br>e<br>e<br>r<br>e<br>n<br>c<br>e                | P<br>d<br>l<br>i<br>h<br>i<br>l<br>d<br>l<br>l<br>h<br>l<br>i<br>h<br>t<br>t<br>t<br>t<br>t<br>t<br>t<br>�<br>�<br>r<br>o<br>u<br>c<br>e<br>s<br>a<br>r<br>e<br>a<br>o<br>n<br>a<br>n<br>c<br>u<br>e<br>s<br>a<br>e<br>u<br>p<br>e<br>s<br>n<br>a<br>a<br>r<br>e<br>ଵ<br>t<br>i<br>d<br>t<br>b<br>i<br>t<br>i<br>b<br>l<br>�<br>�<br>�<br>�<br>�<br>�<br>n<br>o<br>n<br>;<br>a<br>n<br>m<br>u<br>s<br>e<br>u<br>n<br>o<br>n<br>c<br>o<br>m<br>p<br>a<br>e<br>ଶ<br>ଵ<br>ଶ                                                                                                | �<br>�<br>�<br>�<br>െ<br>ଵ<br>ଶ      |
| C<br>t<br>i<br>P<br>d<br>t<br>a<br>r<br>e<br>s<br>a<br>n<br>r<br>o<br>u<br>c | f<br>P<br>d<br>l<br>t<br>i<br>t<br>h<br>t<br>h<br>t<br>h<br>t<br>t<br>i<br>b<br>t<br>d<br>�<br>�<br>r<br>o<br>u<br>c<br>e<br>s<br>a<br>r<br>e<br>a<br>o<br>n<br>a<br>a<br>s<br>e<br>a<br>r<br>u<br>e<br>s<br>o<br>a<br>n<br>ଵ<br>d<br>i<br>l<br>d<br>t<br>l<br>l<br>l<br>i<br>b<br>l<br>b<br>i<br>t<br>i<br>f<br>�<br>�<br>a<br>n<br>n<br>c<br>e<br>s<br>a<br>s<br>p<br>e<br>s<br>a<br>p<br>o<br>s<br>s<br>e<br>c<br>o<br>m<br>n<br>a<br>o<br>n<br>s<br>o<br>u<br>u<br>ଶ<br>l<br>f<br>d<br>t<br>�<br>�<br>�<br>�<br>u<br>p<br>e<br>s<br>r<br>o<br>m<br>a<br>n<br>ଵ<br>ଶ | �<br>�<br>�<br>�<br>ൈ<br>ଵ<br>ଶ      |

Source: Elmasri, Fundamentals of

![](_page_5_Picture_4.jpeg)

![](_page_5_Picture_6.jpeg)

# **ORGANIZATION OUR JOURNEY IN THIS SEMESTER**

![](_page_6_Picture_1.jpeg)

- Integrity, Trigger & Security
- Database Applications
- Transactions
- **Subqueries & Views**
- More SQL
- Notations & Guidelines
- Constraints
- Relationships
- Simple Entities and Attributes

 **only**

Basics

6 Source: Foto von Justin Kauffman auf Unsplash

![](_page_6_Picture_13.jpeg)

![](_page_6_Picture_14.jpeg)

**Databases, © Ulrike Herster, partially© Elmasri"FundamentalsofDatabase Systems –Forpersonal use**

## **SUBQUERIES AND VIEWS SUBQUERIES**

![](_page_7_Picture_1.jpeg)

- **SELECT** returns relation: a (multi-)set
- Result of **SELECT** can be included in query
	- **WHERE** clause
		- also, for **UPDATE**, **DELETE**
	- **HAVING** clause
	- **FROM** clause

- **SELECT** clause (in column list)
- So, we have two (or more) **SELECT**s:
	- Outer **SELECT**
	- Nested (or inner) **SELECT**: *subquery*

**Databases, © Ulrike Herster, partially © Elmasri "Fundamentals of Database Systems – For personal use only**

![](_page_7_Picture_13.jpeg)

### **SUBQUERIES AND VIEWS SUBQUERIES – OPERATORS IN WHERE**

### **IN**

| SELECT E.Fname, E.Lname |  |                                 |                       |  |
|-------------------------|--|---------------------------------|-----------------------|--|
| FROM   EMPLOYEE AS E    |  |                                 |                       |  |
|                         |  | WHERE E.Ssn IN (    SELECT Essn |                       |  |
|                         |  |                                 | FROM   DEPENDENT AS D |  |
|                         |  |                                 | WHERE E.Sex = D.Sex ) |  |

### **=**

| SELECT *                             |  |  |  |
|--------------------------------------|--|--|--|
| IFROM V                              |  |  |  |
| WHERE x = ( SELECT MAX(x) FROM y ) ; |  |  |  |

### **ANY**

## **ALL**

|       | SELECT Lname, Fname |          |  |
|-------|---------------------|----------|--|
| FROM  | EMPLOYEE            |          |  |
| WHERE | Salary > ALL        |          |  |
|       | ( SELECT            | Salary   |  |
|       | FROM                | EMPLOYEE |  |
|       | WHERE               | Dno=5) ; |  |
|       |                     |          |  |

## **EXISTS**

### **NOT EXISTS**

| SELECT Fname, Lname |  |  |                             |                   |  |
|---------------------|--|--|-----------------------------|-------------------|--|
| FROM EMPLOYEE       |  |  |                             |                   |  |
|                     |  |  | WHERE NOT EXISTS ( SELECT * |                   |  |
|                     |  |  |                             | FROM  DEPENDENT   |  |
|                     |  |  |                             | MHERE Ssn=Essn ); |  |

![](_page_8_Picture_13.jpeg)

**Databases, © Ulrike Herster, partially © Elmasri "Fundamentals of Database Systems – For personal use only**

![](_page_8_Picture_15.jpeg)

Repetition

### **SUBQUERIES AND VIEWS SUBQUERIES – IN FROM**

![](_page_9_Picture_1.jpeg)

- **SELECT** returns a new relation
- ... so, we can select values from it
- Necessary: give a name to the relation
- Example: Alias name newtab\_b

**SELECT** tab\_a.x , newtab\_b.y **FROM** tab\_a , (**SELECT** v1, v2 **FROM** tab\_b) **AS** newtab\_b ;

![](_page_9_Picture_7.jpeg)

![](_page_9_Picture_8.jpeg)

## **SUBQUERIES AND VIEWS SUBQUERIES: ASSIGNMENT**

- Suppose that we want the department name number of employees in each department whose departments have an average income of more than 30,000 \$. How can we specify this query in SQL?
- Retrieve the names of all employees with the smallest salary.
- Retrieve the names of all employees whose supervisor's supervisor has ssn '888665555'.
- Retrieve the names of employees who make at least \$10,000 more than the employee who is paid the least in the company.

| Fname    | Minit | Lname   | Ssn       | Bdate      | Address                       | Sex | Salary | Super ssn | Dno |
|----------|-------|---------|-----------|------------|-------------------------------|-----|--------|-----------|-----|
| John     | B     | Smith   | 123456789 | 1965-01-09 | M<br>731 Fondren, Houston, TX |     | 30000  | 333445555 | 5   |
| Franklin |       | Wong    | 333445555 | 1955-12-08 | M<br>638 Voss, Houston, TX    |     | 40000  | 888665555 | 5   |
| Alicia   | J     | Zelaya  | 999887777 | 1968-01-19 | 3321 Castle, Spring, TX       | F   | 25000  | 987654321 | 4   |
| Jennifer | S     | Wallace | 987654321 | 1941-06-20 | 291 Berry, Bellaire, TX       | F   | 43000  | 888665555 | 4   |
| Ramesh   | K     | Narayan | 666884444 | 1962-09-15 | 975 Fire Oak, Humble, TX      | M   | 38000  | 333445555 | 5   |
| Joyce    | A     | English | 453453453 | 1972-07-31 | 5631 Rice, Houston, TX        | F   | 25000  | 333445555 | 5   |
| Ahmad    | V     | Jabbar  | 987987987 | 1969-03-29 | 980 Dallas, Houston, TX       | M   | 25000  | 987654321 | 4   |
| James    | E     | Borg    | 888665555 | 1937-11-10 | 450 Stone, Houston, TX        | M   | 55000  | NULL      | 1   |

| Dname          | Dnumber | Mgr_ssn   | Mgr_start_date |  |
|----------------|---------|-----------|----------------|--|
| Research       | 5       | 333445555 | 1988-05-22     |  |
| Administration | য       | 987654321 | 1995-01-01     |  |
| Headquarters   |         | 888665555 | 1981-06-19     |  |

| Dnumber | Dlocation |  |  |
|---------|-----------|--|--|
| 1       | Houston   |  |  |
| A       | Stafford  |  |  |
| 5       | Bellaire  |  |  |
| 5       | Sugarland |  |  |
| 5       | Houston   |  |  |

| l u<br>p<br>er<br>so<br>na | se<br>on | ly |  |  |  |
|----------------------------|----------|----|--|--|--|

| Pname           | Pnumber | Plocation | Dnum |  |
|-----------------|---------|-----------|------|--|
| ProductX        | 1       | Bellaire  | 5    |  |
| ProductY        | 2       | Sugarland | 5    |  |
| ProductZ        | 3       | Houston   | 5    |  |
| Computerization | 10      | Stafford  | র্ব  |  |
| Reorganization  | 20      | Houston   | 1    |  |
| Newbenefits     | 30      | Stafford  | র্ব  |  |

|  |  | 10 |
|--|--|----|
|  |  |    |
|  |  |    |
|  |  |    |

## **SUBQUERIES AND VIEWS VIEWS – RECAP: THE ANSI-SPARC ARCHITECTURE**

![](_page_11_Picture_1.jpeg)

![](_page_11_Figure_2.jpeg)

Source: www.wikipedia.org 11

## **SUBQUERIES AND VIEWS VIEWS – BASICS**

![](_page_12_Picture_1.jpeg)

- User or application specific views on data
- Only relevant portions of the data
- A *view* in SQL terminology is a single table that is derived from other tables Other tables can be *base tables* or previously defined views
- A view is considered to be a *virtual table*
	- In contrast to base tables

- Limits the possible update operations
- No limitations on querying a view

12 Source: Elmasri, Fundamentals of Database Systems, Page 115ff

![](_page_12_Picture_10.jpeg)

![](_page_12_Picture_11.jpeg)

## **SUBQUERIES AND VIEWS VIEWS – CREATE**

![](_page_13_Picture_1.jpeg)

 Example:

**CREATE VIEW** vPerson **AS**

> **SELECT** Name , Id , BirthDate **FROM** person ;

> > **vPerson Name Id BirthDate**

Can rename columns in view:

![](_page_13_Picture_7.jpeg)

![](_page_13_Picture_9.jpeg)

 Views are Relations ... just like tables

- Should make no difference to users
- Question: **Can we modify the view's data?** Depends on type of view!

![](_page_14_Picture_4.jpeg)

![](_page_14_Picture_5.jpeg)

Example: **EMPLOYEE Lname Ssn … PROJECT Pname Pnumber … WORKS\_ON Essn Pno Hours WORKS\_ON1 Fname Lname Pname Hours**

## **UPDATE** v\_WORKS\_ON1

- **SET** Pname = "Project2"
- **WHERE** Lname= "Borg"
	- **AND** Fname= "James"
	- **AND** Pname= "Project2";

648 Source: Elmasri, Fundamentals of Database Systems, Page 115ff

![](_page_15_Picture_8.jpeg)

![](_page_15_Picture_9.jpeg)

Example:

 Possible update 1 (*Query Modification)*:

![](_page_16_Figure_3.jpeg)

![](_page_16_Picture_4.jpeg)

![](_page_16_Picture_5.jpeg)

Example:

 Possible update 2 (*View Materialization)*:

**UPDATE** PROJECT

- **SET** Pname = "Project2"
- **WHERE** Pname = "Project1";

650 Source: Elmasri, Fundamentals of Database Systems, Page 115ff

![](_page_17_Picture_7.jpeg)

![](_page_17_Picture_8.jpeg)

- Classify views based on the select:
	- *Projection View*
		- **SELECT** a, b, c …
	- *Selection View*
		- … **WHERE** < condition > …
	- *Join View*

- … **FROM** tab\_a **JOIN** tab\_b …
- *Aggregation View*
	- **SELECT MAX**(x) …
- Other types and combinations exist

![](_page_18_Picture_11.jpeg)

### *Projection View*

Example:

- … **AS SELECT** a , b , c **FROM** …
- Manipulations can be transformed to base table quite easily

![](_page_19_Picture_5.jpeg)

**Databases, © Ulrike Herster, partially © Elmasri "Fundamentals of Database Systems – For personal use only**

![](_page_19_Picture_7.jpeg)

- *Selection View*
	- Example:

```
CREATE VIEW v_top AS SELECT * FROM employee WHERE salary > 20000;
```
## Problem:

- Update can move tuples out of selection condition
- So, the update looks like a delete!
- Example: **UPDATE** v\_top **SET** salary = 100;

This phenomenon is called "*tuple migration*"

653

```
Join View
 Example:
  CREATE VIEW v_depman AS
     SELECT *
     FROM employee , department
     WHERE employee.ssn = department.mgr_ssn ;
```
- Data manipulation cannot be transformed to base tables in general case! **DELETE FROM** v\_depman **WHERE** id =11;
- Transformation to base tables employee and department? **DELETE FROM** employee ? **DELETE FROM** department ?

**Databases, © Ulrike Herster, partially © Elmasri "Fundamentals of Database Systems – For personal use only**

![](_page_21_Picture_5.jpeg)

 *Aggregation View*

```
Example:
CREATE VIEW v_astats AS
  SELECT MAX(i) , MIN(i) , COUNT(*)
  FROM a ;
```
- Update of the aggregated columns not possible!
- Note: Aggregation may depend on other columns (**GROUP BY**)

![](_page_22_Picture_5.jpeg)

655

 A view with a single defining table is updatable if 

- the view attributes contain the primary key of the base relation,
- as well as all attributes with the NOT NULL constraint that have a default value specified
- Views defined on multiple tables using joins are only updatable in special cases E.g., **INSERT** and **UPDATE** for Join Views, if join condition is based on PK-FK
- Views defined using grouping and aggregate functions are not updatable

656 Source: Elmasri, Fundamentals of Database Systems, Page 115ff

![](_page_23_Picture_8.jpeg)

 Oracle and standard SQL allow certain options at end of **VIEW** definition:

… **WITH READ ONLY** ;

- Read only view, no data manipulation allowed
- … **WITH CHECK OPTION**;
	- Updates leading to tuple migration are denied

![](_page_24_Picture_6.jpeg)

## **SUBQUERIES AND VIEWS GENERATED TABLES**

- Syntax: **CREATE TABLE** <name> **AS SELECT** …
- Can create new table based on query
- New table is independent from old table
- Use cases:
	- Copy table
	- Copy parts of table
- Attention: New table does not have all constraints of the parent table!

![](_page_25_Picture_8.jpeg)

## **SUBQUERIES AND VIEWS GENERATED TABLES**

Example from before:

**INSERT INTO** Underpaid ( lname , fname ) **SELECT** lname , fname **FROM** Employee **WHERE** salary < 1000 ;

**WHERE** clause belongs to **SELECT**

![](_page_26_Picture_4.jpeg)

- Create a view that has the department name, manager name, and manager salary for every department.
- Create a view that has the project name, controlling department name, number of employees, and total hours worked per week on the project for each project.
- Create a view that has the project name, controlling department name, number of employees, and total hours worked per week on the project for each project with more than one employee working on it.

| Fname    | Minit | Lname   | Ssn       | Bdate      | Address                  | Sex | Salary | Super ssn | Dno |
|----------|-------|---------|-----------|------------|--------------------------|-----|--------|-----------|-----|
| John     | B     | Smith   | 123456789 | 1965-01-09 | 731 Fondren, Houston, TX | M   | 30000  | 333445555 | 5   |
| Franklin |       | Wong    | 333445555 | 1955-12-08 | 638 Voss, Houston, TX    | M   | 40000  | 888665555 | 5   |
| Alicia   |       | Zelaya  | 999887777 | 1968-01-19 | 3321 Castle, Spring, TX  | F   | 25000  | 987654321 | 4   |
| Jennifer | S     | Wallace | 987654321 | 1941-06-20 | 291 Berry, Bellaire, TX  | F   | 43000  | 888665555 | 4   |
| Ramesh   | K     | Narayan | 666884444 | 1962-09-15 | 975 Fire Oak, Humble, TX | M   | 38000  | 333445555 | 5   |
| Joyce    | A     | English | 453453453 | 1972-07-31 | 5631 Rice, Houston, TX   | F   | 25000  | 333445555 | 5   |
| Ahmad    | V     | Jabbar  | 987987987 | 1969-03-29 | 980 Dallas, Houston, TX  | M   | 25000  | 987654321 | 4   |
| James    | E     | Borg    | 888665555 | 1937-11-10 | 450 Stone, Houston, TX   | M   | 55000  | INULL     | 1   |

| Dname          | Dnumber | Mgr_ssn   | Mgr_start_date |  |
|----------------|---------|-----------|----------------|--|
| Research       | 5       | 333445555 | 1988-05-22     |  |
| Administration | য       | 987654321 | 1995-01-01     |  |
| Headquarters   | 1       | 888665555 | 1981-06-19     |  |

| DEPT_LOCATIONS |  |
|----------------|--|
|----------------|--|

| Dnumber | Dlocation |  |  |
|---------|-----------|--|--|
| 1       | Houston   |  |  |
| 4       | Stafford  |  |  |
| 5       | Bellaire  |  |  |
| 5       | Sugarland |  |  |
| 5       | Houston   |  |  |

| l u<br>p<br>er<br>so<br>na | se<br>on | ly |
|----------------------------|----------|----|
|                            |          |    |

| Pname           | Pnumber | Plocation | Dnum |  |
|-----------------|---------|-----------|------|--|
| ProductX        | 1       | Bellaire  | 5    |  |
| ProductY        | 2       | Sugarland | 5    |  |
| ProductZ        | 3       | Houston   | 5    |  |
| Computerization | 10      | Stafford  | 4    |  |
| Reorganization  | 20      | Houston   | 1    |  |
| Newbenefits     | 30      | Stafford  | র্ব  |  |

|  |  | 66<br>0 |
|--|--|---------|
|  |  |         |
|  |  |         |
|  |  |         |

Consider the following view v\_DEPT\_SUMMARY defined on the COMPANY database:

**CREATE VIEW** v\_DEPT\_SUMMARY (DNO, COUNT\_EMPS, SUM\_SALARY, AVG\_SALARY) **AS SELECT** Dno, **COUNT**(\*), **SUM**(Salary), **AVG**(Salary) **FROM** EMPLOYEE **GROUPBY**Dno;

| Fname    | Minit | Lname   | Ssn       | Bdate      | Address                  | Sex | Salary | Super ssn | Dno |
|----------|-------|---------|-----------|------------|--------------------------|-----|--------|-----------|-----|
| John     | B     | Smith   | 123456789 | 1965-01-09 | 731 Fondren, Houston, TX |     | 30000  | 333445555 | 5   |
| Franklin |       | Wong    | 333445555 | 1955-12-08 | 638 Voss, Houston, TX    | M   | 40000  | 888665555 | 5   |
| Alicia   |       | Zelaya  | 999887777 | 1968-01-19 | 3321 Castle, Spring, TX  | E   | 25000  | 987654321 | 4   |
| Jennifer | S     | Wallace | 987654321 | 1941-06-20 | 291 Berry, Bellaire, TX  | F   | 43000  | 888665555 | 4   |
| Ramesh   | K     | Narayan | 666884444 | 1962-09-15 | 975 Fire Oak, Humble, TX | M   | 38000  | 333445555 | 5   |
| Joyce    | A     | English | 453453453 | 1972-07-31 | 5631 Rice, Houston, TX   | E   | 25000  | 333445555 | 5   |
| Ahmad    | V     | Jabbar  | 987987987 | 1969-03-29 | 980 Dallas, Houston, TX  | M   | 25000  | 987654321 | 4   |
| James    | E     | Borg    | 888665555 | 1937-11-10 | 450 Stone, Houston, TX   | M   | 55000  | NULL      | 1   |

| Dnumber<br>Dname |   | Mar ssn   | Mgr_start_date |  |  |
|------------------|---|-----------|----------------|--|--|
| Research         | 5 | 333445555 | 1988-05-22     |  |  |
| Administration   | ঘ | 987654321 | 1995-01-01     |  |  |
| Headquarters     | 1 | 888665555 | 1981-06-19     |  |  |

|  |  |  |  |  |  | DEPT_LOCATIONS |  |
|--|--|--|--|--|--|----------------|--|
|  |  |  |  |  |  |                |  |

| Dnumber | Dlocation |
|---------|-----------|
| 1       | Houston   |
| 4       | Stafford  |
| 5       | Bellaire  |
| 5       | Sugarland |
| 5       | Houston   |

| l u<br>p<br>er<br>so<br>na | se<br>on | ly |  |
|----------------------------|----------|----|--|
|                            |          |    |  |

|  | PROJECT |  |
|--|---------|--|
|  |         |  |

| Pname           | Pnumber | Plocation | Onum |  |
|-----------------|---------|-----------|------|--|
| ProductX        | 1       | Bellaire  | 5    |  |
| ProductY        | 2       | Sugarland | 5    |  |
| ProductZ        | 3       | Houston   | 5    |  |
| Computerization | 10      | Stafford  | র্ব  |  |
| Reorganization  | 20      | Houston   | 1    |  |
| Newbenefits     | 30      | Stafford  | ব    |  |

|  |  | 66<br>1 |
|--|--|---------|
|  |  |         |
|  |  |         |
|  |  |         |

Describe the semantics oft he following SQL -statements. State which of the following queries and updates would be allowed on the view. If a query or update would be allowed, show what the corresponding query or update on the base relations would look like, and give its result when applied to the database.

- **1. SELECT \* FROM** v\_DEPT\_SUMMARY**;**
- **2. SELECT** DNO, COUNT\_EMPS **FROM** v\_DEPT\_SUMMARY **WHERE** SUM\_SALARY > 100000;
- **3. SELECT** DNO, AVG\_SALARY **FROM** v\_DEPT\_SUMMARY **WHERE** COUNT\_EMPS >

**(SELECT** COUNT\_EMPS **FROM** v\_DEPT\_SUMMARY **WHERE** DNO=4);

- **4. UPDATE** v\_DEPT\_SUMMARY **SET** DNO=3 **WHERE** DNO=4;
- **5. DELETE FROM** v\_DEPT\_SUMMARY **WHERE** COUNT\_EMPS > 4;

![](_page_29_Picture_8.jpeg)

- **CREATE VIEW** v\_DEPT\_SUMMARY (DNO, COUNT\_EMPS, SUM\_SALARY, AVG\_SALARY) **AS SELECT** Dno, **COUNT**(\*), **SUM**(Salary), **AVG**(Salary) **FROM** EMPLOYEE **GROUPBY**Dno;
- **1. SELECT \* FROM** v\_DEPT\_SUMMARY**;**

- **2. SELECT** DNO, COUNT\_EMPS **FROM** v\_DEPT\_SUMMARY **WHERE** SUM\_SALARY > 100000;
- **3. SELECT** DNO, AVG\_SALARY **FROM** v\_DEPT\_SUMMARY **WHERE** COUNT\_EMPS >

**(SELECT** COUNT\_EMPS **FROM** v\_DEPT\_SUMMARY **WHERE** DNO=4);

- **4. UPDATE** v\_DEPT\_SUMMARY **SET** DNO=3 **WHERE** DNO=4;
- **5. DELETE FROM** v\_DEPT\_SUMMARY **WHERE** COUNT\_EMPS > 4;

| Fname    | Minit | Lname   | Ssn       | Bdate      | Address                  | Sex | Salary | Super_ssn | Dno |
|----------|-------|---------|-----------|------------|--------------------------|-----|--------|-----------|-----|
| John     | B     | Smith   | 123456789 | 1965-01-09 | 731 Fondren, Houston, TX | M   | 30000  | 333445555 | 5   |
| Franklin |       | Wong    | 333445555 | 1955-12-08 | 638 Voss, Houston, TX    | M   | 40000  | 888665555 | 5   |
| Alicia   | J     | Zelaya  | 999887777 | 1968-01-19 | 3321 Castle, Spring, TX  | F   | 25000  | 987654321 | 4   |
| Jennifer | S     | Wallace | 987654321 | 1941-06-20 | 291 Berry, Bellaire, TX  | F   | 43000  | 888665555 | 4   |
| Ramesh   | K     | Narayan | 666884444 | 1962-09-15 | 975 Fire Oak, Humble, TX | M   | 38000  | 333445555 | 5   |
| Joyce    | A     | English | 453453453 | 1972-07-31 | 5631 Rice, Houston, TX   | B   | 25000  | 333445555 | 5   |
| Ahmad    | V     | Jabbar  | 987987987 | 1969-03-29 | 980 Dallas, Houston, TX  | M   | 25000  | 987654321 | 4   |
| James    | E     | Borg    | 888665555 | 1937-11-10 | 450 Stone, Houston, TX   | M   | 55000  | INULL     | 1   |

| Dname          | Dnumber | Mgr_ssn   | Mgr_start_date |  |
|----------------|---------|-----------|----------------|--|
| Research       | 5       | 333445555 | 1988-05-22     |  |
| Administration | বা      | 987654321 | 1995-01-01     |  |
| Headquarters   | 1       | 888665555 | 1981-06-19     |  |

| Dnumber | Dlocation |  |  |
|---------|-----------|--|--|
| 1       | Houston   |  |  |
| বা      | Stafford  |  |  |
| 5       | Bellaire  |  |  |
| 5       | Sugarland |  |  |
| 5       | Houston   |  |  |

|      | Essn      | Pno | Hours |           |       | Pname           |     | Pnumber | Plocation  |      |
|------|-----------|-----|-------|-----------|-------|-----------------|-----|---------|------------|------|
|      | 123456789 | 1   | 32.5  |           |       | ProductX        |     | 1       | Bellaire   |      |
|      | 123456789 | 2   | 7.5   |           |       | ProductY        |     | 2       | Sugarland  |      |
|      | 666884444 | 3   | 40.0  |           |       | ProductZ        |     | 3       | Houston    |      |
|      | 453453453 | 1   | 20.0  |           |       | Computerization |     | 10      | Stafford   |      |
|      | 453453453 | 2   | 20.0  |           |       | Reorganization  |     | 20      | Houston    |      |
|      | 333445555 | 2   | 10.0  |           |       | Newbenefits     |     | 30      | Stafford   |      |
|      | 333445555 | 3   | 10.0  |           |       |                 |     |         |            |      |
|      | 333445555 | 10  | 10.0  | DEPENDENT |       |                 |     |         |            |      |
|      | 333445555 | 20  | 10.0  | Essn      |       | Dependent name  | Sex | Bdate   |            | Rel: |
|      | 999887777 | 30  | 30.0  | 333445555 | Alice |                 | F   |         | 1986-04-05 | Da   |
|      | 999887777 | 10  | 10.0  | 333445555 |       | Theodore        | M   |         | 1983-10-25 | So   |
|      | 987987987 | 10  | 35.0  | 333445555 | Joy   |                 | E   |         | 1958-05-03 | Sp   |
|      | 987987987 | 30  | 5.0   | 987654321 | Abner |                 | M   |         | 1942-02-28 | Sp   |
| =4); | 987654321 | 30  | 20.0  | 123456789 |       | Michael         | M   |         | 1988-01-04 | So   |
|      | 987654321 | 20  | 15.0  | 123456789 | Alice |                 | E   |         | 1988-12-30 | Da   |
|      | 888665555 | 20  | NULL  | 123456789 |       | Elizabeth       | F   |         | 1967-05-05 | Sp   |
|      |           |     |       |           |       |                 |     |         |            |      |

![](_page_30_Picture_16.jpeg)

**Databases, © Ulrike Herster, partially © Elmasri "Fundamentals of Database Systems – For personal use only**

# **ORGANIZATION OUR JOURNEY IN THIS SEMESTER**

![](_page_31_Picture_1.jpeg)

- Integrity, Trigger & Security
- Database Applications
- **Transactions**
- Subqueries & Views
- More SQL
- Notations & Guidelines
- Constraints
- Relationships
- Simple Entities and Attributes
- Basics

664 Source: Foto von Justin Kauffman auf Unsplash

![](_page_31_Picture_13.jpeg)

# **TRANSACTIONS BASICS**

- A transaction bundles several operations into one logical unit
	- Unit of Work

- Includes one or more database access operations E.g., **INSERT**, **DELETE**, **UPDATE**, **SELECT**
- Operations must be executed all or none
- Example: Order a hotel room over the internet
	- Choose and reserve room
	- Payment
	- Final booking of the hotel room

![](_page_32_Picture_9.jpeg)

# **TRANSACTIONS BASICS**

 DBMS allow

- many users &
- concurrent access
- May lead to funny results if actions interfere
- Example:
	- Donald and Daisy withdraw money from their shared bank account

![](_page_33_Picture_7.jpeg)

![](_page_33_Picture_8.jpeg)

## **TRANSACTIONS BASICS - DBMS LANGUAGES: SQL - TCL**

![](_page_34_Figure_1.jpeg)

**TCL** for performing or rollbacking of changes in the database that we made using DML commands

- **SET TRANSACTION**
- **COMMIT** To persist the changes made by DML commands in database
- **ROLLBACK** To rollback the changes made to the database
- **SAVEPOINTS**

### Source: https://beginnersbook.com 667

![](_page_34_Picture_8.jpeg)

# **TRANSACTIONS ACID**

- Key features of transactions
	- *Atomicity*: Transaction is executed in whole or not at all
	- *Consistency*: State of the DB is consistent before and after a transaction
	- *Isolation*: Transactions do not interfere with other concurrent transactions
	- *Durability*: Changes are stored permanently in the database and will not get lost

![](_page_35_Picture_6.jpeg)

## **TRANSACTIONS ACID - ATOMICITY**

- A transaction can consist of many operations
	- **SELECT**

- **INSERT**, **UPDATE**, **DELETE**
- Note: statements for data definition (e.g., **CREATE TABLE**) usually outside transaction!
- Single operations are always atomic
	- Not trivial when looking at the implementation!
- In a transaction, all operations or none are performed

![](_page_36_Picture_8.jpeg)

## **TRANSACTIONS ACID - ATOMICITY**

- Begin of Transaction (*BoT*)
	- SQL99: **START TRANSACTION**
	- Oracle: transaction is started automatically
- Commit a transaction: **COMMIT;**
	- All operations are made persistent
	- All changes are visible to other users
- Rollback transaction: **ROLLBACK;**
	- DB is in state at *BoT* again

![](_page_37_Picture_9.jpeg)

## **TRANSACTIONS ACID - ATOMICITY**

## Autocommit

- On some systems:
- Single operations are committed automatically
- Called **autocommit** mode
- May be turned off
	- ... by disabling it
	- ... by explicitly starting a transaction
	- Note: Method depends on the system!

![](_page_38_Picture_9.jpeg)

## **TRANSACTIONS ACID - CONSISTENCY**

- DB: in consistent state before transaction Also, in consistent state after transaction
- Integrity constraints assure that
- Constraints can be defined as
	- **IMMEDIATE** (default in mySQL)
		- are checked immediately after operation
	- **DEFERRED**

Check at time of commit

![](_page_39_Picture_8.jpeg)

**Databases, © Ulrike Herster, partially © Elmasri "Fundamentals of Database Systems – For personal use only**

![](_page_39_Picture_10.jpeg)

## **TRANSACTIONS ACID - CONSISTENCY**

Example: Employee Department If the relationship "*employee works in department*" is mandatory, so that an employee should only exist, if he/she is working in a department, then how can that be assured? We must introduce a deferred constraint!

In Oracle: … **FOREIGN KEY** (A) **REFERENCES** TAB1(A) **DEFERRABLE INITIALLY DEFEREED**

![](_page_40_Picture_3.jpeg)

673

## **TRANSACTIONS ACID - CONSISTENCY**

Example: Employee Department

If the relationship "*employee works in department*" is mandatory, 

so that an employee should only exist, if he/she is working in a department, 

then how can that be assured? 

 We must introduce a deferred constraint!

In mySQL: Alternative solution

![](_page_41_Picture_7.jpeg)

![](_page_41_Picture_8.jpeg)

## **TRANSACTIONS ACID - ISOLATION**

- Transactions are isolated from other concurrent transactions
- Concurrent transactions shall behave well

![](_page_42_Picture_3.jpeg)

![](_page_42_Picture_4.jpeg)

## **TRANSACTIONS ACID – ISOLATION: CONCURRENCY CONTROL**

- Concurrent operations can lead to problems
	- Lost Update
	- Dirty Read

- Unrepeatable read
- Phantom tuples

![](_page_43_Picture_7.jpeg)

# **TRANSACTIONS**

**ACID – ISOLATION: CONCURRENCY CONTROL – LOST UPDATE PROBLEM**

- Several transactions change the same value
- Example:

| T<br>i<br>m<br>e | T<br>t<br>i<br>1<br>r<br>a<br>n<br>s<br>a<br>c<br>o<br>n      | T<br>t<br>i<br>2<br>r<br>a<br>n<br>s<br>a<br>c<br>o<br>n      | A<br>t<br>i<br>l<br>r<br>c<br>e | P<br>i<br>r<br>c<br>e |
|------------------|---------------------------------------------------------------|---------------------------------------------------------------|---------------------------------|-----------------------|
| 1                | i<br>S<br>E<br>L<br>E<br>C<br>T<br>p<br>r<br>c<br>e           | ‐                                                             | P<br>e<br>n                     | 1                     |
| 2                | ‐                                                             | i<br>S<br>C<br>E<br>L<br>E<br>T<br>p<br>r<br>c<br>e           | E<br>r<br>a<br>s<br>e<br>r      | 2                     |
| 3                | i<br>U<br>P<br>D<br>A<br>T<br>E<br>5<br>p<br>r<br>c<br>e<br>= | ‐                                                             | R<br>l<br>u<br>e<br>r           | 3                     |
| 4                | ‐                                                             | i<br>U<br>P<br>D<br>A<br>T<br>E<br>6<br>p<br>r<br>c<br>e<br>= |                                 |                       |
| 5                | C<br>O<br>M<br>M<br>I<br>T                                    | ‐                                                             |                                 |                       |
| 6                | ‐                                                             | C<br>O<br>M<br>M<br>I<br>T                                    |                                 |                       |

**Databases, © Ulrike Herster, partially © Elmasri "Fundamentals of Database Systems – For personal use only**

![](_page_44_Picture_6.jpeg)

### **TRANSACTIONS ACID – ISOLATION: CONCURRENCY CONTROL – DIRTY READ (UNCOMMITED DEPENDECY PROBLEM)**

- Transaction reads temporary value
- Example:

| T<br>i<br>m<br>e | T<br>t<br>i<br>1<br>r<br>a<br>n<br>s<br>a<br>c<br>o<br>n      | T<br>t<br>i<br>2<br>r<br>a<br>n<br>s<br>a<br>c<br>o<br>n | A<br>t<br>i<br>l<br>r<br>c<br>e | P<br>i<br>r<br>c<br>e |
|------------------|---------------------------------------------------------------|----------------------------------------------------------|---------------------------------|-----------------------|
| 1                | i<br>S<br>C<br>E<br>L<br>E<br>T<br>p<br>r<br>c<br>e           | ‐                                                        | P<br>e<br>n                     | 1                     |
| 2                | ‐                                                             | i<br>S<br>E<br>L<br>E<br>C<br>T<br>p<br>r<br>c<br>e      | E<br>r<br>a<br>s<br>e<br>r      | 2                     |
| 3                | i<br>U<br>P<br>D<br>A<br>T<br>E<br>7<br>p<br>r<br>c<br>e<br>= | ‐                                                        | R<br>l<br>u<br>e<br>r           | 3                     |
| 4                |                                                               | i<br>S<br>C<br>E<br>L<br>E<br>T<br>p<br>r<br>c<br>e      |                                 |                       |
| 5                | R<br>O<br>L<br>L<br>B<br>A<br>C<br>K                          | ‐                                                        |                                 |                       |

 A dirty read (also uncommitted dependency) occurs when a transaction is allowed to read data from a row that has been modified by another running transaction and not yet committed

![](_page_45_Picture_5.jpeg)

![](_page_45_Picture_6.jpeg)

### **TRANSACTIONS ACID – ISOLATION: CONCURRENCY CONTROL – UNREPEATABLE READ**

- Transaction receives inconsistent value due to interfering transaction
- Credit account and debit account have to match with their values!
- Example:

| T<br>i<br>m<br>e | T<br>i<br>1<br>t<br>r<br>a<br>n<br>s<br>a<br>c<br>o<br>n                                     | T<br>i<br>2<br>t<br>r<br>a<br>n<br>s<br>a<br>c<br>o<br>n                                     |  |  |
|------------------|----------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------|--|--|
| 1                | d<br>i<br>S<br>C<br>t_<br>t<br>E<br>L<br>E<br>T<br>c<br>r<br>e<br>a<br>c<br>c<br>o<br>n<br>u | ‐                                                                                            |  |  |
| 2                | ‐                                                                                            | d<br>i<br>U<br>P<br>D<br>A<br>T<br>E<br>t_<br>t<br>c<br>r<br>e<br>a<br>c<br>c<br>o<br>u<br>n |  |  |
| 3                | ‐                                                                                            | d<br>b<br>i<br>U<br>P<br>D<br>A<br>T<br>E<br>t_<br>t<br>e<br>a<br>c<br>c<br>o<br>u<br>n      |  |  |
| 4                | ‐                                                                                            | C<br>O<br>M<br>M<br>I<br>T                                                                   |  |  |
| 5                | d<br>b<br>i<br>S<br>E<br>L<br>E<br>C<br>T<br>t_<br>t<br>e<br>a<br>c<br>c<br>o<br>u<br>n      | ‐                                                                                            |  |  |
| 6                | C<br>O<br>M<br>M<br>I<br>T                                                                   | ‐                                                                                            |  |  |

**Databases, © Ulrike Herster, partially © Elmasri "Fundamentals of Database Systems – For personal use only**

![](_page_46_Picture_6.jpeg)

# **TRANSACTIONS**

### **ACID – ISOLATION: CONCURRENCY CONTROL – PHANTOM PROBLEMS**

- When doing the same **SELECT** twice, new tuples may appear that are inserted by another transaction
- Basically, same problem as Unrepeatable Read

 Example:

| T<br>i<br>m<br>e | T<br>i<br>1<br>t<br>r<br>a<br>n<br>s<br>a<br>c<br>o<br>n | T<br>i<br>2<br>t<br>r<br>a<br>n<br>s<br>a<br>c<br>o<br>n                 |  |  |
|------------------|----------------------------------------------------------|--------------------------------------------------------------------------|--|--|
| 1                | S<br>E<br>L<br>E<br>C<br>T<br>t<br>a<br>m<br>o<br>u<br>n | ‐                                                                        |  |  |
| 2                | ‐                                                        | S<br>E<br>L<br>E<br>C<br>T<br>t<br>a<br>m<br>o<br>u<br>n                 |  |  |
| 3                | ‐                                                        | S<br>t<br>I<br>N<br>E<br>R<br>T<br>n<br>e<br>a<br>m<br>o<br>n<br>w_<br>u |  |  |
| 4                | ‐                                                        | C<br>O<br>M<br>M<br>I<br>T                                               |  |  |
| 5                | S<br>C<br>t<br>E<br>L<br>E<br>T<br>a<br>m<br>o<br>n<br>u | ‐                                                                        |  |  |
| 6                | C<br>O<br>M<br>M<br>I<br>T                               | ‐                                                                        |  |  |

![](_page_47_Picture_6.jpeg)

![](_page_47_Picture_7.jpeg)

680

# **TRANSACTIONS**

**ACID – ISOLATION: CONCURRENCY CONTROL – ISOLATION LEVELS IN SQL**

 Lost Update is prevented by SQL

- Transactions: may choose *Isolation Level*
	- **SERIALIZABLE**

- no problems
- **REPEATABLE READ** (default in mySQL)
	- Open for phantom tuples
- **READ COMMITTED** (default in Oracle, SQL Server) Open for phantom tuples and unrepeatable read
- **READ UNCOMMITTED**
	- Open for all problems

![](_page_48_Picture_11.jpeg)

## **TRANSACTIONS ACID – ISOLATION: CONCURRENCY CONTROL – ISOLATION LEVELS IN SQL**

| Read phenomena<br>Isolation level | Lost updates | Dirty reads | Non-repeatable reads | Phantoms    |
|-----------------------------------|--------------|-------------|----------------------|-------------|
| Read Uncommitted                  | may occur    | may occur   | may occur            | may occur   |
| Read Committed                    | may occur    | don't occur | may occur            | may occur   |
| Repeatable Read                   | don't occur  | don't occur | don't occur          | may occur   |
| Serializable                      | don't occur  | don't occur | don't occur          | don't occur |

Source: https://en.wikipedia.org/wiki/Isolation\_(database\_systems)

![](_page_49_Picture_3.jpeg)

Source: https://www.youtube.com/ watch?v=xR70UlE\_xbo

![](_page_49_Picture_5.jpeg)

### **TRANSACTIONS ACID – ISOLATION: CONCURRENCY CONTROL – ISOLATION LEVELS IN SQL**

![](_page_50_Picture_1.jpeg)

Source: https://www.bitesizedengineering.com/p/

database-isolation-levels-explained

**Databases, © Ulrike Herster, partially**

## **TRANSACTIONS ACID – ISOLATION: CONCURRENCY CONTROL – ISOLATION LEVELS IN SQL**

- Isolation levels can be set
- Syntax:

```
SET TRANSACTION < transaction_mode > [, …]
<transaction_mode> ::= ISOLATION LEVEL {
                            SERIALIZABLE |
                             REPEATABLE READS |
                             READ COMMIT |
                             READUNCOMMITED}
```
Transactions can be *read only* if it contains only retrieval operations

![](_page_51_Picture_5.jpeg)

684

# **TRANSACTIONS**

### **ACID – ISOLATION: CONCURRENCY CONTROL – IMPLEMENTATION**

## Locks

- Read Lock (share)
- Write Lock (exclusive)
- Locks may hold for
	- Row
	- Table
	- Also: Memory page, Disk block

![](_page_52_Picture_9.jpeg)

![](_page_52_Picture_10.jpeg)

## **TRANSACTIONS ACID – ISOLATION: CONCURRENCY CONTROL – IMPLEMENTATION**

### Deadlocks may occur!!!

 Usually are resolved automatically by aborting one transaction

![](_page_53_Figure_3.jpeg)

Source: https://blog.nodeswat.com/concurrency-mysql-andnode-js-a-journey-of-discovery-31281e53572e

![](_page_53_Picture_5.jpeg)

### **TRANSACTIONS ACID – ISOLATION: CONCURRENCY CONTROL – IMPLEMENTATION**

- Multiversion Concurrency Control
	- Transactions see state of the database at *BoT* (begin of transaction)
	- Can reduce number of locks
	- DB has to store different versions of tuples
- Example:

| T<br>i<br>m<br>e | O<br>b<br>j<br>1<br>t<br>e<br>c                 | O<br>b<br>j<br>2<br>t<br>e<br>c                               | O<br>b<br>j<br>3<br>t<br>e<br>c                           |
|------------------|-------------------------------------------------|---------------------------------------------------------------|-----------------------------------------------------------|
| 0                | "F<br>"<br>b<br>T<br>1<br>o<br>o<br>y           | "B<br>"<br>b<br>T<br>1<br>a<br>r<br>y                         |                                                           |
| 1                | "H<br>l<br>l<br>"<br>b<br>T<br>2<br>e<br>o<br>y |                                                               |                                                           |
| 2                |                                                 | (<br>d<br>l<br>d<br>)<br>b<br>T<br>3<br>t<br>e<br>e<br>e<br>y | "F<br>B<br>"<br>b<br>T<br>3<br>o<br>o<br>a<br>r<br>y<br>- |
|                  |                                                 |                                                               |                                                           |

Source: https://en.wikipedia.org/wiki/Multiversion\_concurrency\_control

 Conceptually similar to Subversion or Git

**Databases, © Ulrike Herster, partially © Elmasri "Fundamentals of Database Systems – For personal use only**

![](_page_54_Picture_10.jpeg)

![](_page_54_Picture_11.jpeg)

## **TRANSACTIONS ACID - DURABILITY**

- Once committed, changed data is safe
- Error types
	- 1. Computer failure
	- 2. Transaction or system error (constraint violation, ௫, blackout, system crash)
	- 3. Local Errors
	- 4. Concurrency control enforcement
	- 5. Disk error (harddisk broken)
	- 6. Physical problems and catastrophes (fire, earthquake, robbery, ...)

688 Source: Elmasri, Fundamentals of Database Systems, Page 750ff

![](_page_55_Picture_10.jpeg)

![](_page_55_Picture_11.jpeg)

## **TRANSACTIONS ACID – DURABILITY: ERROR HANDLING**

- Recovery from transaction failures usually means that the database is *restored* to the most recent consistent state just before the time of failure
- Minor damages due to error types 1-4 from slide "ACID – Durability"
	- DBMS provides handling

- Recovery strategy is to identify any changes that may cause an inconsistency in the database
	- Changes are first written to redo logs (files on disk)
	- Written to database files after commit

689 Source: Elmasri, Fundamentals of Database Systems, Page 808ff

![](_page_56_Picture_8.jpeg)

![](_page_56_Picture_9.jpeg)

## **TRANSACTIONS ACID – DURABILITY: ERROR HANDLING**

 Extensive damage due to error types 5-6 from slide "ACID – Durability"

- recovery handling restores a past copy of the database from archival storage
- reconstructs a more current state by redoing the operations
- Last transactions are lost!
- Solution: Redundancy
	- RAID

(**r**edundant **a**rray of **i**ndependent **d**isks)

Data Replication by DBMS

> 690 Source: Elmasri, Fundamentals of Database Systems, Page 808ff

![](_page_57_Picture_10.jpeg)

![](_page_57_Picture_11.jpeg)

## **TRANSACTIONS ACID – DURABILITY: ERROR HANDLING – DATA REPLICATION**

- Changes are performed on (replicated to) several database instances
	- Master/Slave

- Updates only on one instance (master)
- Slave: Read only vs. Standby
- Multi-Master

**Databases, © Ulrike Herster, partially**

 Updates on different instances

 Needs conflict resolution strategy

![](_page_58_Figure_8.jpeg)

![](_page_58_Picture_9.jpeg)

## **TRANSACTIONS ACID – DURABILITY: ERROR HANDLING – DATA REPLICATION: SYNC VS. ASYNC**

## *Synchronous*

- Transaction valid only when committed on all DBs
- Safest, but performance impact
- May reduce availability of the system

## *Asynchronous*

 Transaction valid when committed locally

![](_page_59_Picture_7.jpeg)

**Databases, © Ulrike Herster, partially © Elmasri "Fundamentals of Database Systems – For personal use only**

![](_page_59_Picture_9.jpeg)

## **TRANSACTIONS ACID – DURABILITY: ERROR HANDLING – DATA REPLICATION METHODS**

![](_page_60_Picture_1.jpeg)

- Low level (disk device)
- Trigger based
	- Update triggers the replication (SQL level)
- Logfile shipping
	- Changes are stored in redo logs (as usual)
	- redo logs are copied to standby DB

![](_page_60_Picture_8.jpeg)

**Databases, © Ulrike Herster, partially © Elmasri "Fundamentals of Database Systems – For personal use only**

# **TRANSACTIONS**

**ACID – DURABILITY: ERROR HANDLING – DATA REPLICATION METHODS**

## Oracle

Data Guard

> Replication on second server, can be used to answer

Read-Only queries

![](_page_61_Figure_6.jpeg)

Source: https://docs.oracle.com/cd/B19306\_01/server.102/b14239/concepts.htm#i1033808

- Real Application Cluster (RAC)
	- Several servers share the same DB

**Databases, © Ulrike Herster, partially © Elmasri "Fundamentals of Database Systems – For personal use only**

![](_page_61_Picture_11.jpeg)

# **TRANSACTIONS DISTRIBUTED TRANSACTIONS**

- Transactions not only in a single DBS
- Standardized by X/Open

- Transaction Manager: A software component that guarantees transaction properties
- Resource Manager:
- Every resource (e.g., DBS, GUI) that is able to work in a transactional mode without providing a transaction control structure itself

![](_page_62_Figure_6.jpeg)

 The Transaction manager coordinates the Resource Manager that take part in the transaction. E.g., different DBS (distributed transactions) that appear as one DBS from outside (transparency!) 695

![](_page_62_Picture_9.jpeg)

![](_page_62_Picture_10.jpeg)

# **TRANSACTIONS DISTRIBUTED TRANSACTIONS**

 To ensure interoperability between the participating resource managers the *2-phase commit protocol*  is realized

![](_page_63_Figure_2.jpeg)

- It defines the final synchronization of different parts of a transaction of a global transaction
- In the first phase the transaction manager asks participating resource managers to announce the results of their local transaction part
- This leads to a global result (commit or rollback) that is then in the second phase announced to the participants

696 Source: https://medium.com/@balrajasubbiah/ consensus-two-phase-and-three-phasecommits-4e35c1a435ac

![](_page_63_Picture_7.jpeg)

![](_page_64_Picture_1.jpeg)

- There are operations that may be expensive to execute time consuming
- If certain constraints fail within transaction execution, then maybe these constraints may not fail in a second attempt (e.g., time dependent)
- So "fall back" points can be defined, which are called *savepoints*
- It is possible to rollback up to a savepoint and restart transaction execution from this point on

![](_page_64_Picture_6.jpeg)

# **TRANSACTIONS SAVEPOINTS**

![](_page_65_Picture_1.jpeg)

## Example:

|         |                                 |                  |     |         |                                 |                  | Sarepoint<br>2 |
|---------|---------------------------------|------------------|-----|---------|---------------------------------|------------------|----------------|
| STUDENT |                                 |                  |     | STUDENT |                                 |                  |                |
|         | STUDENT ID STUDENT NAME Address |                  | Age |         | STUDENT ID STUDENT NAME Address |                  | Age            |
|         | 100 Joseph                      | Troy             | 22  |         | 100 Joseph                      | Troy             | 22             |
|         | 101 Mahtwe                      | Lakeside Village | 23  |         | 101 Mathew                      | Lakeside Village | 22             |
|         | 102 Jacob                       | Fraser Town      | 22  |         | 102 Jacob                       | Fraser Town      | 22             |

![](_page_65_Figure_6.jpeg)

698 Source: https://www.tutorialcup.com/ dbms/transaction-control-language.htm

![](_page_65_Picture_9.jpeg)