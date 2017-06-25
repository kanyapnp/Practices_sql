create table fct_sales (
  dateid date not null,
  fruit varchar(10),
  sold int
);

insert into fct_sales 
values(STR_TO_DATE('2015-01-01', '%Y-%m-%d'), 'Apple', 31);  
insert into fct_sales 
values(STR_TO_DATE('2015-01-01', '%Y-%m-%d'), 'Orange', 19);  
insert into fct_sales 
values(STR_TO_DATE('2015-01-02', '%Y-%m-%d'), 'Apple', 37);  
insert into fct_sales 
values(STR_TO_DATE('2015-01-02', '%Y-%m-%d'), 'Orange', 26);  
insert into fct_sales 
values(STR_TO_DATE('2015-01-03', '%Y-%m-%d'), 'Apple', 21);  
insert into fct_sales 
values(STR_TO_DATE('2015-01-03', '%Y-%m-%d'), 'Orange', 21);  
insert into fct_sales 
values(STR_TO_DATE('2015-01-04', '%Y-%m-%d'), 'Apple', 35);  
insert into fct_sales 
values(STR_TO_DATE('2015-01-04', '%Y-%m-%d'), 'Orange', 27);

/*
fct_sales

+------------+--------+------+ 
| dateid     | fruit  | sold | 
+------------+--------+------+ 
| 2015-01-01 | Apple  |   31 | 
| 2015-01-01 | Orange |   19 | 
| 2015-01-02 | Apple  |   37 | 
| 2015-01-02 | Orange |   26 | 
| 2015-01-03 | Apple  |   21 | 
| 2015-01-03 | Orange |   21 | 
| 2015-01-04 | Apple  |   35 | 
| 2015-01-04 | Orange |   27 | 
+------------+--------+------+ 

*/

/*
Q1: What is the difference between Apples and Oranges sold each day?

Output:
+------------+------+ 
| dateid     | sold | 
+------------+------+ 
| 2015-01-01 |   12 | 
| 2015-01-02 |   11 | 
| 2015-01-03 |    0 | 
| 2015-01-04 |    8 | 
+------------+------+ 
*/

SELECT dateid,
SUM(CASE WHEN fruit = 'Apple' THEN sold WHEN fruit = 'Orange' THEN -sold END) AS diff
FROM fct_sales
group by 1

/*Follow Up - Do this with only one table scan, what if there are more fruit, 
what if we have no row when apples or oranges is 0 on a day*/

Answer: These follow ups shoud be well covered in the above query....
