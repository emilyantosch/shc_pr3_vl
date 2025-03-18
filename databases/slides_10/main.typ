#import "@preview/touying:0.5.2": *
#import themes.university: *

#import "@preview/fletcher:0.5.1" as flechter: diagram, node, edge
#import "@preview/wrap-it:0.1.0": wrap-content

#import "@preview/gentle-clues:1.0.0": *
#import "@preview/pinit:0.2.0": *
#import "@preview/codly:1.0.0": *
#show: codly-init.with()

#import "@preview/numbly:0.1.0": numbly

#set text(lang: "en", font: "Roboto", size: 18pt)
#set heading(numbering: numbly("{1}.", default: "1.1"))

#set align(left + top)

#show raw: it => {
  show regex("pin\d"): it => pin(eval(it.text.slice(3)))
  it
}
#let pinit-rect-from(height: 2em, pos: bottom, fill: rgb(0, 180, 255), point-pin, body) = {
  pinit-point-from(
    fill: fill,
    pin-dx: 0em,
    pin-dy: if pos == bottom { 0em } else { -0.6em },
    body-dx: 0pt,
    body-dy: if pos == bottom { -1.7em } else { -1.6em },
    offset-dx: 0em,
    offset-dy: if pos == bottom { 1.2em + height } else { -0.6em - height },
    point-pin,
    rect(
      inset: 0.5em,
      stroke: (bottom: 0.12em + fill),
      {
        set text(fill: fill)
        body
      },
    ),
  )
}
#show: university-theme.with(
  aspect-ratio: "16-9",
  config-info(
    title: [Databases],
    subtitle: [Lecture 10 - ],
    author: [Emily Lucia Antosch],
    date: datetime.today().display("[day].[month].[year]"),
    institution: [HAW Hamburg],
  ),
)

#codly(
  languages: (
    sql: (
      name: text(font: "JetBrainsMono NFM", " SQL", weight: "bold"),
      icon: text(font: "JetBrainsMono NFM", "\u{e76e}", weight: "bold"),
      color: rgb("#2563eb"),
    ),
    java: (
      name: text(font: "JetBrainsMono NFM", " Java", weight: "bold"),
      icon: text(font: "JetBrainsMono NFM", "\u{e738}", weight: "bold"),
      color: rgb("#CE412B"),
    ),
    c: (
      name: text(font: "JetBrainsMono NFM", " C", weight: "bold"),
      icon: text(font: "JetBrainsMono NFM", "\u{e61e}", weight: "bold"),
      color: rgb("#5612EC"),
    ),
  ),
)

#title-slide(authors: [Emily Lucia Antosch])

#outline(depth: 1)

= Introduction

== Where are we right now?
#slide[
  - Last time, we looked at the basics of subqueries and views
  - Today, we'll be discussing
    - how we can expand our knowledge of views,
    - how we can use transactions to increase the safety of our data manipulation statements
    - how transactions are executed.
]

#slide[
  1. Introduction
  2. Basics
  3. SQL
  4. Entity-Relationship-Model
  5. Relationships
  6. Constraints
  8. *Subqueries & Views*
  9. *Transactions*
  10. Database Applications
  11. Integrity, Trigger & Security
]

== What is the goal of this chapter?
#slide[
  - At the end of this lesson, you should be able to
    - create views in PostgresQL and use them effectively and
    - use transactions to make safe changes, that can be undone if necessary.
]

= Repetition
== Transactions
#slide[
  #heading(numbering: none)[ACID - Durability]
  - Once committed, changed data is safe
  - Error types
    1. Computer failure
    2. Transaction or system error (constraint violation, $x/0$, blackout, system crash)
    3. Local Errors
    4. Concurrency control enforcement
    5. Disk error (harddisk broken)
    6. Physical problems and catastrophes (fire, earthquake, robbery, ...)
]

#slide[
  #heading(numbering: none)[Distributed Transactions]
  #let left = [
    - To ensure interoperability between the participating resource managers the *2-phase commit protocol* is realized
    - It defines the final synchronization of different parts of a transaction of a global transaction
    - In the first phase the transaction manager asks participating resource managers to announce the results of their local transaction part
    - This leads to a global result (commit or rollback) that is then in the second phase announced to the participants]
  #let right = [
    #figure(image("../assets/img/slides_08/20250309_trans_coord_res_man_rev01.jpeg"))
  ]
]

== Integrity, Trigger and Security Integrity Constraints
# **INTEGRITY, TRIGGER & SECURITY INTEGRITY CONSTRAINTS**

 Static Constraints

- Conditions on states
- Conditions must be fulfilled before and after operations
- Used until now
	- Primary Key
	- Foreign Key
	- **UNIQUE**, **NOT NULL**, **CHECK**

![](_page_5_Picture_8.jpeg)

- Integrity conditions that affect multiple tables
- Conditions on state transitions
	- Example: status of order

new payed processing shipped


# **INTEGRITY, TRIGGER & SECURITY TRIGGER – ECA RULE**

![](_page_6_Picture_1.jpeg)

![](_page_6_Figure_2.jpeg)

6 Quelle: https://dev.acquia.com/blog/drupal-8-module-of-the-week/ drupal-8-module-of-the-week-rules/15/06/2016/15681

![](_page_6_Picture_4.jpeg)

![](_page_6_Picture_5.jpeg)

## **INTEGRITY, TRIGGER & SECURITY TRIGGER – EXAMPLE IN MYSQL**

```
delimiter |
CREATE TRIGGER SALARY_VIOLATION
BEFORE INSERT ON EMPLOYEE
FOR EACH ROW
   BEGIN
       IF NEW.SALARY > (SELECT SALARY
                         FROM EMPLOYEE
                         WHERE SSN = NEW.SUPER_SSN )
       THEN SET NEW.Salary = (SELECT SALARY
                                 FROM EMPLOYEE
                                 WHERE SSN = NEW.SUPER_SSN )‐1;
       END IF;
END;
|
delimiter ; 7
                                                                      Source: Elmasri, Fundamentals of
                                                                      Database Systems
```
![](_page_7_Picture_2.jpeg)

![](_page_7_Picture_3.jpeg)

Repetition

# **INTEGRITY, TRIGGER & SECURITY TRIGGER – TYPES**

![](_page_8_Picture_1.jpeg)

- Time of execution, relative to event
	- **BEFORE**
	- **AFTER**

- **INSTEAD OF**
- Statement trigger
	- Once per statement
	- Even if no row is affected!
	- Default trigger type
- Row trigger

- For every affected row
- Syntax: **FOR EACH ROW**

![](_page_8_Picture_13.jpeg)

![](_page_8_Picture_14.jpeg)

# **INTEGRITY, TRIGGER & SECURITY TRIGGER – TRANSITION VARIABLES**

![](_page_9_Picture_1.jpeg)

- Row triggers can access old and new tuples
	- MySQL
		- :old or old NULL for **INSERT**s
		- :new or new NULL for **DELETE**s
	- Oracle

- NEW and OLD
- Before row triggers:
	- Can even modify new!

![](_page_9_Picture_10.jpeg)

9

## **INTEGRITY, TRIGGER & SECURITY PERMISSIONS – BASICS**

- DBMS are multi-user systems
- You need permissions to do anything with the DB:
	- login
	- **CREATE** table, **DROP** table, etc.
	- **SELECT**
	- **INSERT**, **UPDATE**, **DELETE**
- Permissions can be **GRANT**ed and **REVOKE**d

![](_page_10_Picture_8.jpeg)

![](_page_10_Picture_9.jpeg)

#### **INTEGRITY, TRIGGER & SECURITY PERMISSIONS – GRANT AND REVOKE**

![](_page_11_Picture_1.jpeg)

- Permissions can be **GRANT**ed and **REVOKE**d
- Syntax:

```
GRANT <privilege_name> ON <object_name>
TO { <user_name> | PUBLIC | <role_name>} [ WITH GRANT OPTION ] ;
```
 Example: **GRANT**

```
GRANT SELECT ON tab_a TO user_a ;
GRANT UPDATE ON tab_b TO user_a ;
```
 Example: **REVOKE**

> **REVOKE SELECT ON** tab\_a **FROM** user\_a ;

**Databases, © Ulrike Herster, partially © Elmasri "Fundamentals of Database Systems – For personal use only**

![](_page_11_Picture_10.jpeg)


= Database Applications
== Basics
#slide[
#heading(numbering: none)[Problems]
- Cannot solve every problem with SQL
	- No loops

- Recursion not widely implemented
- Need to query DB out of an application
  #idea[
 Combination with procedural or object-oriented programming languages (*host languages*)
  ]
]


#slide[
#heading(numbering: none)[Combining SQL with 3GL]
1. *Embed SQL commands into host language*
	- Embedded SQL, SQL/OLB
2. *SQL commands through API calls*
	- SQL: Call Level Interface (CLI)
	- ODBC, JDBC
3. *Extend SQL*
	- SQL: Persistent Stored Modules (SQL/PSM)
	- Oracle: PL/SQL
]


#slide[
#heading(numbering: none)[Impedance Mismatch]
  #let left = [
- E.g., Object–relational impedance mismatch
	- Object-oriented concepts, like inheritance in OO, polymorphism in OO,…
  - Data type differences, like pointers in OO,…
  - Structural and integrity differences, like constraints in RM, objects can be composed of other objects in OO, …
  - Transactional differences, like transactions in RM
  - Manipulative differences, like declarative querys in RM
  ]
  #let right = [
#figure(image("../assets/img/slides_10/20250309_object_rel_model_rev01.png"))  
  ]
  #grid(columns: (auto, auto), gutter: 0.25em, left, right)
]


Source: https://www.youtube.com/watch?v=wg-NCF5KXNk

741 https://walkingtechie.blogspot.com/2017/12/object-relational-impedance-mismatch.html https://en.wikipedia.org/wiki/Object%E2%80%93relational\_impedance\_mismatch

![](_page_15_Picture_13.jpeg)

![](_page_15_Picture_14.jpeg)

![](_page_15_Picture_16.jpeg)

# **DATABASE APPLICATIONS 1. EMBEDDED SQL**

![](_page_16_Figure_1.jpeg)

**Databases, © Ulrike Herster, partially © Elmasri "Fundamentals of Database Systems – For personal use only**

![](_page_16_Picture_3.jpeg)

### **DATABASE APPLICATIONS 1. EMBEDDED SQL - EXAMPLE: SQL EMBEDDED INTO C (FRAGMENT)**

```
int main() {
    exec sql begin declare section;
    int sv_new_price;
    int sv_isbn;
    exec sql end declare section;
    printf("Please enter ISBN: \n ");
    scanf("%d", &sv_isbn);
    printf("Please enter new_price: \n");
    scanf("%d", &sv_new_price);
    exec sql update book
           set price = :sv_new_price
           where isbn = :sv_isbn;
} Shared variables
```
**Databases, © Ulrike Herster, partially © Elmasri "Fundamentals of Database Systems – For personal use only**

![](_page_17_Picture_3.jpeg)

# **DATABASE APPLICATIONS 1. EMBEDDED SQL - EXAMPLE: SQLJ SNIPPET**

```
int maxSalary, avgSalary;
```

```
#sql{
```

```
SELECT MAX(SALARY) , AVG(SALARY)
       INTO :maxSalary , :avgSalary
       FROM EMPLOYEE
};
```
![](_page_18_Picture_4.jpeg)

# **DATABASE APPLICATIONS 1. EMBEDDED SQL**

 Mainly static SQL

- SQL statement is fixed
- SQL syntax is checked at (pre-)compile time
- Exchange data with application by *host variables* (:varname)
- Precompilers exist for many languages
	- C/C++, Java (SQLJ), Ada, Cobol, Fortran, PL1, ...

![](_page_19_Picture_7.jpeg)

# **DATABASE APPLICATIONS 2. API CALLS**

- SQL commands through library/API calls
- Dynamic SQL

- Application can dynamically set up the SQL command string
- SQL syntax is checked at runtime
- Standard SQL: Call Level Interface (CLI), e.g.,
	- ODBC (for any language like C,C++,Java, but restricted on MS Windows)
	- JDBC (for Java, can be used for any platform)
	- OCI (Oracle Call Interface)

![](_page_20_Picture_9.jpeg)

## **DATABASE APPLICATIONS 2. API CALLS - JDBC**

- JDBC: Java Database Connectivity
- Part of Java API
- Typical steps:
	- 1. Load JDBC driver
	- 2. Define DB connection URL
	- 3. Connect to DB
	- 4. Create command object
	- 5. Execute command
	- 6. Process result
	- 7. Cleanup: Close resources and DB connection

![](_page_21_Picture_11.jpeg)

### **DATABASE APPLICATIONS 2. API CALLS – JDBC: PREPARATION**

### Download JDBC Connector:

- Oracle: http://java.sun.com/products/jdbc/download.html
- MySQL: https://dev.mysql.com/downloads/connector/j/

|  | P<br>r<br>e<br>p<br>a<br>r<br>e | J<br>a<br>a<br>v<br>a | P<br>j<br>t,<br>r<br>o<br>e<br>c | e<br>g<br>., | i<br>E<br>l<br>i<br>n<br>c<br>p<br>s<br>e |
|---|---------------------------------|-----------------------|----------------------------------|--------------|-------------------------------------------|
|   |                                 |                       |                                  |              |                                           |

- Prepare a MySQL database
- Import the JDBC library

| General Availability (GA) Releases<br>Archives | ர்    |                                                   |          |
|------------------------------------------------|-------|---------------------------------------------------|----------|
| Connector/ 8.4.0                               |       |                                                   |          |
| Select Operating System:                       |       |                                                   |          |
| Platform Independent                           | >     |                                                   |          |
|                                                |       |                                                   |          |
| Platform Independent (Architecture             | 8.4.0 | 4.1M                                              | Download |
| Independent), Compressed TAR Archive           |       |                                                   |          |
|                                                |       |                                                   |          |
| (mysql-connector-j-8.4.0.tar.gz)               |       | MD5: 33a74d1a803b504a1141a327bf6ff7c3   Signature |          |
| Platform Independent (Architecture             | 8.4.0 | 4.9M                                              |          |
| Independent), ZIP Archive                      |       |                                                   | Download |

![](_page_22_Picture_8.jpeg)

![](_page_22_Picture_9.jpeg)

## **DATABASE APPLICATIONS 2. API CALLS – JDBC: PREPARATION, E.G., MYSQL**

![](_page_23_Picture_1.jpeg)

## **DATABASE APPLICATIONS 2. API CALLS – JDBC: PREPARATION, E.G., MYSQL**

### Download JDBC Connector:

- Oracle: http://java.sun.com/products/jdbc/download.html
- MySQL: https://dev.mysql.com/downloads/connector/j/
- Prepare a Java Project, e.g., in Eclipse
- Prepare a MySQL database
- Import the JDBC library

![](_page_24_Picture_7.jpeg)

#### You can see if include was successful

![](_page_24_Picture_9.jpeg)

# **DATABASE APPLICATIONS 2. API CALLS – JDBC: 1. LOAD JDBC DRIVER**

 Syntax:

```
Class.forName(driverName);
or
import driverName;
plus create an instance
```
 Example:

**Databases, © Ulrike Herster, partially © Elmasri "Fundamentals of Database Systems – For personal use only**

![](_page_25_Picture_6.jpeg)

# **DATABASE APPLICATIONS**

#### **2. API CALLS – JDBC: 2. DEFINE DB CONNECTION URL**

- Connection is defined by an URL
	- Oracle
		- jdbc:oracle:thin:@<server>:1521:<dbname>
		- For example, Oracle@HAW (available before the cyber attack): jdbc:oracle:thin:@ora14:informatik.haw–hamburg.de:1521:inf14
	- MySQL
		- jdbc:mysql://<server>/<dbname>
		- For example: "jdbc:mysql://localhost:3306/company"

![](_page_26_Picture_10.jpeg)

### **DATABASE APPLICATIONS 2. API CALLS – JDBC: 2. DEFINE DB CONNECTION URL**

![](_page_27_Picture_1.jpeg)

### Exkursion: localhost

- In computer networking, *localhost* is a hostname that refers to the current computer used to access it. It is used to access the network services that are running on the host via the loopback network interface. Using the loopback interface bypasses any local network interface hardware.
- The local loopback mechanism may be used to run a network service on a host without requiring a physical network interface, or without making the service accessible from the networks the computer may be connected to. For example, a locally installed website may be accessed from a Web browser by the URL http://localhost to display its home page.
- The name localhost normally resolves to the IPv4 loopback address 127.0.0.1, and to the IPv6 loopback address ::1 .

(Ipv stands for Internet Protocol version)

> Source: https://en.wikipedia.org/wiki/Localhost 753

![](_page_27_Picture_8.jpeg)

![](_page_27_Picture_9.jpeg)

#### **DATABASE APPLICATIONS 2. API CALLS – JDBC: 3. CONNECT TO DB**

 Syntax:

> Connection conn = DriverManager.getConnection(url,user,psw) ;

 Example:

- Info about the connection is now available
	- Example:

```
conn.getMetaData () ;
```
![](_page_28_Picture_8.jpeg)

![](_page_28_Picture_9.jpeg)

# **DATABASE APPLICATIONS**

#### **2. API CALLS – JDBC: 4. CREATE COMMAND OBJECT**

#### Obtain Statement object

Example

```
Statement st = conn.createStatement() ;
```
 Also: prepareStatement(), prepareCall();

![](_page_29_Picture_6.jpeg)

## **DATABASE APPLICATIONS 2. API CALLS – JDBC: 5. EXECUTE COMMAND**

- Execute query
	- Example

```
String query = "SELECT dnumber, dname FROM DEPARTMENT";
// No ";" in query string
ResultSet myRes2 = myStmt2.executeQuery(query);
```

```
ResultSet myRes = myStmt.executeQuery
          ("SELECT lname, fname FROM EMPLOYEE");
```
 Also: executeUpdate() For **INSERT**, **UPDATE**, **DELETE**, **CREATE**

![](_page_30_Picture_6.jpeg)

### **DATABASE APPLICATIONS 2. API CALLS – JDBC: 6. PROCESS QUERY RESULTS**

Example:

```
while ( cursor.next ( ) ) {
           // position in cursor starts at 1 !
           string s1 = cursor.getString(1) ;
           int i2 = cursor.getInt (2) ;
           System.out.println (s1) ;
           System.out.println (i2) ;
}
while(myRes.next()) {
           System.out.println(i+". Person: "+myRes.getString("fname"));i++;
}
```
**Databases, © Ulrike Herster, partially © Elmasri "Fundamentals of Database Systems – For personal use only**

![](_page_31_Picture_4.jpeg)

### **DATABASE APPLICATIONS 2. API CALLS – JDBC: 7. CLEANUP**

- Important!
- Connections, Statements, ResultSets, etc. hold resources
- Both locally and on the server!
- So: close() *them as soon as possible*
	- After an error, too!

### Syntax:

```
finally {
         cursor.close () ;
          st.close () ;
         conn.close () ;
}
```
**Databases, © Ulrike Herster, partially © Elmasri "Fundamentals of Database Systems – For personal use only**

![](_page_32_Picture_9.jpeg)

**DATABASE APPLICATIONS 2. API CALLS – JDBC**

# **How to build a SQL statement programmatically?**

**Databases, © Ulrike Herster, partially © Elmasri "Fundamentals of Database Systems – For personal use only**

![](_page_33_Picture_3.jpeg)

## **DATABASE APPLICATIONS 2. API CALLS – JDBC: PARAMETER BINDING**

- Problem: use parameters in SQL query
- Syntax

![](_page_34_Figure_3.jpeg)

- Problem 1:
	- name = "O'Reilly";

![](_page_34_Picture_6.jpeg)

### **DATABASE APPLICATIONS 2. API CALLS – JDBC: SQL INJECTION**

 If there is nothing to prevent a user from entering "wrong" input, the user can enter some "smart" input like this:

 Syntax

> SELECT UserId , Name , Password FROM Users WHERE UserId = 105 OR 1=1

- Problem 2:
	- SQL injection attacks

![](_page_35_Picture_6.jpeg)

### **DATABASE APPLICATIONS 2. API CALLS – JDBC: SQL INJECTION**

![](_page_36_Picture_1.jpeg)

![](_page_36_Picture_2.jpeg)

Source: https://www.youtube.com/ watch?v=WONbg6ZjiXk

![](_page_36_Picture_4.jpeg)

Source: https://www.youtube.com/ watch?v=J6v\_W-LFK1c&t=122s

![](_page_36_Picture_6.jpeg)

762

## **DATABASE APPLICATIONS 2. API CALLS – JDBC: PARAMETER BINDING**

 One possible Solution: use PreparedStatement

```
Syntax
     string name = "O'Reilly" ;
     string query = "SELECT id FROM tab WHERE name=?" ;
             // no quotes ( ' ' ) here !
     PreparedStatement pst = conn.prepareStatement(query) ;
     pst.setString (1 , name) ;
     ResultSet cursor = pst.executeQuery () ;
```
![](_page_37_Picture_4.jpeg)

# **DATABASE APPLICATIONS 2. API CALLS – JDBC CLASSES**

- Classes/Interfaces in package java.sql.\*
	- DriverManager
	- Connection

- DatabaseMetaData
- Statement, PreparedStatement, CallableStatement
- ResultSet
- ResultSetMetaData
- SQLException (for error handling)

![](_page_38_Picture_9.jpeg)

### **DATABASE APPLICATIONS 2. API CALLS – JDBC: TRANSACTION HANDLING**

- Transaction syntax: connection.setAutoCommit (false) ; connection.commit () ; connection.rollback () ;
- If you need to change the isolation level, here is the syntax: connection.setTransactionIsolation (level) ;

![](_page_39_Picture_3.jpeg)

# **DATABASE APPLICATIONS 2. API CALLS – JDBC: ERROR HANDLING**

- java.sql.SQLException
- getMessage(): retrieve error text
- getStatus(): XOPEN or SQL status
- getErrorCode(): vendor-specific error code
- Problem: application needs to know vendor's error codes!
	- Problem with connection to DB
	- SQL syntax wrong
	- Constraint violation
	- ...

![](_page_40_Picture_10.jpeg)

![](_page_40_Picture_11.jpeg)

### **DATABASE APPLICATIONS 2. API CALLS – JDBC: ANTIPATTERNS (THINGS TO AVOID)**

 Do not build SQL string using user input!

![](_page_41_Figure_2.jpeg)

 Problems

- Correct quoting
- Need to handle special characters like '&'
- Opens the door for SQL injection attacks

#### Solution: Always use PreparedStatement / parameter binding!

**Databases, © Ulrike Herster, partially © Elmasri "Fundamentals of Database Systems – For personal use only**

![](_page_41_Picture_9.jpeg)

# **DATABASE APPLICATIONS**

#### **2. API CALLS – JDBC: ANTIPATTERNS (THINGS TO AVOID)**

- Do not read whole ResultSet into RAM
	- Problem: ResultSet can get huge
	- Solution: Iterate through the ResultSet
- Do not forget to close() resources Problem: Resources are held on client and server!
- Do not implement selection in client code
	- Problem: ResultSet can get huge
	- Solution: Use **WHERE** clause in SQL

![](_page_42_Picture_9.jpeg)

### **DATABASE APPLICATIONS 2. API CALLS – BEYOND JDBC**

- Frameworks on top of JDBC
- spring-jdbc

- Object-Relational Mapping (ORM)
	- Hibernate
		- www.hibernate.org
		- Mapping is defined in XML configuration files
		- < one - to - many >, < many - to - many >, ...
		- Can generate DDL out of classes+mapping
	- Different approach: Conventions
		- used by Ruby on Rails (non-Java)

![](_page_43_Picture_11.jpeg)

#### **DATABASE APPLICATIONS 3. EXTEND SQL – PROCEDURAL LANGUAGE EXTENSION**

- The previous approaches of connecting programming languages with DBMS are very fine granular (only one operation at a time)
- Problem: The DBMS cannot optimize because it doesn't know which operation is next
- Base idea: *Extend SQL by control structures* Putting the application code at the DBMS not at the programming language
- SQL-extensions were former DBMS-specific and called "Stored Procedure"
- Now they are standardized in SQL-99 and called SQL/PSM (persistently stored modules) and therefore over different DBMS useable (e.g., PL/SQL for Oracle)

![](_page_44_Picture_6.jpeg)

**Databases, © Ulrike Herster, partially**

- To structure the PL/SQL programs, it's possible to define *procedures* and *functions* and reuse them
	- A procedure uses parameters like OUT or IN OUT parameters to get the results A procedure may return one or more values through parameters or may not return at all
	- A function must return a value (of any type) by default definition
- Function can be used in SQL statements, procedures cannot be used in SQL statements

![](_page_45_Picture_5.jpeg)

 Syntax for creating procedures:

```
CREATE PROCEDURE procedure_name
     ( parameter1 IN parameter_type1 ,
     ( parameter2 OUT parameter_type2 ,
     …
     ( parameterN IN OUT parameter_typeNIS
 <PL/SQL‐Block>
```
**Databases, © Ulrike Herster, partially © Elmasri "Fundamentals of Database Systems – For personal use only**

 )

![](_page_46_Picture_4.jpeg)

 Syntax for creating functions:

**CREATE FUNCTION** function\_name

```
(parameter1 parameter_type1 ,
```

```
(parameter2 parameter_type2 ,
```
…

(parameterN parameter\_typeN )

**RETURN** result\_type

# **IS**

<PL/SQL‐Block>

![](_page_47_Picture_10.jpeg)

![](_page_47_Picture_11.jpeg)

- Using variables and defining data types
- Example:

 **declare**

today **date** ; type PersonRecordType is record ( PersonName **varchar2** ( 50 ) ; BirthDate **date** ) ; employee PersonRecordType ; Cursor for processing results: cursor CurBook is

**SELECT** isbn , title **FROM** Books ;

![](_page_48_Picture_6.jpeg)

774

 As control flow structures PL/SQL provides 

sequence (by "; ")

 condition (where the else branch is optional)

 Example:

**if** <condition > **then** < PL/SQ‐operation

**else**

> <PL/SQL‐operation>

**end** if ;

![](_page_49_Picture_9.jpeg)

>

![](_page_49_Picture_10.jpeg)

 and loops (for, while, loop)

### Example:

**while** < condition >

# **loop**

< PL/SQL‐operation >

**end** loop ;

 Example: Executing a relation with infinite loop

# **loop**

**fetch** Book **into** BookRecord ; **exit** when Book%not found ; …

**end loop** ;

**Databases, © Ulrike Herster, partially © Elmasri "Fundamentals of Database Systems – For personal use only**

![](_page_50_Picture_12.jpeg)

### **DATABASE APPLICATIONS 3. EXTEND SQL – EXAMPLE**

```
 Example: MySQL
```

```
delimiter |
CREATE PROCEDURE IF NOT EXISTS
    output(in ssn char(9), in old_sal DECIMAL(10,2),
    in new_sal DECIMAL(10,2), in diff_sal DECIMAL(10,2))
BEGIN
    INSERT INTO EMPLOYEE_SALDIFF VALUES
    ( ssn , old_sal , new_sal, diff_sal);
END|
delimiter ;
```

```
CALL output(123456789, 12.34, 56.78, 44.44);
```
![](_page_51_Picture_4.jpeg)

![](_page_51_Picture_5.jpeg)

### **DATABASE APPLICATIONS 3. EXTEND SQL – EXAMPLE**

```
Example: MySQL
    delimiter |
   CREATE TRIGGER IF NOT EXISTS Print_salary_changes
   BEFORE UPDATE ON EMPLOYEE
   FOR EACH ROW
         BEGIN
            DECLARE sal_diff DECIMAL(10,2);
            IF (NEW.salary != OLD.salary)
            THEN
                  BEGIN
                     SET sal_diff = NEW.salary ‐ OLD.salary ;
                     CALL output(NEW.ssn, OLD.salary, NEW.salary, sal_diff);
                  END;
            END IF;
   END;
   |
   delimiter ;
```
![](_page_52_Picture_3.jpeg)

## **DATABASE APPLICATIONS 3. EXTEND SQL – EXAMPLE**

 Example: Oracle

```
DROP PROCEDURE add_color ;
CREATE PROCEDURE add_color ( param1 IN VARCHAR2)
    IS
    BEGIN
    INSERT INTO color VALUES
            ( (SELECT COUNT(id) FROM color) , param1 ) ;
    END;
/
EXECadd_color('Lightblue');
```
**Databases, © Ulrike Herster, partially © Elmasri "Fundamentals of Database Systems – For personal use only**

![](_page_53_Picture_4.jpeg)

 Additional to the structuring, functions/procedures have more advantages:

- DBMS can optimize the code because it knows the structure
- The execution takes place on the DBMS-server, so network overhead is minimized, which is especially useful in distributed environments (client/server or internet)
- Assignment of permissions are available for procedures
- Procedures can be used to full integrity constraints

![](_page_54_Picture_6.jpeg)

780

### Disadvantages

- Software development environments (IDE) are often not optimal
- Raised dependency on DBMS
- Problems on scalability, because application code is executed on DBS-server instead of being executed by many clients or application servers

![](_page_55_Picture_5.jpeg)

![](_page_55_Picture_6.jpeg)

#### **DATABASE APPLICATIONS 3. EXTEND SQL – JAVA STORED PROCEDURES**

- 
- Formulating Stored procedures in Java is possible in many DBMS
- Oracle supports the execution of Java programs directly on the server
- Java programs with GUI are excluded
- Access by wrapping Java methods in PL/SQL
- The mapping of PL/SQL call on Java method must be created by the programmer
- These mapped Java methods can be accessed by all DML operations (Select, Update, Insert, Delete) and within PL/SQL blocks

![](_page_56_Picture_8.jpeg)

782

# **DATABASE APPLICATIONS SUMMARY**

- Embed SQL commands into host language
	- Advantages

- Query is part of source code
	- syntax checking
	- validation against the database schema
	- readable
- Disadvantages
	- Static queries
	- Changes of queries go through recomplication process

783 Source: Elmasri, Fundamentals of Database Systems, Page 476ff

![](_page_57_Picture_11.jpeg)

# **DATABASE APPLICATIONS SUMMARY**

- SQL commands through API calls
	- Advantages

- More flexibibilty
	- Queries can be generated at runtime
- Disadvantages
	- More complex programing
	- No checking during compile time

784 Source: Elmasri, Fundamentals of Database Systems, Page 476ff

![](_page_58_Picture_9.jpeg)

![](_page_58_Picture_10.jpeg)

# **DATABASE APPLICATIONS SUMMARY**

 Extend SQL

- Advantages
	- No suffering from impedance mismatch problem
- Disadvantages
	- New language for the programmer

785 Source: Elmasri, Fundamentals of Database Systems, Page 476ff

![](_page_59_Picture_7.jpeg)

![](_page_59_Picture_8.jpeg)
= License Notice
== Attribution
- This work is shared under the CC BY-NC-SA 4.0 License and the respective Public License.
- #link("https://creativecommons.org/licenses/by-nc-sa/4.0/")
- This work is based off of the work by Prof. Dr. Ulrike Herster.
- Some of the images and texts, as well as the layout were changed.
- The base material was supplied in private, therefore the link to the source
  cannot be shared with the audience.
