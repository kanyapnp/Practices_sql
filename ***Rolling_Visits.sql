Rolling Visits - determine the number of people who have visited in the last 7 days, every day

Solution 1:
Create a table with

Id, LastVisit, DaysConsecutivelyVisited
and just update the table appropriately on each visit. The logic is clear, and there is no need for an ugly SQL query to otherwise extract the desired information.

Solution 2: 
uid, login_ts

https://jaxenter.com/10-sql-tricks-that-you-didnt-think-were-possible-125934.html
Problem 4

# SELECT uid, row_number() over (order by CAST(log_ts AS DATE)) AS login_date

Good reference 3:
https://blog.jooq.org/2015/11/07/how-to-find-the-longest-consecutive-series-of-events-in-sql/
