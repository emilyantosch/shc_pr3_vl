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

![](_page_2_Figure_0.jpeg)

![](_page_3_Figure_0.jpeg)

### **RELATIONSHIPS ERM: TENARY RELATIONSHIP TYPES**

### Example:

- Manufacturers supply items for projects.
- A manufacturer must supply at least one item.
- An article from in-house production does not have to be supplied for a project but can be supplied for many projects.
- A project uses at least one item.
- An item is supplied by only one manufacturer for a project.

RepetitionQuestion 1 (Cardinality): Can an entity of entity type A and an entity of entity type B be related to multiple entities of entity type C?

Question 2 (Participation): Must an entity type A be related to at least one entity type B and one entity type C?

![](_page_4_Figure_9.jpeg)

### **RELATIONSHIPS ERM: TENARY RELATIONSHIP TYPES**

![](_page_5_Picture_1.jpeg)

![](_page_5_Figure_2.jpeg)

### **RELATIONSHIPS ERM: TENARY RELATIONSHIP TYPES**

![](_page_6_Figure_1.jpeg)

![](_page_6_Figure_2.jpeg)

### **RELATIONSHIPS RM: 7. MAPPING OF N-ARY RELATIONSHIP TYPES**

![](_page_7_Picture_1.jpeg)

![](_page_7_Figure_2.jpeg)

![](_page_7_Picture_3.jpeg)

#### **RELATIONSHIPS MAPPING OF ERM TO RELATIONAL MODEL - SUMMARY**

![](_page_8_Picture_1.jpeg)

| E<br>R<br>M<br>d<br>l<br>o<br>e                                                                                      | R<br>l<br>t<br>i<br>l<br>M<br>d<br>l<br>e<br>a<br>o<br>n<br>a<br>o<br>e                                                                                                               |
|----------------------------------------------------------------------------------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| E<br>i<br>t<br>t<br>t<br>n<br>p<br>e<br>y<br>y                                                                       | R<br>l<br>i<br>t<br>e<br>a<br>o<br>n                                                                                                                                                  |
| 1<br>1<br>1<br>N<br>l<br>t<br>i<br>h<br>i<br>t<br>:<br>o<br>r<br>:<br>r<br>e<br>a<br>o<br>n<br>s<br>p<br>y<br>p<br>e | (<br>)<br>F<br>i<br>k<br>l<br>t<br>i<br>h<br>i<br>l<br>t<br>i<br>o<br>r<br>e<br>g<br>n<br>e<br>y<br>o<br>r<br>r<br>e<br>a<br>o<br>n<br>s<br>p<br>r<br>e<br>a<br>o<br>n                |
| M<br>N<br>l<br>i<br>h<br>i<br>t<br>t<br>:<br>r<br>e<br>a<br>o<br>n<br>s<br>p<br>y<br>p<br>e                          | R<br>l<br>i<br>h<br>i<br>l<br>i<br>d<br>f<br>i<br>k<br>t<br>t<br>t<br>e<br>a<br>o<br>n<br>s<br>p<br>r<br>e<br>a<br>o<br>n<br>a<br>n<br>w<br>o<br>o<br>r<br>e<br>g<br>n<br>e<br>y<br>s |
| N<br>l<br>t<br>i<br>h<br>i<br>t<br>-a<br>r<br>r<br>e<br>a<br>o<br>n<br>s<br>p<br>p<br>e<br>y<br>y                    | R<br>l<br>t<br>i<br>h<br>i<br>l<br>t<br>i<br>d<br>f<br>i<br>k<br>e<br>a<br>o<br>n<br>s<br>p<br>r<br>e<br>a<br>o<br>n<br>a<br>n<br>n<br>o<br>r<br>e<br>g<br>n<br>e<br>s<br>y           |
| S<br>i<br>l<br>t<br>t<br>i<br>b<br>t<br>m<br>p<br>e<br>a<br>r<br>u<br>e                                              | A<br>t<br>t<br>i<br>b<br>t<br>r<br>u<br>e                                                                                                                                             |
| C<br>i<br>i<br>b<br>t<br>t<br>t<br>t<br>o<br>m<br>p<br>o<br>s<br>e<br>a<br>r<br>e<br>u                               | S<br>f<br>i<br>l<br>i<br>b<br>t<br>t<br>t<br>t<br>e<br>o<br>s<br>m<br>p<br>e<br>a<br>r<br>e<br>s<br>u                                                                                 |
| M<br>l<br>t<br>i<br>l<br>d<br>t<br>t<br>i<br>b<br>t<br>u<br>v<br>a<br>u<br>e<br>a<br>r<br>u<br>e                     | f<br>R<br>l<br>t<br>i<br>d<br>i<br>k<br>e<br>a<br>o<br>n<br>a<br>n<br>o<br>r<br>e<br>g<br>n<br>e<br>y                                                                                 |
| V<br>l<br>t<br>a<br>e<br>s<br>e<br>u                                                                                 | D<br>i<br>o<br>m<br>a<br>n                                                                                                                                                            |
| K<br>t<br>t<br>i<br>b<br>t<br>e<br>y<br>a<br>r<br>u<br>e                                                             | P<br>i<br>k<br>r<br>m<br>a<br>r<br>y<br>e<br>y                                                                                                                                        |

8Source: Elmasri, Fundamentals of Database Systems, Page 286ff

![](_page_8_Picture_4.jpeg)

![](_page_9_Picture_0.jpeg)

![](_page_9_Picture_1.jpeg)

Three categories

- 1. Constraints that are inherent in the data model *inherent model-based constraints* or *implicit constraints* Example: no duplicate tuples in a relation
- 2. Constraints that can be directly expressed in schemas of the data model *schema-based constraints* or *explicit constraints* Example: Domain constraints, key constraints, constraints on NULL, entity integrity constraints and referential integrity constraints
- 3. Constraints that cannot be directly expressed in the schemas of the data model, and hence must be expressed and enforced by the application programs *application-based* or *semantic constraints* or *business rules*

 Source: Elmasri, Fundamentals of Database Systems, Page 59ff

![](_page_9_Picture_7.jpeg)

![](_page_9_Picture_8.jpeg)

# **CONSTRAINTS OVERVIEW**

![](_page_10_Picture_1.jpeg)

| C<br>t<br>i<br>t<br>o<br>n<br>s<br>r<br>a<br>n                                                                                                                                             | N<br>b<br>f<br>f<br>f<br>t<br>d<br>R<br>l<br>t<br>i<br>m<br>e<br>r<br>o<br>a<br>e<br>c<br>e<br>e<br>a<br>o<br>n<br>s<br>u |
|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|---------------------------------------------------------------------------------------------------------------------------|
| D<br>i<br>t<br>i<br>t<br>o<br>m<br>a<br>n<br>c<br>o<br>n<br>s<br>r<br>a<br>n<br>s                                                                                                          | 1                                                                                                                         |
| C<br>i<br>N<br>U<br>L<br>L<br>t<br>t<br>o<br>n<br>s<br>r<br>a<br>n<br>s<br>o<br>n                                                                                                          | 1                                                                                                                         |
| (<br>)<br>E<br>t<br>i<br>t<br>i<br>t<br>i<br>t<br>t<br>i<br>t<br>i<br>k<br>n<br>y<br>n<br>e<br>g<br>r<br>y<br>c<br>o<br>n<br>s<br>r<br>a<br>n<br>s<br>p<br>r<br>m<br>a<br>r<br>y<br>e<br>y | 1                                                                                                                         |
| R<br>f<br>i<br>l<br>i<br>i<br>i<br>t<br>t<br>t<br>t<br>t<br>e<br>e<br>r<br>e<br>n<br>a<br>n<br>e<br>g<br>r<br>c<br>o<br>n<br>s<br>r<br>a<br>n<br>s<br>y                                    | 1<br>≥                                                                                                                    |
| S<br>t<br>i<br>i<br>t<br>i<br>t<br>t<br>i<br>t<br>e<br>m<br>a<br>n<br>c<br>n<br>e<br>g<br>r<br>y<br>c<br>o<br>n<br>s<br>r<br>a<br>n<br>s                                                   | 1<br>≥                                                                                                                    |
| F<br>i<br>l<br>d<br>d<br>i<br>i<br>t<br>t<br>t<br>u<br>n<br>c<br>o<br>n<br>a<br>e<br>p<br>e<br>n<br>e<br>n<br>c<br>e<br>s<br>c<br>o<br>n<br>s<br>r<br>a<br>n                               | 1<br>≥                                                                                                                    |

**Databases, © Ulrike Herster, partially © Elmasri "Fundamentals of Database Systems – For personal use only**

![](_page_10_Picture_4.jpeg)

# **ORGANIZATION OUR JOURNEY IN THIS SEMESTER**

![](_page_11_Picture_1.jpeg)

**© Elmasri**

**"Fundamentals**

**Databases, © Ulrike Herster, partially**

- Integrity, Trigger & Security
- Database Applications
- Transactions
- Subqueries & Views
- More SQL
- **Notations & Guidelines**
- Constraints
- Relationships

**Database Systems –**

Simple Entities and Attributes

> **For**

**personal use**

 **only**

Basics

> **of**

11 Source: Foto von Justin Kauffman auf Unsplash

![](_page_11_Picture_13.jpeg)

![](_page_11_Picture_14.jpeg)

![](_page_11_Picture_15.jpeg)

### **NOTATIONS AND GUIDELINES ERM: MC NOTATION (MODIFIED CHEN NOTATION)**

- Participation constraints
- Relationships can be mandatory or optional
- Types
	- Exactly one element: 1
	- One or no element: c (or 1c)
	- No or many elements: mc (or nc)
	- One or many elements: m (or n)

![](_page_12_Picture_8.jpeg)

![](_page_12_Picture_10.jpeg)

12

Repetition

### **ORGANIZATION LABORATORY – 1. LAB ON 29.04.2024**

- Joint lab with all three lab groups
- **Attendance is mandatory!**
- Division of the teams of two to work on the lab assignments
- **Bring your own device with a working mySQL database!**
- You do not have to submit solutions in moodle or implement the assignments in advance
- Start time: 8:30 am
- I strongly recommend that you look at and solve the assignments in advance! This will make the laboratory much more effective for you.

![](_page_13_Picture_8.jpeg)

### **ORGANIZATION OUR JOURNEY IN THIS SEMESTER**

![](_page_14_Picture_1.jpeg)

- Integrity, Trigger & Security
- Database Applications
- Transactions
- Subqueries & Views
- More SQL
- **Notations & Guidelines**
- Constraints
- Relationships
- Simple Entities and Attributes
- Basics

360 Source: Foto von Justin Kauffman auf Unsplash

![](_page_14_Picture_13.jpeg)

### **NOTATIONS AND GUIDELINES ERM: MC NOTATION - TENARY RELATIONSHIP**

Example:

- Manufacturers supply items for projects.
- A manufacturer must supply at least one item.
- An article from in-house production does not have to be supplied for a project but can be supplied for many projects.
- A project uses at least one item.
- An item is supplied by only one manufacturer for a project.

 **TYPES** Question 1 (Cardinality): Can an entity of entity type A and an entity of entity type B be related to multiple entities of entity type C?

Question 2 (Participation): Must an entity type A be related to at least one entity type B and one entity type C?

375ARTICLE SUPPLIED\_BY MANUFACTURER PROJECT nc 1 m

![](_page_15_Picture_11.jpeg)

### **NOTATIONS AND GUIDELINES ERM: MC NOTATION - TENARY RELATIONSHIP**

PROFESSOR

c

Example:

 To prevent students from concentrating on one professor, they may only work with one professor on one seminar topic. entity type C?

- In addition, a student can only work on a seminar topic with one professor.
- However, a professor may assign a seminar topic more than once.
- Students must attend seminars, but seminar topics do not have to be chosen.

SUPPLIES

![](_page_16_Figure_6.jpeg)

**TYPES**

m

STUDENT

**Databases, © Ulrike Herster, partially © Elmasri "Fundamentals of Database Systems – For personal use only**

multiple entities of entity type C? Question 2 (Participation): Must an entity type A be related to at least one entity type B and one 

Question 1 (Cardinality): Can an entity of entity

type A and an entity of entity type B be related to

#### **NOTATIONS AND GUIDELINES ERM: MC NOTATION - TENARY RELATIONSHIP TYPES**

Example:

![](_page_17_Figure_2.jpeg)

![](_page_17_Picture_4.jpeg)

in-ternary-relationships

34506945/erm-cardinality-

Source: https://stackoverflow.com/questions/

### **NOTATIONS AND GUIDELINES DATABASE DESIGN**

![](_page_18_Figure_1.jpeg)

**Databases, © Ulrike Herster, partially © Elmasri "Fundamentals of Database Systems – For personal use only**

![](_page_18_Picture_3.jpeg)

#### ERM:

- Conceptual Database Design
- Describes a collection of **entities**, also called as real-world **objects** and **relations** between those entities
- Basic elements: **entity type**, **relationship type** and **attributes**
- **Constraints** like **Cardinality**, **Participation ratio** and **Keys**

![](_page_19_Figure_6.jpeg)

#### Relational Model:

- Logical Database Design
- Describes data and relation among those data by tables
- Basic elements: Relations and Attributes

 Constraints: Domain constraints, key constraints, constraints on NULL, entity integrity constraints and referential integrity constraints

### **Relational Model**

![](_page_20_Picture_7.jpeg)

![](_page_21_Figure_1.jpeg)

### **Relational Model**

![](_page_21_Figure_3.jpeg)

![](_page_21_Picture_5.jpeg)

| A<br>t<br>s<br>p<br>e<br>c                               | E<br>R<br>M                                                                                                                                                                                                                                                                                                                                                                                             | R<br>M                                                                                                                                                                                                                                                                                                                                                                |
|----------------------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| B<br>i<br>a<br>s<br>c                                    | I<br>t<br>t<br>t<br>h<br>l<br>l<br>t<br>i<br>r<br>e<br>p<br>r<br>e<br>s<br>e<br>n<br>s<br>e<br>c<br>o<br>e<br>c<br>o<br>n<br>f<br>b<br>j<br>t<br>l<br>l<br>d<br>t<br>i<br>t<br>i<br>o<br>o<br>e<br>c<br>s<br>c<br>a<br>e<br>e<br>n<br>e<br>s<br>d<br>l<br>i<br>b<br>t<br>t<br>a<br>n<br>r<br>e<br>a<br>o<br>n<br>e<br>e<br>e<br>n<br>w<br>h<br>i<br>i<br>t<br>t<br>t<br>o<br>s<br>e<br>e<br>n<br>e<br>s | f<br>I<br>t<br>t<br>t<br>h<br>l<br>l<br>t<br>i<br>t<br>b<br>l<br>r<br>e<br>p<br>r<br>e<br>s<br>e<br>n<br>s<br>e<br>c<br>o<br>e<br>c<br>o<br>n<br>o<br>a<br>e<br>s<br>d<br>t<br>h<br>l<br>t<br>i<br>b<br>t<br>t<br>h<br>a<br>n<br>e<br>r<br>e<br>a<br>o<br>n<br>e<br>w<br>e<br>e<br>n<br>o<br>s<br>e<br>b<br>l<br>t<br>a<br>e<br>s                                     |
| D<br>i<br>b<br>e<br>s<br>c<br>r<br>e                     | E<br>R<br>M<br>d<br>i<br>b<br>d<br>t<br>s<br>e<br>s<br>c<br>r<br>e<br>a<br>a<br>a<br>s<br>t<br>i<br>t<br>t,<br>l<br>t<br>i<br>h<br>i<br>t<br>e<br>n<br>y<br>s<br>e<br>r<br>e<br>a<br>o<br>n<br>s<br>p<br>s<br>e<br>d<br>i<br>b<br>t<br>t<br>t<br>a<br>n<br>a<br>r<br>e<br>s<br>u                                                                                                                        | R<br>l<br>i<br>l<br>d<br>l<br>d<br>i<br>b<br>d<br>i<br>t<br>t<br>e<br>a<br>o<br>n<br>a<br>m<br>o<br>e<br>e<br>s<br>c<br>r<br>e<br>s<br>a<br>a<br>n<br>t<br>b<br>l<br>d<br>i<br>t<br>t<br>i<br>b<br>t<br>a<br>a<br>e<br>a<br>s<br>o<br>m<br>a<br>n<br>s<br>a<br>r<br>u<br>e<br>s<br>,<br>,<br>l<br>t<br>p<br>e<br>s<br>u                                               |
| R<br>l<br>i<br>h<br>i<br>t<br>e<br>a<br>o<br>n<br>s<br>p | I<br>E<br>R<br>M<br>i<br>i<br>i<br>t<br>t<br>n<br>a<br>n<br>s<br>e<br>a<br>s<br>e<br>r<br>o<br>,<br>d<br>d<br>h<br>t<br>t<br>u<br>n<br>e<br>r<br>s<br>a<br>n<br>e<br>l<br>t<br>i<br>h<br>i<br>b<br>t<br>r<br>e<br>a<br>o<br>n<br>s<br>p<br>s<br>e<br>w<br>e<br>e<br>n<br>i<br>i<br>t<br>t<br>e<br>n<br>e<br>s                                                                                           | C<br>i<br>l<br>i<br>i<br>l<br>t<br>t<br>t<br>o<br>m<br>p<br>a<br>r<br>a<br>e<br>s<br>e<br>s<br>s<br>e<br>a<br>s<br>o<br>v<br>y,<br>y<br>d<br>i<br>l<br>i<br>b<br>b<br>l<br>i<br>t<br>t<br>t<br>e<br>r<br>v<br>e<br>a<br>r<br>e<br>a<br>o<br>n<br>e<br>w<br>e<br>e<br>n<br>a<br>e<br>s<br>n<br>l<br>t<br>i<br>l<br>d<br>l<br>r<br>e<br>a<br>o<br>n<br>a<br>m<br>o<br>e |
| M<br>i<br>a<br>p<br>p<br>n<br>g                          | E<br>R<br>M<br>d<br>i<br>b<br>i<br>e<br>s<br>c<br>r<br>e<br>s<br>m<br>a<br>p<br>p<br>n<br>g<br>d<br>i<br>l<br>i<br>i<br>t<br>c<br>a<br>r<br>n<br>a<br>e<br>s                                                                                                                                                                                                                                            | R<br>l<br>i<br>l<br>d<br>l<br>d<br>d<br>i<br>b<br>t<br>t<br>e<br>a<br>o<br>n<br>a<br>m<br>o<br>e<br>o<br>e<br>s<br>n<br>o<br>e<br>s<br>c<br>r<br>e<br>i<br>d<br>i<br>l<br>i<br>i<br>t<br>m<br>a<br>p<br>p<br>n<br>g<br>c<br>a<br>r<br>n<br>a<br>e<br>s                                                                                                                |

Source: https://techdifferences.com/difference-between-e-r-andrelational-model-in-dbms.html

**Databases, © Ulrike Herster, partially © Elmasri "Fundamentals of Database Systems – For personal use only**

![](_page_22_Picture_4.jpeg)

### **NOTATIONS AND GUIDELINES MAPPING OF ERM TO RELATIONAL MODEL**

Main rules

- Entity types
	- Mapped to relations
	- Relations contain the attributes
	- Composite attributes: set of simple attributes
- Relationship Types
	- Foreign keys

or

 Relations plus Foreign keys

> 383 Source: Elmasri, Fundamentals of Database Systems, Page 286ff

![](_page_23_Picture_11.jpeg)

### **NOTATIONS AND GUIDELINES MAPPING OF ERM TO RELATIONAL MODEL**

### Seven Steps

- 1. Mapping of regular entity types
- 2. Mapping of weak entity types
- 3. Mapping of binary 1:1 relationships
- 4. Mapping of binary 1:n relationships
- 5. Mapping of binary m:n relationships
- 6. Mapping of multivalued attributes
- 7. Mapping of n-ary relationships

384 Source: Elmasri, Fundamentals of Database Systems, Page 286ff

![](_page_24_Picture_10.jpeg)

### **NOTATIONS AND GUIDELINES DATABASE DESIGN**

![](_page_25_Figure_1.jpeg)

**Databases, © Ulrike Herster, partially © Elmasri "Fundamentals of Database Systems – For personal use only**

![](_page_25_Picture_3.jpeg)

Guideline 1

- Clear semantics of relation attributes
- Meaning of attributes should be easy to explain
- Do not mix attributes from different entity types or relationship types into one relation

|                                                                         |                                     |                         |                               |                         |                      |                          |                    |                       | S<br>D   | E<br>o<br>r<br>c<br>e<br>u<br>:<br>t<br>b<br>a<br>a<br>a<br>s<br>e | l<br>i,<br>F<br>m<br>a<br>s<br>r<br>u<br>S<br>t<br>y<br>s<br>e<br>m<br>s, | d<br>t<br>n<br>a<br>m<br>e<br>n<br>a<br>2<br>8<br>6<br>P<br>a<br>g<br>e | f<br>l<br>s<br>o<br>f<br>f<br>38<br>6 |
|-------------------------------------------------------------------------|-------------------------------------|-------------------------|-------------------------------|-------------------------|----------------------|--------------------------|--------------------|-----------------------|----------|--------------------------------------------------------------------|---------------------------------------------------------------------------|-------------------------------------------------------------------------|---------------------------------------|
| Da<br>ba<br>©<br>U<br>lr<br>i<br>ke<br>He<br>ta<br>te<br>se<br>s,<br>rs | ia<br>l<br>ly<br>t<br>r,<br>p<br>ar | ©<br>E<br>lm<br>as<br>r | i<br>Fu<br>da<br>n<br>me<br>" | ls<br>f<br>ta<br>n<br>o | Da<br>ba<br>ta<br>se | Sy<br>te<br>s<br>ms<br>– | Fo<br>r<br>p<br>er | l u<br>so<br>na<br>se | ly<br>on |                                                                    |                                                                           |                                                                         |                                       |

### Guideline 2

- Avoid schemas that cause insertion, deletion, or modification anomalies
- If anomalies are present, note them clearly!
- Someone must take care of them (application, triggers)

![](_page_27_Figure_5.jpeg)

![](_page_28_Figure_1.jpeg)

### Guideline 4

- Avoid relations that contain matching attributes that are not (foreign key, primary key) combinations
- Joining on such attributes may produce *spurious tuples*
- Matching attributes in relations should be (foreign key, primary key) combinations Do not forget the Foreign Keys!

![](_page_29_Picture_5.jpeg)

#### Spurious Tuples

- Combining relations should produce facts only
	- Example:

- Two relations
	- Employee
	- Project
- When joining these relations, we want only tuples for real existing combinations of employees and projects
- Other combinations: *Spurious tuples*
- Spurious tuples are created when two tables are joined on attributes that are neither primary keys nor foreign keys

![](_page_30_Figure_11.jpeg)

**Databases, © Ulrike Herster, partially © Elmasri "Fundamentals of Database Systems – For personal use only**

390 Source: Elmasri, Fundamentals of Database Systems, Page 286ff

![](_page_30_Picture_14.jpeg)

Why don't we put everything in one big table?

| A<br>L<br>L | f<br>P<br>r<br>o<br>e<br>s<br>s<br>o<br>r | L<br>t<br>e<br>c<br>u<br>r<br>e | S<br>t<br>d<br>t<br>u<br>e<br>n | L<br>i<br>t<br>T<br>i<br>t<br>l<br>e<br>r<br>a<br>c<br>y<br>e | S<br>I<br>B<br>N      | S<br>t<br>e<br>m<br>e<br>s<br>e<br>r | … |
|-------------|-------------------------------------------|---------------------------------|---------------------------------|---------------------------------------------------------------|-----------------------|--------------------------------------|---|
|             | S<br>i<br>h<br>t<br>m                     | C<br>+<br>+                     | J<br>h<br>o<br>n                | L<br>C<br>+<br>+<br>e<br>a<br>r<br>n                          | 1<br>2<br>3<br>4<br>5 | 4                                    | … |
|             | S<br>i<br>t<br>h<br>m                     | C<br>+<br>+                     | J<br>l<br>i<br>u<br>e           | C<br>L<br>+<br>+<br>e<br>a<br>r<br>n                          | 1<br>2<br>3<br>4<br>5 | 4                                    | … |
|             | C<br>l<br>l<br>i<br>o<br>n<br>s           | D<br>B<br>M<br>S                | J<br>l<br>i<br>e<br>u           | D<br>b<br>t<br>a<br>a<br>a<br>s<br>e<br>s                     | 2<br>3<br>4<br>6<br>5 | 4                                    | … |
|             | C<br>l<br>l<br>i<br>o<br>n<br>s           | S<br>D<br>B<br>M                | A<br>n<br>n<br>a                | D<br>t<br>b<br>a<br>a<br>a<br>s<br>e<br>s                     | 2<br>3<br>4<br>5<br>6 | 4                                    | … |
|             | …                                         | …                               | …                               | …                                                             | …                     | …                                    | … |

**Databases, © Ulrike Herster, partially © Elmasri "Fundamentals of Database Systems – For personal use only**

![](_page_31_Picture_4.jpeg)

One problem is: Some data is the always the same (E.g., ISBN)

- This problem occurs in nearly all applications
- There are almost one or several attributes, which define the values of the remaining attributes
- This fact is called *functional dependency*
- Functional dependency is relevant in practical applications

| A<br>L<br>L | f<br>P<br>r<br>o<br>e<br>s<br>s<br>o<br>r | L<br>t<br>e<br>c<br>u<br>r<br>e | S<br>t<br>d<br>t<br>u<br>e<br>n | L<br>i<br>t<br>T<br>i<br>t<br>l<br>e<br>r<br>a<br>c<br>y<br>e | S<br>I<br>B<br>N      | S<br>t<br>e<br>m<br>e<br>s<br>e<br>r | … |
|-------------|-------------------------------------------|---------------------------------|---------------------------------|---------------------------------------------------------------|-----------------------|--------------------------------------|---|
|             | S<br>i<br>h<br>t<br>m                     | C<br>+<br>+                     | J<br>h<br>o<br>n                | L<br>C<br>+<br>+<br>e<br>a<br>r<br>n                          | 1<br>2<br>3<br>4<br>5 | 4                                    | … |
|             | S<br>i<br>t<br>h<br>m                     | C<br>+<br>+                     | J<br>l<br>i<br>u<br>e           | C<br>L<br>+<br>+<br>e<br>a<br>r<br>n                          | 1<br>2<br>3<br>4<br>5 | 4                                    | … |
|             | C<br>l<br>l<br>i<br>o<br>n<br>s           | D<br>B<br>M<br>S                | J<br>l<br>i<br>u<br>e           | D<br>b<br>t<br>a<br>a<br>a<br>s<br>e<br>s                     | 2<br>3<br>4<br>6<br>5 | 4                                    | … |
|             | C<br>l<br>l<br>i<br>o<br>n<br>s           | D<br>B<br>M<br>S                | A<br>n<br>n<br>a                | D<br>t<br>b<br>a<br>a<br>a<br>s<br>e<br>s                     | 2<br>3<br>4<br>5<br>6 | 4                                    | … |
|             | …                                         | …                               | …                               | …                                                             | …                     | …                                    | … |

![](_page_32_Picture_7.jpeg)

**Databases, © Ulrike Herster, partially © Elmasri "Fundamentals of Database Systems – For personal use only**

Functional dependencies

- Definition: There is a relational schema called R, and X and Y are any attribute sets of the attributes of R. Then Y is functional dependent on X, noted as X → Y, if and only if every value of X in R defines exactly one value of Y in R
- In other words: Whenever two tuples of relation R match in their X values, then the Y values of these tuples match as well **YX**

| A<br>L<br>L<br>P<br>f<br>S<br>d<br>i<br>T<br>i<br>l<br>I<br>S<br>B<br>N<br>S<br>L<br>t<br>t<br>t<br>L<br>t<br>t<br>t<br>r<br>o<br>e<br>s<br>s<br>o<br>r<br>e<br>c<br>u<br>r<br>e<br>u<br>e<br>n<br>e<br>r<br>a<br>c<br>y<br>e<br>e<br>m<br>e<br>s<br>e<br>r |   |
|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|---|
|                                                                                                                                                                                                                                                             | … |
| S<br>i<br>h<br>C<br>J<br>h<br>L<br>C<br>1<br>2<br>3<br>4<br>5<br>4<br>t<br>+<br>+<br>+<br>+<br>m<br>o<br>n<br>e<br>a<br>r<br>n                                                                                                                              | … |
| S<br>C<br>C<br>i<br>t<br>h<br>J<br>l<br>i<br>L<br>1<br>2<br>3<br>4<br>5<br>4<br>+<br>+<br>+<br>+<br>m<br>u<br>e<br>e<br>a<br>r<br>n                                                                                                                         | … |
| C<br>l<br>l<br>i<br>D<br>B<br>M<br>S<br>J<br>l<br>i<br>D<br>b<br>2<br>3<br>4<br>5<br>6<br>4<br>t<br>o<br>n<br>s<br>e<br>a<br>a<br>a<br>s<br>e<br>s<br>u                                                                                                     | … |
| C<br>S<br>l<br>l<br>i<br>D<br>B<br>M<br>A<br>D<br>t<br>b<br>2<br>3<br>4<br>5<br>6<br>4<br>o<br>n<br>s<br>n<br>n<br>a<br>a<br>a<br>a<br>s<br>e<br>s                                                                                                          | … |
| …<br>…<br>…<br>…<br>…<br>…                                                                                                                                                                                                                                  | … |
|                                                                                                                                                                                                                                                             |   |

**Databases, © Ulrike Herster, partially © Elmasri "Fundamentals of Database Systems – For personal use only**

![](_page_33_Picture_6.jpeg)

Functional dependencies

- Are used to specify formal measures of the "goodness" of relational designs
- Can help to identify redundancy and suggest refinements
- FD: If for 2 tuples X is the same, then Y must also be the same
- Notation: X → Y Read: "X determines Y"
- Generalization of keys
- A key determines all attributes: ൌ

![](_page_34_Picture_8.jpeg)

**Databases, © Ulrike Herster, partially © Elmasri "Fundamentals of Database Systems – For personal use only**

Functional dependencies

- Actual data can help to identify FDs
- Note: FD is a statement about *all allowable* tuples!
- Based on semantics, NOT instances!
- Full functional dependency:
	- X → Y holds only for complete X, not for subset of X
	- You cannot remove an element of X without destroying the FD
	- Opposite: Partial Functional Dependency

![](_page_35_Picture_9.jpeg)

![](_page_36_Picture_1.jpeg)

Source: https://www.youtube.com/ watch?v=Nq91b4TQ29Q

**Databases, © Ulrike Herster, partially © Elmasri "Fundamentals of Database Systems – For personal use only**

![](_page_36_Picture_4.jpeg)

- Normal Forms provide quality statements on relations
- The process of decomposing unsatisfactory "bad" relations by breaking up their attributes into smaller relations
- There are different Normal Forms: 1NF, 2NF, 3NF, BCNF, ...

![](_page_37_Picture_4.jpeg)

#### Example:

| Title                                                    | Author  | Author<br>Nationality | Format                        |                  |     | Price Subject Pages Thickness Publisher |        | Publisher<br>Country | Publication<br>Type | Genre<br>ID | Genre<br>Name |
|----------------------------------------------------------|---------|-----------------------|-------------------------------|------------------|-----|-----------------------------------------|--------|----------------------|---------------------|-------------|---------------|
| Beginning MySQL Database Design and Chad<br>Optimization | Russell | American              | Hardcover 49.99 Database,   . | MySQL,<br>Design | 520 | Thick                                   | Apress | USA                  | E-book              |             | Tutorial      |

Source: https://en.wikipedia.org/wiki/Database\_normalization 398

![](_page_38_Picture_4.jpeg)

![](_page_38_Picture_5.jpeg)

 The *First Normal Form* (1NF) defines that the values in each column of a table must be atomic

 Solution: Separate the duplicities into multiple columns using repeating groups 'subject'

| Title                                               | Author          | Author<br>Nationality | Format                | Price | Subject                           | Pages             | Thickness   Publisher |               | Publisher<br>Country |                       | Publication<br>Type  | Genre<br>ID | Genre<br>Name |
|-----------------------------------------------------|-----------------|-----------------------|-----------------------|-------|-----------------------------------|-------------------|-----------------------|---------------|----------------------|-----------------------|----------------------|-------------|---------------|
| Beginning MySQL Database Design and<br>Optimization | Chad<br>Russell | American              | Hardcover 49.99       |       | MySQL,<br>Database, 520<br>Design |                   | Thick                 | Apress        | USA                  |                       | E-book               | 1           | Tutorial      |
|                                                     |                 |                       |                       |       |                                   |                   |                       |               |                      |                       |                      |             |               |
| Title                                               | Format          | Author                | Author<br>Nationality | Pric  | Subject                           | Subject<br>2      | Subject<br>3          | lages         |                      | Thickness   Publisher | Publisher<br>country | Genre<br>ID | Genre<br>Name |
| Beginning MySQL Database Design<br>and Optimization | Hardcover       | Chad<br>Russell       | American              | 49.9  | MySQL                             | Database   Design |                       | 5 20<br>Thick |                      | Apress                | USA                  | 1           | Tutorial      |

 Disadvantages? 

> Source: https://en.wikipedia.org/wiki/Database\_normalization 399

![](_page_39_Picture_6.jpeg)

#### Alternative Solution:

|  |  |  |                       | W<br>h<br>i<br>i<br>i<br>?<br>t<br>a<br>s<br>m<br>s<br>s<br>n<br>g |                                 |                        |                            |                       |                            |                  |                        |  |  |
|--|--|--|-----------------------|--------------------------------------------------------------------|---------------------------------|------------------------|----------------------------|-----------------------|----------------------------|------------------|------------------------|--|--|
|  |  |  |                       |                                                                    |                                 |                        |                            |                       |                            |                  |                        |  |  |
|  |  |  |                       |                                                                    |                                 |                        |                            |                       |                            |                  |                        |  |  |
|  |  |  | S<br>o<br>u<br>r<br>c | h<br>t<br>e<br>:                                                   | /<br>/<br>t<br>p<br>s<br>:<br>e | i<br>k<br>i<br>n.<br>w | d<br>i<br>p<br>e<br>a<br>o | /<br>i<br>r<br>g<br>w | k<br>i<br>/<br>D<br>t<br>a | b<br>a<br>a<br>s | e_<br>n<br>o<br>r<br>m |  |  |

400

Decomposition to 1NF:

- Composite Attributes
	- Split into single atomic attributes
- Multi-valued Attributes
	- Decompose to new tuples
		- Results in redundancies
		- Further decomposition in following steps

-or

Decompose to new relation with FK

![](_page_41_Picture_10.jpeg)

![](_page_41_Picture_11.jpeg)

- A relation is in Second Normal Form (2NF), if
	- It is in 1NF and

- Every attribute in R is fully functional dependent on every key in R (or is part of the key)
- In other words: If there is a key with different attributes (e.g., title and format) and an attribute depends on just a part of this key (e.g., title), then the second Normal Form is violated
- To create the Second Normal Form, you must decompose the relation: Depending attribute with part of key in new relation, delete depending attribute in old relation

![](_page_42_Picture_6.jpeg)

| Book                                                                           |           |              |                                                   |  |            |        |  |       |   |                     |              |  |  |  |
|--------------------------------------------------------------------------------|-----------|--------------|---------------------------------------------------|--|------------|--------|--|-------|---|---------------------|--------------|--|--|--|
| Title                                                                          | Format    | Author       | Author Nationalty Price Frages Thickness Genre ID |  |            |        |  |       |   | Genre Name          | Publisher ID |  |  |  |
| Beginning MySQL Database Design and Optimization                               | Hardcover | Chad Russell | American                                          |  | 49.99 520  |        |  | Thick |   | Tutorial            |              |  |  |  |
| Beginning MySQL Database Design and Optimization                               | E-book    | Chad Russell | American                                          |  | 22.34 520  |        |  | Thick |   | Tutorial            |              |  |  |  |
| The Relational Model for Database Management: Version 2   E-book               |           | E.F.Codd     | British                                           |  | 13.88 5 38 |        |  | Thick | 2 | Popular science   2 |              |  |  |  |
| The Relational Model for Database Management: Version 2   Paperback   E.F.Codd |           |              | British                                           |  | 39.99      | 1 5 38 |  | Thick | 2 | Popular science   2 |              |  |  |  |

#### Primary key: Title + Format

#### Functional dependencies: Title Author

 Title Author NationalityTitle, Format Price Title Pages Title Thickness Title GenreID Title Genre Name Title Publisher ID

403Source: https://en.wikipedia.org/wiki/ Database\_normalization

![](_page_43_Picture_6.jpeg)

![](_page_43_Picture_7.jpeg)

| Book                                                                           |           |                         |                                                   |  |            |      |  |       |   |                 |              |  |  |
|--------------------------------------------------------------------------------|-----------|-------------------------|---------------------------------------------------|--|------------|------|--|-------|---|-----------------|--------------|--|--|
| Title                                                                          | Format    | Author                  | Author Nationalty Price Plages Thickness Genre ID |  |            |      |  |       |   | Genre Name      | Publisher ID |  |  |
| Beginning MySQL Database Design and Optimization                               | Hardcover | Chad Russell American   |                                                   |  | 49.99      | 5 20 |  | Thick |   | Tutorial        |              |  |  |
| Beginning MySQL Database Design and Optimization                               | E-book    | Chad Russell   American |                                                   |  | 22.34      | 5 20 |  | Thick |   | Tutorial        |              |  |  |
| The Relational Model for Database Management: Version 2   E-book               |           | E.F.Codd                | British                                           |  | 13.88 5 88 |      |  | Thick | 2 | Popular science |              |  |  |
| The Relational Model for Database Management: Version 2   Paperback   E.F.Codd |           |                         | British                                           |  | 39.99      | 588  |  | Thick | 2 | Popular science | 2            |  |  |

![](_page_44_Figure_2.jpeg)

Source: https://en.wikipedia.org/wiki/Database\_normalization 404

![](_page_44_Picture_4.jpeg)

![](_page_44_Picture_5.jpeg)

Decomposition to Second Normal Form

- Has the relation in 1NF following design (keyPart1, keyPart2, noKey1, noKey2) and there is a functional dependency FD: keyPart2 → noKey2
- Then the decomposition respecting this FD results in following schema: (keyPart1, keyPart2, noKey1) (keyPart2, noKey2)

![](_page_45_Picture_4.jpeg)

Decomposition to Second Normal Form

 Has the relation in 1NF following design (keyPart1, keyPart2, noKey1, noKey2) and there is a functional dependency FD: keyPart2 → noKey2 

| Book                                                                           |           |                         |                                                   |           |  |       |   |                     |              |  |
|--------------------------------------------------------------------------------|-----------|-------------------------|---------------------------------------------------|-----------|--|-------|---|---------------------|--------------|--|
| Title                                                                          | Format    | Author                  | Author Nationality Price Pages Thickness Genre ID |           |  |       |   | Genre Name          | Publisher ID |  |
| Beginning MySQL Database Design and Optimization                               | Hardcover | Chad Russell   American |                                                   | 49.99 520 |  | Thick |   | Tutorial            |              |  |
| Beginning MySQL Database Design and Optimization                               | E-book    | Chad Russell   American |                                                   | 22.34 520 |  | Thick |   | Tutorial            |              |  |
| The Relational Model for Database Management: Version 2   E-book               |           | E.F.Codd                | British                                           | 13.88 538 |  | Thick | 2 | Popular science     |              |  |
| The Relational Model for Database Management: Version 2   Paperback   E.F.Codd |           |                         | British                                           | 39.99 538 |  | Thick | 2 | Popular science   2 |              |  |

Source: https://en.wikipedia.org/wiki/Database\_normalization

**Databases, © Ulrike Herster, partially © Elmasri "Fundamentals of Database Systems – For personal use only**

![](_page_46_Picture_6.jpeg)

Decomposition to Second Normal Form

 Then the decomposition respecting this FD results in following schema: (keyPart1, keyPart2, noKey1) (keyPart2, noKey2) 

![](_page_47_Figure_3.jpeg)

The Third Normal Form (3NF) describes the problem 

- Informal: A relation is in 3NF if every tuple consists of a primary key and a set of other attributes that are independent of each other
- Formal: A relation is in 3NF if
	- It is in 2NF and
	- Every non-primary-key attribute is directly dependent on the primary key (especially no transitive dependencies)
- In other words: A table in third normal form (3NF) is a table in 2NF that has no transitive dependencies

![](_page_48_Picture_7.jpeg)

Transitive Dependency

- Z is transitive dependent on X, if
	- X → Y → Z

- But not Y → X
- Second condition important: not a transitive dependency if X and Y are both keys!

![](_page_49_Picture_6.jpeg)

409

| Book                                                               |                             |                                                   |     |       |   |                 |              |  |  |
|--------------------------------------------------------------------|-----------------------------|---------------------------------------------------|-----|-------|---|-----------------|--------------|--|--|
| Title                                                              | Author                      | Author Nationality   Pages   Thickness   Genre ID |     |       |   | Genre Name      | Publisher ID |  |  |
| Beginning MySQL Database Design and Optimization                   | Chad Russell                | American                                          | 520 | Thick |   | Tutorial        |              |  |  |
| The Relational Model for Database Management: Version 2   E.F.Codd |                             | British                                           | 538 | Thick | 2 | Popular science |              |  |  |
| Learning SQL                                                       | Alan Beaulieu               | American                                          | 338 | Slim  |   | Tutorial        |              |  |  |
| SQL Cookbook                                                       | Anthony Molinaro   American |                                                   | 636 | Thick |   | Tutorial        |              |  |  |

#### Functional dependencies:

![](_page_50_Picture_3.jpeg)

Source: https://en.wikipedia.org/wiki/Database\_normalization

**Databases, © Ulrike Herster, partially © Elmasri "Fundamentals of Database Systems – For personal use only**

![](_page_50_Picture_6.jpeg)

|                                                                    |                  | Book                                        |     |       |   |                 |              |
|--------------------------------------------------------------------|------------------|---------------------------------------------|-----|-------|---|-----------------|--------------|
| Title                                                              | Author           | Author Nationality Pages Thickness Genre ID |     |       |   | Genre Name      | Publisher ID |
| Beginning MySQL Database Design and Optimization                   | Chad Russell     | American                                    | 520 | Thick |   | Tutorial        |              |
| The Relational Model for Database Management: Version 2   E.F.Codd |                  | British                                     | 538 | Thick | 2 | Popular science |              |
| Learning SQL                                                       | Alan Beaulieu    | American                                    | 338 | Slim  |   | Tutorial        |              |
| SQL Cookbook                                                       | Anthony Molinaro | American                                    | 636 | Thick |   | Tutorial        |              |

![](_page_51_Picture_2.jpeg)

| Title                                                              | Author                      | Author Nationality Pages Thickness Genre ID Publisher ID |     |       |   |   |          | Book Genres     |
|--------------------------------------------------------------------|-----------------------------|----------------------------------------------------------|-----|-------|---|---|----------|-----------------|
| Beginning MySQL Database Design and Optimization                   | Chad Russell                | American                                                 | 520 | Thick |   |   | Genre ID | Genre Name      |
| The Relational Model for Database Management: Version 2   E.F.Codd |                             | British                                                  | 538 | Thick | 2 | 2 |          | Tutorial        |
| Learning SQL                                                       | Alan Beaulieu               | American                                                 | 338 | Slim  |   | 3 |          | Popular science |
| SQL Cookbook                                                       | Anthony Molinaro   American |                                                          | 636 | Thick |   | 3 |          |                 |

Source: https://en.wikipedia.org/wiki/Database\_normalization

![](_page_51_Picture_5.jpeg)

411

Decomposition to Third Normal Form

- The relation in 2NF has the schema (KeyPart1, NonKey1, NonKey2) and there is a functional dependency FD: NonKey1 → NonKey2
- Then the decomposition results in a new schema, which is in Third Normal Form (KeyPart1, NonKey1) (NonKey1, NonKey2)

![](_page_52_Picture_4.jpeg)

Decomposition to Third Normal Form

 The relation in 2NF has the schema (KeyPart1, NonKey1, NonKey2) and there is a functional dependency FD: NonKey1 → NonKey2 

|                                                                    | Book             |                                                   |     |       |   |                 |              |  |
|--------------------------------------------------------------------|------------------|---------------------------------------------------|-----|-------|---|-----------------|--------------|--|
| Title                                                              | Author           | Author Nationality   Pages   Thickness   Genre ID |     |       |   | Genre Name      | Publisher ID |  |
| Beginning MySQL Database Design and Optimization                   | Chad Russell     | American                                          | 520 | Thick |   | Tutorial        |              |  |
| The Relational Model for Database Management: Version 2   E.F.Codd |                  | British                                           | 538 | Thick | 2 | Popular science |              |  |
| Learning SQL                                                       | Alan Beaulieu    | American                                          | 338 | Slim  |   | Tutorial        |              |  |
| SQL Cookbook                                                       | Anthony Molinaro | American                                          | 636 | Thick |   | Tutorial        | 3            |  |

Source: https://en.wikipedia.org/wiki/Database\_normalization

![](_page_53_Picture_7.jpeg)

### Decomposition to Third Normal Form

 Then the decomposition results in a new schema, which is in Third Normal Form (KeyPart1, NonKey1) (NonKey1, NonKey2) 

| Title                                                              | Author                      | Author Nationality Pages Thickness   Genre ID |     |       |   | Genre Name      | Publisher ID |
|--------------------------------------------------------------------|-----------------------------|-----------------------------------------------|-----|-------|---|-----------------|--------------|
| Beginning MySQL Database Design and Optimization                   | Chad Russell                | American                                      | 520 | Thick |   | Tutorial        |              |
| The Relational Model for Database Management: Version 2   E.F.Codd |                             | British                                       | 538 | Thick | 2 | Popular science |              |
| Learning SQL                                                       | Alan Beaulieu               | American                                      | 338 | Slim  |   | Tutorial        | 3            |
| SQL Cookbook                                                       | Anthony Molinaro   American |                                               | 636 | Thick |   | Tutorial        | 3            |

![](_page_54_Picture_4.jpeg)

|  |  |  |  |  |  |  |  |  |  | 41<br>4 |  |  |  |  |
|--|--|--|--|--|--|--|--|--|--|---------|--|--|--|--|
|  |  |  |  |  |  |  |  |  |  |         |  |  |  |  |

**Databases, © Ulrike Herster, partially © Elmasri "Fundamentals of Database Systems – For personal use only** Source: https://en.wikipedia.org/wiki/Database\_normalization

**For normalization, use functional dependencies!!!**

**And not the semantics of the attributes!!!**

![](_page_55_Picture_3.jpeg)

**Databases, © Ulrike Herster, partially © Elmasri "Fundamentals of Database Systems – For personal use only**

![](_page_55_Picture_5.jpeg)

- A relational schema R is in Boyce-Codd normal form (BCNF) if, for every one of its dependencies X → Y, one of the following conditions hold true:
	- X → Y is a trivial functional dependency (i.e., Y is a subset of X)
	- X is a super key for schema R

- Focusses on FDs within key attributes
- Every relation in BCNF is in 3NF, too ... but not the other way round
- Informally: To test whether a relation is in BCNF, identify all the determinants and make sure that they are candidate keys

![](_page_56_Figure_7.jpeg)

Source: https://www.geeksforgeeks.org/boyce-codd-normal-form-bcnf/ 416

![](_page_56_Picture_9.jpeg)

![](_page_56_Picture_11.jpeg)

|                                                                                                                                                                                                                              | UNF    | 1NF    | 2NF    | 3NF    |
|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|--------|--------|--------|--------|
|                                                                                                                                                                                                                              | (1970) | (1970) | (1971) | (1971) |
| Primary key (no duplicate tuples)                                                                                                                                                                                            | 1      | V      | S      | 1      |
| No repeating groups                                                                                                                                                                                                          | >      | 1      | 1      | 1      |
| Atomic columns (cells have single value)[8]                                                                                                                                                                                  | 23     | 1      | 1      | 1      |
| Every non-trivial functional dependency either does not begin with a proper subset of a candidate key<br>or ends with a prime attribute (no partial functional dependencies of non-prime attributes on<br>candidate keys)18] | X      | 24     | 1      | 1      |
| Every non-trivial functional dependency either begins with a superkey or ends with a prime attribute<br>(no transitive functional dependencies of non-prime attributes on candidate keys)181                                 | X      | 24     | X      | 1      |
| Every non-trivial functional dependency either begins with a superkey or ends with an elementary<br>prime attributel8]                                                                                                       | X      | X      | X      | X      |
| Every non-trivial functional dependency begins with a superkey(8)                                                                                                                                                            | X      | X      | X      | X      |
| Every non-trivial multivalued dependency begins with a superkey(8)                                                                                                                                                           | X      | X      | X      | X      |
| Every join dependency has a superkey component®]                                                                                                                                                                             | X      | X      | X      | X      |
| Every join dependency has only superkey components(8)                                                                                                                                                                        | X      | X      | X      | X      |
| Every constraint is a consequence of domain constraints and key constraints 101                                                                                                                                              | X      | X      | X      | X      |
| Every join dependency is trivial(8]                                                                                                                                                                                          | X      | X      | X      | X      |

Source: https://en.wikipedia.org/wiki/Database\_normalization 417

![](_page_57_Picture_3.jpeg)

#### **There should be atomic attribute values only!**

#### Disallows:

- composite attributes
- multivalued attributes
- nested relations
- PK determines every atomic attribute value
- In SQL-92 it's not possible to have relations in Non First Normal Form (NFNF)

![](_page_58_Picture_8.jpeg)

#### **Relation is in 1NF and every nonkey attribute is full functional dependent on the key!**

- No nonkey attribute should be functionally dependent on a part of the primary key
- Applies only to relations where the PK contains multiple attributes

![](_page_59_Picture_5.jpeg)

#### **There should be no transitive dependency of a nonkey attribute on the primary key!**

- No nonkey attribute has a FD on another nonkey attribute
- Relation needs to be in 1NF and 2NF

![](_page_60_Picture_4.jpeg)

![](_page_60_Picture_5.jpeg)

#### **NOTATIONS AND GUIDELINES NORMALIZATION – RULES FOR DECOMPOSITION**

- Should be lossless
- Tuples of the original relation can be restored when joining the decomposed relations
- Functional dependencies should be preserved in one of the decomposed relations
- ... so original FDs can be restored

![](_page_61_Picture_6.jpeg)

#### **NOTATIONS AND GUIDELINES ASSIGNMENT: TRANSFORM THE TABLE INTO 1NF, 2NF, AND 3NF**

| Student<br>No | Student<br>Name | Major | Course   Course<br>No | Name                  | Instr Instr<br>No | Name                        | Instr<br>LOC      | Grade       |
|---------------|-----------------|-------|-----------------------|-----------------------|-------------------|-----------------------------|-------------------|-------------|
| 123           | Smith           | DB    | 1<br>2<br>3           | DB<br>Math<br>Physics | 456<br>567<br>678 | Jason<br>Meyer<br>Fish      | R04<br>R01<br>R02 | 1<br>1<br>2 |
| 234           | Jones           | Math  | 1<br>2<br>4           | DB<br>Math<br>OP      | 456<br>567<br>789 | Jason<br>Meyer<br>Dench R07 | R04<br>R01        | 2<br>1<br>3 |

**Databases, © Ulrike Herster, partially © Elmasri "Fundamentals of Database Systems – For personal use only**

![](_page_62_Picture_3.jpeg)

#### **NOTATIONS AND GUIDELINES ASSIGNMENT: TRANSFORM THE TABLE INTO 1NF, 2NF, AND 3NF**

| Fu<br>l<br>l_<br>Na<br>m<br>e          | P<br>hy<br>ica<br>l<br>A<br>d<br>dr<br>s<br>es<br>s            | Mo<br>ies<br>Re<br>te<br>d<br>v<br>n                                                                                                      | Sa<br>lu<br>ta<br>t<br>io<br>n |
|----------------------------------------|----------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------|--------------------------------|
| Ja<br>t<br>Jo<br>ne<br>ne<br>s         | S<br>F<br>irs<br>t<br>tre<br>t<br>P<br>lo<br>t<br>No<br>4<br>e | f<br>Ca<br>P<br>ira<br>te<br>t<br>he<br>i<br>b<br>be<br>s o<br>r<br>an<br>,<br>C<br>f<br>las<br>h o<br>t<br>he<br>T<br>i<br>ta<br>ns      | Ms                             |
| Ro<br>be<br>P<br>h<br>i<br>l<br>t<br>r | rd<br>3<br>S<br>No<br>3<br>4<br>tre<br>t<br>e                  | Fo<br>ing<br>Sa<br>h<br>Ma<br>ha<br>l,<br>t<br>t<br>rg<br>e<br>ra<br>rs<br>Da<br>d<br>dy<br>'s<br>L<br>i<br>le<br>G<br>ir<br>ls<br>t<br>t | M<br>r.                        |
| Ro<br>be<br>t<br>P<br>h<br>i<br>l<br>r | th<br>5<br>Av<br>No<br>4<br>en<br>ue                           | C<br>las<br>h o<br>f<br>t<br>he<br>T<br>i<br>ta<br>ns                                                                                     | M<br>r.                        |

**Databases, © Ulrike Herster, partially © Elmasri "Fundamentals of Database Systems – For personal use only**

![](_page_63_Picture_3.jpeg)