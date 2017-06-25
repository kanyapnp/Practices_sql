create table fct_request (
  dateid date not null,
  sender_uid int,
  recipient_uid int
);

insert into fct_request
values(STR_TO_DATE('2015-01-01', '%Y-%m-%d'), 1, 2);
insert into fct_request
values(STR_TO_DATE('2015-01-01', '%Y-%m-%d'), 1, 4);
insert into fct_request
values(STR_TO_DATE('2015-01-02', '%Y-%m-%d'), 3, 1);
insert into fct_request
values(STR_TO_DATE('2015-01-03', '%Y-%m-%d'), 4, 5);

create table fct_accept (
  dateid date not null,
  accepter_uid int,
  sender_uid int
);

insert into fct_accept
values(STR_TO_DATE('2015-01-01', '%Y-%m-%d'), 2, 1);
insert into fct_accept
values(STR_TO_DATE('2015-01-02', '%Y-%m-%d'), 4, 1);
insert into fct_accept
values(STR_TO_DATE('2015-01-02', '%Y-%m-%d'), 1, 3);

/*
fct_request

+------------+------------+---------------+ 
| dateid     | sender_uid | recipient_uid | 
+------------+------------+---------------+ 
| 2015-01-01 |          1 |             2 | 
| 2015-01-01 |          1 |             4 | 
| 2015-01-02 |          3 |             1 | 
| 2015-01-03 |          4 |             5 | 
+------------+------------+---------------+ 

fct_accept

+------------+--------------+------------+ 
| dateid     | accepter_uid | sender_uid | 
+------------+--------------+------------+ 
| 2015-01-01 |            2 |          1 | 
| 2015-01-02 |            4 |          1 | 
| 2015-01-02 |            1 |          3 | 
+------------+--------------+------------+ 

Rules:
1. You can only send a friend request to a person one time.
2. You cannot send a friend request to someone who has already sent you a friend request.
*/



/*
Q1: What percent of friend requests are accepted?
*/

SELECT 
  CASE
    WHEN fr.req_sent = 0 
    THEN 0 
    ELSE CAST(fc.req_accepted AS DOUBLE)/CAST(fr.req_sent AS DOUBLE)
  END AS accepted_rate
FROM 
(SELECT count(distinct sender_uid, recipient_uid) as req_sent
  FROM fct_request) fr
JOIN 
(SELECT count(distinct accepter_id, sender_uid) as req_accepted 
  FROM fct_accept) fc


/*
Q2: Who has the most friends?
*/ SELECT friend_1, count(distinct friend_2) 
FROM
(SELECT accepter_uid AS friend_1, sender_uid AS friend_2
FROM fct_accept
UNION
SELECT sender_uid AS friend_1, accepter_uid AS friend_2
FROM fct_accept) consolidated
group by 1
order by count(dinstinct friend_2) DESC
limit 1

/*Follow Up - What is the average days from receiving a request to accepting it per user, 
(ignoring requests that haven't been accepted)? What is the percentage of accepted requests per user?*/

Follow up 1:
fct_request: date_id, sender_uid, recipient_uid
fct_accept: date_id, accepter_uid, sender_uid

SELECT fr.recipient_uid, AVG(DATE_DIFF('day', fa.date_id, fr.date_id)) AS avg_accept_days
fct_request fr
JOIN 
fct_accept fa
ON fr.sender_uid = fa.sender_uid
AND fr.recipient_uid = fa.accepter_uid
GROUP BY 1

Follow up 2:
SELECT 
  fr.recipient_uid, 
  CASE 
    WHEN fr.received = 0
    THEN 0
    ELSE CAST(fa.accpted AS DOUBLE)/CAST(fr.received AS DOUBLE)
    END AS rate
FROM
(SELECT recipient_uid, count(distinct sender_uid) AS received
FROM fct_request 
GROUP BY 1) fr
JOIN
(SELECT accepter_uid, count(distinct sender_uid) AS accepted
FROM fct_accept
GROUP BY 1) fa
ON fr.recipient_uid = fa.accepter_uid
GROUP BY 1
