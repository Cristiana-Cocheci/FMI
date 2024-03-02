-- LABORATOR 9
-- DIVISION

EX: S? se ob?in? codurile salaria?ilor ata?a?i tuturor proiectelor pentru care s-a alocat un buget egal cu 10000.

angajatii pot lucra si la o parte din proiecte?
angajatii trebuie sa lucreze obigatoriu la toate?
angajatii pot lucra si la alte proiecte in afara de proiectele cu buget de 10k?

SELECT * FROM PROJECT; -- p2 si p3 proiecte cu buget de 10k
SELECT * FROM WORKS_ON; -- 101, 145, 148, 200 -> angajatii care lucreaza la TOATE proiectele cu buget de 10k

!!! Toate proiectele inseamna ca angajatii sa lucreze OBLIGATORIU la TOATE proiectele cu buget de 10k (la toate - p2 si p3),
dar la alte proiecte cu un alt buget.

--Metoda 1 (utilizând de 2 ori NOT EXISTS):
SELECT	DISTINCT employee_id
FROM works_on a  -- cerere parinte C1 cu ajutorul careia se parcurg pe rand toti angajatii care lucreaza la proiecte
WHERE NOT EXISTS
         (SELECT 1
          FROM	project p
          WHERE	budget = 10000
          AND NOT EXISTS
                (SELECT	'x'
                 FROM works_on b
                 WHERE p.project_id = b.project_id
                 AND b.employee_id = a.employee_id
                 ) -- subcererea C3
          ); -- subcererea C2
          
-- sincronizarea dintre cererea parinte C1 si cererea interioara C3 si implicit si C2
-- se realizeaza dupa coloana employee_id -> b.employee_id = a.employee_id
-- ceea ce inseamna ca afisam angajatii din C1 care nu se afla in cererea C2
-- astfel in cererea C2 dorim angajatii care lucreaza la proiecte cu buget diferit de 10k sau
-- care lucreaza doar la o parte din proiectele cu buget de 10k

DIVISION - succesiune de 2 operatori not exists => 

=> Impartim in doua relatii:

angajati lucreaza la proiecte
proiectele au buget de 10k

C1 - din toti angajatii 
not exists 
C2 - ii excludem pe cei care lucreaza la proiecte cu buget diferit de 10k sau
     pe cei care lucreaza doar la o parte din proiectele cu buget de 10k 

Pentru ca in final sa obtinem exact angajatii care lucreaza la toate proiectele cu buget de 10k

Astfel in C2 NOT EXISTS C3 trebuie sa obtinem proiectele cu buget diferit de 10k

Avem C2 not exists C3
C2 - din toate proiectele cu buget de 10k
not exists 
C3 - excludem proiectele la care lucreaza angajatii in general (toate proiectele)

Si vom obtine proiecte la care lucreaza angajatii si au buget diferit de 10k

   
--Metoda 2 (simularea diviziunii cu ajutorul func?iei COUNT):
SELECT employee_id
FROM works_on
WHERE project_id IN
                (SELECT	project_id
                 FROM  	project
                 WHERE	budget = 10000
                 ) --obtinem proiectele cu buget de 10k
--pana in acest punct preluam angajatii care lucreaza fie la p2 fie la p3, fie la ambele
GROUP BY employee_id 
HAVING COUNT(project_id)=
                (SELECT COUNT(*)
                 FROM project
                 WHERE budget = 10000
                 );
                 
                 
9.	S? se afi?eze lista angaja?ilor care au lucrat numai pe proiecte 
conduse de managerul de proiect având codul 102.

select * from project;  -- managerul 102 conduce doua proiecte => p1 si p3

select * from works_on; -- angajatii care lucreaza NUMAI pe proiecte coduse de 102 => 
                        -- 136, 140, 150, 162, 176
                        
select employee_id
from works_on
where project_id in (select project_id
                     from project
                     where project_manager = 102
                     )--proiectele conduse de 102
minus
select employee_id
from works_on
where project_id not in (select project_id
                     from project
                     where project_manager = 102
                     )--proiectele conduse de 102;
    ;
    
10.	a) S? se ob?in? numele angaja?ilor care au lucrat 
cel pu?in pe acelea?i proiecte ca ?i angajatul având codul 200.

select * from works_on; -- ang 200 lucreaza la p2 si p3

CEL PUTIN -> ANGAJATII POT LUCRA PE ALTE PROIECTE DECAT 200
        -> ANG TRB SA LUCREZE LA TOATE PROIECTELE LUI 200


SELECT employee_id
FROM works_on
WHERE project_id IN
                (SELECT	project_id
                 FROM  	works_on
                 WHERE	employee_id = 200
                 ) --obtinem proiectele la care lucreaza 200
--pana in acest punct preluam angajatii care lucreaza fie la p2 fie la p3, fie la ambele
GROUP BY employee_id 
HAVING COUNT(project_id) =
                (SELECT COUNT(*)
                 FROM  	works_on
                 WHERE	employee_id = 200
                 )
Minus
select employee_id
from works_on
where employee_id=200;


b) S? se ob?in? numele angaja?ilor care au lucrat cel mult pe acelea?i proiecte ca ?i angajatul având codul 200.

select * from works_on; -- ang 200 lucreaza la p2 si p3

=> 101 (la ambele)
   145 (la ambele) 
   148 (la ambele)
   150 (doar p3)
   162 (doar p3)
   176 (doar p3)




SELECT employee_id
FROM works_on
WHERE employee_id!=200 and project_id IN
                (SELECT	project_id
                 FROM  	works_on
                 WHERE	employee_id = 200
                 ) --obtinem proiectele la care lucreaza 200
--pana in acest punct preluam angajatii care lucreaza fie la p2 fie la p3, fie la ambele
GROUP BY employee_id 
HAVING COUNT(project_id) <=
                (SELECT COUNT(*)
                 FROM  	works_on
                 WHERE	employee_id = 200
                 )
minus
select employee_id
from works_on
where project_id not in (SELECT	project_id
                 FROM  	works_on
                 WHERE	employee_id = 200)
    ;
    


11. S? se ob?in? angaja?ii care au lucrat exact pe acelea?i proiecte ca ?i angajatul având codul 200.





1. S? se listeze informa?ii despre angaja?ii care au lucrat în toate proiectele demarate în primele 6 luni ale anului 2006. 





--VARIABILE DE SUBSTITUTIE
--ex:8
select department_id, round(avg(salary))
from employees
group by department_id
having avg(salary) > &p;

select department_id, round(avg(salary))
from employees
group by department_id
having avg(salary) > &&p;


--EXEMPLU 1:
define c = 101;
select project_id
from works_on
where employee_id = &c;

undefine c;
define;

--EXEMPLU 2: 
define x = &&y;
select &&x from dual;
undefine y;
select &&x from dual;
undefine x;
select &&x from dual;
undefine x;
select &x from dual;

