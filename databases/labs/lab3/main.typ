#import "@preview/grape-suite:2.0.0": exercise, german-dates
#import "@preview/gentle-clues:1.2.0": *

#set text(lang: "en")

#import "@preview/codly:1.0.0": *
#show: codly-init.with()

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
      color: rgb("#7c3aed"),
    ),
  ),
)

#let is_solution = true

#show: exercise.project.with(
  title: "Databases Lab 03",
  university: [HAW Hamburg],
  institute: [TI IE4],
  seminar: [DBL],
  abstract: [
    This is the third lab of Databases. This lab is designed to help you deepen your understanding of database design and SQL.
    It is recommended that you familiarize yourself with the assignments to allow a more effective participation in Laboratory 2. If you have questions or need any support, help each other, or use the forum in our moodle room.
  ],
  show-outline: true,
  author: "Emily Antosch & Furkan Yildrim & Julian Moldenhauer",
  show-solutions: false,
)

= Assignment 1: Relational Model for a Hotel
A hotel chain wants to use a database to keep track of their hotels and employees, described in the following ERD:

#figure(image("../../assets/img/labs/2024_11_14_lab02_erd_employee_hotel_rev01.png"))

In addition to the constraints in the ERD, take account of the following constraint: “Every stand-in is uniquely identifiable by the combination of the employee who replaces, the employee who is replaced and the date of the stand-in.”
Convert the ERD into a relation schema. Make sure that every relation is in 3NF.

#if is_solution [
  #conclusion(title: [Solution])[
    *EMPLOYEE*(#underline[SSN] (PK), name, age, HotelID (FK))\
    *HOTEL*(#underline[Address] (PK), SSN (FK), name)\
    *ROOMTYPE*(#underline[Description], minSize, furnishing)\
    *ROSTER*(#underline[year], #underline[day], #underline[SSN] (FK), start, end)\
    *HOTELHASROOMTYPE*(#underline[Address] (FK), #underline[Description] (FK), amount)\
    *STANDIN*(#underline[SSN_Replacer] (FK), #underline[SSN_Replacee] (FK), #underline[date])\
  ]
]
= Assignment 2: Relational Algebra

The following excerpt of a database schema models a database of chess players. The relation PLAYER models a chess player, the relation GAME a game between two chess players. The attribute remis indicates whether the game is draw, it can be true or false.

*PLAYER*(#underline[PID] (PK), firstName, lastName, dateOfBirth)\
*GAME*(#underline[GID] (PK), winnerID (FK), loserId (FK), remis)\

The attributes winnerID and loserID are foreign keys to PID of PLAYER. Specify the following natural language queries as relational algebra queries.
- Which chess players were born before the 01.01.2000? (Output: lastName, dateOfBirth)
#if is_solution [
  #conclusion(title: [Solution])[
    $"PLAYER_NAMES" <- pi_"dateOfBirth, lastname(Player)"$\
    $"PLAYER_BEFORE" <- sigma_"dateOfBirth < 01.01.2000(PLAYER_NAMES)"$
  ]
]
- Which chess players have won at least once? (Output: first name and last name)

#if is_solution [
  #conclusion(title: [Solution])[
    $"PLAYER_GAME" <- "PLAYER" join_"PID = winnerID(GAME)"$\
    $"PLAYER_NAMES" <- pi_"firstname, lastname(PLAYER_GAME)"$\
    $"PLAYER_WON" <- sigma_"remis = false(PLAYER_NAMES)"$
  ]
]

= Assignment 3: Functional dependencies and normalization of a Furniture Database Version 1
A furniture company maintains a database that records information about orders, customers, and products. Note: In version 1, each order contains only one product. The sample database relation ORDER is as follows:

#table(
  columns: (auto, auto, auto, auto, auto, auto, auto),
  inset: 0.5em,
  [*CustomerID*], [*Name*], [*Address*], [*OrderID*], [*Product*], [*Quantity*], [*Price*],
  [24], [Maria Müller], [Wegstraße 12b, Berlin], [101], [Table], [2], [150.0],
  [24], [Maria Müller], [Wegstraße 12b, Berlin], [102], [Chair], [5], [80.0],
  [18], [Klaus Schmidt], [Hauptstraße 4, Hamburg], [103], [Table], [1], [130.0],
  [16], [Petra Wagner], [Lindenallee 7, Munich], [104], [Sofa], [2], [200.0],
)

1. Determine the (full) functional dependencies. Keep in mind that functional dependencies are determined by the model, not just by the actual data in the database relations.
2. Determine potential candidate keys and a primary key for the given relation ORDER. Elaborate on your answer.
3. Transform the relational schema to 3NF. Your relation(s) should indicate PKs & FKs and contain all the data.
4. Create an entity relationship diagram of the 3NF schema.

#if is_solution [
  #conclusion(title: [Solution])[
    1. *Functional Dependencies*:
      - CustomerID → Name, Address
      - OrderID → CustomerID, Name, Address, Product, Quantity, Price
      - Note: In version 1, each order contains only one product, so OrderID uniquely determines all other attributes.

    2. *Candidate Keys and Primary Key*:
      - OrderID is a candidate key and the logical primary key since it uniquely identifies each order record.
      - No other attribute or combination of attributes can serve as a candidate key since OrderID functionally determines all other attributes.

    3. *Transformation to 3NF*:
      - *CUSTOMER*(#underline[CustomerID] (PK), Name, Address)
      - *ORDER*(#underline[OrderID] (PK), CustomerID (FK), Product, Quantity, Price)
      - This decomposition removes the transitive dependency by separating customer information into its own relation.

    4. *Entity Relationship Diagram*:
      ```md
        [CUSTOMER] 1 -------- * [ORDER]
        CustomerID (PK)        OrderID (PK)
        Name                   CustomerID (FK)
        Address                Product
                               Quantity
                               Price
      ```
  ]
]


= Assignment 4: Functional dependencies and normalization of a Furniture Database Version 2
A furniture company maintains a database that records information about orders, customers, and products. Note: In version 2, each order may contain several products. The sample database relation ORDER is as follows:

#table(
  columns: (auto, auto, auto, auto, auto, auto, auto),
  inset: 0.5em,
  [*CustomerID*], [*Name*], [*Address*], [*OrderID*], [*Product*], [*Quantity*], [*Price*],
  [24], [Maria Müller], [Wegstraße 12b, Berlin], [101], [Table], [2], [150.0],
  [24], [Maria Müller], [Wegstraße 12b, Berlin], [102], [Chair], [5], [80.0],
  [18], [Klaus Schmidt], [Hauptstraße 4, Hamburg], [103], [Table], [1], [130.0],
  [16], [Petra Wagner], [Lindenallee 7, Munich], [104], [Sofa], [2], [200.0],
)

1. Determine the (full) functional dependencies. Keep in mind that functional dependencies are determined by the model, not just by the actual data in the database relations.
2. Determine potential candidate keys and a primary key for the given relation ORDER. Elaborate on your answer.
3. Transform the relational schema to 3NF. Your relation(s) should indicate PKs & FKs and contain all the data.
4. Implement the schema in your database and insert sample data.

#if is_solution [
  #conclusion(title: [Solution])[
    1. *Functional Dependencies*
      - CustomerID -> Name, Address
      - OrderID -> CustomerID, Name, Address
      - OrderID, Product -> CustomerID, Name, Address, Quantity, Price

    2. *Candidate Key*
      - OrderID and Product together would make up the only feasible composite primary key, since those two define every other entry in a row in the database

    3. *3NF*
      - *CUSTOMER*(#underline[CustomerID] (PK), Name, Address)
      - *ORDER*(#underline[OrderID] (PK), CustomerID (FK), #underline[Product] (PK), Quantity, Price)
    4. *Schema*
      ```sql
        CREATE TABLE ORDER (
          ORDER_ID INT NOT NULL,
          CUSTOMER_ID INT NOT NULL,
          PRODUCT TEXT NOT NULL,
          QUANTITY INT,
          Price REAL,
          CONSTRAINT "PK_ORDER_ORDER_ID_PRICE" PRIMARY KEY (ORDER_ID, PRODUCT),
          CONSTRAINT "FK_ORDER_CUSTOMER_CUSTOMER_ID_CUSTOMER_ID"
            FOREIGN KEY (CUSTOMER_ID) REFERENCES CUSTOMER(CUSTOMER_ID)
        );

        CREATE TABLE CUSTOMER (
          CUSTOMER_ID INT NOT NULL PRIMARY KEY,
          NAME TEXT,
          ADDRESS TEXT
        );
      ```
  ]
]

= Assignment 5: Relational Algebra vs. SQL query for a Weather Database

The following excerpt from a database schema models a database about a weather
station. The following assignments are to be answered in the form of relational
algebra.
- *WEATHER_DATA* (DataID, CityID (FK), Date, Temperature, Humidity, Precipitation, WindSpeed)
- *CITY* (CityID, Name, Country)
1. Which cities have an average daily temperature above 25°C in August 2023?
2. Which cities experienced no precipitation on any day in July 2023?
3. On which particular day did the cities have the highest wind speed?
4. Which cities recorded the highest temperature?
5. Which cities had the lowest humidity in May 2023?

#if is_solution [
  #conclusion(title: [Solution])[
    $"CITY_WEATHER" <- "WEATHER_DATA" join_"CityID = CityID(City)"$\
    $"CITY_TEMP" <- sigma_"TEMP > 25(CITY_WEATHER)"$\
    $"CITY_DATE" <- sigma_"Date >= 01.08.2023 & Date <= 31.08.2023(City)"$\
    $"CITY_TEMP_DATE" <- "CITY_TEMP" inter "CITY_DATE"$
    $"CITY_TEMP_DATE" <- pi_"Name, TEMP(CITY_TEMP_DATE)"$\
  ]
  #conclusion(title: [Solution])[
    $"CITY_WEATHER" <- "WEATHER_DATA" join_"CityID = CityID(City)"$\
    $"CITY_JULY" <- sigma_"Date >= 01.07.2023 & Date <= 31.07.2023(CITY_WEATHER)"$\
    $"CITY_PRECIPITATION" <- sigma_"Precipitation = 0(CITY_WEATHER)"$\
    $"CITY_TEMP_DATE" <- pi_"Name, TEMP(CITY_PRECIPITATION)"$\
  ]
  ```sql
    SELECT CITY, DATE, MIN(WindSpeed)
    FROM WEATHER_DATA wd
    LEFT JOIN CITY c ON c.cityid = wd.cityid
    GROUP BY CITY, DATE
  ```
  #conclusion(title: [Solution])[
    $"CITY_WEATHER" <- "WEATHER_DATA" join_"CityID = CityID(City)"$\
    $"CITY_WINDSPEED" <- rho_"windspeed/windspeed1"(pi_"windspeed"("CITY_WEATHER") - pi_"windspeed1"("CITY_WEATHER") sigma_"windspeed1<windspeed2" (rho_"windspeed1/windspeed"("CITY_WEATHER") crossmark rho_"windspeed2/windspeed"("CITY_WEATHER"))("CITY_WEATHER")$\
    $"CITY_DAY" <- pi_"DAY(CITY_WINDSPEED)"$\
  ]
  #conclusion(title: [Solution])[
    $"CITY_WEATHER" <- "WEATHER_DATA" join_"CityID = CityID(City)"$\
    $rho_"temperature/temperature1"(pi_"temperature"("CITY_WEATHER") - pi_"temperature1"("CITY_WEATHER") sigma_"temperature1<temperature2" (rho_"temperature1/temperature"("CITY_WEATHER") crossmark rho_"temperature2/temperature"("CITY_WEATHER"))("CITY_WEATHER")$\
  ]
  #conclusion(title: [Solution])[
    $"CITY_WEATHER" <- "WEATHER_DATA" join_"CityID = CityID(City)"$\
    $"CITY_MAY" <- sigma_"Date >= 01.05.2023 & Date <= 31.05.2023(CITY_WEATHER)"$\
    $rho_"humidity/humidity1"(pi_"humidity"("CITY_MAY") - pi_"humidity1"("CITY_MAY") sigma_"humidity1>humidity2" (rho_"humidity1/humidity"("CITY_MAY") crossmark rho_"humidity2/humidity"("CITY_MAY"))("CITY_MAY")$\
  ]
]

