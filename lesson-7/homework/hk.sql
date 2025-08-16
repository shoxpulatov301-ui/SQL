-- 1. Mahsulotlar jadvalidagi mahsulotning minimal (MIN) narxini topish
SELECT MIN(Narxi) AS MinimalNarx
FROM Mahsulotlar;

-- 2. Xodimlar jadvalidan maksimal (MAX) ish haqini topish
SELECT MAX(Ish_haqi) AS MaksimalIshHaqi
FROM Xodimlar;

-- 3. Mijozlar jadvalidagi qatorlar sonini hisoblash
SELECT COUNT(*) AS MijozlarSoni
FROM Mijozlar;

-- 4. Mahsulotlar jadvalidagi noyob mahsulot toifalari sonini hisoblash
SELECT COUNT(DISTINCT Toifasi) AS NoyobToifalar
FROM Mahsulotlar;

-- 5. Savdo jadvalida id = 7 bo'lgan mahsulotning umumiy sotilgan miqdorini topish
SELECT SUM(Miqdor) AS JamiSotilgan
FROM Savdo
WHERE ProductID = 7;

-- 6. Xodimlar jadvalida xodimlarning o'rtacha yoshini hisoblash
SELECT AVG(Yoshi) AS OrtachaYosh
FROM Xodimlar;

-- 7. Har bir bo'limdagi xodimlar soni
SELECT Bo'lim_nomi, COUNT(*) AS XodimlarSoni
FROM Xodimlar
GROUP BY Bo'lim_nomi;

-- 8. Har bir toifa bo‘yicha minimal va maksimal narx
SELECT Toifasi, MIN(Narxi) AS MinimalNarx, MAX(Narxi) AS MaksimalNarx
FROM Mahsulotlar
GROUP BY Toifasi;

-- 9. Savdo jadvalida har bir mijoz uchun jami sotuv
SELECT MijozID, SUM(Miqdor * Narx) AS JamiSavdo
FROM Savdo
JOIN Mahsulotlar ON Savdo.ProductID = Mahsulotlar.ProductID
GROUP BY MijozID;

-- 10. 5 dan ortiq xodimga ega bo‘limlarni filtrlash
SELECT Bo'lim_nomi, COUNT(*) AS XodimlarSoni
FROM Xodimlar
GROUP BY Bo'lim_nomi
HAVING COUNT(*) > 5;
-- 1. Har bir mahsulot toifasi uchun jami va o‘rtacha sotish
SELECT m.Toifasi, SUM(s.Miqdor * m.Narxi) AS JamiSavdo, AVG(s.Miqdor * m.Narxi) AS OrtachaSavdo
FROM Savdo s
JOIN Mahsulotlar m ON s.ProductID = m.ProductID
GROUP BY m.Toifasi;

-- 2. Kadrlar (HR) bo‘limi xodimlari soni
SELECT COUNT(*) AS HR_Xodimlari
FROM Xodimlar
WHERE Bo'lim_nomi = 'HR';

-- 3. Bo‘lim bo‘yicha eng yuqori va eng past ish haqi
SELECT Bo'lim_nomi, MIN(Ish_haqi) AS EngPast, MAX(Ish_haqi) AS EngYuqori
FROM Xodimlar
GROUP BY Bo'lim_nomi;

-- 4. Bo‘lim bo‘yicha o‘rtacha ish haqi
SELECT Bo'lim_nomi, AVG(Ish_haqi) AS OrtachaMaosh
FROM Xodimlar
GROUP BY Bo'lim_nomi;

-- 5. Har bir bo‘limda AVG va COUNT
SELECT Bo'lim_nomi, AVG(Ish_haqi) AS OrtachaMaosh, COUNT(*) AS XodimlarSoni
FROM Xodimlar
GROUP BY Bo'lim_nomi;

-- 6. O‘rtacha narxi 400 dan yuqori bo‘lgan mahsulot toifalari
SELECT Toifasi, AVG(Narxi) AS OrtachaNarx
FROM Mahsulotlar
GROUP BY Toifasi
HAVING AVG(Narxi) > 400;

-- 7. Har bir yil uchun jami sotuv
SELECT YEAR(Sana) AS Yil, SUM(Miqdor * Narx) AS JamiSavdo
FROM Savdo
JOIN Mahsulotlar ON Savdo.ProductID = Mahsulotlar.ProductID
GROUP BY YEAR(Sana);

-- 8. Kamida 3 ta buyurtma bergan mijozlar
SELECT MijozID, COUNT(*) AS BuyurtmalarSoni
FROM Savdo
GROUP BY MijozID
HAVING COUNT(*) >= 3;

-- 9. O‘rtacha ish haqi 60000 dan yuqori bo‘lgan bo‘limlar
SELECT Bo'lim_nomi, AVG(Ish_haqi) AS OrtachaMaosh
FROM Xodimlar
GROUP BY Bo'lim_nomi
HAVING AVG(Ish_haqi) > 60000;
-- 1. Har bir mahsulot toifasi uchun o‘rtacha narx, faqat 150 dan yuqori bo‘lsa
SELECT Toifasi, AVG(Narxi) AS OrtachaNarx
FROM Mahsulotlar
GROUP BY Toifasi
HAVING AVG(Narxi) > 150;

-- 2. Har bir mijoz uchun jami savdo, faqat 1500 dan yuqori bo‘lsa
SELECT s.MijozID, SUM(s.Miqdor * m.Narxi) AS JamiSavdo
FROM Savdo s
JOIN Mahsulotlar m ON s.ProductID = m.ProductID
GROUP BY s.MijozID
HAVING SUM(s.Miqdor * m.Narxi) > 1500;

-- 3. Bo‘lim bo‘yicha umumiy va o‘rtacha ish haqi, faqat 65000 dan yuqori bo‘lsa
SELECT Bo'lim_nomi, SUM(Ish_haqi) AS JamiMaosh, AVG(Ish_haqi) AS OrtachaMaosh
FROM Xodimlar
GROUP BY Bo'lim_nomi
HAVING AVG(Ish_haqi) > 65000;

-- 4. Har bir mijoz uchun $50 dan ortiq buyurtmalar bo‘yicha umumiy savdo
SELECT s.MijozID, SUM(s.Miqdor * m.Narxi) AS JamiSavdo, MIN(s.Miqdor * m.Narxi) AS EngKamXarid
FROM Savdo s
JOIN Mahsulotlar m ON s.ProductID = m.ProductID
WHERE s.Miqdor * m.Narxi > 50
GROUP BY s.MijozID;

-- 5. Har bir mijoz uchun eng kam xaridlari bilan birga $50 dan ortiq buyurtmalar
SELECT s.MijozID, SUM(s.Miqdor) AS JamiMiqdor, MIN(s.Miqdor) AS EngKamXarid
FROM Savdo s
JOIN Mahsulotlar m ON s.ProductID = m.ProductID
WHERE s.Miqdor * m.Narxi > 50
GROUP BY s.MijozID;

-- 6. Har yil va oy bo‘yicha jami sotuv va noyob mahsulotlar
SELECT YEAR(Sana) AS Yil, MONTH(Sana) AS Oy,
       SUM(s.Miqdor * m.Narxi) AS JamiSavdo,
       COUNT(DISTINCT s.ProductID) AS NoyobMahsulotlar
FROM Savdo s
JOIN Mahsulotlar m ON s.ProductID = m.ProductID
GROUP BY YEAR(Sana), MONTH(Sana)
HAVING COUNT(DISTINCT s.ProductID) >= 2;

-- 7. Yiliga MIN va MAX buyurtma miqdori
SELECT YEAR(Sana) AS Yil,
       MIN(Miqdor) AS EngKam,
       MAX(Miqdor) AS EngKo‘p
FROM Buyurtmalar
GROUP BY YEAR(Sana);
