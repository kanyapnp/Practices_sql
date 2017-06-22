4) Timezone Adjustments 

Consider a table that logs the revenue made by ad in each hour. Here measure all our ad data in Pacific Standard Time (PST) and we had the following simple table:

   ads
   +---------------+-------+----------+---------+
   |    date_pst   | ad_id | hour_pst | revenue |
   +---------------+-------+----------+---------+
   | 2015-01-02    |  1    |   1      |  10     |
   | 2015-01-02    |  1    |  13      |  20     |
   | 2015-01-02    |  2    |  12      |  30     |
   | 2015-01-02    |  2    |  20      |  10     |
   | 2015-01-02    |  3    |   6      |   0     |
   | 2015-01-02    |  3    |   1      |  10     |
   +---------------+-------+----------+---------+

a) WARMUP: Write a query to get the revenue made for each ad_id and for each date_pst.
SELECT date_pst, ad_id, SUM(revenue)
FROM ads
GROUP BY 1,2

In reality, advertisers come from all over the world, so each ad account is created in a city, which resides in a specific timezone. The timezone offset is defined in the timezone table.

   ads
   +---------------+-------+----------+---------+------------+
   |    date_pst   | ad_id | hour_pst | revenue | acct_city  |
   +---------------+-------+----------+---------+------------+
   | 2015-01-02    |  1    |   1      |  10     | LA         |
   | 2015-01-02    |  1    |  13      |  20     | LA         |
   | 2015-01-02    |  2    |  12      |  30     | Paris      |
   | 2015-01-02    |  2    |  20      |  10     | Paris      |
   | 2015-01-02    |  3    |   6      |   0     | Honolulu   |
   | 2015-01-02    |  3    |   1      |  10     | Honolulu   |
   +---------------+-------+----------+---------+------------+
   timezone
   +------------+------------+
   | acct_city  | pst_offset |
   +------------+------------+
   | LA         |    0       |
   | Paris      |    9       |
   | Honolulu   |   -2       |
   +------------+------------+

b) Write a query to get the revenue made for each ad_id and for each date -- in the account timezone

SELECT 
  CASE 
    WHEN (hour_pst + pst_offset) >= 24 THEN date_pst + interval '1' day 
    WHEN (hour_pst + pst_offset) < 0 THEN date_pst - interval '1' day
    ELSE date_pst
  END AS date,
  ad_id,
  SUM(revenue)
FROM ads a
JOIN timezone t
ON a.acct_city=t.acct_city
GROUP BY 1,2
