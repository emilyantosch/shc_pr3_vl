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
  This is the first lab of Databases. Here you will learn the basics of database design and SQL. 
  It is recommended that you familiarize yourself with the assignments to allow a more effective  participation in Laboratory 1.    If you have questions or need any support, help each other, or use the forum in our moodle room.  
  ], show-outline: true, author: "Emily Antosch", show-solutions: false,
)

= Assignment 1: Student Information System

== Introduction
A university wants to store information about its students and their courses in a database. The  following requirements have been identified: 
- The university offers one or more study programs. Every study program has a unique  program id, a unique name, and the required credit points to finish it. 
- A study program is made up of one or more courses. A course belongs to exactly one study  program and has a course id, a name, a description, and credit points. A course can have  none, one or more other courses as a prerequisite.
- A student has a student id, first name, last name, date of birth and a year of enrollment. A  student is enrolled in exactly one study program.
- A student attempts courses, that are part of his/her study program. If a student attempts a  course the year and term (summer or winter semester) and grade (between 0 and 15  points) are recorded.  

== Assignments:    
1.  Create an entity-relationship-diagram in Chen notation according to these requirements.  Add attributes where necessary. Take special care that you identify the entity types,  relationship types, and key attributes.    
2.  Can you think of adding some additional composite, multivalued, or derived attributes in  this example?    
3.  How does the ERM looks like in MC notation?  
4.  Describe two semantic integrity requirements, which make sense for the described model,  but cannot be reflected in the entity-relationship-diagram.
5.  Convert the ERD into a relational schema.     
6.  Write SQL-statements that create the corresponding tables. Come up with reasonable  constraints and datatypes for the fields of the tables. Think also about the behavior of data  when a referenced tuple is updated or deleted.
7.  Insert example data in the database you created (you could for example give rows for your  own study program / courses / attempts or any fictional data).

#pagebreak()

= Assignment 2: ERD for an Online Shopping Platform

The following entity-relationship-diagram is given. Assume that the database is filled with data  according to the ERM. Decide whether the following statements are either true (T), false (F), or  undecidable/maybe (U). "U" is used for statements that can be either T or F depending on the  stored data. Evaluate the statements based exclusively on the ERM and the restrictions it contains.

#figure(image("../../assets/img/2024_11_14_lab01_erd_shopping_rev01.png"))

#table(columns: (auto, auto, auto), inset: 0.5em, 
  [*Number*], [*Statement*], [*Answer*],
  [01], [A customer can have multiple shopping carts.], [],
  [02], [A product can be included in multiple orders.], [],
  [03], [Each shopping cart is associated with a specific order.], [],
  [04], [An order can contain only one product.], [],
  [05], [A customer can place multiple orders.], [],
  [06], [Each order has a unique oder number.], [],
  [07], [Each order must be associated with a customer.], [],
  [08], [A customer can place an order without a shopping cart.], [],
  [09], [A product can be sold at different prices in different orders.], [],
  [10], [Every product can be contained several times in the same order.], [],
  [11], [A product can be uniquely identified by the combination of the Product name and Product ID.], [],
)

= Assignment 3 ERD for a Technology Support Company
A technology company is developing a support ticket management system to handle customer  complaints efficiently and track the support staff's work. The system must store information about  support requests, customers, support staff and their interactions.
1.  Create an entity-relationship-diagram in Chen notation according to these requirements.  Add attributes where necessary. Take special care that you identify the entity types,  relationship types, and key attributes.
2.  Can you think of adding some additional composite, multivalued, or derived attributes in  this example?
3.  How does the ERM looks like in MC notation?
4.  Convert the ERD into a relational schema.



= Assignment 4 – RM for Favorite Books
Transform given the ERD to an equivalent relational model.

#figure(image("../../assets/img/2024_11_14_lab01_erd_favorite_books_rev01.png"))


= Assignment 5: ERD for a Zoo
Draw an Entity-Relationship-Diagram in MC notation according to the following requirements. Add  attributes where necessary. Take special care that you identify the entity types, relationship types,  and key attributes. Translate the resulting ERM into a relational model.
The director of the local zoo wants to track problems with his animals. 
- The zoo has many animal types. Every animal type has a unique name and defines an age  at which this type is determined reproductive.
- Every animal has a unique animal ID. Animals also have an age and a gender as well as an  indicator if they are capable of reproduction.
- Animals may have diseases. The beginning time and the duration of a disease needs to be  recorded. A disease has a unique name.
- A keeper takes care of only one animal type, but for every animal type there may be many  keepers.


= Assignment 6: ERD for a Cooking Club
Draw an Entity-Relationship-Diagram in MC notation according to the following requirements. Add  attributes where necessary. Take special care that you identify the entity types, relationship types,  and key attributes. Translate the resulting ERM into a relational model.
A cooking club organizes several dinners for its members. The purpose of the club is to allow  several members to get together and prepare a dinner for the other members. The club president  maintains a database that plans each meal and tracks which members attend each dinner and  keeps track of which members create each dinner.
- Each dinner serves many members, and any member is allowed to attend. Each dinner has  an invitation. This invitation is mailed to each member. The invitation includes the date of  the dinner and location.
- Each dinner is based on a single entrée, a main course, and a single dessert. The recipes for  the entrées and desserts can be used again for other dinners.
