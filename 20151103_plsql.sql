--set serveroutput on

declare
a int;
b int;
begin

a := 17;
b := 20;

if a < b
then
  dbms_output.put_line('a ist kleiner');
else
  dbms_output.put_line('b ist kleiner');
end if;

end;
/

-- Uebung: berechne die Fibonaccizahlen von 1 bis 12 und gebe diese auf die Standardausgabe aus
declare
a int;
b int;
c int;
counter int;
begin
a := 0;
b := 1;
c := 0;
counter := 0;
for counter in 0 .. 11
loop
  c := a + b;
  a := b;
  b := c;
  dbms_output.put_line(c);
end loop;

a := 0;
b := 1;
c := 0;
while c < 12
loop
  c := a + b;
  a := b;
  b := c;
  dbms_output.put_line(c);
end loop;

end;
/


-- UEBUNG: fuege die fibonaccizahlen von 1 bis 150 in eine tabelle ein
-- die tabelle muss vorher erstellt werden
-- die tabelle soll die felder nr und wert besitzen
create table fibonacci (
  nr int,
  wert int
);
select * from fibonacci;
drop table fibonacci;

declare
a number;
b number;
c number;
fnum number;
begin
a := 0;
b := 1;
c := 0;
for counter in 1 .. 150
loop
  c := a + b;
  a := b;
  b := c;
  insert into fibonacci values(counter, c);
end loop;
end;
/

-- cursor in loop
declare 
fnr number;
cursor fib_nr is select wert from fibonacci;
begin
for f in fib_nr loop
  dbms_output.put_line(f.wert);
end loop;
close fib_nr;
end;
/

-- cursor fetch
declare 
cursor f1 (fnr number) is select nr, wert from fibonacci where nr = fnr;
frec f1%rowtype;
begin
open f1(10);
for counter in 1 .. 10
loop
  fetch f1 into frec;
  dbms_output.put_line(frec.nr || ' ' || frec.wert);
end loop;
end;
/

-- cursor in loop
declare 
begin
for fnr in (select nr, wert from fibonacci) loop
  dbms_output.put_line(fnr.nr || ' ' || fnr.wert);
end loop;
end;
/