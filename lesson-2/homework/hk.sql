-- 1. Employees jadvalini yaratish
CREATE TABLE Employees (
    EmpID INT,
    Name VARCHAR(50),
    Salary DECIMAL(10,2)
);

-- 2. Bir qatorli INSERT INTO
INSERT INTO Employees (EmpID, Name, Salary)
VALUES (1, 'Ali Valiyev', 6500.00);

-- 3. Bir nechta qatorli INSERT INTO
INSERT INTO Employees (EmpID, Name, Salary)
VALUES 
(2, 'Dilshod Karimov', 7200.00),
(3, 'Malika Tursunova', 8000.00);

-- 4. Salary ni yangilash (EmpID = 1 bo‘lganda)
UPDATE Employees
SET Salary = 7000
WHERE EmpID = 1;

-- 5. EmpID = 2 bo‘lgan yozuvni o‘chirish
DELETE FROM Employees
WHERE EmpID = 2;

-- 6. DELETE, TRUNCATE, DROP farqi:
-- DELETE: Yozuvlarni o‘chiradi, lekin tuzilmani saqlaydi, WHERE ishlatish mumkin.
-- TRUNCATE: Jadvaldagi barcha yozuvlarni tezda o‘chiradi, tuzilma saqlanadi, WHERE ishlatib bo‘lmaydi.
-- DROP: Butun jadvalni (yozuvlar + tuzilma) o‘chiradi.

-- 7. Name ustunini VARCHAR(100) ga o‘zgartirish
ALTER TABLE Employees
ALTER COLUMN Name VARCHAR(100);

-- 8. Yangi ustun Department qo‘shish
ALTER TABLE Employees
ADD Department VARCHAR(50);

-- 9. Salary ustunini FLOAT ga o‘zgartirish
ALTER TABLE Employees
ALTER COLUMN Salary FLOAT;

-- 10. Departments jadvalini yaratish
CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(50)
);

-- 11. Employees jadvalidagi barcha yozuvlarni o‘chirish (tuzilmani saqlash)
TRUNCATE TABLE Employees;
-- 12. Departments jadvaliga qo‘lda 5 ta yozuv kiritish
INSERT INTO Departments (DepartmentID, DepartmentName)
VALUES
(1, 'Boshqaruv'),
(2, 'Marketing'),
(3, 'IT'),
(4, 'Moliyaviy bo‘lim'),
(5, 'Kadrlar bo‘limi');

-- 13. INSERT INTO SELECT yordamida yozuv kiritish
INSERT INTO Departments (DepartmentID, DepartmentName)
SELECT DepartmentID + 100, DepartmentName + ' - Yangi'
FROM Departments
WHERE DepartmentID <= 3;

-- 14. Salary > 5000 bo‘lgan xodimlarning Department ustunini "Boshqaruv" ga yangilash
UPDATE Employees
SET Department = 'Boshqaruv'
WHERE Salary > 5000;

-- 15. Employees jadvalidan barcha yozuvlarni o‘chirish (tuzilma saqlanadi)
TRUNCATE TABLE Employees;

-- 16. Employees jadvalidan Department ustunini o‘chirish
ALTER TABLE Employees
DROP COLUMN Department;

-- 17. Employees jadvalining nomini StaffMembers ga o‘zgartirish
EXEC sp_rename 'Employees', 'StaffMembers';

-- 18. Departments jadvalini butunlay o‘chirish
DROP TABLE Departments;
-- 19. Mahsulotlar jadvalini yaratish
CREATE TABLE Mahsulotlar (
    ProductID INT PRIMARY KEY,
    MahsulotNomi VARCHAR(50),
    Kategoriya VARCHAR(50),
    Narx DECIMAL(10,2) CHECK (Narx > 0),
    StockQuantity INT
);

-- 20. StockQuantity ustuniga DEFAULT 50 qiymatini berish
ALTER TABLE Mahsulotlar
ADD CONSTRAINT DF_StockQuantity DEFAULT 50 FOR StockQuantity;

-- 21. Kategoriya ustunini ProductCategory deb o‘zgartirish
EXEC sp_rename 'Mahsulotlar.Kategoriya', 'ProductCategory', 'COLUMN';

-- 22. Mahsulotlar jadvaliga 5 ta yozuv kiritish
INSERT INTO Mahsulotlar (ProductID, MahsulotNomi, ProductCategory, Narx, StockQuantity)
VALUES
(1, 'Kompyuter', 'Elektronika', 750.00, 100),
(2, 'Telefon', 'Elektronika', 500.00, 200),
(3, 'Printer', 'Ofis texnikasi', 300.00, 50),
(4, 'Stol', 'Mebel', 120.00, 150),
(5, 'Kreslo', 'Mebel', 90.00, 80);

-- 23. Products_Backup jadvalini SELECT INTO yordamida yaratish
SELECT * INTO Products_Backup
FROM Mahsulotlar;

-- 24. Mahsulotlar jadvalini Inventar deb o‘zgartirish
EXEC sp_rename 'Mahsulotlar', 'Inventar';

-- 25. Inventar jadvalidagi Narx ustunini FLOAT ga o‘zgartirish
ALTER TABLE Inventar
ALTER COLUMN Narx FLOAT;

-- 26. ProductCode IDENTITY ustunini qo‘shish (1000 dan boshlanadi, 5 ga ortadi)
ALTER TABLE Inventar
ADD ProductCode INT IDENTITY(1000,5);
-- 19. Mahsulotlar jadvalini yaratish
CREATE TABLE Mahsulotlar (
    ProductID INT PRIMARY KEY,
    MahsulotNomi VARCHAR(50),
    Kategoriya VARCHAR(50),
    Narx DECIMAL(10,2) CHECK (Narx > 0),
    StockQuantity INT
);

-- 20. StockQuantity ustuniga DEFAULT 50 qiymatini berish
ALTER TABLE Mahsulotlar
ADD CONSTRAINT DF_StockQuantity DEFAULT 50 FOR StockQuantity;

-- 21. Kategoriya ustunini ProductCategory deb o‘zgartirish
EXEC sp_rename 'Mahsulotlar.Kategoriya', 'ProductCategory', 'COLUMN';

-- 22. Mahsulotlar jadvaliga 5 ta yozuv kiritish
INSERT INTO Mahsulotlar (ProductID, MahsulotNomi, ProductCategory, Narx, StockQuantity)
VALUES
(1, 'Kompyuter', 'Elektronika', 750.00, 100),
(2, 'Telefon', 'Elektronika', 500.00, 200),
(3, 'Printer', 'Ofis texnikasi', 300.00, 50),
(4, 'Stol', 'Mebel', 120.00, 150),
(5, 'Kreslo', 'Mebel', 90.00, 80);

-- 23. Products_Backup jadvalini SELECT INTO yordamida yaratish
SELECT * INTO Products_Backup
FROM Mahsulotlar;

-- 24. Mahsulotlar jadvalini Inventar deb o‘zgartirish
EXEC sp_rename 'Mahsulotlar', 'Inventar';

-- 25. Inventar jadvalidagi Narx ustunini FLOAT ga o‘zgartirish
ALTER TABLE Inventar
ALTER COLUMN Narx FLOAT;

-- 26. ProductCode IDENTITY ustunini qo‘shish (1000 dan boshlanadi, 5 ga ortadi)
ALTER TABLE Inventar
ADD ProductCode INT IDENTITY(1000,5);
-- 19. Mahsulotlar jadvalini yaratish
CREATE TABLE Mahsulotlar (
    ProductID INT PRIMARY KEY,
    MahsulotNomi VARCHAR(50),
    Kategoriya VARCHAR(50),
    Narx DECIMAL(10,2) CHECK (Narx > 0),
    StockQuantity INT
);

-- 20. StockQuantity ustuniga DEFAULT 50 qiymatini berish
ALTER TABLE Mahsulotlar
ADD CONSTRAINT DF_StockQuantity DEFAULT 50 FOR StockQuantity;

-- 21. Kategoriya ustunini ProductCategory deb o‘zgartirish
EXEC sp_rename 'Mahsulotlar.Kategoriya', 'ProductCategory', 'COLUMN';

-- 22. Mahsulotlar jadvaliga 5 ta yozuv kiritish
INSERT INTO Mahsulotlar (ProductID, MahsulotNomi, ProductCategory, Narx, StockQuantity)
VALUES
(1, 'Kompyuter', 'Elektronika', 750.00, 100),
(2, 'Telefon', 'Elektronika', 500.00, 200),
(3, 'Printer', 'Ofis texnikasi', 300.00, 50),
(4, 'Stol', 'Mebel', 120.00, 150),
(5, 'Kreslo', 'Mebel', 90.00, 80);

-- 23. Products_Backup jadvalini SELECT INTO yordamida yaratish
SELECT * INTO Products_Backup
FROM Mahsulotlar;

-- 24. Mahsulotlar jadvalini Inventar deb o‘zgartirish
EXEC sp_rename 'Mahsulotlar', 'Inventar';

-- 25. Inventar jadvalidagi Narx ustunini FLOAT ga o‘zgartirish
ALTER TABLE Inventar
ALTER COLUMN Narx FLOAT;

-- 26. ProductCode IDENTITY ustunini qo‘shish (1000 dan boshlanadi, 5 ga ortadi)
ALTER TABLE Inventar
ADD ProductCode INT IDENTITY(1000,5);
