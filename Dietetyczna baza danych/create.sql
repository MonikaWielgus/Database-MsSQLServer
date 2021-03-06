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