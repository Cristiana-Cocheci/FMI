-- LABORATOR 4 - SAPTAMANA 7

--Daca nu ati fost prezenti in laboratorul anterior se ruleaza urmatoarele tranzactii

-- ATENTIE LA DENUMIREA FOLOSITA PENTRU CELE DOUA TABELE EMP SI DEPT

-- trebuie sa utilizati sirul (EMP_PNU/DEPT_PNU), unde pnu inseamna:
-- p - prima litera din prenume, iar nu - primele doua litere din nume

-- apoi se ruleaza cele doua comenzi

CREATE TABLE EMP_coco AS SELECT * FROM employees;
CREATE TABLE DEPT_coco AS SELECT * FROM departments;


 
-- IN CONTINUARE SE ADAUGA CONSTRANGERILE DE INTEGRITATE

ALTER TABLE emp_coco
ADD CONSTRAINT pk_emp_coco PRIMARY KEY(employee_id);

ALTER TABLE dept_coco
ADD CONSTRAINT pk_dept_coco PRIMARY KEY(department_id);

ALTER TABLE emp_coco
ADD CONSTRAINT fk_emp_dept_coco FOREIGN KEY(department_id) 
REFERENCES dept_coco(department_id);
   

ALTER TABLE emp_coco
ADD CONSTRAINT fk_emp_emp_coco FOREIGN KEY(manager_id) 
REFERENCES emp_coco(employee_id); -- managerul unui angajat

ALTER TABLE dept_coco
ADD CONSTRAINT fk_dept_emp_coco FOREIGN KEY(manager_id) 
REFERENCES emp_coco(employee_id); -- managerul de departament


-- APOI SE REZOLVA, IN CADRUL LABORATORULUI CURENT, URMATOARELE EXERCITII


5.	S? se insereze departamentul 300, cu numele Programare în DEPT_pnu.
Analiza?i cazurile, precizând care este solu?ia corect? ?i explicând erorile 
celorlalte variante. 
Pentru a anula efectul instruc?iunii(ilor) corecte, utiliza?i comanda ROLLBACK.
       
       
DESC DEPT_COCO;

SELECT * FROM dept_coco;

--discutie tipuri de INSERT si erori posibile
--vezi laborator
                                                      
--a)insert implicit--  trebuie sa i punem toate valorile din linie, daca nu avem, punem NULL
INSERT INTO DEPT_coco
VALUES (300, 'Programare');


--b)insert explicit
INSERT INTO DEPT_coco (department_id, department_name)
VALUES (300, 'Programare');

SELECT * FROM dept_pnu;



--c) ORDINEA CONTEAZA!!!
INSERT INTO DEPT_pnu (department_name, department_id)
VALUES (300, 'Programare');


--d)	
INSERT INTO DEPT_coco (department_id, department_name, location_id)
VALUES (301, 'Programare', null);	


-- varianta corecta
	
_____	

desc dept_coco;
SELECT * FROM dept_coco;


--e)	
INSERT INTO DEPT_coco (department_name, location_id)
VALUES ('Programare', null);


-- Ce se intampla daca executam rollback?

select * from dept_coco;
rollback;


-- Executati varianta corecta si permanentizati modificarile.

INSERT INTO DEPT_coco (department_id, department_name)
VALUES (300, 'Programare');
commit;


6.	S? se insereze un angajat corespunz?tor departamentului introdus anterior 
în tabelul EMP_pnu, precizând valoarea NULL pentru coloanele a c?ror valoare 
nu este cunoscut? la inserare (metoda implicit? de inserare). 
Determina?i ca efectele instruc?iunii s? devin? permanente.
Aten?ie la constrângerile NOT NULL asupra coloanelor tabelului!


-- inserare prin metoda IMPLICITA de inserare
-- dorim sa inseram un angajat in depart 300

DESC emp_coco;
SELECT * FROM emp_coco;


INSERT INTO emp_coco
VALUES (250, NULL, 'nume250', 'email250', NULL, SYSDATE, 'IT_PROG', NULL, NULL, NULL, 300);

-- Cum parmanentizam efectul actiunii anterioare?

commit;

SELECT * FROM emp_coco;


-- De ce varianta urmatoare nu functioneaza?

INSERT INTO emp_coco
VALUES (251, NULL, 'nume251', 'email251', NULL, SYSDATE, 'IT_PROG', NULL, NULL, NULL, 300);


-- Anulati inserarea anterioara

rollback;

SELECT * FROM emp_coco;


-- De ce varianta urmatoare nu functioneaza?

INSERT INTO emp_coco
VALUES (251, NULL, 'nume251', 'email251', NULL, to_date('03-10-2023','dd-mm-yyyy'), 
       'IT_PROG', NULL, NULL, NULL, 300);
       
SELECT * FROM emp_coco;

ROLLBACK;

-- De ce varianta urmatoare nu functioneaza?

INSERT INTO emp_coco
VALUES (252, NULL, 'nume252', 'email252', NULL, SYSDATE, 
       'IT_PROG', NULL, NULL, NULL, 300);


-- IN CELE DIN URMA PASTRAM IN BAZA DE DATE ANGAJATUL CU ID-UL 250 IN DEPART. 300


7.	S? se mai introduc? un angajat corespunz?tor departamentului 300, 
precizând dup? numele tabelului lista coloanelor în care se introduc valori 
(metoda explicita de inserare). 
Se presupune c? data angaj?rii acestuia este cea curent? (SYSDATE). 
Salva?i înregistrarea.

desc emp_coco;

--inserare prin metoda EXPLICITA de inserare
INSERT INTO emp_coco (hire_date, job_id, employee_id, last_name, email, department_id)
VALUES (sysdate, 'sa_man', 278, 'nume_278', 'email_278', 300);

COMMIT;

SELECT * FROM emp_coco;


8.	Crea?i un nou tabel, numit EMP1_PNU, care va avea aceea?i structur? ca ?i EMPLOYEES, 
dar fara inregistrari. Copia?i în tabelul EMP1_PNU salaria?ii (din tabelul EMPLOYEES) 
al c?ror comision dep??e?te 25% din salariu (se accepta omiterea constrangerilor).


-- crearea tabelului
CREATE TABLE emp1_coco AS SELECT * FROM employees;

-- eliminarea inregistrarilor
DELETE FROM emp1_coco;

-- adaugarea noilor valori (inserarea randurilor)
INSERT INTO emp1_coco
    SELECT *
    FROM employees
    WHERE commission_pct > 0.25;

SELECT * FROM emp1_coco;


-- Ce se intampla daca executam un rollback? 

rollback;




-- SA SE ANALIZEZE EXERCITIILE 9, 10 SI 11 

9.	S? se creeze un fi?ier (script file) care s? permit? introducerea de înregistr?ri 
în tabelul EMP_PNU în mod interactiv. 
Se vor cere utilizatorului: codul, numele, prenumele si salariul angajatului. 
Câmpul email se va completa automat prin concatenarea primei litere din prenume 
?i a primelor 7 litere din nume.    
Executati script-ul pentru a introduce 2 inregistrari in tabel.


INSERT INTO emp_pnu (employee_id, first_name, last_name, email, hire_date, job_id, salary)
VALUES(&cod, '&&prenume', '&&nume', substr('&prenume',1,1) || substr('&nume',1,7), 
       sysdate, 'it_prog', &sal);
       
UNDEFINE prenume;
UNDEFINE nume;

SELECT * FROM emp_pnu;


10.	Crea?i 2 tabele emp2_pnu ?i emp3_pnu cu aceea?i structur? ca tabelul EMPLOYEES, 
dar f?r? înregistr?ri (accept?m omiterea constrângerilor de integritate). 
Prin intermediul unei singure comenzi, copia?i din tabelul EMPLOYEES:

-  în tabelul EMP1_PNU salaria?ii care au salariul mai mic decât 5000;
-  în tabelul EMP2_PNU salaria?ii care au salariul cuprins între 5000 ?i 10000;
-  în tabelul EMP3_PNU salaria?ii care au salariul mai mare decât 10000.

Verifica?i rezultatele, apoi ?terge?i toate înregistr?rile din aceste tabele.

--VEZI INSERARI MULTI-TABEL IN LABORATORUL 4

CREATE TABLE emp1_pnu AS SELECT * FROM employees;

DELETE FROM emp1_pnu;

SELECT * FROM emp1_pnu; 

CREATE TABLE emp2_pnu AS SELECT * FROM employees;

DELETE FROM emp2_pnu;

CREATE TABLE emp3_pnu AS SELECT * FROM employees;

DELETE FROM emp3_pnu;

INSERT ALL
   WHEN salary < 5000 THEN
      INTO emp1_pnu					
   WHEN salary > = 5000 AND salary <= 10000 THEN
      INTO emp2_pnu
   ELSE 
      INTO emp3_pnu
SELECT * FROM employees;  


SELECT * FROM emp1_pnu;
SELECT * FROM emp2_pnu;
SELECT * FROM emp3_pnu;



11.	S? se creeze tabelul EMP0_PNU cu aceea?i structur? ca tabelul EMPLOYEES 
(f?r? constrângeri), dar f?r? inregistrari. 
Copia?i din tabelul EMPLOYEES:

-  în tabelul EMP0_PNU salaria?ii care lucreaz? în departamentul 80;
-  în tabelul EMP1_PNU salaria?ii care au salariul mai mic decât 5000;
-  în tabelul EMP2_PNU salaria?ii care au salariul cuprins între 5000 ?i 10000;
-  în tabelul EMP3_PNU salaria?ii care au salariul mai mare decât 10000.

Dac? un salariat se încadreaz? în tabelul emp0_pnu atunci acesta nu va mai fi inserat 
?i în alt tabel (tabelul corespunz?tor salariului s?u);

CREATE TABLE emp0_pnu AS SELECT * FROM employees;

DELETE FROM emp0_pnu;


INSERT FIRST
    WHEN department_id = 80 THEN
        INTO emp0_pnu
    WHEN salary < 5000 THEN
        INTO emp1_pnu
    WHEN salary > = 5000 AND salary <= 10000 THEN
        INTO emp2_pnu
    ELSE 
        INTO emp3_pnu
SELECT * FROM employees;

SELECT * FROM emp0_pnu;
SELECT * FROM emp1_pnu;
SELECT * FROM emp2_pnu;
SELECT * FROM emp3_pnu;


-- COMANDA UPDATE - VEZI LABORATOR (pentru notiunile teoretice)

12.	M?ri?i salariul tuturor angaja?ilor din tabelul EMP_PNU cu 5%. 
Vizualizati, iar apoi anula?i modific?rile.

UPDATE emp_pnu
SET salary = salary * 1.05;

SELECT * FROM emp_pnu;

ROLLBACK;



13.	Schimba?i jobul tuturor salaria?ilor din departamentul 80 care au comision, în 'SA_REP'. 
Anula?i modific?rile.

UPDATE emp_pnu
SET job_id = 'SA_REP'
WHERE department_id = 80 and commission_pct IS NOT NULL;

SELECT * FROM emp_pnu;

ROLLBACK;


14.	S? se promoveze Douglas Grant la manager în departamentul 20 (tabelul dept_pnu), 
având o cre?tere de salariu cu 1000$. 


-- verificari

SELECT *
FROM emp_pnu
WHERE lower(last_name||first_name) = 'grantdouglas';

SELECT * FROM dept_pnu
WHERE department_id = 20;

-- solutia problemei

___





-- COMANDA DELETE - VEZI LABORATOR (pentru notiunile teoretice)

15.	?terge?i toate înregistr?rile din tabelul DEPT_PNU. 
Ce înregistr?ri se pot ?terge? Anula?i modific?rile. 

DELETE FROM dept_pnu; 

SELECT * FROM dept_pnu;

SELECT * FROM emp_pnu;


16.	Suprima?i departamentele care nu au angajati. Anula?i modific?rile.

-- prima data afisam departamentele care nu au angajati


-- apoi stergem departamentele care nu au angajati



17. S? se mai introduc? o linie in tabelul DEPT_PNU.

desc dept_pnu;

INSERT INTO dept_pnu
VALUES(320, 'dept_nou', NULL, NULL);

SELECT * FROM dept_pnu;


18. S? se marcheze un punct intermediar in procesarea tranzac?iei (SAVEPOINT p).

SAVEPOINT p;


19. S? se ?tearg? din tabelul DEPT_PNU departamentele care au codul de departament 
cuprins intre 160 si 200. Lista?i con?inutul tabelului.

DELETE FROM dept_pnu
WHERE department_id BETWEEN 160 AND 200; 

SELECT * FROM dept_pnu;


20. S? se renun?e la cea mai recent? opera?ie de ?tergere, f?r? a renun?a 
la opera?ia precedent? de introducere. 
Determina?i ca modific?rile s? devin? permanente;

SELECT * FROM dept_pnu;

ROLLBACK TO p;

COMMIT;



