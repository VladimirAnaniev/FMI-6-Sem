--- 1
--- Без повторение заглавията и годините на всички филми, заснети преди 1982, в които е играл
--- поне един актьор (актриса), чието име не съдържа нито буквата 'k', нито 'b'. Първо да се изведат
--- най-старите филми.
SELECT DISTINCT m.title, m.year
FROM movie m
JOIN starsin sin on sin.movietitle = m.title
WHERE m.year < 1982
AND sin.starname NOT LIKE '%k%' 
AND sin.starname NOT LIKE '%b%'
ORDER BY m.year;

--- 2
--- Заглавията и дължините в часове (length е в минути) на всички филми, които са от същата
--- година, от която е и филмът Terms of Endearment, но дължината им е по-малка или неизвестна.
SELECT title, length / 60 as length, year
FROM movie
WHERE year = (SELECT year FROM movie WHERE title = 'Terms of Endearment')
AND (length < (SELECT length FROM movie WHERE title = 'Terms of Endearment') OR length IS NULL);

--- 3
--- Имената на всички продуценти, които са и филмови звезди и са играли в поне един филм
--- преди 1980 г. и поне един след 1985 г.
SELECT name
FROM movieexec
WHERE name IN (
  SELECT sin.starname
  FROM starsin sin
  JOIN movie on sin.movietitle = movie.title
  WHERE movie.year < 1980)
AND name IN (
  SELECT sin.starname
  FROM starsin sin
  JOIN movie on sin.movietitle = movie.title
  WHERE movie.year > 1985);

--- 4
--- Всички черно-бели филми, записани преди най-стария цветен филм (InColor='y'/'n') на същото студио
SELECT * 
FROM movie
WHERE incolor = 'n'
AND year < (
  SELECT MIN(m2.year)
  FROM movie m2
  WHERE m2.incolor = 'y'
  AND m2.studioname = studioname
);

--- 5
--- Имената и адресите на студиата, които са работили с по-малко от 5 различни филмови звезди.
--- Студиа, за които няма посочени филми или има, но не се знае кои актьори са играли в тях, също
--- да бъдат изведени. Първо да се изведат студиата, работили с най-много звезди. 
SELECT s.name, s.address
FROM studio s
LEFT JOIN movie m on m.studioname = s.name
LEFT JOIN starsin sin on m.title = sin.movietitle
GROUP BY s.name, s.address
HAVING COUNT(DISTINCT sin.starname) < 5
ORDER BY COUNT(DISTINCT sin.starname) DESC






