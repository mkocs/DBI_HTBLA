drop table baum;
drop table gattung;

create table gattung(
  kurzbez varchar(7) not null primary key,
  bezeichnung varchar(40) not null/*,
  vorkommen varchar(50)*/
);

create table baum(
  baum_nr int not null primary key,
  blattanzahl int null,
  gattung_kurzbez varchar(7) not null references gattung
);

insert into gattung values ('Apfel', 'Apfelbaum');
insert into gattung values ('Birne', 'Birnenbaum');
insert into gattung values ('Kastan', 'Kastanienbaum');
insert into gattung values ('Buch', 'Buche');

insert into baum (baum_nr, blattanzahl, gattung_kurzbez) values(10, 256, 'Apfel');
insert into baum (baum_nr, gattung_kurzbez) values(1, 'Birne');
insert into baum (baum_nr, blattanzahl, gattung_kurzbez) values(2, 222, 'Kastan');
insert into baum (baum_nr, blattanzahl, gattung_kurzbez) values(3, 375, 'Buch');

select * from gattung; /*gibt alle >>SPALTEN<< aus*/
select * from baum;
select baum_nr from baum where gattung_kurzbez = 'Apfel';

/*wenn man nicht weiss, ob apfel gross oder klein geschrieben ist*/
select baum_nr from baum where lower(gattung_kurzbez) = 'apfel';

select * from baum where gattung_kurzbez = 'Apfel' and blattanzahl > 100;

select count (gattung_kurzbez), gattung_kurzbez from baum group by gattung_kurzbez;

select max(blattanzahl), min(blattanzahl), sum(blattanzahl) from baum;

select baum_nr from baum where blattanzahl is not null;

update baum set blattanzahl = 2000 where gattung_kurzbez = 'Kastan';

select baum_nr as Baumnummer, blattanzahl as Blattanzahl, bezeichung as Bezeichnung from baum join gattung on baum.gattung_kurzbez = gattung.gattung_kurzbez;

select bezeichnung, count(gattung_kurzbez) as Baumanzahl from baum join gattung on baum.gattung_kurzbez = gattung.gattung_kurzbez group by bezeichnung order by bezeichnung desc;
