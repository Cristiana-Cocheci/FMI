Tema laborator s4
Cocheci Cristiana 252

E6. Adapta?i cerin?ele exerci?iilor 5, 7 ?i 9 pentru diagrama proiectului prezentat? la materia Baze
de Date din anul I. Rezolva?i aceste exerci?ii în PL/SQL, folosind baza de date proprie.

4. Defini?i un bloc anonim în care s? se afle numele departamentului cu cei mai mul?i angaja?i.
Comenta?i cazul în care exist? cel pu?in dou? departamente cu num?r maxim de angaja?i.
/
SET SERVEROUTPUT ON
DECLARE
v_dep departments.department_name%TYPE;
BEGIN
SELECT department_name
INTO v_dep
FROM employees e, departments d
WHERE e.department_id=d.department_id
GROUP BY department_name
HAVING COUNT(*) = (SELECT MAX(COUNT(*))
FROM employees

GROUP BY department_id);
DBMS_OUTPUT.PUT_LINE('Departamentul '|| v_dep);
END;
/
5. Rezolva?i problema anterioar? utilizând variabile de leg?tur?. Afi?a?i rezultatul atât din bloc, cât
?i din exteriorul acestuia.
VARIABLE rezultat VARCHAR2(35)
BEGIN
SELECT department_name
INTO :rezultat
FROM employees e, departments d
WHERE e.department_id=d.department_id
GROUP BY department_name
HAVING COUNT(*) = (SELECT MAX(COUNT(*))
FROM employees

GROUP BY department_id);

DBMS_OUTPUT.PUT_LINE('Departamentul '|| :rezultat);
END;
/
PRINT rezultat
7. Determina?i salariul anual ?i bonusul pe care îl prime?te un salariat al c?rui cod este dat de la
tastatur?. Bonusul este determinat astfel: dac? salariul anual este cel pu?in 200001, atunci bonusul
este 20000; dac? salariul anual este cel pu?in 100001 ?i cel mult 200000, atunci bonusul este 10000,
iar dac? salariul anual este cel mult 100000, atunci bonusul este 5000. Afi?a?i bonusul ob?inut.
Comenta?i cazul în care nu exist? niciun angajat cu codul introdus.
Obs. Se folose?te instruc?iunea IF.
IF condi?ie1 THEN
secven?a_de_comenzi_1
[ELSIF condi?ie2 THEN
secven?a_de_comenzi_2]
...
[ELSE
secven?a_de_comenzi_n]
END IF;
SET VERIFY OFF
/
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
9. Scrie?i un bloc PL/SQL în care stoca?i prin variabile de substitu?ie un cod de angajat, un cod de
departament ?i procentul cu care se m?re?te salariul acestuia. S? se mute salariatul în noul
departament ?i s? i se creasc? salariul în mod corespunz?tor. Dac? modificarea s-a putut realiza
(exist? în tabelul emp_*** un salariat având codul respectiv) s? se afi?eze mesajul “Actualizare
realizata”, iar în caz contrar mesajul “Nu exista un angajat cu acest cod”. Anula?i modific?rile
realizate.
DEFINE p_cod_sal= 200
DEFINE p_cod_dept = 80
DEFINE p_procent =20
DECLARE
v_cod_sal emp_***.employee_id%TYPE:= &p_cod_sal;
v_cod_dept emp_***.department_id%TYPE:= &p_cod_dept;
v_procent NUMBER(8):=&p_procent;
BEGIN
UPDATE emp_***
SET department_id = v_cod_dept,
salary=salary + (salary* v_procent/100)
WHERE employee_id= v_cod_sal;
IF SQL%ROWCOUNT =0 THEN
DBMS_OUTPUT.PUT_LINE('Nu exista un angajat cu acest cod');
ELSE DBMS_OUTPUT.PUT_LINE('Actualizare realizata');
END IF;
END;
/
ROLLBACK;
