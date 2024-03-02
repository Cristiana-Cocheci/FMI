1. Folosind subcereri, s? se afi?eze numele ?i data angaj?rii pentru salaria?ii care au fost
angaja?i dup? Gates.

SELECT last_name, hire_date
FROM employees
WHERE hire_date > (SELECT hire_date
                   FROM employees
                   WHERE INITCAP(last_name)='Gates'
                  );


2. Folosind subcereri, scrie?i o cerere pentru a afi?a numele ?i salariul pentru to?i colegii (din
acela?i departament) lui Gates. Se va exclude Gates.

SELECT last_name, salary
FROM employees
WHERE upper(last_name)!= 'GATES'
      and department_id= (SELECT department_id
                          FROM employees
                          WHERE UPPER(last_name)='GATES'
                          );
                          
                          
--Se poate înlocui operatorul IN cu = ???                        
--echivalent cu
SELECT last_name, salary
FROM employees
WHERE upper(last_name)!= 'GATES'
      and department_id IN (SELECT department_id
                          FROM employees
                          WHERE UPPER(last_name)='GATES'
                          );
                          
                          

--Se va inlocui Gates cu King-- aici nu se poate cu = deoarece sunt mai multi angajati KING
SELECT last_name, salary
FROM employees
WHERE upper(last_name)!= 'KING'
      and department_id IN (SELECT department_id
                          FROM employees
                          WHERE UPPER(last_name)='KING'
                          );



3. Folosind subcereri, s? se afi?eze numele ?i salariul angaja?ilor condu?i direct de
pre?edintele companiei (acesta este considerat angajatul care nu are manager).
Cererea trebuie sa returneze 14 angajati, dupa cum urmeaza:

SELECT * from employees;

SELECT last_name, salary
FROM employees
WHERE manager_id = (SELECT employee_id
                    FROM employees
                    WHERE manager_id is NULL);



4. Scrie?i o cerere pentru a afi?a numele, codul departamentului ?i salariul angaja?ilor al
c?ror cod de departament ?i salariu coincid cu codul departamentului ?i salariul unui angajat
care câ?tig? comision.
SELECT last_name, department_id, salary
FROM employees
WHERE (department_id, salary) IN (SELECT department_id, salary
 FROM employees
 WHERE commission_pct is not null);

5. S? se afi?eze codul, numele ?i salariul tuturor angaja?ilor al c?ror salariu este mai mare
decât salariul mediu.
SELECT employee_id, last_name, salary
FROM employees
WHERE salary > (SELECT AVG(salary)
 FROM employees);
 
 6. Scrieti o cerere pentru a afi?a angaja?ii care câ?tig? (castiga = salariul plus commission
din salariu) mai mult decât oricare func?ionar (job-ul con?ine ?irul “CLERK”). Sorta?i rezultatele
dupa salariu, în ordine descresc?toare.


SELECT * FROM employees
WHERE salary+salary* NVL(commission_pct,0) > ALL (
                                                SELECT salary+salary* NVL(commission_pct,0)
                                                FROM employees
                                                WHERE UPPER (job_id) LIKE '%CLERK%'
                                            );
                                            
                                            
                                            
SELECT * FROM employees
WHERE salary+salary* NVL(commission_pct,0) > MAX (
                                                SELECT salary+salary* NVL(commission_pct,0)
                                                FROM employees
                                                WHERE UPPER (job_id) LIKE '%CLERK%'
                                            );


> ALL -> mai mare decat toate valorile => mai mare decat maximul
> ANY -> mai mare decat toate valorile => mai mare decat minimul


7. Scrie?i o cerere pentru a afi?a numele angajatilor, numele departamentului ?i salariul
angaja?ilor care câ?tig? comision, dar al c?ror ?ef direct nu câ?tig? comision.
Cererea trebuie sa returneze 5 angajati, dupa cum urmeaza:

SELECT e.last_name, d.department_name, salary
FROM employees e JOIN departments d ON (e.department_id=d.department_id)
WHERE e.commission_pct is not null
      AND 
      e.manager_id IN (
                        SELECT employee_id
                        FROM employees
                        WHERE commission_pct IS null
                      );
  
8. S? se afi?eze numele angaja?ilor, codul departamentului ?i codul job-ului salaria?ilor
al c?ror departament se afl? în Toronto.
Cererea trebuie sa returneze 2 angajati, dupa cum urmeaza:

SELECT last_name, department_id, job_id
FROM employees
WHERE department_id IN (
                        SELECT department_id
                        FROM departments
                        WHERE location_id IN (
                                                SELECT location_id
                                                FROM locations
                                                WHERE upper(city)='TORONTO' 
                                             )
                        );


9. S? se ob?in? codurile departamentelor în care nu lucreaza nimeni (nu este introdus
niciun salariat în tabelul employees). Sa se utilizeze subcereri. De ce este nevoie de
utilizarea func?iei NVL? 

--operatori pe multimi 
SELECT department_id
FROM departments --din lista tuturor departamentelor din baza de date

MINUS --eliminam

SELECT department_id
FROM employees; --departamente care au angajati

--=> obtinem exact departamentele fara angajati


--subcerere utilizand not in

SELECT department_id
FROM departments 
WHERE department_id IN (
                            SELECT department_id
                            FROM employees
                            );

--
--!!! not in cand compara cu null 
--

SELECT department_id
FROM departments 
WHERE department_id NOT IN (
                            SELECT department_id --  sau nvl(department_id,-1)
                            FROM employees
                            WHERE department_id is not null
                            );


11. S? se creeze tabelul SUBALTERNI_PNU care s? con?in? codul, numele ?i prenumele
angaja?ilor care îl au manager pe Steven King, al?turi de codul ?i numele lui King.
Coloanele se vor numi cod, nume, prenume, cod_manager, nume_manager.

CREATE TABLE SUBALTERNI_CCO
    (
        cod number(6) constrain pkey_sub primary key,
        nume varchar(25) constraint nume_sub not null,
        prenume varchar(25),
        cod_manager number(6),
        nume_manager varchar(25) constraint nume_man not null
    );

INSERT INTO SUBALTERNI (cod, nume, prenume, cod_manager, nume_manager)
    (
        SELECT ang.employees_id, ang.last_name
        FROM employees ang join employees man on (ang.manager_id= man.employee_id)
        WHERE ang.manager_id = (
                                select employee_id
                                from employees
                                where lower(first_name||last_name)='stevenking'
                                );
    );



SELECT e.last_name, d.department_name, salary
FROM employees e JOIN departments d ON (e.department_id=d.department_id)
WHERE e.commission_pct is not null
      AND 
      e.manager_id IN (
                        SELECT employee_id
                        FROM employees
                        WHERE commission_pct IS null
                      );
