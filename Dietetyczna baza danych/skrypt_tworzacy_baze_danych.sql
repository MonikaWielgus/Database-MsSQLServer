--CREATE

IF OBJECT_ID('dbo.AktualnePomiary') IS NOT NULL
DROP TABLE dbo.AktualnePomiary
IF OBJECT_ID('dbo.Znajomi') IS NOT NULL
DROP TABLE dbo.Znajomi
IF OBJECT_ID('dbo.Sk�adJad�ospis�w') IS NOT NULL
DROP TABLE dbo.Sk�adJad�ospis�w
IF OBJECT_ID('dbo.ZaplanowaneJad�ospisy') IS NOT NULL
DROP TABLE dbo.ZaplanowaneJad�ospisy
IF OBJECT_ID('dbo.ZapisaneJad�ospisy') IS NOT NULL
DROP TABLE dbo.ZapisaneJad�ospisy
IF OBJECT_ID('dbo.OcenioneJad�ospisy') IS NOT NULL
DROP TABLE dbo.OcenioneJad�ospisy
IF OBJECT_ID('dbo.Jad�ospisy') IS NOT NULL
DROP TABLE dbo.Jad�ospisy
IF OBJECT_ID('dbo.Sk�adListyZakup�w') IS NOT NULL
DROP TABLE dbo.Sk�adListyZakup�w
IF OBJECT_ID('dbo.Sk�adPosi�k�w') IS NOT NULL
DROP TABLE dbo.Sk�adPosi�k�w
IF OBJECT_ID('dbo.Sk�adTreningu') IS NOT NULL
DROP TABLE dbo.Sk�adTreningu
IF OBJECT_ID('dbo.TagiTrening�w') IS NOT NULL
DROP TABLE dbo.TagiTrening�w
IF OBJECT_ID('dbo.ZaplanowaneTreningi') IS NOT NULL
DROP TABLE dbo.ZaplanowaneTreningi
IF OBJECT_ID('dbo.ZapisaneTreningi') IS NOT NULL
DROP TABLE dbo.ZapisaneTreningi
IF OBJECT_ID('dbo.OcenioneTreningi') IS NOT NULL
DROP TABLE dbo.OcenioneTreningi
IF OBJECT_ID('dbo.Treningi') IS NOT NULL
DROP TABLE dbo.Treningi
IF OBJECT_ID('dbo.Tagi�wicze�') IS NOT NULL
DROP TABLE dbo.Tagi�wicze�
IF OBJECT_ID('dbo.�wiczenia') IS NOT NULL
DROP TABLE dbo.�wiczenia
IF OBJECT_ID('dbo.TagiProdukt�w') IS NOT NULL
DROP TABLE dbo.TagiProdukt�w
IF OBJECT_ID('dbo.TagiPosi�k�w') IS NOT NULL
DROP TABLE dbo.TagiPosi�k�w
IF OBJECT_ID('dbo.Posi�ki') IS NOT NULL
DROP TABLE dbo.Posi�ki
IF OBJECT_ID('dbo.TagSportowy') IS NOT NULL
DROP TABLE dbo.TagSportowy
IF OBJECT_ID('dbo.TagSpo�ywczy') IS NOT NULL
DROP TABLE dbo.TagSpo�ywczy
IF OBJECT_ID('dbo.Tag') IS NOT NULL
DROP TABLE dbo.Tag
IF OBJECT_ID('dbo.Produkty') IS NOT NULL
DROP TABLE dbo.Produkty
IF OBJECT_ID('dbo.Producenci') IS NOT NULL
DROP TABLE dbo.Producenci
IF OBJECT_ID('dbo.ListaZakup�w') IS NOT NULL
DROP TABLE dbo.ListaZakup�w
IF OBJECT_ID('dbo.U�ytkownicy') IS NOT NULL
DROP TABLE dbo.U�ytkownicy

CREATE TABLE Treningi(
IDTreningu INT PRIMARY KEY IDENTITY(1,1),
NazwaTreningu VARCHAR(100) NOT NULL,
Stopie�Trudno�ci VARCHAR(50) NOT NULL
)
CREATE TABLE �wiczenia(
ID�wiczenia INT PRIMARY KEY IDENTITY(1,1),
Nazwa�wiczenia VARCHAR(100) NOT NULL,
SpaloneKcal INT,
[CzasWykonywania] INT 
)
CREATE TABLE U�ytkownicy(
IDU�ytkownika INT PRIMARY KEY IDENTITY(1,1),
NazwaU�ytkownika VARCHAR(20) NOT NULL,
Imi�U�ytownika VARCHAR(20) NOT NULL,
NazwiskoU�ytkownika VARCHAR(20) NOT NULL,
NumerTelefonu VARCHAR(9)
)
CREATE TABLE Posi�ki(
IDPosi�ku INT PRIMARY KEY IDENTITY(1,1),
NazwaPosi�ku VARCHAR(100) NOT NULL,
Kalorie FLOAT NOT NULL,
W�glowodany FLOAT NOT NULL,
Bia�ka FLOAT NOT NULL,
T�uszcze FLOAT NOT NULL,
)
CREATE TABLE Tag(
IDTagu INT PRIMARY KEY IDENTITY(1,1),
NazwaTagu VARCHAR(100) NOT NULL
)
CREATE TABLE TagSportowy(
IDTagu INT REFERENCES Tag(IDTagu),
Og�lnorozwojowy VARCHAR(3),
PRIMARY KEY(IDTagu)
)
CREATE TABLE TagSpo�ywczy(
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
W�glowodany FLOAT NOT NULL,
Bia�ka FLOAT NOT NULL,
T�uszcze FLOAT NOT NULL,
MasaPorcji FLOAT NOT NULL
)
CREATE TABLE ListaZakup�w(
IDListy INT PRIMARY KEY IDENTITY(1,1),
NazwaSklepu VARCHAR(20),
IDU�ytkownika INT REFERENCES U�ytkownicy(IDU�ytkownika)
)

CREATE TABLE Sk�adTreningu(
IDTreningu INT REFERENCES Treningi(IDTreningu),
ID�wiczenia INT REFERENCES �wiczenia(ID�wiczenia),
Ilo��Powt�rze�Jednostki�wiczeniowej INT NOT NULL,
PRIMARY KEY(IDTreningu,ID�wiczenia)
)
CREATE TABLE TagiTrening�w(
IDTreningu INT REFERENCES Treningi(IDTreningu),
IDTagu INT REFERENCES TagSportowy(IDTagu)
)
CREATE TABLE ZaplanowaneTreningi(
IDU�ytkownika INT REFERENCES U�ytkownicy(IDU�ytkownika),
IDTreningu INT REFERENCES Treningi(IDTreningu),
DataRozpocz�cia DATE NOT NULL,
DataZako�czenia DATE NOT NULL,
)
CREATE TABLE ZapisaneTreningi(
IDU�ytkownika INT REFERENCES U�ytkownicy(IDU�ytkownika),
IDTreningu INT REFERENCES Treningi(IDTreningu),
UNIQUE(IDU�ytkownika,IDTreningu)
)
CREATE TABLE OcenioneTreningi(
IDU�ytkownika INT REFERENCES U�ytkownicy(IDU�ytkownika),
IDTreningu INT REFERENCES Treningi(IDTreningu),
Ocena INT NOT NULL,
UNIQUE(IDU�ytkownika,IDTreningu)
)
CREATE TABLE Tagi�wicze�(
ID�wiczenia INT REFERENCES �wiczenia(ID�wiczenia),
IDTagu INT REFERENCES TagSportowy(IDTagu)
)
CREATE TABLE TagiPosi�k�w(
IDPosi�ku INT REFERENCES Posi�ki(IDPosi�ku),
IDTagu INT REFERENCES TagSpo�ywczy(IDTagu)
)
CREATE TABLE TagiProdukt�w(
IDProduktu INT REFERENCES Produkty(IDProduktu),
IDTagu INT REFERENCES TagSpo�ywczy(IDTagu)
)
CREATE TABLE Jad�ospisy(
IDJad�ospisu INT PRIMARY KEY IDENTITY(1,1),
NazwaJad�ospisu VARCHAR(100) NOT NULL,
Kalorie INT NOT NULL,
W�glowodany FLOAT NOT NULL,
Bia�ka FLOAT NOT NULL,
T�uszcze FLOAT NOT NULL,
)
CREATE TABLE Sk�adPosi�k�w(
IDPosi�ku INT REFERENCES Posi�ki(IDPosi�ku),
IDProduktu INT REFERENCES Produkty(IDProduktu),
Ilo��Porcji FLOAT NOT NULL
)
CREATE TABLE Sk�adListyZakup�w(
IDListy INT REFERENCES ListaZakup�w(IDListy),
IDProduktu INT REFERENCES Produkty(IDProduktu),
Ilo��Porcji FLOAT NOT NULL,
UNIQUE(IDListy, IDProduktu)
)
CREATE TABLE ZaplanowaneJad�ospisy(
IDU�ytkownika INT REFERENCES U�ytkownicy(IDU�ytkownika),
IDJad�ospisu INT REFERENCES Jad�ospisy(IDJad�ospisu),
Data DATE NOT NULL
)
CREATE TABLE ZapisaneJad�ospisy(
IDU�ytkownika INT REFERENCES U�ytkownicy(IDU�ytkownika),
IDJad�ospisu INT REFERENCES Jad�ospisy(IDJad�ospisu),
UNIQUE(IDU�ytkownika,IDJad�ospisu)
)
CREATE TABLE OcenioneJad�ospisy(
IDU�ytkownika INT REFERENCES U�ytkownicy(IDU�ytkownika),
IDJad�ospisu INT REFERENCES Jad�ospisy(IDJad�ospisu),
Ocena INT NOT NULL,
UNIQUE(IDU�ytkownika,IDJad�ospisu)
)
CREATE TABLE AktualnePomiary(
IDU�ytkownika INT REFERENCES U�ytkownicy(IDU�ytkownika),
CzasPomiaru DATETIME NOT NULL,
Waga INT NOT NULL,
Obw�dPasa INT NOT NULL,
UNIQUE(IDU�ytkownika, CzasPomiaru)
)

CREATE TABLE Znajomi(
IDPary INT PRIMARY KEY IDENTITY(1,1),
IDU�ytkownika1 INT REFERENCES U�ytkownicy(IDU�ytkownika),
IDU�ytkownika2 INT REFERENCES U�ytkownicy(IDU�ytkownika)
)
CREATE TABLE Sk�adJad�ospis�w(
IDJad�ospisu INT REFERENCES Jad�ospisy(IDJad�ospisu),
IDPosi�ku INT REFERENCES Posi�ki(IDPosi�ku)
)

--INSERT


INSERT INTO Tag VALUES
('wegetaria�ski'),
('wegetaria�ski + ryby'),
('wega�ski'),
('mi�sne'),
('bez nabia�u'),
('bez glutenu'),
('Brzuch'),
('Nogi'),
('R�ce'),
('Plecy'),
('Cardio'),
('Si�owe'),
('Na �wie�ym powietrzu'),
('Bez sprz�tu'),
('Dru�ynowe'),
('Indywidualne'),
('Zimowe'),
('Wodne')


INSERT INTO TagSpo�ywczy VALUES
(1,'nie zawiera produkt�w mi�snych ani rybnych'),
(2,'nie zawiera produkt�w mi�snych'),
(3,'nie zawiera produkt�w pochodzenia zwierz�cego'),
(4,'zawiera mi�so'),
(5,'nie zawiera produkt�w mlecznych'),
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
('Domowy Ogr�dek Hani i Helenki'),
('Warzywa i Owoce Rudy i sp�ka'),
('Zak�ady Mleczarskie �nie�ynka'),
('Wyroby mleczne Bacu�'),
('Masarnia �winka'),
('Wyroby mi�sne Krowa i Kurczak'),
('Hurtownia spo�ywcza Bajka'),
('Sklep z alkoholami Beczka'),
('Danone'),
('Mlekovita'),
('Rians'),
('Roussas'),
('Pi�tnica'),
('S.M. Bieluch Che�m'),
('Kraft Foods'),
('Piekarnia T�usty P�czek')
INSERT INTO Produkty VALUES
('P�atki owsiane', 8, 389, 66, 17, 7, 100),
('Chleb �ytni', 17, 72, 14, 2, 1, 30),
('Bu�ka grahamka', 17, 88, 18, 3, 1, 30),
('Chleb graham', 17, 70, 16, 2, 1, 30),
('S�onecznik pestki', 8, 584, 20, 20, 51, 100),
('Kasza jaglana', 8, 378, 72, 11, 4, 100),
('Chleb pszenno-�ytni', 17, 70, 15, 1, 1, 30),
('Bu�ka kajzerka', 17, 95, 17, 3, 1, 30),
('Ry� br�zowy', 8, 354, 72, 8, 3, 100),
('Chleb pszenny', 17, 67, 18, 3, 1, 30),
('Otr�by pszenne', 8, 185, 61, 16, 5, 100),
('Ry� paraboliczny', 8, 365, 79, 8, 1, 100),
('M�ka pszenna', 8, 364, 76, 10, 1, 100),
('Makaron pe�noziarnisty', 8, 340, 58, 15, 3, 100),
('Bu�ka tarta', 8, 363, 76, 9, 2, 100),
('Chleb orkiszowy', 17, 73, 14, 3, 2, 30),
('Otr�by owsiane', 8, 361, 46, 18 , 8, 100),
('Musli owocowe', 8, 367, 72, 9, 5, 100),
('Kasza gryczana', 8, 355, 70, 13, 3, 100),
('Kasza kuskus', 8, 342, 68, 13, 2, 100),
('Chleb tostowy pe�noziarnisty', 17, 90, 15, 3, 2, 30),
('M�ka �ytnia', 8, 349, 75, 11, 2, 100),
('Wafle ry�owe', 8, 374, 81, 8, 3, 100),
('Ry� bia�y', 8, 350, 79, 7, 1, 100),
('M�ka pszenna pe�noziarnista', 8, 340, 72, 13, 3, 100),
('Makaron jajeczny', 8, 146, 27, 6, 2, 100),
('Pieczywo chrupkie', 8, 368, 77, 9, 2, 100),
('Kasza j�czmienna', 8, 338, 70, 10, 1, 100),
('P�atki kukurydziane', 8, 399, 90, 8, 1, 100),
('Komosa ry�owa', 8, 368, 64, 14, 6, 100),
('Ry� Basmati', 8, 351, 76, 9, 1, 100),
('Sezam', 8, 572, 23, 18, 50, 100),
('Tortilla (placek)', 8, 315, 56, 6, 7, 100),
('Makaron razowy', 8, 318, 61, 14, 2, 100),
('Chia', 8, 402, 1, 23, 33, 100),
('Kasza manna', 8, 348, 74, 9, 1, 100),
('M�ka owsiana', 8, 404, 66, 15, 9, 100),
('Dynia nasiona', 8, 559, 11, 30, 50, 100),
('Makaron Lasagne', 8, 348, 71, 12, 1, 100),
('Sucharki', 8, 399, 69, 13, 7, 100), 
('Makaron spaghetti',8, 324, 50, 9, 1, 100),
('Obwarzanek krakowski', 17, 253, 50, 5, 3, 100),
('M�ka orkiszowa', 8, 326, 60, 14, 2, 100),
('M�ka kokosowa', 8, 312, 13, 11, 24, 100),
('Granola', 8, 429, 60, 70, 17, 100),
('Kasza bulgur', 8, 342, 76, 12, 1, 100), 
('M�ka gryczana', 8, 335, 71, 13, 3, 100),
('Ry� ja�minowy', 8, 355, 79, 7, 1, 100),
('Kurczak (pier� bez sk�ry)', 6, 121, 0, 22, 4, 100),
('�oso� w�dzony', 6, 153, 0, 25, 5, 100),
('Makrela w�dzona', 7, 201, 0, 26, 10, 100),
('Pol�dwica sopocka', 6, 111, 1, 19, 3, 100),
('Szynka', 7, 96, 0, 17, 3, 100),
('Indyk (pier� bez sk�ry)', 6, 104, 4, 17, 2, 100),
('W�dlina z piersi indyka', 7, 90, 2, 20, 1, 100),
('Szynka wieprzowa gotowana', 7, 232, 1, 17, 18, 100),
('Szynka z piersi kurczaka', 7, 85, 2, 16, 2, 100),
('Dorsz', 6, 91, 1, 15, 2, 100),
('Mi�so mielone drobiowe', 6, 143, 0, 19, 8, 100),
('Kotlet schabowy', 6, 318, 12, 15, 25, 100),
('Tu�czyk', 6, 106, 0, 24, 1, 100),
('Szynka parme�ska',6, 222, 1, 28, 12, 100),
('Szynka z indyka', 6, 126, 2, 18, 5, 100),
('Kie�basa krakowska sucha', 7, 326, 0, 26, 25, 100),
('Pier� z kurczaka w�dzona', 7, 107, 0, 23, 1, 100),
('Par�wki', 6, 251, 3, 13, 21, 100),
('Wo�owina', 6, 160, 0, 21, 8, 100),
('Kark�wka wieprzowa',7,  389, 0, 23, 33, 100),
('Mi�so mielone wo�owe', 7, 254, 0, 17, 20, 100),
('Pasztet z drobiu', 7, 149, 1, 22, 6, 100),
('Kie�basa �l�ska', 7, 214, 0, 18, 16, 100),
('Kaszanka', 6, 274, 15, 9, 20, 100),
('Kie�basa', 7, 214, 0, 18, 16, 100),
('Mi�so mielone wieprzowe', 6, 264, 0, 21, 20, 100),
('Boczek', 6, 478, 1, 13, 47, 100),
('Salami', 6, 459, 0, 22, 41, 100),
('Kabanos wieprzowy', 7, 328, 0, 28, 24, 100),
('Frankfurterki', 6, 305, 2, 12, 28, 100),
('Pasztet wieprzowo-wo�owy', 7, 295, 3, 19, 22, 100),
('Pstr�g', 7, 130, 0, 25, 3, 100),
('Krewetki', 7, 106, 1, 21, 2, 100),
('Kaczka', 7, 337, 0, 19, 29, 100),
('Tatar', 7, 118, 1, 18, 5, 100),
('Kurczak - podudzie', 6, 300, 0, 23, 27, 100),
('�led�', 6, 216, 0, 20, 15, 100),
('Sola', 6, 87, 0, 18, 1, 100),
('�eberka wieprzowe',7, 359, 0, 22, 30, 100),
('Metka', 7, 135, 1, 15, 8, 100),
('Jaja przepi�rcze', 2, 95, 0.2, 7.8, 6.6, 60),
('Actimel', 10, 71, 10.5, 2.8, 1.6, 100),
('Actimel wieloowocowy', 10, 78, 12.4, 2.6, 1.5, 100),
('Actimel', 10, 71, 10.5, 2.8, 1.6, 100),
('Bia�ko jaja kurzego', 2, 17, 0.2, 3.8, 0.1, 35),
('Danonek, jogurt o smaku truskawkowym w saszetce', 10, 62, 8.5, 2.5, 2, 70),
('Kostki sera Favita w oleju', 11, 88, 1.5, 7, 6, 50),
('Gar�� startego ��tego sera', 5, 107, 0.7, 7.5, 8.2, 30),
('Jajko sadzone', 2, 127, 0.4, 7.5, 10.8, 52),
('Jajko gotowane', 8, 78, 0.6, 6.3, 5.3, 50),
('Jajko kurze', 2, 71, 0.3, 6.4, 4.9, 51),
('Jogurt kozi naturalny', 12, 95, 3.4, 6.7, 7.2, 120),
('Jogurt naturalny Activia', 10, 145, 10.7, 9.5, 7.1, 210),
('Kawa�ek parmezanu', 4, 908, 0.2, 81.4, 64, 200),
('Kostka greckiej Fety', 13, 530, 2.8, 35, 42, 200),
('Kula mozzarelli', 4, 635, 7.5, 60, 40, 250),
('�y�eczka mleka w proszku', 8, 25, 1.9, 1.3, 1.3, 5),
('�y�eczka sera mascarpone', 14, 47, 0.6, 0.4, 4.8, 12),
('�y�eczka serka naturalnego', 15, 19, 0.6, 1.3, 1.3, 15),
('�y�eczka serka wiejskiego ze szczypiorkiem', 14, 15, 0.3, 1.7, 0.8, 15),
('�y�ka jogurtu greckiego 0%', 10, 10, 0.8, 1.8, 0, 20),
('�y�ka jogurtu naturalnego', 4, 15, 1.5, 1.1, 0.5, 25),
('�y�ka jogurtu naturalnego 0%', 4, 10, 1.3, 1, 0, 20),
('�y�ka serka �mietankowego Philadelphia', 16, 63, 0.8, 1.5, 5.9, 25),
('�y�ka �mietany 12%', 4, 24, 0.7, 0.5, 2.2, 18),
('�y�ka �mietany 18%', 4, 47, 0.9, 0.6, 4.5, 25),
('�y�ka �mietany 30%', 4, 29, 0.3, 0.2, 3.0, 10),
('Pier�g z twarogiem', 4, 72, 8, 3.3, 3, 30),
('Plaster jaja', 8, 16, 0.1, 1.3, 1.1, 10),
('Plaster pe�not�ustego sera "Morskiego"', 11, 71, 0, 5.3, 5.5, 22),
('Plaster sera Gouda', 11, 79, 0, 6.8, 5.7, 25),
('Plaster sera ��tego', 5, 57, 0, 4.3, 4.5, 15),
('Plaster twarogu chudego', 5, 34, 0.7, 7.5, 0.2, 34),
('Porcja mas�a extra', 5, 37, 0, 0, 4.1, 5),
('P� kostki twarogu p�t�ustego', 5, 132, 3.7, 18.3, 4.7, 100),
('Serek wiejski naturalny', 14, 194, 4, 22, 10, 200),
('Szklanka jogurtu naturalnego', 4, 150, 15.5, 10.8, 5, 250),
('Szklanka kefiru naturalnego', 4, 122, 12, 8.6, 4.3, 240),
('Szklanka mleka 0%', 5, 77, 11.3, 7.7, 0, 240),
('Szklanka mleka 0.5%', 5, 90, 11.7, 7.8, 1.2, 230),
('Szklanka mleka 1.5%', 5, 108, 11.5, 7.6, 3.5, 230),
('Szklanka mleka 2%', 5, 117, 11.3, 7.6, 4.6, 230),
('Szklanka mleka 3.2%', 5, 140, 11, 7.4, 7.4, 230),
('��tko jaja kurzego', 5, 63, 0.1, 3.1, 5.6, 20),
('Bak�a�an',1,26,3.8,1.1,0.1,100),
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
('Tofu w�dzone',8,169,4.0,16.3,9.8,100),
('Ciecierzyca',8,120,14.7,6.4,2.2,100),
('Pomidor',3,19,2.9,0.9,0.2,100),
('Papryka',2,32,4.6,1.3,0.5,100),
('Ziemniak',1,71,15,1.8,0.1,100),
('Og�rek',3,14,2.4,0.7,0.1,100),
('Awokado',2,169,4.1,2.0,15.3,100),
('Marchew',2,33,5.1,1,0.2,100),
('Dynia',3,33,4.9,1.3,0.3,100),
('Kapusta bia�a',1,33,4.9,1.7,0.2,100),
('Kapusta peki�ska',1,16,1.3,1.2,0.2,100),
('Jarmu�',2,36,2.3,3.3,0.7,100),
('Broku�',1,31,2.7,3.0,0.4,100),
('Kalafior',1,27,2.6,2.4,0.2,100),
('Fasolka szparagowa',2,27,3.6,1.2,0.3,100),
('Burak',2,37,6.5,1.6,0.1,100),
('Korze� selera',1,30,2.8,1.6,0.3,100),
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
('B�b',1,76,8.2,7.1,0.4,100),
('Groszek cukrowy',1,42,7.5,2.8,0.2,100),
('Kurka',1,32,6.9,1.5,0.5,100),
('Papryka pepperoni',1,6,0.9,0.2,0.1,19),
('Koperek',1,1,0.1,0.1,0,4),
('Papryka habanero',1,5,0.8,0.2,0.1,17),
('Pomidor koktajlowy',2,19,2.9,0.9,0.2,100),
('Rukola',3,25,3.7,2.6,0.7,100),
('Sa�ata mas�owa',1,14,1.5,1.4,0.2,100),
('Sa�ata rzymska',1,16,1.5,1.4,0.2,100),
('Imbir',1,8,1.8,0.2,0.1,10),
('Seler naciowy',3,17,1.8,1,0.2,100),
('Jab�ko',2,50,10.1,0.4,0.4,100),
('Cytryna',1,4,0.8,0.1,0,10),
('Rabarbar',2,15,1.4,0.5,0.1,100),
('Banan',1,97,21.8,1,0.3,100),
('Pomara�cza',2,47,9.4,0.9,0.2,100),
('Mandarynka',1,45,9.3,0.6,0.3,100),
('Pomelo',1,38,9.6,0.8,0,100),
('Truskawka',2,33,5.8,0.7,0.4,100),
('Malina',3,43,5.3,1.3,0.3,100),
('Brzoskwinia',1,50,10,1,0.2,100),
('Nektarynka',3,50,10.6,0.9,0.2,100),
('Pitaja',2,50,11.8,1.4,0.3,100),
('Arbuz',3,36,8.1,0.6,0.1,100),
('Melon',3,34,0.2,0.8,0.2,100),
('�liwka',3,49,10.1,0.6,0.3,100),
('Wi�nia',3,49,9.9,0.9,0.4,100),
('Czere�nia',3,63,13.3,1,0.3,100),
('Kiwi',3,60,11.8,0.9,0.5,100),
('Ananas',3,55,2.4,0.4,0.2,100),
('Papaja',2,44,9.2,0.6,0.1,100),
('Je�yna',1,43,9.6,1.1,0.5,100),
('Olej kokosowy',8,54,0,0,6,6),
('Olej rzepakowy',8,88,0,0,10,10),
('Oliwa z oliwek',8,88,0,0,10,10),
('Olej lniany',8,90,0,0,10,10),
('Olej z awokado',8,71,0,0,8,8),
('Olej sezamowy',8,54,0,0,6,6),
('Olej s�onecznikowy',8,72,0,0,8,8)
INSERT INTO Posi�ki VALUES
('Kanapki z awokado i pomidorem',394.5,47.55,8.45,18.4),
('Makaron z tofu, ciecierzyc� i szpinakiem',880.4,78.35,43.1,40.2),
('Owsianka z owocami i nasionami',576.1,92.2,26.8,17.3),
('Rozgrzewaj�ca owsianka na mleku',689,101.1,53.2,20),
('Pomidorowe spaghetti z soczewic�',599,75,28.8,10.4),
('Tortilla z mozarell� i warzywami',688.5,67.9,38.3,28.75),
('Kasza j�czmienna z kurczakiem i warzywami', 468, 38.6, 43.8, 13.1),
('Jajecznica ze szczypiorkiem i pomidorami',250, 17.1,15.1,13.4),
('Tortilla zapiekana z serem i szynk�', 698, 14.84, 14.52, 11.41),
('Dorsz z warzywami i br�zowym ry�em', 492,59.1, 21,18.5),
('Kanapki z jajkiem, �ososiem i warzywami', 390, 45, 26.7,10.8),
('Pieczony pstr�g w pomidorach z kasz� i warzywami', 702, 87.6, 33.9,23.5)

INSERT INTO Sk�adPosi�k�w VALUES
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
INSERT INTO Jad�ospisy VALUES
('Jad�ospis wega�ski',1851,218.1,78.35,75.9),
('Zimowy jad�ospis wegetaria�ski',1976.5,244,120.3,59.15),
('Jad�ospis redukcyjny dla jedz�cych mi�so', 1416, 70.54,73.42,37.91),
('Jad�ospis wegetaria�ski zawieraj�cy ryby', 1584, 191.7, 135.3, 52.8)
INSERT INTO Sk�adJad�ospis�w VALUES
(1,1),(1,2),(1,3),
(2,4),(2,5),(2,6),
(3,7),(3,8),(3,9),
(4,10),(4,11),(4,12)
INSERT INTO TagiPosi�k�w VALUES
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

INSERT INTO TagiProdukt�w VALUES
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

INSERT INTO �wiczenia
VALUES
('Aerobik(Intensywnie)',255,30),
('Aerobik(Spokojnie)',182,30),
('Aerobik(Umiarkowane tempo',210,30),
('Aerobik z ci�arkami (4.5-6.5 kg)',350,30),
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
('Brzuszki niepe�ne',33,10),
('Brzuszki pe�ne (energiczne)',93,10),
('Brzuszki pe�ne (spokojne tempo)',32,10),
('Brzuszki pe�ne (umiarkowane tempo)',44,10),
('Chodzenie 3km/h',84,30),
('Chodzenie 4km/h',102,30),
('Chodzenie 5km/h',123,30),
('Hula hop',70,15),
('Jazda na �y�wach',123,15),
('Jazda na nartach bieg�wkach',287,30),
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
('Kolarstwo g�rskie',595,60),
('Koszyk�wka',280,30),
('Nordic Walking 7km/h',504,60),
('Nordic Walking 6km/h',476,60),
('Nordic Walking 5km/h',392,60),
('Nordic Walking 4km/h',308,60),
('Snorkeling',175,30),
('Nurkowanie ze sprz�tem',245,30),
('Pilates',210,60),
('Pi�ka no�na',630,60),
('Pi�ka r�czna',840,60),
('P�ywanie kraulem',175,15),
('P�ywanie stylem grzbietowym',166,15),
('P�ywanie stylem klasycznym',180,15),
('P�ywanie stylem motylkowym',240,15),
('Podci�ganie',44,10),
('Pompki',44,10),
('Przysiady wykroczne',44,10),
('Przysiady',58,10),
('Siatk�wka',140,30),
('Siatk�wka pla�owa',280,30),
('Siatk�wka wodna',185,30),
('Skakanka (intensywnie)',192,15),
('Skakanka (spokojnie)',143,15),
('Spacer',245,60),
('Squash',420,30),
('Step aerobik',385,60),
('Steper',82,10),
('Tenis',280,30),
('Rozci�ganie',27,10),
('Trucht',105,15),
('Orbitrek',175,30),
('Schody',51,10),
('Wspinaczka',280,30),
('Zumba',476,60)

INSERT INTO Treningi
VALUES
('Wzmacnianie plec�w','Umiarkowany'),
('Wzmacnianie n�g','Umiarkowany'),
('Aerobik','�atwy'),
('Bieganie szybkie','Trudny'),
('Bieganie dla pocz�tkuj�cych','�atwy'),
('Trening bokserski','Umiarkowany'),
('Wzmacnianie mi�ni brzucha','Umiarkowany'),
('Trening �y�wiarski','Umiarkowany'),
('Trening narciarsko-snowboardowy','Trudny'),
('Sztuki walki','Umiarkowany'),
('Trening p�ywacki','Trudny'),
('Cardio dla pocz�tkuj�cych','�atwy'),
('Pilates','�atwy'),
('Trening pi�karski','Umiarkowany'),
('Trening pi�ki r�cznej','Umiarkowany'),
('Trening koszykarski','Trudny'),
('Trening kolarski','Trudny')
--Tagi �wicze�
INSERT INTO Tagi�wicze�
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

--Tagi Trening�w
INSERT INTO TagiTrening�w
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

INSERT INTO Sk�adTreningu
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

IF OBJECT_ID('Wy�wietlZnajomych','IF') IS NOT NULL
DROP FUNCTION Wy�wietlZnajomych
IF OBJECT_ID ('Wy�wietlZapisaneTreningi') IS NOT NULL
DROP FUNCTION Wy�wietlZapisaneTreningi
IF OBJECT_ID ('Wy�wietlZaplanowaneTreningi') IS NOT NULL
DROP FUNCTION Wy�wietlZaplanowaneTreningi
IF OBJECT_ID ('Wy�wietlOcenioneTreningi') IS NOT NULL
DROP FUNCTION Wy�wietlOcenioneTreningi
IF OBJECT_ID ('Wy�wietlZapisaneJad�ospisy') IS NOT NULL
DROP FUNCTION Wy�wietlZapisaneJad�ospisy
IF OBJECT_ID ('Wy�wietlZaplanowaneJad�ospisy') IS NOT NULL
DROP FUNCTION Wy�wietlZaplanowaneJad�ospisy
IF OBJECT_ID ('Wy�wietlOcenioneJad�ospisy') IS NOT NULL
DROP FUNCTION Wy�wietlOcenioneJad�ospisy
IF OBJECT_ID ('Wy�wietlZaplanowaneTreningiNaDzi�') IS NOT NULL
DROP FUNCTION Wy�wietlZaplanowaneTreningiNaDzi�
IF OBJECT_ID ('Wy�wietlZaplanowaneJad�ospisyNaDzi�') IS NOT NULL
DROP FUNCTION Wy�wietlZaplanowaneJad�ospisyNaDzi�
IF OBJECT_ID ('Wy�wietlPomiary') IS NOT NULL
DROP FUNCTION Wy�wietlPomiary
IF OBJECT_ID ('Wy�wietlSk�adTreningu') IS NOT NULL
DROP FUNCTION Wy�wietlSk�adTreningu
IF OBJECT_ID ('Wy�wietlSk�adJad�ospisu') IS NOT NULL
DROP FUNCTION Wy�wietlSk�adJad�ospisu
IF OBJECT_ID ('Wy�wietlSk�adPosi�ku') IS NOT NULL
DROP FUNCTION Wy�wietlSk�adPosi�ku
IF OBJECT_ID ('Wy�wietlTreningPoTagu') IS NOT NULL
DROP FUNCTION Wy�wietlTreningPoTagu
IF OBJECT_ID ('Wy�wietl�wiczeniePoTagu') IS NOT NULL
DROP FUNCTION Wy�wietl�wiczeniePoTagu
IF OBJECT_ID ('Wy�wietlPosi�ekPoTagu') IS NOT NULL
DROP FUNCTION Wy�wietlPosi�ekPoTagu
IF OBJECT_ID ('Wy�wietlProduktPoTagu') IS NOT NULL
DROP FUNCTION Wy�wietlProduktPoTagu
IF OBJECT_ID ('Wy�wietlList�Zakup�w') IS NOT NULL
DROP FUNCTION Wy�wietlList�Zakup�w
IF OBJECT_ID ('ObliczProcentTkankiT�uszczowej') IS NOT NULL
DROP FUNCTION ObliczProcentTkankiT�uszczowej
GO


CREATE FUNCTION ObliczProcentTkankiT�uszczowej(@NazwaU�ytkownika VARCHAR(20))
RETURNS FLOAT
BEGIN
	DECLARE @wynik FLOAT, @waga INT, @obw�d INT
	SET @waga=(SELECT Top 1 AktualnePomiary.Waga FROM U�ytkownicy JOIN AktualnePomiary ON U�ytkownicy.IDU�ytkownika=AktualnePomiary.IDU�ytkownika
	WHERE U�ytkownicy.NazwaU�ytkownika=@NazwaU�ytkownika
	ORDER BY AktualnePomiary.CzasPomiaru DESC)
	SET @obw�d=(SELECT Top 1 AktualnePomiary.Obw�dPasa FROM U�ytkownicy JOIN AktualnePomiary ON U�ytkownicy.IDU�ytkownika=AktualnePomiary.IDU�ytkownika
	WHERE U�ytkownicy.NazwaU�ytkownika=@NazwaU�ytkownika
	ORDER BY AktualnePomiary.CzasPomiaru DESC)
	SET @wynik=((((4.15*@obw�d)/2.54)-0.082*@waga*2.2-88)/(@waga*2.2))*100
	RETURN @wynik
END
GO

CREATE FUNCTION Wy�wietlList�Zakup�w (@NazwaU�ytkownika VARCHAR(100), @NazwaSklepu VARCHAR(20))
RETURNS TABLE AS
RETURN 
(
	SELECT P.NazwaProduktu, P.MasaPorcji, S.Ilo��Porcji FROM 
	Sk�adListyZakup�w S JOIN ListaZakup�w L ON S.IDListy = L.IDListy
	JOIN U�ytkownicy U ON U.IDU�ytkownika = L.IDU�ytkownika
	JOIN Produkty P ON S.IDProduktu = P.IDProduktu
	WHERE U.NazwaU�ytkownika = @NazwaU�ytkownika AND L.NazwaSklepu = @NazwaSklepu
)
GO

CREATE FUNCTION Wy�wietlTreningPoTagu (@NazwaTagu VARCHAR(20))
RETURNS TABLE AS
RETURN 
(
	SELECT Treningi.NazwaTreningu, Treningi.Stopie�Trudno�ci
	FROM Treningi JOIN TagiTrening�w ON Treningi.IDTreningu=TagiTrening�w.IDTreningu
	JOIN Tag ON Tag.IDTagu=TagiTrening�w.IDTagu WHERE Tag.NazwaTagu=@NazwaTagu
)
GO

CREATE FUNCTION Wy�wietl�wiczeniePoTagu (@NazwaTagu VARCHAR(20))
RETURNS TABLE AS
RETURN 
(
	SELECT �wiczenia.Nazwa�wiczenia, �wiczenia.SpaloneKcal, �wiczenia.CzasWykonywania
	FROM �wiczenia JOIN Tagi�wicze� ON �wiczenia.ID�wiczenia=Tagi�wicze�.ID�wiczenia
	JOIN Tag ON Tag.IDTagu=Tagi�wicze�.IDTagu 
	WHERE Tag.NazwaTagu=@NazwaTagu
)
GO

CREATE FUNCTION Wy�wietlPosi�ekPoTagu (@NazwaTagu VARCHAR(20))
RETURNS TABLE AS
RETURN 
(
	SELECT Posi�ki.NazwaPosi�ku, Posi�ki.Kalorie, Posi�ki.W�glowodany, Posi�ki.Bia�ka, Posi�ki.T�uszcze
	FROM Posi�ki JOIN TagiPosi�k�w ON Posi�ki.IDPosi�ku=TagiPosi�k�w.IDPosi�ku
	JOIN Tag ON Tag.IDTagu=TagiPosi�k�w.IDTagu WHERE Tag.NazwaTagu=@NazwaTagu
)
GO

CREATE FUNCTION Wy�wietlProduktPoTagu (@NazwaTagu VARCHAR(20))
RETURNS TABLE AS
RETURN 
(
	SELECT Produkty.NazwaProduktu, Produkty.Kalorie, Produkty.W�glowodany, Produkty.Bia�ka, Produkty.T�uszcze
	FROM Produkty JOIN TagiProdukt�w ON Produkty.IDProduktu=TagiProdukt�w.IDProduktu
	JOIN Tag ON Tag.IDTagu=TagiProdukt�w.IDTagu WHERE Tag.NazwaTagu=@NazwaTagu
)
GO

CREATE FUNCTION Wy�wietlSk�adPosi�ku (@Nazwa VARCHAR(100))
RETURNS TABLE AS
RETURN 
(
	SELECT Pr.NazwaProduktu, Pr.Kalorie, Pr.W�glowodany, Pr.Bia�ka, Pr.T�uszcze, Pr.MasaPorcji FROM
	Posi�ki P JOIN Sk�adPosi�k�w SP ON P.IDPosi�ku = SP.IDPosi�ku
	JOIN Produkty Pr ON SP.IDProduktu = Pr.IDProduktu
	WHERE P.NazwaPosi�ku = @Nazwa
)
GO

CREATE FUNCTION Wy�wietlSk�adJad�ospisu (@Nazwa VARCHAR(100))
RETURNS TABLE AS
RETURN 
(
	SELECT P.NazwaPosi�ku, P.Kalorie, P.W�glowodany, P.Bia�ka, P.T�uszcze FROM
	Jad�ospisy J JOIN Sk�adJad�ospis�w SJ ON J.IDJad�ospisu = SJ.IDJad�ospisu
	JOIN Posi�ki P ON SJ.IDPosi�ku = P.IDPosi�ku
	WHERE J.NazwaJad�ospisu = @Nazwa
)
GO

CREATE FUNCTION Wy�wietlSk�adTreningu (@Nazwa VARCHAR(100))
RETURNS TABLE AS
RETURN 
(
	SELECT C.Nazwa�wiczenia, C.SpaloneKcal, C.CzasWykonywania FROM
	Treningi T JOIN Sk�adTreningu ST ON T.IDTreningu = ST.IDTreningu
	JOIN �wiczenia C ON ST.ID�wiczenia = C.ID�wiczenia
	WHERE T.NazwaTreningu = @Nazwa
)
GO

CREATE FUNCTION Wy�wietlPomiary(@NazwaU�ytkownika VARCHAR(20))
RETURNS TABLE AS
RETURN
(
	SELECT AktualnePomiary.CzasPomiaru, AktualnePomiary.Waga , AktualnePomiary.Obw�dPasa
	FROM AktualnePomiary
	JOIN U�ytkownicy ON AktualnePomiary.IDU�ytkownika=U�ytkownicy.IDU�ytkownika

)
GO

CREATE FUNCTION Wy�wietlZapisaneTreningi (@Nazwa VARCHAR(20))
RETURNS TABLE AS
RETURN 
(
	SELECT Treningi.NazwaTreningu, Treningi.Stopie�Trudno�ci
    FROM U�ytkownicy JOIN ZapisaneTreningi ON U�ytkownicy.IDU�ytkownika=ZapisaneTreningi.IDU�ytkownika JOIN Treningi ON ZapisaneTreningi.IDTreningu=Treningi.IDTreningu
    WHERE U�ytkownicy.NazwaU�ytkownika=@Nazwa
)
GO

CREATE FUNCTION Wy�wietlZaplanowaneTreningi (@Nazwa VARCHAR(20))
RETURNS TABLE AS
RETURN 
(
	SELECT ZaplanowaneTreningi.DataRozpocz�cia, ZaplanowaneTreningi.DataZako�czenia , Treningi.NazwaTreningu, Treningi.Stopie�Trudno�ci
    FROM U�ytkownicy JOIN ZaplanowaneTreningi ON U�ytkownicy.IDU�ytkownika=ZaplanowaneTreningi.IDU�ytkownika JOIN Treningi ON ZaplanowaneTreningi.IDTreningu=Treningi.IDTreningu
    WHERE U�ytkownicy.NazwaU�ytkownika=@Nazwa
)
GO

CREATE FUNCTION Wy�wietlOcenioneTreningi (@Nazwa VARCHAR(20))
RETURNS TABLE AS
RETURN 
(
	SELECT Treningi.NazwaTreningu, OcenioneTreningi.Ocena
    FROM U�ytkownicy JOIN OcenioneTreningi ON U�ytkownicy.IDU�ytkownika=OcenioneTreningi.IDU�ytkownika
	JOIN Treningi ON OcenioneTreningi.IDTreningu=Treningi.IDTreningu
    WHERE U�ytkownicy.NazwaU�ytkownika=@Nazwa
)
GO

CREATE FUNCTION Wy�wietlZapisaneJad�ospisy (@Nazwa VARCHAR(20))
RETURNS TABLE AS
RETURN 
(
	SELECT Jad�ospisy.NazwaJad�ospisu, Jad�ospisy.Kalorie, Jad�ospisy.W�glowodany, Jad�ospisy.Bia�ka, Jad�ospisy.T�uszcze
    FROM U�ytkownicy JOIN ZapisaneJad�ospisy ON U�ytkownicy.IDU�ytkownika=ZapisaneJad�ospisy.IDU�ytkownika
	JOIN Jad�ospisy ON ZapisaneJad�ospisy.IDJad�ospisu=Jad�ospisy.IDJad�ospisu
    WHERE U�ytkownicy.NazwaU�ytkownika=@Nazwa
)
GO

CREATE FUNCTION Wy�wietlZaplanowaneJad�ospisy (@Nazwa VARCHAR(20))
RETURNS TABLE AS
RETURN 
(
	SELECT ZaplanowaneJad�ospisy.Data, Jad�ospisy.NazwaJad�ospisu, Jad�ospisy.Kalorie, Jad�ospisy.W�glowodany, Jad�ospisy.Bia�ka, Jad�ospisy.T�uszcze
    FROM U�ytkownicy JOIN ZaplanowaneJad�ospisy ON U�ytkownicy.IDU�ytkownika=ZaplanowaneJad�ospisy.IDU�ytkownika
	JOIN Jad�ospisy ON ZaplanowaneJad�ospisy.IDJad�ospisu=Jad�ospisy.IDJad�ospisu
    WHERE U�ytkownicy.NazwaU�ytkownika=@Nazwa
)
GO

CREATE FUNCTION Wy�wietlOcenioneJad�ospisy (@Nazwa VARCHAR(20))
RETURNS TABLE AS
RETURN 
(SELECT Jad�ospisy.NazwaJad�ospisu, OcenioneJad�ospisy.Ocena
        FROM U�ytkownicy JOIN OcenioneJad�ospisy ON U�ytkownicy.IDU�ytkownika=OcenioneJad�ospisy.IDU�ytkownika
		JOIN Jad�ospisy ON OcenioneJad�ospisy.IDJad�ospisu=Jad�ospisy.IDJad�ospisu
        WHERE U�ytkownicy.NazwaU�ytkownika=@Nazwa
)
GO

CREATE FUNCTION Wy�wietlZaplanowaneTreningiNaDzi� (@Nazwa VARCHAR(20))
RETURNS TABLE AS
RETURN 
(
	SELECT Treningi.NazwaTreningu, Treningi.Stopie�Trudno�ci
    FROM U�ytkownicy JOIN ZaplanowaneTreningi ON U�ytkownicy.IDU�ytkownika=ZaplanowaneTreningi.IDU�ytkownika
	JOIN Treningi ON ZaplanowaneTreningi.IDTreningu=Treningi.IDTreningu
    WHERE U�ytkownicy.NazwaU�ytkownika=@Nazwa 
	AND CONVERT(DATE,GETDATE()) BETWEEN ZaplanowaneTreningi.DataRozpocz�cia AND ZaplanowaneTreningi.DataZako�czenia
)
GO

CREATE FUNCTION Wy�wietlZaplanowaneJad�ospisyNaDzi� (@Nazwa VARCHAR(20))
RETURNS TABLE AS
RETURN 
(
	SELECT Jad�ospisy.NazwaJad�ospisu, Jad�ospisy.Kalorie, Jad�ospisy.W�glowodany, Jad�ospisy.Bia�ka, Jad�ospisy.T�uszcze
    FROM U�ytkownicy JOIN ZaplanowaneJad�ospisy ON U�ytkownicy.IDU�ytkownika=ZaplanowaneJad�ospisy.IDU�ytkownika
	JOIN Jad�ospisy ON ZaplanowaneJad�ospisy.IDJad�ospisu=Jad�ospisy.IDJad�ospisu
    WHERE U�ytkownicy.NazwaU�ytkownika=@Nazwa 
	AND (SELECT DATEDIFF(day,GETDATE(),ZaplanowaneJad�ospisy.Data)) = 0
)
GO

CREATE FUNCTION Wy�wietlZnajomych(@nazwa VARCHAR(20))
RETURNS TABLE AS
RETURN(
SELECT C.NazwaU�ytkownika
FROM U�ytkownicy A
JOIN Znajomi B ON A.IDU�ytkownika=B.IDU�ytkownika1
JOIN U�ytkownicy C ON B.IDU�ytkownika2=C.IDU�ytkownika
WHERE A.NazwaU�ytkownika=@nazwa
)
GO
--TRIGGER

IF OBJECT_ID ('U�ytkownicyTrigger', 'TR') IS NOT NULL  
DROP TRIGGER U�ytkownicyTrigger
IF OBJECT_ID ('OcenioneTreningiTrigger', 'TR') IS NOT NULL  
DROP TRIGGER OcenioneTreningiTrigger
IF OBJECT_ID ('OcenioneTreningiUpdateTrigger', 'TR') IS NOT NULL  
DROP TRIGGER OcenioneTreningiUpdateTrigger
IF OBJECT_ID ('OcenioneJad�ospisyTrigger', 'TR') IS NOT NULL  
DROP TRIGGER OcenioneJad�ospisyTrigger
IF OBJECT_ID ('OcenioneJad�ospisyUpdateTrigger', 'TR') IS NOT NULL  
DROP TRIGGER OcenioneJad�ospisyUpdateTrigger
IF OBJECT_ID ('ZaplanowaneJad�ospisyTrigger', 'TR') IS NOT NULL  
DROP TRIGGER ZaplanowaneJad�ospisyTrigger
IF OBJECT_ID ('ZaplanowaneTreningiTrigger', 'TR') IS NOT NULL  
DROP TRIGGER ZaplanowaneTreningiTrigger
IF OBJECT_ID ('ZnajomiTrigger', 'TR') IS NOT NULL  
DROP TRIGGER ZnajomiTrigger
IF OBJECT_ID ('ZapisaneJad�ospisyTrigger', 'TR') IS NOT NULL  
DROP TRIGGER ZapisaneJad�ospisyTrigger
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
	DECLARE @IDU�ytkownika INT, @Data DATETIME, @Waga INT, @Obw�dPasa INT
	SELECT @IDU�ytkownika = INSERTED.IDU�ytkownika,
	@Data = SYSDATETIME(),
	@Waga = INSERTED.Waga,
	@Obw�dPasa = INSERTED.Obw�dPasa FROM INSERTED
	IF (@Waga > 0 AND @Obw�dPasa>0)
	BEGIN
		INSERT INTO AktualnePomiary VALUES
				(@IDU�ytkownika, @Data, @Waga, @Obw�dPasa)
	END
	ELSE
		RAISERROR('Waga lub obw�d pasa ujemne', 16,1)
END
GO

CREATE TRIGGER ZapisaneTreningiTrigger
ON ZapisaneTreningi
INSTEAD OF INSERT
AS 
BEGIN
	DECLARE @IDU�ytkownika INT, @IDTreningu INT
	SELECT
	@IDU�ytkownika = inserted.IDU�ytkownika,
	@IDTreningu = inserted.IDTreningu
	FROM INSERTED
	IF EXISTS (SELECT * FROM ZapisaneTreningi WHERE IDU�ytkownika = @IDU�ytkownika AND IDTreningu = @IDTreningu)
		RAISERROR('Zapisa�e� ju� ten trening', 16,1)
	ELSE
		INSERT INTO ZapisaneTreningi VALUES
		(@IDU�ytkownika, @IDTreningu)

END
GO


CREATE TRIGGER ZapisaneJad�ospisyTrigger
ON ZapisaneJad�ospisy
INSTEAD OF INSERT
AS 
BEGIN
	DECLARE @IDU�ytkownika INT, @IDJad�ospisu INT
	SELECT
	@IDU�ytkownika = inserted.IDU�ytkownika,
	@IDJad�ospisu = inserted.IDJad�ospisu
	FROM INSERTED
	IF EXISTS (SELECT * FROM ZapisaneJad�ospisy WHERE IDU�ytkownika = @IDU�ytkownika AND IDJad�ospisu = @IDJad�ospisu)
		RAISERROR('Zapisa�e� ju� ten jad�ospis', 16,1)
	ELSE
		INSERT INTO ZapisaneJad�ospisy VALUES
		(@IDU�ytkownika, @IDJad�ospisu)

END
GO

CREATE TRIGGER ZnajomiTrigger
ON Znajomi
INSTEAD OF INSERT
AS
BEGIN
	DECLARE	@IDU�ytkownika1 INT, @IDU�ytkownika2 INT
	SELECT @IDU�ytkownika1=INSERTED.IDU�ytkownika1,
	@IDU�ytkownika2=INSERTED.IDU�ytkownika2
	FROM INSERTED
		IF EXISTS (SELECT IDU�ytkownika1 FROM Znajomi WHERE IDU�ytkownika1 = @IDU�ytkownika1 AND IDU�ytkownika2 = @IDU�ytkownika2)
			BEGIN
				RAISERROR('Taka znajomo�� ju� istnieje', 16,1)
			END
		ELSE
			BEGIN
				INSERT INTO Znajomi VALUES
					(@IDU�ytkownika1,@IDU�ytkownika2),(@IDU�ytkownika2,@IDU�ytkownika1)
			END 
END
GO

CREATE TRIGGER ZaplanowaneTreningiTrigger
ON ZaplanowaneTreningi
INSTEAD OF INSERT
AS
BEGIN
	DECLARE @IDU�ytkownika INT, @IDTreningu INT, @DataRozpocz�cia DATE, @DataZako�czenia DATE
	SELECT @IDU�ytkownika = INSERTED.IDU�ytkownika,
	@IDTreningu = INSERTED.IDTreningu,
	@DataRozpocz�cia = INSERTED.DataRozpocz�cia,
	@DataZako�czenia = INSERTED.DataZako�czenia FROM INSERTED
	IF (@DataRozpocz�cia <= @DataZako�czenia)
		INSERT INTO ZaplanowaneTreningi VALUES
		(@IDU�ytkownika, @IDTreningu, @DataRozpocz�cia, @DataZako�czenia)
	ELSE
		RAISERROR('Data rozpocz�cia jest p�niejsza ni� data zako�czenia', 16,1)
END
GO

CREATE TRIGGER ZaplanowaneJad�ospisyTrigger
ON ZaplanowaneJad�ospisy
INSTEAD OF INSERT, UPDATE
AS
BEGIN
	DECLARE @IDU�ytkownika INT, @IDJad�ospisu INT, @Data DATE
	SELECT @IDU�ytkownika = INSERTED.IDU�ytkownika,
	@IDJad�ospisu = INSERTED.IDJad�ospisu,
	@Data = INSERTED.Data FROM INSERTED
	IF NOT EXISTS (SELECT * FROM ZaplanowaneJad�ospisy WHERE ZaplanowaneJad�ospisy.IDU�ytkownika=@IDU�ytkownika AND ZaplanowaneJad�ospisy.Data=@Data )
		INSERT INTO ZaplanowaneJad�ospisy VALUES
		(@IDU�ytkownika, @IDJad�ospisu, @Data)
	ELSE
		RAISERROR('Na ten dzie� jest ju� zaplanowany jad�ospis', 16,1)
END
GO


CREATE TRIGGER OcenioneJad�ospisyTrigger
ON OcenioneJad�ospisy
INSTEAD OF INSERT
AS BEGIN
	DECLARE @IDU�ytkownika INT, @IDJad�ospisu INT, @Ocena INT
	SELECT
	@IDU�ytkownika = inserted.IDU�ytkownika,
	@IDJad�ospisu = inserted.IDJad�ospisu,
	@Ocena = inserted.Ocena
	FROM INSERTED
	IF EXISTS (SELECT * FROM OcenioneJad�ospisy WHERE IDU�ytkownika = @IDU�ytkownika AND IDJad�ospisu = @IDJad�ospisu)
		RAISERROR('Doda�e� ju� ocen� do tego jad�ospisu', 16,1)
	ELSE
		IF (@Ocena BETWEEN 1 AND 5)
			INSERT INTO OcenioneJad�ospisy VALUES
			(@IDU�ytkownika, @IDJad�ospisu, @Ocena)
		ELSE
			RAISERROR('Ocena nie zawiera si� w skali', 16,1)

END
GO


CREATE TRIGGER OcenioneTreningiTrigger
ON OcenioneTreningi
INSTEAD OF INSERT
AS BEGIN
	DECLARE @IDU�ytkownika INT, @IDTreningu INT, @Ocena INT
	SELECT
	@IDU�ytkownika = inserted.IDU�ytkownika,
	@IDTreningu = inserted.IDTreningu,
	@Ocena = inserted.Ocena
	FROM INSERTED
	IF EXISTS (SELECT * FROM OcenioneTreningi WHERE IDU�ytkownika = @IDU�ytkownika AND IDTreningu = @IDTreningu)
		RAISERROR('Doda�e� ju� ocen� do tego treningu', 16,1)
	ELSE
		IF (@Ocena BETWEEN 1 AND 5)
			INSERT INTO OcenioneTreningi VALUES
			(@IDU�ytkownika, @IDTreningu, @Ocena)
		ELSE
			RAISERROR('Ocena nie zawiera si� w skali', 16,1)

END
GO

CREATE TRIGGER OcenioneTreningiUpdateTrigger
ON OcenioneTreningi
INSTEAD OF UPDATE
AS BEGIN
	DECLARE @IDU�ytkownika INT, @IDTreningu INT, @Ocena INT
	SELECT
	@IDU�ytkownika = inserted.IDU�ytkownika,
	@IDTreningu = inserted.IDTreningu,
	@Ocena = inserted.Ocena
	FROM INSERTED	
	IF (@Ocena BETWEEN 1 AND 5)
		UPDATE OcenioneTreningi
		SET Ocena = @Ocena
		WHERE IDU�ytkownika = @IDU�ytkownika AND IDTreningu = @IDTreningu
	ELSE
		RAISERROR('Ocena nie zawiera si� w skali', 16,1)

END
GO

CREATE TRIGGER OcenioneJad�ospisyUpdateTrigger
ON OcenioneJad�ospisy
INSTEAD OF UPDATE
AS BEGIN
	DECLARE @IDU�ytkownika INT, @IDJad�ospisu INT, @Ocena INT
	SELECT
	@IDU�ytkownika = inserted.IDU�ytkownika,
	@IDJad�ospisu = inserted.IDJad�ospisu,
	@Ocena = inserted.Ocena
	FROM INSERTED	
	IF (@Ocena BETWEEN 1 AND 5)
		UPDATE OcenioneJad�ospisy
		SET Ocena = @Ocena
		WHERE IDU�ytkownika = @IDU�ytkownika AND IDJad�ospisu = @IDJad�ospisu
	ELSE
		RAISERROR('Ocena nie zawiera si� w skali', 16,1)

END
GO

CREATE TRIGGER U�ytkownicyTrigger
ON U�ytkownicy
INSTEAD OF INSERT
AS
BEGIN
	DECLARE @IDU�ytkownika INT, @NazwaU�ytkownika VARCHAR(20), @Imi�U�ytkownika VARCHAR(20), @NazwiskoU�ytkownika VARCHAR(20), @NumerTelefonu VARCHAR(9)
	SELECT @IDU�ytkownika = INSERTED.IDU�ytkownika,
	@NazwaU�ytkownika = INSERTED.NazwaU�ytkownika,
	@Imi�U�ytkownika = INSERTED.Imi�U�ytownika,
	@NazwiskoU�ytkownika = INSERTED.NazwiskoU�ytkownika,
	@NumerTelefonu = INSERTED.NumerTelefonu
	FROM INSERTED
		IF EXISTS (SELECT NazwaU�ytkownika FROM U�ytkownicy WHERE NazwaU�ytkownika = @NazwaU�ytkownika)
			BEGIN
				RAISERROR('Zaj�ta nazwa u�ytkownika!', 16,1)
			END
		ELSE
			BEGIN
				IF (LEN(@NumerTelefonu)=9 AND ISNUMERIC(@NumerTelefonu)=1)
					BEGIN
						INSERT INTO U�ytkownicy VALUES
						(@NazwaU�ytkownika,@Imi�U�ytkownika,@NazwiskoU�ytkownika,@NumerTelefonu)
						DECLARE @ID INT
						SET @ID=(SELECT MAX(IDU�ytkownika) FROM U�ytkownicy)
						INSERT INTO ListaZakup�w VALUES
						('Biedronka',@ID),('Lidl',@ID)
					END
				ELSE
					RAISERROR('Numer telefonu ma za ma�o cyfr lub znaki nieb�d�ce cyframi', 16,1)
			END 
END

--PROCEDURE
GO
IF OBJECT_ID('AktualizujPomiar','P') IS NOT NULL
DROP PROC AktualizujPomiar
IF OBJECT_ID('DodajU�ytkownika','P') IS NOT NULL
DROP PROC DodajU�ytkownika
IF OBJECT_ID('DodajDoListyZakup�w','P') IS NOT NULL
DROP PROC DodajDoListyZakup�w
IF OBJECT_ID('Usu�ZListyZakup�w','P') IS NOT NULL
DROP PROC Usu�ZListyZakup�w
IF OBJECT_ID('DodajOcen�Treningu','P') IS NOT NULL
DROP PROC DodajOcen�Treningu
IF OBJECT_ID('DodajOcen�Jad�ospisu','P') IS NOT NULL
DROP PROC DodajOcen�Jad�ospisu
IF OBJECT_ID('ZaplanujTrening','P') IS NOT NULL
DROP PROC ZaplanujTrening
IF OBJECT_ID('ZaplanujJad�ospis','P') IS NOT NULL
DROP PROC ZaplanujJad�ospis
IF OBJECT_ID('ZapiszTrening','P') IS NOT NULL
DROP PROC ZapiszTrening
IF OBJECT_ID('ZapiszJad�ospis','P') IS NOT NULL
DROP PROC ZapiszJad�ospis
IF OBJECT_ID('Zmie�Ocen�Treningu','P') IS NOT NULL
DROP PROC Zmie�Ocen�Treningu
IF OBJECT_ID('Zmie�Ocen�Jad�ospisu','P') IS NOT NULL
DROP PROC Zmie�Ocen�Jad�ospisu
IF OBJECT_ID('DodajZnajomego','P') IS NOT NULL
DROP PROC DodajZnajomego
GO

CREATE PROCEDURE AktualizujPomiar
(@Nazwa VARCHAR(20), @Waga INT, @Obw�dPasa INT)
AS
DECLARE @IDU�ytkownika VARCHAR(20)
DECLARE @DataPomiaru DATETIME
SET @IDU�ytkownika=(SELECT IDU�ytkownika FROM U�ytkownicy WHERE U�ytkownicy.NazwaU�ytkownika=@nazwa)
SET @DataPomiaru=SYSDATETIME()
INSERT INTO AktualnePomiary VALUES
(@IDU�ytkownika,@dataPomiaru,@waga,@obw�dPasa)
GO

CREATE PROCEDURE DodajZnajomego
(@NazwaU�ytkownika1 VARCHAR(20),@NazwaU�ytkownika2 VARCHAR(100))
AS
DECLARE @IDU�ytkownika1 INT, @IDU�ytkownika2 INT
SET @IDU�ytkownika1=(SELECT IDU�ytkownika FROM U�ytkownicy WHERE U�ytkownicy.NazwaU�ytkownika=@NazwaU�ytkownika1)
SET @IDU�ytkownika2=(SELECT IDU�ytkownika FROM U�ytkownicy WHERE U�ytkownicy.NazwaU�ytkownika=@NazwaU�ytkownika2)
INSERT INTO Znajomi
VALUES (@IDU�ytkownika1,@IDU�ytkownika2),(@IDU�ytkownika2,@IDU�ytkownika1)
GO

CREATE PROCEDURE Zmie�Ocen�Jad�ospisu
(@NazwaU�ytkownika VARCHAR(20),@NazwaJad�ospisu VARCHAR(100),@Ocena INT)
AS
DECLARE @IDU�ytkownika INT, @IDJad�ospisu INT
SET @IDU�ytkownika=(SELECT IDU�ytkownika FROM U�ytkownicy WHERE U�ytkownicy.NazwaU�ytkownika=@NazwaU�ytkownika)
SET @IDJad�ospisu=(SELECT IDJad�ospisu FROM Jad�ospisy WHERE Jad�ospisy.NazwaJad�ospisu=@NazwaJad�ospisu)
UPDATE OcenioneJad�ospisy
SET OcenioneJad�ospisy.Ocena=@Ocena WHERE OcenioneJad�ospisy.IDU�ytkownika=@IDU�ytkownika AND OcenioneJad�ospisy.IDJad�ospisu=@IDJad�ospisu
GO

CREATE PROCEDURE Zmie�Ocen�Treningu
(@NazwaU�ytkownika VARCHAR(20),@NazwaTreningu VARCHAR(100),@Ocena INT)
AS
DECLARE @IDU�ytkownika INT, @IDTreningu INT
SET @IDU�ytkownika=(SELECT IDU�ytkownika FROM U�ytkownicy WHERE U�ytkownicy.NazwaU�ytkownika=@NazwaU�ytkownika)
SET @IDTreningu=(SELECT IDTreningu FROM Treningi WHERE Treningi.NazwaTreningu=@NazwaTreningu)
UPDATE OcenioneTreningi 
SET
Ocena = @Ocena
WHERE IDU�ytkownika = @IDU�ytkownika AND IDTreningu = @IDTreningu
GO

CREATE PROCEDURE ZapiszTrening
(@NazwaU�ytkownika VARCHAR(20),@NazwaTreningu VARCHAR(100))
AS
DECLARE @IDU�ytkownika INT, @IDTreningu INT
SET @IDU�ytkownika=(SELECT IDU�ytkownika FROM U�ytkownicy WHERE U�ytkownicy.NazwaU�ytkownika=@NazwaU�ytkownika)
SET @IDTreningu=(SELECT IDTreningu FROM Treningi WHERE Treningi.NazwaTreningu=@NazwaTreningu)
INSERT INTO ZapisaneTreningi VALUES
(@IDU�ytkownika,@IDTreningu)
GO

CREATE PROCEDURE ZapiszJad�ospis
(@NazwaU�ytkownika VARCHAR(20),@NazwaJad�ospisu VARCHAR(100))
AS
DECLARE @IDU�ytkownika INT, @IDJad�ospisu INT
SET @IDU�ytkownika=(SELECT IDU�ytkownika FROM U�ytkownicy WHERE U�ytkownicy.NazwaU�ytkownika=@NazwaU�ytkownika)
SET @IDJad�ospisu=(SELECT IDJad�ospisu FROM Jad�ospisy WHERE Jad�ospisy.NazwaJad�ospisu=@NazwaJad�ospisu)
INSERT INTO ZapisaneJad�ospisy VALUES
(@IDU�ytkownika,@IDJad�ospisu)
GO

CREATE PROCEDURE ZaplanujTrening
(@NazwaU�ytkownika VARCHAR(20),@NazwaTreningu VARCHAR(100),@DataRozpocz�cia DATE, @DataZako�czenia DATE)
AS
DECLARE @IDU�ytkownika INT, @IDTreningu INT
SET @IDU�ytkownika=(SELECT IDU�ytkownika FROM U�ytkownicy WHERE U�ytkownicy.NazwaU�ytkownika=@NazwaU�ytkownika)
SET @IDTreningu=(SELECT IDTreningu FROM Treningi WHERE Treningi.NazwaTreningu=@NazwaTreningu)
INSERT INTO ZaplanowaneTreningi VALUES
(@IDU�ytkownika,@IDTreningu,@DataRozpocz�cia,@DataZako�czenia)
GO

CREATE PROCEDURE ZaplanujJad�ospis
(@NazwaU�ytkownika VARCHAR(20),@NazwaJad�ospisu VARCHAR(100),@Data DATE)
AS
DECLARE @IDU�ytkownika INT, @IDJad�ospisu INT
SET @IDU�ytkownika=(SELECT IDU�ytkownika FROM U�ytkownicy WHERE U�ytkownicy.NazwaU�ytkownika=@NazwaU�ytkownika)
SET @IDJad�ospisu=(SELECT IDJad�ospisu FROM Jad�ospisy WHERE Jad�ospisy.NazwaJad�ospisu=@NazwaJad�ospisu)
INSERT INTO ZaplanowaneJad�ospisy VALUES
(@IDU�ytkownika,@IDJad�ospisu,@Data)
GO

CREATE PROCEDURE DodajOcen�Treningu
(@NazwaU�ytkownika VARCHAR(20),@NazwaTreningu VARCHAR(100),@Ocena INT)
AS
DECLARE @IDU�ytkownika INT, @IDTreningu INT
SET @IDU�ytkownika=(SELECT IDU�ytkownika FROM U�ytkownicy WHERE U�ytkownicy.NazwaU�ytkownika=@NazwaU�ytkownika)
SET @IDTreningu=(SELECT IDTreningu FROM Treningi WHERE Treningi.NazwaTreningu=@NazwaTreningu)
INSERT INTO OcenioneTreningi VALUES
(@IDU�ytkownika,@IDTreningu,@Ocena)
GO

CREATE PROCEDURE DodajOcen�Jad�ospisu
(@NazwaU�ytkownika VARCHAR(20),@NazwaJad�ospisu VARCHAR(100),@Ocena INT)
AS
DECLARE @IDU�ytkownika INT, @IDJad�ospisu INT
SET @IDU�ytkownika=(SELECT IDU�ytkownika FROM U�ytkownicy WHERE U�ytkownicy.NazwaU�ytkownika=@NazwaU�ytkownika)
SET @IDJad�ospisu=(SELECT IDJad�ospisu FROM Jad�ospisy WHERE Jad�ospisy.NazwaJad�ospisu=@NazwaJad�ospisu)
INSERT INTO OcenioneJad�ospisy VALUES
(@IDU�ytkownika,@IDJad�ospisu,@Ocena)
GO

CREATE PROCEDURE Usu�ZListyZakup�w
(@NazwaProduktu VARCHAR(100), @NazwaSklepu VARCHAR(100), @NazwaU�ytkownika VARCHAR(20))
AS
	DECLARE @IDProduktu INT, @IDListy INT, @IDU�ytkownika INT
	SET @IDU�ytkownika=(SELECT IDU�ytkownika FROM U�ytkownicy WHERE U�ytkownicy.NazwaU�ytkownika=@NazwaU�ytkownika)
	SET @IDListy=(SELECT IDListy FROM ListaZakup�w WHERE ListaZakup�w.NazwaSklepu=@NazwaSklepu AND ListaZakup�w.IDU�ytkownika=@IDU�ytkownika)
	SET @IDProduktu = (SELECT IDProduktu FROM Produkty WHERE NazwaProduktu = @NazwaProduktu)
	DELETE  FROM Sk�adListyZakup�w WHERE 
	Sk�adListyZakup�w.IDListy=@IDListy AND Sk�adListyZakup�w.IDProduktu=@IDProduktu

GO

CREATE PROCEDURE DodajDoListyZakup�w
(@NazwaProduktu VARCHAR(100), @NazwaSklepu VARCHAR(100), @NazwaU�ytkownika VARCHAR(20), @Ilo��Porcji INT)
AS
	DECLARE @IDProduktu INT, @IDListy INT, @IDU�ytkownika INT
	SET @IDU�ytkownika=(SELECT IDU�ytkownika FROM U�ytkownicy WHERE U�ytkownicy.NazwaU�ytkownika=@NazwaU�ytkownika)
	SET @IDListy=(SELECT IDListy FROM ListaZakup�w WHERE ListaZakup�w.NazwaSklepu=@NazwaSklepu AND ListaZakup�w.IDU�ytkownika=@IDU�ytkownika)
	SET @IDProduktu = (SELECT IDProduktu FROM Produkty WHERE NazwaProduktu = @NazwaProduktu)
	INSERT INTO Sk�adListyZakup�w VALUES
	(@IDListy,@IDProduktu,@Ilo��Porcji)
GO
 
CREATE PROCEDURE DodajU�ytkownika
(@NazwaU�ytkownika VARCHAR(20), @Imi�U�ytkownika VARCHAR(20), @NazwiskoU�ytkownika VARCHAR(20), @NumerTelefonu VARCHAR(9))
AS
INSERT INTO U�ytkownicy VALUES
(@NazwaU�ytkownika, @Imi�U�ytkownika, @NazwiskoU�ytkownika, @NumerTelefonu)
GO

--VIEW

IF OBJECT_ID('Wy�wietlSk�adyTrening�w','V') IS NOT NULL
DROP VIEW Wy�wietlSk�adyTrening�w
IF OBJECT_ID('Wy�wietlJad�ospisy','V') IS NOT NULL
DROP VIEW Wy�wietlJad�ospisy
IF OBJECT_ID('Wy�wietlSk�adyJad�ospis�w','V') IS NOT NULL
DROP VIEW Wy�wietlSk�adyJad�ospis�w
IF OBJECT_ID('Wy�wietlProdukty','V') IS NOT NULL
DROP VIEW Wy�wietlProdukty
IF OBJECT_ID('Wy�wietlTreningi','V') IS NOT NULL
DROP VIEW Wy�wietlTreningi
IF OBJECT_ID('Wy�wietlTagiSportowe','V') IS NOT NULL
DROP VIEW Wy�wietlTagiSportowe
IF OBJECT_ID('Wy�wietlTagiSpo�ywcze','V') IS NOT NULL
DROP VIEW Wy�wietlTagiSpo�ywcze
IF OBJECT_ID('Wy�wietlPosi�ki','V') IS NOT NULL
DROP VIEW Wy�wietlPosi�ki

GO
CREATE VIEW Wy�wietlPosi�ki AS
SELECT Posi�ki.NazwaPosi�ku, Posi�ki.Kalorie, Posi�ki.W�glowodany, Posi�ki.Bia�ka, Posi�ki.T�uszcze FROM
Posi�ki
GO

CREATE VIEW Wy�wietlTagiSportowe AS
SELECT Tag.NazwaTagu, TagSportowy.Og�lnorozwojowy FROM
Tag JOIN TagSportowy ON Tag.IDTagu=TagSportowy.IDTagu
GO

CREATE VIEW Wy�wietlTagiSpo�ywcze AS
SELECT Tag.NazwaTagu, TagSpo�ywczy.OpisTagu FROM
Tag JOIN TagSpo�ywczy ON Tag.IDTagu=TagSpo�ywczy.IDTagu
GO

CREATE VIEW Wy�wietlTreningi AS
SELECT T.NazwaTreningu, A.NazwaTagu, B.Og�lnorozwojowy FROM 
Treningi T JOIN TagiTrening�w TT on T.IDTreningu = TT.IDTreningu
JOIN Tag A ON A.IDTagu = TT.IDTagu  
JOIN TagSportowy B ON A.IDTagu = B.IDTagu
GO

CREATE VIEW Wy�wietlProdukty AS
SELECT Produkty.NazwaProduktu, Produkty.Kalorie, Produkty.MasaPorcji, Produkty.W�glowodany, Produkty.Bia�ka, Produkty.T�uszcze FROM Produkty
GO 

CREATE VIEW Wy�wietlSk�adyJad�ospis�w AS
SELECT Jad�ospisy.NazwaJad�ospisu, Posi�ki.NazwaPosi�ku
FROM Jad�ospisy JOIN Sk�adJad�ospis�w
ON Jad�ospisy.IDJad�ospisu=Sk�adJad�ospis�w.IDJad�ospisu
JOIN Posi�ki ON Sk�adJad�ospis�w.IDPosi�ku=Posi�ki.IDPosi�ku
GO

CREATE VIEW Wy�wietlJad�ospisy AS
SELECT Jad�ospisy.NazwaJad�ospisu, Jad�ospisy.Kalorie, Jad�ospisy.W�glowodany, Jad�ospisy.Bia�ka, Jad�ospisy.T�uszcze FROM Jad�ospisy
GO 

CREATE VIEW Wy�wietlSk�adyTrening�w AS
SELECT Treningi.NazwaTreningu, �wiczenia.Nazwa�wiczenia
FROM Treningi JOIN Sk�adTreningu
ON Treningi.IDTreningu=Sk�adTreningu.IDTreningu
JOIN �wiczenia ON Sk�adTreningu.ID�wiczenia=�wiczenia.ID�wiczenia
GO








