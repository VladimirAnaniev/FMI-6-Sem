--- 6
--- За всеки кораб, който е от клас с име, несъдържащо буквите i и k, да се изведе името
--- на кораба и през коя година е пуснат на вода (launched). Резултатът да бъде сортиран
--- така, че първо да се извеждат най-скоро пуснатите кораби.
SELECT name, launched
FROM ships 
WHERE class NOT LIKE '%i%' AND class NOT LIKE '%k%'
ORDER BY launched DESC;

--- 7
--- Да се изведат имената на всички битки, в които е повреден (damaged) поне един
--- японски кораб.
SELECT DISTINCT o.battle
FROM outcomes o
JOIN ships s ON o.ship = s.name
JOIN classes c ON c.class = s.class
WHERE o.result = 'damaged' AND c.country = 'Japan';

--- 8
--- Да се изведат имената и класовете на всички кораби, пуснати на вода една година след
--- кораба 'Rodney' и броят на оръдията им е по-голям от средния брой оръдия на
--- класовете, произвеждани от тяхната страна
SELECT s.name, s.class
FROM ships s
JOIN classes c on s.class = c.class
WHERE s.launched = (SELECT launched + 1 FROM ships WHERE name = 'Rodney')
AND c.numguns > (SELECT AVG(numguns) FROM classes WHERE country = c.country);

--- 9
--- Да се изведат американските класове, за които всички техни кораби са пуснати на вода
--- в рамките на поне 10 години (например кораби от клас North Carolina са пускани в
--- периода от 1911 до 1941, което е повече от 10 години, докато кораби от клас Tennessee
--- са пуснати само през 1920 и 1921 г.).
SELECT c.class
FROM classes c
JOIN ships s ON s.class = c.class
WHERE c.country = 'USA'
GROUP BY c.class
HAVING MAX(s.launched) - MIN(s.launched) >= 10;

--- 10
--- За всяка битка да се изведе средният брой кораби от една и съща държава (например в
--- битката при Guadalcanal са участвали 3 американски и един японски кораб, т.е.
--- средният брой е 2).
SELECT b.battle, AVG(b.count)
FROM (
  SELECT o.battle, COUNT(s.name) as count
  FROM outcomes o
  JOIN ships s ON s.name = o.ship
  JOIN classes c ON c.class = s.class
  GROUP BY o.battle, c.country) b
GROUP BY b.battle;

--- 11
--- За всяка държава да се изведе: броят на корабите от тази държава; броя на битките, в
--- които е участвала; броя на битките, в които неин кораб е потънал ('sunk') (ако някоя от
--- бройките е 0 – да се извежда 0).
SELECT c.country, 
       COUNT(DISTINCT s.name) as shipscount, 
       COUNT(DISTINCT o.battle) as battlescount, 
       COUNT(DISTINCT o2.battle) as sunkcount
FROM classes c
LEFT JOIN ships s ON s.class = c.class
LEFT JOIN outcomes o ON o.ship = s.name
LEFT JOIN outcomes o2 ON o2.ship = s.name AND o2.result = 'sunk'
GROUP BY c.country;

--- 16
--- Изведете броя на потъналите американски кораби за всяка проведена битка с поне един
--- потънал американски кораб.
SELECT o.battle, COUNT(s.name) as sunkcount
FROM outcomes o
JOIN ships s ON s.name = o.ship
JOIN classes c ON c.class = s.class
WHERE c.country = 'USA'
AND o.result = 'sunk'
GROUP BY o.battle;

--- 17
--- Битките, в които са участвали поне 3 кораба на една и съща страна.
SELECT DISTINCT o.battle
FROM outcomes o
JOIN ships s ON s.name = o.ship
JOIN classes c ON c.class = s.class
GROUP BY o.battle, c.country
HAVING COUNT(s.name) >= 3;


