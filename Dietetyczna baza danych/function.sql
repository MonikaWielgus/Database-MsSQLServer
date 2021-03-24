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
	AND GETDATE() >= ZaplanowaneTreningi.DataRozpocz�cia AND GETDATE() <= ZaplanowaneTreningi.DataZako�czenia
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