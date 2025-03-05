![](_page_0_Picture_0.jpeg)

Source: https://en.itpedia.nl/2017/11/26/wat-is-een-database/

**DATABASES**

Prof. Dr. Ulrike Herster Hamburg University of Applied Sciences

![](_page_0_Picture_4.jpeg)

## **COPYRIGHT**

![](_page_1_Picture_1.jpeg)

The publication and sharing of slides, images and sound recordings of this course is not permitted

© Professor Dr. Ulrike Herster

The slides and assignments are protected by copyright. The use is only permitted in relation with the course of study. It is not permitted to forward or republish it in other places (e.g., on the internet).

**Databases, © Ulrike Herster, partially © Elmasri "Fundamentals of Database Systems – For personal use only** .

![](_page_1_Picture_6.jpeg)

### **RELATIONSHIPS ASSIGNMENT CUSTOMER: CONVERT THE ERD TO A RM**

![](_page_2_Picture_1.jpeg)

![](_page_2_Figure_2.jpeg)

**Databases, © Ulrike Herster, partially © Elmasri "Fundamentals of Database Systems – For personal use only**

![](_page_2_Picture_4.jpeg)

### **RELATIONSHIPS ASSIGNMENT CUSTOMER: IMPLEMENT RM WITH SQL**

![](_page_3_Figure_1.jpeg)

![](_page_3_Figure_2.jpeg)

![](_page_3_Picture_3.jpeg)

## **ORGANIZATION OUR JOURNEY IN THIS SEMESTER**

![](_page_4_Picture_1.jpeg)

- Integrity, Trigger & Security
- Database Applications
- Transactions
- Subqueries & Views
- More SQL Features
- Notations & Guidelines
- Constraints
- **Relationships**
- Simple Entities and Attributes
- Basics

217 Source: Foto von Justin Kauffman auf Unsplash

![](_page_4_Picture_13.jpeg)

## **RELATIONSHIPS DATABASE DESIGN**

![](_page_5_Figure_1.jpeg)

![](_page_5_Picture_2.jpeg)

![](_page_5_Picture_3.jpeg)

#### **RELATIONSHIPS ERM: WEAK ENTITY TYPES**

- An entity type without a key attribute is called a *weak entity type*
- Weak entities are identified by being related to specific entities from another entity type in combination with one of their attribute values;
- This other entity type is called *the identifying or owner entity type*, and the relationship type that relates a weak entity type to its owner *the identifying relationship*
- A weak entity type always has a total participation constraint (existence dependency) with respect to its identifying relationship
- Represented by double rectangles and by having their identifying relationship placed in double diamonds

The partial key attribute is underlined with a dashed or dotted line

- Example: Room vs. Building
	- Need for identify room: Room number and Building number!

281 Source: Elmasri, Fundamentals of Database Systems, Page 204 ff

```
Databases, © Ulrike Herster, partially © Elmasri "Fundamentals of Database Systems – For personal use only
```
#### **RELATIONSHIPS ERM: WEAK ENTITY TYPES**

![](_page_7_Figure_1.jpeg)

![](_page_7_Picture_2.jpeg)

#### **RELATIONSHIPS ERM: WEAK ENTITY TYPES**

- The company is organized into departments
- Each department has a unique name, a unique number, a manager (employee) with start date, and several locations
- A department controls a number of projects, each with unique name, unique number, single location
- We store each employee's name, ssn, address, salary, sex, birthdate
- An employee is assigned to one department, but may work on several projects, also from other departments
- We keep track of the hours per week per project
- We also keep track of the supervisor
- We want to keep track of each employee's dependents for insurance purposes, namely first name, sex, birth date, and relationship to employee. Source: Elmasri, Fundamentals

Database Systems, Page 204 ff

283

 of

#### **RELATIONSHIPS ERM: WEAK ENTITY TYPES**

What could be a weak entity type?

![](_page_9_Figure_2.jpeg)

#### **RELATIONSHIPS ERM: WEAK ENTITY TYPES**

![](_page_10_Figure_1.jpeg)

### **RELATIONSHIPS ERM: MULTIVALUED ATTRIBUTES**

 Single-valued vs multivalued attributes

- Single-valued: Most attributes have a single value for a particular entity
- Multivalued: In some cases, an attribute can have a set of values for the same entity
- Multivalued attributes are displayed in double ovals

![](_page_11_Picture_5.jpeg)

### **RELATIONSHIPS ERM: MULTIVALUED ATTRIBUTES**

What could be a multivalued attribute?

- The company is organized into departments
- Each department has a unique name, a unique number, a manager (employee) with start date, and several locations
- A department controls a number of projects, each with unique name, unique number, single location
- We store each employee's name, ssn, address, salary, sex, birthdate
- An employee is assigned to one department, but may work on several projects, also from other departments
- We keep track of the hours per week per project
- We also keep track of the supervisor
- We want to keep track of each employee's dependents for insurance purposes, namely first name, sex, birth date, and relationship to employee. Source: Elmasri, Fundamentals

287 Database Systems, Page 204 ff

 of

### **RELATIONSHIPS ERM: MULTIVALUED ATTRIBUTES**

![](_page_13_Figure_1.jpeg)

### **RELATIONSHIPS ERM: COMPLEX ATTRIBUTES**

- Composite and multivalued attributes can be nested arbitrarily
- The combination of composite and multivalued attributes is called *Complex Attribute*
- Example:

Person can have more than one residence and each residence can have a single address and multiple phones

![](_page_14_Picture_5.jpeg)

### **RELATIONSHIPS ERM: DERIVED ATTRIBUTES**

 Stored vs. derived attributes

- Some attribute values can be derived from related entities
- For example: Age can by derived from birthdate

![](_page_15_Picture_4.jpeg)

### **RELATIONSHIPS ERM: DERIVED ATTRIBUTES**

Can you think of a derived attribute?

- The company is organized into departments
- Each department has a unique name, a unique number, a manager (employee) with start date, and several locations
- A department controls a number of projects, each with unique name, unique number, single location
- We store each employee's name, ssn, address, salary, sex, birthdate
- An employee is assigned to one department, but may work on several projects, also from other departments
- We keep track of the hours per week per project
- We also keep track of the supervisor
- We want to keep track of each employee's dependents for insurance purposes, namely first name, sex, birth date, and relationship to employee. Source: Elmasri, Fundamentals

291 Database Systems, Page 204 ff

of

### **RELATIONSHIPS ERM: DERIVED ATTRIBUTES**

![](_page_17_Figure_1.jpeg)

## **RELATIONSHIPS DATABASE DESIGN**

![](_page_18_Figure_1.jpeg)

![](_page_18_Picture_2.jpeg)

![](_page_18_Picture_3.jpeg)

#### **RELATIONSHIPS RM: MAPPING OF ERM TO RELATIONAL MODEL**

## Seven Steps

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

294 Source: Elmasri, Fundamentals of Database Systems, Page 286ff

![](_page_19_Picture_10.jpeg)

# **RELATIONSHIPS RM: 2. MAPPING OF WEAK ENTITY TYPES**

- For each weak entity type W in the ER schema with owner entity type E, create a relation R and include all simple attributes (or simple components of composite attributes) of W as attributes of R
- In addition, include as foreign key attributes of R, the primary key attribute(s) of the relation(s) that correspond to the owner entity type(s); this takes care of mapping the identifying relationship type of W
- The primary key of R is the combination of the primary key(s) of the owner(s) and the partial key of the weak entity type W, if any

295 Source: Elmasri, Fundamentals of Database Systems, Page 286ff

# **RELATIONSHIPS RM: 2. MAPPING OF WEAK ENTITY TYPES**

![](_page_21_Figure_1.jpeg)

296

# **RELATIONSHIPS RM: 6. MAPPING OF MULTIVALUED ATTRIBUTES**

- For each multivalued attribute A, create a new relation R
- This relation R will include an attribute corresponding to A, plus the primary key attribute K - as a foreign key in R - of the relation that represents the entity type or relationship type that has A as a multivalued attribute
- The primary key of R is the combination of A and K
- If the multivalued attribute is composite, we include its simple components

![](_page_22_Picture_5.jpeg)

![](_page_23_Figure_0.jpeg)

- Attribute Dlocation represents the multivalued attribute LOCATIONS of DEPARTMENT
- Attribute Dnumber represents the primary key of DEPARTMENT
- The primary key of DEPT\_LOCATIONS is the combination of {Dnumber, Dlocation}
- A separate tuple will exist in DEPT\_LOCATIONS for each location that a department has

298 Source: Elmasri, Fundamentals of Database Systems, Page 286ff

#### **RELATIONSHIPS RM: MAPPING OF ERM TO RELATIONAL MODEL**

## Seven Steps

- 1. 2. 3. 4. 5. 6.
- Mapping of regular entity types
- Mapping of weak entity types Mapping of binary 1:1 relationships
- Mapping of binary 1:n relationships
- Mapping of binary m:n relationships
- Mapping of multivalued attributes
- 7. Mapping of n-ary relationships

299 Source: Elmasri, Fundamentals of Database Systems, Page 286ff

![](_page_24_Picture_10.jpeg)

## **RELATIONSHIPS DATABASE DESIGN**

![](_page_25_Figure_1.jpeg)

![](_page_25_Picture_2.jpeg)

![](_page_25_Picture_3.jpeg)

## **RELATIONSHIPS DATABASE DESIGN**

![](_page_26_Figure_1.jpeg)

![](_page_26_Picture_3.jpeg)

## Example:

- Manufacturers supply items for projects.
- A manufacturer must supply at least one item.
- An article from in-house production does not have to be supplied for a project but can be supplied for many projects.
- A project uses at least one item.
- An item is supplied by only one manufacturer for a project.

Question 1 (Cardinality): Can an entity of entity type A and an entity of entity type B be related to multiple entities of entity type C?

Question 2 (Participation): Must an entity type A be related to at least one entity type B and one entity type C?

![](_page_27_Figure_9.jpeg)

1

PROFESSOR

## Example:

 To prevent students from concentrating on one professor, they may only work with one professor on one seminar topic.

- In addition, a student can only work on a seminar topic with one professor.
- However, a professor may assign a seminar topic more than once.
- Students must attend seminars, but seminar topics do not have to be chosen.

SUPPLIES

TOPIC

1

![](_page_28_Figure_6.jpeg)

m

Question 1 (Cardinality): Can an entity of entity type A and an entity of entity type B be related to multiple entities of entity type C?

Question 2 (Participation): Must an entity type A be related to at least one entity type B and one entity type C?

STUDENT

![](_page_28_Figure_9.jpeg)

#### Example:

![](_page_29_Figure_2.jpeg)

![](_page_29_Picture_4.jpeg)

- Higher degree relationship type: Literature recommendations for specific courses
- Example:

![](_page_30_Figure_3.jpeg)

**Databases, © Ulrike Herster, partially © Elmasri "Fundamentals of Database Systems – For personal use only**

![](_page_30_Picture_5.jpeg)

- In many CASE tools, only binary relationship types can be represented
- Ternary relationship type is replaced by (weak) entity type + relationship types
- Example:

![](_page_31_Figure_4.jpeg)

**Databases, © Ulrike Herster, partially © Elmasri "Fundamentals of Database Systems – For personal use only**

![](_page_31_Picture_6.jpeg)

## **RELATIONSHIPS DATABASE DESIGN**

![](_page_32_Figure_1.jpeg)

**Databases, © Ulrike Herster, partially © Elmasri "Fundamentals of Database Systems – For personal use only**

![](_page_32_Picture_3.jpeg)

#### **RELATIONSHIPS RM: MAPPING OF ERM TO RELATIONAL MODEL**

## Seven Steps

- 1. 2. 3. 4. 5. 6.
- Mapping of regular entity types Mapping of weak entity types
- Mapping of binary 1:1 relationships
- Mapping of binary 1:n relationships
- Mapping of binary m:n relationships
- Mapping of multivalued attributes
- 7. Mapping of n-ary relationships

308 Source: Elmasri, Fundamentals of Database Systems, Page 286ff

![](_page_33_Picture_10.jpeg)

### **RELATIONSHIPS RM: 7. MAPPING OF N-ARY RELATIONSHIP TYPES**

- For each n-ary relationship type R, where n > 2, create a new relation S to represent R
- Include as foreign key attributes in S the primary keys of the relations that represent the participating entity types
- Also include any simple attributes of the n-ary relationship type (or simple components of composite attributes) as attributes of S
- The primary key of S is usually a combination of all the foreign keys that reference the relations representing the participating entity types

**Databases, © Ulrike Herster, partially © Elmasri "Fundamentals of Database Systems – For personal use only** 309 Source: Elmasri, Fundamentals of Database Systems, Page 286ff

### **RELATIONSHIPS RM: 7. MAPPING OF N-ARY RELATIONSHIP TYPES**

![](_page_35_Figure_1.jpeg)

![](_page_35_Picture_2.jpeg)

#### **RELATIONSHIPS RM: MAPPING OF ERM TO RELATIONAL MODEL**

## Seven Steps

![](_page_36_Picture_2.jpeg)

Mapping of regular entity types Mapping of weak entity types Mapping of binary 1:1 relationships Mapping of binary 1:n relationships Mapping of binary m:n relationships Mapping of multivalued attributes Mapping of n-ary relationships

> 311 Source: Elmasri, Fundamentals of Database Systems, Page 286ff

![](_page_36_Picture_5.jpeg)

#### **RELATIONSHIPS MAPPING OF ERM TO RELATIONAL MODEL - SUMMARY**

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

312 Source: Elmasri, Fundamentals of Database Systems, Page 286ff

![](_page_37_Picture_4.jpeg)

## **ORGANIZATION OUR JOURNEY IN THIS SEMESTER**

![](_page_38_Picture_1.jpeg)

- Integrity, Trigger & Security
- Database Applications
- Transactions
- Subqueries & Views
- More SQL Features
- Notations & Guidelines
- **Constraints**
- Relationships
- Simple Entities and Attributes
- Basics

313 Source: Foto von Justin Kauffman auf Unsplash

![](_page_38_Picture_13.jpeg)

![](_page_39_Picture_0.jpeg)

![](_page_39_Picture_1.jpeg)

Three categories

- 1. Constraints that are inherent in the data model *inherent model-based constraints* or *implicit constraints* Example: no duplicate tuples in a relation
- 2. Constraints that can be directly expressed in schemas of the data model *schema-based constraints* or *explicit constraints* Example: Domain constraints, key constraints, constraints on NULL, entity integrity constraints and referential integrity constraints
- 3. Constraints that cannot be directly expressed in the schemas of the data model, and hence must be expressed and enforced by the application programs *application-based* or *semantic constraints* or *business rules*

314 Source: Elmasri, Fundamentals of Database Systems, Page 59ff

# **CONSTRAINTS SQL**

 Syntax for creating an empty table

```
CREATE TABLE < relationname >
         (<column> <type> [ DEFAULT expr ]
                  [ [NOT] NULL ] [ colconstraint ] *
         [,{<column> <type> [ DEFAULT expr ]
                  [ [NOT] NULL ] [ colconstraint ] *
          | <tableconstraint> } ] *
         ) ;
```
 Some constraints (e.g., **UNIQUE, NOT NULL)** can be defined as column constraints or as table constraints

> 315 Source: Elmasri, Fundamentals of Database Systems, Page 88ff

![](_page_40_Picture_5.jpeg)

![](_page_40_Picture_6.jpeg)

### **CONSTRAINTS ERM: KEY ATTRIBUTES (IDENTIFYING ATTRIBUTES)**

- How can we identify an actual entity within an entity set?
- Attributes must be used
	- → Key Attributes (also called identifying attributes)
- Sometimes several attributes together form a key attribute (identifying attribute), meaning that the combination of the attribute values must be distinct for each entity
	- If a set of attributes possesses this property, the proper way to represent this in the ER model that is to define a *composite attribute* and designate it as a key attribute of the entity type
	- Notice that such a composite key attributes must be minimal; that is, all component attributes must be included in the composite attribute to have the uniqueness property
- Key attributes are underlined
- If two attributes are underlined separately, then each is an identifying attribute on its own Source: Elmasri, Fundamentals

**Databases, © Ulrike Herster, partially © Elmasri "Fundamentals of Database Systems – For personal use only**

![](_page_41_Picture_10.jpeg)

316

 of

![](_page_41_Picture_11.jpeg)

Database Systems, Page 204 ff

## **CONSTRAINTS RM: PRIMARY KEY**

![](_page_42_Picture_1.jpeg)

#### Primary Key

- Also called *Entity Integrity Constraint*
- PK values must be unique and cannot be NULL!
- Notation: underlined

| I<br>S<br>B<br>N                                                          | T<br>i<br>l<br>t<br>e                                                                                                                                   | A<br>h<br>t<br>u<br>o<br>r                               | P<br>b<br>l<br>i<br>h<br>u<br>s<br>e<br>r                | Y<br>e<br>a<br>r | P<br>i<br>r<br>c<br>e |
|---------------------------------------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------|----------------------------------------------------------|------------------|-----------------------|
| 9<br>7<br>8<br>1-<br>2<br>9<br>2<br>0<br>9<br>7<br>6<br>1-<br>9<br>-<br>- | F<br>d<br>l<br>f<br>t<br>n<br>a<br>m<br>e<br>n<br>a<br>s<br>o<br>u<br>D<br>b<br>S<br>t<br>t<br>a<br>a<br>a<br>s<br>e<br>y<br>s<br>e<br>m<br>s           | R<br>E<br>l<br>i<br>a<br>m<br>e<br>m<br>a<br>s<br>r<br>z | P<br>i<br>H<br>l<br>l<br>t<br>r<br>e<br>n<br>c<br>e<br>a | 2<br>0<br>1<br>6 | 5<br>9<br>9<br>9<br>, |
| 9<br>7<br>8<br>0<br>3<br>2<br>1<br>1<br>9<br>7<br>8<br>4<br>9<br>-        | A<br>I<br>d<br>i<br>t<br>t<br>t<br>n<br>n<br>r<br>o<br>c<br>o<br>n<br>o<br>u<br>D<br>b<br>S<br>t<br>t<br>a<br>a<br>a<br>s<br>e<br>y<br>s<br>e<br>m<br>s | C<br>J<br>D<br>t<br>a<br>e                               | P<br>e<br>a<br>r<br>s<br>o<br>n                          | 2<br>0<br>0<br>3 | 6<br>9<br>9<br>2<br>, |
| …                                                                         | …                                                                                                                                                       | …                                                        |                                                          |                  |                       |

**Databases, © Ulrike Herster, partially © Elmasri "Fundamentals of Database Systems – For personal use only**

![](_page_42_Picture_8.jpeg)

- A domain D is a set of atomic values
- Atomic means that each value is indivisible
- A common method of specifying a domain is to specify a data type from which the data values forming the domain are drawn
- It is also useful to specify a name for the domain, to help in interpreting its values
- Example:

- *Names*: The set of character strings that represent names of persons
- *Employee\_age*: Possible ages of employees in a company; each must be an integer value between 16 and 70

318 Source: Elmasri, Fundamentals of Database Systems, Page 59ff

![](_page_43_Picture_9.jpeg)

![](_page_43_Picture_10.jpeg)

- Domain constraints specify that within each tuple, the value of each attribute A must be an atomic value from the domain domሺAሻ
- Data types
	- Numeric data types: short integer, integer, long integer
	- Real numbers: float, double
	- Characters
	- Booleans
	- Fixed-length or variable-length strings
	- Date
	- …

Also, possible subrange of values from a data types and enumerated data types

319 Source: Elmasri, Fundamentals of Database Systems, Page 59ff

![](_page_44_Picture_12.jpeg)

![](_page_44_Picture_13.jpeg)

- For example: Employee must be between 16 and 70 years old
- Value sets are not displayed in ER diagrams, and are typically specified using the basic data types available in most programming languages

![](_page_45_Figure_3.jpeg)

![](_page_45_Picture_4.jpeg)

 Example: 

- Employee\_age: integer number between 16 and 70
- Mobile\_Number: (dd)ddd-ddddddd d is a decimal digit
- A domain is thus given a name, data type, and format

![](_page_46_Picture_5.jpeg)

![](_page_46_Picture_6.jpeg)

![](_page_47_Figure_1.jpeg)

- **CREATE DOMAIN** is part of the ANSI Standard But almost all RDBMS ignore this command
- A domain is simply a self-defined data type More precise it is a limitation of the values range of a data type
- For example:
	- You want to save the age of a person, you could use **INTEGER**
	- Now you could save a value from -2,147,483,648 to 2,147,483,647
	- No person will reach an age of 2,147,483,647 years, neither can someone be younger than 0
- By creating a domain, you could design a useful value range (e.g., 0 => column =< 100).
- For using a domain, you just type the domain-name instead of a data type

![](_page_47_Picture_10.jpeg)

322

![](_page_48_Figure_1.jpeg)

 Based on base data type ... with additional constraints Syntax: **CREATE DOMAIN** <name> [ **AS** ] datatype [ **DEFAULT** expession] [ constraint [ . . . ] ] ; [ **CONSTRAINT** constraint\_name] { **NOT NULL** | **NULL** | **CHECK** ( expression ) Example: **CREATE DOMAIN** nnint **AS INT NOT NULL** ; **CREATE DOMAIN** posint **AS INT CHECK** ( **VALUE** >= 0 ) ; **CREATE DOMAIN** dayofweek **AS VARCHAR CHECK** ( **VALUE IN** ( 'Monday' , 'Tuesday' , ...)) ; **CREATEDOMAIN**SSNTYPE**ASCHAR**(9);

**Databases, © Ulrike Herster, partially © Elmasri "Fundamentals of Database Systems – For personal use only**

![](_page_48_Picture_4.jpeg)

323

}

#### **CONSTRAINTS DOMAINS: SQL - CHECK**

- One option to implement domains in mySQL
- colconstraint = Column constraint
	- **CHECK**

 Constraint can restrict attribute or domain values using the **CHECK** clause following an attribute or domain definition

 Example:

Dnumber **INT NOT NULL CHECK** (Dnumber > 0 **AND** Dnumber < 21);

> 324Source: Elmasri, Fundamentals of Database Systems, Page 88ff

![](_page_49_Picture_8.jpeg)

![](_page_49_Picture_9.jpeg)

### **CONSTRAINTS DOMAINS: SQL - CHECK**

 Tuple-based constraints

- Semantical Integrity
- Apply to each tuple individually and are checked whenever a tuple is inserted or modified
- Makes sure that condition is met ... or NULL!
- Typical use case: Range checking Example: **CONSTRAINT** chk\_age **CHECK** (age ≥ 18)
- Also, complex conditions possible (verify relationships with other rows and/or tables) Example: **CHECK** (Dept\_create\_date <= Mgr\_start\_date);

325 Source: Elmasri, Fundamentals of Database Systems, Page 88ff

![](_page_50_Picture_8.jpeg)

### **CONSTRAINTS DOMAINS: SQL - CHECK**

 The **CHECK** clause can also be used in conjunction with the **CREATE DOMAIN** statement if supported by the DBMS

For example, we can write the following statement:

> **CREATE DOMAIN** D\_NUM **AS INTEGER CHECK** (D\_NUM > 0 **AND** D\_NUM < 21 );

![](_page_51_Picture_4.jpeg)

326 Source: Elmasri, Fundamentals of Database Systems, Page 88ff

![](_page_51_Picture_6.jpeg)

![](_page_52_Picture_1.jpeg)

- Constraint on attributes specifies whether NULL values are or are not permitted
- NULL: special attribute value
	- Value unknown (exists but is intentionally withheld)
		- A person's date of birth is not known, so it is represented by NULL in the data base
	- Unavailable or withheld value (exists but is not known)
		- A person has a home phone but does not want it to be listed, so it is withheld and represented as NULL in the database.
	- Not applicable (the attribute is undefined for this tupel)
		- Student's name has no middle initials, student has no academic degree, ...
- Example: primary key

327 Source: Elmasri, Fundamentals of Database Systems, Page 59ff

![](_page_52_Picture_12.jpeg)

#### NULL Values

 A particular entity may not have an applicable value for an attribute, 

![](_page_53_Figure_3.jpeg)

 NULL can also be used if we do not know the value of an attribute for a particular entity

![](_page_53_Picture_5.jpeg)

![](_page_54_Picture_1.jpeg)

Syntax for creating an empty table:

```
CREATE TABLE < relationname >
         (<column> <type> [ DEFAULT expr ]
                  [ [NOT] NULL ] [ colconstraint ] *
         [,{<column> <type> [ DEFAULT expr ]
                  [ [NOT] NULL ] [ colconstraint ] *
          | <tableconstraint> } ] *
         ) ;
```
329 Source: Elmasri, Fundamentals of Database Systems, Page 88ff

![](_page_54_Picture_5.jpeg)

#### NULL:

- "no information available"
- "no information available yet"
- "unknown"
- "not applicable"
- Examples:

- Birthdate
- Apartment Number
- Minit

![](_page_55_Picture_10.jpeg)

![](_page_55_Picture_11.jpeg)

![](_page_55_Picture_12.jpeg)

![](_page_56_Picture_1.jpeg)

- **NOT NULL** mandatory field, a value is needed
- Default: **NULL** optional field, NULL is allowed
- This is always implicitly specified for the attributes of the primary key of each relation
- Attention: Most attributes should be NOT NULL!!

![](_page_56_Picture_6.jpeg)

![](_page_56_Picture_8.jpeg)

# **CONSTRAINTS UNIQUE**

- UNIQUE constraint prevents duplicates in a column, i.e., a duplicate entry is not valid in a unique column
- A *unique key* is a candidate key
- All the candidate keys of a relation can uniquely identify the records of the relation, but only one of them is used as the primary key of the relation
- Example: primary key

![](_page_57_Picture_5.jpeg)

![](_page_57_Picture_6.jpeg)

# **CONSTRAINTS UNIQUE**

- Additional identifying attributes: alternate (secondary) keys
- In SQL: **UNIQUE**

**Databases, © Ulrike Herster, partially**

- Unique elements can be NULL
	- ... in some implementations
	- Thinking of key: should not be nullable

 Unique: could be null (several nulls allowed!)

![](_page_58_Picture_7.jpeg)

# **CONSTRAINTS UNIQUE**

 As column constraint

> Dname **VARCHAR**(15) **UNIQUE** ;

 As table constraint

```
CREATE TABLE Department
( Dname VARCHAR(15) NOT NULL Dnumber INT NOT NULL …
PRIMARY KEY ( Dnumber ) ,
UNIQUE ( Dname ),
… );
```
334 Source: Elmasri, Fundamentals of Database Systems, Page 88ff

![](_page_59_Picture_6.jpeg)

,

,

![](_page_59_Picture_7.jpeg)

#### **CONSTRAINTS ERM: RELATIONSHIP TYPES**

![](_page_60_Picture_1.jpeg)

 Cardinality

- Specifies the maximum number of relationship instances that an entity can participate in
- Cardinality ratios
	- 1:1
	- 1:N
	- M:N
- Cardinality ratios for binary relationships are represented on ER diagrams by displaying 1, M, and N on the diamonds
- Notice that in this notation, we can either specify no maximum (N) or a maximum of one (1) on participation

335 Source: Elmasri, Fundamentals of Database Systems, Page 212 ff

### **CONSTRAINTS ERM: RELATIONSHIP TYPES**

![](_page_61_Picture_1.jpeg)

 Participation

- Specifies whether the existence of an entity depends on its being related to another entity via the relationship type
- Also called *minimum cardinality constraint*
- Two types

- Total: every entity in the total set of all entities of an entity type A must be related to an entity of entity type B via a relationship
	- Total participation is also called *existence dependency*
		- Is displayed as a double line connecting the participating entity type to the relationship
- Partial: some or part of the entities of an entity type A are related to some entities of an entity type B via a relationship
	- Is displayed by a single line connecting the participating entity type to the relationship336

![](_page_61_Picture_11.jpeg)

![](_page_61_Picture_12.jpeg)

### **CONSTRAINTS ERM: RELATIONSHIP TYPES**

![](_page_62_Picture_1.jpeg)

#### Cardinality

specifies the maximum number of relationship instances that an entity can participate in

#### Participation

 specifies if the existence of an entity depends on its being related to another entity via the relationship type

*minimum cardinality constraint*

![](_page_62_Picture_7.jpeg)

### **CONSTRAINTS RM: REFERENTIAL INTEGRITY CONSTRAINT**

![](_page_63_Picture_1.jpeg)

- It is defined between two relations
- It is used to maintain the consistency among tules in the two relations: a tuple in one relation that refers to another relation must refer to an existing tuple in that relation
- *Foreign key*: a set of attributes FK in relation schema ଵ is a foreign key of ଵ that references relation ଶ if it satisfies the following rules:
	- 1. The attributes in FK have the same domain(s) as the primary key attributes PK of ଶ ; the attributes FK are said to *reference* or *refer to* the relation ଶ
	- 2. A value of FK in a tuple ଵ of the current state ଵሺଵሻ either occurs as a value of PK for some tuple ଶ in the current state ଶሺଶሻ or is NULL. In the former case, we have ଵ ൌ ଶ , and we say that the tuple ଵ references or refers to the tuple ଶ

338 Source: Elmasri, Fundamentals of Database Systems, Page 59ff

![](_page_63_Picture_8.jpeg)

![](_page_64_Picture_1.jpeg)

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
![](_page_64_Picture_8.jpeg)

![](_page_64_Picture_9.jpeg)

![](_page_65_Picture_1.jpeg)

Example column constraint:

#### **CREATE TABLE** Department

| (<br>D<br>n<br>a<br>m<br>e                                                                       | (<br>)<br>V<br>A<br>R<br>C<br>H<br>A<br>R<br>1<br>5 | O<br>N<br>T<br>N<br>U<br>L<br>L<br>,           |                                                               |   |
|--------------------------------------------------------------------------------------------------|-----------------------------------------------------|------------------------------------------------|---------------------------------------------------------------|---|
| b<br>D<br>n<br>u<br>m<br>e<br>r                                                                  | I<br>N<br>T                                         | O<br>N<br>T<br>N<br>U<br>L<br>L<br>,           |                                                               |   |
| M<br>g<br>r_<br>s<br>s<br>n                                                                      | (<br>)<br>C<br>9<br>H<br>A<br>R                     | C<br>S<br>R<br>E<br>F<br>E<br>R<br>E<br>N<br>E | (<br>)<br>l<br>S<br>E<br>m<br>p<br>o<br>y<br>e<br>e<br>s<br>n | , |
| d<br>t<br>t<br>t<br>M<br>g<br>r_<br>s<br>a<br>r<br>a<br>e<br>_                                   | D<br>A<br>T<br>E<br>,                               |                                                |                                                               |   |
| (<br>)<br>b<br>P<br>R<br>I<br>M<br>A<br>R<br>Y<br>K<br>E<br>Y<br>D<br>n<br>u<br>m<br>e<br>r<br>, |                                                     |                                                |                                                               |   |
| (<br>)<br>)<br>Q<br>U<br>N<br>I<br>U<br>E<br>D<br>n<br>a<br>m<br>e<br>;                          |                                                     |                                                |                                                               |   |

340 Source: Elmasri, Fundamentals of Database Systems, Page 88ff

![](_page_65_Picture_7.jpeg)

![](_page_66_Picture_1.jpeg)

Example table constraint:

#### **CREATE TABLE** Department

| (<br>D<br>n<br>a<br>m<br>e                                              | (<br>)<br>V<br>A<br>R<br>C<br>H<br>A<br>R<br>1<br>5 | N<br>O<br>T<br>N<br>U<br>L<br>L<br>,                                                   |                                                                                                                                                                                                                                                                          |
|-------------------------------------------------------------------------|-----------------------------------------------------|----------------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| b<br>D<br>n<br>u<br>m<br>e<br>r                                         | I<br>N<br>T                                         | O<br>N<br>T<br>N<br>U<br>L<br>L<br>,                                                   |                                                                                                                                                                                                                                                                          |
| M<br>g<br>r_<br>s<br>s<br>n                                             | (<br>)<br>C<br>9<br>H<br>A<br>R                     | O<br>N<br>T<br>N<br>U<br>L<br>L<br>,                                                   |                                                                                                                                                                                                                                                                          |
| d<br>t<br>t<br>t<br>M<br>g<br>r_<br>s<br>a<br>r<br>a<br>e<br>_          | D<br>A<br>T<br>E<br>,                               |                                                                                        |                                                                                                                                                                                                                                                                          |
| (<br>P<br>R<br>I<br>M<br>A<br>R<br>Y<br>K<br>E<br>Y<br>D<br>n<br>u<br>m | )<br>b<br>e<br>r<br>,                               |                                                                                        |                                                                                                                                                                                                                                                                          |
| (<br>)<br>Q<br>U<br>N<br>I<br>U<br>E<br>D<br>n<br>a<br>m<br>e<br>,      |                                                     |                                                                                        |                                                                                                                                                                                                                                                                          |
| (<br>O<br>G<br>F<br>R<br>E<br>I<br>N<br>K<br>E<br>Y<br>M<br>g<br>r_     | )<br>R<br>E<br>F<br>E<br>R<br>E<br>N<br>s<br>s<br>n | (<br>)<br>)<br>l<br>C<br>S<br>S<br>E<br>E<br>m<br>p<br>o<br>y<br>e<br>e<br>s<br>n<br>; |                                                                                                                                                                                                                                                                          |
|                                                                         |                                                     |                                                                                        | S<br>E<br>l<br>i,<br>F<br>d<br>l<br>f<br>t<br>o<br>u<br>r<br>c<br>e<br>:<br>m<br>a<br>s<br>r<br>u<br>n<br>a<br>m<br>e<br>n<br>a<br>s<br>o<br>D<br>b<br>S<br>P<br>8<br>8<br>f<br>f<br>t<br>t<br>34<br>1<br>a<br>a<br>a<br>s<br>e<br>y<br>s<br>e<br>m<br>s,<br>a<br>g<br>e |
|                                                                         |                                                     |                                                                                        |                                                                                                                                                                                                                                                                          |

![](_page_67_Picture_1.jpeg)

#### < action >:

How to react on changes to the referenced table

- The default action: reject the update operation (**RESTRICT** option)
- Syntax

![](_page_67_Picture_6.jpeg)

![](_page_68_Picture_1.jpeg)

#### Options:

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

343 Source: Elmasri, Fundamentals of Database Systems, Page 88ff

![](_page_68_Picture_14.jpeg)

![](_page_69_Picture_1.jpeg)

**CREATE TABLE** Employee ( . . . , Dno **INT NOT NULL DEFAULT** 1, **CONSTRAINT** EMPPK **PRIMARY KEY** (Ssn), **CONSTRAINT** EMPSUPERFK **FOREIGN KEY** (Super\_ssn) **REFERENCES** Employee(Ssn) **ON DELETE SET NULL ON UPDATE CASCADE**, **CONSTRAINT** EMPDEPTFK **FOREIGN KEY**(Dno) **REFERENCES** Department(Dnumber) **ON DELETE SET DEFAULT ON UPDATE CASCADE**);

> 344 Source: Elmasri, Fundamentals of Database Systems, Page 88ff

![](_page_69_Picture_5.jpeg)

![](_page_70_Picture_1.jpeg)

- All constraints get an identifier ... if not by you, then by the system
- Problems with system generated identifiers Bad error messages
- Maybe we want to alter or drop the constraint later? Then we need its name!
- Exception: NOT NULL constraints no need for identifier
- The names of all constraints within a particular schema must be unique

![](_page_70_Picture_7.jpeg)

![](_page_70_Picture_8.jpeg)

![](_page_71_Picture_1.jpeg)

**CREATE TABLE** Employee ( . . . , Dno **INT NOT NULL DEFAULT** 1, **CONSTRAINT** EMPPK **PRIMARY KEY** (Ssn), **CONSTRAINT** EMPSUPERFK **FOREIGN KEY** (Super\_ssn) **REFERENCES** EMPLOYEE(Ssn) **ON DELETE SET NULL ON UPDATE CASCADE**, **CONSTRAINT** EMPDEPTFK **FOREIGN KEY**(Dno) **REFERENCES** Department(Dnumber) **ON DELETE SET DEFAULT ON UPDATE CASCADE**);

> 346 Source: Elmasri, Fundamentals of Database Systems, Page 88ff

![](_page_71_Picture_5.jpeg)

# **CONSTRAINTS OTHER CONSTRAINTS**

- Semantic integrity constraints
	- Example: The maximum number of hours an employee can work on all projects per week is 56
	- Realization:

- Within the application programs or
- Constraint specification language, e.g., trigger and assertions
- Functional dependencies constraint
	- It establishes a functional relationship among two sets of attributes X and Y
	- This constraint specifies that the value of X determines a unique value of Y in all states of a relation
	- It is denoted as a functional dependency X → Y

347 Source: Elmasri, Fundamentals of Database Systems, Page 59ff

![](_page_72_Picture_11.jpeg)

![](_page_72_Picture_12.jpeg)

# **CONSTRAINTS OVERVIEW**

| C<br>t<br>i<br>t<br>o<br>n<br>s<br>r<br>a<br>n                                                                                                                                             | N<br>b<br>f<br>f<br>f<br>t<br>d<br>R<br>l<br>t<br>i<br>m<br>e<br>r<br>o<br>a<br>e<br>c<br>e<br>e<br>a<br>o<br>n<br>s<br>u |
|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|---------------------------------------------------------------------------------------------------------------------------|
| D<br>i<br>t<br>i<br>t<br>o<br>m<br>a<br>n<br>c<br>o<br>n<br>s<br>r<br>a<br>n<br>s                                                                                                          | 1                                                                                                                         |
| C<br>i<br>N<br>U<br>L<br>L<br>t<br>t<br>o<br>n<br>s<br>r<br>a<br>n<br>s<br>o<br>n                                                                                                          | 1                                                                                                                         |
| (<br>)<br>E<br>t<br>i<br>t<br>i<br>t<br>i<br>t<br>t<br>i<br>t<br>i<br>k<br>n<br>y<br>n<br>e<br>g<br>r<br>y<br>c<br>o<br>n<br>s<br>r<br>a<br>n<br>s<br>p<br>r<br>m<br>a<br>r<br>y<br>e<br>y | 1                                                                                                                         |
| R<br>f<br>i<br>l<br>i<br>i<br>i<br>t<br>t<br>t<br>t<br>t<br>e<br>e<br>r<br>e<br>n<br>a<br>n<br>e<br>g<br>r<br>y<br>c<br>o<br>n<br>s<br>r<br>a<br>n<br>s                                    | 1<br>≥                                                                                                                    |
| S<br>t<br>i<br>i<br>t<br>i<br>t<br>t<br>i<br>t<br>e<br>m<br>a<br>n<br>c<br>n<br>e<br>g<br>r<br>c<br>o<br>n<br>s<br>r<br>a<br>n<br>s<br>y                                                   | 1<br>≥                                                                                                                    |
| F<br>t<br>i<br>l<br>d<br>d<br>i<br>t<br>i<br>t<br>u<br>n<br>c<br>o<br>n<br>a<br>e<br>p<br>e<br>n<br>e<br>n<br>c<br>e<br>s<br>c<br>o<br>n<br>s<br>r<br>a<br>n                               | 1<br>≥                                                                                                                    |

**Databases, © Ulrike Herster, partially © Elmasri "Fundamentals of Database Systems – For personal use only**

![](_page_73_Picture_3.jpeg)

## **ORGANIZATION OUR JOURNEY IN THIS SEMESTER**

![](_page_74_Picture_1.jpeg)

- Integrity, Trigger & Security
- Database Applications
- Transactions
- Subqueries & Views
- More SQL Features
- **Notations & Guidelines**
- Constraints
- Relationships
- Simple Entities and Attributes
- Basics

349 Source: Foto von Justin Kauffman auf Unsplash

![](_page_74_Picture_13.jpeg)

## **NOTATIONS AND GUIDELINES DATABASE DESIGN**

![](_page_75_Figure_1.jpeg)

![](_page_75_Picture_2.jpeg)

![](_page_75_Picture_3.jpeg)

![](_page_76_Figure_1.jpeg)

**Databases, © Ulrike Herster, partially © Elmasri "Fundamentals of Database Systems – For personal use only**

![](_page_76_Picture_3.jpeg)

351

 of

![](_page_77_Figure_1.jpeg)

352 Source: Elmasri, Fundamentals of Database Systems, Page 223

 Names

- Entity type and relationship type names:
	- uppercase letters
- Attribute names
	- initial letter capitalized
- Role names
	- lowercase letters
- Binary relationship names to make the ER diagram of the schema readable from left to right and from top to bottom

![](_page_78_Picture_9.jpeg)

- In general, the schema design process should be considered an iterative refinement process
- An attribute may be refined to a relationship if it is a reference to another entity type
- If an attribute exists in several entity types, it may be promoted to an independent entity type
- If an entity type A exists in the initial design with a single attribute and is related to only one other entity type B, the entity type A may be reduced or demoted to an attribute of entity type B

![](_page_79_Picture_6.jpeg)

![](_page_80_Figure_1.jpeg)

# **NOTATIONS AND GUIDELINES ERM: UML NOTATION**

![](_page_81_Figure_1.jpeg)

**Databases, © Ulrike Herster, partially © Elmasri "Fundamentals of Database Systems – For personal use only**

![](_page_81_Picture_3.jpeg)

356

 of

- Participation constraints
- Relationships can be mandatory or optional
- Types
	- Exactly one element: 1
	- One or no element: c (or 1c)
	- No or many elements: mc (or nc)
	- One or many elements: m (or n)

![](_page_82_Picture_8.jpeg)

![](_page_82_Picture_9.jpeg)

| Chen-Notation                   | MC-Notation |
|---------------------------------|-------------|
| 1:1                             | C:C         |
| 1:N                             | C:mC        |
| 1:N + total participation       | 1:mc        |
| M-N                             | mc:mc       |
| total participation + 1:1       | C:1         |
| total participation + 1:N       | C:m         |
| total part. + 1:1 + total part. | 1:1         |
| total part. + 1:N + total part. | 1:m         |
| total participation + M:N       | mc:m        |
| total part. + M:N + total part. | m:m         |

Source: https://de.wikipedia.org/wiki/Min-Max-Notation 358

![](_page_83_Picture_3.jpeg)

 Every lecturer teaches at least one course; Every course is taught by at least one lecturer

![](_page_84_Figure_2.jpeg)

 Every lecturer teaches arbitrary many courses (or no course); Every course is taught by at least one lecturer

![](_page_84_Figure_4.jpeg)

 Every person has one or more addresses Every address belongs to at least one person

![](_page_85_Figure_2.jpeg)

 What about homeless people?

![](_page_85_Figure_4.jpeg)

![](_page_85_Picture_5.jpeg)

 Every person owns no, one, or more bikes Every bike has exactly one owner.

![](_page_86_Figure_2.jpeg)

 A person is married to no or exactly one person

![](_page_86_Figure_4.jpeg)

**Databases, © Ulrike Herster, partially © Elmasri "Fundamentals of Database Systems – For personal use only**

![](_page_86_Picture_6.jpeg)

#### Binary 1:N Relationships

Chen Notation

![](_page_87_Figure_3.jpeg)

 MC Notation

![](_page_87_Figure_5.jpeg)

**Databases, © Ulrike Herster, partially © Elmasri "Fundamentals of Database Systems – For personal use only**

![](_page_87_Picture_7.jpeg)

- CEO - Company ?:?
- Country - King ?:?
- University - Student ?:?
- Person - Car ?:?
- Student - Course ?:?
- Customer - Article ?:?
- Customer - Invoice ?:?

![](_page_88_Picture_8.jpeg)

**Databases, © Ulrike Herster, partially © Elmasri "Fundamentals of Database Systems – For personal use only**

### **NOTATIONS AND GUIDELINES ERM: MC NOTATION - TENARY RELATIONSHIP**

Example:

- Manufacturers supply items for projects.
- A manufacturer must supply at least one item.
- An article from in-house production does not have to be supplied for a project but can be supplied for many projects.
- A project uses at least one item.
- An item is supplied by only one manufacturer for a project.

 **TYPES** Question 1 (Cardinality): Can an entity of entity type A and an entity of entity type B be related to multiple entities of entity type C?

Question 2 (Participation): Must an entity type A be related to at least one entity type B and one entity type C?

364ARTICLE SUPPLIED\_BY MANUFACTURER PROJECT nc 1 m

![](_page_89_Picture_11.jpeg)

#### **NOTATIONS AND GUIDELINES ERM: MC NOTATION - TENARY RELATIONSHIP**

c

Example:

 To prevent students from concentrating on one professor, they may only work with one professor on one seminar topic.

- In addition, a student can only work on a seminar topic with one professor.
- However, a professor may assign a seminar topic more than once.
- Students must attend seminars, but seminar topics do not have to be chosen.

![](_page_90_Figure_6.jpeg)

m

**Databases, © Ulrike Herster, partially © Elmasri "Fundamentals of Database Systems – For personal use only**

 **TYPES** Question 1 (Cardinality): Can an entity of entity type A and an entity of entity type B be related to multiple entities of entity type C?

Question 2 (Participation): Must an entity type A be related to at least one entity type B and one entity type C?

#### **NOTATIONS AND GUIDELINES ERM: MC NOTATION - TENARY RELATIONSHIP TYPES**

Example:

![](_page_91_Figure_2.jpeg)

![](_page_91_Picture_4.jpeg)

## **NOTATIONS AND GUIDELINES DATABASE DESIGN**

![](_page_92_Figure_1.jpeg)

**Databases, © Ulrike Herster, partially © Elmasri "Fundamentals of Database Systems – For personal use only**

![](_page_92_Picture_3.jpeg)

#### ERM:

- Conceptual Database Design
- Describes a collection of **entities**, also called as real-world **objects** and **relations** between those entities
- Basic elements: **entity type**, **relationship type** and **attributes**
- **Constraints** like C**ardinality**, **Participation ratio** and **Keys**

![](_page_93_Figure_6.jpeg)

#### Relational Model:

- Logical Database Design
- Describes data and relation among those data by tables
- Basic elements: Relations and Attributes

 Constraints: Domain constraints, key constraints, constraints on NULL, entity integrity constraints and referential integrity constraints

## **Relational Model**

![](_page_94_Picture_7.jpeg)

![](_page_95_Figure_1.jpeg)

## **Relational Model**

![](_page_95_Figure_3.jpeg)

![](_page_95_Picture_5.jpeg)

| A<br>t<br>s<br>p<br>e<br>c                               | E<br>R<br>M                                                                                                                                                                                                                                                                                                                                                                                             | R<br>M                                                                                                                                                                                                                                                                                                                                                                |  |
|----------------------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|--|
| B<br>i<br>a<br>s<br>c                                    | I<br>h<br>l<br>l<br>i<br>t<br>t<br>t<br>t<br>r<br>e<br>p<br>r<br>e<br>s<br>e<br>n<br>s<br>e<br>c<br>o<br>e<br>c<br>o<br>n<br>f<br>b<br>j<br>t<br>l<br>l<br>d<br>t<br>i<br>t<br>i<br>o<br>o<br>e<br>c<br>s<br>c<br>a<br>e<br>e<br>n<br>e<br>s<br>d<br>l<br>i<br>b<br>t<br>t<br>a<br>n<br>r<br>e<br>a<br>o<br>n<br>e<br>e<br>e<br>n<br>w<br>h<br>i<br>i<br>t<br>t<br>t<br>o<br>s<br>e<br>e<br>n<br>e<br>s | I<br>h<br>l<br>l<br>i<br>f<br>b<br>l<br>t<br>t<br>t<br>t<br>t<br>r<br>e<br>p<br>r<br>e<br>s<br>e<br>n<br>s<br>e<br>c<br>o<br>e<br>c<br>o<br>n<br>o<br>a<br>e<br>s<br>d<br>t<br>h<br>l<br>t<br>i<br>b<br>t<br>t<br>h<br>a<br>n<br>e<br>r<br>e<br>a<br>o<br>n<br>e<br>w<br>e<br>e<br>n<br>o<br>s<br>e<br>b<br>l<br>t<br>a<br>e<br>s                                     |  |
| D<br>i<br>b<br>e<br>s<br>c<br>r<br>e                     | E<br>R<br>M<br>d<br>i<br>b<br>d<br>t<br>s<br>e<br>s<br>c<br>r<br>e<br>a<br>a<br>a<br>s<br>t<br>i<br>t<br>t,<br>l<br>t<br>i<br>h<br>i<br>t<br>e<br>n<br>y<br>s<br>e<br>r<br>e<br>a<br>o<br>n<br>s<br>p<br>s<br>e<br>d<br>i<br>b<br>t<br>t<br>t<br>a<br>n<br>a<br>r<br>e<br>s<br>u                                                                                                                        | R<br>l<br>i<br>l<br>d<br>l<br>d<br>i<br>b<br>d<br>i<br>t<br>t<br>e<br>a<br>o<br>n<br>a<br>m<br>o<br>e<br>e<br>s<br>c<br>r<br>e<br>s<br>a<br>a<br>n<br>t<br>b<br>l<br>d<br>i<br>t<br>t<br>i<br>b<br>t<br>a<br>a<br>e<br>a<br>s<br>o<br>m<br>a<br>n<br>s<br>a<br>r<br>u<br>e<br>s<br>,<br>,<br>l<br>t<br>p<br>e<br>s<br>u                                               |  |
| R<br>l<br>t<br>i<br>h<br>i<br>e<br>a<br>o<br>n<br>s<br>p | I<br>E<br>R<br>M<br>i<br>t<br>i<br>i<br>t<br>n<br>a<br>n<br>s<br>e<br>a<br>s<br>e<br>r<br>o<br>,<br>d<br>d<br>h<br>t<br>t<br>n<br>e<br>r<br>s<br>a<br>n<br>e<br>u<br>l<br>t<br>i<br>h<br>i<br>b<br>t<br>r<br>e<br>a<br>o<br>n<br>s<br>p<br>s<br>e<br>w<br>e<br>e<br>n<br>t<br>i<br>t<br>i<br>e<br>n<br>e<br>s                                                                                           | C<br>t<br>i<br>l<br>i<br>t<br>i<br>l<br>t<br>o<br>m<br>p<br>a<br>r<br>a<br>v<br>e<br>y,<br>s<br>e<br>s<br>s<br>e<br>a<br>s<br>y<br>o<br>d<br>i<br>l<br>i<br>b<br>b<br>l<br>i<br>t<br>t<br>t<br>e<br>r<br>e<br>a<br>r<br>e<br>a<br>o<br>n<br>e<br>e<br>e<br>n<br>a<br>e<br>s<br>n<br>v<br>w<br>l<br>t<br>i<br>l<br>d<br>l<br>r<br>e<br>a<br>o<br>n<br>a<br>m<br>o<br>e |  |
| M<br>i<br>a<br>p<br>p<br>n<br>g                          | E<br>R<br>M<br>d<br>i<br>b<br>i<br>e<br>s<br>c<br>r<br>e<br>s<br>m<br>a<br>p<br>p<br>n<br>g<br>d<br>i<br>l<br>i<br>i<br>t<br>c<br>a<br>r<br>n<br>a<br>e<br>s                                                                                                                                                                                                                                            | R<br>l<br>t<br>i<br>l<br>d<br>l<br>d<br>t<br>d<br>i<br>b<br>e<br>a<br>o<br>n<br>a<br>m<br>o<br>e<br>o<br>e<br>s<br>n<br>o<br>e<br>s<br>c<br>r<br>e<br>i<br>d<br>i<br>l<br>i<br>i<br>t<br>m<br>a<br>p<br>p<br>n<br>g<br>c<br>a<br>r<br>n<br>a<br>e<br>s                                                                                                                |  |

Source: https://techdifferences.com/difference-between-e-r-andrelational-model-in-dbms.html

![](_page_96_Picture_4.jpeg)

#### **NOTATIONS AND GUIDELINES MAPPING OF ERM TO RELATIONAL MODEL**

Main rules

- Entity types
	- Mapped to relations
	- Relations contain the attributes
	- Composite attributes: set of simple attributes
- Relationship Types
	- Foreign keys

or

 Relations plus Foreign keys

> 372 Source: Elmasri, Fundamentals of Database Systems, Page 286ff

![](_page_97_Picture_11.jpeg)

#### **NOTATIONS AND GUIDELINES MAPPING OF ERM TO RELATIONAL MODEL**

## Seven Steps

- 1. Mapping of regular entity types
- 2. Mapping of weak entity types
- 3. Mapping of binary 1:1 relationships
- 4. Mapping of binary 1:n relationships
- 5. Mapping of binary m:n relationships
- 6. Mapping of multivalued attributes
- 7. Mapping of n-ary relationships

373 Source: Elmasri, Fundamentals of Database Systems, Page 286ff

![](_page_98_Picture_10.jpeg)

## **NOTATIONS AND GUIDELINES DATABASE DESIGN**

![](_page_99_Figure_1.jpeg)

**Databases, © Ulrike Herster, partially © Elmasri "Fundamentals of Database Systems – For personal use only**

![](_page_99_Picture_3.jpeg)