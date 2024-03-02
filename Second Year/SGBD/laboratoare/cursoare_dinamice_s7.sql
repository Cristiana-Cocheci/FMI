--Cursoare dinamice
--Exercitii bazate pe schema companie comerciala - prezentata la curs.
--
--1. Enun?a?i o cerere în limbaj natural pe schema, 
--care s? implice în rezolvare utilizarea unui cursor dinamic. 
--Scrie?i un subprogram care utilizeaz? acest cursor. 
--Vor fi afi?ate informa?iile din cel pu?in dou? coloane returnate de cursor. 
--Trata?i erorile care pot s? apar? la apelare. Testa?i.
--
--Cu ajutorul unui cursor dinamic gasiti toate facturile care au 
-- fost emise de casa p, unde p este citit de la user;
-- Definiti o procedura care dubleaza cantitatea si pretul de pe o factura 
-- data ca parametru de intrare (in tabelul facturi_contin_produse)
/
CREATE OR REPLACE PROCEDURE proc_tema_curs_din
	(v_id IN facturi.id_factura%TYPE)
AS
	exceptie EXCEPTION;
BEGIN
	UPDATE facturi_contin_produse
	SET cantitate= cantitate*2
    WHERE id_factura=v_id;
    UPDATE facturi_contin_produse
	SET pret_facturare= pret_facturare*2
    WHERE id_factura=v_id;
	IF SQL%NOTFOUND THEN
		RAISE exceptie;
	END IF;
	EXCEPTION
		WHEN exceptie THEN
			RAISE_APPLICATION_ERROR(-20000,'Nu exista factura');
END;
/
rollback;
DECLARE
	TYPE cursor_dinamic IS REF CURSOR;
	c cursor_dinamic;
	v_optiune NUMBER(1):=&p_casa;
	i facturi.id_factura%type;
    j facturi_contin_produse.cantitate%type;
    k facturi_contin_produse.pret_facturare%type;
BEGIN
	OPEN c FOR
		'SELECT f.id_factura, cantitate, pret_facturare
		 FROM facturi f join facturi_contin_produse fcp on (f.id_factura = fcp.id_factura)
		 WHERE id_casa = :v'
		 USING v_optiune;
	LOOP
		FETCH c INTO i,j,k;
		EXIT WHEN c%NOTFOUND;
		DBMS_OUTPUT.PUT_LINE('Factura: '||i ||', Cantitate initiala: '||j||', Pret initial: '||k);
        proc_tema_curs_din(i);
    END LOOP;
CLOSE c;
 OPEN c FOR
		'SELECT f.id_factura, cantitate, pret_facturare
		 FROM facturi f join facturi_contin_produse fcp on (f.id_factura = fcp.id_factura)
		 WHERE id_casa = :v'
		 USING v_optiune;
	LOOP
		FETCH c INTO i,j,k;
		EXIT WHEN c%NOTFOUND;
		DBMS_OUTPUT.PUT_LINE('Factura: '||i ||', Cantitate finala: '||j||', Pret final: '||k);

    END LOOP;
CLOSE c;
END;
/
select * from facturi_contin_produse;

--2. Defini?i un bloc PL/SQL în care procedura proc_ex2 
--(Exemplul 6.2 din SGBD6 - PLSQL Subprograme.pdf) este 
--apelat? pentru fiecare produs din categoria 'it' (nivel 1). 
--Pre?ul acestor produse va fi mic?orat cu 5%.
--Exemplul 6.2
/
CREATE OR REPLACE PROCEDURE proc_ex2
	(v_id IN produse.id_produs%TYPE, v_procent NUMBER)
AS
	exceptie EXCEPTION;
BEGIN
	UPDATE produse
	SET pret_unitar= pret_unitar*(1+v_procent)
	WHERE id_produs=v_id;
	IF SQL%NOTFOUND THEN
		RAISE exceptie;
	END IF;
	EXCEPTION
		WHEN exceptie THEN
			RAISE_APPLICATION_ERROR(-20000,'Nu exista produsul');
END;
/
DECLARE
    v_id produse.id_produs%TYPE;
    CURSOR produse_it 
    IS 
        SELECT id_produs from produse 
        where id_categorie =(select id_categorie 
                    from categorii
                    where denumire='it');
BEGIN
    OPEN produse_it;
    LOOP
        FETCH produse_it INTO v_id;
        EXIT WHEN produse_it%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('id: '||v_id);
        proc_ex2(v_id,-0.05);
    END LOOP;
    CLOSE produse_it;
END;
/
select * from produse
where id_produs=1;
rollback;
/
DECLARE
    /*TYPE vect_date IS TABLE OF Date;
    v_dates vect_date */
    v_data Date ;
BEGIN
    FOR i in 1..15 LOOP
        DBMS_OUTPUT.PUT_LINE(v_data);
        SELECT TRUNC(v_data,1, v_data) 
        INTO v_data FROM DUAL;
    END LOOP;
END;
/
SELECT EXTRACT(DAY FROM sysdate) FROM dual;
DECLARE
    CURSOR hackers IS 
                    SELECT hacker_id 
                    FROM SUBMISSIONS
                    GROUP BY hacker_id
                    HAVING count(DISTINCT submission_date)=15;
    TYPE cursor_results_day IS REF CURSOR;
    c cursor_results_day;
    TYPE vect AS VARRAY OF hackers.hacker_id%TYPE;
    v_date DATE;
    v_nr NUMBER;
    v_id hackers.hacker_id%TYPE;
    v_name hackers.name%TYPE;
    v_max NUMBER ;
BEGIN
    OPEN hackers;
    FETCH hackers BULK COLLECT INTO vect;
    CLOSE HACKERS;
    FOR i in 1..15 LOOP
        OPEN c FOR
            'SELECT hacker_id, COUNT(*) count
            FROM SUBMISSIONS
            WHERE hacker_id IN hackers
            GROUP BY hacker_id
            HAVING EXTRACT(DAY FROM sumission_date) = :v_i;'
            USING i;
        v_nr:=0;
        v_max:=0;
        FOR h in c LOOP
            EXIT WHEN c%NOTFOUND;
            v_nr:=v_nr+1;
            IF h.count>v_max THEN
                v_max:=h.count;
                v_id:=h.hacker_id;
            END IF;
        END LOOP;
        CLOSE c;
        SELECT submission_date INTO v_date
        FROM SUBMISSIONS
        WHERE EXTRACT(DAY FROM sumission_date) =i;
        SELECT name INTO v_name
        FROM hackers
        WHERE hacker_id = v_id;
        DBMS_OUTPUT.PUT_LINE(v_date || ' ' || v_nr || ' ' || v_id || ' ' || v_name);
    END LOOP;
END;
/