-- Module 4 Problems 
-- Intercollegiate Athletic Database
-- The problems use the intercollegiate athletics database. The course website also contain
-- 1. List the customer number, the name, the phone number, and the city of customers.
SELECT
  cusno AS "customer number",
  cusname AS "customer name",
  phone AS "phone number",
  city
FROM
  customer;

-- 2. List the customer number, the name, the phone number, and the city of customers who
-- reside in Colorado (State is CO).
SELECT
  cusno AS "customer number",
  cusname AS "customer name",
  phone AS "phone number",
  city
FROM
  customer
WHERE
  state = 'CO';

-- 3. List all columns of the EventRequest table for events costing more than $4000. Order the
-- result by the event date (DateHeld).
SELECT
  *
FROM
  eventrequest
WHERE
  estcost > 4000
ORDER BY
  dateheld;

-- 4. List the event number, the event date (DateHeld), and the estimated audience number with
-- approved status and audience greater than 9000 or with pending status and audience greater
-- than 7000.
SELECT
  eventno AS "event number",
  dateheld AS "event date",
  status,
  estaudience AS "estimated audience number"
FROM
  eventrequest
WHERE
  (
    status = 'Approved'
    and estaudience > 9000
  )
  or (
    status = 'Pending'
    and estaudience > 7000
  );

-- 5. List the event number, event date (DateHeld), customer number and customer name of
-- events placed in January 2022 by customers FROM Boulder.
SELECT
  event.eventno AS "event number",
  event.dateheld AS "event date",
  cus.cusno AS "customer number",
  cus.cusname AS "customer name"
FROM
  eventrequest AS event
  join customer AS cus ON event.cusno = cus.cusno
WHERE
  EXTRACT(
    YEAR
    FROM
      event.dateheld
  ) = 2022
  and EXTRACT(
    MONTH
    FROM
      event.dateheld
  ) = 1
  and cus.city = 'Boulder';

-- 6. List the average number of resources used (NumberFld) by plan number. Include only
-- location number L100.
SELECT
  planno,
  AVG(ResourceCnt) AS "average number of resources used"
FROM
  eventplanline
WHERE
  LocNo = 'L100'
GROUP BY
  planno;

-- 7. List the average number of resources used (NumberFld) by plan number. Only include
-- location number L100. Eliminate plans with less than two event lines containing location
-- number L100.
SELECT
  planno,
  AVG(ResourceCnt) AS "average number of resources used"
FROM
  eventplanline
WHERE
  LocNo = 'L100'
GROUP BY
  planno
having
  COUNT(DISTINCT lineno) > 1;
