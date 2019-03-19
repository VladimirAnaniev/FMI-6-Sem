----- 1.1 -----
----- Напишете заявка, която за всеки филм, по-дълъг от 120 минути, извежда
----- заглавие, година, име и адрес на студио.
SELECT title, year, address
FROM movie 
JOIN studio on name = studioname
WHERE length > 120;

----- 1.2 -----
----- Напишете заявка, която извежда името на студиото и имената на актьорите,
----- участвали във филми, произведени от това студио, подредени по име на студио.
SELECT DISTINCT studioname, starname
FROM movie
JOIN starsin on movietitle = title
ORDER BY studioname;

----- 1.3 -----
----- Напишете заявка, която извежда имената на продуцентите на филмите, в които е
----- играл Harrison Ford.
SELECT DISTINCT name
FROM movieexec
JOIN movie on producerc# = cert#
JOIN starsin on movietitle = title
WHERE starname = 'Harrison Ford';

----- 1.4 -----
----- Напишете заявка, която извежда имената на актрисите, играли във филми на MGM.
SELECT DISTINCT name
FROM moviestar
JOIN starsin on starname = name
JOIN movie on movietitle = title
WHERE studioname = 'MGM' AND gender = 'F';

----- 1.5 -----
----- Напишете заявка, която извежда името на продуцента и имената на филмите,
----- продуцирани от продуцента на ‘Star Wars’.
SELECT name, title
FROM movieexec
JOIN movie ON cert# = producerc#
WHERE cert# IN (SELECT producerc# FROM movie WHERE title = 'Star Wars');


----- 1.6 -----
----- Напишете заявка, която извежда имената на актьорите не участвали в нито един филм.
SELECT name
FROM moviestar
LEFT JOIN starsin ON starname = name
WHERE movietitle IS NULL;



