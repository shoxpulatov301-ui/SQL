1-savol: Quantity ni qatorlarga ajratish
WITH CTE AS (
    SELECT Product, Quantity
    FROM Guruhlangan
),
Nums AS (
    SELECT 1 AS n
    UNION ALL
    SELECT n+1 FROM Nums WHERE n < (SELECT MAX(Quantity) FROM CTE)
)
SELECT c.Product, 1 AS Quantity
FROM CTE c
JOIN Nums n
    ON n.n <= c.Quantity
ORDER BY c.Product;

2-savol: Har bir Region–Distributor kombinatsiyasi
WITH Regions AS (
    SELECT DISTINCT Region FROM #RegionSales
),
Distributors AS (
    SELECT DISTINCT Distributor FROM #RegionSales
)
SELECT r.Region, d.Distributor, 
       ISNULL(s.Sales, 0) AS Sales
FROM Regions r
CROSS JOIN Distributors d
LEFT JOIN #RegionSales s
    ON s.Region = r.Region 
   AND s.Distributor = d.Distributor
ORDER BY r.Region, d.Distributor;

3-savol: 5 ta bevosita reporti bor managerlar
SELECT m.name
FROM Employee m
JOIN Employee e
    ON m.id = e.managerId
GROUP BY m.id, m.name
HAVING COUNT(e.id) >= 5;

4-savol: 2020-yil fevralida 100+ dona
SELECT p.product_name, SUM(o.unit) AS unit
FROM Products p
JOIN Orders o ON p.product_id = o.product_id
WHERE o.order_date >= '2020-02-01'
  AND o.order_date <  '2020-03-01'
GROUP BY p.product_name
HAVING SUM(o.unit) >= 100;

5-savol: Mijoz uchun eng ko‘p buyurtma bergan sotuvchi
WITH VendorSales AS (
    SELECT CustomerID, Vendor, SUM(OrderCount) AS TotalOrders
    FROM Orders
    GROUP BY CustomerID, Vendor
),
Ranked AS (
    SELECT *,
           RANK() OVER(PARTITION BY CustomerID ORDER BY TotalOrders DESC) AS rnk
    FROM VendorSales
)
SELECT CustomerID, Vendor
FROM Ranked
WHERE rnk = 1;

6-savol: Tub son tekshirish
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

7-savol: Qurilma bo‘yicha signal hisoblash
SELECT Device_id,
       COUNT(DISTINCT Location) AS no_of_location,
       MAX(Location) WITHIN GROUP (ORDER BY COUNT(*) DESC) 
         OVER (PARTITION BY Device_id) AS max_signal_location,
       COUNT(*) AS no_of_signals
FROM Device
GROUP BY Device_id, Location;


(SQL Server’da TOP 1 WITH TIES + ROW_NUMBER() ham ishlatish mumkin.)

8-savol: Bo‘lim bo‘yicha o‘rtachadan yuqori maosh
SELECT e.EmpID, e.EmpName, e.Salary
FROM Employee e
JOIN (
    SELECT DeptID, AVG(Salary) AS avg_salary
    FROM Employee
    GROUP BY DeptID
) d
ON e.DeptID = d.DeptID
WHERE e.Salary > d.avg_salary;

9-savol: Lotereya yutuq summasi
WITH TicketMatch AS (
    SELECT TicketID,
           SUM(CASE WHEN n.Number IS NOT NULL THEN 1 ELSE 0 END) AS matched
    FROM Tickets t
    LEFT JOIN WinningNumbers n
      ON t.Number = n.Number
    GROUP BY TicketID
)
SELECT SUM(
    CASE 
      WHEN matched = (SELECT COUNT(*) FROM WinningNumbers) THEN 100
      WHEN matched > 0 THEN 10
      ELSE 0
    END
) AS Total_Prize
FROM TicketMatch;

10-savol: Mobile, Desktop va Both xarajatlar
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
)
SELECT ROW_NUMBER() OVER(ORDER BY Spend_date, Platform) AS Row,
       Spend_date,
       Platform,
       SUM(TotalAmount) AS Total_Amount,
       COUNT(DISTINCT User_id) AS Total_users
FROM (
    SELECT User_id, Spend_date, 'Mobile' AS Platform, mob AS TotalAmount FROM Combined WHERE mob>0 AND desk=0
    UNION ALL
    SELECT User_id, Spend_date, 'Desktop', desk FROM Combined WHERE desk>0 AND mob=0
    UNION ALL
    SELECT User_id, Spend_date, 'Both', mob+desk FROM Combined WHERE mob>0 AND desk>0
) t
GROUP BY Spend_date, Platform;
