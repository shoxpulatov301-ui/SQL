---- 1
SELECT TOP 5 *
FROM Employees
ORDER BY Salary DESC;
--2
SELECT DISTINCT Category
FROM Products_Discounted;
  --- 3
   SELECT *
FROM Products_Discounted
WHERE Price > 100;
-- 4
	SELECT FirstName, LastName
FROM Employees
WHERE FirstName LIKE 'A%';
5 Order the results of a Products table by Price in ascending order
sql
Копировать
Редактировать
SELECT * 
FROM Products 
ORDER BY Price ASC;
6. Filter for employees with Salary >= 60000 and Department = 'HR'
sql
Копировать
Редактировать
SELECT * 
FROM Employees 
WHERE Salary >= 60000 AND Department = 'HR';
7. Use ISNULL to replace NULL values in the Email column
sql
Копировать
Редактировать
SELECT ISNULL(Email, 'noemail@example.com') AS Email 
FROM Employees;
Agar boshqa ustunlar ham kerak bo‘lsa:

sql
Копировать
Редактировать
SELECT Name, ISNULL(Email, 'noemail@example.com') AS Email 
FROM Employees;
8. Show all products with Price BETWEEN 50 AND 100
sql
Копировать
Редактировать
SELECT * 
FROM Products 
WHERE Price BETWEEN 50 AND 100;
8. Use SELECT DISTINCT on two columns (Category and ProductName)
sql
Копировать
Редактировать
SELECT DISTINCT Category, ProductName 
FROM Products;
9. SELECT DISTINCT Category and ProductName, ordered by ProductName DESC
sql
Копировать
Редактировать
SELECT DISTINCT Category, ProductName 
FROM Products 
ORDER BY ProductName DESC;


Top 10 products by Price DESC
sql
Копировать
Редактировать
SELECT TOP 10 *
FROM Products
ORDER BY Price DESC;
✅ 2. COALESCE for FirstName or LastName
sql
Копировать
Редактировать
SELECT COALESCE(FirstName, LastName) AS Name
FROM Employees;
✅ 3. DISTINCT Category and Price from Products
sql
Копировать
Редактировать
SELECT DISTINCT Category, Price
FROM Products;
✅ 4. Employees Age between 30 and 40 OR in Marketing
sql
Копировать
Редактировать
SELECT *
FROM Employees
WHERE (Age BETWEEN 30 AND 40) OR Department = 'Marketing';
✅ 5. OFFSET-FETCH for rows 11 to 20 ordered by Salary DESC
sql
Копировать
Редактировать
SELECT *
FROM Employees
ORDER BY Salary DESC
OFFSET 10 ROWS FETCH NEXT 10 ROWS ONLY;
✅ 6. Products with Price <= 1000 and Stock > 50
sql
Копировать
Редактировать
SELECT *
FROM Products
WHERE Price <= 1000 AND Stock > 50
ORDER BY Stock ASC;
✅ 7. Products where ProductName contains 'e'
sql
Копировать
Редактировать
SELECT *
FROM Products
WHERE ProductName LIKE '%e%';
✅ 8. Employees in HR, IT, or Finance
sql
Копировать
Редактировать
SELECT *
FROM Employees
WHERE Department IN ('HR', 'IT', 'Finance');
✅ 9. Customers ordered by City ASC and PostalCode DESC
sql
Копировать
Редактировать
SELECT *
FROM Customers
ORDER BY City ASC, PostalCode DESC;
🔴 Hard-Level Tasks
✅ 10. Top 5 products with highest SalesAmount
sql
Копировать
Редактировать
SELECT TOP 5 *
FROM Products
ORDER BY SalesAmount DESC;
✅ 11. Combine FirstName and LastName as FullName
sql
Копировать
Редактировать
SELECT FirstName + ' ' + LastName AS FullName
FROM Employees;
Eslatma: Agar FirstName yoki LastName NULL bo‘lsa, COALESCE ishlatish tavsiya etiladi:

sql
Копировать
Редактировать
SELECT COALESCE(FirstName, '') + ' ' + COALESCE(LastName, '') AS FullName
FROM Employees;
✅ 12. DISTINCT Category, ProductName, Price for products > $50
sql
Копировать
Редактировать
SELECT DISTINCT Category, ProductName, Price
FROM Products
WHERE Price > 50;
✅ 13. Products priced less than 10% of average price
sql
Копировать
Редактировать
SELECT *
FROM Products
WHERE Price < (
    SELECT AVG(Price) * 0.1
    FROM Products
);
✅ 14. Employees age < 30 and in HR or IT
sql
Копировать
Редактировать
SELECT *
FROM Employees
WHERE Age < 30 AND Department IN ('HR', 'IT');
✅ 15. Customers with '@gmail.com' in Email
sql
Копировать
Редактировать
SELECT *
FROM Customers
WHERE Email LIKE '%@gmail.com%';
✅ 16. Employees with salary > ALL in 'Sales' department
sql
Копировать
Редактировать
SELECT *
FROM Employees
WHERE Salary > ALL (
    SELECT Salary
    FROM Employees
    WHERE Department = 'Sales'
);
✅ 17. Orders in last 180 days (using LATEST_DATE column)
sql
Копировать
Редактировать
SELECT *
FROM Orders
WHERE LATEST_DATE BETWEEN DATEADD(DAY, -180, GETDATE()) AND GETDATE();
GETDATE() — joriy sana olish uchun. DATEADD(DAY, -180, ...) — oxirgi 180 kunni olish uchun.
