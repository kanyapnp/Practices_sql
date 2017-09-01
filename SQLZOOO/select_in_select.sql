/*
Fourth section of sqlzoo, SELECT in SELECT
*/


--#1
/*
List each country name where the population is larger than 'Russia'.
*/
SELECT name
FROM world
WHERE population >
     (SELECT population FROM world
      WHERE name='Russia')

--#2
/*
Show the countries in Europe with a per capita GDP greater than 'United Kingdom'.
*/
SELECT name
from world
where gdp/population > (select gdp/population from world where name = 'United Kingdom')
and continent = 'Europe'

--#3
/*
List the name and continent of countries in the continents containing either Argentina or Australia. Order by name of the country.
*/
SELECT name, continent
FROM world
WHERE continent IN (SELECT continent FROM world WHERE name IN ('Argentina', 'Australia'))
ORDER BY name

--#4
/*
Which country has a population that is more than Canada but less than Poland? Show the name and the population.
*/
SELECT name, population
FROM world
WHERE population >
    (SELECT population FROM world WHERE name = 'Canada')
AND population <
    (SELECT population FROM world WHERE name = 'Poland')


--#5
/*
Germany (population 80 million) has the largest population of the countries in Europe. Austria (population 8.5 million) has 11% of the population of Germany.
Show the name and the population of each country in Europe. Show the population as a percentage of the population of Germany.
*/
select name, 
concat(round(population/(select population from world where name = 'Germany')*100, 0), '%') as perc
from world
where continent = 'Europe'

--#6
/*
Which countries have a GDP greater than every country in Europe? [Give the name only.] (Some countries may have NULL gdp values)
*/
-- We can use the word ALL to allow >= or > or < or <=to act over a list. For example, you can find the largest country in the world, by population with this query:

select name
from world
where gdp > all (
select gdp
from world
where continent = 'Europe'
and gdp > 0)

SELECT name
FROM world
WHERE gdp >= ALL(SELECT gdp FROM world WHERE gdp >=0 AND continent = 'Europe') AND continent != 'Europe'

--#7
/*
Find the largest country (by area) in each continent, show the continent, the name and the area:
*/
SELECT continent, name, area
FROM world x
WHERE area >= ALL
    (SELECT area FROM world y
    WHERE y.continent=x.continent
    AND area>0)

select w.continent, w.name, w.area
from world w
join
(select continent, max(area) as ma
from world
group by 1) c_a
on w.continent = c_a.continent
and area = c_a.ma

--#8
/*
List each continent and the name of the country that comes first alphabetically.
*/

 select continent, name
from (
select continent, name, rank() over (partition by continent order by name) as r
from world) t
where t.r = 1 


SELECT continent, name
FROM world x
WHERE name <= ALL(SELECT name FROM world y WHERE y.continent = x.continent)

--#9
/*
Find the continents where all countries have a population <= 25000000.
Then find the names of the countries associated with these continents. Show name, continent and population.
*/

select name, continent, population
from world x
where 25000000 >= All (select population from world y where x.continent = y.continent and population > 0)

--#10
/*
Some countries have populations more than three times that of any of their neighbours (in the same continent). Give the countries and continents.
*/

select name, continent
from world x
where population >= ALL(
select population * 3 from world y where x.continent = y.continent
and population > 0 AND y.name != x.name
)
