1. Maoshi 50000 dan ortiq xodimlar (Employees, Departments):

SELECT e.Ism AS EmployeeName,
       e.Ish_haqi AS Salary,
       d."Bo'lim nomi" AS DepartmentName
FROM Xodimlar e
JOIN Bo'limlar d ON e."Departament ID" = d."Departament identifikatori"
WHERE e.Ish_haqi > 50000;


2. 2023-yilda buyurtma bergan mijozlar (Customers, Orders):

SELECT c.Ism AS FirstName,
       c.Familiyasi AS LastName,
       o."Buyurtma sanasi" AS OrderDate
FROM Mijozlar c
JOIN Buyurtmalar o ON c."Mijoz ID" = o."Mijoz ID"
WHERE YEAR(o."Buyurtma sanasi") = 2023;


3. Barcha xodimlar va bo‘limlari (shu jumladan NULL bo‘lsa ham):

SELECT e.Ism AS EmployeeName,
       d."Bo'lim nomi" AS DepartmentName
FROM Xodimlar e
LEFT JOIN Bo'limlar d ON e."Departament ID" = d."Departament identifikatori";


4. Yetkazib beruvchilar va mahsulotlari (Products, Suppliers):

SELECT s.SupplierName,
       p.ProductName
FROM Suppliers s
LEFT JOIN Products p ON s.SupplierID = p.SupplierID;


5. Buyurtmalar va tegishli to‘lovlari (Orders, Payments):

SELECT o."Buyurtma identifikatori" AS OrderID,
       o."Buyurtma sanasi" AS OrderDate,
       p.PaymentDate,
       p.Amount
FROM Buyurtmalar o
FULL OUTER JOIN To'lovlar p ON o."Buyurtma identifikatori" = p.OrderID;


6. Xodim va uning menejeri (Employees self join):

SELECT e.Ism AS EmployeeName,
       m.Ism AS ManagerName
FROM Xodimlar e
LEFT JOIN Xodimlar m ON e.ManagerID = m."Xodim identifikatori";


7. “Matematik 101” kursiga kirgan talabalar:

SELECT s.StudentName,
       c.CourseName
FROM Students s
JOIN Enrollments e ON s.StudentID = e.StudentID
JOIN Courses c ON e.CourseID = c.CourseID
WHERE c.CourseName = 'Matematik 101';


8. 3 dan ortiq mahsulotga buyurtma bergan mijozlar:

SELECT c.Ism AS FirstName,
       c.Familiyasi AS LastName,
       SUM(o.Miqdori) AS Quantity
FROM Mijozlar c
JOIN Buyurtmalar o ON c."Mijoz ID" = o."Mijoz ID"
GROUP BY c.Ism, c.Familiyasi
HAVING SUM(o.Miqdori) > 3;


9. “Kadrlar” bo‘limidagi xodimlar:

SELECT e.Ism AS EmployeeName,
       d."Bo'lim nomi" AS DepartmentName
FROM Xodimlar e
JOIN Bo'limlar d ON e."Departament ID" = d."Departament identifikatori"
WHERE d."Bo'lim nomi" = 'Inson resurslari';

🟠 O‘rta darajadagi vazifalar

10. 5 dan ortiq xodimga ega bo‘limlar:

SELECT d."Bo'lim nomi" AS DepartmentName,
       COUNT(e."Xodim identifikatori") AS EmployeeCount
FROM Bo'limlar d
JOIN Xodimlar e ON e."Departament ID" = d."Departament identifikatori"
GROUP BY d."Bo'lim nomi"
HAVING COUNT(e."Xodim identifikatori") > 5;


11. Hech qachon sotilmagan mahsulotlar (Products, Sales):

SELECT p.ProductID,
       p.ProductName
FROM Products p
LEFT JOIN Sales s ON p.ProductID = s.ProductID
WHERE s.ProductID IS NULL;


12. Kamida bitta buyurtma bergan mijozlar:

SELECT c.Ism AS FirstName,
       c.Familiyasi AS LastName,
       COUNT(o."Buyurtma identifikatori") AS TotalOrders
FROM Mijozlar c
JOIN Buyurtmalar o ON c."Mijoz ID" = o."Mijoz ID"
GROUP BY c.Ism, c.Familiyasi;


13. NULL bo‘lmagan employee va department yozuvlari:

SELECT e.Ism AS EmployeeName,
       d."Bo'lim nomi" AS DepartmentName
FROM Xodimlar e
INNER JOIN Bo'limlar d ON e."Departament ID" = d."Departament identifikatori";


14. Bir menejerga qarashli xodimlar juftligi:

SELECT e1.Ism AS Employee1,
       e2.Ism AS Employee2,
       e1.ManagerID
FROM Xodimlar e1
JOIN Xodimlar e2 ON e1.ManagerID = e2.ManagerID
WHERE e1."Xodim identifikatori" < e2."Xodim identifikatori";


15. 2022-yildagi buyurtmalar va mijozlari:

SELECT o."Buyurtma identifikatori" AS OrderID,
       o."Buyurtma sanasi" AS OrderDate,
       c.Ism AS FirstName,
       c.Familiyasi AS LastName
FROM Buyurtmalar o
JOIN Mijozlar c ON o."Mijoz ID" = c."Mijoz ID"
WHERE YEAR(o."Buyurtma sanasi") = 2022;


16. Savdo bo‘limidan, ish haqi 60000 dan yuqori bo‘lganlar:

SELECT e.Ism AS EmployeeName,
       e.Ish_haqi AS Salary,
       d."Bo'lim nomi" AS DepartmentName
FROM Xodimlar e
JOIN Bo'limlar d ON e."Departament ID" = d."Departament identifikatori"
WHERE d."Bo'lim nomi" = 'Sotuv'
  AND e.Ish_haqi > 60000;


17. Faqat to‘lovga ega buyurtmalar:

SELECT o."Buyurtma identifikatori" AS OrderID,
       o."Buyurtma sanasi" AS OrderDate,
       p.PaymentDate,
       p.Amount
FROM Buyurtmalar o
JOIN To'lovlar p ON o."Buyurtma identifikatori" = p.OrderID;


18. Hech qachon buyurtma qilinmagan mahsulotlar:

SELECT p.ProductID,
       p.ProductName
FROM Products p
LEFT JOIN Buyurtmalar o ON p.ProductID = o."Mahsulot ID"
WHERE o."Mahsulot ID" IS NULL;

🔴 Qiyin darajadagi vazifalar

19. O‘z bo‘limidagi o‘rtacha ish haqidan yuqori oladigan xodimlar:

SELECT e.Ism AS EmployeeName,
       e.Ish_haqi AS Salary
FROM Xodimlar e
JOIN (
    SELECT "Departament ID", AVG(Ish_haqi) AS AvgSalary
    FROM Xodimlar
    GROUP BY "Departament ID"
) d_avg ON e."Departament ID" = d_avg."Departament ID"
WHERE e.Ish_haqi > d_avg.AvgSalary;


20. 2020-yilgacha, to‘lovsiz buyurtmalar:

SELECT o."Buyurtma identifikatori" AS OrderID,
       o."Buyurtma sanasi" AS OrderDate
FROM Buyurtmalar o
LEFT JOIN To'lovlar p ON o."Buyurtma identifikatori" = p.OrderID
WHERE p.OrderID IS NULL
  AND o."Buyurtma sanasi" < '2020-01-01';


21. Mos toifasiz mahsulotlar:

SELECT p.ProductID,
       p.ProductName
FROM Products p
LEFT JOIN Categories c ON p.CategoryID = c.CategoryID
WHERE c.CategoryID IS NULL;


22. Bir menejerga qarashli va ish haqi > 60000 bo‘lganlar:

SELECT e1.Ism AS Employee1,
       e2.Ism AS Employee2,
       e1.ManagerID,
       e1.Ish_haqi AS Salary
FROM Xodimlar e1
JOIN Xodimlar e2 ON e1.ManagerID = e2.ManagerID
WHERE e1."Xodim identifikatori" < e2."Xodim identifikatori"
  AND e1.Ish_haqi > 60000
  AND e2.Ish_haqi > 60000;


23. Nomi “M” bilan boshlanadigan bo‘limlardagi xodimlar:

SELECT e.Ism AS EmployeeName,
       d."Bo'lim nomi" AS DepartmentName
FROM Xodimlar e
JOIN Bo'limlar d ON e."Departament ID" = d."Departament identifikatori"
WHERE d."Bo'lim nomi" LIKE 'M%';


24. 500 dan ortiq miqdordagi sotuvlar (Sales, Products):

SELECT s.SaleID,
       p.ProductName,
       s.SaleAmount
FROM Sales s
JOIN Products p ON s.ProductID = p.ProductID
WHERE s.SaleAmount > 500;


25. “Matematik 101” ga yozilmagan talabalar:

SELECT s.StudentID,
       s.StudentName
FROM Students s
WHERE s.StudentID NOT IN (
    SELECT e.StudentID
    FROM Enrollments e
    JOIN Courses c ON e.CourseID = c.CourseID
    WHERE c.CourseName = 'Matematik 101'
);


26. To‘lov tafsiloti yo‘q buyurtmalar:

SELECT o."Buyurtma identifikatori" AS OrderID,
       o."Buyurtma sanasi" AS OrderDate,
       p.PaymentID
FROM Buyurtmalar o
LEFT JOIN To'lovlar p ON o."Buyurtma identifikatori" = p.OrderID
WHERE p.PaymentID IS NULL;


27. “Elektronika” yoki “Mebel” toifasidagi mahsulotlar:

SELECT p.ProductID,
       p.ProductName,
       c.CategoryName
FROM Products p
JOIN Categories c ON p.CategoryID = c.CategoryID
WHERE c.CategoryName IN ('Elektronika', 'Mebel');
