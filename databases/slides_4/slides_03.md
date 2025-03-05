![](_page_0_Picture_0.jpeg)

Source: https://en.itpedia.nl/2017/11/26/wat-is-een-database/

**DATABASES**

Prof. Dr. Ulrike Herster Hamburg University of Applied Sciences

![](_page_0_Picture_4.jpeg)

### **COPYRIGHT**

![](_page_1_Picture_1.jpeg)

The publication and sharing of slides, images and sound recordings of this course is not permitted

© Professor Dr. Ulrike Herster

The slides and assignments are protected by copyright. The use is only permitted in relation with the course of study. It is not permitted to forward or republish it in other places (e.g., on the internet).

**Databases, © Ulrike Herster, partially © Elmasri "Fundamentals of Database Systems – For personal use only** .

![](_page_1_Picture_6.jpeg)

## **ORGANIZATION OUR JOURNEY IN THIS SEMESTER**

![](_page_2_Picture_1.jpeg)

- Integrity, Trigger & Security
- Database Applications
- Transactions
- Subqueries & Views
- More Features
- Notations & Guidelines
- Constraints
- **Relationships**
- Simple Entities and Attributes
- Basics

215 Source: Foto von Justin Kauffman auf Unsplash

![](_page_2_Picture_13.jpeg)

## **RELATIONSHIPS DATABASE DESIGN**

![](_page_3_Figure_1.jpeg)

![](_page_3_Picture_2.jpeg)

![](_page_3_Picture_3.jpeg)

### **RELATIONSHIPS ERM: RELATIONSHIP TYPES**

- Describe relationships between entity types
- Characterized by a verb
	- Often 2 naming possibilities:
	- teaches vs. is taught by
	- Relationship has always two (or more) directions
- May have attributes
- Number of participating entity types (degree):
	- 1. Unary relationship type (e.g., Employee supervises another employee)
	- 2. Binary relationship type (e.g., Employee works for one department)
	- 3. Ternary relationship type (e.g., Lecturer recommends books for one specific course)
	- 4. Higher degrees...

![](_page_4_Picture_12.jpeg)

### **RELATIONSHIPS ERM: RELATIONSHIP TYPES**

- Each relationship instance in R is an association of entities, where the association includes exactly one entity from each participating entity type
- In an ERM, relationship types are displayed as diamond-shaped boxes, which are connected by straight lines to the entity types

![](_page_5_Figure_3.jpeg)

218 Source: Elmasri, Fundamentals of Database Systems, Page 212 ff

### **RELATIONSHIPS ERM: RELATIONSHIP TYPES**

### Entity Type

- Represented as rectangle in ERM
- Singular noun
- Attribut Type
	- Represented as ovals
	- Noun
- Relationship Type
	- Represented as diamond in ERM
	- Always between entity types
	- Verb
	- Has cardinalities

![](_page_6_Picture_12.jpeg)

NOUN

Attribute

VERB

![](_page_6_Picture_13.jpeg)

### **RELATIONSHIPS ERM: EXAMPLE - COMPANY**

![](_page_7_Figure_1.jpeg)

#### **RELATIONSHIPS ERM: RELATIONSHIP TYPES - ABSTRACTION**

![](_page_8_Figure_1.jpeg)

**Databases, © Ulrike Herster, partially © Elmasri "Fundamentals of Database Systems – For personal use only**

#### **RELATIONSHIPS ERM: RELATIONSHIP TYPES – ROLE NAMES**

 The **role name** signifies the role that a participating entity from the entity type plays in each relationship instance, and helps to explain what the relationship means

![](_page_9_Picture_2.jpeg)

#### **RELATIONSHIPS ERM: RELATIONSHIP TYPES – RECURSIVE RELATIONSSHIP TYPES**

- In some cases, the same entity type participates more than once in a relationship type in different roles
- In such cases the **role name** becomes essential for distinguishing the meaning of the role that each participating entity plays
- Such relationship types are called **recursive relationship types**

![](_page_10_Picture_4.jpeg)

### **RELATIONSHIPS ERM: EXAMPLE - COMPANY**

![](_page_11_Figure_1.jpeg)

### **RELATIONSHIPS ERM: RELATIONSHIP TYPES – EXAMPLE**

Example: Employee in 2 roles 

- Supervisor (boss) role name 1
- Supervisee (subordinate) role name 2

![](_page_12_Figure_4.jpeg)

**Databases, © Ulrike Herster, partially © Elmasri "Fundamentals of Database Systems – For personal use only**

225 Source: Elmasri, Fundamentals of Database Systems, Page 212 ff

 Cardinality

- Specifies the maximum number of relationship instances that an entity can participate in
- Cardinality ratios
	- 1:1
	- 1:N
	- M:N
- Cardinality ratios for binary relationships are represented on ER diagrams by displaying 1, M, and N on the diamonds
- Notice that in this notation, we can either specify no maximum (N) or a maximum of one (1) on participation

![](_page_13_Picture_9.jpeg)

### **RELATIONSHIPS ERM: EXAMPLE - COMPANY**

![](_page_14_Figure_1.jpeg)

### Cardinality

- (min,max) Notation
- Example
	- A car has at least 3 and at most 5 wheels Every wheel is associated to exactly one car

![](_page_15_Figure_5.jpeg)

- Attention: In UML, (min,max) is placed on the opposite sites!
- Problem: General case cannot be easily implemented in RDBMS

![](_page_15_Picture_8.jpeg)

 Other notations (e.g., in tools like draw.io)

![](_page_16_Figure_2.jpeg)

**Databases, © Ulrike Herster, partially © Elmasri "Fundamentals of Database Systems – For personal use only**

![](_page_16_Picture_4.jpeg)

### Participation

- Specifies whether the existence of an entity depends on its being related to another entity via the relationship type
- Also called *minimum cardinality constraint*
- Two types

- Total: every entity in the total set of all entities of an entity type A must be related to an entity of entity type B via a relationship
	- Total participation is also called *existence dependency*
		- Is displayed as a double line connecting the participating entity type to the relationship
- Partial: some or part of the entities of an entity type A are related to some entities of an entity type B via a relationship
	- Is displayed by a single line connecting the participating entity type to the relationship230

![](_page_17_Picture_10.jpeg)

![](_page_17_Picture_11.jpeg)

### Cardinality

specifies the maximum number of relationship instances that an entity can participate in

### Participation

 specifies if the existence of an entity depends on its being related to another entity via the relationship type

*minimum cardinality constraint*

![](_page_18_Picture_6.jpeg)

231

### **RELATIONSHIPS ERM: EXAMPLE - COMPANY**

![](_page_19_Figure_1.jpeg)

### **RELATIONSHIPS ERM: RELATIONSHIP TYPES – ATTRIBUTES**

- Relationship types can also have attributes
- Notice that attributes of 1:1 or 1:N relationship types can be migrated to one of the participating entity types
- For M:N relationship types, some attributes may be determined by the combination of participating entities in a relationship instance, not by any single entity Such attributes must be specified as relationship attributes

![](_page_20_Picture_4.jpeg)

### **RELATIONSHIPS ERM: EXAMPLE - COMPANY**

![](_page_21_Figure_1.jpeg)

#### **RELATIONSHIPS ERM: RELATIONSHIP TYPES – HOW TO DEFINE THEM?**

- Relationship between entity types
- Good naming
- More than one relationship?
	- Maybe different meanings, roles
	- Example for role: Supervisor, Supervisee
- Cardinalities
- Mandatory/optional
- Attributes for Relationship Type?

![](_page_22_Picture_9.jpeg)

## **RELATIONSHIPS DATABASE DESIGN**

![](_page_23_Figure_1.jpeg)

![](_page_23_Picture_3.jpeg)

# **RELATIONSHIPS RM: CONSTRAINTS**

Three categories

- 1. Constraints that are inherent in the data model *inherent model-based constraints* or *implicit constraints* Example: no duplicate tuples in a relation
- 2. Constraints that can be directly expressed in schemas of the data model *schema-based constraints* or *explicit constraints* Example: Domain constraints, primary key (entity integrity constraints), constraints on NULL, and **referential integrity constraints**
- 3. Constraints that cannot be directly expressed in the schemas of the data model, and hence must be expressed and enforced by the application programs *application-based* or *semantic constraints* or *business rules*

237 Source: Elmasri, Fundamentals of Database Systems, Page 59ff

![](_page_24_Picture_6.jpeg)

![](_page_24_Picture_7.jpeg)

### **RELATIONSHIPS RM: CONSTRAINTS – REFERENTIAL INTEGRITY CONSTRAINT**

- It is defined between two relations
- It is used to maintain the consistency among tules in the two relations: a tuple in one relation that refers to another relation must refer to an existing tuple in that relation
- *Foreign key*: a set of attributes FK in relation schema ଵ is a foreign key of ଵ that references relation ଶ if it satisfies the following rules:
	- 1. The attributes in FK have the same domain(s) as the primary key attributes PK of ଶ ; the attributes FK are said to *reference* or *refer to* the relation ଶ
	- 2. A value of FK in a tuple ଵ of the current state ଵሺଵሻ either occurs as a value of PK for some tuple ଶ in the current state ଶሺଶሻ or is NULL. In the former case, we have ଵ ൌ ଶ , and we say that the tuple ଵ references or refers to the tuple ଶ

238 Source: Elmasri, Fundamentals of Database Systems, Page 59ff

![](_page_25_Picture_8.jpeg)

### **RELATIONSHIPS RM: CONSTRAINTS – REFERENTIAL INTEGRITY CONSTRAINT**

 A foreign key can refer to its own relation

 Foreign keys are depicted with a directed arrow The arrowheadmaypointtotheprimarykey

 All integrity constraints can be defined with the DDL, thus the DBMS can automatically enforce them

![](_page_26_Picture_4.jpeg)

![](_page_26_Picture_5.jpeg)

![](_page_26_Picture_6.jpeg)

### **RELATIONSHIPS ERM: EXAMPLE - COMPANY**

![](_page_27_Figure_1.jpeg)

### **RELATIONSHIPS RM: CONSTRAINTS – EXAMPLE**

![](_page_28_Figure_1.jpeg)

241 Source: Elmasri, Fundamentals of Database Systems, Page 59ff

![](_page_28_Picture_3.jpeg)

### **RELATIONSHIPS RM: NOTATION OF FOREIGN KEYS WITHIN A RELATIONAL SCHEMA**

- There are several ways for the notation of relational schemas
	- especially for representing foreign keys, e.g.
	- Option 1:

- Foreign Keys can be represented with arrows
- This notation is used in the lecture slides and in the book "Fundamentals of Database Systems" from Elmasri and Navathe
- Advantage: Each FK-arrow connects the referencing attribute and referenced attribute, so the involved relations are obvious
- Option 2:

- Foreign Keys can be represented with addition (FK) within the referencing attribute
- This notation is used in the laboratory of Mr. Ocker
- Advantage: This notation is more readable for large, complex schemas
- Both notations are correct and may be used within the examination

![](_page_29_Picture_13.jpeg)

### **RELATIONSHIPS RM: NOTATION OF FOREIGN KEYS WITHIN A RELATIONAL SCHEMA**

#### Example: Some foreign Keys with option 1

![](_page_30_Figure_2.jpeg)

**Databases, © Ulrike Herster, partially © Elmasri "Fundamentals of Database Systems – For personal use only**

![](_page_30_Picture_4.jpeg)

### **RELATIONSHIPS RM: NOTATION OF FOREIGN KEYS WITHIN A RELATIONAL SCHEMA**

#### Example: Some foreign Keys with option 2

| E<br>M<br>P<br>L<br>O<br>Y<br>E<br>E           | F<br>n<br>a<br>m<br>e | M<br>i<br>i<br>t<br>L<br>n<br>n            | S<br>a<br>m<br>e<br>s<br>n                | B<br>d<br>t<br>a<br>e | A<br>d<br>d<br>r<br>e<br>s<br>s             | S<br>e<br>x      | S<br>l<br>a<br>a<br>r<br>y | S<br>u<br>p<br>e<br>r_<br>s<br>s<br>n | D<br>n<br>o |
|------------------------------------------------|-----------------------|--------------------------------------------|-------------------------------------------|-----------------------|---------------------------------------------|------------------|----------------------------|---------------------------------------|-------------|
|                                                |                       |                                            |                                           |                       |                                             |                  |                            |                                       |             |
| D<br>E<br>P<br>A<br>R<br>T<br>M<br>E<br>N<br>T | D<br>n<br>a<br>m<br>e | D<br>b<br>n<br>m<br>e<br>r<br>u            | M<br>(<br>g<br>r_<br>s<br>s<br>n          | F<br>K<br>)<br>M<br>g | d<br>t<br>t_<br>t<br>r_<br>s<br>a<br>r<br>a | e                |                            |                                       |             |
| D<br>E<br>P<br>T_                              |                       |                                            |                                           |                       |                                             |                  |                            |                                       |             |
| L<br>O<br>C<br>A<br>T<br>I<br>O<br>N<br>S      | D<br>b<br>n<br>u<br>m | (<br>F<br>K<br>)<br>D<br>l<br>e<br>r       | i<br>t<br>o<br>c<br>a<br>o<br>n           |                       |                                             |                  |                            |                                       |             |
|                                                |                       |                                            |                                           |                       |                                             |                  |                            |                                       |             |
| P<br>R<br>O<br>J<br>E<br>C<br>T                | P<br>n<br>a<br>m<br>e | P<br>b<br>n<br>m<br>e<br>r<br>u            | P<br>l<br>i<br>t<br>o<br>c<br>a<br>o<br>n | D<br>(<br>n<br>m<br>u | F<br>K<br>)                                 |                  |                            |                                       |             |
|                                                |                       |                                            |                                           |                       |                                             |                  |                            |                                       |             |
| W<br>O<br>R<br>K<br>S<br>O<br>N<br>_           | E<br>s<br>s<br>n      | P<br>(<br>F<br>K<br>)<br>n<br>o            | H<br>o<br>r<br>s<br>u                     |                       |                                             |                  |                            |                                       |             |
|                                                |                       |                                            |                                           |                       |                                             |                  |                            |                                       |             |
| D<br>E<br>P<br>E<br>N<br>D<br>E<br>N<br>T      | E<br>s<br>s<br>n      | D<br>d<br>t_<br>e<br>p<br>e<br>n<br>e<br>n | S<br>n<br>a<br>m<br>e<br>e<br>x           | B<br>d<br>t<br>a<br>e | R<br>l<br>i<br>t<br>e<br>a<br>o<br>n<br>s   | h<br>i<br>s<br>p |                            |                                       |             |
|                                                |                       |                                            |                                           |                       |                                             |                  |                            |                                       |             |

**Databases, © Ulrike Herster, partially © Elmasri "Fundamentals of Database Systems – For personal use only**

![](_page_31_Picture_4.jpeg)

### **RELATIONSHIPS RM: MAPPING OF ERM TO RELATIONAL MODEL**

### Seven Steps

- 1. Mapping of regular entity types
- 2. Mapping of weak entity types
- **3. Mapping of binary 1:1 relationships**
- **4. Mapping of binary 1:n relationships**
- **5. Mapping of binary m:n relationships**
- 6. Mapping of multivalued attributes
- 7. Mapping of n-ary relationships

245 Source: Elmasri, Fundamentals of Database Systems, Page 286ff

![](_page_32_Picture_10.jpeg)

- For each binary 1:1 relationship type R in the ER schema, identify the relations S and T that correspond to the entity types participating in R
- There are three possible approaches:
	- 1. The foreign key approach
	- 2. The merged relationship approach
	- 3. The cross-reference or relationship relation approach

![](_page_33_Picture_6.jpeg)

- 1. The foreign key approach
	- Choose one of the relations S and include as a foreign key in S the primary key of T
	- It is better to choose an entity type with total participation in R in the role of S
	- Include all the simple attributes (or simple components of composite attributes) of the 1:1 relationship type R as attributes of S

![](_page_34_Figure_5.jpeg)

![](_page_34_Picture_6.jpeg)

![](_page_35_Figure_1.jpeg)

- Mapping of relationship type MANAGES
	- DEPARTMENT serves as S
	- EMPLOYEE serves as T
- Attribute Ssn is renamed in Mgr\_ssn in DEPARTMENT
- Attribute Start\_date is renamed in Mgr\_start\_date in DEPARTMENT
- It is also possible to include primary key of S as foreign key in T
- For the mapping, a **UNIQUE-Constraint** must be used!!!
	- Otherwise, an employee could manage several departments!

248 Source: Elmasri, Fundamentals of Database Systems, Page 286ff

![](_page_35_Picture_11.jpeg)

 For the mapping, a **UNIQUE-Constraint** must be used!

![](_page_36_Figure_2.jpeg)

- 2. Merged relation approach
	- Merge the two entity types and the relationship into a single relation
	- This is possible when both participations are total, as this would indicate that the two tables will always have the exact same number of tuples

![](_page_37_Picture_4.jpeg)

**Databases, © Ulrike Herster, partially © Elmasri "Fundamentals of Database Systems – For personal use only**

250 Source: Elmasri, Fundamentals of Database Systems, Page 286ff

- 3. The cross-reference or relationship relation approach
	- Set up a third relation R for the purpose of cross-referencing the primary keys of the two relations S and T representing the entity types
	- This approach is required for binary M:N relationships
	- The relation R will include the primary key attributes of S and T as foreign keys to S and T
	- The primary key of R will be one of the two foreign keys, and the other foreign key will be a unique key of R

![](_page_38_Picture_6.jpeg)

251 Source: Elmasri, Fundamentals of Database Systems, Page 286ff

- For each regular binary 1:N relationship type R, identify the relation S that represents the participating entity type at the N-side of the relationship type
- Include as foreign key in S the primary key of the relation T that represents the other entity type participating in R
- Include any simple attributes (or simple components of composite attributes) of the 1:N relationship type as attributes of S
- An alternative approach: use the relationship relation and create a separate relation

**Databases, © Ulrike Herster, partially © Elmasri "Fundamentals of Database Systems – For personal use only** 252 Source: Elmasri, Fundamentals of Database Systems, Page 286ff

![](_page_40_Figure_1.jpeg)

![](_page_40_Picture_2.jpeg)

- Relationship type WORKS\_FOR: Attribute Dno as foreign key in EMPLOYEE
- Relationship type SUPERVISION: Attribute Super\_ssn as foreign key in EMPLOYEE
- Relationship type CONTROLS: Attribute Dnum as foreign key in PROJECT

253 Source: Elmasri, Fundamentals of Database Systems, Page 286ff

### **RELATIONSHIPS**

### **RM: 4. MAPPING OF BINARY 1:N RELATIONSHIPS - TOTAL PARTICIPATION**

Total and Partial Participation should be mapped as well

- For participation definitions on the "1" side, a constraint assures the requirement
	- Total Participation 1:m → NOT NULL on FK
	- Partial Participation "0:m" → NULL on FK
- For participation definitions on the "m" side, there is a problem
	- These types (1:n vs. "1:0n") are not distinguishable in Relational Model
	- These types of Total Participation cannot be implemented / enforced using SQL-DDL!

![](_page_41_Picture_9.jpeg)

- For each binary M:N relationship type R, create a new relation S to represent R
- Include as foreign key attributes in S the primary keys of the relations that represent the participating entity types; their combination will form the primary key of S
- Also include any simple attributes of the M:N relationship type (or simple components of composite attributes) as attributes of S
- Notice that a M:N relationship type can not be represented by a single foreign key attribute in one of the participating relations (as in 1:1 or 1:N relationship types) because of the M:N cardinality ratio

**Databases, © Ulrike Herster, partially © Elmasri "Fundamentals of Database Systems – For personal use only** 255 Source: Elmasri, Fundamentals of Database Systems, Page 286ff

**WORKS\_ON Essn Pno Hours**

- Attribute Ssn is renamed in Essn in WORKS\_ON
- Attribute Pname is renamed in Pno in DEPARTMENT
- Primary key is the combination {Essn, Pno}

![](_page_43_Figure_5.jpeg)

 Note: The existence dependency between EMPLOYEE and PROJECT should be specified on the foreign keys in the relation corresponding to the relationship R (ON UPDATE and ON DELETE)

![](_page_43_Picture_7.jpeg)

### **RELATIONSHIPS ERM: EXAMPLE - COMPANY**

![](_page_44_Figure_1.jpeg)

### **RELATIONSHIPS RM: EXAMPLE - COMPANY**

|  |  |  |  |  |  |  |  | Fname   Minit   Lname   Ssn   Bdate   Address   Sex   Salary   Super_ssn   Dno |  |
|--|--|--|--|--|--|--|--|--------------------------------------------------------------------------------|--|
|--|--|--|--|--|--|--|--|--------------------------------------------------------------------------------|--|

![](_page_45_Picture_9.jpeg)

![](_page_45_Picture_10.jpeg)

### **RELATIONSHIPS RM: ASSIGNMENT OFFICE - CONVERT THE ERD TO A RM**

 Departments, identified by ID, operate a variety of printers, each located in a particular room in a particular building. Printers are supplied by a number of suppliers, identified by name, with each supplier charging a different price for a given printer, but also providing different delivery delays, measured in days. A given room can have any number of printers, including none.

![](_page_46_Figure_2.jpeg)

### **RELATIONSHIPS RM: MAPPING OF ERM TO RELATIONAL MODEL**

### Seven Steps

3.

4.

5.

- 1. Mapping of regular entity types
- 2. Mapping of weak entity types
	- Mapping of binary 1:1 relationships
	- Mapping of binary 1:n relationships
	- Mapping of binary m:n relationships
- 6. Mapping of multivalued attributes
- 7. Mapping of n-ary relationships

260 Source: Elmasri, Fundamentals of Database Systems, Page 286ff

![](_page_47_Picture_10.jpeg)

## **RELATIONSHIPS DATABASE DESIGN**

![](_page_48_Figure_1.jpeg)

**Databases, © Ulrike Herster, partially © Elmasri "Fundamentals of Database Systems – For personal use only**

![](_page_48_Picture_3.jpeg)

- Referential integrity is specified via the **FOREIGN KEY**
- FK relates two tables
- Referenced table must exist already
- Referenced column must be **UNIQUE**
	- Best to use PK
	- If not PK: need to specify (column)

262 Source: Elmasri, Fundamentals of Database Systems, Page 88ff

![](_page_49_Picture_8.jpeg)

Syntax:

- As Column Constraint
	- Only if the foreign key is one single attribute (and not combined)

```
[CONSTRAINT < constraintname > ]
   REFERENCES < tablename >[( column )] [< action >]
```
 As Table Constraint

```
[CONSTRAINT < constraintname >]
   FOREIGN KEY (< column list >)
   REFERENCES < tablename >[(< column list >)]
           [< action >]
```
**Databases, © Ulrike Herster, partially © Elmasri "Fundamentals of Database Systems – For personal use only**

![](_page_50_Picture_8.jpeg)

Example column constraint:

#### **CREATE TABLE** Department

| (<br>D<br>n<br>a<br>m<br>e                                                                       | (<br>)<br>V<br>A<br>R<br>C<br>H<br>A<br>R<br>1<br>5 | N<br>O<br>T<br>N<br>U<br>L<br>L<br>,           |                                                               |   |  |  |
|--------------------------------------------------------------------------------------------------|-----------------------------------------------------|------------------------------------------------|---------------------------------------------------------------|---|--|--|
| b<br>D<br>n<br>m<br>e<br>r<br>u                                                                  | I<br>N<br>T                                         | N<br>O<br>T<br>N<br>U<br>L<br>L<br>,           |                                                               |   |  |  |
| M<br>g<br>r_<br>s<br>s<br>n                                                                      | (<br>)<br>C<br>H<br>A<br>R<br>9                     | R<br>E<br>F<br>E<br>R<br>E<br>N<br>C<br>E<br>S | (<br>)<br>l<br>E<br>S<br>m<br>p<br>o<br>e<br>e<br>s<br>n<br>y | , |  |  |
| d<br>M<br>t<br>t<br>t<br>g<br>r_<br>s<br>a<br>r<br>a<br>e<br>_                                   | D<br>A<br>T<br>E<br>,                               |                                                |                                                               |   |  |  |
| (<br>)<br>b<br>P<br>R<br>I<br>M<br>A<br>R<br>Y<br>K<br>E<br>Y<br>D<br>n<br>u<br>m<br>e<br>r<br>, |                                                     |                                                |                                                               |   |  |  |
| (<br>)<br>)<br>Q<br>U<br>N<br>I<br>U<br>E<br>D<br>n<br>a<br>m<br>e<br>;                          |                                                     |                                                |                                                               |   |  |  |

264 Source: Elmasri, Fundamentals of Database Systems, Page 88ff

![](_page_51_Picture_5.jpeg)

![](_page_51_Picture_6.jpeg)

Example table constraint:

#### **CREATE TABLE** Department

| (<br>D<br>n<br>a<br>m<br>e                                              | (<br>)<br>V<br>A<br>R<br>C<br>H<br>A<br>R<br>1<br>5      | N<br>O<br>T<br>N<br>U<br>L<br>L<br>,                                              |                                                                                                                                                                                                                                                                          |
|-------------------------------------------------------------------------|----------------------------------------------------------|-----------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| b<br>D<br>n<br>m<br>e<br>r<br>u                                         | I<br>N<br>T                                              | N<br>O<br>T<br>N<br>U<br>L<br>L<br>,                                              |                                                                                                                                                                                                                                                                          |
| M<br>g<br>r_<br>s<br>s<br>n                                             | (<br>)<br>C<br>H<br>A<br>R<br>9                          | N<br>O<br>T<br>N<br>U<br>L<br>L<br>,                                              |                                                                                                                                                                                                                                                                          |
| d<br>M<br>t<br>t<br>t<br>g<br>r_<br>s<br>a<br>r<br>a<br>e<br>_          | D<br>A<br>T<br>E<br>,                                    |                                                                                   |                                                                                                                                                                                                                                                                          |
| (<br>P<br>R<br>I<br>M<br>A<br>R<br>Y<br>K<br>E<br>Y<br>D<br>n<br>u<br>m | )<br>b<br>e<br>r<br>,                                    |                                                                                   |                                                                                                                                                                                                                                                                          |
| (<br>)<br>Q<br>U<br>N<br>I<br>U<br>E<br>D<br>n<br>a<br>m<br>e<br>,      |                                                          |                                                                                   |                                                                                                                                                                                                                                                                          |
| (<br>O<br>G<br>F<br>R<br>E<br>I<br>N<br>K<br>E<br>Y<br>M<br>g<br>r_     | )<br>C<br>R<br>E<br>F<br>E<br>R<br>E<br>N<br>s<br>s<br>n | (<br>)<br>)<br>l<br>S<br>S<br>E<br>E<br>m<br>p<br>o<br>y<br>e<br>e<br>s<br>n<br>; |                                                                                                                                                                                                                                                                          |
|                                                                         |                                                          |                                                                                   | S<br>E<br>l<br>i,<br>F<br>d<br>l<br>f<br>t<br>o<br>u<br>r<br>c<br>e<br>:<br>m<br>a<br>s<br>r<br>u<br>n<br>a<br>m<br>e<br>n<br>a<br>s<br>o<br>D<br>b<br>S<br>P<br>8<br>8<br>f<br>f<br>t<br>t<br>26<br>5<br>a<br>a<br>a<br>s<br>e<br>y<br>s<br>e<br>m<br>s,<br>a<br>g<br>e |
|                                                                         |                                                          |                                                                                   |                                                                                                                                                                                                                                                                          |

![](_page_52_Picture_5.jpeg)

### **RELATIONSHIPS**

#### **SQL: CREATE TABLE – COLUMN AND TABLE CONSTRAINTS: FOREIGN KEY**

 < action >:

> How to react on changes to the referenced table

- The default action: reject the update operation (**RESTRICT** option)
- Syntax

![](_page_53_Picture_6.jpeg)

### **RELATIONSHIPS**

#### **SQL: CREATE TABLE – COLUMN AND TABLE CONSTRAINTS: FOREIGN KEY**

### Options:

- **SET NULL** Value of foreign key is set to NULL
- **SET DEFAULT** Value of foreign key is set to a default value
- **CASCADE** Value of foreign key is updated
- For example:
	- **ON DELETE CASCADE** Delete all referencing tuples
	- **ON UPDATE CASCADE** Change Value of the foreign key attribute(s)
- General Rule for using **CASCADE**:
	- For "relationship" relations
	- For multivalued attributes
	- For relations that represent weak entity types

267 Source: Elmasri, Fundamentals of Database Systems, Page 88ff

![](_page_54_Picture_14.jpeg)

![](_page_54_Picture_15.jpeg)

**CREATE TABLE** Employee ( . . . , Dno **INT NOT NULL DEFAULT** 1, **CONSTRAINT** EMPPK **PRIMARY KEY** (Ssn), **CONSTRAINT** EMPSUPERFK **FOREIGN KEY** (Super\_ssn) **REFERENCES** Employee(Ssn) **ON DELETE SET NULL ON UPDATE CASCADE**, **CONSTRAINT** EMPDEPTFK **FOREIGN KEY**(Dno) **REFERENCES** Department(Dnumber) **ON DELETE SET DEFAULT ON UPDATE CASCADE**);

> 268 Source: Elmasri, Fundamentals of Database Systems, Page 88ff

![](_page_55_Picture_3.jpeg)

![](_page_55_Picture_4.jpeg)

# **RELATIONSHIPS SQL: ALTER TABLE**

- For modifying an existing relation
	- COLUMN: **ADD, DROP, MODIFY**
	- CONSTRAINT: **ADD, DROP**
	- TABLE: **RENAME**

 Vendor-specific extensions

![](_page_56_Picture_6.jpeg)

### **RELATIONSHIPS SQL: ALTER TABLE - COLUMN**

Syntax for altering a table:

```
ALTER TABLE < relationname > . . .
```

```
ADD [ COLUMN ] < column > < type >
        [ < col\_constraint > [ . . .]
```
**DROP** [ **COLUMN** ] <column> [ **RESTRICT** | **CASCADE** ]

**RENAME COLUMN** <column> **TO** <new\\_column>

![](_page_57_Picture_6.jpeg)

### **RELATIONSHIPS SQL: ALTER TABLE - COLUMN**

Syntax for altering a table: 

```
ALTER TABLE < relationname > . . .
```
Modification of columns vendor-specific:

Oracle:

```
... MODIFY < column > < type > [< col\_constraints > [...]]
```
MySQL:

```
... CHANGE [ COLUMN ] < column > < type > ...
```
**Databases, © Ulrike Herster, partially © Elmasri "Fundamentals of Database Systems – For personal use only**

![](_page_58_Picture_9.jpeg)

### **RELATIONSHIPS SQL: ALTER TABLE - COLUMN**

 Example:

> **ALTER TABLE** COMPANY.Employee **ADD COLUMN** Job **VARCHAR**(12);

- Inserting values for the new column:
	- Default is NULL **NOT NULL** constraint is not allowed
	- Using default clause
	- Using **UPDATE** individually on each tuple

![](_page_59_Picture_7.jpeg)

![](_page_59_Picture_8.jpeg)

### **RELATIONSHIPS SQL: ALTER TABLE - CONSTRAINTS**

Syntax for adding a new constraint:

```
ALTER table ADD < tableconstraint > ;
```
 Example: Add a foreign key (instead of within create table statement)

**ALTER TABLE** DEPARTMENT **ADD CONSTRAINT** DEPTMGRFK **FOREIGN KEY (**Mgr\_ssn**) REFERENCES EMPLOYEE(**Ssn**) ON DELETE RESTRICT ON UPDATE CASCADE;**

![](_page_60_Picture_5.jpeg)

### **RELATIONSHIPS SQL: ALTER TABLE - CONSTRAINTS**

Syntax for droping an existing constraint:

> **ALTER TABLE** < tablename > < alterstatement >

```
< alterstatement > ::=
      DROP PRIMARY KEY |
      DROP FOREIGN KEY < keyname > |
```
![](_page_61_Picture_4.jpeg)

### **RELATIONSHIPS SQL: ALTER TABLE - RENAME**

Syntax for renaming an existing table:

```
 Oracle, MySQL
RENAME TABLE < relationname > TO < newrelationname >
```

```
 PostgreSQL, MySQL
ALTER TABLE < name > RENAME TO < new_name >
```
![](_page_62_Picture_4.jpeg)

275

## **HOMEWORK**

- Company Example
	- Implement all relationship types from the ERM in your database
	- Think also about the cardinalities and participation constraints of these relationship types
	- What should be the behavior of these relations if data changes?
	- Try SQL statements for inserting, updating, and deleting data
- Implement the printer example in your database
- Think about your own, individual example (e.g., contact list)
	- Implement all relationship types from the ERM in your database
	- Think also about the cardinalities and participation constraints
	- What should be the behavior of these relations if data changes?
	- Try SQL statements for inserting, updating, and deleting data

![](_page_63_Picture_12.jpeg)

![](_page_63_Picture_13.jpeg)