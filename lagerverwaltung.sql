drop table preise;
drop table lieferung;
drop table lager;
drop table artikel;

create table lager (
  LNr INT,
  Ort VARCHAR(45),
  StueckKap INT,
  primary key(LNr)
);

create table artikel (
  ANr INT,
  Bezeichnung VARCHAR(45),
  primary key(ANr)
);

create table lieferung (
  LNr INT,
  LfndNr INT,
  Datum DATE,
  Stueck INT,
  ANr int,
  constraint Fk_LNr_L foreign key(LNr) references lager(LNr),
  primary key(LNr, LfndNr),
  constraint Fk_ANr_L foreign key(ANr) references artikel(ANr)
);

create table preise (
  ANr INT,
  Gueltig_Ab DATE,
  Gueltig_Bis DATE,
  Preis decimal(8,2),
  constraint Fk_ANr_P foreign key(ANr) references artikel(ANr),
  primary key(ANr, Gueltig_Ab)
);



Insert into ARTIKEL (ANR,BEZEICHNUNG) values (1,'Apfel'); 
Insert into ARTIKEL (ANR,BEZEICHNUNG) values (2,'Birne'); 
Insert into ARTIKEL (ANR,BEZEICHNUNG) values (3,'Banane');

Insert into LAGER (LNR,ORT,STUECKKAP) values (11,'Probstdorf',40); 
Insert into LAGER (LNR,ORT,STUECKKAP) values (12,'Wolkersdorf',30); 
Insert into LAGER (LNR,ORT,STUECKKAP) values (13,'Vösendorf',60);
Insert into LAGER (LNR,ORT,STUECKKAP) values (14,'Neusiedl am See',80); 
Insert into LAGER (LNR,ORT,STUECKKAP) values (15,'Brunn am Gebirge',100);

alter session set nls_date_format='RRRR.MM.DD';

Insert into LIEFERUNG ( LNR, LFNDNR, DATUM,STUECK, ANR) values (11,1,'2014-03-01', 10, 1);
Insert into LIEFERUNG ( LNR, LFNDNR, DATUM,STUECK, ANR) values (11,2,'2014-03-02', 20, 1);
Insert into LIEFERUNG ( LNR, LFNDNR, DATUM,STUECK, ANR) values (11,3,'2014-03-03', 40, 1);
Insert into LIEFERUNG ( LNR, LFNDNR, DATUM,STUECK, ANR) values (11,4,'2014-03-04', -40, 1);
Insert into LIEFERUNG ( LNR, LFNDNR, DATUM,STUECK, ANR) values (11,5,'2014-03-05', -40, 1);
Insert into LIEFERUNG ( LNR, LFNDNR, DATUM,STUECK, ANR) values (11,6,'2014-03-06', 10, 1);
Insert into LIEFERUNG ( LNR, LFNDNR, DATUM,STUECK, ANR) values (12,1,'2014-03-01', 10, 1);
Insert into LIEFERUNG ( LNR, LFNDNR, DATUM,STUECK, ANR) values (12,2,'2014-03-02', 20, 1);
Insert into LIEFERUNG ( LNR, LFNDNR, DATUM,STUECK, ANR) values (12,3,'2014-03-03', 10, 1);
Insert into LIEFERUNG ( LNR, LFNDNR, DATUM,STUECK, ANR) values (12,4,'2014-03-04', -40, 1);
Insert into LIEFERUNG ( LNR, LFNDNR, DATUM,STUECK, ANR) values (12,5,'2014-03-05', 40, 1);
Insert into LIEFERUNG ( LNR, LFNDNR, DATUM,STUECK, ANR) values (12,6,'2014-03-06', -10, 1);
Insert into LIEFERUNG ( LNR, LFNDNR, DATUM,STUECK, ANR) values (13,1,'2014-03-01', 10, 1);
Insert into LIEFERUNG ( LNR, LFNDNR, DATUM,STUECK, ANR) values (13,2,'2014-03-02', 20, 1);
Insert into LIEFERUNG ( LNR, LFNDNR, DATUM,STUECK, ANR) values (13,3,'2014-03-03', 10, 1);
Insert into LIEFERUNG ( LNR, LFNDNR, DATUM,STUECK, ANR) values (13,4,'2014-03-04', -40, 1);
Insert into LIEFERUNG ( LNR, LFNDNR, DATUM,STUECK, ANR) values (13,5,'2014-03-05', 40, 1);
Insert into LIEFERUNG ( LNR, LFNDNR, DATUM,STUECK, ANR) values (13,6,'2014-03-06', 20, 1);

alter session set nls_date_format='RRRR.MM.DD';

Insert into Preise (ANR, GUELTIG_AB, GUELTIG_BIS, PREIS) VALUES (1, '2014-01-01','2014-01-31',2); 
Insert into Preise (ANR, GUELTIG_AB, GUELTIG_BIS, PREIS) VALUES (1, '2014-02-01','2014-02-28',2.1); 
Insert into Preise (ANR, GUELTIG_AB, GUELTIG_BIS, PREIS) VALUES (1, '2014-03-01','2014-03-31',2.2); 
Insert into Preise (ANR, GUELTIG_AB, GUELTIG_BIS, PREIS) VALUES (1, '2014-04-01','2014-04-30',2.1); 
Insert into Preise (ANR, GUELTIG_AB, GUELTIG_BIS, PREIS) VALUES (1, '2014-05-01','2014-05-31',2.3); 
Insert into Preise (ANR, GUELTIG_AB, GUELTIG_BIS, PREIS) VALUES (1, '2014-12-01',null,3);

Insert into Preise (ANR, GUELTIG_AB, GUELTIG_BIS, PREIS) VALUES (2, '2014-01-01','2014-01-31',3); 
Insert into Preise (ANR, GUELTIG_AB, GUELTIG_BIS, PREIS) VALUES (2, '2014-02-01','2014-02-28',3.1); 
Insert into Preise (ANR, GUELTIG_AB, GUELTIG_BIS, PREIS) VALUES (2, '2014-03-01','2014-03-31',3.2); 
Insert into Preise (ANR, GUELTIG_AB, GUELTIG_BIS, PREIS) VALUES (2, '2014-04-01','2014-04-30',3.1); 
Insert into Preise (ANR, GUELTIG_AB, GUELTIG_BIS, PREIS) VALUES (2, '2014-05-01','2014-05-31',3.3); 
Insert into Preise (ANR, GUELTIG_AB, GUELTIG_BIS, PREIS) VALUES (2, '2014-12-01',null,4);
Insert into Preise (ANR, GUELTIG_AB, GUELTIG_BIS, PREIS) VALUES (3, '2014-01-01','2014-01-31',4); 
Insert into Preise (ANR, GUELTIG_AB, GUELTIG_BIS, PREIS) VALUES (3, '2014-02-01','2014-02-28',4.1); 
Insert into Preise (ANR, GUELTIG_AB, GUELTIG_BIS, PREIS) VALUES (3, '2014-03-01','2014-03-31',4.2); 
Insert into Preise (ANR, GUELTIG_AB, GUELTIG_BIS, PREIS) VALUES (3, '2014-04-01','2014-04-30',4.1); 
Insert into Preise (ANR, GUELTIG_AB, GUELTIG_BIS, PREIS) VALUES (3, '2014-05-01','2014-05-31',4.3); 
Insert into Preise (ANR, GUELTIG_AB, GUELTIG_BIS, PREIS) VALUES (3, '2014-12-01',null,5);
-- BAD - Preise mit schlechten Gültigkeitszeitraum
Insert into Preise (ANR, GUELTIG_AB, GUELTIG_BIS, PREIS) VALUES (1, '2014-01-02','2013-01-31',91); 
Insert into Preise (ANR, GUELTIG_AB, GUELTIG_BIS, PREIS) VALUES (1, '2014-01-03','2014-01-31',92); 
Insert into Preise (ANR, GUELTIG_AB, GUELTIG_BIS, PREIS) VALUES (1, '2013-01-04','2014-01-01',93); 
Insert into Preise (ANR, GUELTIG_AB, GUELTIG_BIS, PREIS) VALUES (1, '2016-01-01',null,94);
Insert into Preise (ANR, GUELTIG_AB, GUELTIG_BIS, PREIS) VALUES (1, '2013-01-01','2015-01-01',95); 
Insert into Preise (ANR, GUELTIG_AB, GUELTIG_BIS, PREIS) VALUES (1, '2017-01-01','2017-02-01',96); 
Insert into Preise (ANR, GUELTIG_AB, GUELTIG_BIS, PREIS) VALUES (1, '2013-01-03','2014-10-01',97); 
Insert into Preise (ANR, GUELTIG_AB, GUELTIG_BIS, PREIS) VALUES (1, '2014-11-01','2014-11-11',98); 
Insert into Preise (ANR, GUELTIG_AB, GUELTIG_BIS, PREIS) VALUES (1, '2014-11-02','2014-11-11',99);

-- Lager 3 Preise erhöhen Daten SQL
-- Erhöhe alle Preise um 5 Prozent
update preise set preis=preis*1.005;
select * from preise;

-- Lager 4 löschen Daten SQL
-- Lösche das Lager mit der kleinsten ID
delete from lieferung where LNr = (select min(LNr) from lager);
delete from lager where LNr = (select min(LNr) from lager);
select * from lieferung;
select * from lager;


-- Lager 5.a: Lagerstand Daten SQL
-- Schreibe ein SELECT das zu jedem Lager die aktuelle 
-- Stückanzahl angibt. AUSGABE: Lagernummer sortiert, aktuelle 
-- Stückanzahl
-- (Die Einzelbuchungen stehen in Tabelle Lieferung)

--set serveroutput on
declare
gesamtlagerstand number;
cursor getLager is select lnr from lager;
cursor getLieferung (l number) is select stueck from lieferung where lnr = l;
begin
  for l in getLager loop
    gesamtlagerstand := 0;
    for lie in getLieferung(l.lnr) loop
      gesamtlagerstand := gesamtlagerstand + lie.stueck;
    end loop;
    dbms_output.put_line('Lager: ' || l.lnr || '    Lagerstand: ' || gesamtlagerstand);
  end loop;
end;
/

-- Lager 5.b: Lagerungsverlauf Daten oraSQL mySQL
-- Prüfe jede Lagerstelle ob sie jemals über die Kapazitätsgrenze gefüllt wurde, 
-- oder auch einmal ein negativer Lagerstand aufgetreten ist.
-- Gib in beiden Fehlerfällen eine brauchbare Fehlermeldung aus.
-- HINWEIS: Block mit 2 verschachtelten Cursor-Schleifen
--set serveroutput on
declare
gesamtlagerstand number;
cursor getLager is select lnr, stueckkap from lager;
cursor getLieferung (l number) is select lfndnr, stueck from lieferung where lnr = l;
begin
  for l in getLager loop
    gesamtlagerstand := 0;
    for lie in getLieferung(l.lnr) loop
      gesamtlagerstand := gesamtlagerstand + lie.stueck;
      if gesamtlagerstand < 0
      then
        dbms_output.put_line('Negativer Lagerstand bei Lager ' || l.lnr || ' bei Lieferung ' || lie.lfndnr || '. Lagerstand: ' || gesamtlagerstand);
      elsif gesamtlagerstand > l.stueckkap
      then
        dbms_output.put_line('Lagerstand ueberschritten bei Lager ' || l.lnr || ' bei Lieferung ' || lie.lfndnr || '. Lagerstand: ' || gesamtlagerstand);
      end if;
    end loop;
    dbms_output.put_line('Lager: ' || l.lnr || '    Lagerstand: ' || gesamtlagerstand);
  end loop;
end;
/

-- Lager 5 Procedure Anlieferung Daten oraSQL mySQL
-- erstelle eine Procedure Anlieferung mit den Parametern (P_Artikelbzeichnung VARCHAR, P_Datum date, P_Stueck INT)
-- Die Procedure muß für die richtige Artikelnummer,
-- Lagerstellen mit verfügbaren Platz suchen und die entsprechende Stückanzahl in alle nötigen Lagerplätze verbuchen.
-- Die Belegung eines Lagers ist durch Summieren von Lieferung zu ermitteln.
-- Bsp.: Es sind 160 Äpfel einzulagern. Dazu sind 5 Lager mit 50 Plätzen vorhanden. Im Lager 1 sind bereits 20 Plätze belegt.
--set serveroutput on
declare

procedure Anlieferung(P_Artikelbezeichnung varchar, P_Datum date, P_Stueck INT) as
gesamtlagerstand int;
nCount int;
liefNr int;
artNr int;
cursor getLager is select lnr, stueckkap from lager;
cursor getLieferung (l number) is select lfndnr, stueck from lieferung where lnr = l;
cursor getArtikelNr (bezeichn varchar) is select anr from Artikel where Bezeichnung = bezeichn;

begin
  nCount := P_Stueck;
  open getArtikelNr(P_Artikelbezeichnung);
  fetch getArtikelNr into artNr;
  close getArtikelNr;
  for l in getLager loop
    gesamtlagerstand := 0;
    liefNr := 0;
    for lie in getLieferung(l.lnr) loop
      gesamtlagerstand := gesamtlagerstand + lie.stueck;
      liefNr := lie.lfndnr;
    end loop;
    if gesamtlagerstand < l.stueckkap then
      if gesamtlagerstand >= 0 then
        if nCount > (l.stueckkap-gesamtlagerstand) then
          insert into Lieferung(LNR, LFNDNR, DATUM,STUECK, ANR) values(l.lnr, (liefNr+1), P_Datum, (l.stueckkap-gesamtlagerstand), artNr);
          nCount :=  nCount - (l.stueckkap-gesamtlagerstand);
        else
          insert into Lieferung(LNR, LFNDNR, DATUM,STUECK, ANR) values(l.lnr, (liefNr+1), P_Datum, nCount, artNr);
          nCount :=  0;
        end if;
      else
        insert into Lieferung(LNR, LFNDNR, DATUM,STUECK, ANR) values(l.lnr, (liefNr+1), P_Datum, l.stueckkap, artNr);
        nCount := nCount - l.stueckkap;
      end if;
    end if;
  end loop;
end Anlieferung;

begin
    Anlieferung('Apfel', sysdate, 160);
end;
/

select * from lieferung;

--execute Anlieferung('Apfel', sysdate, 160);


-- Lager 5.c: Artikelpreis Daten oraSQL mySQL
-- Erstelle eine stored Function die zu einer Artikelnummer und einen Stichtag den Preis ermittelt
-- CREATE OR REPLACE
-- FUNCTION getpreis (p_anr int, p_datum date) ....
--update preise set Gueltig_Bis='2015-12-31' where ANr = 1 and Gueltig_Bis = '2014-01-31' and Gueltig_Ab = '2014-01-01';

create or replace function getpreis(p_anr int, p_datum date) return number AS
pr number;
begin
  select preis into pr from preise where ANr = p_anr and (p_datum >= nvl(Gueltig_Ab, sysdate) and p_datum <= nvl(Gueltig_Bis, p_datum));
  return pr;
end getpreis;
/

delete from preise where preis > 90;
select * from preise;
SELECT getpreis(1, sysdate) from dual; -- sollte den Wert 3 liefern
select getpreis(1, '2014-03-01') from dual;
select getpreis(0, sysdate) from dual;
SELECT anr, bezeichnung, getpreis(anr, sysdate) from artikel; 
SELECT anr, bezeichnung, getpreis(anr, '2014-03-01') from artikel;

-- Lager 9
-- Von einem Artikel soll eine gewisse Anzahl aus den Lagern entnommen werden.
-- Dabei werden die Lager nach dem Artikel durchsucht.
-- Wenn ein Lager weniger Stück als gesucht enthält, wird der Eintrag gelöscht
-- und die gesuchte Anzahl entsprechend reduziert und nach weiteren Einträgen gesucht. 
-- Enthält ein Lager mehr Stück als gesucht, wird der Lagerstand entsprechend reduziert. 
-- ZUSATZ: sind nicht genug Stück lagernd - Fehlermeldung ausgeben
--set serveroutput on
delete from lieferung
where stueck < 0;

declare 
procedure Entnehmen(P_Artikelbezeichnung varchar, P_Anzahl int) is
cursor lla is select lie.stueck, l.lnr, lie.lfndnr
        from lager l
        join lieferung lie on l.lnr = lie.lnr
        join artikel ar on ar.anr = lie.anr
        where ar.bezeichnung = P_Artikelbezeichnung;  
v_anr int;
v_stueck int;
v_lnr int;
v_lfndnr int;
begin
  v_stueck := P_Anzahl ; --P_Anzahl = zu entnehmende Anzahl
  for ele1 in lla loop
    if ele1.stueck <= v_stueck and v_stueck > 0 then
    -- wenn die momentane lieferungen mehr stueck als die gesuchte stueckzahl hat
    -- und wenn die gesuchte Anzahl groesser 0 ist (um die lieferungen, die unter 0
    -- gehen, auszuschliessen)
      delete from lieferung where lnr = ele1.lnr and lfndnr = ele1.lfndnr;
      -- die noch abzuziehende menge um die anzahl, die in
      -- der momentanen lieferung enthalten ist, verringern
      v_stueck := v_stueck - ele1.stueck; 
    else
      -- differenz zwischen menge in der lieferungen und der gesuchten menge
      -- berechnen und dann die lieferungen updaten und den neuen wert als stueckzahl
      -- einfuegen.
      -- danach wird die gesuchte stueckzahl mit 0 gleichgesetzt, um nicht nochmal
      -- in die schleife zu kommen (damit nicht alle lieferungen aktualisiert werden)
      v_stueck := ele1.stueck - v_stueck;
      update lieferung set stueck = v_stueck where lnr = ele1.lnr and lfndnr = ele1.lfndnr;
      v_stueck := 0;
    end if;
  end loop;
  if v_stueck > 0 then 
    dbms_output.put_line('Nicht genug Stueck lagernd.');
  end if;
end Entnehmen;
begin
  Entnehmen('Apfel', 7);
end;
/

select * from lager;
select * from lieferung;

-- Lager 5c mit exceptions
-- Erstelle eine stored Function die zu einer Artikelnummer und einen Stichtag den Preis ermittelt
-- CREATE OR REPLACE
-- FUNCTION getpreis (p_anr int, p_datum date) ....
--update preise set Gueltig_Bis='2015-12-31' where ANr = 1 and Gueltig_Bis = '2014-01-31' and Gueltig_Ab = '2014-01-01';
set serveroutput on

create or replace function getpreis(p_anr int, p_datum date) return number AS
pr number;
too_high exception;
begin
  select preis into pr from preise where ANr = p_anr and (p_datum >= nvl(Gueltig_Ab, sysdate) and p_datum <= nvl(Gueltig_Bis, p_datum));
  if pr >= 90 then
    raise too_high;
    return pr;
  end if;
  
  exception
    when too_high then
      DBMS_OUTPUT.put_line('Mehr als 90');
      pr := 90;
    when too_many_rows then
      DBMS_OUTPUT.put_line('Mehr als eine Reihe');
      raise_application_error(-20000, 'das war meine');
end getpreis;
/

delete from preise where preis > 90;
select * from preise;
SELECT getpreis(1, sysdate) from dual; -- sollte den Wert 3 liefern
select getpreis(1, '2014-03-01') from dual;
select getpreis(0, sysdate) from dual;
select getpreis(1, '2015-01-01') from dual; -- ruft too_many_rows exception hervor
select getpreis(1, '2017-02-01') from dual;
SELECT anr, bezeichnung, getpreis(anr, sysdate) from artikel; 
SELECT anr, bezeichnung, getpreis(anr, '2014-03-01') from artikel;


-- Lager 5 mit Exception, die geworfen wird, wenn
-- die Anzahl der Stk. in der Lieferung nicht unterzubringen ist
set serveroutput on

-- Lager 5 Procedure Anlieferung Daten oraSQL mySQL
-- erstelle eine Procedure Anlieferung mit den Parametern (P_Artikelbzeichnung VARCHAR, P_Datum date, P_Stueck INT)
-- Die Procedure muß für die richtige Artikelnummer,
-- Lagerstellen mit verfügbaren Platz suchen und die entsprechende Stückanzahl in alle nötigen Lagerplätze verbuchen.
-- Die Belegung eines Lagers ist durch Summieren von Lieferung zu ermitteln.
-- Bsp.: Es sind 160 Äpfel einzulagern. Dazu sind 5 Lager mit 50 Plätzen vorhanden. Im Lager 1 sind bereits 20 Plätze belegt.
--set serveroutput on

-- mit exception, die geworfen wird, wenn nicht alle gelagert werden koennen
declare

procedure Anlieferung(P_Artikelbezeichnung varchar, P_Datum date, P_Stueck INT) as
gesamtlagerstand int;
nCount int;
liefNr int;
artNr int;
cursor getLager is select lnr, stueckkap from lager;
cursor getLieferung (l number) is select lfndnr, stueck from lieferung where lnr = l;
cursor getArtikelNr (bezeichn varchar) is select anr from Artikel where Bezeichnung = bezeichn;

some_left exception;

begin
  nCount := P_Stueck;
  open getArtikelNr(P_Artikelbezeichnung);
  fetch getArtikelNr into artNr;
  close getArtikelNr;
  for l in getLager loop
    gesamtlagerstand := 0;
    liefNr := 0;
    for lie in getLieferung(l.lnr) loop
      gesamtlagerstand := gesamtlagerstand + lie.stueck;
      liefNr := lie.lfndnr;
    end loop;
    if gesamtlagerstand < l.stueckkap then
      if gesamtlagerstand >= 0 then
        if nCount > (l.stueckkap-gesamtlagerstand) then
          insert into Lieferung(LNR, LFNDNR, DATUM,STUECK, ANR) values(l.lnr, (liefNr+1), P_Datum, (l.stueckkap-gesamtlagerstand), artNr);
          nCount :=  nCount - (l.stueckkap-gesamtlagerstand);
        else
          insert into Lieferung(LNR, LFNDNR, DATUM,STUECK, ANR) values(l.lnr, (liefNr+1), P_Datum, nCount, artNr);
          nCount :=  0;
        end if;
      else
        insert into Lieferung(LNR, LFNDNR, DATUM,STUECK, ANR) values(l.lnr, (liefNr+1), P_Datum, l.stueckkap, artNr);
        nCount := nCount - l.stueckkap;
      end if;
    end if;
  end loop;
  if ncount > 0 then
    raise some_left;
  end if;
  
  exception
    when some_left then
      raise_application_error(-20000, 'Es konnten nicht alle gelagert werden.');
      
end Anlieferung;

begin
    Anlieferung('Apfel', sysdate, 5000);
end;
/

/* Trigger Beispiel vom 23.2.2016 in trigger.sql*/


/* Trigger Beispiel vom 26.2.2016 in trigger.sql
 *  Um ein Table abzuaendern: 
 *  alter table <name> add <feldname> <datentyp>
 *  alter table <name> modify/change <feldname>
 *  alter table <name> drop/delete <feldname>
 */
 
-- lager 10
-- Ein Lager mit vorgebener ID soll aufgelöst werden.
-- All seine darin enthaltenen Artikel sind anderen Lagerstellen zuzuordnen.
declare
procedure Lager_Del(lid int) as
lagerId int;
begin
  lagerId := lid;
  for lie in (select * from lieferung where lnr = lid) loop
    
  end loop;
end Lager_Del;

begin
  Lager_Del(12);
end;
/

delete from artikel where anr = 33;