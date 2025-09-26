🔹 Jumboq 1 – Oyni 0 bilan formatlash
SELECT 
    Id,
    Dt,
    RIGHT('0' + CAST(MONTH(Dt) AS VARCHAR(2)), 2) AS MonthPrefixedWithZero
FROM Dates;

🔹 Jumboq 2 – Distinct Ids va max summasi
SELECT 
    COUNT(DISTINCT Ident) AS Distinct_Ids,
    rID,
    SUM(MaxVals) AS TotalOfMaxVals
FROM (
    SELECT Ident, rID, MAX(Vals) AS MaxVals
    FROM MyTabel
    GROUP BY Ident, rID
) t
GROUP BY rID;

🔹 Jumboq 3 – String uzunligi 6–10 oralig‘ida
SELECT Id, Vals
FROM TestFixLengths
WHERE LEN(LTRIM(RTRIM(Vals))) BETWEEN 6 AND 10;

🔹 Jumboq 4 – Har Id bo‘yicha eng katta qiymat
SELECT t1.ID, t1.Item, t1.Vals
FROM TestMaksimum t1
JOIN (
    SELECT ID, MAX(Vals) AS MaxVal
    FROM TestMaksimum
    GROUP BY ID
) t2
ON t1.ID = t2.ID AND t1.Vals = t2.MaxVal;

🔹 Jumboq 5 – Sum of Max per group
SELECT Id, SUM(MaxVal) AS SumOfMax
FROM (
    SELECT Id, DetailedNumber, MAX(Vals) AS MaxVal
    FROM SumOfMax
    GROUP BY Id, DetailedNumber
) t
GROUP BY Id;

🔹 Jumboq 6 – Farqni hisoblash va nolni bo‘sh qilib chiqarish
SELECT 
    Id, 
    a, 
    b,
    NULLIF(a - b, 0) AS OUTPUT
FROM TheZeroPuzzle;

✅ Savdo (Sales) jadvali bo‘yicha savollar
1. Umumiy daromad
SELECT SUM(SotilganMiqdori * BirlikNarxi) AS TotalRevenue
FROM Sales;

2. O‘rtacha narx
SELECT AVG(BirlikNarxi) AS AvgUnitPrice
FROM Sales;

3. Savdo operatsiyalari soni
SELECT COUNT(*) AS TotalTransactions
FROM Sales;

4. Eng ko‘p sotilgan birlik
SELECT MAX(SotilganMiqdori) AS MaxUnitsInTransaction
FROM Sales;

5. Toifalar bo‘yicha sotuv soni
SELECT Category, SUM(SotilganMiqdori) AS TotalUnits
FROM Sales
GROUP BY Category;

6. Hududlar bo‘yicha daromad
SELECT Region, SUM(SotilganMiqdori * BirlikNarxi) AS TotalRevenue
FROM Sales
GROUP BY Region;

7. Eng katta daromad keltirgan mahsulot
SELECT TOP 1 Product, SUM(SotilganMiqdori * BirlikNarxi) AS TotalRevenue
FROM Sales
GROUP BY Product
ORDER BY TotalRevenue DESC;

8. Kun bo‘yicha daromad
SELECT SaleDate, SUM(SotilganMiqdori * BirlikNarxi) AS DailyRevenue
FROM Sales
GROUP BY SaleDate
ORDER BY SaleDate;

9. Toifalarning umumiy daromaddagi ulushi
SELECT Category, SUM(SotilganMiqdori * BirlikNarxi) AS CategoryRevenue
FROM Sales
GROUP BY Category;

✅ Customers jadvali bilan savollar
1. Sotuvlar va mijozlar ismi
SELECT s.SaleID, s.Product, s.SotilganMiqdori, s.BirlikNarxi, c.CustomerName
FROM Sales s
JOIN Customers c ON s.CustomerID = c.CustomerID;

2. Xarid qilmagan mijozlar
SELECT c.CustomerID, c.CustomerName
FROM Customers c
LEFT JOIN Sales s ON c.CustomerID = s.CustomerID
WHERE s.SaleID IS NULL;

3. Mijoz bo‘yicha umumiy daromad
SELECT c.CustomerName, SUM(s.SotilganMiqdori * s.BirlikNarxi) AS TotalRevenue
FROM Sales s
JOIN Customers c ON s.CustomerID = c.CustomerID
GROUP BY c.CustomerName;

4. Eng katta daromad keltirgan mijoz
SELECT TOP 1 c.CustomerName, SUM(s.SotilganMiqdori * s.BirlikNarxi) AS TotalRevenue
FROM Sales s
JOIN Customers c ON s.CustomerID = c.CustomerID
GROUP BY c.CustomerName
ORDER BY TotalRevenue DESC;

5. Bir mijozga o‘rtacha sotuv
SELECT AVG(CustomerRevenue) AS AvgRevenuePerCustomer
FROM (
    SELECT c.CustomerID, SUM(s.SotilganMiqdori * s.BirlikNarxi) AS CustomerRevenue
    FROM Sales s
    JOIN Customers c ON s.CustomerID = c.CustomerID
    GROUP BY c.CustomerID
) t;

✅ Products jadvali bo‘yicha savollar
1. Hech bo‘lmaganda bir marta sotilgan mahsulotlar
SELECT DISTINCT p.ProductName
FROM Products p
JOIN Sales s ON p.ProductName = s.Product;

2. Eng qimmat mahsulot
SELECT TOP 1 ProductName, SellingPrice
FROM Products
ORDER BY SellingPrice DESC;

3. O‘z kategoriyasidan yuqori narxdagi mahsulotlar
SELECT p.ProductName, p.Category, p.SellingPrice
FROM Products p
JOIN (
    SELECT Category, AVG(SellingPrice) AS AvgPrice
    FROM Products
    GROUP BY Category
) c
ON p.Category = c.Category
WHERE p.SellingPrice > c.AvgPrice;
