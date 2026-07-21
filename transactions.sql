-- ===========================================================
-- CampusConnect Transaction Example
-- Database Engine: SQLite 3.45+
-- File: transactions.sql
-- ===========================================================

PRAGMA foreign_keys = ON;

-- ===========================================================
-- Transaction:
-- Enroll Student 8 in Course 5 and decrease
-- the available seats by one.
-- Both operations succeed together or fail together.
-- ===========================================================

-- ===========================================================
-- If any statement fails before COMMIT,
-- the transaction should be rolled back so that
-- neither change is permanently applied.
-- ===========================================================

BEGIN;

UPDATE Courses
SET available_seats = available_seats - 1
WHERE course_id = 5
  AND available_seats > 0;

INSERT INTO Enrollments
(
    enrollment_id,
    student_id,
    course_id,
    enrollment_date,
    status,
    grade
)
VALUES
(
    21,
    8,
    5,
    DATE('now'),
    'Enrolled',
    NULL
);

COMMIT;
