Consider the following activity table that logs user actions on FB

   actions
   +--------------+-----+----------+ 
   |     date     | uid |  action  | 
   +--------------+-----+----------+
   |  2015-01-01  |  1  |  'post'  | 
   |  2015-01-01  |  2  |  'like'  | 
   |  2015-01-01  |  2  |  'share' |
   |  2015-01-02  |  1  |  'share' |
   |  2015-01-02  |  3  |  'like'  |

a) Write a query to calculate the daily active users and the monthly active users for a given date (e.g. 2015-01-01)


Example Output:

   +------+------+------+
   | date | dau  | mau  |
   +------+------+------|
   |  1/1 |   2  |  23  |
   
SELECT date, 
count(distinct CASE WHEN date = '2015-01-01' THEN uid ELSE NULL END) AS dau,
COUNT(distinct CASE WHEN date > '2014-12-01' and date <= '2015-01-31' THEN uid ELSE NULL END) AS mau
FROM actions
WHERE date > '2014-12-01' and date <= '2015-01-01'
GROUP BY 1

b) These tables are huge (FB scale), perhaps trillions of rows per day. What sort of indexing could you use to make the table more accessible?

Partition on date
B-Tree index on date
Hash index on date

c) This query examines 30 days of data and performs expensive DISTINCT operations. As a result, this query may take many hours to complete. How could you restructure the algorithm/query to avoid such an expensive lookup?

keep track of each user last active date (hash index by uid) at the end of each day. Use the following update logic:
SELECT
    COALESCE(a.uid, b.uid) AS uid,
    IF(b.date > a.last_active, b,date, a.last_active) AS last_active
FROM user_last_active a
FULL OUTER JOIN actions b
ON a.uid = b.uid;
Example Output:

   user_last_active
   +-----+---------------+
   | uid |  last_active  |
   +-----+---------------|
   |  1  |   2015-01-01  |
   |  2  |   2015-01-01  |
   |  12 |   2014-12-27  |
   |  13 |   2014-12-16  |
   
SELECT '2015-01-01' as date,
SUM(CASE WHEN last_active = '2015-01-01' THEN 1 ELSE 0 END) AS dau,
SYM(CASE WHEN last_active > '2014-12-01' and last_active <='2017-01-01' THEN 1 ELSE 0 END) AS mau
from user_last_active
group by 1

Pros:

One row per user. ~1.2B rows instead of 1 trillion rows per day.
Use B-tree index on last_active to make even faster.
Dont need DISTINCT clause
Can calculate any N-day active users
Cons:

Need to update the newtable each day
