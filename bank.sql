declare
ran int;
procedure Book as
begin
  for i in 1..100000 loop
    ran := dbms_random.value(1,2);
    /*if ran = 1 then
      umbuchenab(round(dbms_random.value(1,30)), 5, round(dbms_random.value(-100,100)));
    else
      umbuchenbc(round(dbms_random.value(1,30)), 5, round(dbms_random.value(-100,100)));
    end if;*/
    umbuchenab(1, (round(dbms_random.value(1,30))), 100);
  end loop;
end Book;
begin
  for i in 1..10000 loop
    Book;
  end loop;
end;
/

select * from bank_a;
select * from bank_b;
select * from bank_c;
update bank_a set kontostand=100;