DROP DATABASE IF EXISTS university_course_management;

CREATE DATABASE university_course_management;

USE university_course_management;

# Create Departments Table
create table  Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(100) NOT NULL
);
insert into  Departments
(DepartmentID, DepartmentName)
VALUES
(1, 'Computer Science'),
(2, 'Mathematics'),
(3, 'Physics'),
(4, 'Business Administration'),
(5, 'Information Technology');

select * from Departments

# Create Students Table
CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100),
    BirthDate DATE,
    EnrollmentDate DATE
);
insert into  Students
(StudentID, FirstName, LastName, Email, BirthDate, EnrollmentDate)
VALUES
(1, 'Jay', 'Prajapati', 'jay@gmail.com', '2003-05-15', '2023-06-10'),
(2, 'Hiren', 'Mayavanshi', 'hiren@gmail.com', '2002-08-20', '2024-07-15'),
(3, 'Vipul', 'Patil', 'vipul@gmail.com', '2001-03-12', '2022-06-20'),
(4, 'Priyanka', 'Padshala', 'priyanka@gmail.com', '2004-01-25', '2025-07-10'),
(5, 'Dhruv', 'Patel', 'dhruv@gmail.com', '2003-11-05', '2023-08-18'),
(6, 'Rajan', 'Hingrajiya', 'rajan@gmail.com', '2002-09-14', '2021-06-12'),
(7, 'Swayam', 'Patel', 'swayam@gmail.com', '2004-02-10', '2024-06-25'),
(8, 'Shivam', 'Vansia', 'shivam@gmail.com', '2003-07-30', '2022-08-05');
# select * from students 
# Create Course Table
CREATE TABLE Course (
    CourseID INT PRIMARY KEY,
    CourseName VARCHAR(100) NOT NULL,
    DepartmentID INT,
    Credits INT,

    FOREIGN KEY (DepartmentID)
        REFERENCES Departments(DepartmentID)
);
INSERT INTO Course
(CourseID, CourseName, DepartmentID, Credits)
VALUES
(101, 'Introduction to SQL', 1, 4),
(102, 'Data Structures', 1, 4),
(103, 'Database Management', 1, 3),
(104, 'Calculus', 2, 4),
(105, 'Linear Algebra', 2, 3),
(106, 'Statistics', 2, 3),
(107, 'Physics Fundamentals', 3, 4),
(108, 'Business Management', 4, 3),
(109, 'Computer Networks', 5, 4);
select * from Course
 # Create Instructors Table
 CREATE TABLE Instructors (
    InstructorID INT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100),
    DepartmentID INT,
    Salary DECIMAL(10,2),

    FOREIGN KEY (DepartmentID)
        REFERENCES Departments(DepartmentID)
);

INSERT INTO Instructors
(InstructorID, FirstName, LastName, Email, DepartmentID, Salary)
VALUES
(1, 'jay', 'prajapati', 'jay@university.com', 1, 85000.00),
(2, 'priyanka', 'padshala', 'priyanka@university.com', 2, 72000.00),
(3, 'harry', 'mayavanshi', 'harry@university.com', 1, 95000.00),
(4, 'swayam', 'patel', 'swayam@university.com', 3, 68000.00),
(5, 'prince ', 'rabari', 'prince@university.com', 4, 78000.00),
(6, 'shivam', 'vansia', 'shivam@university.com', 5, 82000.00);


# select * from Instructors

# Create Enrollments Table
CREATE TABLE Enrollments (
    EnrollmentID INT PRIMARY KEY,
    StudentID INT,
    CourseID INT,
    EnrollmentDate DATE,

    FOREIGN KEY (StudentID)
        REFERENCES Students(StudentID),

    FOREIGN KEY (CourseID)
        REFERENCES Courses(CourseID)
);

INSERT INTO Enrollment
(EnrollmentID, StudentID, CourseID, EnrollmentDate)
VALUES
(1, 1, 101, '2023-07-01'),
(2, 2, 102, '2024-07-10'),
(3, 3, 101, '2022-07-05'),
(4, 4, 103, '2025-07-15'),
(5, 5, 101, '2023-08-20'),
(6, 6, 102, '2021-07-10'),
(7, 7, 101, '2024-08-01'),
(8, 8, 102, '2022-08-10'),
(9, 1, 102, '2023-08-05'),
(10, 2, 101, '2024-08-15'),
(11, 3, 102, '2022-08-20'),
(12, 5, 102, '2023-09-01'),
(13, 6, 101, '2021-08-15'),
(14, 7, 103, '2024-09-10'),
(15, 8, 101, '2022-09-05'),
(16, 1, 104, '2023-09-15'),
(17, 2, 104, '2024-09-20'),
(18, 3, 104, '2022-09-25');
# check all table
SELECT * FROM Students;

SELECT * FROM Course;

SELECT * FROM Instructors;

SELECT * FROM Enrollments;

SELECT * FROM Departments;
INSERT INTO Students
(StudentID, FirstName, LastName, Email, BirthDate, EnrollmentDate)
VALUES
(9, 'smitu', 'virani', 'smitu@gmail.com', '2003-04-15', '2025-06-15');
# SELECT * FROM Students;

UPDATE Students
SET Email = 'smituvirani@gmail.com'
WHERE StudentID = 9;

# Retrieve Students Enrolled After 2022

SELECT
    StudentID,
    FirstName,
    LastName,
    Email,
    EnrollmentDate
FROM Students
WHERE EnrollmentDate > '2022-12-31';
# Course Offered by Mathematics Department – Limit 5
SELECT
    c.CourseID,
    c.CourseName,
    c.Credits,
    d.DepartmentName
FROM Courses c
INNER JOIN Departments d
    ON c.DepartmentID = d.DepartmentID
WHERE d.DepartmentName = 'Mathematics'
LIMIT 5;

# Number of Students Enrolled in Each Course
SELECT
    c.CourseID,
    c.CourseName,
    COUNT(e.StudentID) AS NumberOfStudents
FROM Courses c
INNER JOIN Enrollments e
    ON c.CourseID = e.CourseID
GROUP BY
    c.CourseID,
    c.CourseName
HAVING COUNT(e.StudentID) > 5;
# Label Students as Senior or Junior
SELECT
    StudentID,
    CONCAT(FirstName, ' ', LastName) AS StudentName,
    EnrollmentDate,

    CASE	
        WHEN EnrollmentDate < DATE_SUB(CURDATE(), INTERVAL 4 YEAR)
            THEN 'Senior'
        ELSE 'Junior'
    END AS StudentStatus

FROM Students;

# Complete Student Transformation Report
SELECT
    s.StudentID,

    CONCAT(
        UPPER(s.FirstName),
        ' ',
        LOWER(s.LastName)
    ) AS StudentName,

    s.Email,

    s.BirthDate,

    s.EnrollmentDate,

    YEAR(s.EnrollmentDate) AS EnrollmentYear,

    CASE
        WHEN s.EnrollmentDate <
             DATE_SUB(CURDATE(), INTERVAL 4 YEAR)
            THEN 'Senior'
        ELSE 'Junior'
    END AS StudentStatus,

    COUNT(e.CourseID) AS NumberOfCourses

FROM Students s

LEFT JOIN Enrollments e
    ON s.StudentID = e.StudentID

GROUP BY
    s.StudentID,
    s.FirstName,
    s.LastName,
    s.Email,
    s.BirthDate,
    s.EnrollmentDate;
    
    # Students Enrolled in BOTH SQL and Data Structures
    SELECT
    s.StudentID,
    s.FirstName,
    s.LastName
FROM Students s
INNER JOIN Enrollments e
    ON s.StudentID = e.StudentID
INNER JOIN Courses c
    ON e.CourseID = c.CourseID
WHERE c.CourseName IN ('Introduction to SQL', 'Data Structures')
GROUP BY
    s.StudentID,
    s.FirstName,
    s.LastName
HAVING COUNT(DISTINCT c.CourseName) = 2;

# Average Number of Credits for All Courses
SELECT
    AVG(Credits) AS AverageCredits
FROM Courses;
SELECT
    ROUND(AVG(Credits), 2) AS AverageCredits
FROM Courses;
# Maximum Salary of Computer Science Instructors
SELECT
    MAX(i.Salary) AS MaximumSalary
FROM Instructors i
INNER JOIN Departments d
    ON i.DepartmentID = d.DepartmentID
WHERE d.DepartmentName = 'Computer Science';

# Count Students Enrolled in Each Department
SELECT
    d.DepartmentID,
    d.DepartmentName,
    COUNT(DISTINCT e.StudentID) AS NumberOfStudents
FROM Departments d
INNER JOIN Courses c
    ON d.DepartmentID = c.DepartmentID
INNER JOIN Enrollments e
    ON c.CourseID = e.CourseID
GROUP BY
    d.DepartmentID,
    d.DepartmentName;
    # INNER JOIN – Students and Their Courses
    SELECT
    s.StudentID,
    CONCAT(s.FirstName, ' ', s.LastName) AS StudentName,
    c.CourseID,
    c.CourseName,
    e.EnrollmentDate
FROM Students s
INNER JOIN Enrollments e
    ON s.StudentID = e.StudentID
INNER JOIN Courses c
    ON e.CourseID = c.CourseID;
    # LEFT JOIN – All Students and Their Courses
    SELECT
    s.StudentID,
    CONCAT(s.FirstName, ' ', s.LastName) AS StudentName,
    c.CourseID,
    c.CourseName,
    e.EnrollmentDate
FROM Students s
LEFT JOIN Enrollments e
    ON s.StudentID = e.StudentID
LEFT JOIN Courses c
    ON e.CourseID = c.CourseID;
    
 # Subquery – Students in Courses With More Than 10 Students 
 SELECT DISTINCT
    s.StudentID,
    s.FirstName,
    s.LastName
FROM Students s
INNER JOIN Enrollments e
    ON s.StudentID = e.StudentID
WHERE e.CourseID IN (
    SELECT CourseID
    FROM Enrollments
    GROUP BY CourseID
    HAVING COUNT(StudentID) > 10
);
#Extract Year From EnrollmentDate 
SELECT
    StudentID,
    EnrollmentDate,
    YEAR(EnrollmentDate) AS EnrollmentYear
FROM Students;
# Concatenate Instructor First and Last Name
SELECT
    InstructorID,
    CONCAT(FirstName, ' ', LastName) AS InstructorName
FROM Instructors;
SELECT
    InstructorID,
    CONCAT_WS(' ', FirstName, LastName) AS InstructorName
FROM Instructors;
# Running Total of Students Enrolled in Courses
SELECT
    c.CourseID,
    c.CourseName,
    COUNT(e.StudentID) AS StudentCount,

    SUM(COUNT(e.StudentID)) OVER (
        ORDER BY c.CourseID
    ) AS RunningTotal

FROM Courses c
LEFT JOIN Enrollments e
    ON c.CourseID = e.CourseID

GROUP BY
    c.CourseID,
    c.CourseName;
    
  # Complete University Course Report 
  select
    s.StudentID,

    CONCAT(s.FirstName, ' ', s.LastName) AS StudentName,

    c.CourseID,

    c.CourseName,

    d.DepartmentName,

    c.Credits,

    e.EnrollmentDate,

    YEAR(e.EnrollmentDate) AS EnrollmentYear

FROM Students s

INNER JOIN Enrollments e
    ON s.StudentID = e.StudentID

INNER JOIN Courses c
    ON e.CourseID = c.CourseID

INNER JOIN Departments d
    ON c.DepartmentID = d.DepartmentID

ORDER BY s.StudentID;