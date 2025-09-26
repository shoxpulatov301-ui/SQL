1-savol. Barcha distribyutorlar va mintaqalar bo‘yicha sotuvlar (bo‘lmasa 0 qo‘yish)
WITH Regions AS (
    SELECT DISTINCT Region FROM #RegionSales
),
Distributors AS (
    SELECT DISTINCT Distributor FROM #RegionSales
)
SELECT r.Region,
       d.Distributor,
       ISNULL(s.Sales, 0) AS Sales
FROM Regions r
CROSS JOIN Distributors d
LEFT JOIN #RegionSales s
    ON r.Region = s.Region AND d.Distributor = s.Distributor
ORDER BY r.Region, d.Distributor;

2-savol. Kamida 5 ta bevosita hisobotga ega menejerlar
SELECT m.name
FROM Employee m
JOIN Employee e
     ON m.id = e.managerId
GROUP BY m.id, m.name
HAVING COUNT(e.id) >= 5;

3-savol. 2020-yil fevralida ≥100 dona buyurtma qilingan mahsulotlar
SELECT p.product_name, SUM(o.unit) AS unit
FROM Products p
JOIN Orders o ON p.product_id = o.product_id
WHERE o.order_date >= '2020-02-01'
  AND o.order_date <  '2020-03-01'
GROUP BY p.product_name
HAVING SUM(o.unit) >= 100;

4-savol. Har bir mijoz eng ko‘p buyurtma qilgan sotuvchi
WITH VendorSales AS (
    SELECT CustomerID, Vendor, SUM(OrderCount) AS TotalOrders
    FROM Orders
    GROUP BY CustomerID, Vendor
),
Ranked AS (
    SELECT *,
           RANK() OVER (PARTITION BY CustomerID ORDER BY TotalOrders DESC) AS rnk
    FROM VendorSales
)
SELECT CustomerID, Vendor
FROM Ranked
WHERE rnk = 1;

5-savol. Tub son tekshirish
DECLARE @Check_Prime INT = 91;
DECLARE @i INT = 2, @isPrime BIT = 1;

WHILE @i <= SQRT(@Check_Prime)
BEGIN
    IF @Check_Prime % @i = 0
    BEGIN
        SET @isPrime = 0;
        BREAK;
    END
    SET @i += 1;
END

IF @Check_Prime <= 1 SET @isPrime = 0;

IF @isPrime = 1
    PRINT 'This number is prime';
ELSE
    PRINT 'This number is not prime';

6-savol. Qurilma bo‘yicha signal statistikasi
WITH CTE AS (
    SELECT Device_id, Location, COUNT(*) AS cnt
    FROM Device
    GROUP BY Device_id, Location
),
MaxLoc AS (
    SELECT Device_id, Location,
           ROW_NUMBER() OVER (PARTITION BY Device_id ORDER BY cnt DESC) AS rn
    FROM CTE
)
SELECT d.Device_id,
       COUNT(DISTINCT d.Location) AS no_of_location,
       m.Location AS max_signal_location,
       COUNT(*) AS no_of_signals
FROM Device d
JOIN MaxLoc m
     ON d.Device_id = m.Device_id AND m.rn = 1
GROUP BY d.Device_id, m.Location;

7-savol. O‘rtachadan ko‘proq maosh oladigan xodimlar
SELECT e.EmpID, e.EmpName, e.Salary
FROM Employee e
JOIN (
    SELECT DeptID, AVG(Salary) AS avg_salary
    FROM Employee
    GROUP BY DeptID
) d
  ON e.DeptID = d.DeptID
WHERE e.Salary > d.avg_salary;

8-savol. Lotereya umumiy yutuq summasi
WITH TicketMatch AS (
    SELECT t.TicketID,
           SUM(CASE WHEN n.Number IS NOT NULL THEN 1 ELSE 0 END) AS matched
    FROM Tickets t
    LEFT JOIN Numbers n ON t.Number = n.Number
    GROUP BY t.TicketID
)
SELECT SUM(
    CASE 
      WHEN matched = (SELECT COUNT(*) FROM Numbers) THEN 100
      WHEN matched > 0 THEN 10
      ELSE 0
    END
) AS Total_Prize
FROM TicketMatch;


➡️ Natija: 110

9-savol. Mobile/Desktop/Both xarajatlar
WITH UserSpend AS (
    SELECT User_id, Spend_date, Platform, SUM(Amount) AS amt
    FROM Spending
    GROUP BY User_id, Spend_date, Platform
),
Combined AS (
    SELECT User_id, Spend_date,
           SUM(CASE WHEN Platform='Mobile' THEN amt ELSE 0 END) AS mob,
           SUM(CASE WHEN Platform='Desktop' THEN amt ELSE 0 END) AS desk
    FROM UserSpend
    GROUP BY User_id, Spend_date
),
Expanded AS (
    SELECT User_id, Spend_date, 'Mobile' AS Platform, mob AS TotalAmount
    FROM Combined WHERE mob>0 AND desk=0
    UNION ALL
    SELECT User_id, Spend_date, 'Desktop', desk
    FROM Combined WHERE desk>0 AND mob=0
    UNION ALL
    SELECT User_id, Spend_date, 'Both', mob+desk
    FROM Combined WHERE mob>0 AND desk>0
)
SELECT ROW_NUMBER() OVER (ORDER BY Spend_date, Platform) AS Row,
       Spend_date, Platform,
       SUM(TotalAmount) AS Total_Amount,
       COUNT(DISTINCT User_id) AS Total_users
FROM Expanded
GROUP BY Spend_date, Platform;

10-savol. Guruhlangan jadvalni qatorlarga ajratish
WITH Nums AS (
    SELECT 1 AS n
    UNION ALL
    SELECT n+1 FROM Nums WHERE n < (SELECT MAX(Quantity) FROM Grouped)
)
SELECT g.Product, 1 AS Quantity
FROM Grouped g
JOIN Nums n ON n.n <= g.Quantity
ORDER BY g.Product;
