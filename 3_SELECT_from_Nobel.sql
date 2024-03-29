/* 3. SELECT from Nobel Tutorial */

/* 3.1 Winners from 1950. Change the query shown so that it displays Nobel prizes for 1950. */

SELECT yr, subject, winner  FROM nobel
    WHERE yr = 1950;

/* 3.2 1962 Literature. Show who won the 1962 prize for Literature. */

SELECT winner FROM nobel
    WHERE yr = 1962 AND subject = 'Literature';

/* 3.3 Albert Einstein. Show the year and subject that won 'Albert Einstein' his prize. */

SELECT yr, subject FROM nobel
    WHERE winner = 'Albert Einstein';

/* 3.4 Recent Peace Prizes. Give the name of the 'Peace' winners since the year 2000, including 2000. */

SELECT winner FROM nobel
    WHERE yr >= 2000 AND subject = 'Peace';

/* 3.5 Literature in the 1980's. Show all details (yr, subject, winner) of the Literature prize winners for 1980 to 1989 inclusive. */

SELECT yr, subject, winner FROM nobel
    WHERE yr BETWEEN 1980 AND 1989 AND subject = 'Literature';

/* 3.6 Only Presidents. Show all details of the presidential winners: Theodore Roosevelt, Woodrow Wilson, Jimmy Carter, Barack Obama. */

SELECT yr, subject, winner FROM nobel
    WHERE winner IN ('Theodore Roosevelt', 'Woodrow Wilson', 'Jimmy Carter', 'Barack Obama');

/* 3.7 John. Show the winners with first name John. */

SELECT winner FROM nobel
    WHERE winner LIKE 'John%';

/* 3.8 Chemistry and Physics from different years. Show the year, subject, and name of Physics winners for 1980 together with the Chemistry winners for 1984. */

SELECT yr, subject, winner FROM nobel
    WHERE subject = 'Physics' AND yr = 1980 OR subject = 'Chemistry' AND yr = 1984; 

/* 3.9 Exclude Chemists and Medics. Show the year, subject, and name of winners for 1980 excluding Chemistry and Medicine. */

SELECT * FROM nobel 
    WHERE yr = 1980 AND subject NOT IN ('Chemistry', 'Medicine');

/* 3.10 Early Medicine, Late Literature. Show year, subject, and name of people who won a 'Medicine' prize in an early year (before 1910,
not including 1910) together with winners of a 'Literature' prize in a later year (after 2004, including 2004). */

SELECT yr, subject, winner FROM nobel
    WHERE subject = 'mEDICINE' AND yr < 1910 OR subject = 'Literature' AND yr >= 2004;

/* 3.11 Harder Questions. Find all details of the prize won by PETER GRÜNBERG. */

SELECT * FROM nobel 
    WHERE winner = 'PETER GRÜNBERG';

/* 3.12 Apostrophe. Find all details of the prize won by EUGENE O'NEILL. */

SELECT * FROM nobel 
    WHERE winner = 'Eugene O''Neill';

/* 3.13 List the winners, year and subject where the winner starts with Sir. Show the the most recent first, then by name order. */

Select winner, yr, subject FROM nobel 
    WHERE winner LIKE 'Sir%' ORDER BY yr DESC, winner;

/* 3.14 Chemistry and Physics last. The expression subject IN ('Chemistry','Physics') can be used as a value - it will be 0 or 1.
Show the 1984 winners and subject ordered by subject and winner name; but list Chemistry and Physics last. */

SELECT winner, subject FROM nobel
    WHERE yr=1984 ORDER BY subject IN ('Physics','Chemistry'), subject,winner;

