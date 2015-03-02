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

