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
	AND GETDATE() >= ZaplanowaneTreningi.DataRozpoczęcia AND GETDATE() <= ZaplanowaneTreningi.DataZakończenia
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