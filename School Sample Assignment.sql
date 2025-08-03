DROP SCHEMA IF EXISTS Lesson17;
CREATE SCHEMA IF NOT EXISTS Lesson17;
USE Lesson17;

-- Problem 1
DROP TABLE IF EXISTS students;
CREATE TABLE students (
	student_id INT,
    f_name VARCHAR(20),
    l_name VARCHAR(20),
    dob DATE,
    major VARCHAR(50),
    gpa DECIMAL(2,1));
    
INSERT INTO students VALUES
	('1', 'Alex', 'Smith', '2000-01-01', 'Computer Science', '3.5'),
    ('2', 'Bella', 'Johnson', '2000-02-02', 'Business', '3.6'),
    ('3', 'Charlie', 'Brown', '2000-03-03', 'Physics', '3.7'),
    ('4', 'Diana', 'Davis', '2000-04-04', 'Mathematics', '3.8'),
    ('5', 'Ethan', 'Miller', '2000-05-05', 'Biology', '3.9');
    
DROP TABLE IF EXISTS courses;
CREATE TABLE courses (
	course_id INT,
    course_name VARCHAR(50),
    department VARCHAR(50));
    
INSERT INTO courses VALUES
	('101', 'Intro to CS', 'Computer Science'),
    ('102', 'Microeconomics', 'Economics'),
    ('103', 'General Physics', 'Physics'),
    ('104', 'Calculus I', 'Mathematics'),
    ('105', 'Biology 101', 'Biology');
    
DROP TABLE IF EXISTS instructors;
CREATE TABLE instructors (
	instructor_id INT,
    instructor_name VARCHAR(30),
    department VARCHAR(30));
    
INSERT INTO instructors VALUES
	('201', 'Dr. Adams', 'Computer Science'),
    ('202', 'Dr. Baker', 'Economics'),
    ('203', 'Dr. Clark', 'Physics'),
    ('204', 'Dr. Davis', 'Mathematics'),
    ('205', 'Dr. Evans', 'Biology');
    
DROP TABLE IF EXISTS enrollments;
CREATE TABLE enrollments (
	enrollment_id INT,
    student_id INT,
    course_id INT,
    semester VARCHAR(20),
    grade VARCHAR(1));
    
INSERT INTO enrollments VALUES
	('301', '1', '101', 'Fall 2022', 'A'),
    ('302', '2', '102', 'Fall 2023', 'B'),
    ('303', '3', '103', 'Fall 2024', 'C'),
    ('304', '4', '104', 'Spring 2024', 'D'),
    ('305', '5', '105', 'Spring 2025', 'F');
    
DROP VIEW IF EXISTS CourseSummary;
CREATE VIEW CourseSummary AS
	(SELECT course_ID "Course ID", COUNT(student_id) "Enrollments" FROM enrollments
		GROUP BY course_ID);
SELECT * FROM CourseSummary;
    
-- Problem 2
DROP VIEW IF EXISTS InstructorSchedule;
CREATE VIEW InstructorSchedule AS
	(SELECT i.instructor_name Instructor, i.department Department, c.course_name Course FROM instructors i, courses c
		WHERE i.department = c.department);
SELECT * FROM InstructorSchedule;
    
-- Problem 3
ALTER VIEW CourseSummary AS
	SELECT course_ID "Course ID", Semester, COUNT(student_id) "Enrollments" FROM enrollments
		GROUP BY course_ID, Semester;
SELECT * FROM CourseSummary;

-- Problem 4
ALTER VIEW InstructorSchedule AS 
	SELECT i.instructor_name Instructor, i.department Department, c.course_name Course, e.semester Semester FROM instructors i
		JOIN courses c ON i.department = c.department
        JOIN enrollments e ON e.course_id = c.course_id
        WHERE e.semester = "Spring 2025";
SELECT * FROM instructorschedule;

-- Problem 5
DROP VIEW IF EXISTS EligibleGraduates;
CREATE VIEW EligibleGraduates AS
	SELECT CONCAT(f_name, " ", l_name) "Student Name" FROM students
		WHERE GPA >= 3.7;
SELECT * FROM EligibleGraduates;

-- Problem 6
ALTER VIEW EligibleGraduates AS
	SELECT CONCAT(f_name, " ", l_name) "Student Name", GPA FROM students
		WHERE GPA >= 3.7;
SELECT * FROM EligibleGraduates;

-- Problem 7
RENAME TABLE CourseSummary TO CourseEnrollmentSummary;
SELECT * FROM CourseEnrollmentSummary;

-- Problem 8
DROP VIEW IF EXISTS EligibleGraduates;

-- Problem 9
WITH SemesterCourses AS
	(SELECT e.course_id, e.semester, c.course_name FROM enrollments e, courses c		
		WHERE e.course_ID = c.course_id)
        
	SELECT course_id, course_name FROM SemesterCourses
		WHERE semester = "Fall 2024";