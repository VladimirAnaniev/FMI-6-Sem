----- 1.1 -----
----- Напишете заявка, която извежда имената на актьорите мъже, участвали в ‘Terms of Endearment’
SELECT name FROM moviestar 
JOIN starsin ON starname = name
WHERE gender = 'm' AND movietitle = 'Terms of Endearment';

----- 1.2 -----
----- Напишете заявка, която извежда имената на актьорите, участвали във филми,
----- продуцирани от ‘MGM’ през 1995 г.
SELECT starname FROM starsin 
JOIN movie ON movietitle = title
WHERE year = 1995 AND studioname = 'MGM';

----- 1.3 -----
----- Напишете заявка, която извежда името на президента на ‘MGM’
SELECT DISTINCT name FROM movieexec 
JOIN movie ON producerc# = cert#
WHERE studioname = 'MGM';

----- 1.4 -----
----- Напишете заявка, която извежда имената на всички филми с дължина, по-голяма
----- от дължината на филма ‘Star Wars’
SELECT title FROM movie 
WHERE length > (SELECT length FROM movie WHERE title = 'Star Wars');
