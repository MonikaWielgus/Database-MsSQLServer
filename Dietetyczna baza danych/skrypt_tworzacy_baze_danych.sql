--CREATE

IF OBJECT_ID('dbo.AktualnePomiary') IS NOT NULL
DROP TABLE dbo.AktualnePomiary
IF OBJECT_ID('dbo.Znajomi') IS NOT NULL
DROP TABLE dbo.Znajomi
IF OBJECT_ID('dbo.SkładJadłospisów') IS NOT NULL
DROP TABLE dbo.SkładJadłospisów
IF OBJECT_ID('dbo.ZaplanowaneJadłospisy') IS NOT NULL
DROP TABLE dbo.ZaplanowaneJadłospisy
IF OBJECT_ID('dbo.ZapisaneJadłospisy') IS NOT NULL
DROP TABLE dbo.ZapisaneJadłospisy
IF OBJECT_ID('dbo.OcenioneJadłospisy') IS NOT NULL
DROP TABLE dbo.OcenioneJadłospisy
IF OBJECT_ID('dbo.Jadłospisy') IS NOT NULL
DROP TABLE dbo.Jadłospisy
IF OBJECT_ID('dbo.SkładListyZakupów') IS NOT NULL
DROP TABLE dbo.SkładListyZakupów
IF OBJECT_ID('dbo.SkładPosiłków') IS NOT NULL
DROP TABLE dbo.SkładPosiłków
IF OBJECT_ID('dbo.SkładTreningu') IS NOT NULL
DROP TABLE dbo.SkładTreningu
IF OBJECT_ID('dbo.TagiTreningów') IS NOT NULL
DROP TABLE dbo.TagiTreningów
IF OBJECT_ID('dbo.ZaplanowaneTreningi') IS NOT NULL
DROP TABLE dbo.ZaplanowaneTreningi
IF OBJECT_ID('dbo.ZapisaneTreningi') IS NOT NULL
DROP TABLE dbo.ZapisaneTreningi
IF OBJECT_ID('dbo.OcenioneTreningi') IS NOT NULL
DROP TABLE dbo.OcenioneTreningi
IF OBJECT_ID('dbo.Treningi') IS NOT NULL
DROP TABLE dbo.Treningi
IF OBJECT_ID('dbo.TagiĆwiczeń') IS NOT NULL
DROP TABLE dbo.TagiĆwiczeń
IF OBJECT_ID('dbo.Ćwiczenia') IS NOT NULL
DROP TABLE dbo.Ćwiczenia
IF OBJECT_ID('dbo.TagiProduktów') IS NOT NULL
DROP TABLE dbo.TagiProduktów
IF OBJECT_ID('dbo.TagiPosiłków') IS NOT NULL
DROP TABLE dbo.TagiPosiłków
IF OBJECT_ID('dbo.Posiłki') IS NOT NULL
DROP TABLE dbo.Posiłki
IF OBJECT_ID('dbo.TagSportowy') IS NOT NULL
DROP TABLE dbo.TagSportowy
IF OBJECT_ID('dbo.TagSpożywczy') IS NOT NULL
DROP TABLE dbo.TagSpożywczy
IF OBJECT_ID('dbo.Tag') IS NOT NULL
DROP TABLE dbo.Tag
IF OBJECT_ID('dbo.Produkty') IS NOT NULL
DROP TABLE dbo.Produkty
IF OBJECT_ID('dbo.Producenci') IS NOT NULL
DROP TABLE dbo.Producenci
IF OBJECT_ID('dbo.ListaZakupów') IS NOT NULL
DROP TABLE dbo.ListaZakupów
IF OBJECT_ID('dbo.Użytkownicy') IS NOT NULL
DROP TABLE dbo.Użytkownicy

CREATE TABLE Treningi(
IDTreningu INT PRIMARY KEY IDENTITY(1,1),
NazwaTreningu VARCHAR(100) NOT NULL,
StopieńTrudności VARCHAR(50) NOT NULL
)
CREATE TABLE Ćwiczenia(
IDĆwiczenia INT PRIMARY KEY IDENTITY(1,1),
NazwaĆwiczenia VARCHAR(100) NOT NULL,
SpaloneKcal INT,
[CzasWykonywania] INT 
)
CREATE TABLE Użytkownicy(
IDUżytkownika INT PRIMARY KEY IDENTITY(1,1),
NazwaUżytkownika VARCHAR(20) NOT NULL,
ImięUżytownika VARCHAR(20) NOT NULL,
NazwiskoUżytkownika VARCHAR(20) NOT NULL,
NumerTelefonu VARCHAR(9)
)
CREATE TABLE Posiłki(
IDPosiłku INT PRIMARY KEY IDENTITY(1,1),
NazwaPosiłku VARCHAR(100) NOT NULL,
Kalorie FLOAT NOT NULL,
Węglowodany FLOAT NOT NULL,
Białka FLOAT NOT NULL,
Tłuszcze FLOAT NOT NULL,
)
CREATE TABLE Tag(
IDTagu INT PRIMARY KEY IDENTITY(1,1),
NazwaTagu VARCHAR(100) NOT NULL
)
CREATE TABLE TagSportowy(
IDTagu INT REFERENCES Tag(IDTagu),
Ogólnorozwojowy VARCHAR(3),
PRIMARY KEY(IDTagu)
)
CREATE TABLE TagSpożywczy(
IDTagu INT REFERENCES Tag(IDTagu),
OpisTagu VARCHAR(200) NOT NULL,
PRIMARY KEY(IDTagu)
)

CREATE TABLE Producenci(
IDProducenta INT PRIMARY KEY IDENTITY(1,1),
NazwaProducenta VARCHAR(100) NOT NULL,
)
CREATE TABLE Produkty(
IDProduktu INT PRIMARY KEY IDENTITY(1,1),
NazwaProduktu VARCHAR(100) NOT NULL,
IDProducenta INT REFERENCES Producenci(IDProducenta),
Kalorie INT NOT NULL,
Węglowodany FLOAT NOT NULL,
Białka FLOAT NOT NULL,
Tłuszcze FLOAT NOT NULL,
MasaPorcji FLOAT NOT NULL
)
CREATE TABLE ListaZakupów(
IDListy INT PRIMARY KEY IDENTITY(1,1),
NazwaSklepu VARCHAR(20),
IDUżytkownika INT REFERENCES Użytkownicy(IDUżytkownika)
)

CREATE TABLE SkładTreningu(
IDTreningu INT REFERENCES Treningi(IDTreningu),
IDĆwiczenia INT REFERENCES Ćwiczenia(IDĆwiczenia),
IlośćPowtórzeńJednostkiĆwiczeniowej INT NOT NULL,
PRIMARY KEY(IDTreningu,IDĆwiczenia)
)
CREATE TABLE TagiTreningów(
IDTreningu INT REFERENCES Treningi(IDTreningu),
IDTagu INT REFERENCES TagSportowy(IDTagu)
)
CREATE TABLE ZaplanowaneTreningi(
IDUżytkownika INT REFERENCES Użytkownicy(IDUżytkownika),
IDTreningu INT REFERENCES Treningi(IDTreningu),
DataRozpoczęcia DATE NOT NULL,
DataZakończenia DATE NOT NULL,
)
CREATE TABLE ZapisaneTreningi(
IDUżytkownika INT REFERENCES Użytkownicy(IDUżytkownika),
IDTreningu INT REFERENCES Treningi(IDTreningu),
UNIQUE(IDUżytkownika,IDTreningu)
)
CREATE TABLE OcenioneTreningi(
IDUżytkownika INT REFERENCES Użytkownicy(IDUżytkownika),
IDTreningu INT REFERENCES Treningi(IDTreningu),
Ocena INT NOT NULL,
UNIQUE(IDUżytkownika,IDTreningu)
)
CREATE TABLE TagiĆwiczeń(
IDĆwiczenia INT REFERENCES Ćwiczenia(IDĆwiczenia),
IDTagu INT REFERENCES TagSportowy(IDTagu)
)
CREATE TABLE TagiPosiłków(
IDPosiłku INT REFERENCES Posiłki(IDPosiłku),
IDTagu INT REFERENCES TagSpożywczy(IDTagu)
)
CREATE TABLE TagiProduktów(
IDProduktu INT REFERENCES Produkty(IDProduktu),
IDTagu INT REFERENCES TagSpożywczy(IDTagu)
)
CREATE TABLE Jadłospisy(
IDJadłospisu INT PRIMARY KEY IDENTITY(1,1),
NazwaJadłospisu VARCHAR(100) NOT NULL,
Kalorie INT NOT NULL,
Węglowodany FLOAT NOT NULL,
Białka FLOAT NOT NULL,
Tłuszcze FLOAT NOT NULL,
)
CREATE TABLE SkładPosiłków(
IDPosiłku INT REFERENCES Posiłki(IDPosiłku),
IDProduktu INT REFERENCES Produkty(IDProduktu),
IlośćPorcji FLOAT NOT NULL
)
CREATE TABLE SkładListyZakupów(
IDListy INT REFERENCES ListaZakupów(IDListy),
IDProduktu INT REFERENCES Produkty(IDProduktu),
IlośćPorcji FLOAT NOT NULL,
UNIQUE(IDListy, IDProduktu)
)
CREATE TABLE ZaplanowaneJadłospisy(
IDUżytkownika INT REFERENCES Użytkownicy(IDUżytkownika),
IDJadłospisu INT REFERENCES Jadłospisy(IDJadłospisu),
Data DATE NOT NULL
)
CREATE TABLE ZapisaneJadłospisy(
IDUżytkownika INT REFERENCES Użytkownicy(IDUżytkownika),
IDJadłospisu INT REFERENCES Jadłospisy(IDJadłospisu),
UNIQUE(IDUżytkownika,IDJadłospisu)
)
CREATE TABLE OcenioneJadłospisy(
IDUżytkownika INT REFERENCES Użytkownicy(IDUżytkownika),
IDJadłospisu INT REFERENCES Jadłospisy(IDJadłospisu),
Ocena INT NOT NULL,
UNIQUE(IDUżytkownika,IDJadłospisu)
)
CREATE TABLE AktualnePomiary(
IDUżytkownika INT REFERENCES Użytkownicy(IDUżytkownika),
CzasPomiaru DATETIME NOT NULL,
Waga INT NOT NULL,
ObwódPasa INT NOT NULL,
UNIQUE(IDUżytkownika, CzasPomiaru)
)

CREATE TABLE Znajomi(
IDPary INT PRIMARY KEY IDENTITY(1,1),
IDUżytkownika1 INT REFERENCES Użytkownicy(IDUżytkownika),
IDUżytkownika2 INT REFERENCES Użytkownicy(IDUżytkownika)
)
CREATE TABLE SkładJadłospisów(
IDJadłospisu INT REFERENCES Jadłospisy(IDJadłospisu),
IDPosiłku INT REFERENCES Posiłki(IDPosiłku)
)

--INSERT


INSERT INTO Tag VALUES
('wegetariański'),
('wegetariański + ryby'),
('wegański'),
('mięsne'),
('bez nabiału'),
('bez glutenu'),
('Brzuch'),
('Nogi'),
('Ręce'),
('Plecy'),
('Cardio'),
('Siłowe'),
('Na świeżym powietrzu'),
('Bez sprzętu'),
('Drużynowe'),
('Indywidualne'),
('Zimowe'),
('Wodne')


INSERT INTO TagSpożywczy VALUES
(1,'nie zawiera produktów mięsnych ani rybnych'),
(2,'nie zawiera produktów mięsnych'),
(3,'nie zawiera produktów pochodzenia zwierzęcego'),
(4,'zawiera mięso'),
(5,'nie zawiera produktów mlecznych'),
(6,'nie zawiera glutenu')

INSERT INTO TagSportowy VALUES
(7,'NIE'),
(8,'NIE'),
(9,'NIE'),
(10,'NIE'),
(11,'TAK'),
(12,'NIE'),
(13,'TAK'),
(14,NULL),
(15,NULL),
(16,NULL),
(17,'TAK'),
(18,NULL)

INSERT INTO Producenci  VALUES
('Hurtownia Warzyw Kusia'),
('Domowy Ogródek Hani i Helenki'),
('Warzywa i Owoce Rudy i spółka'),
('Zakłady Mleczarskie Śnieżynka'),
('Wyroby mleczne Bacuś'),
('Masarnia Świnka'),
('Wyroby mięsne Krowa i Kurczak'),
('Hurtownia spożywcza Bajka'),
('Sklep z alkoholami Beczka'),
('Danone'),
('Mlekovita'),
('Rians'),
('Roussas'),
('Piątnica'),
('S.M. Bieluch Chełm'),
('Kraft Foods'),
('Piekarnia Tłusty Pączek')
INSERT INTO Produkty VALUES
('Płatki owsiane', 8, 389, 66, 17, 7, 100),
('Chleb żytni', 17, 72, 14, 2, 1, 30),
('Bułka grahamka', 17, 88, 18, 3, 1, 30),
('Chleb graham', 17, 70, 16, 2, 1, 30),
('Słonecznik pestki', 8, 584, 20, 20, 51, 100),
('Kasza jaglana', 8, 378, 72, 11, 4, 100),
('Chleb pszenno-żytni', 17, 70, 15, 1, 1, 30),
('Bułka kajzerka', 17, 95, 17, 3, 1, 30),
('Ryż brązowy', 8, 354, 72, 8, 3, 100),
('Chleb pszenny', 17, 67, 18, 3, 1, 30),
('Otręby pszenne', 8, 185, 61, 16, 5, 100),
('Ryż paraboliczny', 8, 365, 79, 8, 1, 100),
('Mąka pszenna', 8, 364, 76, 10, 1, 100),
('Makaron pełnoziarnisty', 8, 340, 58, 15, 3, 100),
('Bułka tarta', 8, 363, 76, 9, 2, 100),
('Chleb orkiszowy', 17, 73, 14, 3, 2, 30),
('Otręby owsiane', 8, 361, 46, 18 , 8, 100),
('Musli owocowe', 8, 367, 72, 9, 5, 100),
('Kasza gryczana', 8, 355, 70, 13, 3, 100),
('Kasza kuskus', 8, 342, 68, 13, 2, 100),
('Chleb tostowy pełnoziarnisty', 17, 90, 15, 3, 2, 30),
('Mąka żytnia', 8, 349, 75, 11, 2, 100),
('Wafle ryżowe', 8, 374, 81, 8, 3, 100),
('Ryż biały', 8, 350, 79, 7, 1, 100),
('Mąka pszenna pełnoziarnista', 8, 340, 72, 13, 3, 100),
('Makaron jajeczny', 8, 146, 27, 6, 2, 100),
('Pieczywo chrupkie', 8, 368, 77, 9, 2, 100),
('Kasza jęczmienna', 8, 338, 70, 10, 1, 100),
('Płatki kukurydziane', 8, 399, 90, 8, 1, 100),
('Komosa ryżowa', 8, 368, 64, 14, 6, 100),
('Ryż Basmati', 8, 351, 76, 9, 1, 100),
('Sezam', 8, 572, 23, 18, 50, 100),
('Tortilla (placek)', 8, 315, 56, 6, 7, 100),
('Makaron razowy', 8, 318, 61, 14, 2, 100),
('Chia', 8, 402, 1, 23, 33, 100),
('Kasza manna', 8, 348, 74, 9, 1, 100),
('Mąka owsiana', 8, 404, 66, 15, 9, 100),
('Dynia nasiona', 8, 559, 11, 30, 50, 100),
('Makaron Lasagne', 8, 348, 71, 12, 1, 100),
('Sucharki', 8, 399, 69, 13, 7, 100), 
('Makaron spaghetti',8, 324, 50, 9, 1, 100),
('Obwarzanek krakowski', 17, 253, 50, 5, 3, 100),
('Mąka orkiszowa', 8, 326, 60, 14, 2, 100),
('Mąka kokosowa', 8, 312, 13, 11, 24, 100),
('Granola', 8, 429, 60, 70, 17, 100),
('Kasza bulgur', 8, 342, 76, 12, 1, 100), 
('Mąka gryczana', 8, 335, 71, 13, 3, 100),
('Ryż jaśminowy', 8, 355, 79, 7, 1, 100),
('Kurczak (pierś bez skóry)', 6, 121, 0, 22, 4, 100),
('Łosoś wędzony', 6, 153, 0, 25, 5, 100),
('Makrela wędzona', 7, 201, 0, 26, 10, 100),
('Polędwica sopocka', 6, 111, 1, 19, 3, 100),
('Szynka', 7, 96, 0, 17, 3, 100),
('Indyk (pierś bez skóry)', 6, 104, 4, 17, 2, 100),
('Wędlina z piersi indyka', 7, 90, 2, 20, 1, 100),
('Szynka wieprzowa gotowana', 7, 232, 1, 17, 18, 100),
('Szynka z piersi kurczaka', 7, 85, 2, 16, 2, 100),
('Dorsz', 6, 91, 1, 15, 2, 100),
('Mięso mielone drobiowe', 6, 143, 0, 19, 8, 100),
('Kotlet schabowy', 6, 318, 12, 15, 25, 100),
('Tuńczyk', 6, 106, 0, 24, 1, 100),
('Szynka parmeńska',6, 222, 1, 28, 12, 100),
('Szynka z indyka', 6, 126, 2, 18, 5, 100),
('Kiełbasa krakowska sucha', 7, 326, 0, 26, 25, 100),
('Pierś z kurczaka wędzona', 7, 107, 0, 23, 1, 100),
('Parówki', 6, 251, 3, 13, 21, 100),
('Wołowina', 6, 160, 0, 21, 8, 100),
('Karkówka wieprzowa',7,  389, 0, 23, 33, 100),
('Mięso mielone wołowe', 7, 254, 0, 17, 20, 100),
('Pasztet z drobiu', 7, 149, 1, 22, 6, 100),
('Kiełbasa śląska', 7, 214, 0, 18, 16, 100),
('Kaszanka', 6, 274, 15, 9, 20, 100),
('Kiełbasa', 7, 214, 0, 18, 16, 100),
('Mięso mielone wieprzowe', 6, 264, 0, 21, 20, 100),
('Boczek', 6, 478, 1, 13, 47, 100),
('Salami', 6, 459, 0, 22, 41, 100),
('Kabanos wieprzowy', 7, 328, 0, 28, 24, 100),
('Frankfurterki', 6, 305, 2, 12, 28, 100),
('Pasztet wieprzowo-wołowy', 7, 295, 3, 19, 22, 100),
('Pstrąg', 7, 130, 0, 25, 3, 100),
('Krewetki', 7, 106, 1, 21, 2, 100),
('Kaczka', 7, 337, 0, 19, 29, 100),
('Tatar', 7, 118, 1, 18, 5, 100),
('Kurczak - podudzie', 6, 300, 0, 23, 27, 100),
('Śledź', 6, 216, 0, 20, 15, 100),
('Sola', 6, 87, 0, 18, 1, 100),
('Żeberka wieprzowe',7, 359, 0, 22, 30, 100),
('Metka', 7, 135, 1, 15, 8, 100),
('Jaja przepiórcze', 2, 95, 0.2, 7.8, 6.6, 60),
('Actimel', 10, 71, 10.5, 2.8, 1.6, 100),
('Actimel wieloowocowy', 10, 78, 12.4, 2.6, 1.5, 100),
('Actimel', 10, 71, 10.5, 2.8, 1.6, 100),
('Białko jaja kurzego', 2, 17, 0.2, 3.8, 0.1, 35),
('Danonek, jogurt o smaku truskawkowym w saszetce', 10, 62, 8.5, 2.5, 2, 70),
('Kostki sera Favita w oleju', 11, 88, 1.5, 7, 6, 50),
('Garść startego żółtego sera', 5, 107, 0.7, 7.5, 8.2, 30),
('Jajko sadzone', 2, 127, 0.4, 7.5, 10.8, 52),
('Jajko gotowane', 8, 78, 0.6, 6.3, 5.3, 50),
('Jajko kurze', 2, 71, 0.3, 6.4, 4.9, 51),
('Jogurt kozi naturalny', 12, 95, 3.4, 6.7, 7.2, 120),
('Jogurt naturalny Activia', 10, 145, 10.7, 9.5, 7.1, 210),
('Kawałek parmezanu', 4, 908, 0.2, 81.4, 64, 200),
('Kostka greckiej Fety', 13, 530, 2.8, 35, 42, 200),
('Kula mozzarelli', 4, 635, 7.5, 60, 40, 250),
('Łyżeczka mleka w proszku', 8, 25, 1.9, 1.3, 1.3, 5),
('Łyżeczka sera mascarpone', 14, 47, 0.6, 0.4, 4.8, 12),
('Łyżeczka serka naturalnego', 15, 19, 0.6, 1.3, 1.3, 15),
('Łyżeczka serka wiejskiego ze szczypiorkiem', 14, 15, 0.3, 1.7, 0.8, 15),
('Łyżka jogurtu greckiego 0%', 10, 10, 0.8, 1.8, 0, 20),
('Łyżka jogurtu naturalnego', 4, 15, 1.5, 1.1, 0.5, 25),
('Łyżka jogurtu naturalnego 0%', 4, 10, 1.3, 1, 0, 20),
('Łyżka serka śmietankowego Philadelphia', 16, 63, 0.8, 1.5, 5.9, 25),
('Łyżka śmietany 12%', 4, 24, 0.7, 0.5, 2.2, 18),
('Łyżka śmietany 18%', 4, 47, 0.9, 0.6, 4.5, 25),
('Łyżka śmietany 30%', 4, 29, 0.3, 0.2, 3.0, 10),
('Pieróg z twarogiem', 4, 72, 8, 3.3, 3, 30),
('Plaster jaja', 8, 16, 0.1, 1.3, 1.1, 10),
('Plaster pełnotłustego sera "Morskiego"', 11, 71, 0, 5.3, 5.5, 22),
('Plaster sera Gouda', 11, 79, 0, 6.8, 5.7, 25),
('Plaster sera żółtego', 5, 57, 0, 4.3, 4.5, 15),
('Plaster twarogu chudego', 5, 34, 0.7, 7.5, 0.2, 34),
('Porcja masła extra', 5, 37, 0, 0, 4.1, 5),
('Pół kostki twarogu półtłustego', 5, 132, 3.7, 18.3, 4.7, 100),
('Serek wiejski naturalny', 14, 194, 4, 22, 10, 200),
('Szklanka jogurtu naturalnego', 4, 150, 15.5, 10.8, 5, 250),
('Szklanka kefiru naturalnego', 4, 122, 12, 8.6, 4.3, 240),
('Szklanka mleka 0%', 5, 77, 11.3, 7.7, 0, 240),
('Szklanka mleka 0.5%', 5, 90, 11.7, 7.8, 1.2, 230),
('Szklanka mleka 1.5%', 5, 108, 11.5, 7.6, 3.5, 230),
('Szklanka mleka 2%', 5, 117, 11.3, 7.6, 4.6, 230),
('Szklanka mleka 3.2%', 5, 140, 11, 7.4, 7.4, 230),
('Żółtko jaja kurzego', 5, 63, 0.1, 3.1, 5.6, 20),
('Bakłażan',1,26,3.8,1.1,0.1,100),
('Cebula',2,33,5.2,1.4,0.4,100),
('Czosnek',2,8,1.4,0.3,0.0,5),
('Cukinia',3,17,2.2,1.2,0.1,100),
('Passata pomidorowa',8,23,4,1.3,0.2,100),
('Szpinak',8,22,0.9,2.6,0.4,100),
('Ajwar',8,20,2.6,0.2,1.2,20),
('Soczewica',1,105,14.1,8.5,0.7,100),
('Czerwona fasola',8,87,12.3,8.1,0.6,100),
('Kukurydza',2,109,19.7,2.9,1.2,100),
('Groszek',8,73,10.1,4.9,0.2,100),
('Tofu naturalne',8,100,4.4,12,3.8,100),
('Tofu wędzone',8,169,4.0,16.3,9.8,100),
('Ciecierzyca',8,120,14.7,6.4,2.2,100),
('Pomidor',3,19,2.9,0.9,0.2,100),
('Papryka',2,32,4.6,1.3,0.5,100),
('Ziemniak',1,71,15,1.8,0.1,100),
('Ogórek',3,14,2.4,0.7,0.1,100),
('Awokado',2,169,4.1,2.0,15.3,100),
('Marchew',2,33,5.1,1,0.2,100),
('Dynia',3,33,4.9,1.3,0.3,100),
('Kapusta biała',1,33,4.9,1.7,0.2,100),
('Kapusta pekińska',1,16,1.3,1.2,0.2,100),
('Jarmuż',2,36,2.3,3.3,0.7,100),
('Brokuł',1,31,2.7,3.0,0.4,100),
('Kalafior',1,27,2.6,2.4,0.2,100),
('Fasolka szparagowa',2,27,3.6,1.2,0.3,100),
('Burak',2,37,6.5,1.6,0.1,100),
('Korzeń selera',1,30,2.8,1.6,0.3,100),
('Natka pietruszki',1,3,0.3,0.3,0,6),
('Szczypiorek',1,2,0.1,0.2,0,5),
('Rzodkiewka',1,18,1.9,1,0.2,100),
('Por',1,29,3,2.2,0.3,100),
('Pietruszka',1,49,6.3,2.6,0.5,100),
('Podgrzybek',1,49,4,3.6,0.5,100),
('Pieczarka',3,21,2.6,2.7,0.4,100),
('Roszponka',3,21,3.6,2,0.4,100),
('Szparagi',3,21,2.2,1.9,0.2,100),
('Tempeh',8,339,23.4,20.3,11.2,100),
('Cykoria',1,23,3.1,1.7,0.2,100),
('Bób',1,76,8.2,7.1,0.4,100),
('Groszek cukrowy',1,42,7.5,2.8,0.2,100),
('Kurka',1,32,6.9,1.5,0.5,100),
('Papryka pepperoni',1,6,0.9,0.2,0.1,19),
('Koperek',1,1,0.1,0.1,0,4),
('Papryka habanero',1,5,0.8,0.2,0.1,17),
('Pomidor koktajlowy',2,19,2.9,0.9,0.2,100),
('Rukola',3,25,3.7,2.6,0.7,100),
('Sałata masłowa',1,14,1.5,1.4,0.2,100),
('Sałata rzymska',1,16,1.5,1.4,0.2,100),
('Imbir',1,8,1.8,0.2,0.1,10),
('Seler naciowy',3,17,1.8,1,0.2,100),
('Jabłko',2,50,10.1,0.4,0.4,100),
('Cytryna',1,4,0.8,0.1,0,10),
('Rabarbar',2,15,1.4,0.5,0.1,100),
('Banan',1,97,21.8,1,0.3,100),
('Pomarańcza',2,47,9.4,0.9,0.2,100),
('Mandarynka',1,45,9.3,0.6,0.3,100),
('Pomelo',1,38,9.6,0.8,0,100),
('Truskawka',2,33,5.8,0.7,0.4,100),
('Malina',3,43,5.3,1.3,0.3,100),
('Brzoskwinia',1,50,10,1,0.2,100),
('Nektarynka',3,50,10.6,0.9,0.2,100),
('Pitaja',2,50,11.8,1.4,0.3,100),
('Arbuz',3,36,8.1,0.6,0.1,100),
('Melon',3,34,0.2,0.8,0.2,100),
('Śliwka',3,49,10.1,0.6,0.3,100),
('Wiśnia',3,49,9.9,0.9,0.4,100),
('Czereśnia',3,63,13.3,1,0.3,100),
('Kiwi',3,60,11.8,0.9,0.5,100),
('Ananas',3,55,2.4,0.4,0.2,100),
('Papaja',2,44,9.2,0.6,0.1,100),
('Jeżyna',1,43,9.6,1.1,0.5,100),
('Olej kokosowy',8,54,0,0,6,6),
('Olej rzepakowy',8,88,0,0,10,10),
('Oliwa z oliwek',8,88,0,0,10,10),
('Olej lniany',8,90,0,0,10,10),
('Olej z awokado',8,71,0,0,8,8),
('Olej sezamowy',8,54,0,0,6,6),
('Olej słonecznikowy',8,72,0,0,8,8)
INSERT INTO Posiłki VALUES
('Kanapki z awokado i pomidorem',394.5,47.55,8.45,18.4),
('Makaron z tofu, ciecierzycą i szpinakiem',880.4,78.35,43.1,40.2),
('Owsianka z owocami i nasionami',576.1,92.2,26.8,17.3),
('Rozgrzewająca owsianka na mleku',689,101.1,53.2,20),
('Pomidorowe spaghetti z soczewicą',599,75,28.8,10.4),
('Tortilla z mozarellą i warzywami',688.5,67.9,38.3,28.75),
('Kasza jęczmienna z kurczakiem i warzywami', 468, 38.6, 43.8, 13.1),
('Jajecznica ze szczypiorkiem i pomidorami',250, 17.1,15.1,13.4),
('Tortilla zapiekana z serem i szynką', 698, 14.84, 14.52, 11.41),
('Dorsz z warzywami i brązowym ryżem', 492,59.1, 21,18.5),
('Kanapki z jajkiem, łososiem i warzywami', 390, 45, 26.7,10.8),
('Pieczony pstrąg w pomidorach z kaszą i warzywami', 702, 87.6, 33.9,23.5)

INSERT INTO SkładPosiłków VALUES
(1,2,3),(1,147,0.5),(1,151,1),
(2,5,0.1),(2,14,1),(2,145,1),(2,134,1),(2,146,0.5),(2,138,2),(2,208,2),
(3,1,1),(3,11,0.3),(3,5,0.1),(3,35,0.1),(3,192,1),
(4,1,0.5),(4,131,1),(4,188,1),(4,193,1),(4,45,0.5),
(5,41,1), (5,96,1),(5,137,2),(5,140,1),(5,136,1),
(6,33,1),(6,104,0.5),(6,147,0.5),(6,148,0.5),(6,169,0.5),(6,139,1),
(7,168,2), (7,136,1),(7,208,1), (7,49,1.5),(7,28,0.5),
(8,4,1), (8,99,2), (8,147,1.7),(8,163,1), (8,208,1),
(9,33,1.2), (9,63,0.6),(9,119,4),
(10, 208,2),(10,166,0.8),(10,152,0.45),(10,134,0.5),(10,161,0.5), (10,58,1),(10,9,0.75),
(11,4,3),(11,50,0.6), (11,98,2), (11,150,3), (11,163,3), (11,180,1),
(12,180,1),(12,134,0.5),(12,142,0.6),(12,147,1.7),(12,148,1.4),(12,186,0.1),(12,208,1),(12,80,2.3),(12,28,0.75)
INSERT INTO Jadłospisy VALUES
('Jadłospis wegański',1851,218.1,78.35,75.9),
('Zimowy jadłospis wegetariański',1976.5,244,120.3,59.15),
('Jadłospis redukcyjny dla jedzących mięso', 1416, 70.54,73.42,37.91),
('Jadłospis wegetariański zawierający ryby', 1584, 191.7, 135.3, 52.8)
INSERT INTO SkładJadłospisów VALUES
(1,1),(1,2),(1,3),
(2,4),(2,5),(2,6),
(3,7),(3,8),(3,9),
(4,10),(4,11),(4,12)
INSERT INTO TagiPosiłków VALUES
(1,1),(1,2),(1,3),(1,5),
(2,1),(2,2),(2,3),(2,5),
(3,1),(3,2),(3,3),(3,5),
(4,1),(4,2),
(5,1),(5,2),
(6,1),(6,2),
(7,5),(7,4),
(8,1), (8,2),
(9,5),
(10,2),(10,5),(10,6),
(11,2),
(12,2),(12,5)

INSERT INTO TagiProduktów VALUES
(89,1),(89,2),(89,6),
(90,1),(90,2),(90,6),
(91,1),(91,2),(91,6),
(92,1),(92,2),(92,6),
(93,1),(93,2),(93,6),
(94,1),(94,2),(94,6),
(95,1),(95,2),(95,6),
(96,1),(96,2),(96,6),
(97,1),(97,2),(97,6),
(98,1),(98,2),(98,6),
(99,1),(99,2),(99,6),
(100,1),(100,2),(100,6),
(101,1),(101,2),(101,6),
(102,1),(102,2),(102,6),
(103,1),(103,2),(103,6),
(104,1),(104,2),(104,6),
(105,1),(105,2),(105,6),
(106,1),(106,2),(106,6),
(107,1),(107,2),(107,6),
(108,1),(108,2),(108,6),
(109,1),(109,2),(109,6),
(110,1),(110,2),(110,6),
(111,1),(111,2),(111,6),
(112,1),(112,2),(112,6),
(113,1),(113,2),(113,6),
(114,1),(114,2),(114,6),
(115,1),(115,2),(115,6),
(116,1),(116,2),(116,6),
(117,1),(117,2),(117,6),
(118,1),(118,2),(118,6),
(119,1),(119,2),(119,6),
(120,1),(120,2),(120,6),
(121,1),(121,2),(121,6),
(122,1),(122,2),(122,6),
(123,1),(123,2),(123,6),
(124,1),(124,2),(124,6),
(125,1),(125,2),(125,6),
(126,1),(126,2),(126,6),
(127,1),(127,2),(127,6),
(128,1),(128,2),(128,6),
(129,1),(129,2),(129,6),
(130,1),(130,2),(130,6),
(131,1),(131,2),(131,6),
(132,1),(132,2),(132,6),
(133,1),(133,2),(133,3),(133,5),(133,6),
(134,1),(134,2),(134,3),(134,5),(134,6),
(135,1),(135,2),(135,3),(135,5),(135,6),
(136,1),(136,2),(136,3),(136,5),(136,6),
(137,1),(137,2),(137,3),(137,5),(137,6),
(138,1),(138,2),(138,3),(138,5),(138,6),
(139,1),(139,2),(139,3),(139,5),(139,6),
(140,1),(140,2),(140,3),(140,5),(140,6),
(141,1),(141,2),(141,3),(141,5),(141,6),
(142,1),(142,2),(142,3),(142,5),(142,6),
(143,1),(143,2),(143,3),(143,5),(143,6),
(144,1),(144,2),(144,3),(144,5),(144,6),
(145,1),(145,2),(145,3),(145,5),(145,6),
(146,1),(146,2),(146,3),(146,5),(146,6),
(147,1),(147,2),(147,3),(147,5),(147,6),
(148,1),(148,2),(148,3),(148,5),(148,6),
(149,1),(149,2),(149,3),(149,5),(149,6),
(150,1),(150,2),(150,3),(150,5),(150,6),
(151,1),(151,2),(151,3),(151,5),(151,6),
(152,1),(152,2),(152,3),(152,5),(152,6),
(153,1),(153,2),(153,3),(153,5),(153,6),
(154,1),(154,2),(154,3),(154,5),(154,6),
(155,1),(155,2),(155,3),(155,5),(155,6),
(156,1),(156,2),(156,3),(156,5),(156,6),
(157,1),(157,2),(157,3),(157,5),(157,6),
(158,1),(158,2),(158,3),(158,5),(158,6),
(159,1),(159,2),(159,3),(159,5),(159,6),
(160,1),(160,2),(160,3),(160,5),(160,6),
(161,1),(161,2),(161,3),(161,5),(161,6),
(162,1),(162,2),(162,3),(162,5),(162,6),
(163,1),(163,2),(163,3),(163,5),(163,6),
(164,1),(164,2),(164,3),(164,5),(164,6),
(165,1),(165,2),(165,3),(165,5),(165,6),
(166,1),(166,2),(166,3),(166,5),(166,6),
(167,1),(167,2),(167,3),(167,5),(167,6),
(168,1),(168,2),(168,3),(168,5),(168,6),
(169,1),(169,2),(169,3),(169,5),(169,6),
(170,1),(170,2),(170,3),(170,5),(170,6),
(171,1),(171,2),(171,3),(171,5),(171,6),
(172,1),(172,2),(172,3),(172,5),(172,6),
(173,1),(173,2),(173,3),(173,5),(173,6),
(174,1),(174,2),(174,3),(174,5),(174,6),
(175,1),(175,2),(175,3),(175,5),(175,6),
(176,1),(176,2),(176,3),(176,5),(176,6),
(177,1),(177,2),(177,3),(177,5),(177,6),
(178,1),(178,2),(178,3),(178,5),(178,6),
(179,1),(179,2),(179,3),(179,5),(179,6),
(180,1),(180,2),(180,3),(180,5),(180,6),
(181,1),(181,2),(181,3),(181,5),(181,6),
(182,1),(182,2),(182,3),(182,5),(182,6),
(183,1),(183,2),(183,3),(183,5),(183,6),
(184,1),(184,2),(184,3),(184,5),(184,6),
(185,1),(185,2),(185,3),(185,5),(185,6),
(186,1),(186,2),(186,3),(186,5),(186,6),
(187,1),(187,2),(187,3),(187,5),(187,6),
(188,1),(188,2),(188,3),(188,5),(188,6),
(189,1),(189,2),(189,3),(189,5),(189,6),
(190,1),(190,2),(190,3),(190,5),(190,6),
(191,1),(191,2),(191,3),(191,5),(191,6),
(192,1),(192,2),(192,3),(192,5),(192,6),
(193,1),(193,2),(193,3),(193,5),(193,6),
(194,1),(194,2),(194,3),(194,5),(194,6),
(195,1),(195,2),(195,3),(195,5),(195,6),
(196,1),(196,2),(196,3),(196,5),(196,6),
(197,1),(197,2),(197,3),(197,5),(197,6),
(198,1),(198,2),(198,3),(198,5),(198,6),
(199,1),(199,2),(199,3),(199,5),(199,6),
(200,1),(200,2),(200,3),(200,5),(200,6),
(201,1),(201,2),(201,3),(201,5),(201,6),
(202,1),(202,2),(202,3),(202,5),(202,6),
(203,1),(203,2),(203,3),(203,5),(203,6),
(204,1),(204,2),(204,3),(204,5),(204,6),
(205,1),(205,2),(205,3),(205,5),(205,6),
(206,1),(206,2),(206,3),(206,5),(206,6),
(207,1),(207,2),(207,3),(207,5),(207,6),
(208,1),(208,2),(208,3),(208,5),(208,6),
(209,1),(209,2),(209,3),(209,5),(209,6),
(210,1),(210,2),(210,3),(210,5),(210,6),
(211,1),(211,2),(211,3),(211,5),(211,6),
(212,1),(212,2),(212,3),(212,5),(212,6)

INSERT INTO Ćwiczenia
VALUES
('Aerobik(Intensywnie)',255,30),
('Aerobik(Spokojnie)',182,30),
('Aerobik(Umiarkowane tempo',210,30),
('Aerobik z ciężarkami (4.5-6.5 kg)',350,30),
('Aqua Aerobik',192,30),
('Badminton',200,30),
('Bieganie 6 km/h (trucht)',105,15),
('Bieganie 7 km/h',135,15),
('Bieganie 8 km/h',145,15),
('Bieganie 9 km/h',168,15),
('Bieganie 10 km/h',184,15),
('Bieganie 11 km/h',193,15),
('Bieganie 12 km/h',207,15),
('Bieganie 13 km/h',235,15),
('Bieganie 14 km/h',250,15),
('Bieganie 15 km/h',268,15),
('Bieganie 16 km/h',284,15),
('Bieganie 17 km/h (sprint)',301,15),
('Boks',325,30),
('Brzuszki niepełne',33,10),
('Brzuszki pełne (energiczne)',93,10),
('Brzuszki pełne (spokojne tempo)',32,10),
('Brzuszki pełne (umiarkowane tempo)',44,10),
('Chodzenie 3km/h',84,30),
('Chodzenie 4km/h',102,30),
('Chodzenie 5km/h',123,30),
('Hula hop',70,15),
('Jazda na łyżwach',123,15),
('Jazda na nartach biegówkach',287,30),
('Jazda na nartach wodnych',245,30),
('Jazda na nartach zjazdowych',255,30),
('Jazda na rolkach',245,30),
('Jazda na rowerze 10km/h',245,60),
('Jazda na rowerze 11-15km/h',280,60),
('Jazda na rowerze 16-19km/h',476,60),
('Jazda na rowerze 20-22km/h',560,60),
('Jazda na rowerze 23-25km/h',700,60),
('Jazda na rowerze 25-30km/h',840,60),
('Jazda na snowboardzie',490,60),
('Joga',175,60),
('Judo',350,30),
('Karate',350,30),
('Kolarstwo górskie',595,60),
('Koszykówka',280,30),
('Nordic Walking 7km/h',504,60),
('Nordic Walking 6km/h',476,60),
('Nordic Walking 5km/h',392,60),
('Nordic Walking 4km/h',308,60),
('Snorkeling',175,30),
('Nurkowanie ze sprzętem',245,30),
('Pilates',210,60),
('Piłka nożna',630,60),
('Piłka ręczna',840,60),
('Pływanie kraulem',175,15),
('Pływanie stylem grzbietowym',166,15),
('Pływanie stylem klasycznym',180,15),
('Pływanie stylem motylkowym',240,15),
('Podciąganie',44,10),
('Pompki',44,10),
('Przysiady wykroczne',44,10),
('Przysiady',58,10),
('Siatkówka',140,30),
('Siatkówka plażowa',280,30),
('Siatkówka wodna',185,30),
('Skakanka (intensywnie)',192,15),
('Skakanka (spokojnie)',143,15),
('Spacer',245,60),
('Squash',420,30),
('Step aerobik',385,60),
('Steper',82,10),
('Tenis',280,30),
('Rozciąganie',27,10),
('Trucht',105,15),
('Orbitrek',175,30),
('Schody',51,10),
('Wspinaczka',280,30),
('Zumba',476,60)

INSERT INTO Treningi
VALUES
('Wzmacnianie pleców','Umiarkowany'),
('Wzmacnianie nóg','Umiarkowany'),
('Aerobik','Łatwy'),
('Bieganie szybkie','Trudny'),
('Bieganie dla początkujących','Łatwy'),
('Trening bokserski','Umiarkowany'),
('Wzmacnianie mięśni brzucha','Umiarkowany'),
('Trening łyżwiarski','Umiarkowany'),
('Trening narciarsko-snowboardowy','Trudny'),
('Sztuki walki','Umiarkowany'),
('Trening pływacki','Trudny'),
('Cardio dla początkujących','Łatwy'),
('Pilates','Łatwy'),
('Trening piłkarski','Umiarkowany'),
('Trening piłki ręcznej','Umiarkowany'),
('Trening koszykarski','Trudny'),
('Trening kolarski','Trudny')
--Tagi ćwiczeń
INSERT INTO TagiĆwiczeń
VALUES
(1,11),(1,14),
(2,11),(2,14),
(3,11),(3,14),
(4,11),
(5,11),(5,18),
(6,15),
(7,11),(7,13),(7,14),(7,16),
(8,11),(8,13),(8,14),(8,16),
(9,11),(9,13),(9,14),(9,16),
(10,11),(10,13),(10,14),(10,16),
(11,11),(11,13),(11,14),(11,16),
(12,11),(12,13),(12,14),(12,16),
(13,11),(13,13),(13,14),(13,16),
(14,11),(14,13),(14,14),(14,16),
(15,11),(15,13),(15,14),(15,16),
(16,11),(16,13),(16,14),(16,16),
(17,11),(17,13),(17,14),(17,16),
(18,11),(18,13),(18,14),(18,16),
(19,9),(19,11),
(20,7),(20,12),(20,14),(20,16),
(21,7),(21,12),(21,14),(21,16),
(22,7),(22,12),(22,14),(22,16),
(23,7),(23,12),(23,14),(23,16),
(24,11),(24,13),(24,14),(24,16),
(25,11),(25,13),(25,14),(25,16),
(26,11),(26,13),(26,14),(26,16),
(27,11),(27,16),
(28,11),(28,16),(28,17),
(29,11),(29,13),(29,16),(29,17),
(30,16),(30,18),
(31,13),(31,16),(31,17),
(32,11),(32,13),(32,16),
(33,11),(33,13),(33,16),
(34,11),(34,13),(34,16),
(35,11),(35,13),(35,16),
(36,11),(36,13),(36,16),
(37,11),(37,13),(37,16),
(38,11),(38,13),(38,16),
(39,13),(39,16),(39,17),
(40,16),
(41,14),
(42,16),
(43,13),(43,16),
(44,15),
(45,11),(45,13),(45,16),
(46,11),(46,13),(46,16),
(47,11),(47,13),(47,16),
(48,11),(48,13),(48,16),
(49,16),(49,18),
(50,18),
(51,14),
(52,15),
(53,15),
(54,11),(54,16),(54,18),
(55,11),(55,16),(55,18),(56,11),
(56,16),(56,18),
(57,11),(57,16),(57,18),
(58,9),(58,10),(58,12),
(59,9),(59,10),(59,12),(59,14),(59,16),
(60,8),(60,12),(60,16),
(61,8),(61,12),(61,16),
(62,15),
(63,15),
(64,15),(64,18),
(65,11),(65,16),
(66,11),(66,16),
(67,11),(67,13),(67,14),(67,16),
(68,15),
(69,11),
(70,11),
(71,11),(71,15),
(72,14),(72,16),
(73,11),(73,13),(73,14),(73,16),
(74,11),(74,16),
(75,16),
(76,9),(76,10),
(77,11),(77,14)

--Tagi Treningów
INSERT INTO TagiTreningów
VALUES
(1,10),(1,9),(1,12),(1,16),
(2,8),(2,12),(2,16),
(3,11),(3,14),
(4,11),(4,13),(4,14),(4,16),
(5,11),(5,13),(5,14),(5,16),
(6,15),
(7,12),(7,14),(7,16),
(8,16),(8,17),
(9,16),(9,17),
(10,15),
(11,11),(11,16),(11,18),
(12,11),(12,16),
(13,11),
(14,15),
(15,15),
(16,15),
(17,13),(17,16)

INSERT INTO SkładTreningu
VALUES
(1,73,1),
(1,59,1),
(1,58,2),
(1,72,1),
(2,8,1),
(2,75,2),
(2,61,1),
(2,60,1),
(2,70,1),
(3,1,1),
(3,2,1),
(4,11,2),
(4,13,1),
(5,7,1),
(5,9,1),
(6,70,1),
(6,19,2),
(7,20,1),
(7,21,1),
(7,23,1),
(7,72,1),
(8,32,1),
(8,28,2),
(9,31,1),
(9,39,1),
(10,73,1),
(10,41,1),
(10,42,1),
(10,72,1),
(11,54,1),
(11,55,1),
(11,56,1),
(11,57,1),
(12,73,1),
(12,66,1),
(13,51,1),
(13,72,1),
(14,65,1),
(14,52,1),
(15,59,1),
(15,53,1),
(15,72,1),
(16,65,1),
(16,44,2),
(17,36,1),
(17,38,1)

--FUNCTION

IF OBJECT_ID('WyświetlZnajomych','IF') IS NOT NULL
DROP FUNCTION WyświetlZnajomych
IF OBJECT_ID ('WyświetlZapisaneTreningi') IS NOT NULL
DROP FUNCTION WyświetlZapisaneTreningi
IF OBJECT_ID ('WyświetlZaplanowaneTreningi') IS NOT NULL
DROP FUNCTION WyświetlZaplanowaneTreningi
IF OBJECT_ID ('WyświetlOcenioneTreningi') IS NOT NULL
DROP FUNCTION WyświetlOcenioneTreningi
IF OBJECT_ID ('WyświetlZapisaneJadłospisy') IS NOT NULL
DROP FUNCTION WyświetlZapisaneJadłospisy
IF OBJECT_ID ('WyświetlZaplanowaneJadłospisy') IS NOT NULL
DROP FUNCTION WyświetlZaplanowaneJadłospisy
IF OBJECT_ID ('WyświetlOcenioneJadłospisy') IS NOT NULL
DROP FUNCTION WyświetlOcenioneJadłospisy
IF OBJECT_ID ('WyświetlZaplanowaneTreningiNaDziś') IS NOT NULL
DROP FUNCTION WyświetlZaplanowaneTreningiNaDziś
IF OBJECT_ID ('WyświetlZaplanowaneJadłospisyNaDziś') IS NOT NULL
DROP FUNCTION WyświetlZaplanowaneJadłospisyNaDziś
IF OBJECT_ID ('WyświetlPomiary') IS NOT NULL
DROP FUNCTION WyświetlPomiary
IF OBJECT_ID ('WyświetlSkładTreningu') IS NOT NULL
DROP FUNCTION WyświetlSkładTreningu
IF OBJECT_ID ('WyświetlSkładJadłospisu') IS NOT NULL
DROP FUNCTION WyświetlSkładJadłospisu
IF OBJECT_ID ('WyświetlSkładPosiłku') IS NOT NULL
DROP FUNCTION WyświetlSkładPosiłku
IF OBJECT_ID ('WyświetlTreningPoTagu') IS NOT NULL
DROP FUNCTION WyświetlTreningPoTagu
IF OBJECT_ID ('WyświetlĆwiczeniePoTagu') IS NOT NULL
DROP FUNCTION WyświetlĆwiczeniePoTagu
IF OBJECT_ID ('WyświetlPosiłekPoTagu') IS NOT NULL
DROP FUNCTION WyświetlPosiłekPoTagu
IF OBJECT_ID ('WyświetlProduktPoTagu') IS NOT NULL
DROP FUNCTION WyświetlProduktPoTagu
IF OBJECT_ID ('WyświetlListęZakupów') IS NOT NULL
DROP FUNCTION WyświetlListęZakupów
IF OBJECT_ID ('ObliczProcentTkankiTłuszczowej') IS NOT NULL
DROP FUNCTION ObliczProcentTkankiTłuszczowej
GO


CREATE FUNCTION ObliczProcentTkankiTłuszczowej(@NazwaUżytkownika VARCHAR(20))
RETURNS FLOAT
BEGIN
	DECLARE @wynik FLOAT, @waga INT, @obwód INT
	SET @waga=(SELECT Top 1 AktualnePomiary.Waga FROM Użytkownicy JOIN AktualnePomiary ON Użytkownicy.IDUżytkownika=AktualnePomiary.IDUżytkownika
	WHERE Użytkownicy.NazwaUżytkownika=@NazwaUżytkownika
	ORDER BY AktualnePomiary.CzasPomiaru DESC)
	SET @obwód=(SELECT Top 1 AktualnePomiary.ObwódPasa FROM Użytkownicy JOIN AktualnePomiary ON Użytkownicy.IDUżytkownika=AktualnePomiary.IDUżytkownika
	WHERE Użytkownicy.NazwaUżytkownika=@NazwaUżytkownika
	ORDER BY AktualnePomiary.CzasPomiaru DESC)
	SET @wynik=((((4.15*@obwód)/2.54)-0.082*@waga*2.2-88)/(@waga*2.2))*100
	RETURN @wynik
END
GO

CREATE FUNCTION WyświetlListęZakupów (@NazwaUżytkownika VARCHAR(100), @NazwaSklepu VARCHAR(20))
RETURNS TABLE AS
RETURN 
(
	SELECT P.NazwaProduktu, P.MasaPorcji, S.IlośćPorcji FROM 
	SkładListyZakupów S JOIN ListaZakupów L ON S.IDListy = L.IDListy
	JOIN Użytkownicy U ON U.IDUżytkownika = L.IDUżytkownika
	JOIN Produkty P ON S.IDProduktu = P.IDProduktu
	WHERE U.NazwaUżytkownika = @NazwaUżytkownika AND L.NazwaSklepu = @NazwaSklepu
)
GO

CREATE FUNCTION WyświetlTreningPoTagu (@NazwaTagu VARCHAR(20))
RETURNS TABLE AS
RETURN 
(
	SELECT Treningi.NazwaTreningu, Treningi.StopieńTrudności
	FROM Treningi JOIN TagiTreningów ON Treningi.IDTreningu=TagiTreningów.IDTreningu
	JOIN Tag ON Tag.IDTagu=TagiTreningów.IDTagu WHERE Tag.NazwaTagu=@NazwaTagu
)
GO

CREATE FUNCTION WyświetlĆwiczeniePoTagu (@NazwaTagu VARCHAR(20))
RETURNS TABLE AS
RETURN 
(
	SELECT Ćwiczenia.NazwaĆwiczenia, Ćwiczenia.SpaloneKcal, Ćwiczenia.CzasWykonywania
	FROM Ćwiczenia JOIN TagiĆwiczeń ON Ćwiczenia.IDĆwiczenia=TagiĆwiczeń.IDĆwiczenia
	JOIN Tag ON Tag.IDTagu=TagiĆwiczeń.IDTagu 
	WHERE Tag.NazwaTagu=@NazwaTagu
)
GO

CREATE FUNCTION WyświetlPosiłekPoTagu (@NazwaTagu VARCHAR(20))
RETURNS TABLE AS
RETURN 
(
	SELECT Posiłki.NazwaPosiłku, Posiłki.Kalorie, Posiłki.Węglowodany, Posiłki.Białka, Posiłki.Tłuszcze
	FROM Posiłki JOIN TagiPosiłków ON Posiłki.IDPosiłku=TagiPosiłków.IDPosiłku
	JOIN Tag ON Tag.IDTagu=TagiPosiłków.IDTagu WHERE Tag.NazwaTagu=@NazwaTagu
)
GO

CREATE FUNCTION WyświetlProduktPoTagu (@NazwaTagu VARCHAR(20))
RETURNS TABLE AS
RETURN 
(
	SELECT Produkty.NazwaProduktu, Produkty.Kalorie, Produkty.Węglowodany, Produkty.Białka, Produkty.Tłuszcze
	FROM Produkty JOIN TagiProduktów ON Produkty.IDProduktu=TagiProduktów.IDProduktu
	JOIN Tag ON Tag.IDTagu=TagiProduktów.IDTagu WHERE Tag.NazwaTagu=@NazwaTagu
)
GO

CREATE FUNCTION WyświetlSkładPosiłku (@Nazwa VARCHAR(100))
RETURNS TABLE AS
RETURN 
(
	SELECT Pr.NazwaProduktu, Pr.Kalorie, Pr.Węglowodany, Pr.Białka, Pr.Tłuszcze, Pr.MasaPorcji FROM
	Posiłki P JOIN SkładPosiłków SP ON P.IDPosiłku = SP.IDPosiłku
	JOIN Produkty Pr ON SP.IDProduktu = Pr.IDProduktu
	WHERE P.NazwaPosiłku = @Nazwa
)
GO

CREATE FUNCTION WyświetlSkładJadłospisu (@Nazwa VARCHAR(100))
RETURNS TABLE AS
RETURN 
(
	SELECT P.NazwaPosiłku, P.Kalorie, P.Węglowodany, P.Białka, P.Tłuszcze FROM
	Jadłospisy J JOIN SkładJadłospisów SJ ON J.IDJadłospisu = SJ.IDJadłospisu
	JOIN Posiłki P ON SJ.IDPosiłku = P.IDPosiłku
	WHERE J.NazwaJadłospisu = @Nazwa
)
GO

CREATE FUNCTION WyświetlSkładTreningu (@Nazwa VARCHAR(100))
RETURNS TABLE AS
RETURN 
(
	SELECT C.NazwaĆwiczenia, C.SpaloneKcal, C.CzasWykonywania FROM
	Treningi T JOIN SkładTreningu ST ON T.IDTreningu = ST.IDTreningu
	JOIN Ćwiczenia C ON ST.IDĆwiczenia = C.IDĆwiczenia
	WHERE T.NazwaTreningu = @Nazwa
)
GO

CREATE FUNCTION WyświetlPomiary(@NazwaUżytkownika VARCHAR(20))
RETURNS TABLE AS
RETURN
(
	SELECT AktualnePomiary.CzasPomiaru, AktualnePomiary.Waga , AktualnePomiary.ObwódPasa
	FROM AktualnePomiary
	JOIN Użytkownicy ON AktualnePomiary.IDUżytkownika=Użytkownicy.IDUżytkownika

)
GO

CREATE FUNCTION WyświetlZapisaneTreningi (@Nazwa VARCHAR(20))
RETURNS TABLE AS
RETURN 
(
	SELECT Treningi.NazwaTreningu, Treningi.StopieńTrudności
    FROM Użytkownicy JOIN ZapisaneTreningi ON Użytkownicy.IDUżytkownika=ZapisaneTreningi.IDUżytkownika JOIN Treningi ON ZapisaneTreningi.IDTreningu=Treningi.IDTreningu
    WHERE Użytkownicy.NazwaUżytkownika=@Nazwa
)
GO

CREATE FUNCTION WyświetlZaplanowaneTreningi (@Nazwa VARCHAR(20))
RETURNS TABLE AS
RETURN 
(
	SELECT ZaplanowaneTreningi.DataRozpoczęcia, ZaplanowaneTreningi.DataZakończenia , Treningi.NazwaTreningu, Treningi.StopieńTrudności
    FROM Użytkownicy JOIN ZaplanowaneTreningi ON Użytkownicy.IDUżytkownika=ZaplanowaneTreningi.IDUżytkownika JOIN Treningi ON ZaplanowaneTreningi.IDTreningu=Treningi.IDTreningu
    WHERE Użytkownicy.NazwaUżytkownika=@Nazwa
)
GO

CREATE FUNCTION WyświetlOcenioneTreningi (@Nazwa VARCHAR(20))
RETURNS TABLE AS
RETURN 
(
	SELECT Treningi.NazwaTreningu, OcenioneTreningi.Ocena
    FROM Użytkownicy JOIN OcenioneTreningi ON Użytkownicy.IDUżytkownika=OcenioneTreningi.IDUżytkownika
	JOIN Treningi ON OcenioneTreningi.IDTreningu=Treningi.IDTreningu
    WHERE Użytkownicy.NazwaUżytkownika=@Nazwa
)
GO

CREATE FUNCTION WyświetlZapisaneJadłospisy (@Nazwa VARCHAR(20))
RETURNS TABLE AS
RETURN 
(
	SELECT Jadłospisy.NazwaJadłospisu, Jadłospisy.Kalorie, Jadłospisy.Węglowodany, Jadłospisy.Białka, Jadłospisy.Tłuszcze
    FROM Użytkownicy JOIN ZapisaneJadłospisy ON Użytkownicy.IDUżytkownika=ZapisaneJadłospisy.IDUżytkownika
	JOIN Jadłospisy ON ZapisaneJadłospisy.IDJadłospisu=Jadłospisy.IDJadłospisu
    WHERE Użytkownicy.NazwaUżytkownika=@Nazwa
)
GO

CREATE FUNCTION WyświetlZaplanowaneJadłospisy (@Nazwa VARCHAR(20))
RETURNS TABLE AS
RETURN 
(
	SELECT ZaplanowaneJadłospisy.Data, Jadłospisy.NazwaJadłospisu, Jadłospisy.Kalorie, Jadłospisy.Węglowodany, Jadłospisy.Białka, Jadłospisy.Tłuszcze
    FROM Użytkownicy JOIN ZaplanowaneJadłospisy ON Użytkownicy.IDUżytkownika=ZaplanowaneJadłospisy.IDUżytkownika
	JOIN Jadłospisy ON ZaplanowaneJadłospisy.IDJadłospisu=Jadłospisy.IDJadłospisu
    WHERE Użytkownicy.NazwaUżytkownika=@Nazwa
)
GO

CREATE FUNCTION WyświetlOcenioneJadłospisy (@Nazwa VARCHAR(20))
RETURNS TABLE AS
RETURN 
(SELECT Jadłospisy.NazwaJadłospisu, OcenioneJadłospisy.Ocena
        FROM Użytkownicy JOIN OcenioneJadłospisy ON Użytkownicy.IDUżytkownika=OcenioneJadłospisy.IDUżytkownika
		JOIN Jadłospisy ON OcenioneJadłospisy.IDJadłospisu=Jadłospisy.IDJadłospisu
        WHERE Użytkownicy.NazwaUżytkownika=@Nazwa
)
GO

CREATE FUNCTION WyświetlZaplanowaneTreningiNaDziś (@Nazwa VARCHAR(20))
RETURNS TABLE AS
RETURN 
(
	SELECT Treningi.NazwaTreningu, Treningi.StopieńTrudności
    FROM Użytkownicy JOIN ZaplanowaneTreningi ON Użytkownicy.IDUżytkownika=ZaplanowaneTreningi.IDUżytkownika
	JOIN Treningi ON ZaplanowaneTreningi.IDTreningu=Treningi.IDTreningu
    WHERE Użytkownicy.NazwaUżytkownika=@Nazwa 
	AND CONVERT(DATE,GETDATE()) BETWEEN ZaplanowaneTreningi.DataRozpoczęcia AND ZaplanowaneTreningi.DataZakończenia
)
GO

CREATE FUNCTION WyświetlZaplanowaneJadłospisyNaDziś (@Nazwa VARCHAR(20))
RETURNS TABLE AS
RETURN 
(
	SELECT Jadłospisy.NazwaJadłospisu, Jadłospisy.Kalorie, Jadłospisy.Węglowodany, Jadłospisy.Białka, Jadłospisy.Tłuszcze
    FROM Użytkownicy JOIN ZaplanowaneJadłospisy ON Użytkownicy.IDUżytkownika=ZaplanowaneJadłospisy.IDUżytkownika
	JOIN Jadłospisy ON ZaplanowaneJadłospisy.IDJadłospisu=Jadłospisy.IDJadłospisu
    WHERE Użytkownicy.NazwaUżytkownika=@Nazwa 
	AND (SELECT DATEDIFF(day,GETDATE(),ZaplanowaneJadłospisy.Data)) = 0
)
GO

CREATE FUNCTION WyświetlZnajomych(@nazwa VARCHAR(20))
RETURNS TABLE AS
RETURN(
SELECT C.NazwaUżytkownika
FROM Użytkownicy A
JOIN Znajomi B ON A.IDUżytkownika=B.IDUżytkownika1
JOIN Użytkownicy C ON B.IDUżytkownika2=C.IDUżytkownika
WHERE A.NazwaUżytkownika=@nazwa
)
GO
--TRIGGER

IF OBJECT_ID ('UżytkownicyTrigger', 'TR') IS NOT NULL  
DROP TRIGGER UżytkownicyTrigger
IF OBJECT_ID ('OcenioneTreningiTrigger', 'TR') IS NOT NULL  
DROP TRIGGER OcenioneTreningiTrigger
IF OBJECT_ID ('OcenioneTreningiUpdateTrigger', 'TR') IS NOT NULL  
DROP TRIGGER OcenioneTreningiUpdateTrigger
IF OBJECT_ID ('OcenioneJadłospisyTrigger', 'TR') IS NOT NULL  
DROP TRIGGER OcenioneJadłospisyTrigger
IF OBJECT_ID ('OcenioneJadłospisyUpdateTrigger', 'TR') IS NOT NULL  
DROP TRIGGER OcenioneJadłospisyUpdateTrigger
IF OBJECT_ID ('ZaplanowaneJadłospisyTrigger', 'TR') IS NOT NULL  
DROP TRIGGER ZaplanowaneJadłospisyTrigger
IF OBJECT_ID ('ZaplanowaneTreningiTrigger', 'TR') IS NOT NULL  
DROP TRIGGER ZaplanowaneTreningiTrigger
IF OBJECT_ID ('ZnajomiTrigger', 'TR') IS NOT NULL  
DROP TRIGGER ZnajomiTrigger
IF OBJECT_ID ('ZapisaneJadłospisyTrigger', 'TR') IS NOT NULL  
DROP TRIGGER ZapisaneJadłospisyTrigger
IF OBJECT_ID ('ZapisaneTreningiTrigger', 'TR') IS NOT NULL  
DROP TRIGGER ZapisaneTreningiTrigger
IF OBJECT_ID ('PomiaryUpdateTrigger', 'TR') IS NOT NULL  
DROP TRIGGER PomiaryUpdateTrigger

GO
CREATE TRIGGER PomiaryUpdateTrigger
ON AktualnePomiary
INSTEAD OF INSERT
AS
BEGIN
	DECLARE @IDUżytkownika INT, @Data DATETIME, @Waga INT, @ObwódPasa INT
	SELECT @IDUżytkownika = INSERTED.IDUżytkownika,
	@Data = SYSDATETIME(),
	@Waga = INSERTED.Waga,
	@ObwódPasa = INSERTED.ObwódPasa FROM INSERTED
	IF (@Waga > 0 AND @ObwódPasa>0)
	BEGIN
		INSERT INTO AktualnePomiary VALUES
				(@IDUżytkownika, @Data, @Waga, @ObwódPasa)
	END
	ELSE
		RAISERROR('Waga lub obwód pasa ujemne', 16,1)
END
GO

CREATE TRIGGER ZapisaneTreningiTrigger
ON ZapisaneTreningi
INSTEAD OF INSERT
AS 
BEGIN
	DECLARE @IDUżytkownika INT, @IDTreningu INT
	SELECT
	@IDUżytkownika = inserted.IDUżytkownika,
	@IDTreningu = inserted.IDTreningu
	FROM INSERTED
	IF EXISTS (SELECT * FROM ZapisaneTreningi WHERE IDUżytkownika = @IDUżytkownika AND IDTreningu = @IDTreningu)
		RAISERROR('Zapisałeś już ten trening', 16,1)
	ELSE
		INSERT INTO ZapisaneTreningi VALUES
		(@IDUżytkownika, @IDTreningu)

END
GO


CREATE TRIGGER ZapisaneJadłospisyTrigger
ON ZapisaneJadłospisy
INSTEAD OF INSERT
AS 
BEGIN
	DECLARE @IDUżytkownika INT, @IDJadłospisu INT
	SELECT
	@IDUżytkownika = inserted.IDUżytkownika,
	@IDJadłospisu = inserted.IDJadłospisu
	FROM INSERTED
	IF EXISTS (SELECT * FROM ZapisaneJadłospisy WHERE IDUżytkownika = @IDUżytkownika AND IDJadłospisu = @IDJadłospisu)
		RAISERROR('Zapisałeś już ten jadłospis', 16,1)
	ELSE
		INSERT INTO ZapisaneJadłospisy VALUES
		(@IDUżytkownika, @IDJadłospisu)

END
GO

CREATE TRIGGER ZnajomiTrigger
ON Znajomi
INSTEAD OF INSERT
AS
BEGIN
	DECLARE	@IDUżytkownika1 INT, @IDUżytkownika2 INT
	SELECT @IDUżytkownika1=INSERTED.IDUżytkownika1,
	@IDUżytkownika2=INSERTED.IDUżytkownika2
	FROM INSERTED
		IF EXISTS (SELECT IDUżytkownika1 FROM Znajomi WHERE IDUżytkownika1 = @IDUżytkownika1 AND IDUżytkownika2 = @IDUżytkownika2)
			BEGIN
				RAISERROR('Taka znajomość już istnieje', 16,1)
			END
		ELSE
			BEGIN
				INSERT INTO Znajomi VALUES
					(@IDUżytkownika1,@IDUżytkownika2),(@IDUżytkownika2,@IDUżytkownika1)
			END 
END
GO

CREATE TRIGGER ZaplanowaneTreningiTrigger
ON ZaplanowaneTreningi
INSTEAD OF INSERT
AS
BEGIN
	DECLARE @IDUżytkownika INT, @IDTreningu INT, @DataRozpoczęcia DATE, @DataZakończenia DATE
	SELECT @IDUżytkownika = INSERTED.IDUżytkownika,
	@IDTreningu = INSERTED.IDTreningu,
	@DataRozpoczęcia = INSERTED.DataRozpoczęcia,
	@DataZakończenia = INSERTED.DataZakończenia FROM INSERTED
	IF (@DataRozpoczęcia <= @DataZakończenia)
		INSERT INTO ZaplanowaneTreningi VALUES
		(@IDUżytkownika, @IDTreningu, @DataRozpoczęcia, @DataZakończenia)
	ELSE
		RAISERROR('Data rozpoczęcia jest późniejsza niż data zakończenia', 16,1)
END
GO

CREATE TRIGGER ZaplanowaneJadłospisyTrigger
ON ZaplanowaneJadłospisy
INSTEAD OF INSERT, UPDATE
AS
BEGIN
	DECLARE @IDUżytkownika INT, @IDJadłospisu INT, @Data DATE
	SELECT @IDUżytkownika = INSERTED.IDUżytkownika,
	@IDJadłospisu = INSERTED.IDJadłospisu,
	@Data = INSERTED.Data FROM INSERTED
	IF NOT EXISTS (SELECT * FROM ZaplanowaneJadłospisy WHERE ZaplanowaneJadłospisy.IDUżytkownika=@IDUżytkownika AND ZaplanowaneJadłospisy.Data=@Data )
		INSERT INTO ZaplanowaneJadłospisy VALUES
		(@IDUżytkownika, @IDJadłospisu, @Data)
	ELSE
		RAISERROR('Na ten dzień jest już zaplanowany jadłospis', 16,1)
END
GO


CREATE TRIGGER OcenioneJadłospisyTrigger
ON OcenioneJadłospisy
INSTEAD OF INSERT
AS BEGIN
	DECLARE @IDUżytkownika INT, @IDJadłospisu INT, @Ocena INT
	SELECT
	@IDUżytkownika = inserted.IDUżytkownika,
	@IDJadłospisu = inserted.IDJadłospisu,
	@Ocena = inserted.Ocena
	FROM INSERTED
	IF EXISTS (SELECT * FROM OcenioneJadłospisy WHERE IDUżytkownika = @IDUżytkownika AND IDJadłospisu = @IDJadłospisu)
		RAISERROR('Dodałeś już ocenę do tego jadłospisu', 16,1)
	ELSE
		IF (@Ocena BETWEEN 1 AND 5)
			INSERT INTO OcenioneJadłospisy VALUES
			(@IDUżytkownika, @IDJadłospisu, @Ocena)
		ELSE
			RAISERROR('Ocena nie zawiera się w skali', 16,1)

END
GO


CREATE TRIGGER OcenioneTreningiTrigger
ON OcenioneTreningi
INSTEAD OF INSERT
AS BEGIN
	DECLARE @IDUżytkownika INT, @IDTreningu INT, @Ocena INT
	SELECT
	@IDUżytkownika = inserted.IDUżytkownika,
	@IDTreningu = inserted.IDTreningu,
	@Ocena = inserted.Ocena
	FROM INSERTED
	IF EXISTS (SELECT * FROM OcenioneTreningi WHERE IDUżytkownika = @IDUżytkownika AND IDTreningu = @IDTreningu)
		RAISERROR('Dodałeś już ocenę do tego treningu', 16,1)
	ELSE
		IF (@Ocena BETWEEN 1 AND 5)
			INSERT INTO OcenioneTreningi VALUES
			(@IDUżytkownika, @IDTreningu, @Ocena)
		ELSE
			RAISERROR('Ocena nie zawiera się w skali', 16,1)

END
GO

CREATE TRIGGER OcenioneTreningiUpdateTrigger
ON OcenioneTreningi
INSTEAD OF UPDATE
AS BEGIN
	DECLARE @IDUżytkownika INT, @IDTreningu INT, @Ocena INT
	SELECT
	@IDUżytkownika = inserted.IDUżytkownika,
	@IDTreningu = inserted.IDTreningu,
	@Ocena = inserted.Ocena
	FROM INSERTED	
	IF (@Ocena BETWEEN 1 AND 5)
		UPDATE OcenioneTreningi
		SET Ocena = @Ocena
		WHERE IDUżytkownika = @IDUżytkownika AND IDTreningu = @IDTreningu
	ELSE
		RAISERROR('Ocena nie zawiera się w skali', 16,1)

END
GO

CREATE TRIGGER OcenioneJadłospisyUpdateTrigger
ON OcenioneJadłospisy
INSTEAD OF UPDATE
AS BEGIN
	DECLARE @IDUżytkownika INT, @IDJadłospisu INT, @Ocena INT
	SELECT
	@IDUżytkownika = inserted.IDUżytkownika,
	@IDJadłospisu = inserted.IDJadłospisu,
	@Ocena = inserted.Ocena
	FROM INSERTED	
	IF (@Ocena BETWEEN 1 AND 5)
		UPDATE OcenioneJadłospisy
		SET Ocena = @Ocena
		WHERE IDUżytkownika = @IDUżytkownika AND IDJadłospisu = @IDJadłospisu
	ELSE
		RAISERROR('Ocena nie zawiera się w skali', 16,1)

END
GO

CREATE TRIGGER UżytkownicyTrigger
ON Użytkownicy
INSTEAD OF INSERT
AS
BEGIN
	DECLARE @IDUżytkownika INT, @NazwaUżytkownika VARCHAR(20), @ImięUżytkownika VARCHAR(20), @NazwiskoUżytkownika VARCHAR(20), @NumerTelefonu VARCHAR(9)
	SELECT @IDUżytkownika = INSERTED.IDUżytkownika,
	@NazwaUżytkownika = INSERTED.NazwaUżytkownika,
	@ImięUżytkownika = INSERTED.ImięUżytownika,
	@NazwiskoUżytkownika = INSERTED.NazwiskoUżytkownika,
	@NumerTelefonu = INSERTED.NumerTelefonu
	FROM INSERTED
		IF EXISTS (SELECT NazwaUżytkownika FROM Użytkownicy WHERE NazwaUżytkownika = @NazwaUżytkownika)
			BEGIN
				RAISERROR('Zajęta nazwa użytkownika!', 16,1)
			END
		ELSE
			BEGIN
				IF (LEN(@NumerTelefonu)=9 AND ISNUMERIC(@NumerTelefonu)=1)
					BEGIN
						INSERT INTO Użytkownicy VALUES
						(@NazwaUżytkownika,@ImięUżytkownika,@NazwiskoUżytkownika,@NumerTelefonu)
						DECLARE @ID INT
						SET @ID=(SELECT MAX(IDUżytkownika) FROM Użytkownicy)
						INSERT INTO ListaZakupów VALUES
						('Biedronka',@ID),('Lidl',@ID)
					END
				ELSE
					RAISERROR('Numer telefonu ma za mało cyfr lub znaki niebędące cyframi', 16,1)
			END 
END

--PROCEDURE
GO
IF OBJECT_ID('AktualizujPomiar','P') IS NOT NULL
DROP PROC AktualizujPomiar
IF OBJECT_ID('DodajUżytkownika','P') IS NOT NULL
DROP PROC DodajUżytkownika
IF OBJECT_ID('DodajDoListyZakupów','P') IS NOT NULL
DROP PROC DodajDoListyZakupów
IF OBJECT_ID('UsuńZListyZakupów','P') IS NOT NULL
DROP PROC UsuńZListyZakupów
IF OBJECT_ID('DodajOcenęTreningu','P') IS NOT NULL
DROP PROC DodajOcenęTreningu
IF OBJECT_ID('DodajOcenęJadłospisu','P') IS NOT NULL
DROP PROC DodajOcenęJadłospisu
IF OBJECT_ID('ZaplanujTrening','P') IS NOT NULL
DROP PROC ZaplanujTrening
IF OBJECT_ID('ZaplanujJadłospis','P') IS NOT NULL
DROP PROC ZaplanujJadłospis
IF OBJECT_ID('ZapiszTrening','P') IS NOT NULL
DROP PROC ZapiszTrening
IF OBJECT_ID('ZapiszJadłospis','P') IS NOT NULL
DROP PROC ZapiszJadłospis
IF OBJECT_ID('ZmieńOcenęTreningu','P') IS NOT NULL
DROP PROC ZmieńOcenęTreningu
IF OBJECT_ID('ZmieńOcenęJadłospisu','P') IS NOT NULL
DROP PROC ZmieńOcenęJadłospisu
IF OBJECT_ID('DodajZnajomego','P') IS NOT NULL
DROP PROC DodajZnajomego
GO

CREATE PROCEDURE AktualizujPomiar
(@Nazwa VARCHAR(20), @Waga INT, @ObwódPasa INT)
AS
DECLARE @IDUżytkownika VARCHAR(20)
DECLARE @DataPomiaru DATETIME
SET @IDUżytkownika=(SELECT IDUżytkownika FROM Użytkownicy WHERE Użytkownicy.NazwaUżytkownika=@nazwa)
SET @DataPomiaru=SYSDATETIME()
INSERT INTO AktualnePomiary VALUES
(@IDUżytkownika,@dataPomiaru,@waga,@obwódPasa)
GO

CREATE PROCEDURE DodajZnajomego
(@NazwaUżytkownika1 VARCHAR(20),@NazwaUżytkownika2 VARCHAR(100))
AS
DECLARE @IDUżytkownika1 INT, @IDUżytkownika2 INT
SET @IDUżytkownika1=(SELECT IDUżytkownika FROM Użytkownicy WHERE Użytkownicy.NazwaUżytkownika=@NazwaUżytkownika1)
SET @IDUżytkownika2=(SELECT IDUżytkownika FROM Użytkownicy WHERE Użytkownicy.NazwaUżytkownika=@NazwaUżytkownika2)
INSERT INTO Znajomi
VALUES (@IDUżytkownika1,@IDUżytkownika2),(@IDUżytkownika2,@IDUżytkownika1)
GO

CREATE PROCEDURE ZmieńOcenęJadłospisu
(@NazwaUżytkownika VARCHAR(20),@NazwaJadłospisu VARCHAR(100),@Ocena INT)
AS
DECLARE @IDUżytkownika INT, @IDJadłospisu INT
SET @IDUżytkownika=(SELECT IDUżytkownika FROM Użytkownicy WHERE Użytkownicy.NazwaUżytkownika=@NazwaUżytkownika)
SET @IDJadłospisu=(SELECT IDJadłospisu FROM Jadłospisy WHERE Jadłospisy.NazwaJadłospisu=@NazwaJadłospisu)
UPDATE OcenioneJadłospisy
SET OcenioneJadłospisy.Ocena=@Ocena WHERE OcenioneJadłospisy.IDUżytkownika=@IDUżytkownika AND OcenioneJadłospisy.IDJadłospisu=@IDJadłospisu
GO

CREATE PROCEDURE ZmieńOcenęTreningu
(@NazwaUżytkownika VARCHAR(20),@NazwaTreningu VARCHAR(100),@Ocena INT)
AS
DECLARE @IDUżytkownika INT, @IDTreningu INT
SET @IDUżytkownika=(SELECT IDUżytkownika FROM Użytkownicy WHERE Użytkownicy.NazwaUżytkownika=@NazwaUżytkownika)
SET @IDTreningu=(SELECT IDTreningu FROM Treningi WHERE Treningi.NazwaTreningu=@NazwaTreningu)
UPDATE OcenioneTreningi 
SET
Ocena = @Ocena
WHERE IDUżytkownika = @IDUżytkownika AND IDTreningu = @IDTreningu
GO

CREATE PROCEDURE ZapiszTrening
(@NazwaUżytkownika VARCHAR(20),@NazwaTreningu VARCHAR(100))
AS
DECLARE @IDUżytkownika INT, @IDTreningu INT
SET @IDUżytkownika=(SELECT IDUżytkownika FROM Użytkownicy WHERE Użytkownicy.NazwaUżytkownika=@NazwaUżytkownika)
SET @IDTreningu=(SELECT IDTreningu FROM Treningi WHERE Treningi.NazwaTreningu=@NazwaTreningu)
INSERT INTO ZapisaneTreningi VALUES
(@IDUżytkownika,@IDTreningu)
GO

CREATE PROCEDURE ZapiszJadłospis
(@NazwaUżytkownika VARCHAR(20),@NazwaJadłospisu VARCHAR(100))
AS
DECLARE @IDUżytkownika INT, @IDJadłospisu INT
SET @IDUżytkownika=(SELECT IDUżytkownika FROM Użytkownicy WHERE Użytkownicy.NazwaUżytkownika=@NazwaUżytkownika)
SET @IDJadłospisu=(SELECT IDJadłospisu FROM Jadłospisy WHERE Jadłospisy.NazwaJadłospisu=@NazwaJadłospisu)
INSERT INTO ZapisaneJadłospisy VALUES
(@IDUżytkownika,@IDJadłospisu)
GO

CREATE PROCEDURE ZaplanujTrening
(@NazwaUżytkownika VARCHAR(20),@NazwaTreningu VARCHAR(100),@DataRozpoczęcia DATE, @DataZakończenia DATE)
AS
DECLARE @IDUżytkownika INT, @IDTreningu INT
SET @IDUżytkownika=(SELECT IDUżytkownika FROM Użytkownicy WHERE Użytkownicy.NazwaUżytkownika=@NazwaUżytkownika)
SET @IDTreningu=(SELECT IDTreningu FROM Treningi WHERE Treningi.NazwaTreningu=@NazwaTreningu)
INSERT INTO ZaplanowaneTreningi VALUES
(@IDUżytkownika,@IDTreningu,@DataRozpoczęcia,@DataZakończenia)
GO

CREATE PROCEDURE ZaplanujJadłospis
(@NazwaUżytkownika VARCHAR(20),@NazwaJadłospisu VARCHAR(100),@Data DATE)
AS
DECLARE @IDUżytkownika INT, @IDJadłospisu INT
SET @IDUżytkownika=(SELECT IDUżytkownika FROM Użytkownicy WHERE Użytkownicy.NazwaUżytkownika=@NazwaUżytkownika)
SET @IDJadłospisu=(SELECT IDJadłospisu FROM Jadłospisy WHERE Jadłospisy.NazwaJadłospisu=@NazwaJadłospisu)
INSERT INTO ZaplanowaneJadłospisy VALUES
(@IDUżytkownika,@IDJadłospisu,@Data)
GO

CREATE PROCEDURE DodajOcenęTreningu
(@NazwaUżytkownika VARCHAR(20),@NazwaTreningu VARCHAR(100),@Ocena INT)
AS
DECLARE @IDUżytkownika INT, @IDTreningu INT
SET @IDUżytkownika=(SELECT IDUżytkownika FROM Użytkownicy WHERE Użytkownicy.NazwaUżytkownika=@NazwaUżytkownika)
SET @IDTreningu=(SELECT IDTreningu FROM Treningi WHERE Treningi.NazwaTreningu=@NazwaTreningu)
INSERT INTO OcenioneTreningi VALUES
(@IDUżytkownika,@IDTreningu,@Ocena)
GO

CREATE PROCEDURE DodajOcenęJadłospisu
(@NazwaUżytkownika VARCHAR(20),@NazwaJadłospisu VARCHAR(100),@Ocena INT)
AS
DECLARE @IDUżytkownika INT, @IDJadłospisu INT
SET @IDUżytkownika=(SELECT IDUżytkownika FROM Użytkownicy WHERE Użytkownicy.NazwaUżytkownika=@NazwaUżytkownika)
SET @IDJadłospisu=(SELECT IDJadłospisu FROM Jadłospisy WHERE Jadłospisy.NazwaJadłospisu=@NazwaJadłospisu)
INSERT INTO OcenioneJadłospisy VALUES
(@IDUżytkownika,@IDJadłospisu,@Ocena)
GO

CREATE PROCEDURE UsuńZListyZakupów
(@NazwaProduktu VARCHAR(100), @NazwaSklepu VARCHAR(100), @NazwaUżytkownika VARCHAR(20))
AS
	DECLARE @IDProduktu INT, @IDListy INT, @IDUżytkownika INT
	SET @IDUżytkownika=(SELECT IDUżytkownika FROM Użytkownicy WHERE Użytkownicy.NazwaUżytkownika=@NazwaUżytkownika)
	SET @IDListy=(SELECT IDListy FROM ListaZakupów WHERE ListaZakupów.NazwaSklepu=@NazwaSklepu AND ListaZakupów.IDUżytkownika=@IDUżytkownika)
	SET @IDProduktu = (SELECT IDProduktu FROM Produkty WHERE NazwaProduktu = @NazwaProduktu)
	DELETE  FROM SkładListyZakupów WHERE 
	SkładListyZakupów.IDListy=@IDListy AND SkładListyZakupów.IDProduktu=@IDProduktu

GO

CREATE PROCEDURE DodajDoListyZakupów
(@NazwaProduktu VARCHAR(100), @NazwaSklepu VARCHAR(100), @NazwaUżytkownika VARCHAR(20), @IlośćPorcji INT)
AS
	DECLARE @IDProduktu INT, @IDListy INT, @IDUżytkownika INT
	SET @IDUżytkownika=(SELECT IDUżytkownika FROM Użytkownicy WHERE Użytkownicy.NazwaUżytkownika=@NazwaUżytkownika)
	SET @IDListy=(SELECT IDListy FROM ListaZakupów WHERE ListaZakupów.NazwaSklepu=@NazwaSklepu AND ListaZakupów.IDUżytkownika=@IDUżytkownika)
	SET @IDProduktu = (SELECT IDProduktu FROM Produkty WHERE NazwaProduktu = @NazwaProduktu)
	INSERT INTO SkładListyZakupów VALUES
	(@IDListy,@IDProduktu,@IlośćPorcji)
GO
 
CREATE PROCEDURE DodajUżytkownika
(@NazwaUżytkownika VARCHAR(20), @ImięUżytkownika VARCHAR(20), @NazwiskoUżytkownika VARCHAR(20), @NumerTelefonu VARCHAR(9))
AS
INSERT INTO Użytkownicy VALUES
(@NazwaUżytkownika, @ImięUżytkownika, @NazwiskoUżytkownika, @NumerTelefonu)
GO

--VIEW

IF OBJECT_ID('WyświetlSkładyTreningów','V') IS NOT NULL
DROP VIEW WyświetlSkładyTreningów
IF OBJECT_ID('WyświetlJadłospisy','V') IS NOT NULL
DROP VIEW WyświetlJadłospisy
IF OBJECT_ID('WyświetlSkładyJadłospisów','V') IS NOT NULL
DROP VIEW WyświetlSkładyJadłospisów
IF OBJECT_ID('WyświetlProdukty','V') IS NOT NULL
DROP VIEW WyświetlProdukty
IF OBJECT_ID('WyświetlTreningi','V') IS NOT NULL
DROP VIEW WyświetlTreningi
IF OBJECT_ID('WyświetlTagiSportowe','V') IS NOT NULL
DROP VIEW WyświetlTagiSportowe
IF OBJECT_ID('WyświetlTagiSpożywcze','V') IS NOT NULL
DROP VIEW WyświetlTagiSpożywcze
IF OBJECT_ID('WyświetlPosiłki','V') IS NOT NULL
DROP VIEW WyświetlPosiłki

GO
CREATE VIEW WyświetlPosiłki AS
SELECT Posiłki.NazwaPosiłku, Posiłki.Kalorie, Posiłki.Węglowodany, Posiłki.Białka, Posiłki.Tłuszcze FROM
Posiłki
GO

CREATE VIEW WyświetlTagiSportowe AS
SELECT Tag.NazwaTagu, TagSportowy.Ogólnorozwojowy FROM
Tag JOIN TagSportowy ON Tag.IDTagu=TagSportowy.IDTagu
GO

CREATE VIEW WyświetlTagiSpożywcze AS
SELECT Tag.NazwaTagu, TagSpożywczy.OpisTagu FROM
Tag JOIN TagSpożywczy ON Tag.IDTagu=TagSpożywczy.IDTagu
GO

CREATE VIEW WyświetlTreningi AS
SELECT T.NazwaTreningu, A.NazwaTagu, B.Ogólnorozwojowy FROM 
Treningi T JOIN TagiTreningów TT on T.IDTreningu = TT.IDTreningu
JOIN Tag A ON A.IDTagu = TT.IDTagu  
JOIN TagSportowy B ON A.IDTagu = B.IDTagu
GO

CREATE VIEW WyświetlProdukty AS
SELECT Produkty.NazwaProduktu, Produkty.Kalorie, Produkty.MasaPorcji, Produkty.Węglowodany, Produkty.Białka, Produkty.Tłuszcze FROM Produkty
GO 

CREATE VIEW WyświetlSkładyJadłospisów AS
SELECT Jadłospisy.NazwaJadłospisu, Posiłki.NazwaPosiłku
FROM Jadłospisy JOIN SkładJadłospisów
ON Jadłospisy.IDJadłospisu=SkładJadłospisów.IDJadłospisu
JOIN Posiłki ON SkładJadłospisów.IDPosiłku=Posiłki.IDPosiłku
GO

CREATE VIEW WyświetlJadłospisy AS
SELECT Jadłospisy.NazwaJadłospisu, Jadłospisy.Kalorie, Jadłospisy.Węglowodany, Jadłospisy.Białka, Jadłospisy.Tłuszcze FROM Jadłospisy
GO 

CREATE VIEW WyświetlSkładyTreningów AS
SELECT Treningi.NazwaTreningu, Ćwiczenia.NazwaĆwiczenia
FROM Treningi JOIN SkładTreningu
ON Treningi.IDTreningu=SkładTreningu.IDTreningu
JOIN Ćwiczenia ON SkładTreningu.IDĆwiczenia=Ćwiczenia.IDĆwiczenia
GO








