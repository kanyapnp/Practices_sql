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

/* Question 2:
List the current projects and employees assigned to them.

Output:
+------------+-----------+--------------------------+
| first_name | last_name | title                    |
+------------+-----------+--------------------------+
| John       | Smith     | Update TPS Reports       |
| Ava        | Muffinson | Design 3 New Silly Walks |
| Cailin     | Ninson    | Build a cool site        |
| Mike       | Peterson  | Build a cool site        |
| Ian        | Peterson  | Build a cool site        |
+------------+-----------+--------------------------+
5 rows in set (0.00 sec)

Your SQL:*/
SELECT e.first_name, e.last_name, p.title
FROM employees e
JOIN employees_projects ep
ON e.id = ep.employee_id
RIGHT OUTER JOIN projects p
ON ep.project_id = p.id

 SELECT
   e.first_name,
   e.last_name,
   p.title
 FROM projects p
 LEFT OUTER JOIN employees_projects ep
 ON p.id = ep.project_id
 JOIN employees e
 ON ep.employee_id = e.id;
