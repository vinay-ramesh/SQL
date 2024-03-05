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