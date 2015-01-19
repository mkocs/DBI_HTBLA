create table MITARBEITER(
  MA_ID integer not null PRIMARY KEY,
  NAME varchar(22) not null,
  GEHALT integer not null
);

create table WERKZEUG(
  W_ID integer not null PRIMARY KEY,
  EK_PREIS integer not null,
  BUCHWERT integer not null,
  KATEGORIE varchar(2) not null,
  MA_ID integer null references MITARBEITER
);

/*schreibe ein sql statement, das den buchwert aller werkzeuge auf 0 setzt, wenn der BUCHWERT weniger als 10% vom EK_PREIS ist*/
update werkzeug set buchwert = 0 where BUCHWERT < EK_PREIS*0.1;

/*schreibe ein sql statement, das zu jeder werkzeug-KATEGORIE die summe der EK_PREIS ausgibt.*/
select sum(ek_preis), kategorie from werkzeug group by kategorie;

/*schreibe ein sql statement, das zu jedem mitarbeiter NAME von allen seinen werkzeugen KATEGORIE und EK_PREIS*/
select kategorie, ek_preis, NAME from werkzeug w join mitarbeiter m on w.ma_id = m.ma_id;

/*schreibe ein sql statement, das den BUCHWERT aller werkzeuge der art 'E' und 'K' auf 1 setzt*/
update werkzeug set buchwert = 1 where art = 'K' or art = 'E';
update werkzeug set buchwert = 1 where art in('K', 'E');