SQL Server’da BULK INSERT buyrug‘i katta hajmdagi tashqi fayldagi (odatda .txt, .csv) ma’lumotlarni to‘g‘ridan-to‘g‘ri SQL jadvaliga yuklash (import qilish) uchun ishlatiladi. Bu usul ma’lumotlarni qo‘lda kiritishga qaraganda tezroq va samaraliroq.
BULK INSERT JadvalNomi
FROM 'C:\fayl_yoli\malumotlar.csv'
WITH (
    FIELDTERMINATOR = ',',  
    ROWTERMINATOR = '\n',
    FIRSTROW = 2
);
| Parametr          | Tavsifi                                                                   |
| ----------------- | ------------------------------------------------------------------------- |
| `FROM`            | Faylning to‘liq yo‘li                                                     |
| `FIELDTERMINATOR` | Ustunlar orasidagi ajratuvchi belgini bildiradi (masalan: `,`, `;`, `\t`) |
| `ROWTERMINATOR`   | Har bir satr oxiridagi belgini bildiradi (odatda `\n`)                    |
| `FIRSTROW`        | Fayldagi qaysi qatordan boshlab import qilish kerakligini ko‘rsatadi      |
Fayl serverda joylashgan bo‘lishi kerak (odatda SQL Server joylashgan kompyuterda).

SQL Server bu faylga o‘qish huquqiga ega bo‘lishi zarur.

Format xatolari bo‘lsa import amalga oshmasligi mumkin.
SQL Server’ga ma’lumotlarni import qilish uchun foydalaniladigan to‘rtta asosiy fayl formati quyidagilardir:

✅ 1. CSV (Comma-Separated Values) fayl
Tavsif: Har bir satr bitta yozuv, ustunlar esa vergul bilan ajratilgan bo‘ladi.

Kengaytma: .csv

Misol:

Копировать
Редактировать
1,Ali,25
2,Vali,30
Ko‘p ishlatiladi, ayniqsa Excel yoki boshqa dasturlardan eksport qilingan fayllar uchun.

✅ 2. TXT (Text) fayl
Tavsif: Oddiy matn fayli bo‘lib, ustunlar odatda maxsus belgilar (masalan, tab \t, nuqta-vergul ;) bilan ajratiladi.

Kengaytma: .txt

Misol:

Копировать
Редактировать
1   Ali   25
2   Vali  30
Bu fayl formatida FIELDTERMINATOR ni aniqlab berish kerak.

✅ 3. XML (eXtensible Markup Language) fayl
Tavsif: Tuzilgan (strukturali) ma’lumotlarni saqlash uchun ishlatiladi.

Kengaytma: .xml

SQL Server OPENXML, XML datatype, yoki BULK INSERT bilan XML formatini o‘qiy oladi.

Misol:

xml
Копировать
Редактировать
<Employees>
  <Employee>
    <ID>1</ID>
    <Name>Ali</Name>
    <Age>25</Age>
  </Employee>
</Employees>
✅ 4. JSON (JavaScript Object Notation) fayl
Tavsif: Yengil va o‘qilishi oson ma’lumot almashish formati.

Kengaytma: .json

SQL Server 2016 va undan keyingi versiyalarda OPENJSON, JSON_VALUE kabi funksiyalar yordamida o‘qiladi.

Misol:

json
Копировать
Редактировать
[
  {"ID": 1, "Name": "Ali", "Age": 25},
  {"ID": 2, "Name": "Vali", "Age": 30}
]

CREATE TABLE Mahsulotlar (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(50),
    Narx DECIMAL(10,2)
);
ProductID INT PRIMARY KEY – bu ustun butun son turida va asosiy kalit (PRIMARY KEY) sifatida belgilangan (ya'ni unikal va NULL bo‘lmaydi).

ProductName VARCHAR(50) – bu ustun nomlarni saqlaydi, maksimal 50 ta belgi uzunlikda.

Narx DECIMAL(10,2) – 10 xonali son bo‘lib, ulardan 2 tasi verguldan keyingi kasr qismini bildiradi (masalan: 12345.67).
INSERT INTO Mahsulotlar (ProductID, ProductName, Narx)
VALUES 
(1, 'Olma', 4500.00),
(2, 'Banan', 7200.50),
(3, 'Anor', 9800.75);
SELECT * FROM Mahsulotlar;
ProductID — mahsulot identifikatori (har bir mahsulot uchun unikal).

ProductName — mahsulot nomi (Olma, Banan, Anor).

Narx — mahsulot narxi so‘mda, kasr qismini ham oladi (DECIMAL(10,2) formati uchun mos).
SQL’da NULL va NOT NULL — ustunlarda qiymatning mavjud yoki mavjud emasligini bildiruvchi muxtojlik (mavjudlik) cheklovlari hisoblanadi.
| Tavsif                    | `NULL`                      | `NOT NULL`                    |
| ------------------------- | --------------------------- | ----------------------------- |
| Qiymat mavjudligi         | Bo‘lishi shart emas         | Albatta qiymat bo‘lishi kerak |
| Bo‘sh qoldirish mumkinmi? | Ha                          | Yo‘q                          |
| Standart holat            | Ma’lumot noma’lum           | Majburiy ma’lumot             |
| SQLda qo‘llanishi         | `Familiya VARCHAR(50) NULL` | `Ism VARCHAR(50) NOT NULL`    |

ALTER TABLE Mahsulotlar
ADD CONSTRAINT uq_ProductName UNIQUE (ProductName);
CREATE TABLE Mahsulotlar (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(50) UNIQUE,
    Narx DECIMAL(10,2)
);
SELECT ProductName, COUNT(*)
FROM Mahsulotlar
GROUP BY ProductName
HAVING COUNT(*) > 1;

SQL so‘roviga izoh (kommentariya) yozish — kodni tushunarli qilish va so‘rovning maqsadini hujjatlashtirish uchun ishlatiladi. Bu dasturchilar va ma’lumotlar bazasi bilan ishlovchilar uchun juda foydali.

✅ SQL so‘roviga izoh yozishning ikki turi mavjud:
1. Bir qatorda izoh yozish (--)
sql
Копировать
Редактировать
-- Bu so‘rov Mahsulotlar jadvalidan barcha ma’lumotlarni olib keladi
SELECT * FROM Mahsulotlar;
-- belgisi bilan boshlangan joydan boshlab qatordagi qolgan matn izoh sifatida qaraladi va bajarilmaydi.

2. Ko‘p qatorli izoh (/* ... */)
sql
Копировать
Редактировать
/*
  Quyidagi so‘rov narxi 5000 so‘mdan katta bo‘lgan mahsulotlarni tanlaydi
  Natijada ProductName va Narx ustunlari ko‘rsatiladi
*/
SELECT ProductName, Narx
FROM Mahsulotlar
WHERE Narx > 5000;
/* va */ oralig‘idagi matn izoh hisoblanadi, bir necha qatorda yozish mumkin.

🔒 Izohlar bajarilmaydi:
Izohlar SQL Server tomonidan e’tiborga olinmaydi, ya’ni ular kodni bajarmaydi, faqat tushuntirish vazifasini bajaradi.

Mahsulotlar jadvaliga yangi ustun — CategoryID ni qo‘shish uchun quyidagi ALTER TABLE buyrug‘idan foydalanasiz:

✅ SQL buyrug‘i:
sql
Копировать
Редактировать
ALTER TABLE Mahsulotlar
ADD CategoryID INT;
🧾 Izoh:
Bu buyruq Mahsulotlar jadvaliga CategoryID nomli yangi ustunni qo‘shadi.

Ustun turi — INT (butun son).

NULL qiymatga ruxsat bor (agar siz NOT NULL deb ko‘rsatmasangiz).

✏️ Agar bu ustun boshqa jadval bilan chet kalit (FOREIGN KEY) sifatida bog‘lanadigan bo‘lsa (masalan, Kategoriyalar jadvali bilan), shunday tarzda qo‘shiladi:
sql
Копировать
Редактировать
ALTER TABLE Mahsulotlar
ADD CategoryID INT;

ALTER TABLE Mahsulotlar
ADD CONSTRAINT fk_CategoryID FOREIGN KEY (CategoryID) REFERENCES Kategoriyalar(CategoryID);
Quyidagi SQL kod Toifalar (ya'ni Kategoriyalar) jadvalini yaratadi. Unda:

CategoryID — asosiy kalit (PRIMARY KEY) sifatida,

CategoryName — takrorlanmas (UNIQUE) qiymatga ega ustun sifatida belgilanadi.

✅ SQL so‘rovi:
sql
Копировать
Редактировать
CREATE TABLE Toifalar (
    CategoryID INT PRIMARY KEY,
    CategoryName VARCHAR(100) UNIQUE
);
🧾 Izoh:
CategoryID INT PRIMARY KEY — har bir kategoriya uchun yagona identifikator bo‘lib, takrorlanmas va NULL bo‘lmaydi.

CategoryName VARCHAR(100) UNIQUE — kategoriya nomi bo‘lib, u ham takrorlanmas (UNIQUE) bo‘ladi.

SQL Server’dagi IDENTITY ustuni — bu avtomatik tarzda o‘sib boruvchi sonli ustun bo‘lib, odatda birlamchi kalitlar (PRIMARY KEY) uchun ishlatiladi.

✅ IDENTITY ustunining maqsadi:
Avtomatik raqam berish: Har bir yangi yozuv qo‘shilganda, SQL Server avtomatik tarzda unikal son belgilaydi.

Qo‘lda qiymat kiritishga ehtiyoj yo‘q: INSERT so‘rovda bu ustunni kiritishingiz shart emas.

Takrorlanmaydi: Har bir qiymat takrorlanmas bo‘ladi (odatda jadvaldagi qatorlarni aniqlash uchun ishlatiladi).

Soddalik: Yangi yozuvlar uchun identifikatorni yaratish jarayonini soddalashtiradi.

CREATE TABLE Mahsulotlar (
    ProductID INT IDENTITY(1,1) PRIMARY KEY,
    ProductName VARCHAR(50),
    Narx DECIMAL(10,2)
);
SET IDENTITY_INSERT Mahsulotlar ON;

INSERT INTO Mahsulotlar (ProductID, ProductName, Narx)
VALUES (100, 'Banan', 7000.00);

SET IDENTITY_INSERT Mahsulotlar OFF;
1. ✅ Matn faylidan ma’lumotlarni Mahsulotlar jadvaliga import qilish (BULK INSERT):
sql
Копировать
Редактировать
BULK INSERT Mahsulotlar
FROM 'C:\data\mahsulotlar.txt'
WITH (
    FIELDTERMINATOR = ',',     -- Ustunlar ajratuvchisi
    ROWTERMINATOR = '\n',      -- Qator ajratuvchisi
    FIRSTROW = 2               -- Sarlavhani o‘tkazib yuborish
);
🔹 Eslatma: Fayl MahsulotID, MahsulotNomi, Narx, CategoryID, Birja kabi ustunlarni o‘z ichiga olgan bo‘lishi kerak.

2. ✅ Mahsulotlar jadvalida Turkumlar jadvaliga chet kalit (FOREIGN KEY) qo‘shish:
sql
Копировать
Редактировать
ALTER TABLE Mahsulotlar
ADD CONSTRAINT fk_TurkumID 
FOREIGN KEY (CategoryID) REFERENCES Turkumlar(CategoryID);
3. ✅ ASOSIY KALIT (PRIMARY KEY) va UNIKAL KALIT (UNIQUE) o‘rtasidagi farqlar:
Xususiyat	PRIMARY KEY	UNIQUE
Unikal qiymatlar kerakmi?	Ha	Ha
NULL qiymatga ruxsatmi?	Yo‘q	Ha (faqat bitta NULL)
Jadvalda nechta bo‘ladi?	Faqat 1 dona	Bir nechta UNIQUE kalit bo‘lishi mumkin
Asosiy maqsadi	Jadvaldagi yozuvni aniqlash	Takrorlanmas qiymatni ta’minlash

4. ✅ Narx > 0 bo‘lishi uchun CHECK cheklov qo‘shish:
sql
Копировать
Редактировать
ALTER TABLE Mahsulotlar
ADD CONSTRAINT chk_Narx_Plus CHECK (Narx > 0);
5. ✅ Birja ustunini qo‘shish (NOT NULL bilan):
sql
Копировать
Редактировать
ALTER TABLE Mahsulotlar
ADD Birja INT NOT NULL;
👉 Bu ustunga qiymat majburiy bo‘ladi (NULL bo‘lmaydi).

6. ✅ Narx ustunidagi NULL qiymatlarni 0 ga almashtirish (ISNULL):
sql
Копировать
Редактировать
SELECT ProductName, ISNULL(Narx, 0) AS Narx
FROM Mahsulotlar;
🔹 Bu so‘rovda Narx NULL bo‘lsa, u 0 sifatida ko‘rsatiladi.

Agar ma’lumotlarni doimiy o‘zgartirmoqchi bo‘lsangiz:

sql
Копировать
Редактировать
UPDATE Mahsulotlar
SET Narx = 0
WHERE Narx IS NULL;
7. ✅ SQL Serverda FOREIGN KEY cheklovlarining maqsadi va ishlatilishi:
🎯 Maqsadi:
Jadvaldagi ustunni boshqa jadval bilan bog‘lash.

Ma’lumotlar mosligini ta’minlaydi, ya’ni bog‘lanmagan qiymat kiritilishiga yo‘l qo‘ymaydi.

🧱 Foydasi:
Ma’lumotlar integratsiyasini saqlaydi.

Jadval o‘rtasidagi munosabatlarni aniq belgilaydi.

Kaskadli o‘chirish yoki yangilashlar (ON DELETE CASCADE, ON UPDATE CASCADE) qo‘llash mumkin.

🔧 Misol:
sql
Копировать
Редактировать
FOREIGN KEY (CategoryID)
REFERENCES Turkumlar(CategoryID)
Bu degani: Mahsulotlar jadvalidagi CategoryID qiymati faqat Turkumlar jadvalidagi mavjud CategoryID qiymatlari bo‘lishi mumkin.
1. CHECK cheklovi bilan Mijozlar jadvalini yaratish (Yosh >= 18):
sql
Копировать
Редактировать
CREATE TABLE Mijozlar (
    MijozID INT PRIMARY KEY,
    Ism VARCHAR(50),
    Yosh INT CHECK (Yosh >= 18)
);
📝 Izoh: Bu jadvalga faqat 18 yoki undan katta yoshdagi mijozlar qo‘shilishi mumkin. Aks holda xatolik beradi.

✅ 2. IDENTITY ustunli jadval (100 dan boshlanadi, 10 ga oshadi):
sql
Копировать
Редактировать
CREATE TABLE Maxsulotlar (
    MaxsulotID INT IDENTITY(100,10) PRIMARY KEY,
    MaxsulotNomi VARCHAR(100)
);
📝 Izoh: MaxsulotID avtomatik 100 dan boshlanadi: 100, 110, 120, ...

✅ 3. Kompozit PRIMARY KEY bilan OrderDetails jadvalini yaratish:
sql
Копировать
Редактировать
CREATE TABLE OrderDetails (
    OrderID INT,
    ProductID INT,
    Quantity INT,
    PRIMARY KEY (OrderID, ProductID)
);
📝 Izoh: Bu yerda birgalikdagi ikkita ustun OrderID va ProductID kompozit asosiy kalit bo‘ladi — har bir mahsulot har bir buyurtmada yagona bo‘ladi.

✅ 4. COALESCE va ISNULL funksiyalarining farqi va qo‘llanilishi:
▶️ ISNULL() – faqat 2 ta argument qabul qiladi:
sql
Копировать
Редактировать
SELECT ISNULL(Telefon, 'Mavjud emas') AS Telefon FROM Xodimlar;
▶️ COALESCE() – bir nechta qiymatni qabul qiladi, birinchi NULL bo‘lmagan ni qaytaradi:
sql
Копировать
Редактировать
SELECT COALESCE(Telefon1, Telefon2, 'Nomaʼlum') AS Kontakt FROM Xodimlar;
Funksiya	Argument soni	Foydalilik
ISNULL	2 ta	Oddiy holatlar uchun
COALESCE	N ta	Murakkab, bir nechta ustunlar tekshirish uchun

✅ 5. EmpID ustunida ASOSIY KALIT, Email ustunida UNIQUE cheklov bilan Xodimlar jadvalini yaratish:
sql
Копировать
Редактировать
CREATE TABLE Xodimlar (
    EmpID INT PRIMARY KEY,
    Ism VARCHAR(100),
    Email VARCHAR(100) UNIQUE
);
📝 Izoh: EmpID — har bir xodim uchun yagona identifikator; Email — takrorlanmas bo‘lishi shart.

✅ 6. ON DELETE CASCADE va ON UPDATE CASCADE bilan chet kalit (FOREIGN KEY):
sql
Копировать
Редактировать
CREATE TABLE Buyurtmalar (
    BuyurtmaID INT PRIMARY KEY,
    MijozID INT,
    FOREIGN KEY (MijozID)
    REFERENCES Mijozlar(MijozID)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);
📝 Izoh:

ON DELETE CASCADE – Mijozlar jadvalidan mijoz o‘chirilsa, u bilan bog‘liq buyurtmalar ham avtomatik o‘chiriladi.















