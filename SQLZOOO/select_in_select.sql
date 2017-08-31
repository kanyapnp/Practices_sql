

select name
from world
where population > (select population from world where name = 'Russia')

SELECT name
from world
where gdp/population > (select gdp/population from world where name = 'United Kingdom')
and continent = 'Europe'

select name, continent
from world
where continent in (
select continent from world where name in ('Argentina', 'Australia')
)
order by name

select name, population
from world
where population >  (select population from world where name = 'Canada')
and population < (select population from world where name ='Poland');

select name, 
concat(round(population/(select population from world where name = 'Germany')*100, 0), '%') as perc
from world
where continent = 'Europe'

-- We can use the word ALL to allow >= or > or < or <=to act over a list. For example, you can find the largest country in the world, by population with this query:

select name
from world
where gdp > all (
select gdp
from world
where continent = 'Europe'
and gdp > 0)

select w.continent, w.name, w.area
from world w
join
(select continent, max(area) as ma
from world
group by 1) c_a
on w.continent = c_a.continent
and area = c_a.ma

select continent, name
from world x
where name <= all
(select name
from world y
where x.continent = y.continent)

select name, continent, population
from world x
where 25000000 >= All (select population from world y where x.continent = y.continent and population > 0)

select name, continent
from world x
where population >= ALL(
select population * 3 from world y where x.continent = y.continent
and population > 0 AND y.name != x.name
)
