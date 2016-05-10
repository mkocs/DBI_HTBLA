set serveroutput on

-- exception abfangen (hier werden mehrere rows auf einmal
-- geladen, was fuer eine exception too_many_rows sorgt
declare
v1 int;

begin
  begin
    select preis
    into v1
    from preise;
  
    exception
      when too_many_rows then
        v1 := 0;
  end;
  
  DBMS_OUTPUT.put_line('v1: ' || v1);
  
end;
/


-- eigene exception einbauen
declare
v1 int;
meine_exception exception;
meine_zweite exception;
PRAGMA EXCEPTION_INIt(meine_zweite, -20000); -- bindet fehlernummer -20000 an meine_zweite

begin
  begin
    raise meine_exception;
    
    select preis
    into v1
    from preise;
  
    exception
      when too_many_rows then
        v1 := 0;
      when meine_exception then
        DBMS_OUTPUT.put_line('jetzt ist meine passiert.');
        raise_application_error(-20000, 'das war meine');
  end;
  
  DBMS_OUTPUT.put_line('v1: ' || v1);
  exception 
    when meine_zweite then
      DBMS_OUTPUT.put_line('das war die zweite, aber abgefangen');
  
end;
/