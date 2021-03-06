/*PRZYKŁADOWE ZAPYTANIA
Procedura DodajUżytkownika*/
--EXEC DodajUżytkownika @NazwaUżytkownika='User1',@ImięUżytkownika='Basia', @NazwiskoUżytkownika='Kowalska', @NumerTelefonu='123456789'
--EXEC DodajUżytkownika @NazwaUżytkownika='User2',@ImięUżytkownika='Janusz', @NazwiskoUżytkownika='Nowak', @NumerTelefonu='987654321'
--EXEC DodajUżytkownika @NazwaUżytkownika='User3',@ImięUżytkownika='Katarzyna', @NazwiskoUżytkownika='Sowa', @NumerTelefonu='098765432'
--EXEC DodajUżytkownika @NazwaUżytkownika='User4',@ImięUżytkownika='Bożena', @NazwiskoUżytkownika='Wrona', @NumerTelefonu='234567890'

/*Wyzwalacz zły numer*/
--EXEC DodajUżytkownika @NazwaUżytkownika='User5',@ImięUżytkownika='Bożena', @NazwiskoUżytkownika='Wrona', @NumerTelefonu='234'

/*Wyzwalacz powtarzająca się nazwa użytkownika*/
--EXEC DodajUżytkownika @NazwaUżytkownika='User4',@ImięUżytkownika='Maciej', @NazwiskoUżytkownika='Wrona', @NumerTelefonu='234567890'

/*Procedura DodajZnajomego*/
--EXEC DodajZnajomego @NazwaUżytkownika1='User1', @NazwaUżytkownika2='User3'
--EXEC DodajZnajomego @NazwaUżytkownika1='User1', @NazwaUżytkownika2='User2'

/*Funkcja WyświetlZnajomych*/
--SELECT * FROM WyświetlZnajomych('User1')

/*Wyzwalacz nie wolno dodać tych samych znajomych*/
--EXEC DodajZnajomego @NazwaUżytkownika1='User1', @NazwaUżytkownika2='User2'

/* Procedura dodanie pomiaru*/
--EXEC AktualizujPomiar @Nazwa='User1', @Waga=60, @ObwódPasa=70
--EXEC AktualizujPomiar @Nazwa='User1', @Waga=62, @ObwódPasa=71

/*Fukcja wyświetl pomiary użytkownika*/
--SELECT * FROM WyświetlPomiary('User1')

/*Wyzwalacz ujemny pomiar*/
--EXEC AktualizujPomiar @Nazwa='User1', @Waga=62, @ObwódPasa=-71

/*Funkcja oblicz % tkanki tłuszczowej*/
--SELECT dbo.ObliczProcentTkankiTłuszczowej('User1')

/*Teraz wprowadzimy nowy pomiar, a kolejny raz % tkanki tłuszczowej obliczy się dla nowo dodanego pomiaru*/
--EXEC AktualizujPomiar @Nazwa='User1', @Waga=60, @ObwódPasa=70

/*Funkcja oblicz % tkanki tłuszczowej*/
--SELECT dbo.ObliczProcentTkankiTłuszczowej('User1')

/*widok Wyświetlmy tagi sportowe*/
--SELECT * FROM WyświetlTagiSportowe

/*widok Wyświetl wszystkie treningi*/
--SELECT * FROM WyświetlTreningi

/* widok Wyświetl składy treningów*/
--SELECT * FROM WyświetlSkładyTreningów

/*funkcja Wyświetl trening po tagu*/
--SELECT * FROM WyświetlTreningPoTagu('Cardio')

/*funkcja Wyświetl ćwiczenie po tagu*/
--SELECT * FROM WyświetlĆwiczeniePoTagu('Brzuch')

/* funkcja wyswietl skład wybranego treningu*/
--SELECT * FROM WyświetlSkładTreningu('Aerobik')

/* procedura zapisz trening*/
--EXEC ZapiszTrening @NazwaUżytkownika='User1', @NazwaTreningu='Aerobik'
--EXEC ZapiszTrening @NazwaUżytkownika='User1', @NazwaTreningu='Sztuki walki'

/*funkcja wyświetl zapisane treningi*/
--SELECT * FROM WyświetlZapisaneTreningi('User1')

/*wyzwalacz brak duplikatu zapisanego treningu*/
--EXEC ZapiszTrening @NazwaUżytkownika='User1', @NazwaTreningu='Sztuki walki'

/*procedura dodaj ocenę*/
--EXEC DodajOcenęTreningu @NazwaUżytkownika='User1', @NazwaTreningu='Aerobik', @Ocena=5

/*wyzwalacz ocena poza skalą*/
--EXEC DodajOcenęTreningu @NazwaUżytkownika='User1', @NazwaTreningu='Sztuki walki', @Ocena=6

/*funkcja wyswietl ocenione*/
--SELECT * FROM WyświetlOcenioneTreningi('User1')

/*wyzwalacz trening wcześniej oceniony*/
--EXEC DodajOcenęTreningu @NazwaUżytkownika='User1', @NazwaTreningu='Aerobik', @Ocena=5

/*procedura zmień ocenę treningu*/
--EXEC ZmieńOcenęTreningu @NazwaUżytkownika='User1',@NazwaTreningu='Aerobik', @Ocena=3

/*trigger zmiana oceny poza skalę*/
--EXEC ZmieńOcenęTreningu @NazwaUżytkownika='User1',@NazwaTreningu='Aerobik', @Ocena=0

/*procedura Zaplanuj trening*/
--EXEC ZaplanujTrening @NazwaUżytkownika='User1', @NazwaTreningu='Sztuki walki', @DataRozpoczęcia='2021-01-21', @DataZakończenia='2021-01-26'
--EXEC ZaplanujTrening @NazwaUżytkownika='User1', @NazwaTreningu='Aerobik', @DataRozpoczęcia='2021-01-28', @DataZakończenia='2021-01-28'

/*wyzwalacz data rozpoczęcia późniejsza niż data zakończenia*/
--EXEC ZaplanujTrening @NazwaUżytkownika='User1', @NazwaTreningu='Sztuki walki', @DataRozpoczęcia='2021-01-26', @DataZakończenia='2021-01-21'

/*funkcja Wyświetl zaplanowane treningi użytkownika*/
--SELECT * FROM WyświetlZaplanowaneTreningi('User1')

/*funkcja wyswietl treningi na dzisiaj*/
--SELECT * FROM WyświetlZaplanowaneTreningiNaDziś('User1')

--------------------------------------------------------------------------------------------------------------------------




/*widok Wyświetlmy tagi spożywcze*/
--SELECT * FROM WyświetlTagiSpożywcze


/* widok Wyświetl produkty*/
--SELECT * FROM WyświetlProdukty

/*funkcja Wyświetl produkty po tagu*/
--SELECT * FROM WyświetlProduktPoTagu('wegetariański')

 /*widok wyświetl posiłki*/
 --SELECT * FROM WyświetlPosiłki

/*funkcja Wyświetl posiłek po tagu*/
--SELECT * FROM WyświetlPosiłekPoTagu('wegański')

/* funkcja wyswietl skład wybranego posiłku*/
--SELECT * FROM WyświetlSkładPosiłku('Makaron z tofu, ciecierzycą i szpinakiem')

/*widok Wyświetl wszystkie Jadłospisy*/
--SELECT * FROM WyświetlJadłospisy

/* widok Wyświetl składy jadłospisów*/
--SELECT * FROM WyświetlSkładyJadłospisów

/* funkcja wyswietl skład wybranego jadłospisu*/
--SELECT * FROM WyświetlSkładJadłospisu('Zimowy jadłospis wegetariański')

/* procedura zapisz jadłospis*/
--EXEC ZapiszJadłospis @NazwaUżytkownika='User1', @NazwaJadłospisu='Jadłospis wegetariański zawierający ryby'
--EXEC ZapiszJadłospis @NazwaUżytkownika='User1', @NazwaJadłospisu='Jadłospis wegański'

/*funkcja wyświetl zapisane jadłospisy*/
--SELECT * FROM WyświetlZapisaneJadłospisy('User1')

/*wyzwalacz brak duplikatu zapisanego jadłospisu*/
--EXEC ZapiszJadłospis @NazwaUżytkownika='User1', @NazwaJadłospisu='Jadłospis wegański'

/*procedura dodaj ocenę*/
--EXEC DodajOcenęJadłospisu @NazwaUżytkownika='User1', @NazwaJadłospisu='Jadłospis wegetariański zawierający ryby', @Ocena=5

/*wyzwalacz ocena poza skalą*/
--EXEC DodajOcenęJadłospisu @NazwaUżytkownika='User1', @NazwaJadłospisu='Jadłospis wegański', @Ocena=6

/*funkcja wyswietl ocenione*/
--SELECT * FROM WyświetlOcenioneJadłospisy('User1')

/*wyzwalacz jadłospis wcześniej oceniony*/
--EXEC DodajOcenęJadłospisu @NazwaUżytkownika='User1', @NazwaJadłospisu='Jadłospis wegetariański zawierający ryby', @Ocena=5

/*procedura zmień ocenę jadłospisu*/
--EXEC ZmieńOcenęJadłospisu @NazwaUżytkownika='User1',@NazwaJadłospisu='Jadłospis wegetariański zawierający ryby', @Ocena=3

/*trigger zmiana oceny poza skalę*/
--EXEC ZmieńOcenęJadłospisu @NazwaUżytkownika='User1',@NazwaJadłospisu='Jadłospis wegetariański zawierający ryby', @Ocena=0

/*procedura Zaplanuj jadłospis*/
--EXEC ZaplanujJadłospis @NazwaUżytkownika='User1', @NazwaJadłospisu='Jadłospis wegetariański zawierający ryby', @Data='2021-01-21'
--EXEC ZaplanujJadłospis @NazwaUżytkownika='User1', @NazwaJadłospisu='Jadłospis wegański', @Data='2021-01-26'

/*wyzwalacz juz jest zaplanowane na ten dzień*/
--EXEC ZaplanujJadłospis @NazwaUżytkownika='User1', @NazwaJadłospisu='Jadłospis wegetariański zawierający ryby', @Data='2021-01-26'

/*funkcja Wyświetl zaplanowane jadłospisy użytkownika*/
--SELECT * FROM WyświetlZaplanowaneJadłospisy('User1')

/*funkcja wyswietl jadłospis na dzisiaj*/
--SELECT * FROM WyświetlZaplanowaneJadłospisyNaDziś('User1')

/*procedura dodaj do listy zakupów*/
--EXEC DodajDoListyZakupów @NazwaProduktu='Bakłażan', @NazwaSklepu='Lidl', @NazwaUżytkownika='User1', @IlośćPorcji=1
--EXEC DodajDoListyZakupów @NazwaProduktu='Ciecierzyca', @NazwaSklepu='Biedronka', @NazwaUżytkownika='User1', @IlośćPorcji=2
--EXEC DodajDoListyZakupów @NazwaProduktu='Szpinak', @NazwaSklepu='Lidl', @NazwaUżytkownika='User1', @IlośćPorcji=1

/*funkcja wyświetl listę zakupów*/

--SELECT * FROM WyświetlListęZakupów('User1','Lidl')

/*procedura usuń z listy*/
--EXEC UsuńZListyZakupów @NazwaProduktu='Bakłażan', @NazwaSklepu='Lidl', @NazwaUżytkownika='User1'

/*funkcja wyświetl listę zakupów*/

--SELECT * FROM WyświetlListęZakupów('User1','Lidl')