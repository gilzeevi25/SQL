/*******************************************************************************
   Drop database if it exists
********************************************************************************/
DROP DATABASE IF EXISTS testdb;


/*******************************************************************************
   Create database
********************************************************************************/
CREATE DATABASE testdb;

USE testdb;

/*
Students and grades
*/

CREATE TABLE students (
	id INT NOT NULL AUTO_INCREMENT,
    first_name TEXT,
    last_name TEXT,
    email TEXT,
    phone TEXT,
    birthdate TEXT,
    PRIMARY KEY (id)
);

INSERT INTO students (first_name, last_name, email, phone, birthdate)
    VALUES ('Peter', 'Rabbit', 'peter@rabbit.com', '555-6666', '2002-06-24');
INSERT INTO students (first_name, last_name, email, phone, birthdate)
    VALUES ('Alice', 'Wonderland', 'alice@wonderland.com', '555-4444', '2002-07-04');
    
CREATE TABLE student_grades (
    course_id INTEGER,
    student_id INTEGER,
    test TEXT,
    grade INTEGER);

INSERT INTO student_grades (course_id, student_id, test, grade)
    VALUES (123, 1, 'Nutrition', 95);
INSERT INTO student_grades 
    VALUES (123, 2, 'Nutrition', 92);
INSERT INTO student_grades 
    VALUES (125, 1, 'Chemistry', 85);
INSERT INTO student_grades 
    VALUES (125, 2, 'Chemistry', 95);


-- Customers & Otders

CREATE TABLE customers (
    id INT NOT NULL AUTO_INCREMENT,
    name CHAR(100),
    email CHAR(100),
    PRIMARY KEY(id)
);
 
INSERT INTO customers (name, email) VALUES ('Doctor Who', 'doctorwho@timelords.com');
INSERT INTO customers (name, email) VALUES ('Harry Potter', 'harry@potter.com');
INSERT INTO customers (name, email) VALUES ('Captain Awesome', 'captain@awesome.com');

CREATE TABLE orders (
    id INTEGER NOT NULL AUTO_INCREMENT,
    customer_id INTEGER,
    item CHAR(100),
    price REAL,
    PRIMARY KEY (id)
);

INSERT INTO orders (customer_id, item, price)
    VALUES (1, 'Sonic Screwdriver', 1000.00);
INSERT INTO orders (customer_id, item, price)
    VALUES (2, 'High Quality Broomstick', 40.00);
INSERT INTO orders (customer_id, item, price)
    VALUES (1, 'TARDIS', 1000000.00);
 
 /*****************************************************************************************
 Start demo
 *****************************************************************************************/

