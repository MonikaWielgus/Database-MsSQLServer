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