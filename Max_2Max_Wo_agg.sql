Given a Table with Account and Revenue for a month find the Max and Second Max Revenue from that table without using MAX function. 
Also any windowing functions (like Lead/Lag/Rank/Row Number) are not allowed. Rowid/ rownum/limit. not allowed as well. 
You can use joins, filter conditions, Group By /Order by 
=> This tests self join to count records that are greater than each record. 

Generic solution:

SELECT t1.revenue
FROM table t1
WHERE N-1 = (
  SELECT COUNT(DISTINCT t2.salary)
  FROM table t2
  WHERE t2.revenue > t1.revenue 
)

Max:
SELECT revenue
from table 
WHERE revenue NOT IN
(SELECT small.revenue
FROM table smaller
JOIN table bigger
WHERE smaller.revenue<bigger.revenue)

2nd_Max:
SELECT t1.evenue
FROM table t1
WHERE 1 = (
  SELECT COUNT(DISTINCT ts.salary) 
  FROM table t2
  WHERE t2.revenue > t1.revenue
)
