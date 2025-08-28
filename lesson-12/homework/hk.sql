1. Ikki jadvalni birlashtirish (Person va Address)
SELECT 
    p.firstName,
    p.lastName,
    a.city,
    a.state
FROM Person p
LEFT JOIN Address a
    ON p.personId = a.personId;

2. Menejeridan ko‘proq maosh oladigan xodimlar
SELECT e.name AS Employee
FROM Employee e
JOIN Employee m
    ON e.managerId = m.id
WHERE e.salary > m.salary;

3. Ikki nusxadagi elektron pochta xabarlari (dupes)
SELECT email
FROM Person
GROUP BY email
HAVING COUNT(*) > 1;

4. Takroriy e-pochta yozuvlarini o‘chirish
DELETE p
FROM Person p
JOIN Person q
    ON p.email = q.email
   AND p.id > q.id;

5. Faqat qizlari bor ota-onalar
SELECT DISTINCT g.parentName
FROM Girls g
WHERE g.parentName NOT IN (
    SELECT b.parentName FROM Boys b
);

6. Jami 50 dan ortiq va eng kam (Sales.Orders)
SELECT 
    customerid,
    SUM(salesamount) AS TotalSales,
    MIN(weight) AS MinWeight
FROM Sales.Orders
WHERE weight > 50
GROUP BY customerid;

7. Aravalar (Cart1 va Cart2 UNION FULL JOIN)
SELECT 
    c1.Item AS [Item Cart 1],
    c2.Item AS [Item Cart 2]
FROM Cart1 c1
FULL OUTER JOIN Cart2 c2
    ON c1.Item = c2.Item;

8. Gugurtlar (Winner or Draw)
SELECT 
    MatchID,
    Match,
    Score,
    CASE 
        WHEN CAST(LEFT(Score, CHARINDEX(':', Score)-1) AS INT) 
           > CAST(RIGHT(Score, LEN(Score)-CHARINDEX(':', Score)) AS INT)
             THEN LEFT(Match, CHARINDEX('-', Match)-1)
        WHEN CAST(LEFT(Score, CHARINDEX(':', Score)-1) AS INT) 
           < CAST(RIGHT(Score, LEN(Score)-CHARINDEX(':', Score)) AS INT)
             THEN RIGHT(Match, LEN(Match)-CHARINDEX('-', Match))
        ELSE 'Draw'
    END AS Result
FROM match1;

98. Hech qachon buyurtma bermagan mijozlar
SELECT c.name AS Customers
FROM Customers c
LEFT JOIN Orders o
    ON c.id = o.customerId
WHERE o.id IS NULL;

109. Talabalar va imtihonlar (cross join + count)
SELECT 
    s.student_id,
    s.student_name,
    sub.subject_name,
    COUNT(e.subject_name) AS attended_exams
FROM Students s
CROSS JOIN Subjects sub
LEFT JOIN Exams e
    ON s.student_id = e.student_id
   AND sub.subject_name = e.subject_name
GROUP BY s.student_id, s.student_name, sub.subject_name
ORDER BY s.student_id, sub.subject_name;
