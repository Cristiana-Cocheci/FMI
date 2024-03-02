SET SERVEROUTPUT ON

BEGIN
DBMS_OUTPUT.PUT('aaaaa');
DBMS_OUTPUT.NEW_LINE;
END;
/
/*
DECLARE 
v_nr NUMBER:=&p_nr;
v_cod_job employees.job_id%TYPE;
BEGIN

SELECT job_id
INTO v_cod_job
FROM employees
WHERE employee_id = v_nr;
DBMS_OUTPUT.PUT_LINE('ANGAJATUL CU CODUL ' ||v_nr|| ' ARE COD JOB ' ||v_cod_job);

EXCEPTION
    WHEN NO_DATA_FOUND THEN DBMS_OUTPUT.PUT_LINE('NU EXISTA ANGAJAT CU CODUL DAT');

END;
*/


DECLARE 
v_nume employees.last_name%TYPE:=UPPER(&p_nume);
v_cod_job employees.job_id%TYPE;
BEGIN

SELECT job_id
INTO v_cod_job
FROM employees
WHERE last_name = v_nume;
DBMS_OUTPUT.PUT_LINE('ANGAJATUL CU NUMELE ' ||v_nume|| ' ARE COD JOB ' ||v_cod_job);

EXCEPTION
    WHEN NO_DATA_FOUND THEN DBMS_OUTPUT.PUT_LINE('NU EXISTA ANGAJAT CU CODUL DAT');
    --WHEN TOO_MANY_ROWS THEN RAISE_APPLICATION_ERROR(-20001,'EXISTA ANGAJATI MULTI CU CODUL DAT');
END;
/

<<eticheta>>
DECLARE
variabila1 NUMBER:=1;
BEGIN
    <<eticheta2>>
    DECLARE
    variabila2 NUMBER:=2;
    BEGIN
    eticheta.variabila1:=variabila1+variabila2;
    END;
    --nu merge ce e mai jos
    --eticheta2.variabila2:=5;
END;

/
SET VERIFY OFF

DEFINE p_cod=103
BEGIN
DBMS_OUTPUT.put_line(&&p_cod);
END;
/
UNDEFINE p_cod;
/
VARIABLE g_mesaj VARCHAR2(100)
BEGIN
:g_mesaj:='Test';
DBMS_OUTPUT.PUT_LINE(:g_mesaj);
END;
Print g_mesaj;
/

VARIABLE rezultat VARCHAR2(35)
DECLARE
angajati NUMBER;
BEGIN
SELECT department_name
INTO :rezultat
FROM employees e, departments d
WHERE e.department_id=d.department_id
GROUP BY department_name
HAVING COUNT(*) = (SELECT MAX(COUNT(*))
FROM employees
GROUP BY department_id);

SELECT count(*) 
INTO :angajati
FROM employees e, departments d
WHERE e.department_id=d.department_id
GROUP BY department_name
HAVING COUNT(*) = (SELECT MAX(COUNT(*))
FROM employees
GROUP BY department_id);


DBMS_OUTPUT.PUT_LINE('Departamentul '|| :rezultat ||' are '|| :angajati ||'angajati');
END;
/
PRINT rezultat
/
SET VERIFY OFF
DECLARE
v_cod employees.employee_id%TYPE:=&p_cod;
v_bonus NUMBER(8);
v_salariu_anual NUMBER(8);
BEGIN
    SELECT salary*12 INTO v_salariu_anual
    FROM employees
    WHERE employee_id = v_cod;
    IF v_salariu_anual>=200001
    THEN v_bonus:=20000;
    ELSIF v_salariu_anual BETWEEN 100001 AND 200000
    THEN v_bonus:=10000;
    ELSE v_bonus:=5000;
    END IF;
DBMS_OUTPUT.PUT_LINE('Bonusul este ' || v_bonus);
END;
/
SET VERIFY ON
/
--se citeste un cod de departament de la tastatura 
--in cazul in care numarul de angajati este mai mic decat 5 sa se afiseze departament mic
--intre 5 si 20 departament mediu
-->20 departament mare
/

DECLARE
v_cod_dep NUMBER := &p_cod_dep;
rezultat NUMBER;

BEGIN
SELECT count(*)
INTO :rezultat
FROM employees e
WHERE e.department_id=v_cod_dep;

IF rezultat<5 THEN DBMS_OUTPUT.PUT_LINE('DEPARTAMENT MIC');
ELSIF rezultat<20 THEN DBMS_OUTPUT.PUT_LINE('DEPARTAMENT MEDIU');
ELSE DBMS_OUTPUT.PUT_LINE('DEPARTAMENT MARE');
END IF;

END;
/
PRINT rezultat
/
select * from departments;
