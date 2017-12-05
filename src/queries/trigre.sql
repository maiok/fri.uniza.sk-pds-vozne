CREATE SEQUENCE zamestnanec_id_seq
  start with 1
  increment by 1;

CREATE TRIGGER zamestnanec_id_trigger
   before insert on "SYSTEM"."Zamestnanec"
   for each row
begin
   if inserting then
      if :NEW."id_zamestnanca" is null then
         select ZAMESTNANEC_ID_SEQ.nextval into :NEW."id_zamestnanca" from dual;
      end if;
   end if;
end;
