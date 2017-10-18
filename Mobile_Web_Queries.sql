MYSQL STATEMENTS
create table daily_mobile_query_log( uid int, ts datetime, query varchar(255), result boolean );

create table daily_web_query_log( uid int, ts datetime, query varchar(255), result boolean );

create table user_table ( uid int, country varchar(255), gender varchar(255) );

INSERT INTO daily_mobile_query_log VALUES (111, '2014-07-15 09:00:20', 'magic', true), (222, '2014-07-15 12:00:20', 'meebo', false), (333, '2014-07-15 13:05:20', 'awesome', false), (111, '2014-07-15 13:09:20', 'junk', false), (444, '2014-07-15 13:15:20', 'answer to life', NULL);

INSERT INTO daily_web_query_log VALUES (555, '2014-07-15 01:00:20', 'doo da', true), (777, '2014-07-15 13:00:20', 'jerk chicken', false), (333, '2014-07-15 15:00:20', 'mango', false), (111, '2014-07-15 19:00:20', 'flags', false), (333, '2014-07-15 22:00:20', 'san francisco', NULL);

INSERT into user_table VALUES (111, 'USA', 'M'), (222, 'USA', 'M'), (333, 'GER', 'M'), (444, 'CAN', 'F'), (555, 'USA', 'M'), (666, 'IND', 'M'), (777, 'GER', 'M');


Signals 

1 Aggregation Functions, Filters, UNION ALL
candidates should be able to do this one quickly.
Candidates should quickly realize they need some way to differentiate between mobile/web and then continue onwards
2 union all, Filters, TOP (or limit and order by)
candidates might know rank/top so then this'll be easier.
3 joins and builds up on above.
Candidates will realize it's a build up on the previous questions. Hopefully they'll recognize they don't need to differentiate by platform anymore.
4 union, aggregation, filter
They need to union first then count distinct. Props if they filter first then union then count distinct.


Question 1: Can you give me the number of queries that have no result; broken down by platform?


SELECT 
  'mobile' AS platform,
  SUM(if (result IS NULL), 1, 0) AS count
FROM daily_mobile_query_log

UNION ALL

SELECT 
  'web' AS platform,
  SUM(if (result IS NULL), 1, 0) AS count
FROM daily_web_query_log;

Question 2: for this day, what platform makes the first unsuccessful query: mobile or web?

SELECT platform, First
FROM
(SELECT
  'mobile' AS platform,
  MIN(ts) AS First
FROM daily_mobile_quary_log

UNION ALL

SELECT
  'web' AS platform,
  MIN(ts) AS First
FROM daily_web_quary_log) c
ORDER BY 1 DESC
LIMIT 1;

Question 3: Write a query to get the breakdown of successful/unsuccessful queries by country and gender.

SELECT ut.country, ut.gender, 
SUM(
  CASE 
  WHEN t1.result = 1
  THEN 1
  ELSE 0
  END) AS count_successful,
SUM(
  CASE
  WHEN t1.result is NULL
  THEN 1
  ELSE 0
  END) AS count_unsuccessful
FROM 
(
SELECT uid, result
FROM daily_mobile_query_log

UNION ALL

SELECT uid, result
FROM daily_web_query_log) t1
LEFT OUTER JOIN user_table ut
ON t1.uid = ut.uid
GROUP BY 1,2

Question 4: An analyst comes to us and says that he suspects that longer queries (more than 10 characters) are less successful. Hopefully they will be able to derive the right question. HINT: Write a SQL that tells us the number of users who have had unsuccessful queries larger than 10 characters?

SELECT count(distinct uid)
FROM 

(SELECT uid
FROM daily_mobile_query_log
WHERE result IS NULL 
AND len(query) > 10

UNION ALL

SELECT uid
FROM daily_web_query_log
WHERE result IS NULL 
AND len(query) > 10 ) c
