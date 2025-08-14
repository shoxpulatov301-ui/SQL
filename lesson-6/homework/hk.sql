Puzzle 1: Finding Distinct Values based on two columns

Ma’lumotlarga qarasak, (a,b) va (b,a) bir xil deb hisoblanadi. Buni ikki xil yo‘l bilan topish mumkin.

Usul 1 — CASE va DISTINCT bilan

SELECT DISTINCT
       CASE WHEN col1 < col2 THEN col1 ELSE col2 END AS col1,
       CASE WHEN col1 < col2 THEN col2 ELSE col1 END AS col2
FROM InputTbl;


Usul 2 — LEAST() va GREATEST() bilan (MySQL)

SELECT DISTINCT
       LEAST(col1, col2) AS col1,
       GREATEST(col1, col2) AS col2
FROM InputTbl;


Natija:

col1 | col2
-----|-----
a    | b
c    | d
m    | n

Puzzle 2: Removing rows with all zeroes

Agar barcha ustunlar 0 bo‘lsa, ularni ko‘rsatmaslik kerak.

SELECT *
FROM TestMultipleZero
WHERE NOT (A = 0 AND B = 0 AND C = 0 AND D = 0);


Yoki:

SELECT *
FROM TestMultipleZero
WHERE A <> 0 OR B <> 0 OR C <> 0 OR D <> 0;

Puzzle 3: Find those with odd ids
SELECT *
FROM section1
WHERE id % 2 = 1;

Puzzle 4: Person with the smallest id
SELECT TOP 1 *
FROM section1
ORDER BY id ASC;   -- SQL Server


MySQL versiyasi:

SELECT *
FROM section1
ORDER BY id ASC
LIMIT 1;

Puzzle 5: Person with the highest id
SELECT TOP 1 *
FROM section1
ORDER BY id DESC;  -- SQL Server


MySQL:

SELECT *
FROM section1
ORDER BY id DESC
LIMIT 1;

Puzzle 6: People whose name starts with b
SELECT *
FROM section1
WHERE name LIKE 'B%';


B% — katta “B” harfi bilan boshlanadiganlar. Agar katta-kichik farqsiz qidirish kerak bo‘lsa:

WHERE LOWER(name) LIKE 'b%';

Puzzle 7: Rows where code contains literal underscore _

Wildcard bo‘lmasligi uchun ESCAPE ishlatamiz.

SELECT *
FROM ProductCodes
WHERE Code LIKE '%\_%' ESCAPE '\';


Natija:

X_456
X_ABC
