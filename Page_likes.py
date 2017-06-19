CREATE TABLE IF NOT EXISTS coderpad.post_likes (ds VARCHAR(10), post_id INT, num_likes INT);
INSERT INTO coderpad.post_likes (ds, post_id, num_likes) VALUES ('2014-01-01', 101, 2);
INSERT INTO coderpad.post_likes (ds, post_id, num_likes) VALUES ('2014-01-01', 102, 7);
INSERT INTO coderpad.post_likes (ds, post_id, num_likes) VALUES ('2014-01-01', 103, 0);
INSERT INTO coderpad.post_likes (ds, post_id, num_likes) VALUES ('2014-01-01', 104, 9);
INSERT INTO coderpad.post_likes (ds, post_id, num_likes) VALUES ('2014-01-02', 102, 11);
INSERT INTO coderpad.post_likes (ds, post_id, num_likes) VALUES ('2014-01-02', 103, 2);
INSERT INTO coderpad.post_likes (ds, post_id, num_likes) VALUES ('2014-01-02', 104, 1);
INSERT INTO coderpad.post_likes (ds, post_id, num_likes) VALUES ('2014-01-02', 105, 7);

/*
Table contains the number of likes a post has received on a given datestamp (ds):

post_likes
+--------------+------------+------------+
| ds           | post_id    | num_likes  |
+--------------+------------+------------+
| 2014-01-01   | 101        | 2          |
| 2014-01-01   | 102        | 7          |
| 2014-01-01   | 103        | 0          |
| 2014-01-01   | 104        | 9          |
| 2014-01-02   | 102        | 11         |
| 2014-01-02   | 103        | 2          |
| 2014-01-02   | 104        | 1          |
| 2014-01-02   | 105        | 7          |
+--------------+------------+-------------
*/

/* Q1:
Write a query to return the dates that have > 20 likes.

Example Output:
+------------+ 
| ds         | 
+------------+ 
| 2014-01-02 | 
+------------+ 
*/

SELECT ds, SUM(num_likes) 
FROM post_likes
GROUP BY 1
HAVING SUM(num_likes) > 20

/* Q2:
Write a single query to get the count of the following for a ds
* total number of posts
* total number of posts with > 0 likes

Example Output:
    +-------------+-----------+-----------------+
    | ds          | cnt_posts | cnt_posts_likes |
    +-------------+-----------+-----------------+
    | 2014-01-01  |     4     |       3         |
    | 2014-01-02  |     4     |       4         |
    +-------------+-----------+-----------------+
*/

SELECT ds, COUNT(distinct post_id) AS cnt_posts,
SUM(CASE WHEN num_likes > 0 THEN 1 ELSE 0 END) AS cnt_posts_likes
FROM post_likes
group by 1

/* Q3:
Write a query to select the post_ids that had 0 likes on 2014-01-01 and > 0 likes on 2014-01-02.
E.g. it would return the post_id of 103.</b>
*/
SELECT post_id
FROM(
SELECT post_id,
CASE WHEN ds='2014-01-01' AND num_likes = 0 THEN 1 ELSE 0 END AS f_1,
CASE WHEN ds='2014-01-02' AND num_likes > 0 THEN 1 ELSE 0 END AS f_2
FROM post_likes
WHERE ds BETWEEN '2014-01-01' AND '2014-01-02') tmp
WHERE tmp.f_1 = 1 AND tmp.f_2 = 1

SELECT a.post_id
FROM post_likes a
JOIN post_likes b
ON a.post_id = b.post_id
  AND a.ds = '2014-01-01'
  AND b.ds = '2014-01-02'
  AND a.num_likes = 0
  AND b.num_likes > 0;

/* Q3: follow-up
In real life, data may be noisy or missing. Lets say we had some post_ids that had NULL values in the num_likes column

    +--------------+------------+------------+
    | ds           | post_id    | num_likes  |
    +--------------+------------+------------+
    | 2014-01-01   | 101        | 2          |
    | 2014-01-01   | 102        | 7          |
    | 2014-01-01   | 103        | 0          |
    | 2014-01-01   | 104        | 9          |
    | 2014-01-01   | 105        | NULL       |    <-- new row
    | 2014-01-02   | 102        | 11         |
    | 2014-01-02   | 103        | 2          |
    | 2014-01-02   | 104        | 1          |
    | 2014-01-02   | 105        | 7          |
    +--------------+------------+-------------


We want to treat these NULL values as zero. Modify the query to take this into account so that we return the post_ids of 103 & 105:</i>
*/

SELECT post_id
FROM(
SELECT post_id,
CASE WHEN ds='2014-01-01' AND COALESCE(num_likes, 0)= 0 THEN 1 ELSE 0 END AS f_1,
CASE WHEN ds='2014-01-02' AND num_likes > 0 THEN 1 ELSE 0 END AS f_2
FROM post_likes
WHERE ds BETWEEN '2014-01-01' AND '2014-01-02') tmp
WHERE tmp.f_1 = 1 AND tmp.f_2 = 1

SELECT a.post_id
FROM post_likes a
JOIN post_likes b
ON a.post_id = b.post_id
  AND a.ds = '2014-01-01'
  AND b.ds = '2014-01-02'
  AND COALESCE(a.num_likes,0) = 0
  AND b.num_likes > 0;

/* Q4: 
Write a query to check that there is a unique post_id for each ds (i.e. no duplicate post_ids on a given date).
Return 1 if the test passes; 0 if the test fails.</b>

Example Output:
    +-------------+-------------+
    | ds          | test_result |
    +-------------+-------------+
    | 2014-01-01  |     1       |
    | 2014-01-02  |     1       |
    +-------------+-------------+
*/

SELECT 
  ds, 
  CASE WHEN count(*) = count(disintct post_id)
  THEN 1
  ELSE 0
  END AS test_result
FROM post_likes
GROUP BY 1

/* Q4: Follow-up
Modify the query to rollup across all dates. 
E.g. Return 1 if all tests pass on all dates; 0 if any test fails on any of the dates.</b>

Example Output:
    +---------------------+
    | overall_test_result |
    +---------------------+
    |          1          |
    +---------------------+
*/

SELECT IF (SUM(sub.test_result) = COUNT(distinct sub.ds), 1, 0) AS overall_test_result
FROM (
SELECT 
  ds, 
  CASE WHEN count(*) = count(disintct post_id)
  THEN 1
  ELSE 0
  END AS test_result
FROM post_likes
GROUP BY 1
) sub
