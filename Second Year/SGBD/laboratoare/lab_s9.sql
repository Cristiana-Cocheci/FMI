
CREATE OR REPLACE PROCEDURE inserare_cco (v_nume employees.last_name%TYPE, v_nr info_cco.nr_linii%type,v_str STRING) IS
v_user info_cco.utilizator%type;

BEGIN
    SELECT USER
    INTO v_user
    FROM dual;

     INSERT INTO info_cco 
     VALUES(info_seq_cco.NEXTVAL, v_user, SYSDATE,'salariu pt. angajat cu numele '||v_nume, v_nr, v_str);
END inserare_cco;

/

CREATE OR REPLACE PROCEDURE
p4_cco(v_nume IN employees.last_name%TYPE DEFAULT 'Bell', salariu OUT employees.salary%type) IS

v_user info_spr.utilizator%type;
v_nr info_spr.nr_linii%type;
v_str info_spr.eroare%type;

BEGIN
    SELECT USER
    INTO v_user
    FROM dual;
    SELECT COUNT(*)
    INTO v_nr
    FROM employees
    WHERE last_name = v_nume;


    SELECT salary INTO salariu
    FROM employees
    WHERE last_name = v_nume;
    inserare_cco(v_nume, v_nr, 'ok');
    EXCEPTION
    WHEN NO_DATA_FOUND THEN
        v_str:=SQLCODE||SUBSTR(SQLERRM,1,30);
        inserare_cco(v_nume, v_nr, v_str);
    
    WHEN too_many_rows THEN
    v_str:='Exista mai multi angajati cu numele dat';
    inserare_cco(v_nume, v_nr, v_str);
    WHEN others then
    v_str:='other';
    inserare_cco(v_nume, v_nr, v_str);
END p4_cco;
/
-- metode apelare
-- 1. Bloc PLSQL
DECLARE
v_salariu employees.salary%type;
BEGIN
p4_cco('Bell',v_salariu);
DBMS_OUTPUT.PUT_LINE('Salariul este '|| v_salariu);
END;
/
-- 2. SQL*PLUS
VARIABLE v_sal NUMBER
EXECUTE p4_cco ('Bell',:v_sal)
PRINT v_sal;
/
select* from info_cco;
commit;
/
CREATE OR REPLACE FUNCTION cnt_ang_cco
  (v_oras locations.city%TYPE DEFAULT 'Seattle')
RETURN NUMBER IS
numar NUMBER;
exista_oras NUMBER;
v_user info_spr.utilizator%type;
  BEGIN
  exista_oras:=0;
  SELECT count(*) into exista_oras
  from locations
  where city= v_oras
  group by city;

  WITH angajati AS(
  Select employee_id 
  FROM(
    SELECT e.employee_id, COUNT(*) AS c
        FROM employees e
        JOIN departments d ON e.department_id = d.department_id
        JOIN locations l ON d.location_id = l.location_id
        JOIN job_history jh ON e.employee_id = jh.employee_id
        GROUP BY e.employee_id)
    WHERE c > 1
    MINUS
    SELECT e.employee_id
        FROM employees e
        JOIN departments d ON e.department_id = d.department_id
        JOIN locations l ON d.location_id = l.location_id
    WHERE city=v_oras)
    SELECT count(*) INTO numar
    FROM angajati;

    SELECT USER
    INTO v_user
    FROM dual;
    INSERT INTO info_cco 
     VALUES(info_seq_cco.NEXTVAL, v_user, SYSDATE,'nr de angajati din orasul '||v_oras, 1, 'am gasit '||numar);

    EXCEPTION
    WHEN NO_DATA_FOUND THEN
        numar:=0;
        INSERT INTO info_cco 
         VALUES(info_seq_cco.NEXTVAL, v_user, SYSDATE,'nr de angajati din orasul '||v_oras, 1, 'nu exista orasul');
 
        IF exista_oras!= 0 THEN
            INSERT INTO info_cco 
         VALUES(info_seq_cco.NEXTVAL, v_user, SYSDATE,'nr de angajati din orasul '||v_oras, 1, 'niciun angajat corespunzator gasit');
        
        
            END IF;
    RETURN numar;
END cnt_ang_cco;
/
DECLARE 
  nr NUMBER;
  v_oras locations.city%TYPE;
BEGIN
    v_oras:='Roma';
  nr := cnt_ang_cco(v_oras);
  DBMS_OUTPUT.PUT_LINE('Nr angajati ceruti in '||v_oras||' este: ' || nr);
END;

/
select city from locations;
select * from job_history;
select * from departments;
select * from info_cco;