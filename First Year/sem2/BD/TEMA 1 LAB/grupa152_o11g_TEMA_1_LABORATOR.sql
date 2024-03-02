1. Sa se afiseze numele, salariul, titlul jobului, codul si numele departamentului,
id-ul locatiei, orasul si tara in care lucreaza angajatii condusi direct de 
?hunoldalexander?.
Pe ultima coloana se va afisa numele managerului (Hunold), concatenat cu spatiu, 
concatenat cu prenumele sau (Alexander). 
Coloana o sa se numeasca Nume si Prenume Manager.

SELECT * FROM employees;

SELECT ang.last_name, ang.salary, j.job_title, d.department_id, d.department_name, d.location_id, l.city, c.country_name, 
        concat(concat(man.last_name,' '),man.first_name) "Nume si Prenume Manager"
FROM employees ang JOIN departments d ON (ang.department_id=d.department_id)
                   JOIN jobs j ON (ang.job_id=j.job_id)
                   JOIN locations l ON (d.location_id=l.location_id)
                   JOIN countries c ON (l.country_id=c.country_id)
                   JOIN employees man ON (ang.manager_id=man.employee_id)
WHERE lower(concat(man.last_name,man.first_name))='hunoldalexander';

2. Sa se listeze codul departamentului, numele departamentului si codul managerului de departament. In cazul in care un departament nu are manager se va afisa mesajul:
?Departamentul <department_id> nu are manager? (ex: Departamentul 120 nu are manager). Coloana se va numi ?Manageri departamente?. 
De asemenea, in cadrul aceleiasi cereri, sa se afiseze atat departamentele care au angajati, cat si cele fara angajati. 
In cazul in care un departament are angajati, se va afisa si codul acestor angajati (o coloana unde se vor afisa codurile de angajati pentru fiecare departament in parte).
Daca un departament nu are angajati, se va afisa mesajul: ?Departamentul nu are angajati?. Coloana se va numi ?Angajati departamente?. 
In final se vor afisa 4 coloane: department_id, department_name, Angajati departamente, Manageri departamente. 
In acest caz, fiind mai multe randuri returnate, atasati un singur print screen care sa cuprinda toate cele 4 coloane, dar doar ultimele 25 de inregistrari.


SELECT d.department_id, d.department_name, NVL(to_char(e.employee_id), 'Departamentul nu are angajati') "Angajati Departamente", 
    NVL(to_char(d.manager_id),concat(concat('Departamentul ',to_char(d.department_id)),' nu are manager')) "Manageri departamente"
FROM departments d LEFT JOIN employees e ON (d.department_id=e.department_id);



3. Sa se creeze tabelele urmatoare CAMPANIE_PNU si SPONSOR_PNU
Unde PNU se formeaza astfel:
? P -> prima litera din prenume
? NU -> primele doua litere din nume
CAMPANIE_PNU
 ( cod_campanie ? cheie primara,
 titlu -> titlul campaniei ? nu poate fi null,
 data_start -> data la care incepe campania ? are implicit
valoarea sysdate,
 data_end -> data la care se incheie campania ? este o data
inserata in momentul inserarii inregistrarii in baza de date; aceasta data trebuie
sa fie mai mare decat data_start,
 valoare -> pretul campaniei ? poate fi null,
 cod_sponsor ? cheie externa
 )

 
SPONSOR_PNU
 ( cod_sponsor ? cheie primara,
 nume -> denumirea sponsorului ? nu poate fi null si trebuie sa
aiba o valoare unica,
 email -> poate fi null si are o valoare unica
 )
 
 OBS:
Relatia dintre cele doua tabele este one-to-many -> un sponsor poate sponsoriza mai multe campanii, iar o campanie este sponsorizata doar de un singur sponsor.
Instructiunea commit se va rula doar unde este necesara stocarea datelor/modificarilor in baza de date sau doar acolo unde cerinta specifica acest lucru.
;

 CREATE TABLE SPONSOR_CCO
 (
    cod_sponsor NUMBER(3),
    constraint pk_sponsorr primary key(cod_sponsor),
    nume VARCHAR(20) constraint nume_unic_sponsorr unique 
                     constraint sponsor_not_nulll not null,
    email VARCHAR(20) constraint email_unic_sponsorr unique
 );
 CREATE TABLE CAMPANIE_CCO
 (
    cod_campanie NUMBER(3), 
    constraint pk_campaniee primary key(cod_campanie),
    titlu_campanie VARCHAR(26) constraint titlu_campanie_not_nulll not null,
    data_start date default sysdate,
    data_end DATE,
    constraint data_mai_mare_ca_data_startt check(data_end>data_start),
    valoare NUMBER(7),
    cod_sponsor NUMBER(3) constraint fk_cod_sponsorr references SPONSOR_CCO(cod_sponsor)
 );
 
desc SPONSOR_COCO;

drop table campanie_coco;

4. Sa se insereze in baza de date urmatoarele inregistrari, folosind la alegere metoda implicita sau explicita, precizand varianta aleasa.
SPONSOR;


--folosesc metoda explicita
INSERT INTO SPONSOR_CCO(cod_sponsor, nume, email)
VALUES
    (10, 'CISCO', 'cisco@gmail.com');
    (20, 'KFC', NULL);  
    (30, 'ADOBE', 'adobe@adobe.com');
    (40, 'BRD' ,NULL);
    (50, 'VODAFONE', 'vdf@gmail.com');
    (60, 'BCR', NULL);
    (70, 'SAMSUNG', NULL);
    (80, 'IBM', 'ibm@ibm.com');
    (90, 'OMV', NULL);
    (100, 'ENEL', NULL);
select * from SPONSOR_CCO;
--metoda implicita
INSERT INTO CAMPANIE_CCO
VALUES
    --(1, 'CAMP1', sysdate,  to_date('20-06-2023', 'dd-mm-yyyy'), 1200, 10);
    --(2, 'CAMP2', sysdate,  to_date('25-07-2023', 'dd-mm-yyyy'), 3400, 20);  
    --(3, 'CAMP3', sysdate,  to_date('10-06-2023', 'dd-mm-yyyy'), NULL, 30);
   -- (4, 'CAMP4', sysdate,  to_date('20-06-2023', 'dd-mm-yyyy'), NULL, 40);
    --(5, 'CAMP5', sysdate,  to_date('05-06-2023', 'dd-mm-yyyy'), 2200, 50);
    --(6, 'CAMP6', sysdate,  to_date('15-08-2023', 'dd-mm-yyyy'), NULL, 60);
    --(7, 'CAMP7', sysdate,  to_date('02-09-2023', 'dd-mm-yyyy'), 5500, 70);
    --(8, 'CAMP8', sysdate,  to_date('10-10-2023', 'dd-mm-yyyy'), NULL, 20);
    --(9, 'CAMP9', sysdate,  to_date('10-06-2023', 'dd-mm-yyyy'), 4000, 30);
    (10, 'CAMP10', sysdate, to_date('25-09-2023', 'dd-mm-yyyy'), 3500, NULL);

select * from campanie_cco;
commit;

cod_sponsor nume email
10 CISCO cisco@gmail.com
20 KFC NULL
30 ADOBE adobe@adobe.com
40 BRD NULL
50 VODAFONE vdf@gmail.com
60 BCR NULL
70 SAMSUNG NULL
80 IBM ibm@ibm.com
90 OMV NULL
100 ENEL NULL
CAMPANIE
cod_campanie titlu data_start data_end valoare cod_sponsor
1 CAMP1 sysdate 20-06-2023 1200 10
2 CAMP2 sysdate 25-07-2023 3400 20
3 CAMP3 sysdate 10-06-2023 NULL 30
4 CAMP4 sysdate 20-06-2023 NULL 40
5 CAMP5 sysdate 05-06-2023 2200 50
6 CAMP6 sysdate 15-08-2023 NULL 60
7 CAMP7 sysdate 02-09-2023 5500 70
8 CAMP8 sysdate 10-10-2023 NULL 20
9 CAMP9 sysdate 10-06-2023 4000 30
10 CAMP10 sysdate 25-09-2023 3500 NULL
Dupa inserare se vor selecta toate campaniile (SELECT * FROM campanie), dupa care toti sponsorii (SELECT * FROM sponsor) 
si se vor adauga in document print screen-uri cu output-ul din SQL Developer.



5. Sa se stearga campaniile care vor expira inainte de data 01-07-2023.
Se va adauga un print screen cu rezultatele ramase in urma stergerii, dupa care se vor anula modificarile.

DELETE FROM CAMPANIE_CCO
WHERE data_end<to_date('01-07-2023','dd-mm-yyyy');
select* from campanie_cco;
rollback;

6. Sa se modifice valoarea tuturor campaniilor, aplicandu-se o majorare cu 25%. Daca o campanie nu are valoare, atunci ea este o campanie caritabila si se va completa cu textul
?Campanie Caritabila?. Se va atasa in document un print cu valorile modificate (output-ul dupa rulare) dupa care se vor anula modificarile.

ALTER TABLE CAMPANIE_CCO
DROP COLUMN valoare;
ALTER TABLE CAMPANIE_CCO
ADD valoare VARCHAR(10);

UPDATE CAMPANIE_CCO
SET valoare= 1200
WHERE cod_campanie=1;

UPDATE CAMPANIE_CCO
SET valoare= 3400
WHERE cod_campanie=2;

UPDATE CAMPANIE_CCO
SET valoare= NULL
WHERE cod_campanie=3;

UPDATE CAMPANIE_CCO
SET valoare= NULL
WHERE cod_campanie=4;

UPDATE CAMPANIE_CCO
SET valoare= 2200
WHERE cod_campanie=5;

UPDATE CAMPANIE_CCO
SET valoare= NULL
WHERE cod_campanie=6;

UPDATE CAMPANIE_CCO
SET valoare= 5500
WHERE cod_campanie=7;

UPDATE CAMPANIE_CCO
SET valoare= NULL
WHERE cod_campanie=8;

UPDATE CAMPANIE_CCO
SET valoare= 4000
WHERE cod_campanie=9;

UPDATE CAMPANIE_CCO
SET valoare= 3500
WHERE cod_campanie=10;

select* from campanie_cco;

ALTER TABLE CAMPANIE_CCO
MODIFY valoare VARCHAR(25);

UPDATE CAMPANIE_CCO
SET valoare= (NVL(to_char(1.25*to_number(valoare)),'Campanie Caritabila'));

select* from CAMPANIE_CCO;
rollback;

7. Sa se stearga sponsorul 20 din baza de date. Explicati in cuvinte pasii necesari rezolvarii cu succes a cerintei. Dupa stergere anulati modificarile.

select * from sponsor_cco;

UPDATE CAMPANIE_CCO
SET cod_sponsor=NULL
WHERE cod_sponsor=20;

DELETE FROM SPONSOR_CCO WHERE cod_sponsor=20;

rollback;
commit;


8. Stergeti sponsorii care nu sponsorizeaza nicio campanie. Dupa stergere realizati un print screen output-ului (SELECT * FROM sponsor), dupa care salvati modificarile. 

SELECT * FROM SPONSOR_CCO;

ALTER TABLE SPONSOR_CCO
ADD are_campanii NUMBER(2) default 0;

ALTER TABLE SPONSOR_CCO
DROP COLUMN are_campanii;

UPDATE SPONSOR_CCO
SET are_campanii=1
WHERE cod_sponsor in (select cod_sponsor from CAMPANIE_CCO);

delete FROM SPONSOR_CCO WHERE are_campanii=0;
commit;


