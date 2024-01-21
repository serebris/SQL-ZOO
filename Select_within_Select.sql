-- SELECT within SELECT Tutorial

/*
This tutorial looks at how we can use SELECT statements within SELECT statements to perform more complex queries. 
https://sqlzoo.net/wiki/SELECT_within_SELECT_Tutorial

TABLE: world(name, continent, area, population, gdp)
*/

-- 1. List each country name where the population is larger than that of 'Russia'. 

SELECT name FROM world
WHERE population >
     (SELECT population FROM world
      WHERE name='Russia');

-- 2. Show the countries in Europe with a per capita GDP greater than 'United Kingdom'.

SELECT name 
FROM world
WHERE continent = 'Europe' AND GDP/population > 
	(SELECT gdp/population FROM world WHERE name = 'United Kingdom');
	
-- 3. List the name and continent of countries in the continents containing either Argentina or Australia. Order by name of the country.

SELECT  name, continent 
FROM world
WHERE continent IN 
	(SELECT continent FROM world WHERE name IN ('Argentina','Australia'))
ORDER BY name;

-- 4. Which country has a population that is more than United Kingdom but less than Germany? Show the name and the population.

SELECT name, population
FROM world
WHERE population > 
	(SELECT population FROM world WHERE name = 'United Kingdom')
AND 
population < 
	(SELECT population FROM world WHERE name = 'Germany');

-- 5. Show the name and the population of each country in Europe. Show the population as a percentage of the population of Germany.

SELECT name, CONCAT(ROUND(100*population/(SELECT population FROM world WHERE name ='Germany')), '%') 
FROM world
WHERE continent = 'Europe';

-- 6. Which countries have a GDP greater than every country in Europe? [Give the name only.] (Some countries may have NULL gdp values). We can use the word ALL to allow >= or > or < or <=to act over a list.  

SELECT name
FROM world
WHERE gdp > ALL (SELECT gdp FROM world WHERE continent ='Europe' AND gdp>0);

-- 7. Find the largest country (by area) in each continent, show the continent, the name and the area. The above example is known as a correlated or synchronized sub-query. 

SELECT continent, name, area FROM world x
WHERE area >= ALL
    (SELECT area FROM world y
     WHERE y.continent=x.continent
     AND population>0);
	 
-- 8. List each continent and the name of the country that comes first alphabetically.

SELECT continent, name 
FROM world x 
WHERE name <= ALL
 (SELECT name FROM world y WHERE x.continent = y.continent);
 

