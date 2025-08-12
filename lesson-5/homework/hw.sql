1. ProductName ustunini Nom sifatida o‘zgartirish (alias)

sql
Копировать
Редактировать
SELECT ProductName AS Nom
FROM Mahsulotlar;
2. Mijozlar jadvalini Mijoz sifatida alias qilish

sql
Копировать
Редактировать
SELECT *
FROM Mijozlar AS Mijoz;
3. UNION bilan ikkita jadvaldan mahsulot nomlarini birlashtirish

sql
Копировать
Редактировать
SELECT Mahsulot_nomi
FROM Mahsulotlar
UNION
SELECT Mahsulot_nomi
FROM Mahsulotlar_chegirmali;
4. INTERSECT bilan ikkala jadvaldagi umumiy mahsulotlar

sql
Копировать
Редактировать
SELECT Mahsulot_nomi
FROM Mahsulotlar
INTERSECT
SELECT Mahsulot_nomi
FROM Mahsulotlar_chegirmali;
5. SELECT DISTINCT bilan mijoz nomlari va davlat

sql
Копировать
Редактировать
SELECT DISTINCT Ism, Mamlakati
FROM Mijozlar;
6. CASE bilan narx darajasini belgilash

sql
Копировать
Редактировать
SELECT Mahsulot_nomi,
       Narxi,
       CASE
           WHEN Narxi > 1000 THEN 'Yuqori'
           ELSE 'Past'
       END AS Narx_Darajasi
FROM Mahsulotlar;
7. IIF bilan stok bo‘yicha mavjudlik

sql
Копировать
Редактировать
SELECT Mahsulot_nomi,
       IIF(Stok_miqdori > 100, 'Ha', 'Yo‘q') AS Mavjud
FROM Mahsulotlar_chegirmali;
O‘rta darajadagi vazifalar
8. UNION bilan "Sotuvda yo‘q" va "Mahsulotlar_chegirmali" birlashtirish

sql
Копировать
Редактировать
SELECT Mahsulot_nomi
FROM Sotuvda_yoq
UNION
SELECT Mahsulot_nomi
FROM Mahsulotlar_chegirmali;
9. EXCEPT bilan farqni ko‘rsatish

sql
Копировать
Редактировать
SELECT Mahsulot_nomi
FROM Mahsulotlar
EXCEPT
SELECT Mahsulot_nomi
FROM Mahsulotlar_chegirmali;
10. IIF bilan narxni "Qimmat" yoki "Arzon" deb belgilash

sql
Копировать
Редактировать
SELECT Mahsulot_nomi,
       IIF(Narxi > 1000, 'Qimmat', 'Arzon') AS Narx_Turi
FROM Mahsulotlar;
11. Yoshi < 25 yoki ish haqi > 60000 bo‘lgan xodimlar

sql
Копировать
Редактировать
SELECT *
FROM Xodimlar
WHERE Yoshi < 25 OR Ish_Haqi > 60000;
12. Ish haqini yangilash (UPDATE)

sql
Копировать
Редактировать
UPDATE Xodimlar
SET Ish_Haqi = Ish_Haqi * 1.10
WHERE Bolim = 'HR' OR EmployeeID = 5;
Qattiq darajadagi vazifalar
13. INTERSECT bilan umumiy mahsulotlar

sql
Копировать
Редактировать
SELECT Mahsulot_nomi
FROM Mahsulotlar
INTERSECT
SELECT Mahsulot_nomi
FROM Mahsulotlar_chegirmali;
14. Sotish summasiga qarab daraja (CASE)

sql
Копировать
Редактировать
SELECT SavdoID, Sotish_Summasi,
       CASE
           WHEN Sotish_Summasi > 500 THEN 'Yuqori daraja'
           WHEN Sotish_Summasi BETWEEN 200 AND 500 THEN 'O‘rta daraja'
           ELSE 'Past daraja'
       END AS Daraja
FROM Savdo;
15. EXCEPT bilan buyurtma berib, hisob-fakturasi bo‘lmagan mijozlar

sql
Копировать
Редактировать
SELECT MijozID
FROM Sotish
EXCEPT
SELECT MijozID
FROM Hisob_fakturalar;
16. Miqdorga qarab chegirma (CASE)

sql
Копировать
Редактировать
SELECT MijozID,
       Miqdori,
       CASE
           WHEN Miqdori = 1 THEN 0.03
           WHEN Miqdori BETWEEN 1 AND 3 THEN 0.05
           ELSE 0.07
       END AS ChegirmaFoizi
FROM Buyurtmalar;
