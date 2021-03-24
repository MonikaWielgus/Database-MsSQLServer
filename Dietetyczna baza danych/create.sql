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