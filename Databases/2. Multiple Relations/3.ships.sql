----- 3.1 -----
----- Напишете заявка, която извежда името на корабите, по-тежки (displacement) от 35000
SELECT DISTINCT name FROM ships s
JOIN classes c ON c.class = s.class
WHERE c.displacement > 35000;

----- 3.2 -----
----- Напишете заявка, която извежда имената, водоизместимостта и броя оръдия на
----- всички кораби, участвали в битката при ‘Guadalcanal’
SELECT name, displacement, numguns FROM ships s
JOIN classes c ON c.class = s.class
JOIN outcomes o on o.ship = s.name
WHERE o.battle = 'Guadalcanal';

----- 3.3 -----
----- Напишете заявка, която извежда имената на тези държави, които имат класове
----- кораби от тип ‘bb’ и ‘bc’ едновременно
(
  SELECT country FROM classes
  WHERE type = 'bb'
)
INTERSECT
(
  SELECT country FROM classes
  WHERE type = 'bc'
);

----- 3.4 -----
----- Напишете заявка, която извежда имената на тези кораби, които са били
----- повредени в една битка, но по-късно са участвали в друга битка
SELECT DISTINCT o1.ship
FROM outcomes o1 
JOIN battles b1 ON o1.battle = b1.name
JOIN outcomes o2 ON o1.ship = o2.ship
JOIN battles b2 ON o2.battle = b2.name
WHERE o1.result = 'damaged' AND b1.date < b2.date;
