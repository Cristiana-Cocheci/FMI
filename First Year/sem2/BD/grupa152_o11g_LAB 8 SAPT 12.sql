
--LABORATOR 8 partea 2

3. Sa se afiseze numele si salariul celor mai prost platiti angajati din fiecare departament.
Solu?ia 1 (cu sincronizare):


SELECT last_name, salary, department_id
FROM employees e
WHERE salary=(
                select min(salary)
                from employees 
                Where e.department_id=department_id
               -- group by department_id
                );


Solu?ia 2 (f?r? sincronizare):
SELECT last_name, salary, department_id
FROM employees e
WHERE (salary, department_id) IN (
                select min(salary), department_id
                from employees
                group by department_id
                );



Solu?ia 3: Subcerere în clauza FROM

select last_name, salary, e.department_id
from employees e join (
                        select min(salary) SALARIU, department_id
                        from employees
                        group by department_id) min_sal
                on (e.department_id= min_sal.department_id and salary= SALARIU);

select last_name, salary, e.department_id
from employees e join (
                        select min(salary) SALARIU, department_id
                        from employees
                        group by department_id) min_sal
                on (e.department_id= min_sal.department_id)
WHERE e.salary=SALARIU;



------idkk what where are we



select employee_id, last_name, salary, rownum
from employees e
where 10>(select count (salari)
          from employees
          where e.salary<salary
          );
          


select employee_id, last_name, salary, rownum
from employees 
where rownum<=10
order by salary desc;

select employee_id, last_name, salary, rownum
from (select employee_id, last_name, salary
      from employees 
      order by salary desc)
where rownum<=10;





select
from
where
group by
having
order by




4.	Sa se obtina numele si salariul salariatilor care lucreaza intr-un departament 
in care exista cel putin 1 angajat cu salariul egal cu 
salariul maxim din departamentul 30.;

-- METODA 1 - IN;

select last_name, salary, department_id
from employees
where department_id in ( select department_id
                        from employees
                        where salary=(select max(salary)
                                      from employees
                                      where department_id=30
                                    )
                        );


-- METODA 2 - EXISTS

select last_name, salary, department_id
from employees e
where exists ( select 1 --sau caracter'x'-- selectare de constanta
                from employees
                where e.department_id=department_id
                and salary=(select max(salary)
                            from employees
                             where department_id=30
                            )
             );


5.	S? se afi?eze codul, numele ?i prenumele angaja?ilor care au cel pu?in doi subalterni. 

a)

select employee_id, last_name, first_name
from employees mgr
where 1 < (select count(employee_id)
           from employees
           where mgr.employee_id = manager_id
          );

--SAU:
select employee_id, last_name, first_name
from employees e join (select manager_id, count(*) 
                       from employees 
                       group by manager_id
                       having count(*) >= 2
                       ) man
on e.employee_id = man.manager_id;


b) Cati subalterni are fiecare angajat? Se vor afisa codul, numele, prenumele si numarul de subalterni.
Daca un angajat nu are subalterni, o sa se afiseze 0 (zero). 


select employee_id, last_name, first_name, (select count(employee_id) 
                                            from employees 
                                            where manager_id=e.employee_id)
from employees e;

select employee_id, last_name, first_name , nvl(man.NUMAR,0)
from employees e left join (select manager_id, count(*) NUMAR
                            from employees 
                            group by manager_id
                            ) man
on e.employee_id = man.manager_id;

---ALIASURILE sunt importante!!!!!!!!!!!!!!!!!!!!!!!!


6.	S? se determine loca?iile în care se afl? cel pu?in un departament.
;
-- REZOLVATI
-- CEREREA TREBUIE SA AFISEZE 7 LOCATII 
-- VEZI IMAGINEAZA ATASATA IN LABORATOR
;
-- METODA 1 - IN (care este echivalent cu  = ANY )     
select location_id
from locations loc
where location_id in (select location_id from departments);

select location_id



-- METODA 2 - EXISTS



7.	S? se determine departamentele în care nu exist? niciun angajat.

-- REZOLVATI
-- CEREREA TREBUIE SA RETURNEZE 16 DEPARTAMENTE
-- VEZI IMAGINEAZA ATASATA IN LABORATOR

-- METODA 1 - UTILIZAND NOT IN 

SELECT department_id, department_name
FROM departments d
WHERE ___ NOT IN (SELECT ____
                  FROM ____
                  );


-- METODA 2 - UTILIZAND NOT EXISTS

SELECT department_id, department_name
FROM departments d
WHERE ___ (SELECT 
           FROM 
          );



9. S? se afi?eze codul, prenumele, numele ?i data angaj?rii, pentru angajatii condusi de Steven King 
care au cea mai mare vechime dintre subordonatii lui Steven King. 
Rezultatul nu va con?ine angaja?ii din anul 1970. ;


--with creeaza un pseudo tabel, il denumeste cu un alias prin 'as'

--subordonatii lui King
with subordonati as (select employee_id,hire_date
                     from employees
                     where manager_id =(select employee_id
                                        from employees
                                        where lower(last_name || first_name)='kingsteven'
                                        )
                    ),
--subordonatii lui king cu cea mai mare vechime

subordonati_vechi as (select employee_id 
                      from subordonati
                      where hire_date = (select min(hire_date)
                                         from subordonati
                                         )
                    )
select *
from employees 
where employee_id in (select employee_id from subordonati_vechi);
                    


10. Sa se obtina numele primilor 10 angajati avand salariul maxim. 
Rezultatul se va afi?a în ordine cresc?toare a salariilor. 

-- Solutia 1: subcerere sincronizat?

-- numaram cate salarii sunt mai mari decat linia la care a ajuns

select last_name, salary, rownum 
from employees e
where 10 >
     (select count(salary) 
      from employees
      where e.salary < salary
     );




-- Solutia 2: analiza top-n 
-- ESTE CORECTA VARIANTA URMATOARE?

select employee_id, last_name, salary, rownum
from employees
where rownum <= 10
order by salary desc;


