Rolling Visits - determine the number of people who have visited in the last 7 days, every day

Solution 1:
Create a table with

Id, LastVisit, DaysConsecutivelyVisited
and just update the table appropriately on each visit. 
The logic is clear, and there is no need for an ugly SQL query to otherwise extract the desired information.

Solution 2: 
uid, login_ts

https://jaxenter.com/10-sql-tricks-that-you-didnt-think-were-possible-125934.html
Problem 4

# SELECT uid, row_number() over (order by CAST(log_ts AS DATE)) AS login_date

Good reference 3:
https://blog.jooq.org/2015/11/07/how-to-find-the-longest-consecutive-series-of-events-in-sql/

Implementation:

Table log: 
date          
----------
2010-11-26
2010-11-27
2010-11-29
2010-11-30
2010-12-01
2010-12-02
2010-12-03
2010-12-05
2010-12-06
2010-12-07
2010-12-08
2010-12-09
2010-12-13
2010-12-14

select min(date), max(date), count(*) as consecutive_days
(select 
log.*, 
row_number() over (order by date) as rnk,
dateadd(day, -row_number() over (order by date), date) as grp
from log) log
group by grp

or with CTE(common table expression):

WITH
  -- This table contains all the distinct date 
  -- instances in the data set
  dates(date) AS (
    SELECT DISTINCT CAST(CreationDate AS DATE)
    FROM Posts
    WHERE OwnerUserId = ##UserId##
  ),
   
  -- Generate "groups" of dates by subtracting the
  -- date's row number (no gaps) from the date itself
  -- (with potential gaps). Whenever there is a gap,
  -- there will be a new group
  groups AS (
    SELECT
      ROW_NUMBER() OVER (ORDER BY date) AS rn,
      dateadd(day, -ROW_NUMBER() OVER (ORDER BY date), date) AS grp,
      date
    FROM dates
  )
SELECT
  COUNT(*) AS consecutiveDates,
  MIN(week) AS minDate,
  MAX(week) AS maxDate
FROM groups
GROUP BY grp
ORDER BY 1 DESC, 2 DESC

