/* 6. The JOIN operation */

/* 6.1 Modify it to show the matchid and player name for all goals scored by Germany.
To identify German players, check for: teamid = 'GER'. */

SELECT matchid, player FROM goal 
    WHERE teamid = 'GER';

/* 6.2 From the previous query you can see that Lars Bender's scored a goal in game 1012. Now we want to know what teams were playing in that match.
Notice in the that the column matchid in the goal table corresponds to the id column in the game table. We can look up information about game 1012 
by finding that row in the game table. Show id, stadium, team1, team2 for just game 1012. */

SELECT DISTINCT id,stadium,team1,team2 FROM game
    INNER JOIN goal
    ON 
    game.id = goal.matchid
    WHERE id = 1012;

/* 6.3 You can combine the two steps into a single query with a JOIN. Modify it to show the player, teamid, stadium and mdate for every German goal. */

SELECT DISTINCT goal.player,goal.teamid,game.stadium,game.mdate FROM game
    JOIN goal
    ON 
    game.id = goal.matchid
    WHERE teamid = 'GER';

/* 6.4 Use the same JOIN as in the previous question.
Show the team1, team2 and player for every goal scored by a player called Mario player LIKE 'Mario%'. */

SELECT game.team1,game.team2,goal.player FROM game
    JOIN goal
    ON 
    game.id = goal.matchid
    WHERE player LIKE 'Mario%';

/* 6.5 The table eteam gives details of every national team including the coach. You can JOIN goal to eteam using the phrase goal JOIN eteam on teamid=id
Show player, teamid, coach, gtime for all goals scored in the first 10 minutes gtime<=10. */


SELECT player, teamid, coach, gtime FROM goal 
    JOIN eteam
    ON 
    teamid=id
    WHERE gtime<=10;

/* 6.6 To JOIN game with eteam you could use either game JOIN eteam ON (team1=eteam.id) or game JOIN eteam ON (team2=eteam.id).
Notice that because id is a column name in both game and eteam you must specify eteam.id instead of just id.
List the the dates of the matches and the name of the team in which 'Fernando Santos' was the team1 coach. */

SELECT game.mdate, eteam.teamname FROM game 
    JOIN eteam
    ON 
    game.team1=eteam.id
    WHERE coach = 'Fernando Santos';

/* 6.7 List the player for every goal scored in a game where the stadium was 'National Stadium, Warsaw'. */

SELECT goal.player FROM game 
    JOIN goal
    ON goal.matchid = game.id
    WHERE stadium = 'National Stadium, Warsaw';

/* 6.8 The example query shows all goals scored in the Germany-Greece quarterfinal.
Instead show the name of all players who scored a goal against Germany. */

SELECT DISTINCT player FROM game 
    JOIN goal 
    ON 
    matchid = id 
    WHERE (team1='GER' OR team2='GER') AND teamid != 'GER';

/* 6.9 Show teamname and the total number of goals scored. COUNT and GROUP BY. */

SELECT teamname, COUNT(*) FROM eteam 
    JOIN goal 
    ON 
    id=teamid GROUP BY teamname;

/* 6.10 Show the stadium and the number of goals scored in each stadium. */

SELECT stadium, COUNT(*) FROM goal 
    JOIN game 
    ON 
    matchid = id GROUP BY stadium;

/* 6.11 For every match involving 'POL', show the matchid, date and the number of goals scored. */

SELECT matchid, mdate, COUNT(*) FROM game 
    JOIN goal 
    ON 
    matchid=id
    WHERE (team1='POL' OR team2='POL') GROUP BY matchid, mdate;

/* 6.12 For every match where 'GER' scored, show matchid, match date and the number of goals scored by 'GER'. */

SELECT matchid, mdate, COUNT(*) FROM game 
    JOIN goal 
    ON 
    id=matchid
    WHERE teamid='GER'GROUP BY matchid, mdate;

/* 6.13 List every match with the goals scored by each team as shown.
This will use "CASE WHEN" which has not been explained in any previous exercises. */

SELECT mdate, team1,
    SUM(CASE WHEN teamid=team1 THEN 1 ELSE 0 END) score1,team2,
    SUM(CASE WHEN teamid=team2 THEN 1 ELSE 0 END) score2 FROM game 
    LEFT JOIN goal 
    ON 
    matchid=id GROUP BY mdate, matchid, team1, team2;
