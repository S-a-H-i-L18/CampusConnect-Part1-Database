-- ===========================================================
-- CampusConnect SQL Queries
-- Database Engine: SQLite 3.45+
-- File: queries.sql
-- ===========================================================

PRAGMA foreign_keys = ON;

-- ===========================================================
-- Query using IN
-- Displays students enrolled in Database Systems or Operating Systems.
-- ===========================================================

SELECT DISTINCT
    s.student_id,
    s.first_name,
    s.last_name,
    c.course_name
FROM Students s
INNER JOIN Enrollments e
    ON s.student_id = e.student_id
INNER JOIN Courses c
    ON e.course_id = c.course_id
WHERE c.course_name IN ('Database Systems', 'Operating Systems');


-- ===========================================================
-- Query using BETWEEN
-- Displays courses having available seats between 20 and 30.
-- ===========================================================

SELECT
    course_id,
    course_name,
    available_seats
FROM Courses
WHERE available_seats BETWEEN 20 AND 30;


-- ===========================================================
-- Query using IS NULL
-- Displays enrollments where grades have not yet been assigned.
-- ===========================================================

SELECT
    enrollment_id,
    student_id,
    course_id,
    status,
    grade
FROM Enrollments
WHERE grade IS NULL;


-- ===========================================================
-- Query using GROUP BY with HAVING
-- Displays courses having more than one enrolled student.
-- ===========================================================

SELECT
    c.course_name,
    COUNT(e.student_id) AS total_students
FROM Courses c
INNER JOIN Enrollments e
    ON c.course_id = e.course_id
GROUP BY c.course_id, c.course_name
HAVING COUNT(e.student_id) > 1;


-- ===========================================================
-- Query using INNER JOIN
-- Displays students along with the courses they are enrolled in.
-- ===========================================================

SELECT
    s.student_id,
    s.first_name || ' ' || s.last_name AS student_name,
    c.course_name,
    e.status
FROM Students s
INNER JOIN Enrollments e
    ON s.student_id = e.student_id
INNER JOIN Courses c
    ON e.course_id = c.course_id
ORDER BY student_name;


-- ===========================================================
-- Query using LEFT JOIN
-- Displays all courses along with the number of assignments.
-- ===========================================================

SELECT
    c.course_name,
    COUNT(a.assignment_id) AS total_assignments
FROM Courses c
LEFT JOIN Assignments a
    ON c.course_id = a.course_id
GROUP BY c.course_id, c.course_name
ORDER BY c.course_name;


-- ===========================================================
-- Query using RIGHT JOIN
-- Displays all assignments along with their corresponding courses.
-- ===========================================================

SELECT
    c.course_name,
    a.title AS assignment_title
FROM Courses c
RIGHT JOIN Assignments a
    ON c.course_id = a.course_id
ORDER BY c.course_name, a.title;


-- ===========================================================
-- Query using a Scalar Subquery
-- Displays the course(s) having the maximum available seats.
-- ===========================================================

SELECT
    course_id,
    course_name,
    available_seats
FROM Courses
WHERE available_seats = (
    SELECT MAX(available_seats)
    FROM Courses
);


-- ===========================================================
-- Query using a Correlated Subquery
-- Displays students whose grade is higher than the average
-- grade earned in the same course.
-- ===========================================================

SELECT
    s.student_id,
    s.first_name,
    s.last_name,
    c.course_name,
    e.grade
FROM Students s
INNER JOIN Enrollments e
    ON s.student_id = e.student_id
INNER JOIN Courses c
    ON e.course_id = c.course_id
WHERE e.grade IS NOT NULL
  AND (
        CASE e.grade
            WHEN 'A' THEN 5
            WHEN 'B' THEN 4
            WHEN 'C' THEN 3
            WHEN 'D' THEN 2
            WHEN 'F' THEN 1
        END
      ) >
      (
        SELECT AVG(
            CASE e2.grade
                WHEN 'A' THEN 5
                WHEN 'B' THEN 4
                WHEN 'C' THEN 3
                WHEN 'D' THEN 2
                WHEN 'F' THEN 1
            END
        )
        FROM Enrollments e2
        WHERE e2.course_id = e.course_id
          AND e2.grade IS NOT NULL
      );


-- ===========================================================
-- Query using EXISTS
-- Displays courses that have at least one enrolled student.
-- ===========================================================

SELECT
    c.course_id,
    c.course_name
FROM Courses c
WHERE EXISTS (
    SELECT 1
    FROM Enrollments e
    WHERE e.course_id = c.course_id
);


-- ===========================================================
-- Query using UNION
-- Displays names of all students and instructors.
-- ===========================================================

SELECT
    first_name,
    last_name,
    'Student' AS role
FROM Students

UNION

SELECT
    first_name,
    last_name,
    'Instructor' AS role
FROM Instructors

ORDER BY first_name;

-- ===========================================================
-- Query using a Window Function
-- Ranks students based on the number of courses they are enrolled in.
-- ===========================================================

SELECT
    s.student_id,
    s.first_name || ' ' || s.last_name AS student_name,
    COUNT(e.course_id) AS enrolled_courses,
    RANK() OVER (
        ORDER BY COUNT(e.course_id) DESC
    ) AS course_rank
FROM Students s
LEFT JOIN Enrollments e
    ON s.student_id = e.student_id
GROUP BY
    s.student_id,
    s.first_name,
    s.last_name
ORDER BY
    course_rank,
    student_name;
