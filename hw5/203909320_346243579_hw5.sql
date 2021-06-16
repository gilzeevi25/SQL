/* Names:
	Gil Zeevi ID 203909320
	Joel Liurner ID 346243579
*/

use world;
/*
1) What is the average population per country?
*/
SELECT  cou.name AS Country, AVG(cit.Population) AS Avg_Population
FROM world.city AS cit, world.country AS cou
WHERE cit.CountryCode = cou.code
GROUP BY cit.CountryCode;

/*
2) Total population in the world?
   ANSWER : '6078749450'
*/
SELECT SUM(population)
FROM country;

/*
3) How many spoken languages are there??
   ANSWER : '457'
*/
SELECT COUNT(DISTINCT language)
FROM countrylanguage;

/*
4) How many countries are in each continent??
   ANSWER : 
			'37', 'North America'
			'51', 'Asia'
			'58', 'Africa'
			'46', 'Europe'
			'14', 'South America'
			'28', 'Oceania'
			'5', 'Antarctica'

*/
SELECT COUNT(name), continent
FROM country
GROUP BY continent;

/*
5) Find number of languages spoken in each country.
*/

SELECT  cou.name AS Country, COUNT(lang.language) AS language_count
FROM world.country AS cou, world.countrylanguage as lang
WHERE lang.CountryCode = cou.code
GROUP BY lang.CountryCode;

/*
6) List the countries with more than 10 spoken languages
	ANSWER:
    Canada	12
	China	12
	India	12
	Russian Federation	12
	Tanzania	11
	United States	12
	South Africa	11
*/

SELECT  cou.name AS Country, COUNT(lang.language) AS language_count
FROM world.country AS cou, world.countrylanguage as lang
WHERE lang.CountryCode = cou.code
GROUP BY lang.CountryCode
HAVING language_count > 10;

/*
7) List the top 5 countries with the highest number of spoken languages.
	ANSWER:
    Canada	12
	Russian Federation	12
	India	12
	United States	12
	China	12
*/
SELECT  cou.name AS Country, COUNT(lang.language) AS language_count
FROM world.country AS cou, world.countrylanguage as lang
WHERE lang.CountryCode = cou.code
GROUP BY lang.CountryCode
ORDER BY language_count DESC
LIMIT 5;

/*
8) Use the sakila DB for this question:
	a. Refer to the address table and list the addresses in which the phone number starts with 177.
    ANSWER:
		1998 Halifax Drive,	177727722820
		97 Shimoga Avenue, 	177167004331
*/
USE sakila;
SELECT address,phone
FROM address
WHERE phone LIKE '177%';

USE classicmodels;
/* 
9,a) For all sales rep. employee list:
	 the employee name, the total number of orders, and total payments their customers made.
*/
SELECT a.firstName, a.lastName, 
		if( a.order_count is NULL, 0, a.order_count) order_count, 
        if( b.total_pay is NULL, 0, b.total_pay) total_pay
FROM(
		SELECT emp.employeeNumber, emp.firstName,emp.lastName, COUNT(o.orderNumber) AS order_count
		FROM employees as emp 
		LEFT JOIN customers as cus
		ON  emp.employeeNumber = cus.salesRepEmployeeNumber
		LEFT JOIN  orders as o
		ON cus.customerNumber = o.customerNumber
		WHERE emp.jobTitle = 'Sales Rep'
		GROUP BY emp.employeeNumber
        ) AS a
LEFT JOIN 
	(
    SELECT emp.employeeNumber, emp.firstName,emp.lastName, COUNT(pay.checkNumber) AS total_pay
	FROM employees as emp 
	LEFT JOIN customers as cus
		ON  emp.employeeNumber = cus.salesRepEmployeeNumber
	LEFT JOIN  orders as o
		ON cus.customerNumber = o.customerNumber
	LEFT JOIN payments as pay
		ON pay.customerNumber = cus.customerNumber
	WHERE emp.jobTitle = 'Sales Rep'
	GROUP BY cus.salesRepEmployeeNumber
    ) as b
ON a.employeeNumber = b.employeeNumber;

/* 
9,b) For  all  orders  in  dispute  status  list:  the  order  number, 
 the  customer  name,  the customer  phone  number,  the  sales  representative, 
 the  sales  manager,  the  total amount paid, and the reason for the dispute.
*/

SELECT o.orderNumber, c.customerName, c.phone, 
		c.salesRepEmployeeNumber, CONCAT(emp.firstName, ' ', emp.lastName) as salesRepName,
        emp.reportsTo, CONCAT(mngr.firstName, ' ', mngr.lastName) as managerName,
		 sum(p.amount) as amount_paid, o.comments
FROM orders o
INNER JOIN customers c 
	ON o.customerNumber = c.customerNumber
INNER JOIN employees emp
	ON c.salesRepEmployeeNumber = emp.employeeNumber
INNER JOIN employees mngr
	ON mngr.employeeNumber = emp.reportsTo
LEFT JOIN payments p
	ON p.customerNumber = c.customerNumber
WHERE o.status = 'Disputed'
GROUP BY o.orderNumber;

/* 
9,c) Write a query that lists the total sales per year.
*/
SELECT count(*) total_sales, YEAR(orderDate) as year
FROM orders
GROUP BY YEAR(orderDate);

/* 
10) Create a database names MyWorld - This is a subset of the world database we used.
	Use the data related to Israel in the world database and
    insert in into the MyWorld tables.
*/

DROP DATABASE IF EXISTS MyWorld;
CREATE DATABASE MyWorld;

CREATE TABLE MyWorld.country
(	Code CHAR(3),
	Name CHAR(52),
	Continent ENUM('Asia', 'Europe', 'North America', 'Africa', 'Oceania', 'Antarctica', 'South America'),
	PRIMARY KEY (Code)

);
CREATE TABLE MyWorld.countrylanguage
(	CountryCode CHAR(3),
	Language CHAR(30),
	IsOfficial ENUM('T', 'F'),
	PRIMARY KEY (Language),
    FOREIGN KEY (CountryCode) REFERENCES country(Code)
);
USE world;
INSERT INTO MyWorld.country(Code,Name,Continent)
SELECT wc.Code,wc.Name,wc.Continent
FROM world.country as wc
WHERE Name = 'Israel';

INSERT INTO MyWorld.countrylanguage(CountryCode,Language,IsOfficial)
SELECT wcl.CountryCode,wcl.Language,wcl.IsOfficial 
FROM world.countrylanguage as wcl
WHERE CountryCode = 'ISR';
        
    
    
