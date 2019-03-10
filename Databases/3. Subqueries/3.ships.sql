----- 3.1 -----
----- Напишете заявка, която извежда страните, чиито кораби са с най-голям брой оръжия.  
SELECT DISTINCT country
FROM classes
WHERE numguns >= ALL(
  SELECT numguns
  FROM classes
);

----- 3.2 -----
----- Напишете заявка, която извежда класовете, за които поне един от корабите им е
----- потънал в битка. 
SELECT DISTINCT class
FROM ships 
WHERE name IN (
  SELECT ship
  FROM outcomes
  WHERE result = 'sunk'
);

----- 3.3 -----
----- Напишете заявка, която извежда имената на корабите с 16 инчови оръдия (bore). 
SELECT name
FROM ships 
WHERE class IN (
  SELECT class
  FROM classes
  WHERE bore = 16
);

----- 3.4 -----
----- Напишете заявка, която извежда имената на битките, в които са участвали
----- кораби от клас ‘Kongo’
SELECT battle
FROM outcomes 
WHERE ship IN (
  SELECT name
  FROM ships
  WHERE class = 'Kongo'
);

----- 3.5 -----
----- Напишете заявка, която извежда иманата на корабите, чиито брой оръдия е найголям
----- в сравнение с корабите със същия калибър оръдия (bore). 
SELECT name
FROM ships 
WHERE class IN (
  SELECT class
  FROM classes c
  WHERE numguns >= ALL(
    SELECT numguns
    FROM classes c1
    WHERE  c1.bore = c.bore
  )
);

