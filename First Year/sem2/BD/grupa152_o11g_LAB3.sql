-- LABORATOR 1 CONTNUARE --
15. S? se afi?eze numele ?i job-ul pentru to?i angaja?ii care nu au manager.

SELECT last_name, job_id, manager_id
FROM employees
WHERE manager_id IS NULL;




16. S? se afi?eze numele, salariul ?i comisionul pentru toti salaria?ii care câ?tig? comision.
S? se sorteze datele în ordine descresc?toare a salariilor ?i comisioanelor.

SELECT last_name, salary, commission_pct
FROM employees
WHERE commission_pct IS NOT NULL
ORDER BY salary desc, commission_pct desc;


-- plasarea valorilor null (sunt considerate cele mai mari)
SELECT last_name, salary, commission_pct
FROM employees
-- WHERE commission_pct IS NOT NULL
ORDER BY commission_pct desc;








-- LABORATOR 2 --

SELECT TO_CHAR(SYSDATE,'DD/MON/YEAR')
FROM DUAL;

SELECT TO_CHAR (TO_DATE('22/FEB/2023'), 'DD/MON/YYYY')
FROM DUAL;

SELECT TO_NUMBER ('-25.789', 99.999) 
FROM DUAL;

SELECT RTRIM ('infoXXX','X')
FROM DUAL;

SELECT RTRIM ('infoXXXx','X')
FROM DUAL;

SELECT RTRIM ('infoABC','CAB')
FROM DUAL;

SELECT TRANSLATE('$a$aaa','$a','bc')
FROM DUAL;

--- TEACA---
SELECT 08-03-2023 +3
FROM DUAL;


SELECT TO_DATE('08-MAR-2023', 'DD-MM-YYYY')+3
FROM DUAL;

NVL(EXPR1, EXPR2) -- TIPURILE SUNT COMPATIBILE SAU SUNT CONVERTITE LA EXPRESIE 1

SELECT NVL (1,'a')
FROM DUAL;

SELECT NVL (TO_CHAR(1),'a')
FROM DUAL;

--- EXERCITII ---

2. Scrie?i o cerere prin care s? se afi?eze prenumele salariatului cu prima litera majuscul?
?i toate celelalte litere minuscule, numele acestuia cu majuscule ?i lungimea
numelui, pentru angaja?ii al c?ror nume începe cu J sau M sau care au a treia liter? din
nume A. Rezultatul va fi ordonat descresc?tor dup? lungimea numelui. Se vor eticheta
coloanele corespunz?tor. Se cer 2 solu?ii (cu operatorul LIKE ?i func?ia SUBSTR).

-- LIKE
SELECT INITCAP(first_name) "Prenume", UPPER(last_name) "Nume", length(last_name) "Lungime nume"
FROM employees;
WHERE UPPER(last_name) LIKE 'J%'
    OR UPPER(last_name) LIKE 'M%'
    OR UPPER(last_name) LIKE '__A%' --cate careactere au a treia litera A
ORDER BY "Lungime nume" desc;



4

SELECT EMPLOYEE_ID, LAST_NAME, LENGTH(LAST_NAME)
FROM EMPLOYEES;
WHERE SUBSTR(LOWER(LAST_NAME),-1)='e';


-- Laborator 2--

5.S? se afi?eze detalii despre salaria?ii care au lucrat un num?r întreg de s?pt?mâni pân?
la data curent?. 

SELECT *
FROM employees
WHERE mod(round(sysdate -hire_date),7)=0;

6.S? se afi?eze codul salariatului, numele, salariul, salariul m?rit cu 15%, exprimat cu
dou? zecimale ?i num?rul de sute al salariului nou rotunjit la 2 zecimale. Eticheta?i
ultimele dou? coloane “Salariu nou”, respectiv “Numar sute”. Se vor lua în considerare
salaria?ii al c?ror salariu nu este divizibil cu 1000. 


SELECT employee_id, last_name, salary,
 round(salary + 0.15 * salary, 2) "Salariu Nou",
 round((salary + 0.15 * salary) / 100, 2) "Numar sute"
FROM employees
WHERE MOD(salary, 1000) != 0;


13.. S? se afi?eze numele angaja?ilor ?i comisionul. Dac? un angajat nu câ?tig? comision, s?
se scrie “Fara comision”. Eticheta?i coloana “Comision”.

NVL(Expr1,Expr2)-- DACA EXPRESIE 1 ESTE NULL< RETURNEAZA EXPR2, altfel returneaza expresie 1
        -- tipurile celor doua expresii trebuie sa fie compatibile
        --sau expr2 sa se converteasca implicit la expr1
        --in caz contrar facemm o conbersie explicita

SELECT last_name, NVL(commission_pct,"FARA COMISION") "Comision"
FROM employees; ---eroare deoarece expresiile nu au acelasi tip

SELECT last_name, NVL(TO_CHAR(commission_pct),'FARA COMISION') "Comision"
FROM employees;


SELECT last_name,decode(commission_pct, NULL, 'Fara comision', commission_pct) "comunism"
FROM employees;

14.
SELECT last_name,salary, commission_pct
FROM employees
WHERE salary + salary * commission_pct >10000; --DAAAAAR comisionul poate fi si null!!!

--OPERATIILE MATEMATICE CU NULL SUNT EGALE CU NULL

SELECT last_name,salary, commission_pct,
        salary + salary * NVL(commission_pct,0) "Venit lunar"
FROM employees
WHERE salary + salary * NVL(commission_pct,0) >10000;

SELECT last_name,salary, commission_pct,
        salary + salary * NVL(commission_pct,0) "Venit lunar"
FROM employees
WHERE NVL(salary + salary * commission_pct,SALARY) >10000
ORDER BY commission_pct NULLS FIRST;


--join

SELECt employee_id,last_name, department_name
FROM employees,departments; --produs cartezian


--JOIN IN FROM -- folosind ON /// USING(merge doar cand numele coincid)
SELECt employee_id,last_name, department_name, d.department_id
FROM employees e JOIN departments d ON (e.department_id=d.department_id);

SELECT employee_id, last_name, department_name, d.department_id
FROM employees e, departments d
WHERE e.department_id=d.department_id;

--SUNT NUMAI 106/107 angajati, deoarece are null pe coloana department id din employees

SE POT AFISA SI ANGAJATII CARE NU AU DEPARTAMENT
EXISTA SIMBOLUL (+) CARE SE PLASEAZA IN PARTEA DEFICITARA DE INFO
--

--VREM SA AFISAM ANGAJATII FARA DEPARTAMENT
SELECT employee_id, last_name, department_name, d.department_id
FROM employees e, departments d
WHERE e.department_id=d.department_id(+);


17.
SELECT job_title,e.job_id, department_id, employee_id
FROM jobs j, employees e
WHERE department_id=30 and j.job_id= e.job_id;


tema !! 18,19,20

























