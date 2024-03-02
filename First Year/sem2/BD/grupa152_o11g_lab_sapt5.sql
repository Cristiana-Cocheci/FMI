22. Scrie?i o cerere care afi?eaz? numele angajatului, codul departamentului în care
acesta lucreaz? ?i numele colegilor s?i de departament. Se vor eticheta coloanele
corespunz?tor.

SELECT ang.employee_id Cod_Angajat, ang.last_name, ang.department_id,
        coleg.employee_id Cod_Coleg, coleg.last_name
FROM employees ang ,employees coleg
WHERE ang.department_id = coleg.department_id
    AND ang.employee_id != coleg.employee_id 
    AND ang.employee_id < coleg.employee_id;
    

23. Crea?i o cerere prin care s? se afi?eze numele angajatilor, codul job-ului, titlul job-ului,
numele departamentului ?i salariul angaja?ilor. Se vor include ?i angaja?ii al c?ror
departament nu este cunoscut.


SELECT last_name, j.job_id, job_title, department_name, salary
FROM employees e, departments d, jobs j --intersectia nu ar lua angajatii cu department id null
WHERE e.department_id = d.department_id (+) --afiseaza si angajatii fara departament
 AND j.job_id = e.job_id;
 
 
24. S? se afi?eze numele ?i data angaj?rii pentru salaria?ii care au fost angaja?i dup? Gates.

SELECT ang.last_name NumeAng, ang.hire_date DataAng,
    gates.last_name NumeGates, gates.hire_date DataGates
FROM employees ang, employees gates
WHERE initcap(gates.last_name)='Gates'
    and gates.hire_date< ang.hire_date;
    
    
SELECT ang.last_name NumeAng, ang.hire_date DataAng
FROM employees ang
WHERE hire_date > (SELECT hire_date FROM employees 
WHERE last_name='Gates');

25. S? se afi?eze numele salariatului ?i data angaj?rii împreun? cu numele ?i data angaj?rii
?efului direct pentru salaria?ii care au fost angaja?i înaintea ?efilor lor. Se vor eticheta
coloanele Angajat, Data_ang, Manager si Data_mgr.


SELECT ang.last_name Angajat, ang.hire_date Data_Ang, m.last_name Manager,
    m.hire_date Data_mgr
FROM employees ang, employees m
WHERE ang.manager_id = m.employee_id AND ang.hire_date < m.hire_date;


--LAB3
2. S? se afi?eze codul ?i numele angaja?ilor care lucreaz? în acela?i departament cu
cel pu?in un angajat al c?rui nume con?ine litera “t”. Se vor afi?a, de asemenea, codul ?i
numele departamentului respectiv. Rezultatul va fi ordonat alfabetic dup? nume.

SELECT ang.employee_id "Cod_angajat", ang.last_name "Nume angajat", ang.department_id, department_name,
        coleg.employee_id "Cod_coleg", coleg.last_name Nume_coleg
FROM employees ang JOIN departments d ON (ang.department_id=d.department_id)
                    JOIN employees coleg ON (ang.department_id = coleg.department_id)
WHERE upper(coleg.last_name) like '%T%'
    and ang.employee_id != coleg.employee_id
ORDER BY ang.last_name;



3. S? se afi?eze numele, salariul, titlul job-ului, ora?ul ?i ?ara în care lucreaz?
angaja?ii condu?i direct de King.

SELECT e.last_name, e.salary, job_title, city, country_name, k.last_name
FROM employees e JOIN employees k ON (e.manager_id= k.employee_id)
                JOIN jobs j ON (e.job_id =j.job_id)
                JOIN departments d ON (d.department_id = e.department_id)
                JOIN locations l ON (d.location_id= l.location_id)
                JOIN countries c ON (l.country_id= c.country_id)
WHERE initcap(k.last_name)= 'King';
