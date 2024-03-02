SET SERVEROUTPUT ON

CREATE TABLE emp_cco
AS SELECT * FROM employees;
/
DECLARE
TYPE tablou_indexat IS TABLE OF emp_cco%ROWTYPE
INDEX BY BINARY_INTEGER;
t tablou_indexat;
BEGIN
-- stergere din tabel si salvare in tablou
DELETE FROM emp_cco
WHERE ROWNUM <= 2
RETURNING employee_id, first_name, last_name, email, phone_number,
hire_date, job_id, salary, commission_pct, manager_id,
department_id
BULK COLLECT INTO t;
--afisare elemente tablou
DBMS_OUTPUT.PUT_LINE (t(1).employee_id ||' ' || t(1).last_name);
DBMS_OUTPUT.PUT_LINE (t(2).employee_id ||' ' || t(2).last_name);
--inserare cele 2 linii in tabel
INSERT INTO emp_cco VALUES t(1);
INSERT INTO emp_cco VALUES t(2);
END;
/
select * from emp_cco;
/
DECLARE
TYPE tablou_imbricat IS TABLE OF NUMBER;
t tablou_imbricat := tablou_imbricat();
BEGIN
-- punctul a
FOR i IN 1..10 LOOP
DBMS_OUTPUT.PUT_LINE(t.count);
DBMS_OUTPUT.PUT_LINE(t.first || ' '||t.last);
t.extend;
t(i):=i;
END LOOP;
DBMS_OUTPUT.PUT('Tabloul are ' || t.COUNT ||' elemente: ');
FOR i IN t.FIRST..t.LAST LOOP
DBMS_OUTPUT.PUT(t(i) || ' ');
END LOOP;
DBMS_OUTPUT.NEW_LINE;
-- punctul b
FOR i IN 1..10 LOOP
IF i mod 2 = 1 THEN t(i):=null;
END IF;
END LOOP;
DBMS_OUTPUT.PUT('Tabloul are ' || t.COUNT ||' elemente: ');
FOR i IN t.FIRST..t.LAST LOOP
DBMS_OUTPUT.PUT(nvl(t(i), 0) || ' ');
END LOOP;
DBMS_OUTPUT.NEW_LINE;
-- punctul c
t.DELETE(t.first);
t.DELETE(5,7);
t.DELETE(t.last);
DBMS_OUTPUT.PUT_LINE('Primul element are indicele ' || t.first ||
' si valoarea ' || nvl(t(t.first),0));
DBMS_OUTPUT.PUT_LINE('Ultimul element are indicele ' || t.last ||
' si valoarea ' || nvl(t(t.last),0));
DBMS_OUTPUT.PUT('Tabloul are ' || t.COUNT ||' elemente: ');
FOR i IN t.FIRST..t.LAST LOOP
IF t.EXISTS(i) THEN
DBMS_OUTPUT.PUT(nvl(t(i), 0)|| ' ');
END IF;
END LOOP;
DBMS_OUTPUT.NEW_LINE;
-- punctul d
t.delete;
DBMS_OUTPUT.PUT_LINE('Tabloul are ' || t.COUNT ||' elemente.');
END;
/
CREATE OR REPLACE TYPE subordonati_cco AS VARRAY(10) OF NUMBER(4);
/
CREATE TABLE manageri_cco (cod_mgr NUMBER(10),
nume VARCHAR2(20),
lista subordonati_cco);
DECLARE
v_sub subordonati_cco:= subordonati_cco(100,200,300);
v_lista manageri_cco.lista%TYPE;
BEGIN
INSERT INTO manageri_cco
VALUES (1, 'Mgr 1', v_sub);
INSERT INTO manageri_cco
VALUES (2, 'Mgr 2', null);
INSERT INTO manageri_cco
VALUES (3, 'Mgr 3', subordonati_cco(400,500));
SELECT lista
INTO v_lista
FROM manageri_cco
WHERE cod_mgr=1;
FOR j IN v_lista.FIRST..v_lista.LAST loop
DBMS_OUTPUT.PUT_LINE (v_lista(j));
END LOOP;
END;
/
SELECT * FROM manageri_cco;
DROP TABLE manageri_cco;
DROP TYPE subordonati_cco;
/
Men?ine?i într-o colec?ie codurile celor mai prost pl?ti?i 5 angaja?i care nu câ?tig? comision. Folosind
aceast? colec?ie m?ri?i cu 5% salariul acestor angaja?i. Afi?a?i valoarea veche a salariului, respectiv valoarea
nou? a salariului.
/
SELECT * 
FROM (SELECT *
      FROM employees
      WHERE commission_pct is NULL
      ORDER BY salary)
WHERE ROWNUM <=5 ;
/
DECLARE
TYPE tablou_indexat IS TABLE OF employees%ROWTYPE
INDEX BY BINARY_INTEGER;
t tablou_indexat;
BEGIN
SELECT * 
BULK COLLECT INTO t
FROM (SELECT *
      FROM employees
      WHERE commission_pct is NULL
      ORDER BY salary)
WHERE ROWNUM <=5 ;
--afisare elemente tablou
FOR i in t.first..t.last LOOP
    DBMS_OUTPUT.PUT_LINE (t(i).employee_id ||' salariu vechi ' || t(i).salary);
    t(i).salary:= t(i).salary *1.05;
    DBMS_OUTPUT.PUT_LINE (t(i).employee_id ||' salariu nou ' || t(i).salary);
END LOOP;
END;
/
CREATE TABLE emp_cco LIKE employees;
INSERT INTO emp_cco SELECT * FROM employees;
/
DECLARE
TYPE emp_record IS RECORD
(
    employee_id employees.employee_id%TYPE,
    salary employees.salary%TYPE
);
TYPE tablou_indexat IS TABLE OF emp_record%ROWTYPE
INDEX BY BINARY_INTEGER;
t tablou_indexat;
BEGIN
SELECT * 
BULK COLLECT INTO t
FROM (SELECT employee_id, salary
      FROM employees
      WHERE commission_pct is NULL
      ORDER BY salary)
WHERE ROWNUM <=5 ;
--afisare elemente tablou
FOR i in t.first..t.last LOOP
    DBMS_OUTPUT.PUT_LINE (t(i).employee_id ||' salariu vechi ' || t(i).salary);
    t(i).salary:= t(i).salary *1.05;
    DBMS_OUTPUT.PUT_LINE (t(i).employee_id ||' salariu nou ' || t(i).salary);
END LOOP;
END;