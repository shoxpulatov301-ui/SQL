1. Har bir toifadagi mahsulotlarning umumiy sonini topish

SELECT Toifasi, COUNT(*) AS Mahsulotlar_soni
FROM Mahsulotlar
GROUP BY Toifasi;


2. "Elektronika" toifasidagi mahsulotlarning o‘rtacha narxi

SELECT AVG(Narxi) AS O'rtacha_Narx
FROM Mahsulotlar
WHERE Toifasi = 'Elektronika';


3. "L" harfi bilan boshlangan shaharlardagi mijozlar

SELECT *
FROM Mijozlar
WHERE Shahar LIKE 'L%';


4. "er" bilan tugaydigan mahsulot nomlari

SELECT Mahsulot_nomi
FROM Mahsulotlar
WHERE Mahsulot_nomi LIKE '%er';


5. "A" bilan tugaydigan mamlakatlardagi mijozlar

SELECT *
FROM Mijozlar
WHERE Mamlakati LIKE '%A';


6. Eng yuqori narxdagi mahsulot

SELECT MAX(Narxi) AS Eng_yuqori_narx
FROM Mahsulotlar;


7. Zaxira yetarlilik belgisi

SELECT Mahsulot_nomi,
       CASE 
         WHEN Stok_miqdori < 30 THEN 'Kam'
         ELSE 'Etarli'
       END AS Zaxira_holati
FROM Mahsulotlar;


8. Har bir mamlakatdagi mijozlar soni

SELECT Mamlakati, COUNT(*) AS Mijozlar_soni
FROM Mijozlar
GROUP BY Mamlakati;


9. Buyurtma qilingan minimal va maksimal miqdor

SELECT MIN(Savdo_summasi) AS Min_summa,
       MAX(Savdo_summasi) AS Max_summa
FROM Sotuvlar;

O‘rta darajadagi vazifalar

10. 2023-yanvarda buyurtma qilgan, lekin schyot-fakturasi bo‘lmagan mijozlar

SELECT DISTINCT b.MijozID
FROM Buyurtmalar b
LEFT JOIN Schyot_fakturalar s ON b.BuyurtmaID = s.BuyurtmaID
WHERE s.BuyurtmaID IS NULL
  AND b.BuyurtmaSana BETWEEN '2023-01-01' AND '2023-01-31';


11. Mahsulotlar va Mahsulotlar_chegirmali — dublikatlar bilan

SELECT Mahsulot_nomi FROM Mahsulotlar
UNION ALL
SELECT Mahsulot_nomi FROM Mahsulotlar_chegirmali;


12. Mahsulotlar va Mahsulotlar_chegirmali — takroriylarsiz

SELECT Mahsulot_nomi FROM Mahsulotlar
UNION
SELECT Mahsulot_nomi FROM Mahsulotlar_chegirmali;


13. Yil bo‘yicha o‘rtacha buyurtma miqdori

SELECT YEAR(SaleSate) AS Yil, 
       AVG(Savdo_summasi) AS Ortacha_miqdor
FROM Sotuvlar
GROUP BY YEAR(SaleSate);


14. Mahsulotlarni narx guruhlari bo‘yicha ajratish

SELECT Mahsulot_nomi,
       CASE 
         WHEN Narxi < 100 THEN 'Past'
         WHEN Narxi BETWEEN 100 AND 500 THEN 'O‘rta'
         ELSE 'Yuqori'
       END AS Narx_guruhi
FROM Mahsulotlar;


15. Shahar_Aholisi — Pivot (yillar ustunlarda)

SELECT Shahar, 
       MAX(CASE WHEN Yil = 2012 THEN Aholi END) AS [2012],
       MAX(CASE WHEN Yil = 2013 THEN Aholi END) AS [2013]
INTO Aholi_yillik_yil
FROM Shahar_Aholisi
GROUP BY Shahar;


16. Har bir mahsulot identifikatori bo‘yicha jami sotish

SELECT MahsulotID, SUM(Savdo_summasi) AS Jami_savdo
FROM Sotuvlar
GROUP BY MahsulotID;


17. Nomida "oo" bo‘lgan mahsulotlar

SELECT Mahsulot_nomi
FROM Mahsulotlar
WHERE Mahsulot_nomi LIKE '%oo%';


18. Shahar_Aholisi — Pivot (shaharlar ustunlarda)

SELECT Yil, 
       MAX(CASE WHEN Shahar = 'Bektemir' THEN Aholi END) AS Bektemir,
       MAX(CASE WHEN Shahar = 'Chilonzor' THEN Aholi END) AS Chilonzor,
       MAX(CASE WHEN Shahar = 'Yakkasaroy' THEN Aholi END) AS Yakkasaroy
INTO Aholi_shahar_jadvali
FROM Shahar_Aholisi
GROUP BY Yil;

Qattiq darajadagi vazifalar

19. Eng ko‘p hisob-fakturaga ega 3 ta mijoz

SELECT TOP 3 CustomerID, SUM(TotalSent) AS Jami_summa
FROM Hisob_fakturalar
GROUP BY CustomerID
ORDER BY Jami_summa DESC;


20. Population_Har_Year → Shahar_Aholisi (unpivot)

SELECT Shahar, '2012' AS Yil, [2012] AS Aholi FROM Population_Har_Year
UNION ALL
SELECT Shahar, '2013', [2013] FROM Population_Har_Year;


21. Mahsulotlar va Savdo — necha marta sotilganini ko‘rsatish

SELECT m.Mahsulot_nomi, COUNT(s.SaleID) AS Sotilgan_marta
FROM Mahsulotlar m
JOIN Sotuvlar s ON m.ProductID = s.MahsulotID
GROUP BY m.Mahsulot_nomi;


22. Population_Each_City → City_Population (unpivot)

SELECT Yil, 'Bektemir' AS Shahar, Bektemir AS Aholi FROM Population_Each_City
UNION ALL
SELECT Yil, 'Chilonzor', Chilonzor FROM Population_Each_City
UNION ALL
SELECT Yil, 'Yakkasaroy', Yakkasaroy FROM Population_Each_City;
