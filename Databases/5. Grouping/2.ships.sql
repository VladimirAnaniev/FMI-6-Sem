----- 2.1 -----
--- Напишете заявка, която извежда броя на класовете кораби
SELECT COUNT(*)
FROM classes;

----- 2.2 -----
--- Напишете заявка, която извежда средния брой на оръжия за всички кораби,
--- пуснати на вода
SELECT AVG(c.numguns)
FROM classes c;
  
----- 2.3 -----
--- Напишете заявка, която извежда за всеки клас първата и последната година, в
--- която кораб от съответния клас е пуснат на вода
SELECT class, MIN(launched) AS first, MAX(launched) AS last
FROM ships
GROUP BY class;

----- 2.4 -----
--- Напишете заявка, която извежда броя на корабите потънали в битка според класа
SELECT s.class, COUNT(*)
FROM ships s
JOIN outcomes o on o.ship = s.name 
WHERE o.result = 'sunk'
GROUP BY s.class;

----- 2.5 -----
--- Напишете заявка, която извежда броя на корабите потънали в битка според
--- класа, за тези класове с повече от 4 пуснати на вода кораба
SELECT s.class, COUNT(*)
FROM ships s
JOIN outcomes o on o.ship = s.name 
WHERE o.result = 'sunk' 
AND class IN (
  SELECT class
  FROM ships
  GROUP BY class
  HAVING COUNT(*) > 4)
GROUP BY s.class;
  
----- 2.6 -----
--- Напишете заявка, която извежда средното тегло на корабите, за всяка страна. 
SELECT country, AVG(displacement)
FROM classes
GROUP BY country;
  

