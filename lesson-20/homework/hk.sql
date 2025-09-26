🔵 1-savol

EXISTS yordamida 2024-yil mart oyida kamida bitta mahsulot sotib olgan mijozlarni toping

SELECT DISTINCT s.[Mijoz nomi]
FROM Sales s
WHERE EXISTS (
    SELECT 1
    FROM Sales s2
    WHERE s2.[Mijoz nomi] = s.[Mijoz nomi]
      AND YEAR(s2.SaleSate) = 2024
      AND MONTH(s2.SaleSate) = 3
);

🔵 2-savol

Quyi so‘rov yordamida eng yuqori umumiy savdo daromadiga ega mahsulotni toping.

SELECT TOP 1 mahsuloti
FROM Sales
GROUP BY mahsuloti
ORDER BY SUM(miqdori * Narxi) DESC;

🔵 3-savol

Quyi so‘rov yordamida ikkinchi eng yuqori sotuv miqdorini toping.

SELECT MAX(miqdori) AS IkkinchiKattaMiqdor
FROM Sales
WHERE miqdori < (SELECT MAX(miqdori) FROM Sales);

🔵 4-savol

Bir oyda sotilgan mahsulotlarning umumiy miqdorini toping.

SELECT SaleMonth, SUM(Miqdori) AS TotalQty
FROM (
    SELECT MONTH(SaleSate) AS SaleMonth, Miqdori
    FROM Sales
) t
GROUP BY SaleMonth;

🔵 5-savol

EXISTS yordamida boshqa xaridor bilan bir xil mahsulot sotib olgan mijozlarni toping.

SELECT DISTINCT s1.[Mijoz nomi]
FROM Sales s1
WHERE EXISTS (
    SELECT 1
    FROM Sales s2
    WHERE s1.[Mijoz nomi] <> s2.[Mijoz nomi]
      AND s1.mahsuloti = s2.mahsuloti
);

🔵 6-savol

Har bir odam nechta olma, banan, apelsin olganini qaytarish (pivot usulida).

SELECT 
    Nomi,
    SUM(CASE WHEN Meva = 'Olma' THEN 1 ELSE 0 END) AS Apple,
    SUM(CASE WHEN Meva = 'Apelsin' THEN 1 ELSE 0 END) AS Orange,
    SUM(CASE WHEN Meva = 'Banan' THEN 1 ELSE 0 END) AS Banana
FROM Mevalar
GROUP BY Nomi;

🔵 7-savol

Oiladagi keksa odamlarni kichiklari bilan birga qaytarish.

WITH RecursiveCTE AS (
    SELECT ParentId, ChildId
    FROM Oila
    UNION ALL
    SELECT r.ParentId, o.ChildId
    FROM RecursiveCTE r
    JOIN Oila o ON r.ChildId = o.ParentId
)
SELECT * FROM RecursiveCTE;

🔵 8-savol

Kaliforniyaga buyurtma qilgan mijozlarning Texasdagi buyurtmalarini qaytarish.

SELECT DISTINCT o1.CustomerID, o1.OrderID, o1.DeliveryState, o1.Amount
FROM Orders o1
WHERE o1.DeliveryState = 'TX'
  AND EXISTS (
      SELECT 1 FROM Orders o2
      WHERE o2.CustomerID = o1.CustomerID
        AND o2.DeliveryState = 'CA'
  );

🔵 9-savol

Agar “ismi” yetishmayotgan bo‘lsa, uni yozib chiqish.

👉 Bu yerda CASE WHEN yoki CHARINDEX bilan ajratish kerak.
Masalan, “nomi=” bo‘lmaganlarni topish:

SELECT *
FROM Rezidentlar
WHERE Adres NOT LIKE '%nomi=%';

🔵 10-savol

Toshkentdan Xorazmga boradigan eng arzon va eng qimmat yo‘nalishlarni topish.
👉 Bu graf masalasi, rekursiv CTE bilan yechiladi.

WITH Paths AS (
    SELECT RouteID,
           DepartureCity,
           ArrivalCity,
           CAST(DepartureCity + ' - ' + ArrivalCity AS VARCHAR(MAX)) AS Route,
           Cost
    FROM Marshrut
    WHERE DepartureCity = 'Toshkent'
    UNION ALL
    SELECT m.RouteID,
           p.DepartureCity,
           m.ArrivalCity,
           p.Route + ' - ' + m.ArrivalCity,
           p.Cost + m.Cost
    FROM Paths p
    JOIN Marshrut m ON p.ArrivalCity = m.DepartureCity
)
SELECT Route, Cost
FROM Paths
WHERE ArrivalCity = 'Xorazm';

🔵 11-savol

Mahsulotlarni joylashtirish tartibida chiqarish.

SELECT *
FROM RankingPuzzle
ORDER BY CASE WHEN Vals = 'Mahsulot' THEN ID ELSE 1000+ID END;

🔵 12-savol

Ketma-ket bir xil sonlarning maksimal uzunligi.

WITH CTE AS (
    SELECT Id, Vals,
           ROW_NUMBER() OVER (PARTITION BY Id ORDER BY (SELECT NULL)) -
           ROW_NUMBER() OVER (PARTITION BY Id, Vals ORDER BY (SELECT NULL)) AS grp
    FROM Ketma_ket
)
SELECT Id, Vals, MAX(cnt) AS MaxLen
FROM (
    SELECT Id, Vals, grp, COUNT(*) AS cnt
    FROM CTE
    GROUP BY Id, Vals, grp
) t
GROUP BY Id, Vals;

🔵 13-savol

Bo‘limidagi o‘rtacha savdodan yuqori ishlagan xodimlar.

SELECT e.*
FROM EmployeeSales e
WHERE e.SalesAmount > (
    SELECT AVG(SalesAmount)
    FROM EmployeeSales e2
    WHERE e2.Department = e.Department
      AND e2.SalesYear = e.SalesYear
      AND e2.SalesMonth = e.SalesMonth
);

🔵 14-savol

EXISTS – eng yuqori sotuv qilgan xodimlar.

SELECT e1.*
FROM EmployeeSales e1
WHERE NOT EXISTS (
    SELECT 1
    FROM EmployeeSales e2
    WHERE e2.SalesMonth = e1.SalesMonth
      AND e2.SalesYear = e1.SalesYear
      AND e2.SalesAmount > e1.SalesAmount
);

🔵 15-savol

NOT EXISTS – har oy sotuv qilgan xodimlar.

SELECT e.*
FROM EmployeeSales e
WHERE NOT EXISTS (
    SELECT 1
    FROM (
        SELECT DISTINCT SalesMonth, SalesYear
        FROM EmployeeSales
    ) m
    WHERE NOT EXISTS (
        SELECT 1
        FROM EmployeeSales e2
        WHERE e2.EmployeeName = e.EmployeeName
          AND e2.SalesMonth = m.SalesMonth
          AND e2.SalesYear = m.SalesYear
    )
);

🔵 16–25-savollar (Mahsulotlar va Buyurtmalar)
16. O‘rtacha narxdan qimmatroq mahsulotlar:
SELECT Ismi
FROM Mahsulotlar
WHERE Narxi > (SELECT AVG(Narxi) FROM Mahsulotlar);

17. Maksimal stokdan kam mahsulotlar:
SELECT *
FROM Mahsulotlar
WHERE Stok < (SELECT MAX(Stok) FROM Mahsulotlar);

18. “Noutbuk” bilan bir xil toifa:
SELECT Ismi
FROM Mahsulotlar
WHERE Toifasi = (SELECT Toifasi FROM Mahsulotlar WHERE Ismi = 'Noutbuk');

19. Elektronikadagi eng past narxdan yuqori mahsulotlar:
SELECT Ismi
FROM Mahsulotlar
WHERE Narxi > (
    SELECT MIN(Narxi) FROM Mahsulotlar WHERE Toifasi = 'Elektronika'
);

20. Toifa bo‘yicha o‘rtacha narxdan qimmat mahsulotlar:
SELECT m.Ismi
FROM Mahsulotlar m
WHERE m.Narxi > (
    SELECT AVG(Narxi) FROM Mahsulotlar WHERE Toifasi = m.Toifasi
);

21. Kamida bir marta buyurtma qilingan mahsulotlar:
SELECT DISTINCT m.Ismi
FROM Mahsulotlar m
JOIN Buyurtmalar b ON m.ProductID = b.ProductID;

22. O‘rtacha miqdordan ko‘p buyurtma qilingan mahsulotlar:
SELECT m.Ismi
FROM Mahsulotlar m
JOIN Buyurtmalar b ON m.ProductID = b.ProductID
GROUP BY m.Ismi
HAVING SUM(b.Miqdori) > (SELECT AVG(Miqdori) FROM Buyurtmalar);

23. Hech qachon buyurtma qilinmagan mahsulotlar:
SELECT m.Ismi
FROM Mahsulotlar m
WHERE NOT EXISTS (
    SELECT 1 FROM Buyurtmalar b WHERE b.ProductID = m.ProductID
);

24. Eng ko‘p buyurtma qilingan mahsulot:
SELECT TOP 1 m.Ismi
FROM Mahsulotlar m
JOIN Buyurtmalar b ON m.ProductID = b.ProductID
GROUP BY m.Ismi
ORDER BY SUM(b.Miqdori) DESC;

25. O‘rtacha buyurtmalar sonidan ko‘p buyurtma qilingan mahsulotlar:
SELECT m.Ismi
FROM Mahsulotlar m
JOIN Buyurtmalar b ON m.ProductID = b.ProductID
GROUP BY m.Ismi
HAVING COUNT(b.OrderID) > (
    SELECT AVG(cnt)
    FROM (
        SELECT COUNT(*) AS cnt
        FROM Buyurtmalar
        GROUP BY ProductID
    ) t
);
