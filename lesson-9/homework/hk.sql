. Products × Suppliers (all combinations)

SELECT p.ProductName, s.SupplierName
FROM Products p
CROSS JOIN Suppliers s;


2. Departments × Employees (all combinations)

SELECT d.DepartmentName, e.Name AS EmployeeName
FROM Departments d
CROSS JOIN Employees e;


3. Products supplied by Suppliers (only matching ones)

SELECT s.SupplierName, p.ProductName
FROM Products p
JOIN Suppliers s ON p.SupplierID = s.SupplierID;


4. Customers and their Orders

SELECT c.FirstName, c.LastName, o.OrderID
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID;


5. Students × Courses (all combinations)

SELECT s.StudentName, c.CourseName
FROM Students s
CROSS JOIN Courses c;


6. Products × Orders (only matching IDs)

SELECT o.OrderID, p.ProductName
FROM Orders o
JOIN Products p ON o.ProductID = p.ProductID;


7. Employees and their Departments (only matches)

SELECT e.Name AS EmployeeName, d.DepartmentName
FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID;


8. Students and their Enrolled CourseIDs

SELECT s.StudentName, e.CourseID
FROM Students s
JOIN Enrollments e ON s.StudentID = e.StudentID;


9. Orders with Payments

SELECT o.OrderID, p.PaymentID, p.Amount
FROM Orders o
JOIN Payments p ON o.OrderID = p.OrderID;


10. Orders × Products (price > 100)

SELECT o.OrderID, p.ProductName, p.Price
FROM Orders o
JOIN Products p ON o.ProductID = p.ProductID
WHERE p.Price > 100;

🟡 Medium (10 puzzles)

1. Employees × Departments (mismatched IDs)

SELECT e.Name AS EmployeeName, d.DepartmentName
FROM Employees e
CROSS JOIN Departments d
WHERE e.DepartmentID <> d.DepartmentID;


2. Orders where Quantity > Stock

SELECT o.OrderID, p.ProductName, o.Quantity, p.StockQuantity
FROM Orders o
JOIN Products p ON o.ProductID = p.ProductID
WHERE o.Quantity > p.StockQuantity;


3. Customers & Sales (Amount ≥ 500)

SELECT c.FirstName, c.LastName, s.ProductID, s.Amount
FROM Customers c
JOIN Sales s ON c.CustomerID = s.CustomerID
WHERE s.Amount >= 500;


4. Students & Courses (via Enrollments)

SELECT s.StudentName, c.CourseName
FROM Students s
JOIN Enrollments e ON s.StudentID = e.StudentID
JOIN Courses c ON e.CourseID = c.CourseID;


5. Products & Suppliers (where supplier has “Tech”)

SELECT p.ProductName, s.SupplierName
FROM Products p
JOIN Suppliers s ON p.SupplierID = s.SupplierID
WHERE s.SupplierName LIKE '%Tech%';


6. Orders where Payment < Total

SELECT o.OrderID, o.TotalAmount, p.Amount
FROM Orders o
JOIN Payments p ON o.OrderID = p.OrderID
WHERE p.Amount < o.TotalAmount;


7. Employees with higher salary than manager

SELECT e.Name AS Employee, e.Salary, m.Name AS Manager, m.Salary AS ManagerSalary
FROM Employees e
JOIN Employees m ON e.ManagerID = m.EmployeeID
WHERE e.Salary > m.Salary;


8. Employees and Department Names

SELECT e.Name AS Employee, d.DepartmentName
FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID;


9. Electronics or Furniture Products

SELECT ProductName, Category
FROM Products
WHERE Category IN ('Electronics', 'Furniture');


10. Sales from USA Customers

SELECT s.SaleID, c.FirstName, c.LastName, c.Country
FROM Sales s
JOIN Customers c ON s.CustomerID = c.CustomerID
WHERE c.Country = 'USA';

🔴 Hard (5 puzzles)

1. Pairs of employees from different departments

SELECT e1.Name AS Employee1, e2.Name AS Employee2
FROM Employees e1
JOIN Employees e2 ON e1.EmployeeID < e2.EmployeeID
WHERE e1.DepartmentID <> e2.DepartmentID;


2. Payments ≠ (Quantity × Price)

SELECT p.PaymentID, p.Amount, o.Quantity, pr.Price
FROM Payments p
JOIN Orders o ON p.OrderID = o.OrderID
JOIN Products pr ON o.ProductID = pr.ProductID
WHERE p.Amount <> (o.Quantity * pr.Price);


3. Students NOT enrolled in any course

SELECT s.StudentName
FROM Students s
LEFT JOIN Enrollments e ON s.StudentID = e.StudentID
WHERE e.CourseID IS NULL;


4. Managers with lower/equal salary than subordinates

SELECT m.Name AS Manager, m.Salary AS ManagerSalary, e.Name AS Employee, e.Salary AS EmployeeSalary
FROM Employees e
JOIN Employees m ON e.ManagerID = m.EmployeeID
WHERE m.Salary <= e.Salary;


5. Customers with orders but no payment

SELECT DISTINCT c.FirstName, c.LastName, o.OrderID
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
LEFT JOIN Payments p ON o.OrderID = p.OrderID
WHERE p.PaymentID IS NULL;
