Solution 1:
create table marxBrothers (
    ident int IDENTITY,
    Name varchar(32)
)
go
insert marxBrothers (Name)
    select 'Groucho Marx' UNION ALL
    select 'Harpo Marx' UNION ALL
    select 'Chico Marx' UNION ALL
    select 'Groucho Marx' UNION ALL
    select 'Harpo Marx' UNION ALL
    select 'Chico Marx' UNION ALL
    select 'Groucho Marx' UNION ALL
    select 'Harpo Marx' UNION ALL
    select 'Chico Marx' UNION ALL
    select 'Groucho Marx' UNION ALL
    select 'Harpo Marx' UNION ALL
    select 'Chico Marx' UNION ALL
    select 'Zeppo Marx' UNION ALL
    select 'Gummo Marx' UNION ALL
    select 'Zeppo Marx'
  
select * from marxBrothers

delete marxBrothers
where ident > (
    select min(ident)
    from marxBrothers m
    where m.name = marxBrothers.name
)
Solution 2:

Step 1: Move the non duplicates (unique tuples) into a temporary table


CREATE TABLE new_table as
SELECT * FROM old_table WHERE 1 GROUP BY [column to remove duplicates by];
Step 2: delete delete the old table
We no longer need the table with all the duplicate entries, so drop it!


DROP TABLE old_table;
Step 3: rename the new_table to the name of the old_table


RENAME TABLE new_table TO old_table;
