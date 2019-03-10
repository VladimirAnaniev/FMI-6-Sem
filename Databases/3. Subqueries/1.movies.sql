----- 1.1 -----
----- Напишете заявка, която извежда имената на актрисите, които са също и
----- продуценти с нетна стойност по-голяма от 10 милиона. 
SELECT name 
FROM moviestar
WHERE gender = 'f' 
  AND name IN (
    SELECT name 
    FROM movieexec 
    WHERE networth > 10000
  );

----- 1.2 -----
----- Напишете заявка, която извежда имената на тези актьори (мъже и жени), които
----- не са продуценти.  
SELECT name 
FROM moviestar
WHERE name NOT IN (
  SELECT name 
  FROM movieexec
);

----- 1.3 -----
----- Напишете заявка, която извежда имената на всички филми с дължина по-голяма
----- от дължината на филма ‘Gone With the Wind’  
SELECT title 
FROM movie
WHERE length > (
  SELECT length 
  FROM movie
  WHERE title = 'Gone With the Wind'
);

----- 1.4 -----
----- Напишете заявка, която извежда имената на продуцентите и имената на
----- продукциите за които стойността им е по-голяма от продукциите на продуценти
----- ‘Mery Griffin’
SELECT me.name, m.title 
FROM movieexec me
JOIN movie m ON m.producerc# = me.cert# 
WHERE me.networth > ALL(
  SELECT networth 
  FROM movieexec
  WHERE name = 'Mery Griffin'
);

