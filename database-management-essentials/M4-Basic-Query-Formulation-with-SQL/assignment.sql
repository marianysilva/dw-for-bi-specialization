-- Module 4 Assignment
-- Intercollegiate Athletic Database

-- The assignment in module 4 involves SELECT statements for single table problems with
-- conditions, joins with two tables, and row summaries involving single tables. The assignment
-- extends the problems in Module 4. If you completed problems and extra problems, you should be
-- prepared for the assignment. You should execute the statements using Oracle or PostgreSQL.
-- Please number the SQL statements and format them neatly in a document. For each
-- statement, you should also take a screen snapshot demonstrating statement execution and some
-- result rows. Indicate if you used Oracle or PostgreSQL.

-- 1. List the city, state, and zip codes in the customer table. Your result should not have
-- duplicates. (Hint: The DISTINCT keyword eliminates duplicates.)
SELECT DISTINCT
  city,
  state,
  zip AS "zip code"
FROM intercollegiatedb.customer;

-- 2. List the name, department, phone number, and email address of employees with a phone
-- number beginning with “3-”.
SELECT
  empname AS "name",
  department,
  phone,
  email
FROM intercollegiatedb.employee
WHERE phone LIKE '3-%';

-- 3. List all columns of the resource table with a rate BETWEEN $10 and $20. Sort the result by rate.
SELECT
  *
FROM intercollegiatedb.resourcetbl
WHERE rate BETWEEN 10 and 20
ORDER BY rate ASC;

-- 4. List the event requests with a status of “Approved” or “Denied” and an authorized date in
-- July 2022. Include the event number, authorization date, and status in the output.
SELECT
  eventno AS "event number",
  dateauth AS "authorization date",
  status
FROM intercollegiatedb.eventrequest
WHERE
  status IN ('Approved', 'Denied')
  AND dateauth BETWEEN '2022-07-1' AND '2022-07-31';

-- 5. List the location number and name of locations that are part of the “Basketball arena”. Your
-- WHERE clause should not have a condition involving the facility number compared to a
-- constant (“F101”). Instead, you should use a condition on the FacName column for the value
-- of “Basketball arena”.
SELECT
  locno AS "location number",
  locname AS "name"
FROM intercollegiatedb.facility
LEFT JOIN intercollegiatedb.location ON facility.facno = location.facno
WHERE facname = 'Basketball arena';

-- 6. For each event plan, list the plan number, COUNT of the event plan lines, and sum of the
-- number of resources assigned. For example, plan number P100 has 4 lines and 7 resources
-- assigned. You only need to consider event plans that have at least one line.
SELECT
  planno AS "plan number",
  COUNT(DISTINCT lineno) AS "event plan lines",
  sum(resourcecnt) AS "number of resources assigned"
FROM intercollegiatedb.eventplanline
GROUP BY planno;

-- 7. For each event plan with a time start in October 2022, list the plan number, COUNT of the event
-- plan lines, and sum of the number of resources assigned. For example, plan number P100
-- has 4 lines and 7 resources assigned. The result should only contain event plans that have
-- sum of resources of 10 or more. For conditions on columns containing both date and time
-- details, you should include both the date and time for conditions testing end of day. In
-- PostgreSQL, the condition to test the end of December 2022 should use a TIMESTAMP
-- constant of '31-Dec-2022 11:59PM'. In Oracle with the DATE data type for a column, you
-- should use the TO_DATE function such AS TO_DATE('31-Dec-2022 23:59', 'DD-MonYYYY HH24:MI').
SELECT
  planno AS "plan number",
  COUNT(DISTINCT lineno) AS "event plan lines",
  sum(resourcecnt) AS "number of resources assigned"
FROM intercollegiatedb.eventplanline
WHERE timestart BETWEEN '01-Oct-2022' AND '31-Oct-2022 11:59PM'
GROUP BY planno
HAVING sum(resourcecnt) >= 10;
