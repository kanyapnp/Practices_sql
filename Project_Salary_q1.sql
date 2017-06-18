/*
CoderPad provides a basic SQL sandbox with the following schema.
You can also use commands like `show tables` and `desc employees`

employees                             projects
+---------------+---------+           +---------------+---------+
| id            | int     |<----+  +->| id            | int     |
| first_name    | varchar |     |  |  | title         | varchar |
| last_name     | varchar |     |  |  | start_date    | date    |
| salary        | int     |     |  |  | end_date      | date    |
| department_id | int     |--+  |  |  | budget        | int     |
+---------------+---------+  |  |  |  +---------------+---------+
                             |  |  |
departments                  |  |  |  employees_projects
+---------------+---------+  |  |  |  +---------------+---------+
| id            | int     |<-+  |  +--| project_id    | int     |
| name          | varchar |     +-----| employee_id   | int     |
+---------------+---------+           +---------------+---------+
*/

/* Question 1:
Write a query to list the departments that have a total combined salary greater than $40,000.

Output:
+-------------+----------------+ 
| name        | combined_salary| 
+-------------+----------------+ 
| Engineering |        130000  | 
| Marketing   |         50000  | 
+-------------+----------------+ 
2 rows in set (0.00 sec)

Your SQL:*/

SELECT d.name, e.combined_salary
FROM
(SELECT department_id, SUM(salary) as combined_salary
from employee
group by 1
HAVING SUM(salary) > 40000) e
JOIN departments d
ON e.department_id = d.id

SELECT
   d.name AS department_name,
   SUM(e.salary) AS combined_salary
 FROM departments d
 LEFT OUTER JOIN employees e
 ON d.id = e.department_id
 GROUP BY d.name
 HAVING SUM(e.salary) > 40000;
