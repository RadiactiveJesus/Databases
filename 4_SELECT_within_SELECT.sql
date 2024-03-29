
/* 4. SELECT within SELECT Tutorial */

/* 4.1 List each country name where the population is larger than that of 'Russia'. */

SELECT name FROM world
  WHERE population >
    (SELECT population FROM world WHERE name = 'Russia');

/* 4.2 Show the countries in Europe with a per capita GDP greater than 'United Kingdom'. */

SELECT name FROM world
  WHERE continent = 'Europe' AND gdp/population >
     (SELECT gdp/population FROM world WHERE name = 'United Kingdom');

/* 4.3 List the name and continent of countries in the continents containing either Argentina or Australia. Order by name of the country. */

SELECT name, continent FROM world
  WHERE continent = 
    (SELECT continent FROM world WHERE name = 'Argentina')
  OR 
  continent = 
    (SELECT continent FROM world WHERE name = 'Australia') ORDER BY name;

/* 4.4 Which country has a population that is more than Canada but less than Poland? Show the name and the population. */

SELECT name, population FROM world
  WHERE population > 
    (SELECT population FROM world WHERE name = 'Canada')
  AND 
    population < 
      (SELECT population FROM world WHERE name = 'Poland');

/* 4.5 Germany (population 80 million) has the largest population of the countries in Europe. 
Austria (population 8.5 million) has 11% of the population of Germany.
Show the name and the population of each country in Europe. Show the population as a percentage of the population of Germany. */ 

SELECT name, CONCAT(ROUND(100*population/(SELECT population FROM world WHERE name = 'Germany')), '%') FROM world
  WHERE continent = 'Europe';

/* 4.6 Which countries have a GDP greater than every country in Europe? [Give the name only.] (Some countries may have NULL gdp values). */

SELECT name FROM world 
  WHERE gdp > ALL
    (SELECT gdp FROM world  WHERE continent = 'Europe' AND gdp > 0);

/* 4.7 Find the largest country (by area) in each continent, show the continent, the name and the area. */

SELECT continent, name, area FROM world x
  WHERE area >= ALL
    (SELECT area FROM world y WHERE y.continent=x.continent AND area>0);

/* 4.8 List each continent and the name of the country that comes first alphabetically. */

SELECT continent, MIN(name) AS name  FROM world 
  GROUP BY continent ORDER by continent;

/* 4.9 Find the continents where all countries have a population <= 25000000.
Then find the names of the countries associated with these continents. Show name, continent and population. */

SELECT x.name, x.continent, x.population FROM world AS x
  WHERE (x.continent NOT IN 
    (SELECT y.continent FROM world y WHERE (y.population > 25000000) GROUP BY y.continent));

/* 4.10 Some countries have populations more than three times that of any of their neighbours (in the same continent). Give the countries and continents. */

SELECT x.name, x.continent FROM world x
  WHERE (x.population > ALL 
    (SELECT (y.population * 3) FROM world y WHERE (y.population > 0) AND (y.continent = x.continent) AND (y.name != x.name)));