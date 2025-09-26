✅ Oson vazifalar

1. Ism ustunini vergul bo‘yicha ikkita ustunga ajratish (Ism, Familiya)

SELECT 
    Id,
    LTRIM(RTRIM(LEFT(Ism, CHARINDEX(',', Ism) - 1))) AS Ism,
    LTRIM(RTRIM(SUBSTRING(Ism, CHARINDEX(',', Ism) + 1, LEN(Ism)))) AS Familiya
FROM TestMultipleColumns;


2. % belgisi mavjud bo‘lgan satrlarni topish

SELECT *
FROM TestPercent
WHERE Strs LIKE '%[%]%';


3. Satrni nuqta (.) bo‘yicha ajratish (Splitter)
(SQL Server’da STRING_SPLIT ishlatamiz)

SELECT Id, value AS Part
FROM Splitter
CROSS APPLY STRING_SPLIT(Vals, '.');


4. Nuqta (.) ikki martadan ortiq qatnashgan satrlarni qaytarish

SELECT *
FROM testDots
WHERE LEN(Vals) - LEN(REPLACE(Vals, '.', '')) > 2;


5. Satr ichidagi bo‘sh joylarni sanash

SELECT 
    matnlari,
    LEN(matnlari) - LEN(REPLACE(matnlari, ' ', '')) AS SpaceCount
FROM CountSpaces;


6. Menejeridan ko‘proq maosh oladigan xodimlarni aniqlash

SELECT e.Ismi, e.Ish_haqi, m.Ismi AS ManagerName, m.Ish_haqi AS ManagerSalary
FROM Xodim e
JOIN Xodim m ON e.ManagerId = m.Ident
WHERE e.Ish_haqi > m.Ish_haqi;


7. 10 yildan ko‘p, 15 yildan kam ishlagan xodimlar

SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, HIRE_DATE,
       DATEDIFF(YEAR, HIRE_DATE, GETDATE()) AS YearsWorked
FROM Xodimlar
WHERE DATEDIFF(YEAR, HIRE_DATE, GETDATE()) BETWEEN 10 AND 14;

✅ O‘rta vazifalar

1. Satrni raqam va harflarga ajratish

SELECT 
    Id,
    LEFT(Vals, PATINDEX('%[^0-9]%', Vals + 'a') - 1) AS Numbers,
    SUBSTRING(Vals, PATINDEX('%[^0-9]%', Vals + 'a'), LEN(Vals)) AS Letters
FROM GetIntegers
WHERE Vals IS NOT NULL;


2. Oldingi kundan yuqori haroratli sanalar

SELECT a.Ident, a.RecordDate
FROM ob_havo a
JOIN ob_havo b ON a.RecordDate = DATEADD(DAY, 1, b.RecordDate)
WHERE a.Harorat > b.Harorat;


3. Har bir o‘yinchining birinchi kirish sanasi

SELECT player_id, MIN(voqea_date) AS FirstLogin
FROM Faoliyat
GROUP BY player_id;


4. mevalar jadvalidan uchinchi elementni olish

SELECT 
    LTRIM(RTRIM(value)) AS ThirdFruit
FROM mevalar
CROSS APPLY STRING_SPLIT(meva_roʻyxati, ',')
WHERE (SELECT COUNT(*) 
       FROM STRING_SPLIT(meva_roʻyxati, ',') s2 
       WHERE s2.value <= STRING_SPLIT(meva_roʻyxati, ',').value) = 3;


(SQL Server 2016+ uchun STRING_SPLIT orderless, kerak bo‘lsa OPENJSON ishlatish mumkin.)

5. Har bir belgi satrga aylantirish

SELECT Id, SUBSTRING(Vals, n.Number, 1) AS EachChar
FROM Splitter
JOIN master..spt_values n ON n.type='P' AND n.Number BETWEEN 1 AND LEN(Vals);


6. p1 va p2 jadvallarini qo‘shish va code=0 bo‘lsa almashtirish

SELECT p1.id,
       CASE WHEN p1.code = 0 THEN p2.code ELSE p1.code END AS Code
FROM p1
JOIN p2 ON p1.id = p2.id;


7. Xodim bandlik bosqichini aniqlash

SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, HIRE_DATE,
       CASE 
         WHEN DATEDIFF(YEAR, HIRE_DATE, GETDATE()) < 1 THEN 'Yangi ishga qabul qilish'
         WHEN DATEDIFF(YEAR, HIRE_DATE, GETDATE()) BETWEEN 1 AND 4 THEN 'Junior'
         WHEN DATEDIFF(YEAR, HIRE_DATE, GETDATE()) BETWEEN 5 AND 9 THEN 'O''rta daraja'
         WHEN DATEDIFF(YEAR, HIRE_DATE, GETDATE()) BETWEEN 10 AND 19 THEN 'Katta'
         ELSE 'Veteran'
       END AS Stage
FROM Xodimlar;


8. GetIntegers jadvalidan boshidagi raqamlarni chiqarish

SELECT Id,
       LEFT(Vals, PATINDEX('%[^0-9]%', Vals + 'a') - 1) AS StartNumbers
FROM GetIntegers
WHERE Vals IS NOT NULL;

✅ Qiyin vazifalar

1. Vergul bilan ajratilgan birinchi ikki harfni almashtirish

SELECT Id,
       STUFF(Vals, 1, 1, SUBSTRING(Vals, CHARINDEX(',', Vals) + 1, 1)) AS Swapped
FROM MultipleVals;


2. Har bir o‘yinchining birinchi kirgan qurilmasi

SELECT f.player_id, f.device_id
FROM Faoliyat f
WHERE f.voqea_date = (
    SELECT MIN(voqea_date)
    FROM Faoliyat
    WHERE player_id = f.player_id
);


3. Har hafta va hudud bo‘yicha savdoni foiz hisobida chiqarish

SELECT FinancialWeek, FinancialYear, DayName,
       (SalesLocal + SalesRemote) * 100.0 / SUM(SalesLocal + SalesRemote) OVER (PARTITION BY FinancialWeek, FinancialYear) AS PercentShare
FROM WeekPercentagePuzzle
WHERE SalesLocal IS NOT NULL AND SalesRemote IS NOT NULL;
