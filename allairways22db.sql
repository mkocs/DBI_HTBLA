desc flugplan

select count(*) from flugplan;

select * from entfernung;

select distinct von_hcode, nach_hcode, 0 from flugplan where (von_hcode = 'BKK' or nach_hcode = 'BKK') and von_hcode > nach_hcode;

insert into entfernung (von_hcode, nach_hcode, entfernung_km)
(
  select distinct von_hcode, nach_hcode, 0 from flugplan where von_hcode > nach_hcode
);

select * from entfernung where nach_hcode = 'BKK';

update entfernung set entfernung_km = 8461 where nach_hcode = 'BKK' and von_hcode = 'VIE';

-- entfernungen mit der eigenen katalognummer * (21 * 0/1/2/3) updaten
-- entfernungen von http://www.airmilescalculator.com/
update entfernung set entfernung_km = 655 where (von_hcode = 'VIE' and nach_hcode = 'MXP') or (von_hcode = 'MXP' and nach_hcode = 'VIE');
update entfernung set entfernung_km = 876 where (von_hcode = 'VIE' and nach_hcode = 'NCE') or (von_hcode = 'NCE' and nach_hcode = 'VIE');
update entfernung set entfernung_km = 551 where (von_hcode = 'VIE' and nach_hcode = 'WAW') or (von_hcode = 'WAW' and nach_hcode = 'VIE');
update entfernung set entfernung_km = 150 where (von_hcode = 'GRZ' and nach_hcode = 'DUS') or (von_hcode = 'DUS' and nach_hcode = 'GRZ');
--commit;

-- zeige alle entfernungen, die zwischen 540 und 600 km liegen.
-- dabei sollen beide namen der beteiligten Flughaefen angezeigt werden
-- zeige die entfernung zwischen 2 Flugfaehfen nur 1 mal
select entfernung_km, nf.name, vf.name
from entfernung e 
join flughafen vf on e.von_hcode = vf.hcode
join flughafen nf on e.nach_hcode = nf.hcode
where entfernung_km between 540 and 600 and nf.hcode > vf.hcode
order by 1;

select * from flughafen where stadt like 'Wien%';
select * from flughafen where stadt like 'London%';

-- zeig alle Verbindungen im Flugplan von Wien nach London
--
-- mit join
select p.* from flugplan p 
join flughafen f1 on nach_hcode = f1.hcode
join flughafen f2 on von_hcode = f2.hcode
where lower(f2.stadt) like 'wien%' 
and lower(f1.stadt) like 'london%' and lower(f1.land) = 'großbritannien';

-- mit subselect
select * from flugplan
where nach_hcode in (select hcode
                    from flughafen where lower(stadt) = 'london'
                    and lower(land) = 'großbritannien')
and von_hcode = 'VIE';


-- zeige alle entfernungen an, wo die andere Richtung nicht die gleiche entfernung_km hat (Datenfehler zB)
select e1.* from entfernung e1
join entfernung e2 on e1.von_hcode = e2.nach_hcode and e1.nach_hcode = e2.von_hcode
where e1.entfernung_km <> e2.entfernung_km;

-- zeige alle entfernungen zu den flugplaenen von wien nach frankfurt und von wien nach muenchen
select distinct p.*, e.entfernung_km from flugplan p
join entfernung e on p.nach_hcode = e.nach_hcode and p.von_hcode = e.von_hcode
join flughafen f1 on p.nach_hcode = f1.hcode
join flughafen f2 on p.von_hcode = f2.hcode
where (lower(f2.stadt) like '%wien%')
and (lower(f1.stadt) like '%frankfurt%' or lower(f1.stadt) like '%münchen%');

select distinct p.*, e.entfernung_km from flugplan p
join entfernung e on p.nach_hcode = e.nach_hcode and p.von_hcode = e.von_hcode
join flughafen f1 on p.nach_hcode = f1.hcode
where (lower(p.von_hcode) like 'vie') 
and (lower(f1.stadt) like '%frankfurt%' or lower(f1.stadt) like '%münchen%');

--zeige alle entfernungen an, die nur in einer richtung angegeben sind
-- in anderen worten: gib alle entfernungen aus, zu denen keine in der anderen richtung existieren
select * from entfernung e
where not exists(select nach_hcode, von_hcode from entfernung e2 where e2.nach_hcode = e.von_hcode and e2.von_hcode = e.nach_hcode);

--------------------------------------------------------------------------------------------------------------------------------------
--
-- fuer welche flugzeugtypen sind die sitzplaetze konfiguriert?
select bezeichnung from flugzeugtyp ft
join sitz s on s.typid = ft.typid
group by ft.bezeichnung
having count(s.typid) > 0;

-- besser
select * from flugzeugtyp t
where exists(select * from sitz s where s.typid = t.typid);

-- schlecht, weil 1297 Datensaetze gefunden werden
-- und verarbeitet werden
select distinct t.* from flugzeugtyp t
join sitz s on t.typid = s.typid;

select distinct typid from sitz;

-- gib alle flugzeugtypen aus, fuer die mehr als 201 sitzplaetze konfiguriert sind
select t.typid, t.bezeichnung, count(*) from flugzeugtyp t
join sitz s on s.typid = t.typid
group by t.typid, t.bezeichnung
having count(*) > 201;

-- gib zu jedem flugzeughersteller die anzahl der verfuegbaren flugzeugtypen  an
-- zusatzaufgabe: nur jene, die mehr als 25 typen haben
select h.bezeichnung, count(t.typid) from flugzeugtyp t
join hersteller h on h.herstellerid = t.herstellerid
group by h.bezeichnung
order by count(t.typid) desc;

select h.bezeichnung, count(t.typid) from flugzeugtyp t
join hersteller h on h.herstellerid = t.herstellerid
group by h.bezeichnung
having count(t.typid) > 25
order by count(t.typid) desc;


select * from fluggesellschaft;
select * from flugplan;
select * from flugzeugtyp;


-- ausgehend vom flugplan, gib zu den fluggesellschaften OS und LH die Anzahl der Einsaetze der Flugzeugtypen an
-- in einem 2. Schritt beschraenke die Ausgabe auf mehr als 70 Einsaetze
-- Aufgabe: Kuerzel und Name der Fluggesellschaft, Typ und Bezeichnung des Flugzeugs, Anzahl der Einsaetze
-- Sortiere auch nach obigen Felder (sinnvoll)
select g.gcode, g.name, fp.typid, t.bezeichnung, count(fp.typid) from fluggesellschaft g
join flugplan fp on g.gcode = fp.gcode and g.gcode in('OS', 'LH')
join flugzeugtyp t on t.typid = fp.typid
group by g.gcode, g.name, fp.typid, t.bezeichnung
order by count(fp.typid) desc;

select g.gcode, g.name, fp.typid, t.bezeichnung, count(fp.typid) from fluggesellschaft g
join flugplan fp on g.gcode = fp.gcode and g.gcode in('OS', 'LH')
join flugzeugtyp t on t.typid = fp.typid
group by g.gcode, g.name, fp.typid, t.bezeichnung
having count(fp.typid) > 70
order by count(fp.typid) desc;


-- gib jene flugplaene aus wo die Reichweite des Flugzeugtyps
-- kleiner als die Entfernung der Flughaefen im Flugplan ist
-- bonus: gib die namen der flughaefen aus
select f.name as VON_NAME, f2.name as NACH_NAME, p.gcode, p.plannr, t.typid, t.bezeichnung from flugplan p
join flugzeugtyp t on p.typid = t.typid
join entfernung e on p.von_hcode = e.von_hcode and p.nach_hcode = e.nach_hcode
join flughafen f on f.hcode = p.von_hcode
join flughafen f2 on f2.hcode = p.nach_hcode
where t.reichweite_km < e.entfernung_km;


-- suche flugzeugtypen, die mehrere unterschiedliche Klassen in ihrer
-- sitzkonfiguration haben
select h.bezeichnung, t.typid, t.bezeichnung from flugzeugtyp t
join sitz s on t.typid = s.typid
join klasse k on s.kcode = k.kcode
join hersteller h on h.herstellerid = t.herstellerid
group by h.bezeichnung, t.typid, t.bezeichnung
having count(distinct k.kcode) > 1;

select h.bezeichnung, t.bezeichnung, count(*) as Anzahl_Sitze, count(distinct k.kcode) as Anzahl_Klassen, min(k.kcode), max(k.kcode) from sitz s
join klasse k on s.kcode = k.kcode
join flugzeugtyp t on s.typid = t.typid
join hersteller h on h.herstellerid = t.herstellerid
group by h.bezeichnung, t.bezeichnung
having count(distinct k.kcode) > 1
order by count(s.typid) desc;

select h.bezeichnung, t.bezeichnung, count(*) as Anzahl_Sitze, count(distinct k.kcode) as Anzahl_Klassen, min(k.kcode), max(k.kcode) from sitz s
join klasse k on s.kcode = k.kcode
join flugzeugtyp t on s.typid = t.typid
join hersteller h on h.herstellerid = t.herstellerid
group by h.bezeichnung, t.bezeichnung
having min(s.kcode) <> max(s.kcode);

-- zu obigen flugzeugtypen gib die kleinste und groesste Sitzreihe pro Klasse aus
-- Ausgabe: Bezeichnung des Flugzeugtyps, Bezeichnung der Klasse,
-- kleinste Sitzreihe, groesste Sitzreihe
select k.kcode, t.bezeichnung, k.bezeichnung, min(s.reihe), max(s.reihe) from sitz s
join flugzeugtyp t on t.typid = s.typid
join klasse k on k.kcode = s.kcode
where s.typid in (select s.typid from sitz s
                  group by s.typid
                  having min(s.kcode) <> max(s.kcode))
group by k.kcode, t.typid, t.bezeichnung, k.bezeichnung
order by t.bezeichnung, k.bezeichnung;

select k.kcode, t.bezeichnung, k.bezeichnung, min(s.reihe), max(s.reihe) from sitz s
join flugzeugtyp t on t.typid = s.typid
join klasse k on k.kcode = s.kcode
group by k.kcode, t.typid, t.bezeichnung, k.bezeichnung
having t.typid in (select s.typid from sitz s
                  group by s.typid
                  having min(s.kcode) <> max(s.kcode))
order by t.bezeichnung, k.bezeichnung;


-- gib pro flugzeugtyp die anzahl der sitzreihen und die anzahl der unterschiedlichen
-- sitzplaetze pro reihe (=Buchstabe) aus
-- zusatzaufgabe: zeige auch die Bezeichnung von Flugzeugtyp und hersteller
select h.bezeichnung, t.typid, t.bezeichnung, count(distinct s.reihe), count(distinct s.buchstabe), max(s.reihe) from flugzeugtyp t
join sitz s on t.typid = s.typid
join hersteller h on t.herstellerid = h.herstellerid
group by h.bezeichnung, t.typid, t.bezeichnung;


-- gib pro flugzeugtyp und sitzklasse die anzahl der sitzreihen und die anzahl der
-- unterschiedlichen Sitzplaetze pro reihe (=buchstabe) aus
-- Zusatzaufgabe: Zeige auch die Bezeichnung von Klasse, Hersteller und Flugzeugtyp an
select t.typid, k.kcode, k.bezeichnung, h.bezeichnung, t.bezeichnung, count(distinct s.reihe), count(distinct s.buchstabe) from flugzeugtyp t
join sitz s on t.typid = s.typid
join klasse k on k.kcode = s.kcode
join hersteller h on t.herstellerid = h.herstellerid
group by t.typid, k.kcode, k.bezeichnung, h.bezeichnung, t.bezeichnung
order by t.typid asc;

-- gib alle fluggesellschaften aus, zu denen flugzeuge existieren
-- AUSGABE: alle felder aus fluggesellschaft
--
-- ZUSATZAUFGABE: gib alle flugzeugtypen aus, zu denen flugzeuge existieren
-- AUSGABE: bezeichnung von hersteller und flugzeugtyp
select * from fluggesellschaft g
where exists(select 1 from flugzeug t where g.gcode = t.gcode);

--select distinct h.bezeichnung, t.bezeichnung from flugzeugtyp t
--join hersteller h on t.herstellerid = h.herstellerid
--join flugzeug f on f.typid = t.typid;

select h.bezeichnung, t.bezeichnung from flugzeugtyp t
join hersteller h on h.herstellerid = t.herstellerid
where exists(select 1 from flugzeug f where f.typid = t.typid);

-- gib zu den flugzeugtypen die anzahl der flugzeuge aus
-- sortiere absteigend
-- ergaenze um die bezeichnung des flugzeugtypes und den hersteller
select t.bezeichnung, h.bezeichnung, count(f.flugzeugnr) from flugzeugtyp t
join flugzeug f on f.typid = t.typid
join hersteller h on h.herstellerid = t.herstellerid
group by t.bezeichnung, h.bezeichnung
order by count(f.flugzeugnr) desc;

select f.typid, count(*) as anzahl, max(t.bezeichnung), min(t.bezeichnung) from flugzeug f
join flugzeugtyp t on t.typid = f.typid
join hersteller h on h.herstellerid = t.herstellerid
group by f.typid
order by anzahl desc;

-- wenn man nun auch die typen angezeigt bekommen will, von denen es keine Flugzeuge gibt, dann kann man eine basistabelle angeben
-- welche auch angezeigt wird, wenn die anderen nicht vorhanden sind

-- gibt nur 8 datensaetze aus
select f.typid, count(z.typid) as anzahl from flugzeugtyp f
join flugzeug z on z.typid = f.typid
group by f.typid
order by anzahl desc;

-- gibt alle aus. auch die, die null sind
select f.typid, count(z.typid) as anzahl from flugzeugtyp f
left outer join flugzeug z on z.typid = f.typid
group by f.typid
order by anzahl desc;

-- beispiel, warum das so ist
select * from flugzeugtyp f
left outer join flugzeug z on z.typid = f.typid;


-- erstelle eine liste aller flugzeugtypen des herstellers Airbus.
-- gib die anzahl der verwendeten flugzeuge an (0 wenn den Typ niemand verwendet)
select t.typid, t.bezeichnung, h.bezeichnung, count(p.typid) from flugzeugtyp t
join hersteller h on h.herstellerid = t.herstellerid
join flugplan p on p.typid = t.typid
where h.bezeichnung = 'Airbus'
group by t.typid, t.bezeichnung, h.bezeichnung
having count(p.typid) > 0;

-- loesung
select h.bezeichnung, t.bezeichnung, count(f.regnr) as ANZAHL_VERWENDUNGEN, count(*) as ANZAHL_DATENSAETZE from flugzeugtyp t
join hersteller h on h.herstellerid = t.herstellerid
left outer join flugzeug f on f.typid = t.typid -- durch das left outer join werden auch felder angezeigt, die 0/null sind
where h.bezeichnung = 'Airbus'
group by h.bezeichnung, t.bezeichnung
order by count(f.regnr) desc;

-- ohne left outer join
select h.bezeichnung, t.bezeichnung, count(f.regnr) as ANZAHL_VERWENDUNGEN from flugzeugtyp t
join hersteller h on h.herstellerid = t.herstellerid
join flugzeug f on f.typid = t.typid -- durch das left outer join werden auch felder angezeigt, die 0/null sind
where h.bezeichnung = 'Airbus'
group by h.bezeichnung, t.bezeichnung
union
select h.bezeichnung, t.bezeichnung, 0
from flugzeugtyp t
join hersteller h on h.herstellerid = t.herstellerid
where h.bezeichnung = 'Airbus'
and not exists (select * from flugzeug f where f.typid = t.typid);

-- gib zu jeder fluggesellschaft die anzahl ihrer flugzeuge aus.
-- gesellschaften ohne flugzeuge sollen mit 0 ausgegeben werden
-- sortiere so, dass die mit 0 am ende sind
-- ausgabe: name der gesellschaft und anzahl der flugzeuge

select g.name, count(f.regnr) from fluggesellschaft g
left outer join flugzeug f on g.gcode = f.gcode
group by g.name
order by count(f.regnr) desc;


-- gib zu jedem ticket mit ausstellungsdatum 1.2.2015 Boarding und Passagierdaten an
-- AUSGABE: GCode, PlanNR, TicketNR, Sitzreihe, Sitzbuchstabe, Startzeit des Fluges
-- ZUSATZ1: Code und Name des Zielflugshafens
-- ZUSATZ2: Ersetze fehlende String (null) mit N.N. und fehlene Zahlen durch -1

-- normal
select t.GCODE, t.PLANNR, t.TNR, s.REIHE, s.BUCHSTABE, f.STARTZEIT, p.PID, p.TITEL, p.ANREDE, p.NAME from TICKET t
left outer join BOARDINGCARD b on b.TNR = t.TNR
left outer join FLUG f on f.FID = b.FID
left outer join SITZ s on b.SITZID = s.SITZID
join PASSAGIER p on t.PID = p.PID
where t.AUSSTELLUNGSDATUM = '1.2.2015';

-- zusatz 1
select t.GCODE, t.PLANNR, t.TNR, s.REIHE, s.BUCHSTABE, f.STARTZEIT, fp.NACH_HCODE, p.PID, p.TITEL, p.ANREDE, p.NAME from TICKET t
left outer join BOARDINGCARD b on b.TNR = t.TNR
left outer join FLUG f on f.FID = b.FID
left outer join SITZ s on b.SITZID = s.SITZID
join PASSAGIER p on t.PID = p.PID
left outer join FLUGPLAN fp on fp.PLANNR = f.PLANNR and fp.GCODE = t.GCODE -- plannr und gcode zusammen sind schluessel
left outer join FLUGHAFEN fh on fh.HCODE = fp.NACH_HCODE
where t.AUSSTELLUNGSDATUM = '1.2.2015';

-- zusatz 2
select t.GCODE, t.PLANNR, t.TNR, COALESCE(s.REIHE, -1) as REIHE, COALESCE(s.BUCHSTABE, 'N.N.') as SITZ_BUCHSTABE, f.STARTZEIT, COALESCE(fp.NACH_HCODE, 'N.N.'), p.PID, COALESCE(p.TITEL, 'N.N.'), p.ANREDE, p.NAME from TICKET t
left outer join BOARDINGCARD b on b.TNR = t.TNR
left outer join FLUG f on f.FID = b.FID
left outer join SITZ s on b.SITZID = s.SITZID
join PASSAGIER p on t.PID = p.PID
left outer join FLUGPLAN fp on fp.PLANNR = f.PLANNR and fp.GCODE = t.GCODE
left outer join FLUGHAFEN fh on fh.HCODE = fp.NACH_HCODE
where t.AUSSTELLUNGSDATUM = '1.2.2015';

-- summiere entfernung * person mit boardingcard pro flugplan
-- AUSGABE: schluessel zu flugplan, summe personenkilometer (entfernung*personen)
select fp.gcode, fp.plannr, e.entfernung_km * count(p.pid) as PERSONENKILOMETER from boardingcard bc
join ticket t on bc.tnr = t.tnr
join passagier p on p.pid = t.pid
join flugplan fp on t.gcode = fp.gcode and t.plannr = fp.plannr
join entfernung e on e.von_hcode = fp.von_hcode and e.nach_hcode = fp.nach_hcode
group by fp.plannr, fp.gcode, e.entfernung_km;

select fp.gcode, fp.plannr, sum(e.entfernung_km) as personen_km
from boardingcard c
join ticket t on c.tnr = t.tnr
join flugplan fp on fp.plannr = t.plannr and fp.gcode = t.gcode
join entfernung e on fp.von_hcode = e.von_hcode and fp.nach_hcode = e.nach_hcode
group by fp.gcode, fp.plannr;

select fp.gcode, fp.plannr, sum(e.entfernung_km) from flugplan fp
join flug f on f.plannr = fp.plannr and f.gcode = fp.gcode
join boardingcard bc on f.fid = bc.fid
join entfernung e on e.nach_hcode = fp.nach_hcode and e.von_hcode = fp.von_hcode
group by fp.gcode, fp.plannr;



