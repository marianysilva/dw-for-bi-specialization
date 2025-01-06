-- Extra Problems for Module 4
-- Order Entry Database
-- The extra problems use the Order Entry Database AS described in the Order Entry 
-- Database Background document. The course website also contains Oracle and PostgreSQL 
-- CREATE TABLE statements and INSERT statements. 
-- 1. List the customer number, the name (first and last), and the balance of customers.
SELECT
  custno AS "customer number",
  trim(concat(custfirstname, ' ', custlastname)) AS "customer name",
  custbal AS "balance of customer"
FROM
  orderdb.customer;

-- 2. List the customer number, the name (first and last), and the balance of customers who reside 
-- in Colorado (CustState is CO). 
SELECT
  custno AS "customer number",
  trim(concat(custfirstname, ' ', custlastname)) AS "customer name",
  custbal AS "balance of customer"
FROM
  orderdb.customer
WHERE
  custstate = 'CO';

-- 3. List all columns of the Product table for products costing more than $50.  Order the result by 
-- product manufacturer (ProdMfg) and product name. 
SELECT
  *
FROM
  orderdb.product
WHERE
  prodprice > 50
ORDER BY
  prodmfg,
  prodname;

-- 4. List the customer number, the name (first and last), the city, and the balance of customers 
-- who reside in Denver with a balance greater than $150 or who reside in Seattle with a 
-- balance greater than $300. 
SELECT
  custno AS "customer number",
  trim(concat(custfirstname, ' ', custlastname)) AS "customer name",
  custcity AS "city",
  custbal AS "balance of customer"
FROM
  orderdb.customer
WHERE
  (
    custcity = 'Denver'
    AND custbal > 150
  )
  OR (
    custcity = 'Seattle'
    AND custbal > 300
  );

-- 5. List the order number, order date, customer number, and customer name (first and last) of 
-- orders placed in January 2021 sent to Colorado recipients.
SELECT
  ordertbl.ordno AS "order number",
  ordertbl.orddate AS "order date",
  customer.custno AS "customer number",
  trim(
    concat(
      customer.custfirstname,
      ' ',
      customer.custlastname
    )
  ) AS "customer name"
FROM
  orderdb.ordertbl
  JOIN orderdb.customer ON ordertbl.custno = customer.custno
WHERE
  EXTRACT(
    YEAR
    FROM
      orderdb.ordertbl.orddate
  ) = 2021
  AND EXTRACT(
    MONTH
    FROM
      orderdb.ordertbl.orddate
  ) = 1
  AND ordertbl.ordstate = 'CO';

-- 6. List the average balance of customers by city. Include only customers residing in 
-- Washington state (WA).
SELECT
  custcity AS "city",
  AVG(custbal) AS "average balance of customers by city"
FROM
  orderdb.customer
WHERE
  custstate = 'WA'
GROUP BY
  1;

-- 7. List the average balance and number of customers by city. Only include customers residing 
-- in Washington State (WA).  Eliminate cities in the result with less than two customers. 
SELECT
  custcity AS "city",
  AVG(custbal) AS "average balance of customers by city"
FROM
  orderdb.customer
WHERE
  custstate = 'WA'
GROUP BY
  1
HAVING
  COUNT(DISTINCT custno) > 1;
