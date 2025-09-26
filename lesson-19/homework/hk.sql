📄 1-topshiriq
CREATE PROCEDURE GetEmployeeBonus
AS
BEGIN
    -- Vaqtinchalik jadval yaratish
    CREATE TABLE #EmployeeBonus (
        EmployeeID INT,
        FullName NVARCHAR(100),
        Department NVARCHAR(50),
        Salary DECIMAL(10,2),
        BonusAmount DECIMAL(10,2)
    );

    -- Ma'lumotlarni qo‘shish
    INSERT INTO #EmployeeBonus (EmployeeID, FullName, Department, Salary, BonusAmount)
    SELECT e.EmployeeID,
           e.FirstName + ' ' + e.LastName,
           e.Department,
           e.Salary,
           e.Salary * b.BonusPercent / 100
    FROM Employees e
    JOIN DepartmentBonus b ON e.Department = b.Department;

    -- Natijani qaytarish
    SELECT * FROM #EmployeeBonus;
END;

📄 2-topshiriq
CREATE PROCEDURE UpdateDepartmentSalary
    @Department NVARCHAR(50),
    @IncreasePercent DECIMAL(5,2)
AS
BEGIN
    -- Yangilash
    UPDATE Employees
    SET Salary = Salary + (Salary * @IncreasePercent / 100)
    WHERE Department = @Department;

    -- Natijani qaytarish
    SELECT * FROM Employees WHERE Department = @Department;
END;

🔵 2-qism: Birlashtirish
📄 3-topshiriq
MERGE Products_Current AS target
USING Products_New AS source
ON target.ProductID = source.ProductID
WHEN MATCHED THEN
    UPDATE SET target.ProductName = source.ProductName,
               target.Price = source.Price
WHEN NOT MATCHED BY TARGET THEN
    INSERT (ProductID, ProductName, Price)
    VALUES (source.ProductID, source.ProductName, source.Price)
WHEN NOT MATCHED BY SOURCE THEN
    DELETE;

-- Yakuniy holat
SELECT * FROM Products_Current;

🔵 3-qism: LeetCode uslubi masalalar
📄 4-topshiriq — Daraxt tugunlari
SELECT id,
       CASE 
           WHEN p_id IS NULL THEN 'Root'
           WHEN id NOT IN (SELECT DISTINCT p_id FROM Tree WHERE p_id IS NOT NULL) THEN 'Leaf'
           ELSE 'Inner'
       END AS Type
FROM Tree;

📄 5-topshiriq — Tasdiqlash darajasi
SELECT r.user_id,
       CAST(
            ISNULL(SUM(CASE WHEN c.action = 'confirmed' THEN 1 ELSE 0 END),0) * 1.0 /
            NULLIF(COUNT(c.action),0)
            AS DECIMAL(3,2)
       ) AS confirmation_rate
FROM Signups r
LEFT JOIN Confirmations c
    ON r.user_id = c.user_id
GROUP BY r.user_id
ORDER BY r.user_id;

📄 6-topshiriq — Eng kam maoshli xodimlar
SELECT *
FROM Employees
WHERE Salary = (SELECT MIN(Salary) FROM Employees);

🔵 4-qism: Mahsulotlar va Savdolar
📄 7-topshiriq — GetProductSalesSummary
CREATE PROCEDURE GetProductSalesSummary
    @ProductID INT
AS
BEGIN
    SELECT 
        p.ProductName,
        SUM(s.Quantity) AS TotalQuantity,
        SUM(s.Quantity * p.Price) AS TotalSalesAmount,
        MIN(s.SaleDate) AS FirstSaleDate,
        MAX(s.SaleDate) AS LastSaleDate
    FROM Products p
    LEFT JOIN Sales s ON p.ProductID = s.ProductID
    WHERE p.ProductID = @ProductID
    GROUP BY p.ProductName;
END;
