/*1.*/
select * from projekte;

/*2b projekte in London im detail*/
select * from projekte where stadt='London';

/*2d Lieferungen mit einer Menge im Bereich von 300 bis 750 */
select * from projektlieferungen where menge between 300 and 750;

/*2g Projektnummer und Staedte mit einem o als zweiten Buchstaben des Stadtnames*/
select pnr, stadt from projekte where stadt like '_o%';
select pnr, stadt from projekte where substr(stadt, 2 /*position*/, 1 /*anzahl der zeichen*/) = 'o';

/*3a Liste aller Staedte aus denen zumindest ein Lieferant, ein Teil oder ein Projekt ist*/
select stadt from lieferanten union all /*Listen vereinigen*/ select stadt from teile union all select stadt from projekte;

/*union vereinigt tabellen; unionall vereinigt sie, ohne mehrfach vorhandene ergebnisse zu entfernen*/

/*nenne alle Lieferanten, die mehr als 20% rabatt geben*/
select lname from lieferanten where rabatt > 20;

/*4a  Namen der Projekte, die vom Lieferanten L1 beliefert werden*/
/*join um 2 tabellen zusammenzukleben*/
select pname from projekte join projektlieferungen on projekte.pnr = projektlieferungen.pnr where projektlieferungen.lnr = 'L1';
/*verkuerzte form mit alias*/
select pname from projekte p join projektlieferungen pl on p.pnr = pl.pnr where pl.lnr = 'L1';

/*4b  Farben der Teile, die vom Lieferanten L1 geliefert wurden*/
select farbe from teile t join projektlieferungen pl on t.tnr = pl.tnr where pl.lnr = 'L1';
select * from teile t join projektlieferungen pl on t.tnr = pl.tnr where pl.lnr = 'L1';
select distinct farbe from teile t join projektlieferungen pl on t.tnr = pl.tnr where pl.lnr = 'L1';

/*gebe jene Lieferanten aus, die teile aus ihrem standort (stadt) geliefert haben*/
select lname from lieferanten l join projektlieferungen pl on l.lnr = pl.lnr join teile t on pl.tnr = t.tnr where t.stadt = l.stadt;
select distinct lname from lieferanten l join projektlieferungen pl on l.lnr = pl.lnr join teile t on pl.tnr = t.tnr where t.stadt = l.stadt;

/*so umbauen, dass es ohne distinct funktioniert (mit subquery) (vom 08.01.2015)*/
/*schluesselwort IN wird verwendet, um in einer liste zu suchen*/
/*die liste besteht in dem fall aus dem subquery*/
select lname from lieferanten where lnr in
(select l.lnr from lieferanten l 
join projektlieferungen pl on l.lnr = pl.lnr 
join teile t on pl.tnr = t.tnr where t.stadt = l.stadt);


/*liste mit allen lieferantennamen, projektnamen und teilnamen die irgendwo hin geliefert wurden*/
select pname, lname, tname from projektlieferungen pl 
join teile t on pl.tnr = t.tnr 
join projekte p on p.pnr = pl.pnr 
join lieferanten l on pl.lnr = l.lnr
where t.stadt is not null;

select distinct pname, lname, tname from projektlieferungen pl 
join teile t on pl.tnr = t.tnr 
join projekte p on p.pnr = pl.pnr 
join lieferanten l on pl.lnr = l.lnr
where t.stadt is not null;

/*hasta luego selecto * no yes por favor;*/

/*subquery --> query innerhalb des query*/
select lnr, rabatt from lieferanten where rabatt < (select rabatt from lieferanten where lnr = 'L1');

/*Nummer der Projekte, die nicht mit roten Teilen von Lieferanten aus Paris beliefert werden*/
/*related subquery --> steht in beziehung mit dem uebergeordneten subquery*/
select pnr 
from projekte p 
where not exists (select * 
from projektlieferungen pl join teile t on pl.tnr = t.tnr join lieferanten l on l.lnr = pl.lnr 
where t.farbe = 'rot' and l.stadt = 'Paris' and p.pnr = pl.pnr);

/*ueberpruefung, ob p2 ein rotes teil hat, das aus paris kommt*/
select pnr 
from projekte p 
where exists (select * 
from projektlieferungen pl join teile t on pl.tnr = t.tnr join lieferanten l on l.lnr = pl.lnr 
where t.farbe = 'rot' and l.stadt = 'Paris' and p.pnr = pl.pnr);

select pl.pnr
from projektlieferungen pl
join teile t on pl.tnr = t.tnr
join lieferanten l on l.lnr = pl.lnr
where t.farbe = 'rot'
and l.stadt = 'Paris';





