----- 1.1 Напишете заявка, която извежда адресът на студио ‘MGM’ ----- 
SELECT address FROM studio WHERE name = 'MGM';

----- 1.2 Напишете заявка, която извежда адресът на студио ‘MGM’ ----- 
SELECT birthdate FROM moviestar WHERE name = 'Sandra Bullock';

----- 1.3 Напишете заявка, която извежда имената на всички актьори, които са участвали във филм през 1980, в заглавието на които има думата ‘Empire’ -----
SELECT starname FROM starsin WHERE movieyear = 1980 AND movietitle LIKE '%Empire%';

----- 1.4 Напишете заявка, която извежда имената всички изпълнители на филми с нетна стойност над 10 000 000 долара -----
SELECT name FROM movieexec WHERE networth > 10000000;

----- 1.5 Напишете заявка, която извежда имената на всички актьори, които са мъже или живеят в Malibu -----
SELECT name FROM moviestar WHERE gender = 'M' OR address LIKE '%Malibu%';
