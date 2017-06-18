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

/* Question 4
Which employees are not currently assigned to any projects?

Example Output:
    +------------+-----------+ 
    | first_name | last_name | 
    +------------+-----------+  
    | John       | Mills     | 
    +------------+-----------+ 
*/


SELECT e.first_name, e.last_name
FROM employees e
WHERE id NOT IN 
( SELECT employee_id from employees_projects
)

SELECT e.first_name, e.last_name
FROM eomployees e
LEFT OUTER JOIN employees_projects ep
ON e.id=ep.employee_id
WHERE ep.project_id IS NULL 
