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