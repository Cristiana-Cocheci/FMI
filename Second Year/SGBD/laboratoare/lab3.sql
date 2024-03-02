/*Crea?i tabelul zile_***(id, data, nume_zi). Introduce?i în tabelul zile_*** informa?iile
corespunz?toare tuturor zilelor care au r?mas din luna curent?.
LOOP
secven?a_de_comenzi
END LOOP;
Comanda se execut? cel pu?in o dat?.*/

SET SERVEROUTPUT ON

CREATE TABLE zile_cco (id NUMBER, data DATE, nume_zi VARCHAR(20));

DECLARE
contor NUMBER(6) := 1;
v_data DATE;
maxim NUMBER(2) := LAST_DAY(SYSDATE)-SYSDATE;
BEGIN
LOOP
v_data := sysdate+contor;
INSERT INTO zile_cco
VALUES (contor,v_data,to_char(v_data,'Day'));
contor := contor + 1;
EXIT WHEN contor > maxim;
END LOOP;
END;
/
select * from zile_cco;
/
SELECT * FROM rental;
/
CREATE table octombrie_cco(id NUMBER, data DATE);
/

DECLARE
n number(3);
i number(3);
no number(3);
BEGIN
i:=1;
SELECT count(*)
INTO (n)
FROM rental;
LOOP
    i:=i+1;
    SELECT book_date,sum(copy_id)
    --INTO no
    FRoM rental
    GROUP BY book_date;
    DBMS_OUTPUT.PUT_LINE(' ' || no);
    EXIT WHEN i>n;
END LOOP;
END;
/
DECLARE
v_cod employee/employee_id%TYPE;
v_cod_dep employee/department_id%TYPE;
BEGIN
SELECT employee_id
INTO v_cod
FROM EMPLOYEes
WHERE department_id=v_cod_dep;
DBMS_OUTPUT.PUT_LINE('In dep cu codul ' || v_cod_dep||' lucreaza '||v_cod);
EXCEPTION 
WHEN NO_DATA_FOUND THEN
    RAISE_APPLICATION_ERROR(-20000, 'Fara date');
WHEN toO_MANY_ROWS THEN
    RaisE_APPLICATIon_ERROR(-20000, 'Prea multe date');
END;
/
DECLARE 
v_nume member.last_name%TYPE:= UPPER('&p_nume');
rez NUMBER(3);
BEGIN
    SELECT c
    INTO rez
    FROM (select count(*) c , last_name
            from rental r join member m on (r.member_id=m.member_id)
            GROUP BY last_name
            HAVING UPPER(last_name)=UPPER(v_nume));
        
    DBMS_OUTPUT.PUT_LINE(rez);
EXCEPTION 
WHEN NO_DATA_FOUND THEN
    RAISE_APPLICATION_ERROR(-20000, 'Fara date');
WHEN toO_MANY_ROWS THEN
    RaisE_APPLICATIon_ERROR(-20000, 'Prea multe date');
END;
/
/
DECLARE 
v_nume member.last_name%TYPE:= UPPER('&p_nume');
rez NUMBER(3);
v_total NUMBER(3);
BEGIN
    SELECT count(*) INTO v_total
    FROM rental
    GROUP BY title_id;
    SELECT c
    INTO rez
    FROM (select count(*) c , last_name
            from rental r join member m on (r.member_id=m.member_id)
            GROUP BY last_name
            HAVING UPPER(last_name)=UPPER(v_nume));
        
    DBMS_OUTPUT.PUT_LINE(rez);
    CASE WHEN rez>0.75*v_total THEN DBMS_OUTPUT.PUT_LINE('A imprumutat mai mult de 75% din titlurile existente');
     WHEN rez>0.5*v_total THEN DBMS_OUTPUT.PUT_LINE('A imprumutat mai mult de 50% din titlurile existente');
     WHEN rez>0.25*v_total THEN DBMS_OUTPUT.PUT_LINE('A imprumutat mai mult de 25% din titlurile existente');
     ELSE DBMS_OUTPUT.PUT_LINE('altfel');
    END CASE;
EXCEPTION 
WHEN NO_DATA_FOUND THEN
    RAISE_APPLICATION_ERROR(-20000, 'Fara date');
WHEN toO_MANY_ROWS THEN
    RaisE_APPLICATIon_ERROR(-20000, 'Prea multe date');
END;
/
