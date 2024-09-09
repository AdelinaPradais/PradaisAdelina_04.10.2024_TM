--- creare bază de date
	create database inscrieri_facultate;

--- creare tabele
CREATE TABLE date_identificare_candidati(
    id integer primary key auto_increment,
	nume_candidat varchar(20) NOT NULL,
    prenume_candidat varchar(20) NOT NULL,
    data_nastere_candidat date,
    CNP_candidat integer);
	
CREATE TABLE date_contact(
    id_candidat integer,
	email_candidat varchar(30) NOT NULL,
    telefon_candidat integer);
	
--- introducere cheie secundara în tabela date_contact pentru a crea o legătură între cele 2 tabele = modificăm o coloana
	alter table date_contact 
		add foreign key (id_candidat) references date_identificare_candidati(id);
	
CREATE TABLE adrese(
    localitate varchar(20),
    strada varchar(20),
    nr varchar(5),
    ap integer,
    judet varchar(20));

CREATE TABLE istoric_studii(
    id_istoric integer primary key auto_increment,
	id_candidat integer, # cheie secundară către coloana id din tabela date_identificare_candidati
	liceu varchar(30),
    profil varchar(30),
    nr_ani integer,
	foreign key (id_candidat) references date_identificare_candidati(id));
	
CREATE TABLE contracte_studii(
    id_contract integer primary key auto_increment,
	id_candidat integer, # cheie secundară către coloana id din tabela date_identificare_candidati
	facultate varchar (50),
	nr_contract varchar(10),
    data_contract date,
    nr_RMU integer,
	foreign key (id_candidat) references date_identificare_candidati(id));
    
--- Verific structura tabelelor
	desc date_identificare_candidati;
    desc date_contact;
    desc istoric_studii;
    desc contracte_studii;

--- adăug două coloane în tabela istoric_studii
	alter table istoric_studii
		add column an_absolvire integer,
		add column medie_bac decimal;

--- modificare proprietăți coloana nr_RMU din tabela contracte_studii
	alter table contracte_studii modify nr_RMU char(5);

--- ștergere tabelă adrese
	drop table adrese;

--- creare tabelă nouă
CREATE TABLE adrese_domiciliu(
    id_adresa integer primary key auto_increment,
	id_candidat integer, # cheie secundară către coloana id din tabela date_identificare_candidati
	judet varchar(20),
    localitate varchar(20),
    strada varchar(20),
    nr char(5),
    sc char(3),
    ap integer,
	foreign key (id_candidat) references date_identificare_candidati(id));   
    
--- modificare tabela adrese_domiciliu - șterg coloana scară
	alter table adrese_domiciliu drop column sc;

--- redenumit tabelă adrese_domiciliu
	rename table adrese_domiciliu to adrese_domiciliu_candidati;

--- creare tabelă nouă de burse în cadrul căreia vor fi legate 3 tabele
CREATE TABLE burse(
    id_bursa integer primary key auto_increment,
	id_candidat integer, # cheie secundară către coloana id din tabela date_identificare_candidati
	id_contract integer, # cheie secundară către coloana id_contract din tabela contracte_studii
	id_istoric integer, # cheie secundară către coloana id_istoric din tabela istoric_studii
	valoare_bursa integer,
	foreign key (id_candidat) references date_identificare_candidati(id),
	foreign key (id_contract) references contracte_studii(id_contract),
	foreign key (id_istoric) references istoric_studii(id_istoric));

--- verific structura tabelelor modificate sau adăugate
	desc istoric_studii;
	desc contracte_studii;
	desc adrese_domiciliu_candidati;
	desc burse;

--- modificare tabela date_identificare_candidati - modificare caracteristici coloana CNP
	alter table date_identificare_candidati
		modify column CNP_candidat char(13);

--- adăugare valori multiple în coloanele din tabela date_identificare_candidati, în același timp
	insert into date_identificare_candidati (nume_candidat, prenume_candidat, data_nastere_candidat, CNP_candidat)
	values ('Popa', 'Adam', '1997-02-09', '1970209517634'),('Cristea', 'Bucur', '2000-04-09', '5000409017025'),
	('Diaconu', 'Matilda', '2000-07-26', '6000726366661'),('Iancu', 'Zoe', '2001-03-15', '6010315304967'),
	('Ifrim', 'Stela', '2001-01-31', '6010131211641'),('Munteanu', 'Sara', '2007-07-17', '6070717078469'),
	('Mocanu', 'Livia', '1999-01-24', '2990124108501'),('Tudor', 'Ludovic', '1996-11-15', '1961115376155'),
	('Sava', 'Gelu', '1998-08-28', '1980828276024'),('Florea', 'Carol', '2003-04-30', '5030430118263');
    
--- returnarea tuturor datelor candidaților (interogare simplă pe toată tabela date_identificare_candidati)
	select * from date_identificare_candidati;

--- adăugare valori multiple în coloanele din tabela date_contact, în același timp
	insert into date_contact (id_candidat, email_candidat, telefon_candidat) 
	values (1, 'Popa.Adam@yahoo.com', 0711223344), (2, 'Cristea.Bucur@yahoo.ro', 0711223345), (3, 'Diaconu.Matilda@yahoo.com', null),
	(4, 'Iancu.Zoe@yahoo.com', 0722334456), (5, 'Ifrim.Stela@yahoo.ro', 0722334457), (6, 'Munteanu.Sara@yahoo.com', 0700784458),
	(7, 'Mocanu.Livia@gmail.com', 0700784459), (8, 'Tudor.Ludovic@gmail.com', 0787542165), (9, 'Sava.Gelu@hotmail.com', null),
	(10, 'Florea.Carol@yahoo.com', 0785421369);

--- returnarea tuturor datelor de contact ale candidaților (interogare simplă pe toată tabela date_contact)
	select * from date_contact;

--- modificare tabela istoric_studii - modificare caracteristici coloana liceu
	alter table istoric_studii
		modify column liceu varchar(50);
        
--- adăugare valori multiple în coloanele din tabela istoric_studii, în același timp
	insert into istoric_studii (id_candidat, liceu, profil, nr_ani, an_absolvire, medie_bac)
	values (2, 'Colegiul Național Ion Luca Caragiale Ploiești‎', 'mate-info', 4, 2008, 8.8), (4, 'Liceul de Artă din Târgu Mureș', 'muzica', 5, 2020, 9),
	(5, 'Liceul de Artă George Apostu din Bacău‎', 'pictura', 5, 2021, 10),	(6, 'Colegiul Național „Gheorghe Lazăr” din Sibiu', 'real', 4, 2023, 9),
	(9, 'Colegiul Național Silvania', 'real', 4, 2023, 10),	(10, 'Liceul Teoretic Ady Endre din Oradea', 'filologie', 4, 2020, 8);
    
--- returnarea studiilor realizate de candidați (interogare simplă pe toată tabela istoric_studii)
	select * from istoric_studii;

--- adăugare valori multiple în coloanele din tabela contracte_studii, în același timp
	insert into contracte_studii (id_candidat, facultate, nr_contract, data_contract, nr_RMU)
	values (1, 'Chimie', null , null, '5384U'), (2, 'Istorie', '4721', '2023-10-10', 'I8641'), 
	(3, 'Psihologie', '354', '2023-10-11', '79546'),	(4, 'Matematica-Informatica', '964/A/54', '2023-09-07', '96SED'), 
	(5, 'Studii europene', null, '2023-10-10', null), (6, 'Istorie', '4754', '2023-10-10', null ),
	(7, 'Psihologie', '351', '2023-11-01', '7955'), (8, 'Chimie', '43b', '2023-11-01', 'C25C'), 
	(9, 'Istorie', '4835', '2023-10-11', '36T'), (10, 'Matematica-Informatica', '963/A/52', '2023-09-07', '75DEF');

--- returnarea tuturor contractelor de studii semnate (interogare simplă pe toată tabela contracte_studii)
	select * from contracte_studii;

--- adăugare valori multiple în coloanele din tabela adrese_domiciliu_candidati, în același timp
	insert into adrese_domiciliu_candidati (id_candidat, judet, localitate, strada, nr)
	values (1, 'Iasi', 'Iasi', 'str. Dreapta', '25'), (5, 'Bihor', 'Alesd', 'str. De Sus', '42a'),
	(6, 'Arad', 'Curtici', 'str. Rariu', '3B'), (7, 'Cluj', 'Huedin', 'str. Trei', '75'),
	(9, 'Hunedoara', 'Hateg', 'str. Principala', '4587'), (10, 'Brasov', 'Rasnov', 'str. Principala', '9C');
    
--- returnarea tuturor adreselor de domiciliu din baza de date (interogare simplă pe toată tabela adrese_domiciliu_candidati)
	select * from adrese_domiciliu_candidati;
    
--- adăugare valori multiple în coloanele din tabela burse, în același timp
	insert into burse (id_candidat, id_contract, id_istoric, valoare_bursa)
	values (2, 2, 1, 550), (4, 4, 2, 500), (5, 5, 3, 1000), (9, 9, 5, 1000), (10, 10, 6, 300);

--- majorarea tuturor burselor cu 150: prin instrucțiunea update pentru coloana valoare_bursa specifică, pentru toate înregistrările (fără condiție/filtru)
	SET SQL_SAFE_UPDATES = 0; --- este o instrucțiune de siguranță SQL ca să putem face update-ul pe câmpul următor
	update burse set valoare_bursa=valoare_bursa+150;

--- returnarea burselor oferite (interogare simplă pe toată tabela burse)
	select * from burse;

--- returnarea acelor candidați care au avut media la bac mai mare de 9 (interogare doar pentru unele coloane din tabela istoric_studii pe baza unui filtru/condiții)
	select id_candidat, liceu, profil, medie_bac from istoric_studii where medie_bac >9;

--- returnarea acelor candidați care sunt născuți după anul 200_ (interogare doar pentru unele coloane din tabela date_identificare_candidati pe baza unui filtru/condiții  + LIKE)
	select nume_candidat, prenume_candidat, data_nastere_candidat from date_identificare_candidati where data_nastere_candidat like '200%';

--- returnarea contractelor de la facultatea de Chimie care nu au nr. de contract null (interogare tabela contracte_studii pe baza unui filtru/condiții + AND)
	select * from contracte_studii where facultate = 'Chimie' and nr_contract is not null;

--- returnarea contractelor de la facultatea de Istorie sau care au nr. de contract ce începe cu cifra 4 (interogare tabela contracte_studii pe baza unui filtru/condiții + OR)
	select * from contracte_studii where facultate = 'Istorie' or nr_contract like '4%';

--- funcțiile agregate MIN, MAX, SUM, AVG, COUNT
--- verificarea numărului total de contracte semnate / numărarea tuturor înregistrările din tabela contracte_studii
	select count(*) from contracte_studii;
--- verificarea numărului total de burse / numărarea tuturor înregistrările din tabela burse
	select count(*) from burse;

--- verificarea contractului cu numărul cel mai mare din tabela contracte_studii
	select max(nr_contract) from contracte_studii;
--- verificarea contractului cu numărul cel mai mic din tabela contracte_studii
	select min(nr_contract) from contracte_studii;

--- identificarea mediei aritmetice a tuturor mediilor de BAC ale candidaților, rotunjită la 2 zecimale (redenumire coloana de răspuns cu ALIAS)
    select round(avg(medie_bac),2) as "Media aritmetică a mediilor de BAC a candidaților" from istoric_studii;
    
--- identificarea valorii totale a burselor pentru o lună, (redenumire coloana de răspuns cu ALIAS)
    select sum(valoare_bursa) as " Valoarea totală a burselor alocate în fiecare lună" from burse;

--- funcții agregate, group by
--- returnarea bursei medii, minimă și maximă din cadrul fiecărei facultăți
	select 
		facultate as "Facultate",
        avg(valoare_bursa) as "Bursă medie",
		min(valoare_bursa) as "Bursă minimă",
		max(valoare_bursa) as "Bursă maximă"
        from burse
        inner join contracte_studii on contracte_studii.id_contract=burse.id_contract 
        group by facultate;

--- grupare în funcție de o condiție anume cu HAVING
--- returnarea liceelor care au avut candidați cu media la BAC mai mare ca 9
	select liceu,
		avg(medie_bac) as "Media de la BAC"
		from istoric_studii group by liceu
		having avg(medie_bac)>9;

--- subquery = interogare în interiorul altei interogări 
--- returnarea liceelor și profilelor care au avut o durată a numărului de ani de studii peste nr. de ani de studii medii
	select liceu, profil, nr_ani from istoric_studii
		where nr_ani > (select avg(nr_ani) from istoric_studii);

--- INNER JOIN
--- returnarea numelui și prenumelui și a nr contractului de studii pentru fiecare candidat (legătură între tabela date_identificare_candidati și contracte_studii)
	select nume_candidat, prenume_candidat, nr_contract from date_identificare_candidati inner join contracte_studii
		on date_identificare_candidati.id=contracte_studii.id_candidat;
    
 --- returnarea liceului, mediei de la BAC, a numelui și prenumelui pentru fiecare candidat (legătură între tabela date_identificare_candidati și istoric_studii)
	select nume_candidat, prenume_candidat, liceu, medie_bac from date_identificare_candidati inner join istoric_studii
		on date_identificare_candidati.id=istoric_studii.id_candidat;

--- inner join cu 3 tabele
 --- returnarea nr contractului de studii, valorii bursei, a numelui și prenumelui pentru fiecare student care are bursă 
 --- (legătură între tabela date_identificare_candidati, contracte_studii și burse)
	select nume_candidat, prenume_candidat, nr_contract, valoare_bursa from date_identificare_candidati 
		inner join contracte_studii on contracte_studii.id_candidat=date_identificare_candidati.id
		inner join burse on burse.id_contract=contracte_studii.id_contract;

--- LEFT JOIN: 
--- returnarea nr contractului de studii, a numelui și prenumelui pentru fiecare candidat, prima redare fiind nr. de contract
	select nr_contract, nume_candidat, prenume_candidat
		from date_identificare_candidati left join contracte_studii on date_identificare_candidati.id=contracte_studii.id_candidat;
--- returnarea	liceului, nr de ani de studii, a numelui și prenumelui pentru fiecare candidat care a făcut un liceu sau nr. de ani de studii a fost mai mare ca 3
    select liceu, nr_ani, nume_candidat, prenume_candidat
		from date_identificare_candidati left join istoric_studii on date_identificare_candidati.id=istoric_studii.id_candidat
        where liceu != null or nr_ani >3;
        
--- RIGHT JOIN: 
--- returnarea județului, a localității de domiciliu, a numelui și prenumelui pentru fiecare candidat, inclusiv pentru acei candidați care nu au încă adrese completate
	select judet, localitate, nume_candidat, prenume_candidat
		from adrese_domiciliu_candidati right join date_identificare_candidati on date_identificare_candidati.id=adrese_domiciliu_candidati.id_candidat;
--- returnarea județului, a localității de domiciliu, a numelui și prenumelui DOAR pentru candidații care au adrese completate
    select judet, localitate, nume_candidat, prenume_candidat
		from date_identificare_candidati right join adrese_domiciliu_candidati on adrese_domiciliu_candidati.id_candidat=date_identificare_candidati.id;
--- returnarea tuturor adreselor de e-mail-ul, a numelui și prenumelui pentru fiecare candidat, pornind de la tabela date_contact
    select email_candidat, nume_candidat, prenume_candidat
		from date_contact right join date_identificare_candidati on date_identificare_candidati.id=date_contact.id_candidat;

--- CROSS JOIN 
--- produs cartezian între tabela de burse și tabela date_identificare_candidați
	select id_bursa, valoare_bursa, nume_candidat, prenume_candidat
		from burse cross join date_identificare_candidati;

--- returnare a acelor burse mai mari de 500, a numelui și prenumelui studentui care beneficiază de ea (grupat după id_bursă)
	select valoare_bursa, id_bursa, nume_candidat, prenume_candidat
		from burse
		inner join date_identificare_candidati on burse.id_candidat = date_identificare_candidati.id
		where valoare_bursa > 500
		group by id_bursa;

--- verificare id candidați și data semnare contracte de studii din 2023, pentru studenții care nu au asociat un nr_RMU (grupate după id_candidat)
	select id_candidat, max(data_contract)
		from date_identificare_candidati 
		inner join contracte_studii on date_identificare_candidati.id = contracte_studii.id_candidat
		where data_contract like '2023%'
        and nr_RMU is null
		group by id_candidat;

--- returnarea numelor și prenumelor candidaților, care au semnat contractele de studii în luna 10 și care AU nr_contract (grupate după nume și prenume candidat)
    select nume_candidat, prenume_candidat, max(data_contract), nr_contract
		from date_identificare_candidati 
		inner join contracte_studii on date_identificare_candidati.id = contracte_studii.id_candidat
		where data_contract like '%-10-%'
        and nr_contract is not null
		group by nume_candidat, prenume_candidat;

--- inner join 3 tabele și cu condiție
--- returnarea numelor și prenumelor candidaților, a nr de contract de studii și valorii bursei pentru acei studenți care au bursa mai mare de 400 
--- (legătură între cele 3 tabele: tabela date_identificare_candidati, contracte_studii și burse)
	select nume_candidat, prenume_candidat, nr_contract, valoare_bursa from date_identificare_candidati 
		inner join contracte_studii on contracte_studii.id_candidat=date_identificare_candidati.id
		inner join burse on burse.id_contract=contracte_studii.id_contract
        where valoare_bursa > 400;
