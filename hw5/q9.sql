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

SELECT count(*) total_sales, YEAR(orderDate) as year
FROM orders
GROUP BY YEAR(orderDate);

