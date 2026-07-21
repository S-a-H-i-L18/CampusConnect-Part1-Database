# CampusConnect – Part 1: Relational Database Design, Querying, Indexing & Transactions

## Database Engine

* **Database Engine:** SQLite 3.45+
* **Language:** SQL

---

# Project Overview

This project implements the relational database layer for the CampusConnect web platform. The database is designed to manage students, instructors, courses, assignments, and enrollments while enforcing data integrity through primary keys, foreign keys, constraints, indexes, and transactions.

The project satisfies the requirements of Part 1 of the assignment, including:

* Relational schema design
* Database normalization (up to Third Normal Form)
* Sample data population
* SQL queries
* Database indexing
* Transaction management
* Concurrency and isolation-level analysis

---

# Repository Structure

```
CampusConnect-Part1-Database/

├── schema.sql
├── sample_data.sql
├── queries.sql
├── indexes.sql
├── transactions.sql
└── README.md
```

---

# How to Run

Execute the SQL files in the following order:

1. `schema.sql`
2. `sample_data.sql`
3. `indexes.sql`
4. `queries.sql`
5. `transactions.sql`

For SQLite, ensure foreign key enforcement is enabled:

```sql
PRAGMA foreign_keys = ON;
```

---

# Schema Design

The database consists of the following tables:

* Students
* Instructors
* Courses
* Assignments
* Enrollments

The schema includes:

* Primary Keys
* Foreign Keys
* NOT NULL constraints
* DEFAULT values
* CHECK constraints
* UNIQUE constraints

Relationships:

* One instructor teaches many courses.
* One course has many assignments.
* One student can enroll in many courses.
* One course can have many students.

---

# Normalization Write-up

## Unnormalized Form (UNF)

An unnormalized version of the database could store all information in one table such as:

| Student | Course | Instructor | Assignment | Grade |
| ------- | ------ | ---------- | ---------- | ----- |

A student enrolled in multiple courses would have repeated student information in multiple rows, causing unnecessary duplication and update anomalies.

---

## First Normal Form (1NF)

The database satisfies First Normal Form because:

* Every table has a primary key.
* Every column contains atomic values.
* There are no repeating groups.
* Each row is unique.

Example:

Instead of storing multiple courses in one column, each enrollment is stored as a separate row in the Enrollments table.

---

## Second Normal Form (2NF)

The database satisfies Second Normal Form because:

* It already satisfies 1NF.
* Every non-key attribute depends on the whole primary key.
* Partial dependencies have been removed.

Example:

Course information such as course name, credits, and available seats is stored only in the Courses table instead of the Enrollments table.

This avoids partial dependency on student-course relationships.

---

## Third Normal Form (3NF)

The database satisfies Third Normal Form because:

* It satisfies 2NF.
* No non-key attribute depends on another non-key attribute.

Examples:

* Instructor information is stored in the Instructors table rather than inside Courses.
* Student details are stored only in Students.
* Assignment information is stored only in Assignments.

This removes transitive dependencies and eliminates update anomalies.

---

# Indexing Justification

The following indexes were created.

## 1. Index on `Courses(course_name)`

```sql
CREATE INDEX idx_courses_course_name
ON Courses(course_name);
```

**Purpose**

This index improves the performance of the query using the `IN` operator by allowing faster searching of course names.

---

## 2. Index on `Enrollments(student_id)`

```sql
CREATE INDEX idx_enrollments_student_id
ON Enrollments(student_id);
```

**Purpose**

This index improves JOIN operations between the Students and Enrollments tables and also benefits the window function query.

---

## 3. Composite Index on `Enrollments(course_id, grade)`

```sql
CREATE INDEX idx_enrollments_course_grade
ON Enrollments(course_id, grade);
```

**Purpose**

This composite index improves performance of the correlated subquery and other queries that filter by both course and grade.

---

## Column Deliberately Not Indexed

The `status` column in the Enrollments table was intentionally not indexed.

Reason:

* It contains only three possible values:

  * Enrolled
  * Completed
  * Dropped
* This is a low-cardinality column.
* Indexing such a column provides little performance benefit while increasing storage and maintenance overhead during insert and update operations.

---

# Transactions and Isolation

## Transaction Example

The transaction performs two related operations together:

1. Inserts a new enrollment record.
2. Decreases the available seats for the corresponding course.

Both operations are enclosed within a transaction using:

* `BEGIN`
* `COMMIT`

If an error occurs before the transaction is committed, the transaction should be rolled back so that neither operation is permanently applied. This ensures atomicity and maintains database consistency.

---

# Concurrent Access Scenario

Consider the following situation:

Only one seat remains in a course.

Two students attempt to enroll in the course at exactly the same time.

Without proper transaction isolation:

* Both transactions may read the same available seat.
* Both may successfully enroll.
* The course becomes over-enrolled.

This is a classic lost update problem.

---

# Isolation Level

The most appropriate isolation level is:

**Serializable**

Reason:

* Prevents concurrent transactions from modifying the same data simultaneously.
* Ensures transactions behave as if executed one after another.
* Prevents lost updates and maintains data consistency when multiple users enroll at the same time.

---

# Features Implemented

* Relational database schema
* Primary and foreign keys
* Referential integrity
* Domain constraints
* Third Normal Form (3NF)
* Sample data
* SQL queries
* Database indexes
* Composite index
* Transaction management
* Isolation-level analysis

---

# Conclusion

The CampusConnect database is a normalized relational database designed according to SQL best practices. It enforces referential integrity, minimizes redundancy through normalization, supports efficient querying using indexes, and maintains consistency through transactional processing and appropriate isolation-level considerations.
