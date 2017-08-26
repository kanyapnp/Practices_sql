create table #t (Id int, Name char)

insert into #t values
(1, 'A'),
(2, 'A'),
(3, 'B'),
(4, 'B'),
(5, 'B'),
(6, 'B'),
(7, 'C'),
(8, 'B'),
(9, 'B')


select name, count(*) 
from (select t.*,
             (row_number() over (order by id) -
              row_number() over (partition by name order by id)
             ) as grp
      from t
     ) t
group by grp, name;
