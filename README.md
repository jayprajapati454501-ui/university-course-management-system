University Course Management System
A comprehensive SQL-based database management system designed to manage university departments, students, courses, instructors, and enrollments. This project includes relational database schema creation, data manipulation (DML), complex analytical queries, aggregate functions, and window functions.   
SQL
+ 1

🛠 Project Structure & Features
Relational Database Design: 5 core tables connected via foreign key relationships (Departments, Students, Courses, Instructors, Enrollments).   
SQL

Data Manipulation & Maintenance: INSERT, UPDATE, and table synchronization tasks.   
SQL

Data Reporting & Analysis: Advanced JOIN operations, conditional logic (CASE), group filtering (HAVING), subqueries, and window functions (OVER).   
SQL

🗄️ Database Schema & ER Model
               +-------------------+
               |    Departments    |
               +-------------------+
               | DepartmentID (PK) |
               | DepartmentName    |
               +---------+---------+
                         |
           +-------------+-------------+
           | 1                         | 1
           |                           |
           v N                         v N
    +--------------+            +--------------+
    |   Courses    |            | Instructors  |
    +--------------+            +--------------+
    | CourseID(PK) |            | InstructorID |
    | DepartmentID |            | DepartmentID |
    | CourseName   |            | Salary...    |
    | Credits      |            +--------------+
    +-------+------+
            |
            | 1
            v N
    +---------------+           +--------------+
    |  Enrollments  | N       1 |   Students   |
    +---------------+-----------+--------------+
    | EnrollmentID  |           | StudentID(PK)|
    | StudentID(FK) |           | FirstName    |
    | CourseID (FK) |           | LastName...  |
    | EnrollmentDate|           +--------------+
    +---------------+
🚀 Getting Started
Prerequisites
MySQL Server (8.0+ recommended) or any compatible SQL client (e.g., MySQL Workbench, DBeaver, VS Code SQL Extension).   
SQL

Installation & Execution
Clone this repository or download the SQL script.   
SQL

Open your SQL client and connect to your database instance.   
SQL

Run the complete SQL script (final project.sql) to automatically build the database schema and seed initial records:   
SQL

SQL
DROP DATABASE IF EXISTS university_course_management;
CREATE DATABASE university_course_management;
USE university_course_management;
⚠️ Fixed Bugs & Corrections in the Script
If you are running the source script directly, note the following bugs and their corrections:

Issue Location	Bug Description	Resolution / Fix
Table Creation	
Table is created as Course (singular), but queried as Courses (plural) later in the script. 
SQL

Rename CREATE TABLE Course to CREATE TABLE Courses. 
SQL

Foreign Keys	
Enrollments foreign key references Courses(CourseID), but the table was created as Course. 
SQL

Ensuring consistent use of Courses fixes foreign key creation. 
SQL

Data Insertion	
Table created as Enrollments (plural), but INSERT INTO Enrollment (singular) is executed. 
SQL

Change statement to INSERT INTO Enrollments. 
SQL

📊 Key Queries & Analytical Reports
1. Complete Student Status & Summary
Calculates student status based on enrollment date and counts enrolled courses per student:   
SQL

SQL
SELECT
    s.StudentID,
    CONCAT(UPPER(s.FirstName), ' ', LOWER(s.LastName)) AS StudentName,
    s.Email,
    s.EnrollmentDate,
    YEAR(s.EnrollmentDate) AS EnrollmentYear,
    CASE
        WHEN s.EnrollmentDate < DATE_SUB(CURDATE(), INTERVAL 4 YEAR) THEN 'Senior'
        ELSE 'Junior'
    END AS StudentStatus,
    COUNT(e.CourseID) AS NumberOfCourses
FROM Students s
LEFT JOIN Enrollments e ON s.StudentID = e.StudentID
GROUP BY s.StudentID, s.FirstName, s.LastName, s.Email, s.BirthDate, s.EnrollmentDate;
2. Dual Course Enrollment Check
Retrieves students enrolled in both 'Introduction to SQL' and 'Data Structures':   
SQL

SQL
SELECT
    s.StudentID,
    s.FirstName,
    s.LastName
FROM Students s
INNER JOIN Enrollments e ON s.StudentID = e.StudentID
INNER JOIN Courses c ON e.CourseID = c.CourseID
WHERE c.CourseName IN ('Introduction to SQL', 'Data Structures')
GROUP BY s.StudentID, s.FirstName, s.LastName
HAVING COUNT(DISTINCT c.CourseName) = 2;
3. Cumulative Course Enrollment (Window Function)
Calculates student counts per course alongside a running cumulative total:   
SQL

SQL
SELECT
    c.CourseID,
    c.CourseName,
    COUNT(e.StudentID) AS StudentCount,
    SUM(COUNT(e.StudentID)) OVER (ORDER BY c.CourseID) AS RunningTotal
FROM Courses c
LEFT JOIN Enrollments e ON c.CourseID = e.CourseID
GROUP BY c.CourseID, c.CourseName;
