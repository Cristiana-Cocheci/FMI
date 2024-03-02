set serveroutput on
CREATE TABLE info_dept_cco(
    id NUMBER(10) PRIMARY KEY,
    nume_dept VARCHAR2(40),
    plati NUMBER(10)
);
/
CREATE OR REPLACE PROCEDURE modific_plati_cco
(v_codd info_dept_cco.id%TYPE, v_plati info_dept_cco.plati%TYPE) AS
BEGIN
UPDATE info_dept_cco
SET plati = NVL (plati, 0) + v_plati
WHERE id = v_codd;
END;
/
CREATE OR REPLACE TRIGGER trig4_cco
AFTER DELETE OR UPDATE OR INSERT OF salary ON emp_cco
FOR EACH ROW
BEGIN
IF DELETING THEN
-- se sterge un angajat
modific_plati_cco (:OLD.department_id, -1*:OLD.salary);
ELSIF UPDATING THEN
--se modifica salariul unui angajat
modific_plati_cco(:OLD.department_id,:NEW.salary-:OLD.salary);
ELSE
-- se introduce un nou angajat
modific_plati_cco(:NEW.department_id, :NEW.salary);
END IF;
END;
/

INSERT INTO info_dept_cco VALUES (90, 'SA_REP', 0);
SELECT * FROM info_dept_cco WHERE id=90;
INSERT INTO emp_cco (employee_id, last_name, email, hire_date,
job_id, salary, department_id)
VALUES (300, 'N1', 'n1@g.com',sysdate, 'SA_REP', 2000, 90);
commit;
/
select * from emp_cco;
CREATE TABLE dept_cco AS (select * from departments);
select * from dept_cco;
delete from emp_cco;
drop table emp_cco;
CREATE TABLE emp_cco AS(select * from employees);
alter table emp_cco disable all triggers;

/
CREATE OR REPLACE PACKAGE pachet_ang_dep_cco AS
    TYPE tip_rec IS RECORD
		(dep dept_cco.department_id%TYPE, nr NUMBER(10));
	TYPE tabel_dep IS TABLE OF tip_rec INDEX BY PLS_INTEGER;
	t tabel_dep;
    
    TYPE tab2 IS TABLE OF NUMBER INDEX BY BINARY_INTEGER;
    t2 tab2;
    
    CURSOR c_dept IS (select department_id from dept_cco);
END;
/
CREATE OR REPLACE TRIGGER trg_E4_cco 
BEFORE INSERT OR UPDATE OF department_id ON emp_cco
DECLARE v NUMBER;
BEGIN
    select department_id d, count(*)
    BULK COLLECT INTO pachet_ang_dep_cco.t
    from emp_cco
    group by department_id;
     OPEN pachet_ang_dep_cco.c_dept;
        LOOP
            FETCH pachet_ang_dep_cco.c_dept INTO v;
            EXIT WHEN pachet_ang_dep_cco.c_dept%NOTFOUND;
            pachet_ang_dep_cco.t2(v):=0;
        END LOOP;  
        CLOSE pachet_ang_dep_cco.c_dept;
END;
/
CREATE OR REPLACE TRIGGER trg_E4_2_cco 
	BEFORE INSERT OR UPDATE OF d epartment_id ON emp_cco
	FOR EACH ROW
BEGIN
	FOR i IN 1..pachet_ang_dep_cco.t.LAST LOOP
		IF pachet_ang_dep_cco.t(i).dep=:NEW.department_id AND pachet_ang_dep_cco.t(i).nr + pachet_ang_dep_cco.t2(:NEW.department_id)=45 THEN
			RAISE_APPLICATION_ERROR(-20000,'Dep '||:NEW.department_id||'  depaseste numarul '||
				' maxim de angajati');
		END IF;
	END LOOP;
    pachet_ang_dep_cco.t2(:NEW.department_id):=1+pachet_ang_dep_cco.t2(:NEW.department_id);
END;
/
select department_id d, count(*)
    
    from emp_cco
    group by department_id;
INSERT INTO emp_cco VALUES (300,'a','b','ab','0',sysdate,'10',5,null,100,50);
INSERT INTO emp_cco SELECT 300,'a','b','ab','0',sysdate,'10',5,null,100,50 FROM DUAL;
UPDATE emp_cco SET department_id =50;
UPDATE emp_cco SET department_id=80 WHERE department_id = 100 OR department_id =30;
rollback;
/
/*
-- o solutie ar fi consultarea unei copii a tabelului clienti_au_pret_preferential, neindicata
-- alta adaugarea clauzei pragma autonomous_transaction, neindicata
-- Varianta 2 pachet si 2 trigger-i,
-- Varianta 3 trigger compus

CREATE OR REPLACE TRIGGER trig_17_tranzactie_autonoma
	BEFORE INSERT OR UPDATE OF id_client_j ON clienti_au_pret_preferential
	FOR EACH ROW
DECLARE
	PRAGMA AUTONOMOUS_TRANSACTION;
	nr NUMBER(1);
BEGIN
	SELECT COUNT(*) INTO nr
	FROM clienti_au_pret_preferential
	WHERE id_client_j=:NEW.id_client_j;
	--AND EXTRACT(YEAR FROM data_in)=EXTRACT(YEAR FROM SYSDATE);

	IF nr=3 THEN
		RAISE_APPLICATION_ERROR(-20000,'Clientul are deja numarul maxim de promotii permis anual');
	END IF;
END;
/
--executare operatii insert si update anterioare
--Ce se intampla cu operatiile pt. id_client_j = 12?
--Sunt permise inserari/actualizari chiar daca nr. de promotii depaseste 3!!!

ALTER TRIGGER trig_17_tranzactie_autonoma DISABLE;
*/

--Varianta 2
CREATE OR REPLACE PACKAGE pachet
AS
	TYPE tip_rec IS RECORD
		(id clienti_au_pret_preferential.id_client_j%TYPE, nr NUMBER(1));
	TYPE tip_ind IS TABLE OF tip_rec INDEX BY PLS_INTEGER;
	t tip_ind;
	contor NUMBER(2):=0;
END;
/

CREATE OR REPLACE TRIGGER trig_17_comanda
	BEFORE INSERT OR UPDATE OF id_client_j ON clienti_au_pret_preferential
BEGIN
	pachet.contor:=0;
	SELECT id_client_j, COUNT(*)
	BULK COLLECT INTO pachet.t
	FROM clienti_au_pret_preferential
	--WHERE EXTRACT(YEAR FROM data_in)=EXTRACT(YEAR FROM SYSDATE)
	GROUP BY id_client_j;
END;
/

CREATE OR REPLACE TRIGGER trig_17_linie
	BEFORE INSERT OR UPDATE OF id_client_j ON clienti_au_pret_preferential
	FOR EACH ROW
BEGIN
	FOR i IN 1..pachet.t.LAST LOOP
		IF pachet.t(i).id=:NEW.id_client_j AND pachet.t(i).nr+pachet.contor=3 THEN
			RAISE_APPLICATION_ERROR(-20000,'Clientul '||:NEW.id_client_j||'  depaseste numarul '||
				' maxim de promotii permise anual');
		END IF;
	END LOOP;
	pachet.contor:=pachet.contor+1;
END;
/

--linia este inserata
INSERT INTO clienti_au_pret_preferential(id_pret_pref,discount,data_in,data_sf,
id_categorie,id_client_j)
VALUES (102,0.1,SYSDATE,SYSDATE+30,1,11);

--linia este inserata
INSERT INTO clienti_au_pret_preferential(id_pret_pref,discount,data_in,data_sf,
id_categorie,id_client_j)
SELECT 103,0.1,SYSDATE,SYSDATE+30,2,11
FROM dual;

--se depaseste limita impusa;
--apare mesajul din trigger
SELECT *
FROM USER_CONSTRAINTS
WHERE lower(TABLE_NAME) = 'clienti_au_pret_preferential';

ALTER TABLE clienti_au_pret_preferential
DROP CONSTRAINT clienti_au_pret_pref_pk;

INSERT INTO clienti_au_pret_preferential
SELECT * FROM clienti_au_pret_preferential;

UPDATE clienti_au_pret_preferential
SET id_client_j=12
WHERE id_client_j=11;

UPDATE clienti_au_pret_preferential
SET id_client_j=2
WHERE id_client_j IN (10,11,12);

DELETE FROM clienti_au_pret_preferential
WHERE id_pret_pref IN (102,103);
COMMIT;

ALTER TABLE CLIENTI_AU_PRET_PREFERENTIAL
ADD CONSTRAINT clienti_au_pret_pref_pk
    PRIMARY KEY(id_pret_pref,id_categorie,id_client_j);

ALTER TRIGGER trig_17_comanda DISABLE;
ALTER TRIGGER trig_17_linie DISABLE;

--Varianta 3
CREATE OR REPLACE TRIGGER trig_17_compus
    FOR INSERT OR UPDATE OF id_client_j ON clienti_au_pret_preferential
COMPOUND TRIGGER
	TYPE tip_rec IS RECORD
		(id clienti_au_pret_preferential.id_client_j%TYPE, nr NUMBER(1));
	TYPE tip_ind IS TABLE OF tip_rec INDEX BY PLS_INTEGER;
	t tip_ind;
	contor NUMBER(2):=0;
    BEFORE STATEMENT IS
    BEGIN
    	contor:=0;
        SELECT id_client_j, COUNT(*)
        BULK COLLECT INTO t
        FROM clienti_au_pret_preferential
        --WHERE EXTRACT(YEAR FROM data_in)=EXTRACT(YEAR FROM SYSDATE)
        GROUP BY id_client_j;
    END BEFORE STATEMENT;
    BEFORE EACH ROW IS
    BEGIN
        FOR i IN 1..t.LAST LOOP
            IF t(i).id=:NEW.id_client_j AND t(i).nr+contor=3 THEN
                RAISE_APPLICATION_ERROR(-20000,'Clientul '||:NEW.id_client_j||'  depaseste numarul '||
                    ' maxim de promotii permise anual');
		    END IF;
	    END LOOP;
	    contor:=contor+1;
    END BEFORE EACH ROW;
END trig_17_compus;
/

ALTER TRIGGER trig_17_compus DISABLE;
-------------------------