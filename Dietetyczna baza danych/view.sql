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