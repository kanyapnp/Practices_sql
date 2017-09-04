AMAZON Notes

Q: Give me a SQL query that has the 2016 annual spending of an average customer in US. 

Table: unified_customoer_order_items table, has following columns.
 
order_day,
order_item_id (PK),
item_price,
item_quantity
customer_id,
marketplace_id (eg US, UK, DE, JP),
order_item_status_code (eg completed, pending, refunded, canceled),
record_updated_date

select AVG(spending) 
FROM(
Select 
Date_truncate(order_day, Year) AS year
count(distinct customer_id),
SUM(item_price*item_quantity) AS spending,
count(
from unified_customer_order_items 
where order_item_status_code = 'completed'
and year = '2016-01-01'
group by 1,2) t

SELECT 
SUM(items_price*item_quantity) / COUNT(distinct customer_id) as Avg_spending
FROM unified_customer_order_items
WHERE date_truncate('year', order_day) = '2016-01-01' 
AND order_item_status_code = 'completed'

Q2: Select the overall spending in year 2016

SELECT
SUM(CASE 
WHEN order_day BETWEEN '2016-01-01' AND '2016-12-31'
THEN item_price*item_quantity
ELSE 0
END) as Spending
from unified_customer_order_items 
where order_item_status_code = 'completed';


Q3: if the overall spending looks really off, how would you troubleshoot?

Assuming that you have already checked the upstream dependencies, like item_price, item_quantity and order_item_status_code.  Now you may want to break down into small buckets of these spending, and see which buckets have the concerning spendings..

Bucket function:

every 1000 as a bucket

Manual create buckets with Floor function:

SELECT
FLOOR((items_price*item_quantity)/1000.00)*1000 AS lower_b,
FLOOR((items_price*item_quantity)/1000.00)*1000 + 1000 as higher_b,
COUNT(customer_id)
FROM unified_customer_order_items
WHERE date_truncate('year', order_day) = '2016-01-01' 
AND order_item_status_code = 'completed' 
GROUP BY 1,2
ORDER BY 1,2


Use the bucket function NTILE:
SELECT 
NTILE(10) OVER (ORDER BY items_price*item_quantity DESC) AS Spending_group,
COUNT(*)
FROM unified_customer_order_items
WHERE date_truncate('year', order_day) = '2016-01-01' 
AND order_item_status_code = 'completed' 
GROUP BY 1
ORDER BY 1 

Use the bucket function WIDTH_BUCKET (ORACLE):

SELECT 
WIDTH_BUCKET(items_price*item_quantity, 0, 60000, 10) AS Spending_group,
count(*)
FROM unified_customer_order_items
WHERE date_truncate('year', order_day) = '2016-01-01' 
AND order_item_status_code = 'completed' 
GROUP BY 1
ORDER BY 1
