drop table Besucht;
drop table SetztVoraus;
drop table Geeignet;
drop table KVeranst;
drop table Referent;
drop table Person;
drop table Kurs;

create table Kurs (
  KNr number not null,
  Bezeichn varchar(100) not null,
  Tage number not null,
  Preis number not null,
  primary key(KNr)
);

create table Person (
  PNr number not null,
  FName varchar(100) not null,
  VName varchar(100) not null,
  Ort varchar(100) not null,
  Land varchar(3) not null,
  primary key(PNr)
);

create table Referent (
  PNr number not null,
  GebDat date not null,
  Seit date not null,
  Titel varchar(30),
  constraint Fk_PNr_R foreign key (PNr) references Person(PNr)
);

create table KVeranst (
  KNr number not null,
  KNrLfnd number not null,
  Von date not null,
  Bis date not null,
  Ort varchar(100) not null,
  Plaetze number not null,
  PNr number,
  constraint Fk_KNr_Kv foreign key (KNr) references Kurs(KNr),
  primary key(KNr, KNrLfnd),
  constraint Fk_PNr_Kv foreign key (PNr) references Person(PNr)
);

create table Geeignet (
  KNr number not null,
  PNr number not null,
  constraint Fk_Knr_G foreign key (KNr) references Kurs(KNr),
  constraint Fk_PNr_G foreign key (PNr) references Person(PNr)
);

create table SetztVoraus (
  KNr number not null,
  KNrVor number not null,
  constraint Fk_Knr_V foreign key (KNr) references Kurs(KNr),
  constraint Fk_KnrVor_V foreign key (KNr) references Kurs(Knr)
);

create table Besucht (
  KNr number not null,
  KNrLfnd number not null,
  PNr number not null,
  Bezahlt date,
  constraint Fk_KNr_B_KnrLfd_B foreign Key(KNr, KNrLfnd) references KVeranst(KNr, KNrLfnd),
  constraint Fk_PNr_B foreign key(PNr) references Person(PNr)
);

insert into Person values(101, 'Bach', 'Johann Sebastian', 'Leipzig', 'D');
insert into Person values(102, 'Händel', 'Georg Friedrich', 'London', 'GB');
insert into Person values(103, 'Haydn', 'Joseph', 'Wien', 'A');
insert into Person values(104, 'Mozart', 'Wolfgang Amadeus', 'Salzburg', 'A');
insert into Person values(105, 'Beethoven', 'Ludwig van', 'Wien', 'A');
insert into Person values(106, 'Schubert', 'Franz', 'Wien', 'A');
insert into Person values(107, 'Berlioz', 'Hector', 'Paris', 'F');
insert into Person values(108, 'Liszt', 'Franz', 'Wien', 'A');
insert into Person values(109, 'Wagner', 'Richard', 'München', 'D');
insert into Person values(110, 'Verdi', 'Giuseppe', 'Busseto', 'I');
insert into Person values(111, 'Bruckner', 'Anton', 'Linz', 'A');
insert into Person values(112, 'Brahms', 'Johannes', 'Wien', 'A');
insert into Person values(113, 'Bizet', 'Georges', 'Paris', 'F');
insert into Person values(114, 'Tschaikowskij', 'Peter', 'Moskau', 'RUS');
insert into Person values(115, 'Puccini', 'Giacomo', 'Mailand', 'I');
insert into Person values(116, 'Strauss', 'Richard', 'München', 'D');
insert into Person values(117, 'Schönberg', 'Arnold', 'Wien', 'D');

insert into Referent values(101, '21.3.1935', '1.1.1980', null);
insert into Referent values(103, '1.4.1932', '1.1.1991', null);
insert into Referent values(104, '27.1.1956', '1.7.1985', null);
insert into Referent values(111, '4.9.1924', '1.7.1990', 'Mag');
insert into Referent values(114, '25.4.1940', '1.7.1980', null);
insert into Referent values(116, '11.6.1964', '1.1.1994', 'Dr');

insert into Kurs values(1, 'Notenkunde', 2, 1400.00);
insert into Kurs values(2, 'Harmonielehre', 3, 2000.00);
insert into Kurs values(3, 'Rhythmik', 1, 700.00);
insert into Kurs values(4, 'Instrumentenkunde', 2, 1500.00);
insert into Kurs values(5, 'Dirigieren', 3, 1900.00);
insert into Kurs values(6, 'Musikgeschichte', 2, 1400.00);
insert into Kurs values(7, 'Komposition', 4, 3000.00);

insert into KVeranst values(1, 1, '7.4.2003', '8.4.2003', 'Wien', 3, 103);
insert into KVeranst values(1, 2, '23.6.2004', '24.6.2004', 'Moskau', 4, 114);
insert into KVeranst values(1, 3, '10.4.2005', '11.4.2005', 'Paris', 3, null);
insert into KVeranst values(2, 1, '9.10.2003', '11.10.2003', 'Wien', 4, 104);
insert into KVeranst values(3, 1, '17.11.2003', '17.11.2003', 'Moskau', 3, 103);
insert into KVeranst values(4, 1, '12.1.2004', '13.1.2004', 'Wien', 2, 116);
insert into KVeranst values(4, 2, '28.3.2004', '29.3.2004', 'Wien', 4, 104);
insert into KVeranst values(5, 1, '18.5.2004', '20.5.2004', 'Paris', 3, 101);
insert into KVeranst values(5, 2, '23.9.2004', '26.9.2004', 'Wien', 2, 101);
insert into KVeranst values(5 ,3, '30.3.2005', '1.4.2005', 'Rom', 3, null);
insert into KVeranst values(7 ,1, '9.3.2005', '13.3.2005', 'Wien', 5, 103);
insert into KVeranst values(7 ,2, '14.9.2005', '18.9.2005', 'Muenchen', 4, 116);

insert into Geeignet values(1, 103);
insert into Geeignet values(1, 114);
insert into Geeignet values(2, 104);
insert into Geeignet values(2, 111);
insert into Geeignet values(3, 103);
insert into Geeignet values(4, 104);
insert into Geeignet values(5, 101);
insert into Geeignet values(5, 114);
insert into Geeignet values(6, 111);
insert into Geeignet values(7, 103);
insert into Geeignet values(7, 116);

insert into SetztVoraus values(2, 1);
insert into SetztVoraus values(3, 1);
insert into SetztVoraus values(5, 2);
insert into SetztVoraus values(5, 3);
insert into SetztVoraus values(5, 4);
insert into SetztVoraus values(7, 5);
insert into SetztVoraus values(7, 6);

insert into Besucht values(1, 1, 108, '1.5.2003');
insert into Besucht values(1, 1, 109, null);
insert into Besucht values(1, 1, 114, null);
insert into Besucht values(1, 2, 110, '1.7.2004');
insert into Besucht values(1, 2, 112, '3.7.2004');
insert into Besucht values(1, 2, 113, '20.7.2004');
insert into Besucht values(1, 2, 116, null);
insert into Besucht values(1, 3, 110, null);
insert into Besucht values(2, 1, 105, '15.10.2003');
insert into Besucht values(2, 1, 109, '3.11.2003');
insert into Besucht values(2, 1, 112, '28.10.2003');
insert into Besucht values(2, 1, 116, null);
insert into Besucht values(3, 1, 101, null);
insert into Besucht values(3, 1, 109, null);
insert into Besucht values(3, 1, 117, '20.11.2003');
insert into Besucht values(4, 1, 102, '20.1.2004');
insert into Besucht values(4, 1, 107, '1.2.2004');
insert into Besucht values(4, 1, 111, null);
insert into Besucht values(4, 2, 106, '7.4.2004');
insert into Besucht values(4, 2, 109, '15.4.2004');
insert into Besucht values(5, 1, 103, null);
insert into Besucht values(5, 1, 109, '7.6.2004');
insert into Besucht values(5, 2, 115, '7.10.2004');
insert into Besucht values(5, 2, 116, null);
insert into Besucht values(7, 1, 109, '20.3.2005');
insert into Besucht values(7, 1, 113, null);
insert into Besucht values(7, 1, 117, '8.4.2005');

select * from Kurs;
select * from Person;
select * from Referent;
select * from KVeranst;
select * from Geeignet;
select * from SetztVoraus;
select * from Besucht;

-- 4)
-- welche kurse (KNr) haben einen Kurs als Voraussetzung
select KNr from SetztVoraus;

-- 5)
-- welche kurse (bezeichnung) dauern zwischen 2 und 4 tagen und haben einen
-- durchschnittlichen Tagespreis von hoechstens 700.-? (aufsteigend nach bezeichnung sortiert)
select Bezeichn from Kurs where (Tage between 2 and 4) and (Preis/Tage <= 700)
order by Bezeichn;

-- 6)
-- welche personen (familienname) haben ein leerzeichen im vornamen
-- und den selben vokal zweimal im ort?
select FName from Person where VName like '% %' and lower(Ort) like '%a%a%'
                                                or lower(Ort) like '%e%e%'
                                                or lower(Ort) like '%i%i%'
                                                or lower(Ort) like '%o%o%'
                                                or lower(Ort) like '%u%u%';

-- 7)
-- welche personen haben noch nicht alle kursbesuche bezahlt                                             
select distinct b.PNr from Besucht b where b.Bezahlt is null
order by 1;

-- 8)
-- wieviele tage dauern die kursveranstaltungen, die in wien stattfinden
-- und von referent 103 oder 104 gehalten werden? (KNr, KNrLfnd, Tage - danach absteigend)
select PNr, KNr, KNrLfnd, Bis-Von as Dauer_in_Tagen from KVeranst 
where (PNr = 103 or PNr = 104)
and (Ort = 'Wien');

-- 9)
-- welche referenten (PNr, Alter) sind aelter als 75 jahre?
-- Verwende als Dauer eines Jahres 365,25 Tage
select PNr, round((sysdate - GebDat)/365.25) as AGE from Referent
where (sysdate - GebDat)/365.25 > 75;

-- 10)
-- welche personen (PNr) halten oder besuchen mindestens
-- eine Kursveranstaltung?
select distinct k.PNr from KVeranst k
where k.PNr is not null
union (select distinct b.PNr from Besucht b);


-- 11)
-- alle kursveranstaltungen (KNr, Bezeichnung, KNrLfnd, von), 
-- bei denen noch kein referent festgelegt ist
select k.KNr, k.Bezeichn, kv.KNrLfnd, kv.Von from KVeranst kv
join Kurs k on k.KNr = kv.KNr
where PNr is null;

-- 12)
-- alle kursveranstaltungen (KNr, Bezeichnung, KNrLfnd, von)
-- die mindestens ein Teilnehmer besucht
select k.KNr, k.Bezeichn, kv.KNrLfnd, kv.Von, count(b.Pnr) as ANZAHL_TEILNEHMER from KVeranst kv
join Besucht b on b.KNr = kv.KNr
join Kurs k on k.KNr = kv.Knr
group by k.KNr, k.Bezeichn, kv.KnrLfnd, kv.Von
having count(b.PNr) > 1;

-- 13)
-- alle kursveranstaltungen (KNr, Bezeichnung, KNrLfnd, von)
-- die mindestens ein Teilnehmer besucht und bei denen
-- schon ein referent festgelegt ist
select k.KNr, k.Bezeichn, kv.KNrLfnd, kv.Von, count(b.Pnr) as ANZAHL_TEILNEHMER from KVeranst kv
join Besucht b on b.KNr = kv.KNr
join Kurs k on k.KNr = kv.Knr
where kv.PNr is not null
group by k.KNr, k.Bezeichn, kv.KnrLfnd, kv.Von
having count(b.PNr) > 1;

-- 14)
-- referenten zahlen fuer besuche von kursveranstaltungen nichts
-- zeigen sie besuche (samt kursbezeichnung und familienname)
-- wo dies nicht eingehalten wurde
select b.* from besucht b
join referent r on b.pnr = r.pnr
where bezahlt is not null;

-- 15)
-- teilnehmerliste pro kursveranstaltung 
-- mit folgenden spalten (sortiert nach vonDatum und
-- Kursbezeichnung)
-- -> Kursbezeichnung
-- -> vonDatum
-- -> Familien- und Vorname des Referenten
-- -> Familien- und Vorname des Teilnehmers
select k.bezeichn, kv.von, r.fname, r.vname, p.fname, p.vname
from besucht b
join kveranst kv on b.knr = kv.knr and b.knrlfnd = kv.knrlfnd
join kurs k on kv.knr = k.knr
join person p on p.pnr = b.pnr
left join person r on kv.pnr = r.pnr 
order by 2,1;

-- 16)
-- welche kursveranstaltungen (bezeichnung, vonDatum) werden
-- von referenten besucht?
select k.KNr, kv.Von from KVeranst kv
join Kurs k on k.KNr = kv.KNr
join Besucht b on b.KNr = kv.KNr and b.KNrLfnd = kv.KnrLfnd
join Referent r on r.Pnr = b.PNr
group by k.KNr, kv.Von;

-- 17)
-- welche kursveranstaltungen (bezeichnung, vondatum)
-- werden von referenten besucht und halten diese
-- auch? (Fehlerfall!)
select k.KNr, kv.Von from KVeranst kv
join Kurs k on k.KNr = kv.KNr
join Besucht b on b.KNr = kv.KNr and b.KNrLfnd = kv.KnrLfnd
join Referent r on r.Pnr = b.PNr
where b.PNr = kv.PNr
group by k.KNr, kv.Von;

-- 18)
-- welche personen (FName) haben den Kurs Nr 1 
-- und den Kurs Nr 5 besucht?
select distinct p.FName from Person p
join Besucht b on b.PNr = p.PNr
where b.KNr = 1 and b.KNr = 5;

-- 19)
-- alle kursveranstaltungen mit durchschnittlichen
-- tagespreisen zwischen 610,- und 690,-
-- die von referenten ohne titel gehalten werden
-- (Bezeichn, von, bin, durchschnittlicher tagespreis)
select k.Bezeichn, kv.Von, kv.Bis, round(k.Preis/k.Tage) from KVeranst kv
join Kurs k on k.KNr = kv.KNr
join Besucht b on b.KNr = kv.KNr and b.KNrLfnd = kv.KNrLfnd
join Referent r on r.PNr = kv.PNr
where r.Titel is null and (k.Preis/k.Tage) between 610 and 690
group by k.Bezeichn, kv.Von, kv.Bis, (k.Preis/k.Tage);

-- 20)
-- welche Kursbesuche wurden vor dem Kursbeginn bezahlt?
-- welche kursbesuche wurden waehrend des Kurses bezahlt?
-- welche kursbesuche wurden nach dem kursende bezahlt?
select kv.KNrLfnd, k.Bezeichn from KVeranst kv
join Kurs k on k.KNr = kv.KNr
join Besucht b on b.KNr = kv.KNr and b.KNrLfnd = kv.KNrLfnd
where b.Bezahlt < kv.Von;
select kv.KNrLfnd, k.Bezeichn from KVeranst kv
join Kurs k on k.KNr = kv.KNr
join Besucht b on b.KNr = kv.KNr and b.KNrLfnd = kv.KNrLfnd
where b.Bezahlt between kv.Von and kv.Bis;

select kv.KNrLfnd, k.Bezeichn from KVeranst kv
join Kurs k on k.KNr = kv.KNr
join Besucht b on b.KNr = kv.KNr and b.KNrLfnd = kv.KNrLfnd
where b.Bezahlt > kv.Von;

-- 21)
-- welche personen (familienname, danach sortiert) besuchen
-- kursveranstaltungen, die in ihrem wohnort abgehalten werden
-- und laenger als 2 tage dauern?
select p.FName from Besucht b
join Person p on p.PNr = b.PNr
join KVeranst kv on kv.KNr = b.KNr and b.KNrLfnd = kv.KNrLfnd
join Kurs k on k.KNr = kv.KNr
where p.Ort = kv.Ort and k.Tage > 2
order by p.FName desc;

-- 22)
-- welche kursveranstaltungen (bezeichnung, laufende nummer) 
-- werden von referenten gehalten, die fuer den kurs auch
-- geeignet sind
select k.Bezeichn, kv.KNrLfnd from KVeranst kv
join Geeignet g on g.KNr = kv.KNr
join Referent r on r.PNr = g.PNr
join Kurs k on kv.KNr = k.KNr
where kv.PNr = r.PNr
group by k.Bezeichn, kv.KNrLfnd;

-- 23)
-- alle referenten (nummer und name), die kursveranstaltungen
-- gehalten haben bevor/nachdem sie in die firma eingetreten
-- sind
select p.PNr, p.FName, p.VName from Person p
join Referent r on r.PNr = p.PNr
join KVeranst kv on kv.PNr = r.PNr
where kv.Von > r.Seit;

select p.PNr, p.FName, p.VName from Person p
join Referent r on r.PNr = p.PNr
join KVeranst kv on kv.PNr = r.PNr
where kv.Von < r.Seit;

-- 24)
-- all personen (PNr, FName), die einen Kurs in wien besucht
-- oder gehalten haben
select p.PNr, p.FName from Person p
join Besucht b on b.PNr = p.PNr
join KVeranst kv on kv.PNr = p.PNr
where kv.Ort = 'Wien'
union
select p.PNr, p.FName from Person p
join KVeranst kv on kv.PNr = p.PNr
where kv.Ort = 'Wien';

-- 25)
-- dauer der kursveranstaltungen im vergleich mit der im kurs
-- angegebenen dauer
select (kv.Bis - kv.Von), k.Tage from KVeranst kv
join Kurs k on k.KNr = kv.KNr;

-- 26)
-- welche referenten (nummer und name) haben 
-- kursveranstaltungen in einem alter von ueber 60 jahren gehalten
select p.PNr, p.VName, p.FName, round((kv.Von - r.GebDat)/365.25) as age_alter from KVeranst kv
join Referent r on r.PNr = kv.PNr
join Person p on p.PNr = r.PNr
where ((kv.Von - r.GebDat)/365.25) > 60;

-- 27)
-- welche kursveranstaltungen gibt es, zu denen eine
-- (unmittelbar) vorausgesetzte Kursveranstaltung zeitlich davor
-- und am selben ort abgehalten wird?
-- (jeweils alle daten der kursveranstaltung und der
-- vorausgesetzten Kursveranstaltung)
select * from KVeranst kv
join SetztVoraus s on kv.KNr = s.KNr
join KVeranst kvvor on kvvor.KNr = s.KNrVor
where (kvvor.Von < kv.Von) and kvvor.Ort = kv.Ort;

-- 28)
-- welche kursveranstaltungen ueberschneiden einander
-- terminlich? (je bezeichnung, laufende Nummer, von, bis)
select k.Bezeichn, kv.KNrLfnd, kv.Von, kv.Bis from KVeranst kv
join Kurs k on k.KNr = kv.KNr
where kv.Von in (select kv2.Von from KVeranst kv2
                  join Kurs k2 on kv2.KNr = k2.KNr);
                  
-- 29)
-- Gibt es Personen (Familien- und Vorname), bei denen
-- Kursbesuche einander terminlich ueberschneiden?
select p.fname, p.vname from Person p
join Besucht b1 on b1.PNr = p.PNr
join Besucht b2 on b2.PNr = p.PNr
join KVeranst kv1 on kv1.KNr = b1.KNr and kv1.KNrLfnd = b1.KNrLfnd
join KVeranst kv2 on kv2.KNr = b2.KNr and kv2.KNrLfnd = b2.KNrLfnd
where
(kv1.von > kv2.von and kv1.von < kv2.bis) or 
(kv1.von < kv2.von and kv1.bis > kv2.bis) or
((kv1.von > kv2.von and kv1.von < kv2.bis) and kv1.bis > kv2.bis) or
(kv1.von < kv2.von and kv1.bis > kv2.bis);


