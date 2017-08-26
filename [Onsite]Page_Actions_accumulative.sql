Given a Table with dateid, Pageid, Number of Actions . Write a SQL that calculates the total number of actions
for a pageid and dateid in last 1,7 and 28 days 
=> One implementation is date or dateint and action each day. Or just array with actions for each day etc.

SELECT 
  dateid, 
  pageid,
  SUM(actions) actions,
  SUM(CASE
    WHEN dateid BETWEEN CURRENT_DATE - INTERVAL '6' DAY AND CURRENT_DATE
    THEN actions
    ELSE 0 END) AS actions_7d,
 SUM(CASE
    WHEN dateid BETWEEN CURRENT_DATE - INTERVAL '27' DAY AND CURRENT_DATE
    THEN actions
    ELSE 0 END) AS actions_28d, 
FROM table
WHERE date_id BETWEEN CURRENT_DATE - INTERVAL '27' DAY AND CURRENT_DATE
