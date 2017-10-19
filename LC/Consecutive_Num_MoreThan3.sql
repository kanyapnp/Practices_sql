Write a SQL query to find all numbers that appear at least three times consecutively.

# +----+-----+
# | Id | Num |
# +----+-----+
# | 1  |  1  |
# | 2  |  1  |
# | 3  |  1  |
# | 4  |  2  |
# | 5  |  1  |
# | 6  |  2  |
# | 7  |  2  |
# +----+-----+
# For example, given the above Logs table, 1 is the only number that appears consecutively for at least three times.

# +-----------------+
# | ConsecutiveNums |
# +-----------------+
# | 1               |
# +-----------------+



# Write your MySQL query statement below
# select Num, count(*)
# from 
# (SELECT 
#  Num,
# (SELECT Id - row_number() over (partition by Num order by Id)) as grp
# from Logs) tmp
# group by Num, grp
# having count(*) >= 3

Select DISTINCT l1.Num AS ConsecutiveNums 
from Logs l1, Logs l2, Logs l3 
where l1.Id=l2.Id-1 and l2.Id=l3.Id-1 
and l1.Num=l2.Num and l2.Num=l3.Num