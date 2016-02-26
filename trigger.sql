set serveroutput on

create or replace trigger preise_demo
before insert on preise
-- oder AFTER INSERT ON PREISE
for each row -- damit der trigger fuer jeden datensatz feuert
declare
v_gueltig_ab date;
begin
  dbms_output.put_line('EINGEFUEGT:'||:new.anr||' '||:new.preis);
  
  IF INSERTING THEN
    DBMS_OUTPUT.PUT_LINE('Es ist ein INSERT passiert');
  ELSIF UPDATING THEN
    DBMS_OUTPUT.PUT_LINE('Es ist ein UPDATE passiert');
  ELSIF DELETING THEN
    DBMS_OUTPUT.PUT_LINE('Es ist ein DELETE passiert');
  END IF;   
  
  -- nach ueberlappungen suchen
  -- 1. schritt select statement das solche intervalle sucht
  -- 2. schritt wenn etwas gefunden wird --> raise
  
end;
/

create or replace trigger preise_ins
before insert on preise
-- oder AFTER INSERT ON PREISE
for each row -- damit der trigger fuer jeden datensatz feuert
declare
v_gueltig_ab date;
begin
  dbms_output.put_line('Eingefuegt ' || :new.anr || ' ' || :new.preis);
end;
/

-- wozu das ganze?
-- fuer komplexe pruefungen die ueber mehrere datensaetze gehen
-- pflegen von redundanzen
-- logging --> mitschreiben von aenderungen in der datenbank - am besten
--             in einer "zweiten" tabelle
alter session set nls_date_format='RRRR.MM.DD';
insert into Preise (ANR, GUELTIG_AB, GUELTIG_BIS, PREIS) VALUES (1, '2010-01-01', '2010-01-31', 1.5);


set serveroutput on

  -- nach ueberlappungen suchen
  -- 1. schritt select statement das solche intervalle sucht
  -- 2. schritt wenn etwas gefunden wird --> raise
create or replace trigger preise_demo
before insert on preise
-- oder AFTER INSERT ON PREISE
for each row -- damit der trigger fuer jeden datensatz feuert
declare
v_gueltig_ab date;
begin
  for ele in (select * from preise where anr = :new.anr) loop
    if (:new.gueltig_ab between ele.gueltig_ab and ele.gueltig_bis or
       :new.gueltig_bis between ele.gueltig_ab and ele.gueltig_bis) 
       or
       (ele.gueltig_ab between :new.gueltig_ab and :new.gueltig_bis or
       ele.gueltig_bis between :new.gueltig_ab and :new.gueltig_bis)
       or
       (ele.gueltig_bis is null and :new.gueltig_bis > ele.gueltig_ab)
       or
       (ele.gueltig_bis is null and :new.gueltig_bis is null)
       then
       raise_application_error(-20000, 'UEBERLAPPUNG');
    end if;
  end loop;
end;
/

select * from preise;
insert into Preise (ANR, GUELTIG_AB, GUELTIG_BIS, PREIS) VALUES (1, '2014-01-03','2013-02-02',91); 
insert into Preise(ANR, GUELTIG_AB, GUELTIG_BIS, PREIS) VALUES(1, '2013-10-01', '2014-01-31', 91);

-- test
delete from preise;


/* Trigger Beispiel vom 26.2.2016 in trigger.sql
 *  Um ein Table abzuaendern: 
 *  alter table <name> add <feldname> <datentyp>
 *  alter table <name> modify/change <feldname>
 *  alter table <name> drop/delete <feldname>
 */
 -- trigger, der den aktuellen Lagerstand immer aktualisiert in das Lager eintraegt
set serveroutput on

alter table lager add aktueller_lagerstand int;

create or replace trigger neue_lieferung
before insert or update or delete on lieferung
for each row
declare
begin
  if inserting then
    update lager set aktueller_lagerstand=nvl(aktueller_lagerstand, 0)+:new.stueck
    where lnr = :new.lnr;
  elsif updating then
    dbms_output.put_line(:new.stueck);
    update lager set aktueller_lagerstand=nvl(aktueller_lagerstand, 0)-:old.stueck+:new.stueck
    where lnr = :new.lnr;
  elsif deleting then
    dbms_output.put_line(:old.stueck);
    if :old.stueck > 0 then
    update lager set aktueller_lagerstand=nvl(aktueller_lagerstand, 0)-:old.stueck
    where lnr = :old.lnr;
    elsif :old.stueck < 0 then
    update lager set aktueller_lagerstand=nvl(aktueller_lagerstand, 0)+:old.stueck
    where lnr = :old.lnr;
    end if;
  end if;
end;
/
 
select lnr, aktueller_lagerstand from lager;
Insert into LIEFERUNG ( LNR, LFNDNR, DATUM,STUECK, ANR) values (11,6,'2014-03-06', 10, 1);
delete from lieferung where lfndnr = 4 and lnr = 11;
delete from lieferung where lfndnr = 6 and lnr = 11;
update lieferung set stueck=-25 where lfndnr = 3 and lnr = 11;
update lieferung set stueck=-2 where lfndnr = 2 and lnr = 12;
update lieferung set stueck=-5 where lfndnr = 6 and lnr = 11;
