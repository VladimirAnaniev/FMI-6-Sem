----- 2.1 -----
----- Напишете заявка, която извежда производителя и честотата на процесора на тези
----- лаптопи с размер на диска поне 9 GB
SELECT p.maker, l.speed FROM laptop l
JOIN product p ON p.model = l.model 
WHERE l.hd >= 9;

----- 2.2 -----
----- Напишете заявка, която извежда номер на модел и цена на всички продукти,
----- произведени от производител с име ‘B’. Сортирайте резултата така, че първо да
----- се изведат най-скъпите продукти
(
  SELECT p.model, l.price
  FROM product p
  JOIN laptop l ON p.model = l.model
  WHERE p.maker = 'B'
) 
UNION 
(
  SELECT p.model, pc.price
  FROM product p
  JOIN pc ON p.model = pc.model
  WHERE p.maker = 'B'
)
UNION
(
  SELECT p.model, pr.price
  FROM product p
  JOIN printer pr ON p.model = pr.model
  WHERE p.maker = 'B'
)
ORDER BY price DESC;

----- 2.3 -----
----- Напишете заявка, която извежда размерите на тези дискове, които се предлагат в
----- поне два компютъра
SELECT DISTINCT pc1.hd FROM pc pc1
WHERE (SELECT COUNT(pc2.hd) FROM pc pc2 WHERE pc1.hd = pc2.hd) >= 2;

----- 2.4 -----
----- Напишете заявка, която извежда всички двойки модели на компютри, които имат
----- еднаква честота и памет. Двойките трябва да се показват само по веднъж,
----- например само (i, j), но не и (j, i)
SELECT DISTINCT pc1.model, pc2.model FROM pc pc1
JOIN pc pc2 ON pc1.speed = pc2.speed AND pc1.ram = pc2.ram
WHERE pc1.model < pc2.model;

----- 2.5 -----
----- Напишете заявка, която извежда производителите на поне два различни
----- компютъра с честота на процесора поне 1000 MHz.
----- Реш: ми няма такива :Д
