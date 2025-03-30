#import "@preview/grape-suite:1.0.0": exercise, german-dates

#set text(lang: "en")

#import "@preview/codly:1.0.0": *
#show: codly-init.with()

#codly(
  languages: (
    sql: (
      name: text(font: "JetBrainsMono NFM", " SQL", weight: "bold"), icon: text(font: "JetBrainsMono NFM", "\u{e76e}", weight: "bold"), color: rgb("#2563eb"),
    ),
    java: (
      name: text(font: "JetBrainsMono NFM", " Java", weight: "bold"), icon: text(font: "JetBrainsMono NFM", "\u{e738}", weight: "bold"), color: rgb("#CE412B"),
    ), c: (
      name: text(font: "JetBrainsMono NFM", " C", weight: "bold"), icon: text(font: "JetBrainsMono NFM", "\u{e61e}", weight: "bold"), color: rgb("#7c3aed"),
    ),
  ),
)

#show: exercise.project.with(
  title: "Databases Lab 01", university: [HAW Hamburg], institute: [TI IE4], seminar: [DBL], abstract: [
  This is the second lab of Databases. This lab is designed to help you deepen your understanding of database design and SQL.
  It is recommended that you familiarize yourself with the assignments to allow a more effective  participation in Laboratory 2.    If you have questions or need any support, help each other, or use the forum in our moodle room.  
  ], show-outline: true, author: "Emily Antosch", show-solutions: false,
)

= Assignment 1: Relational Model for a Hotel    
A hotel chain wants to use a database to keep track of their hotels and employees, described in  the following ERD:  

#figure(image("../../assets/img/2024_11_14_lab02_erd_employee_hotel_rev01.png"))

In addition to the constraints in the ERD, take account of the following constraint: “Every stand-in  is uniquely identifiable by the combination of the employee who replaces, the employee who is  replaced and the date of the stand-in.”
Convert the ERD into a relation schema. Make sure that every relation is in 3NF.


= Assignment 2: Functional dependencies and normalization of a Furniture Database Version 1    
A furniture company maintains a database that records information about orders, customers, and  products. Note: In version 1, each order contains only one product. The sample database relation  ORDER is as follows:    

#table(columns: (auto, auto, auto, auto, auto, auto, auto), inset: 0.5em, 
  [*CustomerID*], [*Name*], [*Address*], [*OrderID*], [*Product*], [*Quantity*], [*Price*],
  [24], [Maria Müller], [Wegstraße 12b, Berlin], [101], [Table], [2], [150.0],
  [24], [Maria Müller], [Wegstraße 12b, Berlin], [102], [Chair], [5], [80.0],
  [18], [Klaus Schmidt], [Hauptstraße 4, Hamburg], [103], [Table], [1], [130.0],
  [16], [Petra Wagner], [Lindenallee 7, Munich], [104], [Sofa], [2], [200.0],
)

1. Determine the (full) functional dependencies. Keep in mind that functional dependencies  are determined by the model, not just by the actual data in the database relations.  
2. Determine potential candidate keys and a primary key for the given relation ORDER.  Elaborate on your answer.  
3. Transform the relational schema to 3NF. Your relation(s) should indicate PKs & FKs and  contain all the data.  
4. Create an entity relationship diagram of the 3NF schema.


= Assignment 3: Functional dependencies and normalization of a Furniture Database Version 2    
A furniture company maintains a database that records information about orders, customers, and  products. Note: In version 2, each order may contain several products. The sample database  relation ORDER is as follows:

#table(columns: (auto, auto, auto, auto, auto, auto, auto), inset: 0.5em, 
  [*CustomerID*], [*Name*], [*Address*], [*OrderID*], [*Product*], [*Quantity*], [*Price*],
  [24], [Maria Müller], [Wegstraße 12b, Berlin], [101], [Table], [2], [150.0],
  [24], [Maria Müller], [Wegstraße 12b, Berlin], [102], [Chair], [5], [80.0],
  [18], [Klaus Schmidt], [Hauptstraße 4, Hamburg], [103], [Table], [1], [130.0],
  [16], [Petra Wagner], [Lindenallee 7, Munich], [104], [Sofa], [2], [200.0],
)

1. Determine the (full) functional dependencies. Keep in mind that functional dependencies  are determined by the model, not just by the actual data in the database relations.  
2. Determine potential candidate keys and a primary key for the given relation ORDER.  Elaborate on your answer.  
3. Transform the relational schema to 3NF. Your relation(s) should indicate PKs & FKs and  contain all the data.  
4. Implement the schema in your database and insert sample date.  


= Assignment 4: Functional dependencies and normalization of a Sale Database

A university stores information about the quantities of copies of lecture notes sold by each  professor. Lectures are taught by different professors, using different lecture notes.  The following sample database relation SALE is used:

#figure(image("../../assets/img/2024_11_14_lab02_sales_table_rev01.png"))

1. Determine the (full) functional dependencies. Keep in mind that FDs are determined by the  model, not just by the actual data in the database relations.
2. Identify a primary key for the given relation SALE. Explain your answer. 
3. Transform the relational schema to 2NF. Your relation(s) should indicate PKs & FKs and  contain all the data.
4. Transform the relational schema to 3NF. Your relation(s) should indicate PKs & FKs and  contain all the sample data.


= Assignment 5: Functional dependencies and normalization for a general example
Consider the following relation *ANY*:

ANY (aid, bid, cid, aName, bName, cName, since, description, location)

and functional dependencies *F* that hold over the relation *ANY*:      

- aid: aName
- aName: aid
- bid: bName, location, cid, cName, description
- cid: cName, description
- cName: cId
- aName, bid: aid, bid, cid, aName, bName, cName, since, description

1. Determine all candidate keys (possible primary keys) of ANY.  
2. In which normal form is the relation ANY and why?  
3. If relation ANY is not in 1NF, 2NF or 3NF then decompose it, accordingly, taking care to  denote possible keys (both PKs and FKs).    
