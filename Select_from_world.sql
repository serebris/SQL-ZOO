-- select from world tutorial
/*
SELECT from WORLD Tutorial
 https://sqlzoo.net/wiki/SELECT_from_WORLD_Tutorial
 */
 
 -- 2. Show the name for the countries that have a population of at least 200 million. 200 million is 200000000, there are eight zeros. 
 
SELECT name FROM world
WHERE population >= 200000000;

-- 3. Give the name and the per capita GDP for those countries with a population of at least 200 million. 

SELECT name, GDP/population as per_capita
FROM world
WHERE population >= 200000000;

-- 4. Show the name and population in millions for the countries of the continent 'South America'. Divide the population by 1000000 to get population in millions. 

SELECT name, population/1000000 as population
FROM world
WHERE continent='South America';

-- 5. Show the name and population for France, Germany, Italy 

SELECT name, population
FROM world
WHERE name IN ('France', 'Germany', 'Italy');

-- 6. Show the countries which have a name that includes the word 'United' 

SELECT name
FROM world
WHERE name LIKE 'United%';

-- 7. Show the countries that are big by area or big by population. Show name, population and area (A country is big if it has an area of more than 3 million sq km or it has a population of more than 250 million. ).

SELECT name, population, area
FROM world
WHERE area > 3000000 OR population > 250000000;

-- 8. Exclusive OR (XOR). Show the countries that are big by area (more than 3 million) or big by population (more than 250 million) but not both. Show name, population and area.

/*    Australia has a big area but a small population, it should be included.
	  Indonesia has a big population but a small area, it should be included.
	  China has a big population and big area, it should be excluded.
*/    United Kingdom has a small population and a small area, it should be excluded.

SELECT name, population, area
FROM world
WHERE area > 3000000 XOR population > 250000000;

-- 9. Show the name and population in millions and the GDP in billions for the countries of the continent 'South America'. Use the ROUND function to show the values to two decimal places. 

SELECT name, ROUND(population/1000000,2) AS 'population(million)', ROUND(GDP/1000000000,2) AS 'GDP(billion)'
FROM world
WHERE continent='South America';

-- 10. Show the name and per-capita GDP for those countries with a GDP of at least one trillion (1000000000000; that is 12 zeros). Round this value to the nearest 1000. 

SELECT name, ROUND(GDP/population,-3) AS 'per-capita GDP'
FROM world
WHERE GDP > 1000000000000;

-- 11. Show the name and capital where the name and the capital have the same number of characters.

SELECT name, capital
FROM world
WHERE LENGTH(name)=LENGTH(capital);

-- 12. Show the name and the capital where the first letters of each match. Don't include countries where the name and the capital are the same word.

SELECT name, capital
FROM world
where LEFT(name,1)=LEFT(capital,1) and name!=capital;

-- 13. Find the country that has all the vowels and no spaces in its name.

SELECT name FROM world
WHERE name LIKE '%a%' 
	AND name LIKE '%e%' 
	AND name LIKE '%i%' 
	AND name LIKE '%o%' 
	AND name LIKE '%u%' 
	AND name NOT LIKE '% %';