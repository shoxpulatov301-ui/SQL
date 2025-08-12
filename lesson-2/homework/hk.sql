-- Employees jadvalini yaratish
CREATE TABLE Employees (
    EmpID INT,
    Name VARCHAR(50),
    Salary DECIMAL(10,2)
);

-- Bir qatorli qo'shish
INSERT INTO Employees (EmpID, Name, Salary)
VALUES (1, 'Ali Valiyev', 6500.00);

-- Bir nechta qatorli qo'shish
INSERT INTO Employees (EmpID, Name, Salary)
VALUES 
(2, 'Dilshod Karimov', 7200.00),
(3, 'Malika Tursunova', 8000.00);

-- Salary yangilash (EmpID = 1)
UPDATE Employees
SET Salary = 7000
WHERE EmpID = 1;

-- EmpID = 2 yozuvini o'chirish
DELETE FROM Employees
WHERE EmpID = 2;

-- Name ustunini VARCHAR(100) ga o‘zgartirish
ALTER TABLE Employees
ALTER COLUMN Name VARCHAR(100);

-- Department ustunini qo‘shish
ALTER TABLE Employees
ADD Department VARCHAR(50);

-- Salary ustunini FLOAT ga o‘zgartirish
ALTER TABLE Employees
ALTER COLUMN Salary FLOAT;

-- Departments jadvalini yaratish
CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(50)
);

-- Employees jadvalidagi barcha yozuvlarni o‘chirish
TRUNCATE TABLE Employees;

-- Departments jadvaliga 5 ta yozuv kiritish
INSERT INTO Departments (DepartmentID, DepartmentName)
VALUES
(1, 'Boshqaruv'),
(2, 'Marketing'),
(3, 'IT'),
(4, 'Moliyaviy bo‘lim'),
(5, 'Kadrlar bo‘limi');

-- INSERT INTO SELECT yordamida yozuv qo'shish
INSERT INTO Departments (DepartmentID, DepartmentName)
SELECT DepartmentID + 100, DepartmentName + ' - Yangi'
FROM Departments
WHERE DepartmentID <= 3;

-- Employees jadvalini test uchun qayta to‘ldirish
INSERT INTO Employees (EmpID, Name, Salary, Department)
VALUES
(1, 'Ali Valiyev', 7000, NULL),
(3, 'Malika Tursunova', 8000, NULL);

-- Salary > 5000 bo‘lgan xodimlarga Department = 'Boshqaruv'
UPDATE Employees
SET Department = 'Boshqaruv'
WHERE Salary > 5000;

-- Employees jadvalidagi barcha yozuvlarni o‘chirish
TRUNCATE TABLE Employees;

-- Department ustunini o‘chirish
ALTER TABLE Employees
DROP COLUMN Department;

-- Employees jadvalining nomini StaffMembers ga o‘zgartirish
EXEC sp_rename 'Employees', 'StaffMembers';

-- Departments jadvalini o‘chirish
DROP TABLE Departments;
-- Mahsulotlar jadvalini yaratish
CREATE TABLE Mahsulotlar (
    ProductID INT PRIMARY KEY,
    MahsulotNomi VARCHAR(50),
    Kategoriya VARCHAR(50),
    Narx DECIMAL(10,2) CHECK (Narx > 0),
    StockQuantity INT
);

-- StockQuantity ustuniga DEFAULT 50 qiymatini berish
ALTER TABLE Mahsulotlar
ADD CONSTRAINT DF_StockQuantity DEFAULT 50 FOR StockQuantity;

-- Kategoriya ustunini ProductCategory deb o‘zgartirish
EXEC sp_rename 'Mahsulotlar.Kategoriya', 'ProductCategory', 'COLUMN';

-- 5 ta yozuv kiritish
INSERT INTO Mahsulotlar (ProductID, MahsulotNomi, ProductCategory, Narx, StockQuantity)
VALUES
(1, 'Kompyuter', 'Elektronika', 750.00, 100),
(2, 'Telefon', 'Elektronika', 500.00, 200),
(3, 'Printer', 'Ofis texnikasi', 300.00, 50),
(4, 'Stol', 'Mebel', 120.00, 150),
(5, 'Kreslo', 'Mebel', 90.00, 80);

-- Zaxira jadvalini yaratish
SELECT * INTO Products_Backup
FROM Mahsulotlar;

-- Mahsulotlar jadvalini Inventar deb o‘zgartirish
EXEC sp_rename 'Mahsulotlar', 'Inventar';

-- Narx ustunini FLOAT ga o‘zgartirish
ALTER TABLE Inventar
ALTER COLUMN Narx FLOAT;

-- ProductCode IDENTITY ustunini qo‘shish
ALTER TABLE Inventar
ADD ProductCode INT IDENTITY(1000,5);
