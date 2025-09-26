1-savol. Temp jadval – joriy oy savdo xulosasi
-- Joriy oy uchun vaqtinchalik jadval
SELECT 
    s.ProductID,
    SUM(s.Quantity) AS TotalQuantity,
    SUM(s.Quantity * p.Price) AS TotalRevenue
INTO #MonthlySales
FROM Sales s
JOIN Products p ON s.ProductID = p.ProductID
WHERE MONTH(s.SaleDate) = MONTH(GETDATE())
  AND YEAR(s.SaleDate) = YEAR(GETDATE())
GROUP BY s.ProductID;

-- Natijani ko‘rish
SELECT * FROM #MonthlySales;

2-savol. Ko‘rinish – mahsulot va umumiy sotuvlar
CREATE VIEW vw_ProductSalesSummary AS
SELECT 
    p.ProductID,
    p.ProductName,
    p.Category,
    ISNULL(SUM(s.Quantity), 0) AS TotalQuantitySold
FROM Products p
LEFT JOIN Sales s ON p.ProductID = s.ProductID
GROUP BY p.ProductID, p.ProductName, p.Category;

3-savol. Funksiya – mahsulot bo‘yicha jami daromad
CREATE FUNCTION fn_GetTotalRevenueForProduct (@ProductID INT)
RETURNS DECIMAL(18,2)
AS
BEGIN
    DECLARE @Revenue DECIMAL(18,2);

    SELECT @Revenue = SUM(s.Quantity * p.Price)
    FROM Sales s
    JOIN Products p ON s.ProductID = p.ProductID
    WHERE p.ProductID = @ProductID;

    RETURN ISNULL(@Revenue, 0);
END;

4-savol. Funksiya – kategoriya bo‘yicha savdolar
CREATE FUNCTION fn_GetSalesByCategory (@Category VARCHAR(50))
RETURNS TABLE
AS
RETURN
(
    SELECT 
        p.ProductName,
        SUM(s.Quantity) AS TotalQuantity,
        SUM(s.Quantity * p.Price) AS TotalRevenue
    FROM Products p
    LEFT JOIN Sales s ON p.ProductID = s.ProductID
    WHERE p.Category = @Category
    GROUP BY p.ProductName
);

5-savol. Funksiya – tub son tekshirish
CREATE FUNCTION fn_IsPrime (@Number INT)
RETURNS VARCHAR(5)
AS
BEGIN
    DECLARE @i INT = 2, @isPrime BIT = 1;

    IF @Number <= 1 RETURN 'No';

    WHILE @i <= SQRT(@Number)
    BEGIN
        IF @Number % @i = 0
        BEGIN
            SET @isPrime = 0;
            BREAK;
        END
        SET @i += 1;
    END

    RETURN CASE WHEN @isPrime = 1 THEN 'Yes' ELSE 'No' END;
END;

6-savol. Funksiya – sonlar orasidagi barcha qiymatlar
CREATE FUNCTION fn_GetNumbersBetween (@Start INT, @End INT)
RETURNS @Numbers TABLE (Number INT)
AS
BEGIN
    DECLARE @i INT = @Start;
    WHILE @i <= @End
    BEGIN
        INSERT INTO @Numbers VALUES (@i);
        SET @i += 1;
    END
    RETURN;
END;

7-savol. N-chi eng yuqori maosh
-- Parametr N ni SET qilib olish mumkin
DECLARE @N INT = 2;

SELECT DISTINCT Salary AS NthHighestSalary
FROM Employee e1
WHERE @N = (
    SELECT COUNT(DISTINCT e2.Salary)
    FROM Employee e2
    WHERE e2.Salary >= e1.Salary
);

8-savol. Eng ko‘p do‘stlari bo‘lgan odam
SELECT TOP 1 id, COUNT(*) AS num
FROM (
    SELECT requester_id AS id, accepter_id FROM RequestAccepted
    UNION ALL
    SELECT accepter_id, requester_id FROM RequestAccepted
) t
GROUP BY id
ORDER BY COUNT(*) DESC;

9-savol. Ko‘rinish – mijoz buyurtma xulosasi
CREATE VIEW vw_CustomerOrderSummary AS
SELECT 
    c.customer_id,
    c.name,
    COUNT(o.order_id) AS total_orders,
    ISNULL(SUM(o.amount),0) AS total_amount,
    MAX(o.order_date) AS last_order_date
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name;

10-savol. Bo‘sh qatorlarni to‘ldirish
SELECT RowNumber,
       FIRST_VALUE(TestCase) OVER (
            PARTITION BY grp
            ORDER BY RowNumber
            ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
       ) AS Workflow
FROM (
    SELECT RowNumber, TestCase,
           SUM(CASE WHEN TestCase IS NOT NULL THEN 1 ELSE 0 END)
               OVER (ORDER BY RowNumber ROWS UNBOUNDED PRECEDING) AS grp
    FROM Gaps
) t
ORDER BY RowNumber;
