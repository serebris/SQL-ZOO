-- More JOIN operations

/*
https://sqlzoo.net/wiki/More_JOIN_operations
This tutorial introduces the notion of a join. The database consists of three tables movie , actor and casting . 
*/

-- 1. List the films where the yr is 1962 [Show id, title] 

SELECT id, title
FROM movie
WHERE yr=1962;

-- 2. Give year of 'Citizen Kane'. 

SELECT yr
FROM  movie
WHERE title = 'Citizen Kane';

-- 3. List all of the Star Trek movies, include the id, title and yr (all of these movies include the words Star Trek in the title). Order results by year. 

SELECT id, title, yr
FROM movie
WHERE title LIKE 'Star Trek%'
ORDER BY yr;

-- 4. What id number does the actor 'Glenn Close' have? 

SELECT id
FROM actor
WHERE NAME = 'Glenn Close';

-- 5. What is the id of the film 'Casablanca' 

SELECT id
FROM movie
WHERE title = 'Casablanca';

-- 6. Obtain the cast list for 'Casablanca'. Use movieid=11768, (or whatever value you got from the previous question).

SELECT a.name
FROM actor a
JOIN casting c ON c.actorid = a.id
JOIN movie m ON c.movieid = m.id
WHERE m.movieid=11768;

-- 7. Obtain the cast list for the film 'Alien' 

SELECT a.name
FROM actor a
JOIN casting c ON c.actorid = a.id
JOIN movie m ON c.movieid = m.id
WHERE m.title= 'Alien';


-- 8. List the films in which 'Harrison Ford' has appeared 

SELECT m.title
FROM movie m
JOIN casting c ON c.movieid = m.id
JOIN actor a ON c.actorid=a.id
WHERE a.name='Harrison Ford';

-- 9. List the films where 'Harrison Ford' has appeared - but not in the starring role. 

SELECT m.title
FROM movie m
JOIN casting c ON c.movieid = m.id
JOIN actor a ON c.actorid=a.id
WHERE a.name='Harrison Ford' AND c.ord!=1;

-- 10. List the films together with the leading star for all 1962 films. 

SELECT m.title, a.name as 'Leading Star'
FROM movie m
JOIN casting c ON m.id=c.movieid
JOIN actor a ON c.actorid=a.id
WHERE m.yr=1962 AND c.ord=1;

-- 11. Which were the busiest years for 'Rock Hudson', show the year and the number of movies he made each year for any year in which he made more than 2 movies. 

SELECT yr, COUNT(title) 
FROM movie 
JOIN casting ON movie.id=movieid
JOIN actor   ON actorid=actor.id
WHERE name='Rock Hudson'
GROUP BY yr
HAVING COUNT(title) > 2;

-- 12. List the film title and the leading actor for all of the films 'Julie Andrews' played in. 

SELECT m.title, a.name
FROM movie m
JOIN casting c ON (c.movieid=m.id AND c.ord=1)
JOIN actor a ON c.actorid=a.id 
WHERE m.id IN (SELECT c.movieid FROM casting WHERE c.actorid IN (
                 SELECT a.id FROM actor WHERE a.name='Julie Andrews')
                );
				
-- 13. Obtain a list, in alphabetical order, of actors who've had at least 15 starring roles. 

SELECT a.name
FROM actor a
JOIN casting c ON (a.id = c.actorid AND 
     (SELECT COUNT(c.ord) FROM casting WHERE c.actorid = a.id AND c.ord=1)
   >=15)
GROUP BY a.name;

-- 14. List the films released in the year 1978 ordered by the number of actors in the cast, then by title. 

SELECT m.title, COUNT(c.actorid) as cast
FROM movie m
JOIN casting c ON c.movieid=m.id 
WHERE yr = 1978
GROUP BY title
ORDER BY cast DESC, m.title

-- 15. List all the people who have worked with 'Art Garfunkel'. 

SELECT a.name
FROM actor a
JOIN casting c on c.actorid=a.id
WHERE c.movieid IN 
  (SELECT c.movieid FROM casting c JOIN actor a ON (a.id=c.actorid AND a.name = 'Art Garfunkel')) 
  AND name != 'Art Garfunkel';