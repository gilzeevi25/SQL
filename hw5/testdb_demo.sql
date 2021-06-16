USE testdb;

/*****************************************************************
Demo 1
*******************************************************************/
SELECT *
FROM students;

SELECT *
FROM student_grades;

/* Cross Join example (i.e. cartasian product) */
SELECT * FROM student_grades, students;

/* implicit inner join */
SELECT * FROM student_grades, students
    WHERE student_grades.student_id = students.id;
    
/* explicit inner join - JOIN */
SELECT * FROM students
    INNER JOIN student_grades
    ON students.id = student_grades.student_id;


/* Return list of all students and courses names with grades above 90  */
SELECT students.first_name, students.last_name, students.email, student_grades.test, student_grades.grade FROM students
    INNER JOIN student_grades
    ON students.id = student_grades.student_id
    WHERE grade > 90;
/*****************************************************************
END Demo 1
*******************************************************************/



/*****************************************************************
Demo 2
*******************************************************************/
/*
Customers & Orders - inner join
*/

SELECT * FROM Orders;
SELECT * FROM customers;
-- lists the name and email of every customer followed by the item and price of orders they've made
SELECT c.name, c.email, o.item, o.price
FROM customers as c JOIN
	orders as o ON c.id=o.customer_id;

-- Left join demo
-- Come up with a query that lists the name and email of every customer followed by the item and price of orders they've made. 
-- Use a LEFT OUTER JOIN so that a customer is listed even if they've made no orders.
SELECT c.name, c.email, o.item, o.price
FROM customers as c LEFT OUTER JOIN
	orders as o ON c.id=o.customer_id;
    
    


