USE `classicmodels`;

/*****************************************************************
Join demo
*******************************************************************/    

-- INNER JOIN example: https://www.mysqltutorial.org/mysql-inner-join.aspx
-- Get a list of products that include product code, name and description

SELECT 
    productCode, 
    productName, 
    textDescription
FROM
    products t1
INNER JOIN productlines t2 
    ON t1.productline = t2.productline;

-- Since the joined columns of both tables have the same name  productline, we can use the USING syntax:    
SELECT 
    productCode, 
    productName, 
    textDescription
FROM
    products
INNER JOIN productlines USING (productline);

-- List order number, order status and total sales
SELECT 
    t1.orderNumber,
    t1.status,
    SUM(quantityOrdered * priceEach) total
FROM
    orders t1
INNER JOIN orderdetails t2 
    ON t1.orderNumber = t2.orderNumber
GROUP BY orderNumber;

-- INNER JOIN – join three tables example
-- List for all orders the order dates, products name and quantity ordered
    
SELECT 
    orderDate,
    productName,
    quantityOrdered
FROM
    orders
INNER JOIN
    orderdetails USING (orderNumber)
INNER JOIN
    products USING (productCode);

    
/*
INNER JOIN using other operators for matching rows (instead of =).
you can use other operators such as greater than ( >), less than ( <), and not-equal ( <>) operator to form the join condition.
*/
/*
Example: find sales price of the product whose code is S10_1678 that is less than the manufacturer’s 
suggested retail price (MSRP) for that product.
*/
SELECT 
    orderNumber, 
    productName, 
    msrp, 
    priceEach
FROM
    products p
INNER JOIN orderdetails o 
   ON p.productcode = o.productcode
      AND p.msrp > o.priceEach
WHERE
    p.productcode = 'S10_1678';
    

/*****************************************************************
Union demo
*******************************************************************/    
-- list the names of all customers and employees.
SELECT     firstName, lastName
FROM
    employees 
UNION 
SELECT   contactFirstName, contactLastName
FROM
    customers;
    
/*
As you can see from the output, the MySQL UNION uses the column names of the first SELECT statement for the column headings of the output.
If you want to use other column headings, you need to use column aliases explicitly in the first SELECT statement 
as shown in the following example:
*/

SELECT 
    CONCAT(firstName,' ',lastName) fullname
FROM
    employees 
UNION SELECT 
    CONCAT(contactFirstName,' ',contactLastName)
FROM
    customers;

