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
