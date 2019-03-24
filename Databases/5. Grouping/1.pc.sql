----- 1.1 -----
--- Напишете заявка, която извежда средната честота на компютрите
SELECT AVG(speed)
FROM pc;

----- 1.2 -----
--- Напишете заявка, която извежда средния размер на екраните на лаптопите за
--- всеки производител
SELECT p.maker, AVG(l.screen)
FROM laptop l
JOIN product p ON l.model = p.model
GROUP BY p.maker;

----- 1.3 -----
--- Напишете заявка, която извежда средната честота на лаптопите с цена над 1000
SELECT AVG(speed)
FROM laptop 
WHERE price > 1000;

----- 1.4 -----
--- Напишете заявка, която извежда средната цена на компютрите произведени от
--- производител ‘A’
SELECT AVG(pc.price)
FROM pc
JOIN product p ON p.model = pc.model
WHERE p.maker = 'A';

----- 1.5 -----
--- Напишете заявка, която извежда средната цена на компютрите и лаптопите за
--- производител ‘B’
SELECT AVG(p.price)
FROM (
  (
    SELECT l.price 
    FROM laptop l
    JOIN product p ON p.model = l.model
    WHERE p.maker = 'B'
  ) UNION (
    SELECT pc.price
    FROM pc
    JOIN product p ON pc.model = p.model
    WHERE p.maker = 'B'
  )
) as p;

----- 1.6 -----
--- Напишете заявка, която извежда средната цена на компютрите според
--- различните им честоти
SELECT speed, AVG(price)
FROM pc
GROUP BY speed;

----- 1.7 -----
--- Напишете заявка, която извежда производителите, които са произвели поне по 3
--- различни модела компютъра
SELECT p.maker
FROM product p
JOIN pc on pc.model = p.model
GROUP BY p.maker
HAVING COUNT(pc.model) > 3;

----- 1.8 -----
--- Напишете заявка, която извежда производителите на компютрите с най-висока цена
SELECT p.maker
FROM product p
JOIN pc ON p.model = pc.model
WHERE pc.price = (SELECT MAX(price) FROM pc);

----- 1.9 -----
--- Напишете заявка, която извежда средната цена на компютрите за всяка честота
--- по-голяма от 800
SELECT speed, AVG(price)
FROM pc
WHERE speed > 800
GROUP BY speed;

----- 1.10 -----
--- Напишете заявка, която извежда средния размер на диска на тези компютри
--- произведени от производители, които произвеждат и принтери
SELECT AVG(pc.hd)
FROM product p
LEFT JOIN pc ON pc.model = p.model
WHERE maker IN (
  SELECT maker 
  FROM product
  WHERE type = 'printer'
);

----- 1.11 -----
--- Напишете заявка, която за всеки размер на лаптоп намира разликата в цената на
--- най-скъпия и най-евтиния лаптоп със същия размер
SELECT screen,  MAX(price) - MIN(price)
FROM laptop
GROUP BY screen;
  
  

