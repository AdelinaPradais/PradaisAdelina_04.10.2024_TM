Descrierea proiectului realizat pentru finalizarea cursului de Testare Manuală

În urma finalizării cursului de SOFTWARE TESTER (Testare Manuală), am ales pentru partea practică a proiectului final: SQL, respectiv crearea unei baze de date și executarea instrucțiunilor specifice SQL utilizând MySQL Workbench.

Baze de date creată reprezintă situația de înscrieri la facultate.
M-am inspirat din situații din viața reală, dar datele sau denumirile elementelor nu sunt reprezentări 100% a situațiilor din viața reală. Sper exemplu, „candidatul” va deveni „student” odată ce este înmatriculat - am încercat simularea acestor situații prin nesemnarea 
contractelor de către toți candidații sau prin nealocarea de nr. RMU (Registru Matricol Unic) tuturor candidaților.

Astfel, baza de date este alcătuită din 6 tabele interconectate:
* date_identificare_candidati (unde se regăsesc informațiile personale ale candidaților la înscriere)
* date_cotact (surprind principalele date de contact pentru fiecare candidat)
* adrese_domiciliu_candidati (stochează informații legate de adresele candidaților)
* istoric_studii (cuprinde informații cu privire la studiile preuniversitare urmate de către candidați)
* contracte_studii (surprinde contractele de studii semnate de către acei candidați admiși)
* burse (tabelă în care sunt centralizate bursele alocate în funcție de mediile obținute la finalizarea studiilor

Tabelele sunt legate prin chei primare și secundare, ele fiind evidențiate, iar relațiile dintre tabele sunt atât de tip 1:1 cât și 1:n (un candidat poate avea mai multe contracte de studii dacă a fost admis la mai multe facultăți și a ales să semneze contracte pentru toate).
Pentru a se vedea ușor relația dintre tabele și modul în care ele sunt legate am inclus în proiect și diagrama EER (am generat raportul de execuție din reverse engineering).

Ulterior creării bazei de date și a tabelelor aferente cu ajutorul instrucțiunilor DDL, am introdus sau șters date folosind instrucțiuni DML. Înaintea fiecărei instrucțiuni am introdus explicația scenariului sau a acțiunii dorite a fi executate.
După ce m-am asigurat că am date introduse pentru diferite scenarii, cu ajutorul instrucțiunilor DQL (select, select anumite coloane, filtrare cu where, filtrări cu like, filtrări cu AND și OR, funcții agregate, filtrări pe
funcții agregate, joinuri - inner join, left join, right join, cross join, limite, order by, subquery-uri) am creat diverse scenarii.

Am ales scrierea instrucțiunilor în ordinea în care ele se vor rula și executa pentru a nu returna erori de referențiere, deci cu ajutorul MySQL Workbench se poate rula de la sus în jos întregul proiect.
