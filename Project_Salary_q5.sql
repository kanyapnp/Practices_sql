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

-- second highest salary per department:
SELECT * FROM(
SELECT department_id, first_name, last_name, salary,
RANK() OVER (PARTITION BY department_id ORDER BY SALARY DESC) AS rank,
FROM employees e
GROUP BY 1)
where rank = 2

-- Nth highest salary in the company
-- http://www.programmerinterview.com/index.php/database-sql/find-nth-highest-salary-sql/
SELECT * /*This is the outer query part */
FROM employees Emp1
WHERE (N-1) = ( /* Subquery starts here */
SELECT COUNT(DISTINCT(Emp2.Salary))
FROM employees Emp2
WHERE Emp2.Salary > Emp1.Salary)
