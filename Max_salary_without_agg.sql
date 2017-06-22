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

3) Salary rank Without ranking Function (use table from last question) 

SELECT name, salary,
(SELECT COUNT(*)+1 from employees t2 where t1.salary < t2.salary) AS rank
FROM employees t1
ORDER BY salary DESC
