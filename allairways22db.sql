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


-- zeige alle entfernungen, die zwischen 540 und 600 km liegen.
-- dabei sollen beide namen der beteiligten Flughaefen angezeigt werden
-- zeige die entfernung zwischen 2 Flugfaehfen nur 1 mal
select entfernung_km, nf.name, vf.name
from entfernung e 
join flughafen vf on e.von_hcode = vf.hcode
join flughafen nf on e.nach_hcode = nf.hcode
where entfernung_km between 540 and 600 and nf.hcode > vf.hcode;

commit;