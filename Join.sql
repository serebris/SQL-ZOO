-- The JOIN operation

/*
https://sqlzoo.net/wiki/The_JOIN_operation
This tutorial introduces JOIN which allows you to use data from two or more tables. The tables contain all matches and goals from UEFA EURO 2012 Football Championship in Poland and Ukraine.

The data is available (mysql format) at http://sqlzoo.net/euro2012.sql
*/

-- 1. Modify it to show the matchid and player name for all goals scored by Germany. To identify German players, check for: teamid = 'GER'

SELECT matchid, player
FROM goal 
WHERE teamid = 'GER';

-- 2. Show id, stadium, team1, team2 for just game 1012

SELECT id,stadium,team1,team2
FROM game
WHERE id = 1012;

-- 3. Modify it to show the player, teamid, stadium and mdate for every German goal.

SELECT go.player,go.teamid, g.stadium, g.mdate
FROM game g
JOIN goal go ON (g.id=go.matchid)
WHERE teamid = 'GER';

-- 4. Show the team1, team2 and player for every goal scored by a player called Mario player LIKE 'Mario%'

SELECT g.team1, g.team2, go.player
FROM game g
JOIN goal go ON (g.id=go.matchid)
WHERE player LIKE 'Mario%';

-- 5. Show player, teamid, coach, gtime for all goals scored in the first 10 minutes gtime<=10

SELECT g.player, g.teamid, e.coach, g.gtime
FROM goal g
JOIN eteam e ON g.teamid = e.id
WHERE gtime<=10

-- 6. List the dates of the matches and the name of the team in which 'Fernando Santos' was the team1 coach.

SELECT g.mdate, e.teamname
FROM game g
JOIN eteam e ON g.team1=e.id
WHERE e.coach = 'Fernando Santos';

-- 7. List the player for every goal scored in a game where the stadium was 'National Stadium, Warsaw'

SELECT g.player
FROM goal g
JOIN game ga ON ga.id=g.matchid
WHERE ga.stadium = 'National Stadium, Warsaw';

-- 8. show the name of all players who scored a goal against Germany.

SELECT DISTINCT go.player
FROM goal go
JOIN game g ON go.matchid = g.id 
WHERE (team1='GER' OR team2='GER') AND  go.teamid != 'GER';

-- 9. Show teamname and the total number of goals scored.

SELECT e.teamname, COUNT(go.teamid)
FROM eteam e
JOIN goal go ON e.id=go.teamid
GROUP BY e.teamname;

-- 10. Show the stadium and the number of goals scored in each stadium. 

SELECT g.stadium, COUNT(go.player)
FROM game g
JOIN goal go ON go.matchid = g.id
GROUP BY g.stadium;

-- 11. For every match involving 'POL', show the matchid, date and the number of goals scored.

SELECT go.matchid, g.mdate, COUNT(go.player) goals
FROM goal go
JOIN game g ON go.matchid = g.id 
WHERE (g.team1 = 'POL' OR g.team2 = 'POL')
GROUP BY go.matchid, g.mdate;

-- 12. For every match where 'GER' scored, show matchid, match date and the number of goals scored by 'GER'

SELECT g.id, g.mdate, COUNT(go.player)
FROM game g
JOIN goal go ON g.id=go.matchid 
WHERE (g.team1 = 'GER' OR g.team2 = 'GER') AND go.teamid='GER'
GROUP BY g.id;

-- 13. List every match with the goals scored by each team as shown.

SELECT g.mdate,
       g.team1,
       SUM(CASE WHEN go.teamid = g.team1 THEN 1 ELSE 0 END) AS score1,
       team2,
       SUM(CASE WHEN go.teamid = g.team2 THEN 1 ELSE 0 END) AS score2 
FROM game g 
JOIN goal go ON (g.id = go.matchid)
    GROUP BY g.mdate, g.team1, g.team2
    ORDER BY mdate, go.matchid, g.team1, g.team2;