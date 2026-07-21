-- ===========================================================
-- CampusConnect Database Schema
-- Database Engine: SQLite 3.45+
-- File: schema.sql
-- ===========================================================

-- Enable Foreign Key Enforcement (SQLite)
PRAGMA foreign_keys = ON;

-- ===========================================================
-- Drop Existing Tables (Allows Script Re-execution)
-- ===========================================================

DROP TABLE IF EXISTS Assignments;
DROP TABLE IF EXISTS Enrollments;
DROP TABLE IF EXISTS Courses;
DROP TABLE IF EXISTS Instructors;
DROP TABLE IF EXISTS Students;

-- ===========================================================
-- Table: Students
-- ===========================================================

CREATE TABLE Students (
    student_id INTEGER PRIMARY KEY,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    email TEXT NOT NULL UNIQUE,
    phone TEXT UNIQUE,
    department TEXT NOT NULL,
    registration_date DATE NOT NULL DEFAULT CURRENT_DATE
);

-- ===========================================================
-- Table: Instructors
-- ===========================================================

CREATE TABLE Instructors (
    instructor_id INTEGER PRIMARY KEY,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    email TEXT NOT NULL UNIQUE,
    office TEXT NOT NULL
);

-- ===========================================================
-- Table: Courses
-- ===========================================================

CREATE TABLE Courses (
    course_id INTEGER PRIMARY KEY,
    course_name TEXT NOT NULL,
    credits INTEGER NOT NULL
        CHECK (credits BETWEEN 1 AND 6),

    available_seats INTEGER NOT NULL
        DEFAULT 30
        CHECK (available_seats >= 0),

    instructor_id INTEGER NOT NULL,

    FOREIGN KEY (instructor_id)
        REFERENCES Instructors(instructor_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

-- ===========================================================
-- Table: Enrollments
-- ===========================================================

CREATE TABLE Enrollments (
    enrollment_id INTEGER PRIMARY KEY,

    student_id INTEGER NOT NULL,

    course_id INTEGER NOT NULL,

    enrollment_date DATE NOT NULL
        DEFAULT CURRENT_DATE,
    
    status TEXT NOT NULL
        DEFAULT 'Enrolled'
        CHECK (
            status IN ('Enrolled', 'Completed', 'Dropped')
        ),
    
    grade TEXT
        CHECK (
            grade IN ('A','B','C','D','F')
            OR grade IS NULL
        ),

    FOREIGN KEY (student_id)
        REFERENCES Students(student_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,

    FOREIGN KEY (course_id)
        REFERENCES Courses(course_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,

    UNIQUE(student_id, course_id)
);

-- ===========================================================
-- Table: Assignments
-- ===========================================================

CREATE TABLE Assignments (

    assignment_id INTEGER PRIMARY KEY,

    course_id INTEGER NOT NULL,

    title TEXT NOT NULL,

    due_date DATE NOT NULL,

    max_marks INTEGER NOT NULL
        DEFAULT 100
        CHECK(max_marks > 0),

    FOREIGN KEY(course_id)
        REFERENCES Courses(course_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    
    UNIQUE(course_id, title)
);

-- ===========================================================
-- End of Schema
-- ===========================================================
-- End of Statement
