1-daraja: Asosiy quyi so‘rovlar

1. Eng kam ish haqi bo'lgan xodimlarni toping

SELECT id, nomi, ish_haqi
FROM xodimlar
WHERE ish_haqi = (SELECT MIN(ish_haqi) FROM xodimlar);


2. O‘rtacha narxdan yuqori mahsulotlarni toping

SELECT id, mahsulot_nomi, narxi
FROM mahsulotlar
WHERE narxi > (SELECT AVG(narxi) FROM mahsulotlar);

2-daraja: Shartlar bilan ichki subquery

3. Savdo bo‘limida ishlaydigan xodimlar

SELECT x.id, x.nomi
FROM xodimlar x
WHERE x.departament_identifikatori = (
    SELECT id FROM bo'limlar WHERE bo'lim_nomi = 'Sotish'
);


4. Buyurtma bermagan mijozlar

SELECT m.customer_id, m.nomi
FROM mijozlar m
WHERE m.customer_id NOT IN (SELECT customer_id FROM buyurtmalar);

3-daraja: Subquery + Group By

5. Har bir kategoriyada eng qimmat mahsulot

SELECT m.id, m.mahsulot_nomi, m.narxi, m.kategoriya_id
FROM mahsulotlar m
WHERE m.narxi = (
    SELECT MAX(narxi)
    FROM mahsulotlar
    WHERE kategoriya_id = m.kategoriya_id
);


6. Bo‘limda eng yuqori o‘rtacha ish haqi olgan xodimlar

SELECT x.id, x.nomi, x.ish_haqi, x.departament_identifikatori
FROM xodimlar x
WHERE x.ish_haqi > (
    SELECT AVG(x2.ish_haqi)
    FROM xodimlar x2
    WHERE x2.departament_identifikatori = x.departament_identifikatori
);

4-daraja: Correlated subquery

7. O‘z bo‘limidagi o‘rtachadan yuqori maosh oladigan xodimlar

SELECT x.id, x.nomi, x.ish_haqi, x.departament_id
FROM xodimlar x
WHERE x.ish_haqi > (
    SELECT AVG(x2.ish_haqi)
    FROM xodimlar x2
    WHERE x2.departament_id = x.departament_id
);


8. Har bir kursda eng yuqori baho olgan talabalar

SELECT t.student_id, t.nomi, b.course_id, b.baho
FROM talabalar t
JOIN baholar b ON t.student_id = b.student_id
WHERE b.baho = (
    SELECT MAX(b2.baho)
    FROM baholar b2
    WHERE b2.course_id = b.course_id
);
