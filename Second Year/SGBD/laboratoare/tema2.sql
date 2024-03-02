--25
SELECT count(*)
FROM (
        SELECT e.department_id, count(*) emp
        FROM employees e 
        GROUP BY department_id
        
)
WHERE emp>15;


--26

SELECT employee_id, last_name, EXTRACT(DAY FROM hire_date)
FROM employees
WHERE EXTRACT(DAY FROM hire_date) = (
            SELECT zi
            FROM (SELECT EXTRACT(DAY FROM hire_date) zi, count(*) nr
                    FROM employees
                    GROUP BY EXTRACT(DAY FROM hire_date)
                    ORDER BY nr DESC
            )
            WHERE rownum<2
);
--28
SELECT * 
FROM (
    SELECT employee_id,last_name, salary
    FROM employees
    ORDER BY salary DESC
    )
WHERE rownum<11;

--29
SELECT department_id, department_name, suma
FROM departments
WHERE nvl(to_char(department_id) ,'fara_departament') IN (
        SELECT nvl(to_char(department_id) ,'fara_departament') id_departament, nvl(sum(salary),0) suma
        FROM employees
        GROUP BY department_id);
        
        
--31
SELECT last_name, salary, nvl(to_char(department_id),'fara_departamnet')
FROM employees
WHERE (salary,nvl(to_char(department_id),'fara_departamnet')) IN (
                SELECT min(salary) s,nvl(to_char(department_id),'fara_departamnet')
                FROM employees
                GROUP BY department_id
                );
                
--30
    SELECT employee_id,salary, nvl(to_char(department_id),'fara_departamnet') dep
    FROM employees e
    WHERE salary>
                (SELECT avg(salary)
                FROM employees
                GROUP BY department_id
                Having department_id=e.department_id
                );
            
                
                
                
                
                