🔵 1-qism: Mahsulotlarni sotish (Sales) jadvali

📌 Jadvalni yaratish:

CREATE TABLE MahsulotSotish (
    SaleID INT PRIMARY KEY,
    MahsulotNomi VARCHAR(50) NOT NULL,
    SaleDate DATE NOT NULL,
    SaleAmount DECIMAL(10,2) NOT NULL,
    Miqdor INT NOT NULL,
    CustomerID INT NOT NULL
);


📌 Endi topshiriqlar:

1️⃣ Har bir sotuvga qator raqami (SaleDate asosida)
SELECT 
    SaleID,
    MahsulotNomi,
    SaleDate,
    SaleAmount,
    ROW_NUMBER() OVER (ORDER BY SaleDate) AS RowNum
FROM MahsulotSotish;

2️⃣ Umumiy sotilgan miqdor bo‘yicha tartiblash (DENSE_RANK)
SELECT 
    MahsulotNomi,
    SUM(Miqdor) AS JamiMiqdor,
    DENSE_RANK() OVER (ORDER BY SUM(Miqdor) DESC) AS RankMiqdor
FROM MahsulotSotish
GROUP BY MahsulotNomi;

3️⃣ Umumiy sotilgan summaga ko‘ra tartiblash (rank)
SELECT 
    MahsulotNomi,
    SUM(SaleAmount) AS JamiSumma,
    DENSE_RANK() OVER (ORDER BY SUM(SaleAmount) DESC) AS RankSumma
FROM MahsulotSotish
GROUP BY MahsulotNomi;

4️⃣ Har bir mijoz uchun eng katta sotuv
SELECT *
FROM (
    SELECT 
        CustomerID,
        SaleID,
        SaleAmount,
        RANK() OVER (PARTITION BY CustomerID ORDER BY SaleAmount DESC) AS rnk
    FROM MahsulotSotish
) t
WHERE rnk = 1;

5️⃣ SaleDate tartibida keyingi sotuv summasi (LEAD)
SELECT 
    SaleID,
    SaleDate,
    SaleAmount,
    LEAD(SaleAmount) OVER (ORDER BY SaleDate) AS NextSale
FROM MahsulotSotish;

6️⃣ SaleDate tartibida oldingi sotuv summasi (LAG)
SELECT 
    SaleID,
    SaleDate,
    SaleAmount,
    LAG(SaleAmount) OVER (ORDER BY SaleDate) AS PrevSale
FROM MahsulotSotish;

7️⃣ Har bir mahsulot ichida sotuv miqdorini tartiblash
SELECT 
    MahsulotNomi,
    SaleID,
    Miqdor,
    ROW_NUMBER() OVER (PARTITION BY MahsulotNomi ORDER BY Miqdor DESC) AS rn
FROM MahsulotSotish;

8️⃣ Oldingi sotuvdan kattaroq bo‘lgan sotuv summalari
SELECT *
FROM (
    SELECT 
        SaleID,
        SaleAmount,
        LAG(SaleAmount) OVER (ORDER BY SaleDate) AS PrevAmount
    FROM MahsulotSotish
) t
WHERE SaleAmount > PrevAmount;

9️⃣ Har bir mahsulot bo‘yicha oldingi sotuvdan farq
SELECT 
    MahsulotNomi,
    SaleID,
    SaleAmount,
    SaleAmount - LAG(SaleAmount) OVER (PARTITION BY MahsulotNomi ORDER BY SaleDate) AS DiffPrev
FROM MahsulotSotish;

🔟 Keyingi sotuv miqdoriga nisbatan foiz o‘zgarish
SELECT 
    SaleID,
    Miqdor,
    LEAD(Miqdor) OVER (ORDER BY SaleDate) AS NextQty,
    ( (LEAD(Miqdor) OVER (ORDER BY SaleDate) - Miqdor) * 100.0 / Miqdor ) AS PercentChange
FROM MahsulotSotish;

11️⃣ Mahsulot ichida joriy summaning oldingi summaga nisbatini hisoblash
SELECT 
    MahsulotNomi,
    SaleID,
    SaleAmount,
    CAST(SaleAmount AS DECIMAL(10,2)) / 
    NULLIF(LAG(SaleAmount) OVER (PARTITION BY MahsulotNomi ORDER BY SaleDate),0) AS RatioPrev
FROM MahsulotSotish;

12️⃣ Birinchi sotuvdan keyingi farq
SELECT 
    MahsulotNomi,
    SaleID,
    SaleAmount,
    SaleAmount - FIRST_VALUE(SaleAmount) OVER (PARTITION BY MahsulotNomi ORDER BY SaleDate) AS DiffFirst
FROM MahsulotSotish;

13️⃣ Doimiy oshib borayotgan sotuvlarni topish
SELECT *
FROM (
    SELECT 
        SaleID,
        MahsulotNomi,
        SaleAmount,
        LAG(SaleAmount) OVER (PARTITION BY MahsulotNomi ORDER BY SaleDate) AS PrevAmt
    FROM MahsulotSotish
) t
WHERE SaleAmount > PrevAmt;

14️⃣ Yuguruvchi jami (running total)
SELECT 
    SaleID,
    MahsulotNomi,
    SaleDate,
    SaleAmount,
    SUM(SaleAmount) OVER (PARTITION BY MahsulotNomi ORDER BY SaleDate ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS RunningTotal
FROM MahsulotSotish;

15️⃣ Oxirgi 3 ta sotuvning harakatlanuvchi o‘rtacha qiymati
SELECT 
    SaleID,
    MahsulotNomi,
    SaleAmount,
    AVG(SaleAmount) OVER (ORDER BY SaleDate ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS MovingAvg3
FROM MahsulotSotish;

16️⃣ Sotuv summasi va o‘rtacha summasi o‘rtasidagi farq
SELECT 
    SaleID,
    SaleAmount,
    SaleAmount - AVG(SaleAmount) OVER () AS DiffFromAvg
FROM MahsulotSotish;

🔵 2-qism: Xodimlar jadvali

📌 Jadval:

CREATE TABLE Xodimlar1 (
    XodimID INT PRIMARY KEY,
    Ism VARCHAR(50),
    Bolim VARCHAR(50),
    IshHaqi DECIMAL(10,2),
    IshgaOlishSanasi DATE
);


📌 Topshiriqlar:

1️⃣ Bir xil ish haqi oladigan xodimlar
SELECT IshHaqi, COUNT(*) AS XodimSoni
FROM Xodimlar1
GROUP BY IshHaqi
HAVING COUNT(*) > 1;

2️⃣ Har bir bo‘limda eng yuqori 2 ish haqi
SELECT *
FROM (
    SELECT *,
           DENSE_RANK() OVER (PARTITION BY Bolim ORDER BY IshHaqi DESC) AS rnk
    FROM Xodimlar1
) t
WHERE rnk <= 2;

3️⃣ Har bir bo‘limda eng kam maosh oluvchi
SELECT *
FROM (
    SELECT *,
           RANK() OVER (PARTITION BY Bolim ORDER BY IshHaqi ASC) AS rnk
    FROM Xodimlar1
) t
WHERE rnk = 1;

4️⃣ Har bir bo‘limda jami ish haqi
SELECT Bolim, SUM(IshHaqi) AS JamiIshHaqi
FROM Xodimlar1
GROUP BY Bolim;

5️⃣ GROUP BY ishlatmasdan jami ish haqi
SELECT DISTINCT
    Bolim,
    SUM(IshHaqi) OVER (PARTITION BY Bolim) AS JamiIshHaqi
FROM Xodimlar1;

6️⃣ Har bir bo‘limda o‘rtacha ish haqi (GROUP BY bilan)
SELECT Bolim, AVG(IshHaqi) AS O‘rtachaMaosh
FROM Xodimlar1
GROUP BY Bolim;

7️⃣ Xodim ish haqi va bo‘lim o‘rtachasi farqi
SELECT 
    Ism,
    Bolim,
    IshHaqi,
    IshHaqi - AVG(IshHaqi) OVER (PARTITION BY Bolim) AS DiffFromAvg
FROM Xodimlar1;

8️⃣ Har bir xodim uchun (oldingi, joriy, keyingi) ish haqi o‘rtachasi
SELECT 
    XodimID,
    Ism,
    IshHaqi,
    AVG(IshHaqi) OVER (ORDER BY XodimID ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS MovingAvg
FROM Xodimlar1;

9️⃣ Ishga qabul qilingan oxirgi 3 xodimning jami ish haqi
SELECT SUM(IshHaqi) AS Last3Total
FROM (
    SELECT TOP 3 IshHaqi
    FROM Xodimlar1
    ORDER BY IshgaOlishSanasi DESC
) t;
