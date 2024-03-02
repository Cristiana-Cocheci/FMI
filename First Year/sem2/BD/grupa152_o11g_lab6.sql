select distinct d.department_id
from employees e full join departments d on (e.department_id= d.department_id)
where lower() like "%re%"
and 




LMD -select, insert, update, delete, merge

LDD- CREATE, OTHER, DROP, TRUNCATE

LCD- ROLLBACK, COMMIT, SAVEPOINT