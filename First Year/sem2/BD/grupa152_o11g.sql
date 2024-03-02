DESC EMPLOYEES;

SELECT * FROM EMPLOYEES;

SELECT LAST_NAME, SALARY 
FROM employees
WHERE salary >10000;

-- ATENTIE LA ORDINEA SCRIERII CLAUZELOR!
SELECT last_name, salary 
WHERE salary > 10000
FROM employees;

/*
COMENTARIU
xD
*/

-- alias cu ghilimele ""
-- caracter sau sir de caractere cu apostrof ''
SELECT employee_id, last_name, salary * 12 as "ANNUAL SALARY"
FROM employees;

SELECT employee_id, last_name, salary * 12 as annual_salary
FROM employees;



SELECT * 
FROM employees;

SELECT * FROM jobs;

SELECT * FROM job_history;




