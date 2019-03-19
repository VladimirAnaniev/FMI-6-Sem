----- 3.1 -----
----- Напишете заявка, която за всеки кораб извежда името му, държавата, броя
----- оръдия и годината на пускане (launched).
SELECT s.name, c.country, c.numguns, s.launched
FROM ships s
JOIN classes c ON s.class = c.class;

----- 3.3 -----
----- Напишете заявка, която извежда имената на корабите, участвали в битка от 1942
SELECT s.name
FROM ships s
JOIN outcomes o on s.name = o.ship
JOIN battles b on b.name = o.battle
WHERE YEAR(b.date) = 1942;

----- 3.4 -----
----- За всяка страна изведете имената на корабите, които никога не са участвали в
----- битка.
SELECT DISTINCT s.name
FROM classes c
JOIN ships s on s.class = c.class
LEFT JOIN outcomes o on s.name = o.ship
WHERE battle IS NULL;

