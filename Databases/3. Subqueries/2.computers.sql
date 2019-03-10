----- 2.1 -----
----- Напишете заявка, която извежда производителите на персонални компютри с
----- честота поне 500
SELECT DISTINCT maker 
FROM product
WHERE model IN (
  SELECT model 
  FROM pc
  WHERE speed >= 500
);

----- 2.2 -----
----- Напишете заявка, която извежда принтерите с най-висока цена. 
SELECT * 
FROM printer
WHERE price >= ALL(
  SELECT price
  FROM printer
);

----- 2.3 -----
----- Напишете заявка, която извежда лаптопите, чиято честота е по-ниска от
----- честотата на който и да е персонален компютър.  
SELECT *
FROM laptop
WHERE speed < ALL(
  SELECT speed
  FROM pc
);

----- 2.4 -----
----- Напишете заявка, която извежда модела на продукта (PC, лап топ или принтер) с
----- най-висока цена.
SELECT model
FROM (
  (SELECT price, model FROM laptop)
  UNION
  (SELECT price, model FROM pc)
  UNION
  (SELECT price, model FROM printer)
) allprod
WHERE price >= ALL(
  (SELECT price FROM laptop)
  UNION
  (SELECT price FROM pc)
  UNION
  (SELECT price FROM printer)
);

----- 2.5 -----
----- Напишете заявка, която извежда производителя на цветния принтер с най-ниска цена. 
SELECT maker 
FROM product
WHERE model = (
  SELECT model 
  FROM printer
  WHERE color = 'y' AND price <= ALL(
    SELECT price 
    FROM printer
    WHERE color = 'y'
  )
);

----- 2.6 -----
----- Напишете заявка, която извежда производителите на тези персонални компютри
----- с най-малко RAM памет, които имат най-бързи процесори.  
SELECT DISTINCT maker 
FROM product p
JOIN pc on pc.model = p.model
WHERE ram <= ALL(
  SELECT ram
  FROM pc
  WHERE speed >= ALL(
    SELECT speed
    FROM pc
  )
);

----- 2.6 -----
----- Напишете заявка, която извежда производителите на тези персонални компютри
----- с най-малко RAM памет, които имат най-бързи процесори.  
SELECT DISTINCT maker 
FROM product p
JOIN pc on pc.model = p.model
WHERE speed >= ALL(
  SELECT speed
  FROM pc
  WHERE ram <= ALL(
    SELECT ram
    FROM pc
  )
) AND ram <= ALL(
  SELECT ram
  FROM pc
);

