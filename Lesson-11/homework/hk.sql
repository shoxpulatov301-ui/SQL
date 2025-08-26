Orders after 2022 with customer names

SELECT 
    o.OrderID,
    CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
    o.OrderDate
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
WHERE YEAR(o.OrderDate) > 2022;


2. Employees in Sales or Marketing

SELECT 
    e.Name AS EmployeeName,
    d.DepartmentName
FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID
WHERE d.DepartmentName IN ('Sales', 'Marketing');


3. Employee with highest salary per department

SELECT 
    d.DepartmentName,
    e.Name AS TopEmployeeName,
    e.Salary AS MaxSalary
FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID
WHERE e.Salary = (
    SELECT MAX(Salary) 
    FROM Employees 
    WHERE DepartmentID = e.DepartmentID
);


4. Highest salary per department

SELECT 
    d.DepartmentName,
    MAX(e.Salary) AS MaxSalary
FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID
GROUP BY d.DepartmentName;


5. USA customers who placed orders in 2023

SELECT 
    CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
    o.OrderID,
    o.OrderDate
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE c.Country = 'USA' AND YEAR(o.OrderDate) = 2023;


6. Number of orders per customer

SELECT 
    CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
    COUNT(o.OrderID) AS TotalOrders
FROM Customers c
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.FirstName, c.LastName;


7. Products from Gadget Supplies or Clothing Mart

SELECT 
    p.ProductName,
    s.SupplierName
FROM Products p
JOIN Suppliers s ON p.SupplierID = s.SupplierID
WHERE s.SupplierName IN ('Gadget Supplies', 'Clothing Mart');


8. Most recent order per customer (including no orders)

SELECT 
    CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
    MAX(o.OrderDate) AS MostRecentOrderDate,
    (
        SELECT OrderID 
        FROM Orders o2 
        WHERE o2.CustomerID = c.CustomerID 
        ORDER BY o2.OrderDate DESC 
        LIMIT 1
    ) AS OrderID
FROM Customers c
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.FirstName, c.LastName;

🟠 Medium-Level (6 ta)

9. Customers with orders > 500

SELECT 
    CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
    o.OrderID,
    o.TotalAmount AS OrderTotal
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
WHERE o.TotalAmount > 500;


10. Sales in 2022 or amount > 400

SELECT 
    p.ProductName,
    s.SaleDate,
    s.SaleAmount
FROM Sales s
JOIN Products p ON s.ProductID = p.ProductID
WHERE YEAR(s.SaleDate) = 2022 OR s.SaleAmount > 400;


11. Total sales per product

SELECT 
    p.ProductName,
    SUM(s.SaleAmount) AS TotalSalesAmount
FROM Sales s
JOIN Products p ON s.ProductID = p.ProductID
GROUP BY p.ProductName;


12. HR employees with salary > 50000

SELECT 
    e.Name AS EmployeeName,
    d.DepartmentName,
    e.Salary
FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID
WHERE d.DepartmentName = 'Human Resources' 
  AND e.Salary > 50000;


13. Products sold in 2023 with stock > 50

SELECT 
    p.ProductName,
    s.SaleDate,
    p.StockQuantity
FROM Sales s
JOIN Products p ON s.ProductID = p.ProductID
WHERE YEAR(s.SaleDate) = 2023 AND p.StockQuantity > 50;


14. Employees in Sales OR hired after 2020

SELECT 
    e.Name AS EmployeeName,
    d.DepartmentName,
    e.HireDate
FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID
WHERE d.DepartmentName = 'Sales' OR YEAR(e.HireDate) > 2020;

🔴 Hard-Level (7 ta)

15. USA orders with 4-digit address

SELECT 
    CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
    o.OrderID,
    c.Address,
    o.OrderDate
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE c.Country = 'USA' AND c.Address REGEXP '^[0-9]{4}';


16. Electronics sales or sales > 350

SELECT 
    p.ProductName,
    p.Category,
    s.SaleAmount
FROM Sales s
JOIN Products p ON s.ProductID = p.ProductID
WHERE p.Category = 'Electronics' OR s.SaleAmount > 350;


17. Product count per category

SELECT 
    p.Category AS CategoryName,
    COUNT(p.ProductID) AS ProductCount
FROM Products p
GROUP BY p.Category;


18. Orders from Los Angeles > 300

SELECT 
    CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
    c.City,
    o.OrderID,
    o.TotalAmount AS Amount
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE c.City = 'Los Angeles' AND o.TotalAmount > 300;


19. Employees in HR or Finance OR ≥ 4 vowels in name

SELECT 
    e.Name AS EmployeeName,
    d.DepartmentName
FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID
WHERE d.DepartmentName IN ('Human Resources', 'Finance')
   OR LENGTH(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(LOWER(e.Name),'a',''),'e',''),'i',''),'o',''),'u','')) <= LENGTH(e.Name) - 4;


20. Products with sales qty > 100 and price > 500

SELECT 
    p.ProductName,
    s.QuantitySold,
    p.Price
FROM Sales s
JOIN Products p ON s.ProductID = p.ProductID
WHERE s.QuantitySold > 100 AND p.Price > 500;


21. Sales/Marketing employees with salary > 60000

SELECT 
    e.Name AS EmployeeName,
    d.DepartmentName,
    e.Salary
FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID
WHERE d.DepartmentName IN ('Sales', 'Marketing') AND e.Salary > 60000;
