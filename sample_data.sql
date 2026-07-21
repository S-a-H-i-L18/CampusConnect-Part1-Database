-- ===========================================================
-- CampusConnect Sample Data
-- File: sample_data.sql
-- ===========================================================

PRAGMA foreign_keys = ON;

-- ===========================================================
-- Students (10 Records)
-- ===========================================================

INSERT INTO Students
(student_id, first_name, last_name, email, phone, department, registration_date)
VALUES
(1,'Rahul','Sharma','rahul.sharma@campusconnect.edu','9876543210','Computer Science','2026-01-10'),
(2,'Priya','Singh','priya.singh@campusconnect.edu','9876543211','Information Technology','2026-01-12'),
(3,'Amit','Kumar','amit.kumar@campusconnect.edu','9876543212','Electronics','2026-01-15'),
(4,'Neha','Verma','neha.verma@campusconnect.edu','9876543213','Mechanical','2026-01-18'),
(5,'Rohan','Gupta','rohan.gupta@campusconnect.edu','9876543214','Civil','2026-01-20'),
(6,'Anjali','Mehta','anjali.mehta@campusconnect.edu','9876543215','Computer Science','2026-01-22'),
(7,'Karan','Yadav','karan.yadav@campusconnect.edu','9876543216','Information Technology','2026-01-24'),
(8,'Sneha','Patel','sneha.patel@campusconnect.edu','9876543217','Electronics','2026-01-25'),
(9,'Vikas','Joshi','vikas.joshi@campusconnect.edu','9876543218','Mechanical','2026-01-27'),
(10,'Pooja','Arora','pooja.arora@campusconnect.edu','9876543219','Civil','2026-01-30');

-- ===========================================================
-- Instructors (10 Records)
-- ===========================================================

INSERT INTO Instructors
(instructor_id, first_name, last_name, email, office)
VALUES
(1,'Rajesh','Sharma','rajesh.sharma@campusconnect.edu','A-101'),
(2,'Sunita','Singh','sunita.singh@campusconnect.edu','A-102'),
(3,'Anil','Gupta','anil.gupta@campusconnect.edu','B-201'),
(4,'Meena','Verma','meena.verma@campusconnect.edu','B-202'),
(5,'Sanjay','Kapoor','sanjay.kapoor@campusconnect.edu','C-301'),
(6,'Kavita','Mehta','kavita.mehta@campusconnect.edu','C-302'),
(7,'Deepak','Yadav','deepak.yadav@campusconnect.edu','D-401'),
(8,'Nisha','Patel','nisha.patel@campusconnect.edu','D-402'),
(9,'Arvind','Malik','arvind.malik@campusconnect.edu','E-501'),
(10,'Ritu','Bansal','ritu.bansal@campusconnect.edu','E-502');

-- ===========================================================
-- Courses (10 Records)
-- ===========================================================

INSERT INTO Courses
(course_id, course_name, credits, available_seats, instructor_id)
VALUES
(1,'Database Systems',4,30,1),
(2,'Operating Systems',4,25,2),
(3,'Computer Networks',3,28,3),
(4,'Data Structures',4,35,4),
(5,'Software Engineering',3,20,5),
(6,'Artificial Intelligence',4,18,6),
(7,'Cyber Security',3,22,7),
(8,'Web Development',3,40,8),
(9,'Machine Learning',4,15,9),
(10,'Cloud Computing',3,27,10);

-- ===========================================================
-- Assignments (10 Records)
-- ===========================================================

INSERT INTO Assignments
(assignment_id, course_id, title, due_date, max_marks)
VALUES
(1,1,'SQL Project','2026-08-15',100),
(2,2,'Process Scheduling','2026-08-18',100),
(3,3,'Routing Assignment','2026-08-20',100),
(4,4,'Binary Tree Lab','2026-08-22',100),
(5,5,'SDLC Report','2026-08-25',100),
(6,6,'AI Search Algorithms','2026-08-28',100),
(7,7,'Network Security Audit','2026-08-30',100),
(8,8,'REST API Development','2026-09-02',100),
(9,9,'Prediction Model','2026-09-05',100),
(10,10,'Cloud Deployment','2026-09-08',100);

-- ===========================================================
-- Enrollments (15 Records)
-- ===========================================================

INSERT INTO Enrollments
(enrollment_id, student_id, course_id, enrollment_date, status, grade)
VALUES
(1,1,1,'2026-02-01','Completed','A'),
(2,1,2,'2026-02-01','Completed','B'),
(3,2,1,'2026-02-02','Completed','A'),
(4,2,3,'2026-02-02','Enrolled',NULL),
(5,3,4,'2026-02-03','Enrolled',NULL),
(6,3,5,'2026-02-03','Dropped',NULL),
(7,4,6,'2026-02-04','Completed','C'),
(8,5,7,'2026-02-05','Enrolled',NULL),
(9,6,8,'2026-02-05','Completed','B'),
(10,7,9,'2026-02-06','Dropped',NULL),
(11,8,10,'2026-02-06','Enrolled',NULL),
(12,9,2,'2026-02-07','Completed','A'),
(13,9,5,'2026-02-07','Enrolled',NULL),
(14,10,6,'2026-02-08','Dropped',NULL),
(15,10,8,'2026-02-08','Enrolled',NULL);

-- ===========================================================
-- Foreign Key Demonstration (Do NOT Execute)
-- Task Requirement: Insertion Order Dependency
-- ===========================================================

-- The following examples demonstrate referential integrity.
-- They are intentionally commented out so the script runs successfully.

-- Example 1:
-- This would fail if Student ID 999 does not exist.

-- INSERT INTO Enrollments
-- (enrollment_id, student_id, course_id, enrollment_date, status)
-- VALUES
-- (16,999,1,'2026-02-10','Enrolled');

-- Example 2:
-- This would fail if Course ID 999 does not exist.

-- INSERT INTO Assignments
-- (assignment_id, course_id, title, due_date, max_marks)
-- VALUES
-- (11,999,'Invalid Assignment','2026-09-15',100);

-- ===========================================================
-- End of Sample Data
-- ===========================================================
