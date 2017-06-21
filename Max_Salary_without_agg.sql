Suppose we have an employee table containing salaries.

   employees
   +--------+----+---------+---------+
   |  name  | id |  dept   | salary  |
   +--------+----+---------+---------+
   | John   |  1 | SW      |  70000  |
   | Bob    |  2 | SW      |  90000  |
   | Simon  |  3 | Data    |  95000  |
   | Andy   |  4 | Data    |  50000  |
   | Eric   |  5 | Legal   |  60000  |
   | Matt   |  6 | Legal   | 100000  |
   +--------+----+---------+---------+

3) Max Employee ID Without Max Function (use table from last question) 

Find the max employee id without using the MAX, or TOP or ORDER function? Assume no duplicates.

official answer:
SELECT DISTINCT id
FROM employees
WHERE id NOT IN (
    SELECT a.id
    FROM employees a
    JOIN employees b
    ON a.id < b.id );

SELECT id
from employees e1
WHERE 0 = (
SELECT count(distinct id)
FROM employees e2
where e2.id > e1.id
)

http://www.programmerinterview.com/index.php/database-sql/find-maximum-value-without-using-aggregate/

SELECT distinct id from
employees where id not in (
SELECT smaller.id
FROM employees smaller
JOIN employees larger
WHERE smaller.id < larger.id)

Alternative Solution

  SELECT e.id
  FROM employees e
  WHERE e.id >= ALL(SELECT e1.id FROM employees e1)

Alternative Solution

  SELECT e1.id
  FROM employees e1
  LEFT OUTER JOIN employees e2
  ON e1.id < e2.id
  GROUP BY e1.id
  HAVING COUNT(e2.id) = 0 

Followup: What change would you make to get the MIN instead of the MAX?

official answer: 

The values in a.id represent everything EXCEPT the min number. So change the exclusion query in the nested join from a.id to b.id.

SELECT distinct id from
employees where id not in (
SELECT bigger.id
FROM employees bigger
JOIN employees smaller
WHERE bigger.id > smaller.id)
