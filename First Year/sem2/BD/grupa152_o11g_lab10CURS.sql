1. S? se creeze o vizualizare VIZ_EMP30_PNU, care con?ine codul, numele, email-ul si salariul
angaja?ilor din departamentul 30. S? se analizeze structura ?i con?inutul vizualiz?rii. 
Ce se observ? referitor la constrângeri? Ce se ob?ine de fapt la interogarea con?inutului vizualiz?rii?
Insera?i o linie prin intermediul acestei vizualiz?ri; comenta?i.


SELECT * FROM EMP_COCO;

CREATE OR REPLACE VIEW VIZ_EMP30_COCO AS
 (SELECT employee_id, last_name, email, salary
 FROM emp_pnu
 WHERE department_id = 30
 );

DESC VIZ_EMP30_COCO;
SELECT * FROM VIZ_EMP30_COCO;
INSERT INTO VIZ_EMP30_COCO
 VALUES(559,'last_name','eemail',10000);
DROP VIEW VIZ_EMP30_PNU;




2. Modifica?i VIZ_EMP30_PNU astfel încât s? fie posibil? inserarea/modificarea con?inutului
tabelului de baz? prin intermediul ei. Insera?i ?i actualiza?i o linie (cu valoarea 601 pentru codul
angajatului) prin intermediul acestei vizualiz?ri.
Obs: Trebuie introduse neap?rat în vizualizare coloanele care au constrângerea NOT NULL în
tabelul de baz? (altfel, chiar dac? tipul vizualiz?rii permite opera?ii LMD, acestea nu vor fi posibile
din cauza nerespect?rii constrângerilor NOT NULL).
CREATE OR REPLACE VIEW VIZ_EMP30_coco AS
 (SELECT employee_id, last_name, email, salary, hire_date, job_id, department_id
 FROM emp_coco
 WHERE department_id = 30
 );
DESC VIZ_EMP30_COCO;
SELECT * FROM VIZ_EMP30_COCO;
SELECT * FROM EMP_COCO;
INSERT INTO VIZ_EMP30_COCO
 VALUES(601, 'last_name', 'eemail', 10000, SYSDATE, 'IT_PROG', 30);
SELECT * FROM VIZ_EMP30_COCO;
SELECT * FROM EMP_COCO;


Unde a fost introdus? linia? Mai apare ea la interogarea vizualiz?rii?
Ce efect are urm?toarea opera?ie de actualizare?


UPDATE viz_emp30_coco
SET hire_date=hire_date-15
WHERE employee_id=601;

?terge?i angajatul având codul 601 prin intermediul vizualiz?rii. Analiza?i efectul asupra tabelului de
baz?.

DELETE FROM viz_emp30_coco
WHERE employee_id = 601;
COMMIT;

3. S? se creeze o vizualizare, VIZ_EMPSAL50_PNU, care contine coloanele cod_angajat, nume,
email, functie, data_angajare si sal_anual corespunz?toare angaja?ilor din departamentul 50.
Analiza?i structura ?i con?inutul vizualiz?rii.

CREATE OR REPLACE VIEW VIZ_EMPSAL50_coco AS
 SELECT employee_id, last_name, email, job_id, hire_date, salary*12 sal_anual
 FROM emp_coco
 WHERE department_id = 50;

DESC VIZ_EMPSAL50_coco;
SELECT * FROM VIZ_EMPSAL50_coco;

4. a) Insera?i o linie prin intermediul vizualiz?rii precedente. Comenta?i.
INSERT INTO VIZ_EMPSAL50_PNU(employee_id, last_name, email, job_id, hire_date)
 VALUES(567, 'last_name', 'email000', 'IT_PROG', sysdate);
b) Care sunt coloanele actualizabile ale acestei vizualiz?ri? Verifica?i r?spunsul în dic?ionarul datelor
(USER_UPDATABLE_COLUMNS).
c) Analiza?i con?inutul vizualiz?rii viz_empsal50_pnu ?i al tabelului emp_pnu.
5. a) S? se creeze vizualizarea VIZ_EMP_DEP30_PNU, astfel încât aceasta s? includ? coloanele
vizualiz?rii VIZ_EMP30_PNU, precum ?i numele ?i codul departamentului. S? se introduc?
aliasuri pentru coloanele vizualiz?rii.
! Asigura?i-v? c? exist? constrângerea de cheie extern? între tabelele de baz? ale acestei
vizualiz?ri.;


CREATE OR REPLACE VIEW VIZ_EMP_DEP30_coco AS
SELECT v.*,d.department_name
FROM VIZ_EMP30_PNU v JOIN departments d ON(d.department_id = v.department_id);

b) Insera?i o linie prin intermediul acestei vizualiz?ri.

INSERT INTO VIZ_EMP_DEP30_coco
 (employee_id,last_name,email,salary,job_id,hire_date,department_id)
 VALUES (358, 'lname', 'email', 15000, 'IT_PROG', sysdate, 30);
SELECT * FROM VIZ_EMP_DEP30_coco;
SELECT * FROM VIZ_EMP30_coco;

c) Care sunt coloanele actualizabile ale acestei vizualiz?ri? Ce fel de tabel este cel ale c?rui
coloane sunt actualizabile?
d) Ce efect are o opera?ie de ?tergere prin intermediul vizualiz?rii viz_emp_dep30_pnu? Comenta?i.

DELETE FROM VIZ_EMP_DEP30_coco WHERE employee_id = 358;
6. S? se creeze vizualizarea VIZ_DEPT_SUM_PNU, care con?ine codul departamentului ?i pentru
fiecare departament salariul minim, maxim si media salariilor. Ce fel de vizualizare se ob?ine
(complexa sau simpla)? Se poate actualiza vreo coloan? prin intermediul acestei vizualiz?ri?;
CREATE OR REPLACE VIEW VIZ_DEPT_SUM_coco AS
 (SELECT department_id, MIN(salary) min_sal, MAX(salary) max_sal,AVG(salary) med_sal
 FROM employees RIGHT JOIN departments USING (department_id)
 GROUP BY department_id);
SELECT * FROM VIZ_DEPT_SUM_coco;
7. Modifica?i vizualizarea VIZ_EMP30_PNU astfel încât s? nu permit? modificarea sau inserarea
de linii ce nu sunt accesibile ei. Vizualizarea va selecta ?i coloana department_id. Da?i un nume
constrângerii ?i reg?si?i-o în vizualizarea USER_CONSTRAINTS din dic?ionarul datelor.
Încerca?i s? modifica?i ?i s? insera?i linii ce nu îndeplinesc condi?ia department_id = 30.
CREATE OR REPLACE VIEW VIZ_EMP30_PNU AS
 (SELECT employee_id, last_name, email, salary, hire_date, job_id, department_id
 FROM emp_pnu
 WHERE department_id = 30)
WITH READ ONLY CONSTRAINT verific;
INSERT INTO VIZ_EMP30_PNU
 VALUES(600, 'last_name', 'eemail', 10000, SYSDATE, 'IT_PROG', 50);