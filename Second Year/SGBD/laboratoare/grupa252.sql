desc departments;

select sysdate from dual;

'ex 9'
desc employees;
select first_name,last_name
from employees
where lower(first_name) like '___a%'
        or lower(last_name) like '___a%';
        
'ex 10'
select first_name, last_name
from employees
where (lower(first_name) like '%l%l%'
        or lower(last_name) like '%l%l%')
        and (department_id = 30
        or manager_id=102);
        
'ex 11'
desc jobs;
select first_name, last_name , job_title , salary
from employees e join jobs j on (e.job_id=j.job_id)
where (lower(job_title) like ('%clerk%') or lower(job_title) like ('%rep%'))
 and salary NOT IN (1000, 2000, 3000);
 
 
desc departments;

 'ex 12'
 SELECT first_name, department_name
 FROM employees e LEFT JOIN departments d ON (d.department_id=e.department_id);
 
 
 
'ex 13'
SELECT first_name, department_name
 FROM employees e RIGHT JOIN departments d ON (d.department_id=e.department_id);
 
 'ex 14'
 SELECT e.first_name, e.last_name, m.first_name managerf, m.last_name managerl
 FROM employees e JOIN employees m ON (e.manager_id = m.employee_id);
 
 'ex 15'
 SELECT e.first_name, e.last_name, m.first_name managerf, m.last_name managerl
 FROM employees e LEFT JOIN employees m ON (e.manager_id = m.employee_id);
 
 
 --EX 16. S? se ob?in? codurile departamentelor ?n care nu lucreaza nimeni (nu este introdus nici un
--salariat ?n tabelul employees).
SELECT d.department_id
FROM departments d LEFT JOIN employees e ON (d.department_id= e.department_id)
MINUS
SELECT d.department_id
FROM departments d JOIN employees e ON (d.department_id= e.department_id);

--17. S? se afi?eze cel mai mare salariu, cel mai mic salariu, suma ?i media salariilor tuturor
--angaja?ilor. Eticheta?i coloanele Maxim, Minim, Suma, respectiv Media. Sa se rotunjeasca
--rezultatele.

SELECT max(salary) Maxim, min(salary) Minim, sum(salary) Suma, round(avg(salary)) Media
FROM employees;

--18. S? se afi?eze minimul, maximul, suma ?i media salariilor pentru fiecare job.
SELECT job_id,max(salary) Maxim, min(salary) Minim, sum(salary) Suma, round(avg(salary)) Media
FROM employees
GROUP BY job_id;

--19.19. S? se afi?eze num?rul de angaja?i pentru fiecare job.
SELECT job_id,count (*)
FROM employees
GROUP BY job_id;

--20. Scrie?i o cerere pentru a se afi?a numele departamentului, loca?ia, num?rul de angaja?i ?i
---salariul mediu pentru angaja?ii din acel departament. Coloanele vor fi etichetate
--corespunz?tor.
select * from departments;

SELECT department_name Nume_Departament, location_id Locatia, count(*), avg(salary)
FROM departments d join employees e ON (d.department_id= e.department_id)
GROUP BY department_name, location_id;


--21 S? se afi?eze codul ?i numele angaja?ilor care c?stiga mai mult dec?t salariul mediu din
--firm?. Se va sorta rezultatul ?n ordine descresc?toare a salariilor.

SELECT employee_id, first_name, last_name, salary
FROM employees
WHERE salary > (
                SELECT avg(salary)
                from employees
                )
ORDER BY salary desc;

--22 Care este salariul mediu minim al job-urilor existente? Salariul mediu al unui job va fi
--considerat drept media arirmetic? a salariilor celor care ?l practic?.

SELECT min(s)
FROM (
        SELECT avg(salary) s
        FROM employees
        GROUP BY job_id
);

--23 Modifica?i exerci?iul anterior pentru a afi?a ?i id-ul jobului.


SELECT *
FROM (
        SELECT avg(salary) s, job_id
        FROM employees
        GROUP BY job_id
        ORDER BY s
)
WHERE rownum<2;


--24 24. Sa se afiseze codul, numele departamentului si numarul de angajati care lucreaza in
--acel departament pentru:
--a) departamentele in care lucreaza mai putin de 4 angajati;
--b) departamentul care are numarul maxim de angajati.

--departamet si numar de angajati
--a
SELECT *
FROM (
    SELECT count(*) nr_angajati, d.department_id, department_name
    FROM employees e join departments d on (e.department_id=d.department_id)
    GROUP BY d.department_id, department_name)
WHERE nr_angajati<4;

--b

SELECT *
FROM (
    SELECT count(*) nr_angajati, d.department_id, department_name
    FROM employees e join departments d on (e.department_id=d.department_id)
    GROUP BY d.department_id, department_name
    ORDER BY 1 DESC)
WHERE rownum<2 ;



--nr max de angajati pe departament
SELECT max(nr) from(
SELECT count(*) nr, d.department_id, department_name
FROM employees e join departments d on (e.department_id=d.department_id)
GROUP BY d.department_id, department_name);



--tema din anexa 2 ++ exercitiile de la 25 la 31

--25. S? se ob?in? num?rul departamentelor care au cel pu?in 15 angaja?i.
SELECT *
FROM (
    SELECT count(*) nr_angajati, d.department_id, department_name
    FROM employees e join departments d on (e.department_id=d.department_id)
    GROUP BY d.department_id, department_name)
WHERE nr_angajati>=15;

--26. Sa se afiseze salariatii care au fost angajati în aceea?i zi a lunii în care cei mai multi dintre
--salariati au fost angajati.