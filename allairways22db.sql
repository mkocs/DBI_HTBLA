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


