✅ Oson savollar
1️⃣ Har bir mijozga to‘g‘ri keladigan jami sotishni hisoblash
SELECT customer_id, mijoz_nomi, SUM(jami_summa) AS jami_sotuv
FROM sales_data
GROUP BY customer_id, mijoz_nomi;

2️⃣ Mahsulot toifasi uchun buyurtmalar sonini hisoblash
SELECT mahsulot_toifasi, COUNT(*) AS buyurtmalar_soni
FROM sales_data
GROUP BY mahsulot_toifasi;

3️⃣ Mahsulot toifasi uchun maksimal umumiy miqdorni topish
SELECT mahsulot_toifasi, MAX(sotilgan_miqdori) AS max_miqdor
FROM sales_data
GROUP BY mahsulot_toifasi;

4️⃣ Mahsulot toifasidagi mahsulotlarning minimal narxi
SELECT mahsulot_toifasi, MIN(birik_narxi) AS min_narx
FROM sales_data
GROUP BY mahsulot_toifasi;

5️⃣ 3 kunlik harakatlanuvchi o‘rtacha sotuv
SELECT 
    order_date,
    AVG(jami_summa) OVER(
        ORDER BY order_date
        ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING
    ) AS moving_avg_3days
FROM sales_data;

6️⃣ Hudud bo‘yicha jami savdo
SELECT hududi, SUM(jami_summa) AS jami_sotuv
FROM sales_data
GROUP BY hududi;

7️⃣ Xaridorlarning umumiy xarid miqdori bo‘yicha reytingi
SELECT customer_id, mijoz_nomi,
       SUM(jami_summa) AS jami_sotuv,
       RANK() OVER(ORDER BY SUM(jami_summa) DESC) AS reyting
FROM sales_data
GROUP BY customer_id, mijoz_nomi;

8️⃣ Har bir mijoz uchun joriy va oldingi savdo summasi farqi
SELECT customer_id, mijoz_nomi, order_date, jami_summa,
       LAG(jami_summa) OVER(PARTITION BY customer_id ORDER BY order_date) AS oldingi,
       jami_summa - LAG(jami_summa) OVER(PARTITION BY customer_id ORDER BY order_date) AS farq
FROM sales_data;

9️⃣ Har bir toifadagi eng qimmat 3 ta mahsulot
SELECT *
FROM (
    SELECT mahsulot_toifasi, mahsulot_nomi, birlik_narxi,
           ROW_NUMBER() OVER(PARTITION BY mahsulot_toifasi ORDER BY birlik_narxi DESC) AS rn
    FROM sales_data
) t
WHERE rn <= 3;

🔟 Mintaqa bo‘yicha sanalar kesimida jami sotuv
SELECT hududi, order_date, SUM(jami_summa) AS jami_sotuv
FROM sales_data
GROUP BY hududi, order_date
ORDER BY hududi, order_date;

✅ O‘rta savollar
1️⃣ Mahsulot toifasi bo‘yicha jami daromad
SELECT mahsulot_toifasi, SUM(jami_summa) AS jami_daromad
FROM sales_data
GROUP BY mahsulot_toifasi;

2️⃣ Oldingi qiymatlarning yig‘indisi (OneColumn misoli)
SELECT Qiymati,
       SUM(Qiymati) OVER(ORDER BY Qiymati ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS SumPreValues
FROM OneColumn;

3️⃣ Har bir bo‘lim uchun qator raqami toqdan boshlanishi
SELECT Ident, Vals,
       ROW_NUMBER() OVER(ORDER BY Ident, Vals) * 2 - 1 AS RowNumber
FROM Qator_raqamlari;

4️⃣ Bir nechta mahsulot kategoriyasidan xarid qilgan mijozlar
SELECT customer_id, mijoz_nomi
FROM sales_data
GROUP BY customer_id, mijoz_nomi
HAVING COUNT(DISTINCT mahsulot_toifasi) > 1;

5️⃣ O‘z mintaqasida o‘rtachadan yuqori xarajat qilgan mijozlar
SELECT s.customer_id, s.mijoz_nomi, s.hududi, SUM(s.jami_summa) AS jami_xarajat
FROM sales_data s
GROUP BY s.customer_id, s.mijoz_nomi, s.hududi
HAVING SUM(s.jami_summa) > (
    SELECT AVG(jami_summa) FROM sales_data WHERE hududi = s.hududi
);

✅ Qiyin savollar
1️⃣ Narxi o‘rtacha narxdan yuqori bo‘lgan mahsulotlar
SELECT mahsulot_nomi, birlik_narxi
FROM sales_data
WHERE birlik_narxi > (SELECT AVG(birik_narxi) FROM sales_data);

2️⃣ Guruh boshiga umumiy yig‘indi chiqarish (MyData)
SELECT Id, Grp, Val1, Val2,
       CASE WHEN ROW_NUMBER() OVER(PARTITION BY Grp ORDER BY Id) = 1
            THEN SUM(Val1+Val2) OVER(PARTITION BY Grp)
       END AS Tot
FROM MyData;

3️⃣ TheSumPuzzle yechimi
SELECT Id, SUM(Xarajat) AS Cost, SUM(Miqdor) AS Quantity
FROM TheSumPuzzle
GROUP BY Id;

4️⃣ O‘rindiqlar bo‘sh joy oralig‘ini topish
WITH all_numbers AS (
    SELECT TOP 100 ROW_NUMBER() OVER(ORDER BY (SELECT NULL)) AS n
    FROM master.dbo.spt_values
)
SELECT MIN(n) AS GapStart, MAX(n) AS GapEnd
FROM all_numbers
WHERE n NOT IN (SELECT Orindiq_raqami FROM Orindiqlar)
GROUP BY DATEDIFF(DAY, 0, n - ROW_NUMBER() OVER(ORDER BY n));

