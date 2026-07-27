#import "@preview/grape-suite:2.0.0": colors, exercise
#import "@preview/gentle-clues:1.0.0": *
#import exercise: project, subtask, task
#import colors: *

#import "@preview/codly:1.3.0": *
#show: codly-init.with()

#codly(languages: (
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
  sql: (
    name: text(font: "JetBrainsMono NFM", " SQL", weight: "bold"),
    icon: text(font: "JetBrainsMono NFM", "\u{e76e}", weight: "bold"),
    color: rgb("#2563eb"),
  ),
))

#show: project.with(
  type: [Exam],
  suffix-title: [Databases - Summer 2026],

  show-point-distribution-in-tasks: true,
  show-namefield: true,
  show-timefield: true,

  max-time: 90,
  show-lines: true,

  show-solutions: false,
  solutions-as-matrix: true,

  university: [HAW Hamburg],
  institute: [HAW - EMI IE4],
  seminar: [Databases],

  task-type: [Task],
  extra-task-type: [Extra task],

  solution-matrix-task-header: [Task],
  solution-matrix-achieved-points-header: [Achieved Points],

  distribution-header-point-value: [Points],
  distribution-header-point-grade: [Value],

  message: (
    points-sum,
    extrapoints-sum,
  ) => [In total, you can achieve #(points-sum + extrapoints-sum) points. You have achieved #box(line(stroke: purple, length: 1cm)) P. of #(points-sum + extrapoints-sum) points.],

  solutions-title: [Suggestion for the Solution],
  timefield: time => [Time: #time min.],

  grade-scale: (([A], 0.9), ([B], 0.8), ([C], 0.7), ([D], 0.6), ([E], 0.51), ([F], 0.50)),
)

#set heading(numbering: none)
#set text(font: "Roboto")

#block(
  width: 100%,
  inset: 12pt,
  radius: 4pt,
  stroke: 1pt + black,
)[
  #align(center)[#text(size: 18pt, weight: "bold")[Exam Rules]]

  *Name:* #box(line(length: 4cm)) #h(1cm) *Matriculation number:* #box(line(length: 4cm))

  1. Do not cheat.
  2. Write your full name and matriculation number on the exam and each extra sheet.
  3. You may use two double-sided A4 cheat sheets or four single-sided A4 cheat sheets.
  4. Do not attach sticky notes to the cheat sheets.
  5. If you need extra sheets, place them on your table before the exam starts.
  6. Ask the exam supervisor before you use the restroom.
  7. Use your floor's restroom only when it is vacant.
  8. After the first student leaves the exam early, the remaining students cannot use the restroom.
  9. Stay until the exam ends so that other students can use the restroom.
  10. Hand in the exam and all extra sheets.
]

#pagebreak()

#task(
  points: 10,
  [
    Explain Database Terms
  ],
  [
    For each term, write 2-3 sentences. Include one concrete database example in these sentences.

    - Primary key
    - Foreign key
    - Table
    - Row
    - SQL query

  ],
  [],
  (
    (
      2,
      [Primary key: attribute or attribute set that uniquely identifies each row in a table. Example: `student_id` in `Student(student_id, name)`.],
    ),
    (
      2,
      [Foreign key: attribute that references a key in the same table or another table. Example: `Enrollment.student_id` references `Student.student_id`.],
    ),
    (
      2,
      [Table: collection of rows with the same columns. Example: a `Book` table stores one row per book.],
    ),
    (
      2,
      [Row: one record in a table. Example: one row in `Customer` contains one customer's id, name, and email.],
    ),
    (
      2,
      [SQL query: statement that requests data from a database. Example: `SELECT name FROM Student;` returns student names.],
    ),
  ),
)


#task(
  points: 16,
  [
    Multiple Choice: True or False
  ],
  [
    For each statement, mark exactly one column. Each correct answer gives 2 points. Each wrong answer deducts 2 points. An empty row or two marks give 0 points for that row. The total score for this task cannot be negative.

    #table(
      columns: (1fr, auto, auto),
      inset: 10pt,
      align: horizon,
      table.header([*Statement*], [*True*], [*False*]),

      [A primary key identifies each row in a table.], [], [],
      [A foreign key can reference a primary key in another table.], [], [],
      [A table row is also called a record.], [], [],
      [The ```sql SELECT``` statement is used to delete rows from a table.], [], [],
      [The ```sql COUNT(*)``` function counts rows.], [], [],
      [A ```sql WHERE``` clause filters rows before they are returned.], [], [],
      [Every table must have a foreign key.], [], [],
      [```sql NULL``` means the same as the number 0.], [], [],
    )
  ],
  [],
  (
    (2, [True]),
    (2, [True]),
    (2, [True]),
    (2, [False]),
    (2, [True]),
    (2, [True]),
    (2, [False]),
    (2, [False]),
  ),
)
#pagebreak()

#task(
  [
    Normalization and SQL Constraints
  ],
  [
    A small library uses one table and one row for each book in a loan. A loan can contain multiple books. Each `loan_id` identifies one member, loan date, and due date. Each `member_id` identifies one member name and email address. Each `book_id` identifies one title, author name, and genre. The `return_date` applies to one book in one loan.

    ```sql
    CREATE TABLE library_loans (
        loan_id INT,
        loan_date DATE,
        due_date DATE,
        member_id INT,
        member_name VARCHAR(100),
        member_email VARCHAR(100),
        book_id INT,
        book_title VARCHAR(150),
        author_name VARCHAR(100),
        genre VARCHAR(50),
        return_date DATE,
        PRIMARY KEY (loan_id, book_id)
    );
    ```
  ],
  [
    #subtask(points: 6)[
      Identify three functional dependencies from the table description. Use this form:
      ```sql
      A -> B, C
      ```
      `A` functionally determines `B` and `C`.
    ]

    #subtask(points: 6)[
      Describe two distinct anomalies or data redundancies. For each one, name the applicable schema columns.
    ]

    #subtask(points: 14)[
      Decompose the table into 3NF relations. Mark primary-key attributes with `(PK)` and foreign-key attributes with `(FK)`. Do not write SQL in this subtask.
    ]

    #subtask(points: 8)[
      Write SQL `CREATE TABLE` statements for two relations from your 3NF design. Each statement must include a primary key and one other constraint. At least one statement must include a foreign key.
    ]
  ],
  (
    (
      6,
      [
        Accept any three correct dependencies, for example: `member_id -> member_name, member_email`; `book_id -> book_title, author_name, genre`; `loan_id -> loan_date, due_date, member_id`; `(loan_id, book_id) -> return_date`.
      ],
    ),
    (
      6,
      [
        Award up to 3 points per well-explained anomaly. Examples: member names/emails are repeated for every borrowed book; book title/author/genre are repeated for every loan; changing a member email requires many updates; deleting the last loan of a book can lose book information; a new book or member cannot be stored before a loan if using this table only.
      ],
    ),
    (
      14,
      [
        Expected structure: ```sql Member(member_id (PK), member_name, member_email)```, ```sql Book(book_id (PK), book_title, author_name, genre)```, ```sql Loan(loan_id (PK), loan_date, due_date, member_id (FK))```, and ```sql LoanItem(loan_id (PK, FK), book_id (PK, FK), return_date)```. Award points for correct keys, foreign keys, decomposition, and removal of partial dependencies.
      ],
    ),
    (
      8,
      [
        Award points for syntactically plausible SQL, primary keys, foreign key use, and relevant constraints such as ```sql NOT NULL```, ```sql UNIQUE(member_email)```, or ```sql due_date >= loan_date```.
      ],
    ),
  ),
)

#pagebreak()

#task(
  [
    Query Writing
  ],
  [
    Use the following relational schema:

    ```sql
    Member(member_id, name, email)
    Book(book_id, title, genre)
    Loan(loan_id, member_id, book_id, loan_date, return_date)
    ```

    The first attribute in each relation is its primary key. `Loan.member_id` references `Member.member_id`. `Loan.book_id` references `Book.book_id`.
  ],
  [
    #subtask(points: 6)[
      Return the name and email of each member who has an open loan. Return each member once. A loan is open when `return_date IS NULL`.
    ]

    #subtask(points: 8)[
      Return the total number of loans for each book genre that has at least one loan. Return `genre` and `loan_count`.
    ]

    #subtask(points: 8)[
      Return `member_id`, `name`, and `email` for each member who has never borrowed a book.
    ]
  ],
  (
    (
      6,
      [
        Example: `SELECT DISTINCT m.name, m.email FROM Member m JOIN Loan l ON l.member_id = m.member_id WHERE l.return_date IS NULL;`
      ],
    ),
    (
      8,
      [
        Example: `SELECT b.genre, COUNT(*) AS loan_count FROM Book b JOIN Loan l ON l.book_id = b.book_id GROUP BY b.genre;`
      ],
    ),
    (
      8,
      [
        Example: `SELECT m.* FROM Member m LEFT JOIN Loan l ON l.member_id = m.member_id WHERE l.loan_id IS NULL;` Alternative with `NOT EXISTS` is also correct.
      ],
    ),
  ),
)

#pagebreak()

#task(
  [
    Database Design: Course Registration System
  ],
  [
    Design a database for the following restricted course registration scenario.

    A university has departments. Each department has a unique name and offers courses. Each course has a globally unique course code and a title. Each course belongs to exactly one department. Each lecturer has a name and works for exactly one department.

    A course can have multiple offerings, such as offerings in different semesters. Each course offering has one course, one semester, one year, and exactly one lecturer.

    Students can enroll in course offerings. Each student has a name and a unique matriculation number. A student email address is optional and unique when present. An enrollment has an enrollment date, a status, and an optional grade. The valid status values are `active`, `completed`, and `withdrawn`.

    Use surrogate integer IDs where useful. You may add attributes, but your design must contain all specified information.
  ],
  [
    #subtask(points: 12)[
      Draw or describe the ER model. Include the required entity types, relationships, and cardinalities. Write cardinalities explicitly if your drawing is ambiguous.

      *Grading checklist*: entities (4 P), required attributes and identifiers (3 P), cardinalities (3 P), handling repeated course offerings and enrollments (2 P).
    ]

    #subtask(points: 14)[
      Transform your ER model into a relational model. Write each relation as `Table(attribute, attribute, ...)`. Mark primary keys with `(PK)` and foreign keys with `(FK)`. Mark unique attributes with `(UNIQUE)` and optional attributes with `(OPTIONAL)`.

      *Grading checklist*: correct tables (4 P), primary keys (3 P), foreign keys (4 P), optional values and uniqueness constraints (2 P), no unnecessary duplicated department/lecturer/student data (1 P).
    ]

    #subtask(points: 10)[
      Write PostgreSQL `CREATE TABLE` statements for `CourseOffering` and `Enrollment`. Include primary keys, foreign keys, and constraints for all required values.

      *Grading checklist*: syntactically valid DDL (2 P), PKs (2 P), FKs (3 P), ```sql NOT NULL```/optional values handled correctly (2 P), useful status or year constraint (1 P).
    ]

    #subtask(points: 8)[
      Return one row for each active enrollment. Include the student name, course title, and lecturer name. An enrollment is active when `status = 'active'`.

      *Grading checklist*: correct joins (4 P), filter for active enrollments (2 P), selected output columns and aliases are understandable (2 P).
    ]
  ],
  (
    (
      12,
      [
        Expected entities: Department, Lecturer, Course, CourseOffering, Student, Enrollment. Relationships: Department 1:n Lecturer; Department 1:n Course; Course 1:n CourseOffering; Lecturer 1:n CourseOffering; Student n:m CourseOffering through Enrollment. Award checklist points as specified.
      ],
    ),
    (
      14,
      [
        Expected model: `Department(department_id (PK), name (UNIQUE))`, `Lecturer(lecturer_id (PK), department_id (FK), name)`, `Course(course_id (PK), department_id (FK), course_code (UNIQUE), title)`, `CourseOffering(offering_id (PK), course_id (FK), lecturer_id (FK), semester, year)`, `Student(student_id (PK), name, email (UNIQUE, OPTIONAL), matriculation_no (UNIQUE))`, `Enrollment(student_id (PK, FK), offering_id (PK, FK), enrollment_date, status, grade (OPTIONAL))`. Equivalent normalized designs are acceptable.
      ],
    ),
    (
      10,
      [
        CourseOffering DDL should reference Course and Lecturer and require semester/year. Enrollment DDL should reference Student and CourseOffering, use a primary key, require enrollment date/status, and allow grade to be nullable. PostgreSQL syntax should be plausible.
      ],
    ),
    (
      8,
      [
        Example: `SELECT s.name AS student_name, c.title AS course_title, l.name AS lecturer_name FROM Enrollment e JOIN Student s ON s.student_id = e.student_id JOIN CourseOffering co ON co.offering_id = e.offering_id JOIN Course c ON c.course_id = co.course_id JOIN Lecturer l ON l.lecturer_id = co.lecturer_id WHERE e.status = 'active';`
      ],
    ),
  ),
)
