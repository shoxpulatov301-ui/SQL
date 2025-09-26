🟢 Oson vazifalar
1️⃣ 100-Steven King ko‘rinishida chiqarish
SELECT CAST(EMPLOYEE_ID AS VARCHAR) + '-' + FIRST_NAME + ' ' + LAST_NAME AS EMP_INFO
FROM Employees
WHERE EMPLOYEE_ID = 100;

2️⃣ Telefon raqamidagi 124 → 999 almashtirish
UPDATE Employees
SET PHONE_NUMBER = REPLACE(PHONE_NUMBER, '124', '999');

3️⃣ Ismi A, J, M bilan boshlanadiganlar
SELECT FIRST_NAME, LEN(FIRST_NAME) AS Name_Length
FROM Employees
WHERE FIRST_NAME LIKE 'A%' OR FIRST_NAME LIKE 'J%' OR FIRST_NAME LIKE 'M%'
ORDER BY FIRST_NAME;

4️⃣ Har bir menejer uchun umumiy ish haqi
SELECT MANAGER_ID, SUM(SALARY) AS Total_Salary
FROM Employees
WHERE MANAGER_ID IS NOT NULL
GROUP BY MANAGER_ID;

5️⃣ TestMax jadvalidan eng katta qiymat va yil
SELECT Id,
       GREATEST(Max1, Max2, Max3) AS MaxValue,
       CASE 
         WHEN Max1 = GREATEST(Max1, Max2, Max3) THEN 'Max1'
         WHEN Max2 = GREATEST(Max1, Max2, Max3) THEN 'Max2'
         ELSE 'Max3'
       END AS MaxYear
FROM TestMax;

6️⃣ Toq ID va tavsifi zerikarli bo‘lmagan filmlar
SELECT *
FROM Kino
WHERE Id % 2 = 1
  AND Description NOT LIKE '%zerikarli%';

7️⃣ Id bo‘yicha saralash, 0 oxirida chiqishi kerak
SELECT *
FROM SingleOrder
ORDER BY CASE WHEN Id = 0 THEN 1 ELSE 0 END, Id;

8️⃣ Ustunlar to‘plamidan birinchi nol bo‘lmagan qiymatni olish
SELECT COALESCE(NULLIF(Col1,0), NULLIF(Col2,0), NULLIF(Col3,0)) AS FirstNonZero
FROM Shaxs;

🟡 O‘rta vazifalar
9️⃣ To‘liq ismni bo‘lish (Ismi, otasining ismi, familiyasi)
SELECT 
  PARSENAME(REPLACE(FullName, ' ', '.'), 3) AS FirstName,
  PARSENAME(REPLACE(FullName, ' ', '.'), 2) AS FatherName,
  PARSENAME(REPLACE(FullName, ' ', '.'), 1) AS LastName
FROM Talabalar;

🔟 Kaliforniya va Texas buyurtmalarini taqqoslash
SELECT c.CustomerID, c.CustomerName, o.OrderID, o.State
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
WHERE o.State IN ('California', 'Texas');

11️⃣ Qiymatlarni birlashtirish (DMLTable)
SELECT Col1 + ' ' + Col2 + ' ' + Col3 AS CombinedValue
FROM DMLTable;

12️⃣ Ismida kamida 3 ta a bo‘lganlar
SELECT *
FROM Employees
WHERE (LEN(FIRST_NAME + LAST_NAME) - LEN(REPLACE(FIRST_NAME + LAST_NAME, 'a', ''))) >= 3;

13️⃣ Har bir bo‘limdagi xodimlar soni va 3 yildan ortiq ishlaganlar ulushi
SELECT DEPARTMENT_ID,
       COUNT(*) AS TotalEmployees,
       SUM(CASE WHEN DATEDIFF(YEAR, HIRE_DATE, GETDATE()) > 3 THEN 1 ELSE 0 END) AS MoreThan3Years,
       CAST(SUM(CASE WHEN DATEDIFF(YEAR, HIRE_DATE, GETDATE()) > 3 THEN 1 ELSE 0 END) * 1.0 / COUNT(*) AS DECIMAL(5,2)) AS ShareMoreThan3Years
FROM Employees
GROUP BY DEPARTMENT_ID;

🔴 Qiyin vazifalar
14️⃣ "tf56sd#%OqH" qatorini ajratish
WITH Chars AS (
    SELECT value AS ch
    FROM STRING_SPLIT('tf56sd#%OqH', '')
    WHERE value <> ''
)
SELECT 
    STRING_AGG(CASE WHEN ch LIKE '[A-Z]' THEN ch END, '') AS Uppercase,
    STRING_AGG(CASE WHEN ch LIKE '[a-z]' THEN ch END, '') AS Lowercase,
    STRING_AGG(CASE WHEN ch LIKE '[0-9]' THEN ch END, '') AS Digits,
    STRING_AGG(CASE WHEN ch NOT LIKE '[A-Za-z0-9]' THEN ch END, '') AS Others
FROM Chars;

15️⃣ Oldingi satrlar yig‘indisi bilan almashtirish
SELECT Id, 
       SUM(Value) OVER (ORDER BY Id ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS CumulativeSum
FROM Talabalar;

16️⃣ VARCHAR ustunidagi tenglamalarni yechish

(Misol: '2+3*4')

SELECT Id, Expression, 
       CAST(EVAL(Expression) AS INT) AS Result
FROM Tenglamalar;


(SQL Server’da EVAL yo‘q, buni CLR function yoki Dynamic SQL orqali bajarish mumkin.)

17️⃣ Tug‘ilgan kuni bir xil talabalar
SELECT t1.StudentID, t1.FullName, t1.BirthDate
FROM Talabalar t1
JOIN Talabalar t2 
  ON t1.StudentID <> t2.StudentID
 AND t1.BirthDate = t2.BirthDate;

18️⃣ O‘yinchilar juftligi bo‘yicha umumiy ball
SELECT 
   CASE WHEN PlayerA < PlayerB THEN PlayerA ELSE PlayerB END AS Player1,
   CASE WHEN PlayerA < PlayerB THEN PlayerB ELSE PlayerA END AS Player2,
   SUM(Score) AS TotalScore
FROM PlayerScores
GROUP BY 
   CASE WHEN PlayerA < PlayerB THEN PlayerA ELSE PlayerB END,
   CASE WHEN PlayerA < PlayerB THEN PlayerB ELSE PlayerA END;
