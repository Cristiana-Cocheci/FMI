--lab1 

S? se afi?eze numele concatenat cu prenumele si cu job_id-ul, separate prin
virgula
?i spatiu. Eticheta?i coloana “Detalii Angajat”.

SELECT last_name || ', ' || first_name || ', ' || job_id as "Detalii Angajat"
FROM employees;

10. S? se afi?eze numele, job-ul ?i data la care au început lucrul salaria?ii
angaja?i între 20 Februarie 1987 ?i 1 Mai 1989.
Rezultatul va fi ordonat cresc?tor dup? data de început.
--sysdate

SELECT last_name, job_id, hire_date
FROM employees
WHERE hire_date BETWEEN '20-FEB-1987' AND '1-MAY-1989'
ORDER BY hire_date; -- ordonare crescatoare ORDER BY 3

SELECT last_name || ', ' || first_name as "Angajat", salary as "Salariu lunar", department_id
FROM employees
WHERE department_id in (10, 30) and salary > 1500
ORDER BY "Angajat";

SELECT SYSDATE
FROM DUAL;

SELECT TO_CHAR(SYSDATE, 'mon')
FROM DUAL;

SELECT TO_CHAR(SYSDATE, 'hh24 mi ss sssss') ora
FROM DUAL;

SELECT last_name, hire_date
FROM employees
WHERE TO_CHAR(hire_date, 'YYYY')= '1987';

SELECT last_name
FROM employees
WHERE UPPER(last_name) LIKE '__A%';

SELECT last_name, job_id, salary
FROM employees
WHERE (UPPER(job_id) LIKE '%CLERK%' OR UPPER(job_id) LIKE
'%REP%')
 AND salary NOT IN (1000, 2000, 3000);
 
 --lab2
 
 CASE expr
WHEN expr_1 THEN
 valoare_1
[WHEN expr_2 THEN
 valoare_2
...
WHEN expr_n THEN
 valoare_n ]
[ELSE valoare]
END ;

SELECT TO_DATE('18-03-2022', 'DD-MM-YYYY')
FROM DUAL;

select employee_id "Cod ang", last_name "Nume Ang", length(last_name)
"Lung Nume",
 INSTR(upper(last_name), 'A', 1, 1) "Pozitie litera A"
from employees
where --substr (lower(last_name), -1) = 'e';
 lower(last_name) like '%e';
 
 6. S? se afi?eze codul salariatului, numele, salariul, salariul m?rit cu 15%,
exprimat cu dou? zecimale ?i num?rul de sute al salariului nou rotunjit la 2 zecimale.
Eticheta?i ultimele dou? coloane “Salariu nou”, respectiv “Numar sute”.
Se vor lua în considerare salaria?ii al c?ror salariu nu este divizibil cu 1000.
SELECT employee_id, last_name, salary,
 round(salary + 0.15 * salary, 2) "Salariu Nou",
 round((salary + 0.15 * salary) / 100, 2) "Numar sute"
FROM employees
WHERE MOD(salary, 1000) != 0;

9. S? se afi?eze num?rul de zile r?mase pân? la sfâr?itul anului.
SELECT ROUND(sysdate- to_date('03-03-2023', 'DD-MM-YYYY'))
FROM dual;

--lab3
-- DORIM SA AFISAM SI ANGAJATII CARE NU AU DEPARTAMENT
-- ADICA AFISAM TOTI ANGAJATII INDIFERENT DACA AU SAU NU DEPARTAMENT
-- CEEA CE INSEAMNA CA AFISAM ATAT ANGAJATII CARE AUDEPARTAMENT (INTERSECTIA)
-- CAT SI ANGAJATII CARE NU AU DEPARTAMENT
SELECT employee_id, last_name, d.department_id, department_name
FROM employees e LEFT JOIN departments d ON (e.department_id =
d.department_id)
minus
SELECT employee_id, last_name, d.department_id, department_name
FROM employees e JOIN departments d ON (e.department_id =
d.department_id)
;

--lab 5--tabele


CREATE TABLE angajati_coco
      ( cod_ang number(4),
        nume varchar2(20) constraint nume_ang not null,
        prenume varchar2(20),
        email char(15)unique,
        data_ang date default sysdate,
        job varchar2(10),
        cod_sef number(4),
        salariu number(8, 2) constraint salariu_ang not null,
        cod_dep number(2),
        constraint pkey_ang primary key(cod_ang) --constrangere la nivel de tabel
       );
INSERT INTO angajati_coco(cod_ang, nume, prenume, data_ang, job, salariu, cod_dep)
VALUES(100, 'nume1', 'prenume1', null, 'Director', 20000, 10);

SELECT * FROM angajati_coco;
INSERT INTO angajati_coco
VALUES(101, 'nume2', 'prenume2', 'nume2', to_date('02-02-2004','dd-mm-yyyy'), 
       'Inginer', 100, 10000, 10);
       INSERT INTO angajati_coco
VALUES(102, 'nume3', 'prenume3', 'nume3', to_date('05-06-2000','dd-mm-yyyy'), 
       'Analist', 101, 5000, 20);

-- 4             
INSERT INTO angajati_coco(cod_ang, nume, prenume, data_ang, job, cod_sef, salariu, cod_dep)
VALUES(103, 'nume4', 'prenume4', null, 'Inginer', 100, 9000, 20);

-- 5       
INSERT INTO angajati_coco
VALUES(104, 'nume5', 'prenume5', 'nume5', null, 'Analist', 101, 3000, 30);

-- salvam inregistrarile
COMMIT;
   

DESC angajati_coco;

ALTER TABLE angajati_coco
ADD comision number(4,2);

SELECT * FROM angajati_coco;

ALTER TABLE angajati_coco
MODIFY (salariu number(6,2));
--nu , pot doar sa cresc, nu pot sa scad sub (8,2)


ALTER TABLE angajati_coco
MODIFY (salariu number(8,2) default 100);

UPDATE angajati_coco
SET comision = 0.1
WHERE upper(job) LIKE 'A%';

select * from angajati_coco;
desc angajati_coco;

ALTER TABLE angajati_coco
MODIFY (email varchar2(15));

ALTER TABLE angajati_coco
ADD (nr_telefon varchar2(10) default '0723123944');

SELECT * FROM angajati_coco;
DESC angajati_coco

ALTER TABLE angajati_coco
DROP column nr_telefon;

rollback;

select* from departamente_coco;
desc departamente_coco;

INSERT INTO departamente_coco
VALUES (10, 'Administrativ', 100);

ALTER TABLE angajati_coco
ADD CONSTRAINT fkey_ang_dep FOREIGN KEY(cod_dep) REFERENCES departamente_coco(cod_dep);


INSERT INTO departamente_coco
VALUES (20, 'Proiectare', 101);

INSERT INTO departamente_coco
VALUES (30, 'Programare', null);

commit;

ALTER TABLE departamente_coco  --are commit automat
ADD CONSTRAINT pkey_dep PRIMARY KEY(cod_dep);



--lab3/4 joinuri
6. Se cer codurile departamentelor al c?ror nume con?ine ?irul “re” sau
în care lucreaz? angaja?i având codul job-ului “SA_REP”.


select * from departments;
select * from employees;

select department_id
from departments
where upper(department_name) like '%RE%'
UNION
select department_id
from employees
where upper(job_id) = 'SA_REP';

select distinct d.department_id
from departments d full join employees e on(d.department_id=e.department_id)
where upper(d.department_name) like '%RE%' or e.job_id='SA_REP'
order by 1;

8. S? se ob?in? codurile departamentelor în care nu lucreaza nimeni
(nu este introdus nici un salariat în tabelul employees). Se cer doua solutii
;

select department_id
from departments
minus
select distinct department_id
from employees;


select d.department_id
from departments d left join employees e on(d.department_id=e.department_id)
where d.department_id not in (
                                select d.department_id
from departments d join employees e on(d.department_id=e.department_id)

);

select *
from employees e right join departments d on (e.department_id =
d.department_id)
where e.department_id is null;

--lab 4
select * from emp_coco;
select * from dept_coco;

14. S? se promoveze Douglas Grant la manager în departamentul 20 (tabelul
dept_pnu),
având o cre?tere de salariu cu 1000$


update dept_coco
set manager_id= (
                    select employee_id
                    from emp_coco
                    where upper(last_name)='GRANT' 
                    and upper( first_name)='DOUGLAS'
)
where department_id=20;

update emp_coco
set salary= salary+1000
where employee_id=(select employee_id
                    from emp_coco
                    where upper(last_name)='GRANT' 
                    and upper( first_name)='DOUGLAS');
commit;
rollback;


19. S? se ?tearg? din tabelul DEPT_PNU departamentele care au codul de
departament
cuprins intre 160 si 200. Lista?i con?inutul tabelului.
select * from emp_coco;
select * from dept_coco;


delete from dept_coco
where department_id between 160 and 200;

rollback;



--lab 6
9. S? se ob?in? codurile departamentelor în care nu lucreaza nimeni (nu este introdus
niciun salariat în tabelul employees). Sa se utilizeze subcereri. De ce este nevoie de
utilizarea func?iei NVL? 
select *from departments;

select department_id
from departments
where department_id not in(
                select distinct nvl(department_id,0)
                from employees
);

7. Scrie?i o cerere pentru a afi?a numele angajatilor, numele departamentului ?i salariul
angaja?ilor care câ?tig? comision, dar al c?ror ?ef direct nu câ?tig? comision.

select * from employees;

select last_name from employees
where nvl(commission_pct,0)>0;

select employee_id from employees
where nvl(commission_pct,0)=0;

select e.last_name, department_name, e.salary
from employees e join departments d on(e.department_id=d.department_id)
where employee_id in(
                select employee_id from employees
                where nvl(commission_pct,0)>0)
        and e.manager_id in(
                select employee_id from employees
                where nvl(commission_pct,0)=0);
                
                
--lab 7
2. S? se afi?eze cel mai mare salariu, cel mai mic salariu, suma ?i media salariilor
tuturor angaja?ilor. Eticheta?i coloanele Maxim, Minim, Suma, respectiv Media. Sa se
rotunjeasca media salariilor.
SELECT MAX(salary) Maxim, MIN(salary) Minim, Sum(salary) Suma, Avg(salary) Average
FROM employees;
3. S? se modifice problema 2 pentru a se afi?a minimul, maximul, suma ?i media
salariilor pentru FIECARE job.
SELECT job_id,MAX(salary) Maxim, MIN(salary) Minim, Sum(salary) Suma, round(Avg(salary),2) Average
FROM employees
GROUP BY job_id;
4. S? se afi?eze num?rul de angaja?i pentru FIECARE departament.
SELECT COUNT(*), nvl(to_char(department_id),'fara') departament
FROM employees
GROUP BY department_id;
5. S? se determine num?rul de angaja?i care sunt ?efi. Etichetati coloana “Nr.
manageri”.

select *from employees;

select DISTINCT  nvl(manager_id,0)
FROM employees;

select count(ccc)
from(
select count(*) ccc
from employees
where manager_id is not null
group by manager_id);

select count(distinct manager_id) "Nr. manageri"
from employees;



SELECT department_name, location_id, count(employee_id),
 round(avg(salary))
FROM employees e left join departments d on (e.department_id =
d.department_id)
GROUP BY department_name, location_id;


Pentru fiecare ?ef, s? se afi?eze codul s?u ?i salariul celui mai prost platit
subordonat.
Se vor exclude cei pentru care codul managerului nu este cunoscut.
De asemenea, se vor exclude grupurile în care salariul minim este mai mic de
1000$.
Sorta?i rezultatul în ordine descresc?toare a salariilor.


select manager_id, min(salary) m
from employees
where manager_id is not null
group by manager_id
--having min(salary) > 1000
order by 2 desc
;


Pentru departamentele in care salariul maxim dep??e?te 3000$, s? se
ob?in? codul,
numele acestor departamente ?i salariul maxim pe departament.

select d.department_id, department_name, max(salary)
from departments d join employees e on (d.department_id=e.department_id)
group by d.department_id, department_name
having max(salary)>3000;


16. Sa se afiseze codul, numele departamentului si numarul de angajati care
lucreaza in acel departament pentru:
a) departamentele in care lucreaza mai putin de 4 angajati;
-- vrem sa afisam toate depart -> atat pe cele care au ang cat si pe cele care nu
au
-- departamentele care nu au angajati au zero angajati
-- 0 < 4 -> deci vom afisa si departamentele care au zero angajati

select * from employees;


--select count(*) from()
select d.department_id, department_name, count(*)
from departments d join employees e on (d.department_id=e.department_id)
group by d.department_id, department_name
having  count(*)<4;

--În cazul în care utiliz?m NOT IN trebuie avut grij? ca subcererea s? nu returneze valori
--null. În caz contrar, invariabil, rezultatul cererii va fi 'no rows selected'. 


b) S? se afi?eze informa?ii (numele, salariul si codul departamentului) despre angaja?ii al c?ror
salariu dep??e?te valoarea medie a salariilor colegilor s?i de departament.
 c) Analog cu cererea precedent?, afi?ându-se ?i numele departamentului ?i media salariilor
acestuia ?i num?rul de angaja?i.

select last_name, salary, department_id
from employees e
where salary> (select avg(salary)
                from employees
                group by department_id
                having department_id=e.department_id);
 

SELECT last_name, salary, e. department_id--, department_name,
 --(SELECT AVG(salary)
 --FROM employees
 --WHERE department_id = e. department_id) "Salariu mediu",
 --(SELECT COUNT(*)
 --FROM employees
 --WHERE department_id = e. department_id) "Nr angajati"
FROM employees e join departments d on (e.department_id = d.department_id)
WHERE salary > (SELECT AVG(salary)
 FROM employees
 WHERE department_id = e.department_id);
 
 
 
 b) Cati subalterni are fiecare angajat? Se vor afisa codul, numele, prenumele
si numarul de subalterni.
Daca un angajat nu are subalterni, o sa se afiseze 0 (zero)

select employee_id, first_name||' '||last_name Nume, 
         (   select count(employee_id)
            from employees
            where manager_id=e.employee_id
        ) subalt
from employees e;

select employee_id, last_name, first_name, (select count(employee_id)
 from employees
 where manager_id = e.employee_id
 ) "Nr subalterni"
from employees e;


select last_name, salary
from employees e
where 10 >
 (select count(salary)
 from employees
 where e.salary < salary
 )
 order by salary desc;

select employee_id, last_name, salary, rownum
from (select employee_id, salary, last_name
 from employees
 order by salary desc
 )
where rownum <= 10
order by salary;


16. Care sunt departamentele (cod si nume) care contin cel putin
doua job-uri distincte?

select department_id, count(distinct job_id)
from employees
group by department_id;



select department_id, department_name
from departments d
where 2<=(
        select count(distinct job_id)
        from employees
        where d.department_id=department_id
        group by department_id)
;

select department_id, department_name,(
        select count(distinct job_id)
        from employees
        where d.department_id=department_id
        group by department_id) j
from departments d
where 2<=(
        select count(distinct job_id)
        from employees
        where d.department_id=department_id
        group by department_id);


--division
SELECT employee_id
FROM works_on
WHERE project_id IN
 (SELECT project_id
 FROM project
 WHERE budget = 10000
 ) -- obtinem proiectele cu buget de 10k = p2 si p3

-- pana in acest punct vom prelua angajatii care lucreaza
-- fie la p2, fie la p3, fie la ambele

GROUP BY employee_id
HAVING COUNT(project_id)=
 (SELECT COUNT(*)
 FROM project
 WHERE budget = 10000
 );
 
 11. S? se ob?in? angaja?ii care au lucrat EXACT pe acelea?i proiecte ca ?i
angajatul având codul 200.

select employee_id from works_on
where project_id in(
            select project_id from works_on
            where employee_id=200)
group by employee_id
having count(project_id)=(
            select count(project_id) from works_on
            where employee_id=200);
            
