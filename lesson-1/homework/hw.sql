1

1. Ma'lumotlar (Data)
Ma'lumotlar — bu faktlar, raqamlar, so‘zlar, belgilar yoki kuzatuvlar ko‘rinishidagi xom (hali qayta ishlanmagan) axborotlardir.
Masalan: "Ali", "25", "Toshkent", "100$", "2025-08-04" kabi qiymatlar ma'lumot hisoblanadi.

2. Ma'lumotlar bazasi (Database)
Ma'lumotlar bazasi — bu ko‘p miqdordagi o‘zaro bog‘langan ma'lumotlarni tartib bilan saqlash, boshqarish va izlab topish imkonini beruvchi tizimdir.
Oddiy tushuntirish: Ma'lumotlarni kompyuterda to‘plab, kerakli vaqtda topish va ishlatish uchun saqlanadigan joy.

Masalan: Kutubxona katalogi (kitoblar haqida ma'lumotlar), mijozlar ro‘yxati, talabalar baholari.
3. Relyatsion ma'lumotlar bazasi (Relational Database)
Relyatsion ma'lumotlar bazasi — bu ma'lumotlarni jadvallar ko‘rinishida saqlovchi va ular o‘rtasidagi bog‘lanishlarni aloqa (relyatsiya) orqali tashkil etuvchi ma'lumotlar bazasidir.
Masalan:

Bitta jadvalda talabalar ismi va ID raqami bo‘lsa,

Ikkinchi jadvalda baholar va talabalar ID raqami bo‘lishi mumkin.
Bu ikki jadval ID orqali bir-biriga bog‘langan bo‘ladi.

4. Jadval (Table)
Jadval — relyatsion ma'lumotlar bazasidagi asosiy element bo‘lib, qatordan (yani yozuvlardan) va ustunlardan (maydonlardan) tashkil topgan.
Har bir jadval biror mavzuga oid ma'lumotlarni tartibli saqlaydi.

Masalan – Talabalar jadvali:
| ID | Ismi  | Yoshi |
| -- | ----- | ----- |
| 1  | Ali   | 20    |
| 2  | Laylo | 19    |


2

1. Ma'lumotlarni ishonchli saqlash va boshqarish
SQL Server katta hajmdagi ma'lumotlarni xavfsiz, ishonchli va samarali tarzda saqlashga imkon beradi. Foydalanuvchilar ma'lumotlarni qo‘shish, o‘zgartirish, o‘chirish va izlash amallarini bajarishlari mumkin.

2. Relyatsion ma'lumotlar bazasi tizimi (RDBMS)
SQL Server relyatsion tizim bo‘lib, ma'lumotlarni jadvallar ko‘rinishida tashkil qiladi va ular o‘rtasidagi bog‘lanishlarni qo‘llab-quvvatlaydi (foreign key, primary key orqali).

3. Transaktsiyalarni qo‘llab-quvvatlash
SQL Server ACID tamoyillari asosida ishlaydi:

Atomicity,

Consistency,

Isolation,

Durability.
Bu esa ma'lumotlar ustida ishonchli va to‘liq bajariladigan operatsiyalarni ta’minlaydi.

4. Xavfsizlik va foydalanuvchi nazorati
SQL Server foydalanuvchilarni ro‘yxatdan o‘tkazish, rollar berish va ruxsatlarni sozlash orqali ma'lumotlar xavfsizligini ta’minlaydi. Keraksiz shaxslardan ma'lumotlar himoyalanadi.

5. Analitik va hisobot imkoniyatlari (Reporting & BI)
SQL Serverda SQL Server Reporting Services (SSRS) va SQL Server Analysis Services (SSAS) kabi xizmatlar orqali tahlil va hisobotlar tayyorlash mumkin. Bu esa biznes qarorlar qabul qilishda foydali bo‘ladi.

3 

SQL Server'ga ulanishda quyidagi ikki asosiy autentifikatsiya (foydalanuvchini tekshirish) usuli mavjud:

1. Windows autentifikatsiyasi (Windows Authentication)
Bu usulda foydalanuvchi Windows operatsion tizimidagi login ma’lumotlari orqali SQL Serverga ulanadi.

Tizim foydalanuvchining Windows hisobini avtomatik tan oladi.

Kerakli ruxsatlar Active Directory orqali beriladi.

Eng xavfsiz hisoblanadi, chunki parol tizim tomonidan boshqariladi.

 Afzalligi: Foydalanuvchiga parol kiritish shart emas, xavfsizlik yuqori.

2. SQL Server autentifikatsiyasi (SQL Server Authentication)
Bu usulda foydalanuvchi SQL Server ichida ro‘yxatdan o‘tgan foydalanuvchi nomi (login) va parol orqali tizimga ulanadi.

Foydalanuvchi nomi va parol faqat SQL Server uchun alohida yaratiladi.

Har bir foydalanuvchiga individual login-parol berilishi mumkin.

Afzalligi: Windows tizimiga ulanmagan foydalanuvchilar ham kirish huquqiga ega bo‘ladi (masalan, boshqa tarmoqdan).

 Qo‘shimcha:
SQL Server’da Mixed Mode rejimi ham mavjud bo‘lib, u ikkala usulni (Windows + SQL autentifikatsiyasi) birgalikda qo‘llab-quvvatlaydi.

4

SQL Server Management Studio (SSMS) dasturida SchoolDB nomli yangi ma'lumotlar bazasini yaratish uchun quyidagi usullardan birini tanlashingiz mumkin:

 1-usul: Graﬁk interfeys orqali yaratish (GUI)
SSMS dasturini oching.

Chap tomondagi Object Explorer oynasida SQL Server'ga ulaning.

Databases bo‘limini sichqonchaning o‘ng tugmasi bilan bosing.

New Database... ni tanlang.

Database name maydoniga: SchoolDB deb yozing.

Quyidagi sozlamalar o‘zgarishsiz qolsa ham bo‘ladi.

OK tugmasini bosing.

 Endi SchoolDB nomli ma'lumotlar bazasi yaratildi.

 2-usul: SQL buyrug‘i orqali yaratish
Agar siz bu ishni SQL kod yordamida qilmoqchi bo‘lsangiz, quyidagi kodni New Query oynasida yozing va bajaring:

sql
Копировать
Редактировать
CREATE DATABASE SchoolDB;
 So‘ng F5 tugmasini bosing yoki Execute tugmasini bosing.

 5
 Quyidagi SQL so‘rovi yordamida Talabalar nomli jadvalni yaratishingiz mumkin. Jadvalda quyidagi ustunlar bo‘ladi:

StudentID — butun son (INT), asosiy kalit (PRIMARY KEY)

Ism — maksimal uzunligi 50 belgidan iborat matn (VARCHAR(50))

Age — butun son (INT)

 SQL so‘rovi:
sql
Копировать
Редактировать
CREATE TABLE Talabalar (
    StudentID INT PRIMARY KEY,
    Ism VARCHAR(50),
    Age INT
);
 Bajaring:
SSMS (SQL Server Management Studio) dasturida SchoolDB bazasini tanlang.

New Query tugmasini bosing.

Yuqoridagi kodni oynaga kiriting.

Execute (F5) tugmasini bosing.

 Agar hech qanday xato chiqmasa, Talabalar jadvali muvaffaqiyatli yaratildi.

Agar bu jadvalga ma'lumot qo‘shmoqchi bo‘lsangiz, quyidagicha INSERT so‘rovidan foydalanishingiz mumkin:

sql

INSERT INTO Talabalar (StudentID, Ism, Age)
VALUES (1, 'Ali', 20);

6
SQL Server
Bu ma’lumotlar bazasi boshqaruv tizimi (DBMS) bo‘lib, Microsoft tomonidan ishlab chiqilgan.

Unda ma’lumotlarni saqlash, boshqarish, qayta ishlash, qidirish, zaxiralash kabi vazifalar bajariladi.

Aslida bu server dasturi bo‘lib, kompyuter yoki tarmoqda xizmat ko‘rsatadi.

Misol: Siz barcha talabalar ro‘yxatini, ularning baholarini, o‘qituvchilar jadvalini va boshqalarni SQL Server ichida saqlaysiz
SSMS (SQL Server Management Studio)
Bu SQL Server bilan ishlash uchun yaratilgan grafikli (GUI) dastur.

Unda kod yozish, ma’lumotlarni ko‘rish, jadval tuzish, foydalanuvchilar yaratish, zaxira olish kabi barcha amallarni qulay grafik interfeys orqali bajarish mumkin.

SSMS o‘zi ma’lumotlarni saqlamaydi, balki SQL Server bilan bog‘lanib ishlaydi.

Misol: SSMS — bu sizning qo‘lingizdagi pult, SQL Server — uning boshqaradigan asboblari.
SQL (Structured Query Language)
Bu so‘rovlar yozish uchun dasturlash tili.

SQL tili yordamida siz ma’lumotlarni qo‘shasiz, o‘chirasiz, tahrirlaysiz va qidirasiz.

SQL Server ham aynan shu SQL tilini tushunadi va bajaradi.

Misol:

SELECT * FROM Talabalar
bu SQL buyrug‘i.

Bu buyruq SSMS orqali yoziladi va SQL Serverga yuboriladi, natijani qaytaradi.

 1. DQL – Data Query Language (Ma'lumotni so‘rash tili)
👉 Ma’lumotlarni bazadan so‘rash (tanlash) uchun ishlatiladi.

🔹 Asosiy buyruq:
SELECT – ma’lumotni jadvaldan olish

🧩 Misol:
sql
Копировать
Редактировать
SELECT Ism, Age FROM Talabalar WHERE Age > 18;
➡ Talabalar jadvalidan yoshi 18 dan katta bo‘lganlarning ismi va yoshini ko‘rsatadi.

✅ 2. DML – Data Manipulation Language (Ma’lumotlar bilan ishlash tili)
👉 Ma’lumot qo‘shish, o‘zgartirish va o‘chirish uchun ishlatiladi.

🔹 Asosiy buyruqlar:
INSERT – yangi yozuv qo‘shish

UPDATE – mavjud yozuvni yangilash

DELETE – yozuvni o‘chirish

🧩 Misollar:
sql
Копировать
Редактировать
INSERT INTO Talabalar (StudentID, Ism, Age) VALUES (1, 'Ali', 20);

UPDATE Talabalar SET Age = 21 WHERE StudentID = 1;

DELETE FROM Talabalar WHERE StudentID = 1;
✅ 3. DDL – Data Definition Language (Ma’lumotlar tuzilmasini yaratish tili)
👉 Jadval va bazaning tuzilmasini yaratish yoki o‘zgartirish uchun ishlatiladi.

🔹 Asosiy buyruqlar:
CREATE – yangi obyekt yaratish (jadval, baza)

ALTER – mavjud obyektni o‘zgartirish

DROP – obyektni o‘chirish

🧩 Misollar:
sql
Копировать
Редактировать
CREATE TABLE Talabalar (
    StudentID INT PRIMARY KEY,
    Ism VARCHAR(50),
    Age INT
);

ALTER TABLE Talabalar ADD Telefon VARCHAR(15);

DROP TABLE Talabalar;
✅ 4. DCL – Data Control Language (Ma’lumotlarga ruxsatni boshqarish tili)
👉 Foydalanuvchilarga ruxsat berish yoki olib tashlash uchun ishlatiladi.

🔹 Asosiy buyruqlar:
GRANT – ruxsat berish

REVOKE – ruxsatni bekor qilish

🧩 Misollar:
sql
Копировать
Редактировать
GRANT SELECT, INSERT ON Talabalar TO Foydalanuvchi1;

REVOKE INSERT ON Talabalar FROM Foydalanuvchi1;
✅ 5. TCL – Transaction Control Language (Tranzaksiyani boshqarish tili)
👉 DML buyruqlari orqali bajarilgan amallarni yakunlash yoki bekor qilish uchun ishlatiladi.

🔹 Asosiy buyruqlar:
COMMIT – tranzaksiyani saqlash

ROLLBACK – tranzaksiyani bekor qilish

BEGIN TRANSACTION – tranzaksiyani boshlash

🧩 Misollar:
sql
Копировать
Редактировать
BEGIN TRANSACTION;

UPDATE Talabalar SET Age = 25 WHERE StudentID = 2;

COMMIT;
⤷ Agar xatolik bo‘lsa:

sql
Копировать
Редактировать
ROLLBACK;
📌 Xulosa jadvali:
Kategoriya	Maqsad	Asosiy buyruqlar
DQL	Ma’lumotni so‘rash	SELECT
DML	Ma’lumot ustida amal	INSERT, UPDATE, DELETE
DDL	Tuzilma yaratish yoki o‘zgartirish	CREATE, ALTER, DROP
DCL	Ruxsat berish va boshqarish	GRANT, REVOKE
TCL	Tranzaksiyani boshqarish	BEGIN, COMMIT, ROLLBACK
INSERT INTO Talabalar (StudentID, Ism, Age)
VALUES
    (1, 'Ali', 20),
    (2, 'Laylo', 19),
    (3, 'Jasur', 21);
