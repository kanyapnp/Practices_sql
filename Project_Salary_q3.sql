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

/* Question 3:
Who has the highest paid person per department?

Output:
+------------+-----------+-------------+--------+ 
| first_name | last_name | name        | salary | 
+------------+-----------+-------------+--------+ 
| John       | Smith     | Reporting   |  20000 | 
| Ian        | Peterson  | Engineering |  80000 | 
| John       | Mills     | Marketing   |  50000 | 
| Ava        | Muffinson | Silly Walks |  10000 | 
+------------+-----------+-------------+--------+ 
4 rows in set (0.00 sec) 


Your SQL:*/
SELECT e.first_name, e.last_name, d.name, max_s.salary
FROM employees e
JOIN
(SELECT department_id, max(salary) AS salary
FROM employee
GROUP BY 1) max_s
ON e.department_id = max_s.department_id
AND e.salary = max_s.salary
JOIN departments d
ON max_s.department_id = d.name
