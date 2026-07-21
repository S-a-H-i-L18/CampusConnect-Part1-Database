-- ===========================================================
-- CampusConnect Database Indexes
-- Database Engine: SQLite 3.45+
-- File: indexes.sql
-- ===========================================================

-- ===========================================================
-- Index on course_name
-- Speeds up searches using WHERE ... IN(...)
-- ===========================================================

CREATE INDEX idx_courses_course_name
ON Courses(course_name);


-- ===========================================================
-- Index on student_id
-- Speeds up joins between Students and Enrollments.
-- ===========================================================

CREATE INDEX idx_enrollments_student_id
ON Enrollments(student_id);


-- ===========================================================
-- Composite Index on course_id and grade
-- Speeds up correlated subqueries and filtering by course
-- and grade together.
-- ===========================================================

CREATE INDEX idx_enrollments_course_grade
ON Enrollments(course_id, grade);
