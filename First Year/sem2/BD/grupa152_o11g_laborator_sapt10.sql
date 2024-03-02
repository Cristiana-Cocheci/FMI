SELECT manager_id
from grupare
where salariu < 1100
group by manager_id
having count(*)<2;


select max(salariu)
from grupare
where max(salariu) < 2000;

select * from grupare;

select manager_id, min(salariu)
from grupare
group by manager_id
having min(salariu) <=1000;




1. a) Functiile grup includ valorile NULL in calcule?

functiile group ignora valorile null
count(expresie) ignora si el valorile null
count(*) ia in considerare si valorile null

b) Care este deosebirea dintre clauzele WHERE ?i HAVING?

where 
group by
having max() and salary >


2. S? se afi?eze cel mai mare salariu, cel mai mic salariu, suma ?i media salariilor
tuturor angaja?ilor. Eticheta?i coloanele Maxim, Minim, Suma, respectiv Media. Sa se
rotunjeasca media salariilor.
SELECT MAX(salary) Maxim, MIN(salary), SUM(salary), AVG(salary)
FROM employees;


3. S? se modifice problema 2 pentru a se afi?a minimul, maximul, suma ?i media
salariilor pentru FIECARE job.

SELECT job_id,job_title, MAX(salary) Maxim, MIN(salary), SUM(salary), AVG(salary)
FROM employees join jobs using (job_id)
GROUP BY job_id, job_title; 
--group by ia fiecare job, face grupuri, apoi apeleaza functiile de mai sus


4. S? se afi?eze num?rul de angaja?i pentru FIECARE departament.
SELECT nvl(to_char(department_id), 'Angajati fara departament'),COUNT(employee_id)
FROM employees
GROUP BY department_id;


5. S? se determine num?rul de angaja?i care sunt ?efi. Etichetati coloana “Nr.
manageri”.

Select COUNT(distinct manager_id) "Nr manageri"
from employees;

6. S? se afi?eze diferen?a dintre cel mai mare si cel mai mic salariu. Etichetati
coloana “Diferenta”.

SELECT department_id, max(salary)-min(salary) --Diferenta
FROM employees;

--pentru fiecare departament in parte

SELECT department_id, max(salary)-min(salary) --Diferenta
FROM employees
WHERE department_id is not null
GRoup by department_id;



7. Scrie?i o cerere pentru a se afi?a numele departamentului, loca?ia, num?rul de
angaja?i ?i salariul mediu pentru angaja?ii din acel departament. Coloanele vor fi
etichetate corespunz?tor.
!!!Obs: În clauza GROUP BY se trec obligatoriu toate coloanele prezente în clauza
SELECT, care nu sunt argument al func?iilor grup (a se vedea ultima observa?ie de la
punctul I).

SELECT e.department_id,d.department_name, d.location_id, COUNT(employee_id), round(AVG(salary))
FROM employees e LEFT JOIN departments d on(e.department_id = d.department_id)
GROUP BY e.department_id,d.department_name, d.location_id;



8. S? se afi?eze codul ?i numele angaja?ilor care au salariul mai mare decât salariul
mediu din firm?. Se va sorta rezultatul în ordine descresc?toare a salariilor.

SELECT employee_id, first_name, last_name
FROM employees
WHERE salary > (SELECT AVG(salary)
                FROM employees
                )
ORDER BY salary DESC;



9. Pentru fiecare ?ef, s? se afi?eze codul s?u ?i salariul celui mai prost platit
subordonat. Se vor exclude cei pentru care codul managerului nu este cunoscut. De
asemenea, se vor exclude grupurile în care salariul minim este mai mic de 1000$.
Sorta?i rezultatul în ordine descresc?toare a salariilor.

select manager_id, min(salary)
from employees
where manager_id is not null
group by manager_id
having min(salary)> 5800
ORDER BY min(salary); --important



10. Pentru departamentele in care salariul maxim dep??e?te 3000$, s? se ob?in? codul,
numele acestor departamente ?i salariul maxim pe departament.
SELECT department_id, department_name, MAX(salary)
FROM departments JOIN employees USING(department_id)
GROUP BY department_id,department_name
HAVING MAX(salary) >= 3000;
11. Care este salariul mediu minim al job-urilor existente? Salariul mediu al unui job va
fi considerat drept media aritmetic? a salariilor celor care îl practic?.

SELECT min(round(avg(salary)))
FROM employees
GROUP BY job_id;


12. S? se afi?eze maximul salariilor medii pe departamente.

SELECT max(round(avg(salary)))
FROM employees
GROUP BY department_id;

13. Sa se obtina codul, titlul ?i salariul mediu al job-ului pentru care salariul mediu
este minim.

SELECT j.job_id, j.job_title, avg(salary)
FROM employees e join jobs j on (e.job_id=j.job_id)
group by j.job_id, j.job_title
HAVING round(avg(salary))= (
                            SELECT min(round(avg(salary)))
                            FROM employees
                            GROUP BY job_id
                            );
-- having este functie de grupare, echivalent cu where dar merge pe grupari



14. S? se afi?eze salariul mediu din firm? doar dac? acesta este mai mare decât 2500
--nu e gata
SELECT round(avg(salary))
from employees
WHERE round(avg(salary))>2500;

15. S? se afi?eze suma salariilor pe departamente ?i, în cadrul acestora, pe job-uri.
SELECT department_id, job_id, SUM(salary)
FROM employees
GROUP BY department_id, job_id;


16. Sa se afiseze codul, numele departamentului si numarul de angajati care
lucreaza in acel departament pentru:
a) departamentele in care lucreaza mai putin de 4 angajati;
b) departamentul care are numarul maxim de angajati.

a) ;
SELECT e.department_id, d. department_name, COUNT(*)
FROM departments d JOIN employees e
                    ON (d.department_id = e.department_id )
WHERE e.department_id IN (SELECT department_id
                          FROM employees
                          GROUP BY department_id
                          HAVING COUNT(*) < 4)
GROUP BY e.department_id, d.department_name;
 
Sau:

SELECT e.department_id, d.department_name, COUNT(employee_id)
FROM employees e right JOIN departments d ON (d.department_id = e.department_id )
GROUP BY e.department_id, d.department_name
HAVING COUNT(employee_id)<4; 

b)
SELECT e.department_id, d.department_name, COUNT(employee_id)
FROM employees e right JOIN departments d ON (d.department_id = e.department_id )
GROUP BY e.department_id, d.department_name
HAVING COUNT(employee_id)=(
                            SELECT max(COUNT(employee_id))
                            FROM employees e right JOIN departments d ON (d.department_id = e.department_id )
                            GROUP BY e.department_id, d.department_name
                          ); 

17. S? se ob?in? num?rul departamentelor care au cel pu?in 15 angaja?i.


select count(count(employee_id)) "nr. departamente"
from employees
group by department_id
having count(employee_id) >=15;

18. S? se ob?in? codul departamentelor ?i suma salariilor angaja?ilor care lucreaz? în
acestea, în ordine cresc?toare. Se consider? departamentele care au mai mult de 10 angaja?i ?i al c?ror cod este diferit de 30.

select sum(salary),department_id, count(employee_id)
from employees
where department_id !=30
group by department_id
having count(employee_id)>10;

19. Care sunt angajatii care au mai avut cel putin doua joburi?

select employee_id
from job-history
group by employee_id
having count(job_id)>=2;

20. S? se calculeze comisionul mediu din firm?, luând în considerare toate liniile din
tabel.

avg, min, max, sum, count(expresie) -ignora valorile null
count(*) - numara si valorile null

select round(sum(comission_pct) / count(*),2)
from employees;

--sau--
select avg(nvl(commision_pct,0))
from employees;

-- calculam media tuturor comisiooanlor luand in considerare doar valorile !=null
select round(sum(commision_pct)/count(commision_pct),2)
from employees;

--__sau__--

select avg(commision_pct)
from employees;

21. Scrieti o cerere pt a afisa job-ul, salariul total pt job-ul respectiv pe departamente
si salariul total pt job ul respectiv pe departamentele


--!!!
_--____DECODE (value, if1, then1 if2, then2 ....., else);

select job_id, sum(decode(department_id,30, salary) Dep30,
               sum(decode(department_id,50, salary) Dep50,
               sum(decode(department_id,80, salary) Dep80,
               sum(salary) total
from employees
group by job_id;

--sau cu subcereri
select job_id, (select sum(salary) from employees where department_id=30 and job_id=e.job_id) dep30,
               (select sum(salary) from employees where department_id=50 and job_id=e.job_id) dep50,
               sum(salary) total
               
24.

--gresit, criteriul de grupare nu este corect, trb sa grupam numai dupa department_id
select last_name, salary, department_id, departmen_name, avg(salary), round(avg(salary)), count(employee_id)
from employees join departments using(department_id)
group by last_name, salary, department_id, department_name;


-- cu subcereri

--subcerere in from
select last_name, salary, e.department_id, departmen_name
from employees e join departments d on(e.department_id=d.department_id)
                 join (
                            select round(avg(salary)) sal_mediu, count(employee_id) nr_ang
                            from employees
                            group by department_id
                       ) ac 
                        on(ac.department_id = e.department_id);

select last_name, salary, e.department_id, departmen_name,
                    (select round(avg(salary)) 
                     from employees
                     ) "salariu mediu"
                     
                     (select count(employee_id) 
                     from employees
                     where department_id= e.department_id
                     ) "nr ang"
from employees e join departments d on (e.department_id= d.department_id);




--LABORATOR OPT
A) sa se afiseze informatii despre ang cu sal> sal mediu

select last_name, salary, department_id
from employees e
where salary > ( select avg(salary from employees where employee_id!= e.employee_id);

b)
select last_name, salary, department_id 
from employees e
where salary > (select round(avg(salary)) from employees where department_id= e.department_id);

c)


2.














