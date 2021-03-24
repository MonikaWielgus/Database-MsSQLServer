/*PRZYK�ADOWE ZAPYTANIA
Procedura DodajU�ytkownika*/
--EXEC DodajU�ytkownika @NazwaU�ytkownika='User1',@Imi�U�ytkownika='Basia', @NazwiskoU�ytkownika='Kowalska', @NumerTelefonu='123456789'
--EXEC DodajU�ytkownika @NazwaU�ytkownika='User2',@Imi�U�ytkownika='Janusz', @NazwiskoU�ytkownika='Nowak', @NumerTelefonu='987654321'
--EXEC DodajU�ytkownika @NazwaU�ytkownika='User3',@Imi�U�ytkownika='Katarzyna', @NazwiskoU�ytkownika='Sowa', @NumerTelefonu='098765432'
--EXEC DodajU�ytkownika @NazwaU�ytkownika='User4',@Imi�U�ytkownika='Bo�ena', @NazwiskoU�ytkownika='Wrona', @NumerTelefonu='234567890'

/*Wyzwalacz z�y numer*/
--EXEC DodajU�ytkownika @NazwaU�ytkownika='User5',@Imi�U�ytkownika='Bo�ena', @NazwiskoU�ytkownika='Wrona', @NumerTelefonu='234'

/*Wyzwalacz powtarzaj�ca si� nazwa u�ytkownika*/
--EXEC DodajU�ytkownika @NazwaU�ytkownika='User4',@Imi�U�ytkownika='Maciej', @NazwiskoU�ytkownika='Wrona', @NumerTelefonu='234567890'

/*Procedura DodajZnajomego*/
--EXEC DodajZnajomego @NazwaU�ytkownika1='User1', @NazwaU�ytkownika2='User3'
--EXEC DodajZnajomego @NazwaU�ytkownika1='User1', @NazwaU�ytkownika2='User2'

/*Funkcja Wy�wietlZnajomych*/
--SELECT * FROM Wy�wietlZnajomych('User1')

/*Wyzwalacz nie wolno doda� tych samych znajomych*/
--EXEC DodajZnajomego @NazwaU�ytkownika1='User1', @NazwaU�ytkownika2='User2'

/* Procedura dodanie pomiaru*/
--EXEC AktualizujPomiar @Nazwa='User1', @Waga=60, @Obw�dPasa=70
--EXEC AktualizujPomiar @Nazwa='User1', @Waga=62, @Obw�dPasa=71

/*Fukcja wy�wietl pomiary u�ytkownika*/
--SELECT * FROM Wy�wietlPomiary('User1')

/*Wyzwalacz ujemny pomiar*/
--EXEC AktualizujPomiar @Nazwa='User1', @Waga=62, @Obw�dPasa=-71

/*Funkcja oblicz % tkanki t�uszczowej*/
--SELECT dbo.ObliczProcentTkankiT�uszczowej('User1')

/*Teraz wprowadzimy nowy pomiar, a kolejny raz % tkanki t�uszczowej obliczy si� dla nowo dodanego pomiaru*/
--EXEC AktualizujPomiar @Nazwa='User1', @Waga=60, @Obw�dPasa=70

/*Funkcja oblicz % tkanki t�uszczowej*/
--SELECT dbo.ObliczProcentTkankiT�uszczowej('User1')

/*widok Wy�wietlmy tagi sportowe*/
--SELECT * FROM Wy�wietlTagiSportowe

/*widok Wy�wietl wszystkie treningi*/
--SELECT * FROM Wy�wietlTreningi

/* widok Wy�wietl sk�ady trening�w*/
--SELECT * FROM Wy�wietlSk�adyTrening�w

/*funkcja Wy�wietl trening po tagu*/
--SELECT * FROM Wy�wietlTreningPoTagu('Cardio')

/*funkcja Wy�wietl �wiczenie po tagu*/
--SELECT * FROM Wy�wietl�wiczeniePoTagu('Brzuch')

/* funkcja wyswietl sk�ad wybranego treningu*/
--SELECT * FROM Wy�wietlSk�adTreningu('Aerobik')

/* procedura zapisz trening*/
--EXEC ZapiszTrening @NazwaU�ytkownika='User1', @NazwaTreningu='Aerobik'
--EXEC ZapiszTrening @NazwaU�ytkownika='User1', @NazwaTreningu='Sztuki walki'

/*funkcja wy�wietl zapisane treningi*/
--SELECT * FROM Wy�wietlZapisaneTreningi('User1')

/*wyzwalacz brak duplikatu zapisanego treningu*/
--EXEC ZapiszTrening @NazwaU�ytkownika='User1', @NazwaTreningu='Sztuki walki'

/*procedura dodaj ocen�*/
--EXEC DodajOcen�Treningu @NazwaU�ytkownika='User1', @NazwaTreningu='Aerobik', @Ocena=5

/*wyzwalacz ocena poza skal�*/
--EXEC DodajOcen�Treningu @NazwaU�ytkownika='User1', @NazwaTreningu='Sztuki walki', @Ocena=6

/*funkcja wyswietl ocenione*/
--SELECT * FROM Wy�wietlOcenioneTreningi('User1')

/*wyzwalacz trening wcze�niej oceniony*/
--EXEC DodajOcen�Treningu @NazwaU�ytkownika='User1', @NazwaTreningu='Aerobik', @Ocena=5

/*procedura zmie� ocen� treningu*/
--EXEC Zmie�Ocen�Treningu @NazwaU�ytkownika='User1',@NazwaTreningu='Aerobik', @Ocena=3

/*trigger zmiana oceny poza skal�*/
--EXEC Zmie�Ocen�Treningu @NazwaU�ytkownika='User1',@NazwaTreningu='Aerobik', @Ocena=0

/*procedura Zaplanuj trening*/
--EXEC ZaplanujTrening @NazwaU�ytkownika='User1', @NazwaTreningu='Sztuki walki', @DataRozpocz�cia='2021-01-21', @DataZako�czenia='2021-01-26'
--EXEC ZaplanujTrening @NazwaU�ytkownika='User1', @NazwaTreningu='Aerobik', @DataRozpocz�cia='2021-01-28', @DataZako�czenia='2021-01-28'

/*wyzwalacz data rozpocz�cia p�niejsza ni� data zako�czenia*/
--EXEC ZaplanujTrening @NazwaU�ytkownika='User1', @NazwaTreningu='Sztuki walki', @DataRozpocz�cia='2021-01-26', @DataZako�czenia='2021-01-21'

/*funkcja Wy�wietl zaplanowane treningi u�ytkownika*/
--SELECT * FROM Wy�wietlZaplanowaneTreningi('User1')

/*funkcja wyswietl treningi na dzisiaj*/
--SELECT * FROM Wy�wietlZaplanowaneTreningiNaDzi�('User1')

--------------------------------------------------------------------------------------------------------------------------




/*widok Wy�wietlmy tagi spo�ywcze*/
--SELECT * FROM Wy�wietlTagiSpo�ywcze


/* widok Wy�wietl produkty*/
--SELECT * FROM Wy�wietlProdukty

/*funkcja Wy�wietl produkty po tagu*/
--SELECT * FROM Wy�wietlProduktPoTagu('wegetaria�ski')

 /*widok wy�wietl posi�ki*/
 --SELECT * FROM Wy�wietlPosi�ki

/*funkcja Wy�wietl posi�ek po tagu*/
--SELECT * FROM Wy�wietlPosi�ekPoTagu('wega�ski')

/* funkcja wyswietl sk�ad wybranego posi�ku*/
--SELECT * FROM Wy�wietlSk�adPosi�ku('Makaron z tofu, ciecierzyc� i szpinakiem')

/*widok Wy�wietl wszystkie Jad�ospisy*/
--SELECT * FROM Wy�wietlJad�ospisy

/* widok Wy�wietl sk�ady jad�ospis�w*/
--SELECT * FROM Wy�wietlSk�adyJad�ospis�w

/* funkcja wyswietl sk�ad wybranego jad�ospisu*/
--SELECT * FROM Wy�wietlSk�adJad�ospisu('Zimowy jad�ospis wegetaria�ski')

/* procedura zapisz jad�ospis*/
--EXEC ZapiszJad�ospis @NazwaU�ytkownika='User1', @NazwaJad�ospisu='Jad�ospis wegetaria�ski zawieraj�cy ryby'
--EXEC ZapiszJad�ospis @NazwaU�ytkownika='User1', @NazwaJad�ospisu='Jad�ospis wega�ski'

/*funkcja wy�wietl zapisane jad�ospisy*/
--SELECT * FROM Wy�wietlZapisaneJad�ospisy('User1')

/*wyzwalacz brak duplikatu zapisanego jad�ospisu*/
--EXEC ZapiszJad�ospis @NazwaU�ytkownika='User1', @NazwaJad�ospisu='Jad�ospis wega�ski'

/*procedura dodaj ocen�*/
--EXEC DodajOcen�Jad�ospisu @NazwaU�ytkownika='User1', @NazwaJad�ospisu='Jad�ospis wegetaria�ski zawieraj�cy ryby', @Ocena=5

/*wyzwalacz ocena poza skal�*/
--EXEC DodajOcen�Jad�ospisu @NazwaU�ytkownika='User1', @NazwaJad�ospisu='Jad�ospis wega�ski', @Ocena=6

/*funkcja wyswietl ocenione*/
--SELECT * FROM Wy�wietlOcenioneJad�ospisy('User1')

/*wyzwalacz jad�ospis wcze�niej oceniony*/
--EXEC DodajOcen�Jad�ospisu @NazwaU�ytkownika='User1', @NazwaJad�ospisu='Jad�ospis wegetaria�ski zawieraj�cy ryby', @Ocena=5

/*procedura zmie� ocen� jad�ospisu*/
--EXEC Zmie�Ocen�Jad�ospisu @NazwaU�ytkownika='User1',@NazwaJad�ospisu='Jad�ospis wegetaria�ski zawieraj�cy ryby', @Ocena=3

/*trigger zmiana oceny poza skal�*/
--EXEC Zmie�Ocen�Jad�ospisu @NazwaU�ytkownika='User1',@NazwaJad�ospisu='Jad�ospis wegetaria�ski zawieraj�cy ryby', @Ocena=0

/*procedura Zaplanuj jad�ospis*/
--EXEC ZaplanujJad�ospis @NazwaU�ytkownika='User1', @NazwaJad�ospisu='Jad�ospis wegetaria�ski zawieraj�cy ryby', @Data='2021-01-21'
--EXEC ZaplanujJad�ospis @NazwaU�ytkownika='User1', @NazwaJad�ospisu='Jad�ospis wega�ski', @Data='2021-01-26'

/*wyzwalacz juz jest zaplanowane na ten dzie�*/
--EXEC ZaplanujJad�ospis @NazwaU�ytkownika='User1', @NazwaJad�ospisu='Jad�ospis wegetaria�ski zawieraj�cy ryby', @Data='2021-01-26'

/*funkcja Wy�wietl zaplanowane jad�ospisy u�ytkownika*/
--SELECT * FROM Wy�wietlZaplanowaneJad�ospisy('User1')

/*funkcja wyswietl jad�ospis na dzisiaj*/
--SELECT * FROM Wy�wietlZaplanowaneJad�ospisyNaDzi�('User1')

/*procedura dodaj do listy zakup�w*/
--EXEC DodajDoListyZakup�w @NazwaProduktu='Bak�a�an', @NazwaSklepu='Lidl', @NazwaU�ytkownika='User1', @Ilo��Porcji=1
--EXEC DodajDoListyZakup�w @NazwaProduktu='Ciecierzyca', @NazwaSklepu='Biedronka', @NazwaU�ytkownika='User1', @Ilo��Porcji=2
--EXEC DodajDoListyZakup�w @NazwaProduktu='Szpinak', @NazwaSklepu='Lidl', @NazwaU�ytkownika='User1', @Ilo��Porcji=1

/*funkcja wy�wietl list� zakup�w*/

--SELECT * FROM Wy�wietlList�Zakup�w('User1','Lidl')

/*procedura usu� z listy*/
--EXEC Usu�ZListyZakup�w @NazwaProduktu='Bak�a�an', @NazwaSklepu='Lidl', @NazwaU�ytkownika='User1'

/*funkcja wy�wietl list� zakup�w*/

--SELECT * FROM Wy�wietlList�Zakup�w('User1','Lidl')