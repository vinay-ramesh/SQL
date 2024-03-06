-- SESSION 1: Intro
-- Create Database
CREATE DATABASE trendyTech;
-- Query OK, 1 row affected (0.01 sec)

-- Show List of Databases;
SHOW DATABASES;
/* 
+--------------------+
| Database           |
+--------------------+
| information_schema |
| mysql              |
| performance_schema |
| sys                |
| trendytech         |
+--------------------+
 */

-- Select database to use;
USE trendyTech;
-- OP: Database changed

-- Show, which database is in Use:
SELECT DATABASE();
/*
+------------+
| DATABASE() |
+------------+
| trendytech |
+------------+
1 row in set (0.00 sec)
 */

-- Create a Table;
CREATE TABLE tableName;

-- Show Table Structure
DESC tableName;

-- Drop a table from DB;
DROP TABLE tableName;

-- Show list of tables;
SHOW TABLES;

-- Another way to Create table
CREATE TABLE trendyTech.mySecondTable(
    name varchar(20), age int, salary int
);

-- SESSION 2: CRUD Operations
CREATE TABLE employee(
    firstName varchar(20),
    lastName varchar(20),
    age int(11),
    salary int(11),
    location varchar(20)
);
-- Describe the table structure
desc employee;
/*
+-----------+-------------+------+-----+---------+-------+
| Field     | Type        | Null | Key | Default | Extra |
+-----------+-------------+------+-----+---------+-------+
| firstName | varchar(20) | YES  |     | NULL    |       |
| lastName  | varchar(20) | YES  |     | NULL    |       |
| age       | int         | YES  |     | NULL    |       |
| salary    | int         | YES  |     | NULL    |       |
| location  | varchar(20) | YES  |     | NULL    |       |
+-----------+-------------+------+-----+---------+-------+ 
 */

-- Insert Records
INSERT INTO employee(firstName, age, salary, location) VALUES("John", 26, 1200000, "Banglore"); --can insert values of required column and restt are left as NULL, hence we need to mention column names (firstName, age, salary, location)
INSERT INTO employee VALUES("Peter","Doe", 26, 1200000, "Banglore"); --Must have to insert all the values of perticular column

-- Inserting multiple records
INSERT INTO employee VALUES("Test1","Testing", 22, 1200005, "Banglore"), ("Test2","Doe1", 26, 1200067, "Mysore"), ("Peter2","Doe2", 26, 1304000, "Manglore");

-- Display everything from table
SELECT * FROM tableName;
/*
+-----------+----------+------+---------+----------+
| firstName | lastName | age  | salary  | location |
+-----------+----------+------+---------+----------+
| John      | NULL     |   26 | 1200000 | Banglore |
+-----------+----------+------+---------+----------+ 
*/
-- Display perticular columns from table
SELECT firstName, age FROM employee;
/* 
+-----------+------+
| firstName | age  |
+-----------+------+
| John      |   26 |
+-----------+------+
*/

-- NULL, DEFAULT
-- NULL validation and DEFAULT values can be added during Table Creation phase. 
CREATE TABLE user(
    firstName varchar(20) NOT NULL,
    location varchar(20) DEFAULT "Banglore" NOT NULL
);
INSERT INTO user VALUES("Harikrishna", "Mysore");
INSERT INTO user(firstName) VALUES("Vinay");
INSERT INTO user VALUES("Sham", null); --ERROR 1048 (23000): Column 'location' cannot be null
SELECT * FROM user;
/*
+-------------+----------+
| firstName   | location |
+-------------+----------+
| Harikrishna | Mysore   |
| Vinay       | Banglore |
+-------------+----------+
 */

-- SESSION 3: PRIMARY KEY vs UNIQUE KEY
-- PRIMARY KEY --> Any record inside the table can be uniquely identidfied by PRIMARY KEY and it cannot be NULL, and in the table ideally we will have 1 column as primary key.
-- Example: product_id
-- AUTO_INCREMENT ---helps to increment the id automatically for every record added.
CREATE TABLE actors(
    id int NOT NULL AUTO_INCREMENT,
    firstName varchar(20) NOT NULL,
    location varchar(20) NOT NULL DEFAULT "Banglore",
    PRIMARY KEY(id)
);
DESC actors;
/*
+-----------+-------------+------+-----+----------+----------------+
| Field     | Type        | Null | Key | Default  | Extra          |
+-----------+-------------+------+-----+----------+----------------+
| id        | int         | NO   | PRI | NULL     | auto_increment |
| firstName | varchar(20) | NO   |     | NULL     |                |
| location  | varchar(20) | NO   |     | Banglore |                |
+-----------+-------------+------+-----+----------+----------------+ 
 */
INSERT INTO actors(firstName) VALUES("Dr.Puneet Rajkumar");
INSERT INTO actors(firstName, location) VALUES("Kapil", "Mumbai");
SELECT * FROM actors;
/*
+----+--------------------+----------+
| id | firstName          | location |
+----+--------------------+----------+
|  1 | Dr.Puneet Rajkumar | Banglore |
|  2 | Kapil              | Mumbai   |
+----+--------------------+----------+ 
 */
-- UNIQUE KEY --> Helps to hold Unique values in table  (Main purpose is to make sure that the values do not duplicate in table)and can also take NULL as value
-- REF https://www.w3schools.com/sql/sql_unique.asp
-- Ideal situation is, 1 primary key and multiple UNIQUE keys in the table
CREATE TABLE new_employee(
    id int NOT NULL AUTO_INCREMENT,
    firstName varchar(20) NOT NULL,
    email varchar(20) NOT NULL,
    PRIMARY KEY(id),
    UNIQUE(email)
);
INSERT INTO new_employee(firstName, email) values("Test", "test@gmail.com"); --success
INSERT INTO new_employee(firstName, email) values("Testing", "test3@gmail.com"); --success
INSERT INTO new_employee(firstName, email) values("Test2", "test@gmail.com"); --error ERROR 1062 (23000): Duplicate entry 'test@gmail.com' for key 'new_employee.email'
/*
+-----------+-------------+------+-----+---------+----------------+
| Field     | Type        | Null | Key | Default | Extra          |
+-----------+-------------+------+-----+---------+----------------+
| id        | int         | NO   | PRI | NULL    | auto_increment |
| firstName | varchar(20) | NO   |     | NULL    |                |
| email     | varchar(20) | NO   | UNI | NULL    |                |
+-----------+-------------+------+-----+---------+----------------+ 
 */

-- Session 4 CRUD with Truncate
CREATE TABLE employee(
    id int PRIMARY KEY AUTO_INCREMENT,
    firstName varchar(20) NOT NULL,
    lastName varchar(20) NOT NULL,
    email varchar(20) NOT NULL UNIQUE,
    age int NOT NULL,
    salary int NOT NULL,
    location varchar(30) NOT NULL DEFAULT "Banglore"
);
SELECT * FROM employee;

-- create
INSERT INTO employee(firstName, lastName, email, age, salary) VALUES("Vinay", "Ramesh", "vinay@gmail.com", 26, 1250000);
INSERT INTO employee(firstName, lastName, email, age, salary) VALUES("Krishna", "Vajramatti", "krishna@gmail.com", 26, 1250000);
INSERT INTO employee(firstName, lastName, email, age, salary) VALUES("Test", "Test", "Test@gmail.com", 26, 125000);
-- Select using where clause
SELECT * FROM employee WHERE age=26;
SELECT * FROM employee WHERE firstName="krishna"; --1 RECORD -- case in sensitive
SELECT * FROM employee WHERE BINARY firstName="krishna"; --Empty set, 1 warning (0.00 sec) -- NO RECORD FOUND - BINARY keyword added for matching evry case, case sensitive
-- Renaming the columns using AS Keyword
SELECT firstName as name FROM employee;
/*
+---------+
| name    |
+---------+
| Vinay   |
| Krishna |
+---------+ 
 */

-- Update specific record
-- If we miss the WHERE caluse in update operation, Evry row of the table will change as mentioned. 
UPDATE employee SET lastName="V" WHERE firstName="Krishna";
UPDATE employee SET salary = salary + 1000000; --Update evry employee salary by 10lakhs
UPDATE employee SET location = "Ahmedabad" WHERE firstName="krishna" AND lastName="V"; --Update evry employee salary by 10lakhs

-- Delete
DELETE FROM employee; -- Delete the whole table
DELETE FROM employee where id=3; -- Delete the perticular record from table

-- ALTER --- This helps in Updating the Structure of the Table
-- add, drop, modify the columns
ALTER TABLE employee ADD column role varchar(20);
ALTER TABLE employee DROP column role varchar(20);
ALTER TABLE employee MODIFY column firstName varchar(50); --firstname character limit increased

ALTER TABLE employee DROP PRIMARY KEY;
ALTER TABLE employee ADD UNIQUE(firstName);

-- DDL vs DML -- ref notes
-- TRUNCATE
TRUNCATE FROM employee;
-- Truncate internally drops the table first and recreats the table; 
-- DELETE will remove data one by one and if data is more , use truncate for quicker response.

-- Session 5 Foreign Key Constraint
-- Build relation between Course and Students enrolled for course using Foreign key
-- Create course and students table with foreign key
CREATE TABLE courses(
    course_id int AUTO_INCREMENT,
    course_name varchar(30) NOT NULL,
    course_duration_months DECIMAL(3,1) NOT NULL,
    course_fee int NOT NULL,
    PRIMARY KEY(course_id)
);
-- Insert Seed data for courses
INSERT INTO courses(course_name, course_duration_months, course_fee) VALUES('Big Data', 6.5, 50000);
INSERT INTO courses(course_name, course_duration_months, course_fee) VALUES('Full stack', 6, 50000);
INSERT INTO courses(course_name, course_duration_months, course_fee) VALUES('Data Science', 8.5, 60000);
INSERT INTO courses(course_name, course_duration_months, course_fee) VALUES('Data Analyst', 4, 45000);

CREATE TABLE students(
    student_id int AUTO_INCREMENT,
    student_fname varchar(30) NOT NULL,
    student_lname varchar(30) NOT NULL,
    student_mname varchar(30),
    student_email varchar(30) NOT NULL,
    student_phone varchar(15) NOT NULL,
    student_alternate_phone varchar(15),
    selected_course int NOT NULL DEFAULT 1,
    enrollment_date TIMESTAMP NOT NULL DEFAULT NOW(),
    years_of_exp int NOT NULL,
    student_company varchar(30),
    batch_date varchar(30) NOT NULL,
    source_of_joining varchar(30) NOT NULL,
    location varchar(30) NOT NULL DEFAULT "Banglore",
    PRIMARY KEY(student_id),
    UNIQUE(student_email),
    FOREIGN KEY(selected_course) REFERENCES courses(course_id)
);

SELECT student_id, student_fname, student_lname, selected_course, student_company, years_of_exp, source_of_joining, location FROM students;
-- Insert students
INSERT INTO students(student_fname, student_lname, student_email, student_phone, selected_course, years_of_exp, student_company, batch_date, source_of_joining, location) VALUES("Virat", "Kohli", "Virat@gmail.com", "9741742797", 2, 18, "RCB", "12-04-2010", "LinkedIn", "Banglore");
INSERT INTO students(student_fname, student_lname, student_email, student_phone, selected_course, years_of_exp, student_company, batch_date, source_of_joining, location) VALUES("MS", "Dhoni", "Dhoni@gmail.com", "9870653412", 1, 21, "CSK", "12-03-2008", "Selection", "Raanchi");

INSERT INTO students(student_fname, student_lname, student_email, student_phone, selected_course, years_of_exp, student_company, batch_date, source_of_joining, location) VALUES("Rahul", "Dravid", "Dravid@gmail.com", "987034561", 3, 35, "RCB", "12-03-1994", "Selection", "Banglore"), ("Yuzi", "Chahal", "Yuzi Chahal@gmail.com", "8762813866", 4, 10, "RR", "14-04-2015", "Selection", "Ponda"), ("Shreyas", "Iyar", "Iyar@gmail.com", "8769054231", 4, 9, "CSK", "12-03-2008", "Reference", "Delhi"), ("Kapil Dev", "Dev", "Dev@gmail.com", "8763923866", 4, 35, "Inidan Old", "12-03-1993", "Selection", "Punjab"),  ("Dev", "S", "DevS@gmail.com", "8783923866", 5, 5, "Inidan New", "12-03-2013", "Team Buy", "Haryana"),  ("Hardik", "Pandya", "Hardik@gmail.com", "8763923566", 2, 15, "Mumbai Indians", "12-03-20133", "Team Buy", "Mumbai"),  ("Rohit", "Sharma", "Sharma@gmail.com", "8745923866", 1, 20, "Mumbai Indians", "12-03-2010", "Team Buy", "Mumbai"),  ("ABD", "De Velliars", "ABD@gmail.com", "8763978866", 4, 22, "RCB", "12-03-2014", "Selection", "Banglore");

-- Inserting dummy data for course which is not registered results in error;
INSERT INTO students(student_fname, student_lname, student_email, student_phone, selected_course, years_of_exp, student_company, batch_date, source_of_joining, location) VALUES("Kidambi", "Test", "Kidambi@gmail.com", "987038661", 7, 40, "Delhi", "12-03-1994", "Test", "Hydrabad");
-- ERROR 1452 (23000): Cannot add or update a child row: a foreign key constraint fails (`trendytech`.`students`, CONSTRAINT `students_ibfk_1` FOREIGN KEY (`selected_course`) REFERENCES `courses` (`course_id`))

-- Session 6: DISTINCT, ORDER BY, LIMIT, LIKE Keywords;
-- ORDER BY -- Listing Data in perticular format
SELECT student_fname, years_of_exp from students ORDER BY years_of_exp; --Default Ascending order
/*
+---------------+--------------+
| student_fname | years_of_exp |
+---------------+--------------+
| Shreyas       |            9 |
| Yuzi          |           10 |
| Virat         |           18 |
| MS            |           21 |
| Rahul         |           35 |
| Kapil Dev     |           35 |
+---------------+--------------+ 
 */
SELECT student_fname, years_of_exp from students ORDER BY years_of_exp DESC; --DESC for descending order
-- Same query can also be written as 1-student_fname and 2-years_of_exp
SELECT student_fname, years_of_exp from students ORDER BY 2 DESC; --DESC for descending order
/*
+---------------+--------------+
| student_fname | years_of_exp |
+---------------+--------------+
| Rahul         |           35 |
| Kapil Dev     |           35 |
| MS            |           21 |
| Virat         |           18 |
| Yuzi          |           10 |
| Shreyas       |            9 |
+---------------+--------------+ 
 */ 
-- 2 levels of Sorting
SELECT student_fname, years_of_exp from students ORDER BY years_of_exp, student_fname;
-- Data will get sort at first by years_of_exp and then sorted as per the student_fname

-- LIMIT - Fetches limited number of records, Limit has to be used with Order by keywords
-- Sort students in ascending order and get 3 candidates with least experience.
SELECT student_fname, years_of_exp FROM students ORDER BY years_of_exp LIMIT 3;
-- Students with top 3 exp
SELECT student_fname, years_of_exp FROM students ORDER BY years_of_exp DESC LIMIT 3;

-- DISTINCT -- gives values of distict type--where values will not get repeat
SELECT DISTINCT student_company from students;
/*
+-----------------+
| student_company |
+-----------------+
| RCB             |
| CSK             |
| RR              |
| Inidan Old      |
| Inidan New      |
| Mumbai Indians  |
+-----------------+ 
 */
SELECT DISTINCT student_fname FROM students ORDER BY years_of_exp DESC LIMIT 3;
-- ERROR 3065 (HY000): Expression #1 of ORDER BY clause is not in SELECT list, references column 'trendytech.students.years_of_exp' which is not in SELECT list; this is incompatible with DISTINCT
-- This will lead to error as it hampers the order of query execution in the system --ref notes session 7
-- Correction can be done by using years_of_exp column in projection 
SELECT DISTINCT student_fname, years_of_exp FROM students ORDER BY years_of_exp DESC LIMIT 3;

-- LIKE 
-- Similar to where clause and helps to match the data with fuzzy manner
-- Students name contains "Ra" in it
SELECT student_fname FROM students where student_fname LIKE "%ra%";

-- Students name starts with "Ra"
SELECT student_fname FROM students where student_fname LIKE "ra%";

-- Students name ends with "Ra"
SELECT student_fname FROM students where student_fname LIKE "%ra";
-- % is the wild card character indicating that it can be anything

-- Students name ends with "Rohi%t" -- string itself contains % character
-- Use escape character
SELECT student_fname FROM students where student_fname LIKE "%Rohi\%t%";

-- Get students who has 5 characters in their name, use underscore( _ ), where one underscore = one character
SELECT student_fname FROM students where student_fname LIKE "_____";

-- Session 8: Aggregate Functions
-- Get all students count
SELECT COUNT(*) AS students_count FROM students;
/*
+----------------+
| students_count |
+----------------+
|             10 |
+----------------+ 
 */
SELECT COUNT(DISTINCT student_company) AS total_companies FROM students;
/*
+-----------------+
| total_companies |
+-----------------+
|               6 |
+-----------------+ 
 */

-- Get students enrolled for perticular batch of march
SELECT COUNT(*) AS students_enrolled FROM students WHERE enrollment_date LIKE "%-03-%";
/*
+-------------------+
| students_enrolled |
+-------------------+
|                10 |
+-------------------+ 
 */

-- GROUP BY - Group the data based on Logic
SELECT source_of_joining, COUNT(*) FROM students GROUP BY source_of_joining;
/*
+-------------------+----------+
| source_of_joining | COUNT(*) |
+-------------------+----------+
| Selection         |        6 |
| Reference         |        1 |
| Team Buy          |        3 |
+-------------------+----------+ 
 */
SELECT location, COUNT(*) FROM students GROUP BY location;
/*
+----------+----------+
| location | COUNT(*) |
+----------+----------+
| Banglore |        3 |
| Raanchi  |        1 |
| Ponda    |        1 |
| Delhi    |        1 |
| Punjab   |        1 |
| Haryana  |        1 |
| Mumbai   |        2 |
+----------+----------+ 
 */

-- Grouping Column should always be projected with Select statement -- otherwise error message will be thrown by system
-- ie: 
SELECT location, COUNT(*) FROM students GROUP BY source_of_joining;
-- ERROR 1055 (42000): Expression #1 of SELECT list is not in GROUP BY clause and contains nonaggregated column 'trendytech.students.location' which is not functionally dependent on columns in GROUP BY clause; this is incompatible with sql_mode=only_full_group_by

-- Group based on 2 columns
SELECT location,source_of_joining, COUNT(*) FROM students GROUP BY source_of_joining, location;
/*
+----------+-------------------+----------+
| location | source_of_joining | COUNT(*) |
+----------+-------------------+----------+
| Banglore | Selection         |        3 |
| Raanchi  | Selection         |        1 |
| Ponda    | Selection         |        1 |
| Delhi    | Reference         |        1 |
| Punjab   | Selection         |        1 |
| Haryana  | Team Buy          |        1 |
| Mumbai   | Team Buy          |        2 |
+----------+-------------------+----------+ 
 */

-- People enrolled for each course
SELECT selected_course, COUNT(*) FROM students GROUP BY selected_course;
/*
+-----------------+----------+
| selected_course | COUNT(*) |
+-----------------+----------+
|               1 |        2 |
|               2 |        2 |
|               3 |        1 |
|               4 |        4 |
|               5 |        1 |
+-----------------+----------+ 
 */

-- MIN and MAX experiences
SELECT MIN(years_of_exp) AS minimum_exp FROM students;
/*
+-------------+
| minimum_exp |
+-------------+
|           5 |
+-------------+ 
 */
SELECT MAX(years_of_exp) AS maximum_exp FROM students;
-- Min and Max with student names
SELECT MIN(years_of_exp), student_fname AS minimum_exp FROM students;
-- ERROR 1140 (42000): In aggregated query without GROUP BY, expression #2 of SELECT list contains nonaggregated column 'trendytech.students.student_fname'; this is incompatible with sql_mode=only_full_group_by

-- Correct way to define minimum experienced player with years of exp
SELECT student_fname, years_of_exp FROM students ORDER BY years_of_exp LIMIT 1;
/*
+---------------+--------------+
| student_fname | years_of_exp |
+---------------+--------------+
| Dev           |            5 |
+---------------+--------------+ 
 */

-- Correct way to define minimum experienced player with years of exp
SELECT student_fname, years_of_exp FROM students ORDER BY years_of_exp DESC LIMIT 1;
/*
+---------------+--------------+
| student_fname | years_of_exp |
+---------------+--------------+
| Rahul         |           35 |
+---------------+--------------+ 
 */

-- Based on source of joining, show max experiences
SELECT source_of_joining, MAX(years_of_exp) FROM students GROUP BY source_of_joining;
/*
+-------------------+-------------------+
| source_of_joining | MAX(years_of_exp) |
+-------------------+-------------------+
| Selection         |                35 |
| Reference         |                 9 |
| Team Buy          |                20 |
+-------------------+-------------------+ 
 */

-- Get Sum of experience based on source of joining
SELECT source_of_joining, SUM(years_of_exp) FROM students GROUP BY source_of_joining;
/*
+-------------------+-------------------+
| source_of_joining | SUM(years_of_exp) |
+-------------------+-------------------+
| Selection         |               141 |
| Reference         |                 9 |
| Team Buy          |                40 |
+-------------------+-------------------+ 
 */

-- Get Avg experience based on source of joining
SELECT source_of_joining, AVG(years_of_exp) FROM students GROUP BY source_of_joining;
/*
+-------------------+-------------------+
| source_of_joining | AVG(years_of_exp) |
+-------------------+-------------------+
| Selection         |           23.5000 |
| Reference         |            9.0000 |
| Team Buy          |           13.3333 |
+-------------------+-------------------+ 
 */