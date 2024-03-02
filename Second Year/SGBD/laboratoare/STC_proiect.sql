SET SERVEROUTPUT ON
/
CREATE OR REPLACE FUNCTION exista_angajat(v_nume_ang angajati_stc.nume%TYPE) RETURN BOOLEAN 
AS v_cnt NUMBER; 
BEGIN
    SELECT count(*) INTO v_cnt
    FROM ANGAJATI_STC
    WHERE upper(nume) = upper(v_nume_ang);
    
    IF v_cnt > 0 THEN RETURN TRUE;
    ELSE RETURN FALSE;
    END IF;
END;
/
declare 
v_a BOOLEAN;
begin
 v_a:=exista_angajat('Dionys');
 DBMS_OUTPUT.PUT_LINE(sys.diutil.bool_to_int(v_a));
end;
/
/*exercitiul 7 cursoare*/
CREATE OR REPLACE PROCEDURE proiect_lungime_trasee
        (v_nume_ang IN angajati_stc.nume%TYPE)
AS
    TYPE cursor2 IS REF CURSOR;
    c2 cursor2;
    CURSOR c1 (v_subordonati angajati_stc.cod_angajat%TYPE) IS
            (select distinct s.cod_statie, nume_statie, s.cod_traseu
            from vehicul_traseu_sofer vts join trasee_stc t on (vts.cod_traseu= t.cod_traseu) 
                    join statie_unica_stc s on (s.cod_traseu= t.cod_traseu) 
                    join angajati_stc a on (vts.cod_angajat= a.cod_angajat) 
                    join statii_stc st on (st.cod_statie = s.cod_statie)
            where a.cod_angajat =v_subordonati);
       

    statie statie_unica_stc.cod_statie%TYPE;
    nume_statie statii_stc.nume_statie%TYPE;
    cod_traseu trasee_stc.cod_traseu%TYPE;
    
    subo angajati_stc.cod_angajat%TYPE;
    cod_sef angajati_stc.cod_angajat%TYPE;
    lungime_trasee NUMBER;
    ok BOOLEAN;
    exceptie_ang EXCEPTION;

BEGIN
    ok:=exista_angajat(v_nume_ang);
    IF ok=FALSE then raise exceptie_ang; END IF;
    
    SELECT cod_angajat INTO cod_sef
    FROM ANGAJATI_STC
    WHERE upper(nume) = upper(v_nume_ang);

    OPEN c2 FOR
        'SELECT cod_angajat
        FROM ANGAJATI_STC
        WHERE cod_sef = :v_cod_sef'
        USING cod_sef;
    
    LOOP
		FETCH c2 INTO subo;
		EXIT WHEN c2%NOTFOUND;
		DBMS_OUTPUT.PUT_LINE('Angajatul: '|| subo);

        OPEN c1(subo);
        LOOP
            FETCH c1 INTO statie, nume_statie, cod_traseu;
            EXIT WHEN c1%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE('Statia: ' || statie ||' '||nume_statie|| ', din traseul: ' ||cod_traseu);
        END LOOP;
        IF c1%ROWCOUNT=0 THEN
            DBMS_OUTPUT.PUT_LINE('Acest angajat nu conduce pe niciun traseu');
        ELSE 
            SELECT sum(lungime) INTO lungime_trasee
            FROM trasee_stc WHERE cod_traseu IN
            (
                select distinct s.cod_traseu
                from vehicul_traseu_sofer vts join trasee_stc t on (vts.cod_traseu= t.cod_traseu) 
                        join statie_unica_stc s on (s.cod_traseu= t.cod_traseu) 
                        join angajati_stc a on (vts.cod_angajat= a.cod_angajat) 
                        join statii_stc st on (st.cod_statie = s.cod_statie)
                where a.cod_angajat =subo
            );           
            
            DBMS_OUTPUT.PUT_LINE('Suma lungimilor traseelor parcurse de acest angajat este: ' || lungime_trasee);
        END IF;
        CLOSE c1;
    END LOOP;
    IF c2%ROWCOUNT=0 THEN
        DBMS_OUTPUT.PUT_LINE('Nu am gasit niciun subordonat al lui' || v_nume_ang);
    END IF;
    CLOSE c2;
    EXCEPTION
        WHEN exceptie_ang THEN
            DBMS_OUTPUT.PUT_LINE('Nu am gasit angajat cu numele ' || v_nume_ang);
        WHEN too_many_rows THEN
            DBMS_OUTPUT.PUT_LINE('Prea multi angajati cu numele ' || v_nume_ang);
END;
/
select * from angajati_stc;
/
/*apel ex 7*/
DECLARE 
    v_nume angajati_stc.nume%TYPE;
    cod_sef angajati_stc.cod_angajat%TYPE;
BEGIN
    v_nume :='Dionys';
    proiect_lungime_trasee(v_nume);
END;
/
select distinct s.cod_statie 
from vehicul_traseu_sofer vts join trasee_stc t on (vts.cod_traseu= t.cod_traseu) 
        join statie_unica_stc s on (s.cod_traseu= t.cod_traseu) 
        join angajati_stc a on (vts.cod_angajat= a.cod_angajat) 
where a.cod_angajat ='A4';/*in (select cod_angajat 
                        from angajati_stc 
                        where cod_sef = (select cod_angajat 
                        from angajati_stc a
                        where upper(nume)='DIONYS'));*/ --subordonati
/
select * from angajati_stc;
select * from vehicul_traseu_sofer;
insert into vehicul_traseu_sofer VALUES('A4','B-66-MIC','T3');
select * from vehicule_stc;
select * from trasee_stc;
select * from sofer_stc;
insert into sofer_stc VALUES('A4', 'permis_special');
commit;
/
/*exercitiul 6 colectii*/
CREATE OR REPLACE PROCEDURE colectii_ex_proiect (v_numar NUMBER)
AS
--procedura afla un tablou_indexat al angajatilor cu cel putin 3 vehicule
    TYPE record_nr_traseu IS RECORD 
        (nr_inmatriculare vehicul_traseu_sofer.nr_inmatriculare%TYPE,
        traseu vehicul_traseu_sofer.cod_traseu%TYPE);
            
    TYPE tablou_imbricat IS TABLE OF record_nr_traseu;
    TYPE tablou_indexat IS TABLE OF tablou_imbricat 
                        INDEX BY angajati_stc.cod_angajat%TYPE;
    TYPE vector IS VARRAY(26) OF angajati_stc.cod_angajat%TYPE; --numar de angajati din baza de date
    ang vector:=vector(26);
    ang_vehicule_indx tablou_indexat;
    recs tablou_imbricat;
    angajat angajati_stc.cod_angajat%TYPE;
    exceptie EXCEPTION;
BEGIN
    SELECT cod_angajat 
    BULK COLLECT INTO ang
    FROM angajati_stc;
    
    FOR i IN 1..ang.COUNT LOOP  
        recs:= tablou_imbricat();
        SELECT nr_inmatriculare, cod_traseu
        BULK COLLECT INTO recs
        FROM vehicul_traseu_sofer
        WHERE cod_angajat = ang(i);
        
        IF recs.count >=v_numar THEN
            ang_vehicule_indx(ang(i)) := recs;
        END IF;

    END LOOP;
    
    IF ang_vehicule_indx.COUNT = 0 THEN
        raise exceptie;
    END IF;
    angajat:= ang_vehicule_indx.FIRST;
    WHILE angajat != ang_vehicule_indx.LAST LOOP  
        DBMS_OUTPUT.PUT_LINE('Cod Angajat: ' || angajat);
        FOR j IN ang_vehicule_indx(angajat).FIRST .. ang_vehicule_indx(angajat).LAST LOOP
            DBMS_OUTPUT.PUT_LINE('  Vehicul: ' || ang_vehicule_indx(angajat)(j).nr_inmatriculare || ', Traseu: ' ||ang_vehicule_indx(angajat)(j).traseu );
        END LOOP;
        angajat := ang_vehicule_indx.NEXT (angajat);
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('Cod Angajat: ' || angajat);
        FOR j IN ang_vehicule_indx(angajat).FIRST .. ang_vehicule_indx(angajat).LAST LOOP
            DBMS_OUTPUT.PUT_LINE('  Vehicul: ' || ang_vehicule_indx(angajat)(j).nr_inmatriculare || ', Traseu: ' ||ang_vehicule_indx(angajat)(j).traseu );
        END LOOP;
    EXCEPTION
        WHEN exceptie THEN
        DBMS_OUTPUT.PUT_LINE('Nu exista astfel de angajati');
END colectii_ex_proiect;
/
/*apel ex 6*/
BEGIN
    colectii_ex_proiect(1);
    colectii_ex_proiect(5); --o sa dea exceptie
END;
/
select * from trasee_stc;
select distinct s.cod_statie, nume_statie, s.cod_traseu
            from vehicul_traseu_sofer vts join trasee_stc t on (vts.cod_traseu= t.cod_traseu) 
                    join statie_unica_stc s on (s.cod_traseu= t.cod_traseu) 
                    join angajati_stc a on (vts.cod_angajat= a.cod_angajat) 
                    join statii_stc st on (st.cod_statie = s.cod_statie)
            where a.cod_angajat ='A16';

/
--Pentru o sectie data sa se afle toate locatiile filialelor acesteia. 
-- Sa se returneze codurile postale ale locatiilor intr-un string.
/*exercitiul 8 functie*/
CREATE OR REPLACE FUNCTION functie_proiect_coduri_postale
 (v_sectie sectii_stc.nume_sectie%TYPE DEFAULT 'autobuz')
RETURN VARCHAR2 AS
    coduri_postale VARCHAR2(1000);
    niciunCod EXCEPTION;
    sectieGresita EXCEPTION;
    v_count NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO v_count
    FROM sectii_stc
    WHERE lower(nume_sectie) = lower(v_sectie);

    IF v_count = 0 THEN
        RAISE sectieGresita;
    END IF;

    FOR coduri IN 
        (SELECT distinct cod_postal 
         FROM locatii_stc l join filiale_stc f on (l.cod_locatie = f.cod_locatie)
                            join sectii_stc s on (s.cod_sectie = f.cod_sectie)
         WHERE lower(v_sectie) = lower(nume_sectie)) LOOP
            coduri_postale := coduri_postale || coduri.cod_postal || ', ';
         END LOOP;
        IF coduri_postale IS NOT NULL THEN
            coduri_postale := RTRIM(coduri_postale, ', ');
        ELSE
            RAISE niciunCod;
        END IF;

    RETURN coduri_postale;
    
    EXCEPTION
    WHEN sectieGresita THEN
        DBMS_OUTPUT.PUT_LINE('Exceptie: Nu exista o sectie cu acest nume: ' || v_sectie);
        RETURN NULL;
    WHEN niciunCod THEN
        DBMS_OUTPUT.PUT_LINE('Exceptie: Nu exista coduri postale pentru sectia ' || v_sectie);
        RETURN NULL;
    WHEN too_many_rows THEN
        DBMS_OUTPUT.PUT_LINE('Exceptie: Prea multe sectii cu numele ' || v_sectie);
        RETURN NULL;
        
END functie_proiect_coduri_postale;
/
/*apel ex 8*/
DECLARE
    CoduriLocatii VARCHAR2(1000);
    v_sectie Varchar2(20);
BEGIN
    v_sectie :='autobuz';
    CoduriLocatii := functie_proiect_coduri_postale(v_sectie);
    
    DBMS_OUTPUT.PUT_LINE('Pentru sectia ' || v_sectie || ' exista aceste coduri postale: ' || CoduriLocatii);
END;
/
select * from departament_transport_stc;
select * from sectii_stc;
select * from locatii_stc;
select * from filiale_stc;
select * from joburi_stc;
select * from sofer_stc;
select * from angajati_stc;
--Pentru fiecare departament de transport sa se afiseze 
--angajatii sai, daca sunt sau nu soferi si numarul total de roti ale vehiculelor pe care le conduc in prezent
/
CREATE OR REPLACE FUNCTION este_sofer (v_cod_ang angajati_stc.cod_angajat%TYPE)
RETURN VARCHAR2 AS rez NUMBER;
BEGIN
    SELECT count(*) INTO rez
    FROM sofer_stc
    WHERE cod_angajat = v_cod_ang;
    IF rez = 0 THEN
        RETURN 'nu';
    else
        RETURN 'da';
    END IF;
END este_sofer;
/
/*exercitiul 9 5 tabele*/
CREATE OR REPLACE PROCEDURE numar_roti_procedura_proiect
AS
    CURSOR departamente IS (SELECT * FROM departament_transport_stc);

    v_bool VARCHAR2(2);
    numar_roti NUMBER;
BEGIN
    FOR dep IN departamente LOOP
        DBMS_OUTPUT.PUT_LINE('Departamentul ' || dep.nume_departament);
        
        FOR ang in (SELECT cod_angajat, nume
                    FROM angajati_stc a JOIN sectii_stc s ON (a.cod_sectie = s.cod_sectie)
                    WHERE tip_transport = dep.tip_transport) LOOP
            v_bool := este_sofer(ang.cod_angajat);
            DBMS_OUTPUT.PUT_LINE('- ' || ang.cod_angajat || ' ' || ang.nume || ', este sofer: ' ||v_bool);  
            IF v_bool = 'da' THEN
                select sum(nr_roti) INTO numar_roti
                from(
                    select  distinct v.nr_inmatriculare, nr_roti, c.cod_caract, nvl(data_expirare,sysdate+1) exp
                    from vehicul_traseu_sofer v 
                        join vehicule_stc  v2 on (v.nr_inmatriculare= v2.nr_inmatriculare)
                        join tipuri_vehicule_stc tv on (v2.cod_tip_vehicul=tv.cod_tip_vehicul)
                        join caracteristica_tip c on (tv.cod_tip_vehicul=c.cod_tip_vehicul)
                        join caracteristici_stc car on (car.cod_caract=c.cod_caract)
                    where nvl(data_expirare,sysdate+1)>sysdate --verificam ca inca conduce acest vehicul
                    AND cod_angajat = ang.cod_angajat
                );
                 DBMS_OUTPUT.PUT_LINE('numar roti: ' || numar_roti);  
            END IF;
        END LOOP;
        
    END LOOP;

END numar_roti_procedura_proiect;
/

CREATE OR REPLACE PROCEDURE numar_roti_procedura_proiect2 (nume_angajat angajati_stc.nume%TYPE)
AS
    
    cod_angajat angajati_stc.cod_angajat%TYPE;
    numar_roti NUMBER;
    v_sofer VARCHAR2(2);
    nu_e_sofer EXCEPTION;
    nu_e_angajat EXCEPTION;
BEGIN
        SELECT cod_angajat INTO cod_angajat
        FROM angajati_stc 
        WHERE upper(nume) = upper(nume_angajat);
        
        v_sofer := este_sofer(cod_angajat);
        DBMS_OUTPUT.PUT_LINE(cod_angajat);
        IF v_sofer = 'nu' THEN RAISE nu_e_sofer; END IF;
        
                select sum(nr_roti) INTO numar_roti
                from(
                    select  distinct v.nr_inmatriculare, nr_roti, c.cod_caract, nvl(data_expirare,sysdate+1) exp
                    from vehicul_traseu_sofer v 
                        join vehicule_stc  v2 on (v.nr_inmatriculare= v2.nr_inmatriculare)
                        join tipuri_vehicule_stc tv on (v2.cod_tip_vehicul=tv.cod_tip_vehicul)
                        join caracteristica_tip c on (tv.cod_tip_vehicul=c.cod_tip_vehicul)
                        join caracteristici_stc car on (car.cod_caract=c.cod_caract)
                    where nvl(data_expirare,sysdate+1)>sysdate --verificam ca inca conduce acest vehicul
                    AND cod_angajat = cod_angajat
                );
                 DBMS_OUTPUT.PUT_LINE('numar roti: ' || numar_roti);  

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE (' no data found: ' ||SQLCODE || ' - ' || SQLERRM);
    WHEN TOO_MANY_ROWS THEN
        DBMS_OUTPUT.PUT_LINE (' too many rows: ' ||SQLCODE || ' - ' || SQLERRM);
    WHEN nu_e_sofer THEN
         DBMS_OUTPUT.PUT_LINE (' angajatul cautat nu e sofer ' );
END numar_roti_procedura_proiect2;

/
/*apel ex 9*/
DECLARE 
cod_ang angajati_stc.cod_angajat%TYPE;
nr_roti NUMBER;
BEGIN
    cod_ang:='Yuri';
    numar_roti_procedura_proiect2(cod_ang);
    
END;
/
select * from tipuri_vehicule_stc;
select * from vehicule_stc;
select * from caracteristica_tip;
--trigger care nu te lasa sa stergi un vehicul care nu e expirat (are data_expirare = null)
/
/*trigger ex 11 lmd*/
CREATE OR REPLACE TRIGGER trigger_proiect_vehicule
    BEFORE DELETE ON vehicule_stc
    FOR EACH ROW
DECLARE
    data_expirare caracteristica_tip.data_expirare%type;
BEGIN
    SELECT min(nvl(data_expirare, TO_DATE('1-1-1','DD-MM-YYYY'))) INTO data_expirare
    FROM caracteristica_tip 
    WHERE cod_tip_vehicul = :OLD.cod_tip_vehicul;
    
    IF data_expirare = TO_DATE('1-1-1','DD-MM-YYYY') THEN
        RAISE_APPLICATION_ERROR(-20002,'vehiculul nu poate fi sters');
    END IF;
END;
/
select * from vehicule_stc;
DELETE FROM vehicule_stc
WHERE cod_tip_vehicul = 'TV6';
select * from sectii_stc;
/
/*ex 10 LMD*/

CREATE OR REPLACE TRIGGER inserturi_zile_impare_luni_pare_proiect
BEFORE INSERT OR UPDATE ON sectii_stc
DECLARE 
    v_zi NUMBER;
    v_luna NUMBER;
BEGIN
    SELECT EXTRACT(DAY from SYSDATE), EXTRACT(MONTH from SYSDATE)
    INTO v_zi, v_luna
    FROM dual;
    
    IF MOD(v_zi, 2) = 1 AND MOD(v_luna, 2) = 0 THEN
        RAISE_APPLICATION_ERROR (-20002, 'Azi e o zi impara intr-o luna para! Fara inserturi');
    END IF;
END inserturi_zile_impare_luni_pare_proiect;
/
select sysdate from dual;
INSERT INTO sectii_stc VALUES ('B1', 'A0', 'DT8', 'mmm');
/
CREATE SEQUENCE log_sequence
    START WITH 1
    MAXVALUE 99999999999999999999999999
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;

CREATE TABLE tabel_log_proiect(
   id_log NUMBER  DEFAULT log_sequence.NEXTVAL PRIMARY KEY,
   tip_operatie VARCHAR2(10),
    data_log TIMESTAMP default SYSTIMESTAMP,
    executat_de VARCHAR2(100)
);
ALTER TABLE tabel_log_proiect
MODIFY tip_operatie VARCHAR2(100);
/
/*ex 12 trigger*/
CREATE OR REPLACE TRIGGER trigger_log_LDD 
    AFTER CREATE OR ALTER OR DROP ON DATABASE
DECLARE
    v_user VARCHAR2(100);
BEGIN
    SELECT USER INTO v_user FROM dual;
    INSERT INTO tabel_log_proiect (tip_operatie, executat_de)
    VALUES (SYS.SYSEVENT, v_user);
END;
/
drop trigger trigger_log_LDD;
CREaTE TABLE testt (testt NUMBER DEFAULT 0);
select * from tabel_log_proiect;
drop table testt;
select to_char(sysdate,'dd-mm-yyyy, hh:mi:ss') from dual;
/
/*ex 13*/
CREATE OR REPLACE PACKAGE pachet_proiect_stc AS
    FUNCTION exista_angajat(v_nume_ang angajati_stc.nume%TYPE) 
        RETURN BOOLEAN;
    PROCEDURE colectii_ex_proiect(v_numar NUMBER);
    PROCEDURE proiect_lungime_trasee (v_nume_ang IN angajati_stc.nume%TYPE);
    FUNCTION functie_proiect_coduri_postale (v_sectie sectii_stc.nume_sectie%TYPE DEFAULT 'autobuz')
        RETURN VARCHAR2;
    FUNCTION este_sofer (v_cod_ang angajati_stc.cod_angajat%TYPE)
        RETURN VARCHAR2;
    PROCEDURE numar_roti_procedura_proiect2 (nume_angajat angajati_stc.nume%TYPE);
END pachet_proiect_stc;
/
CREATE OR REPLACE PACKAGE BODY pachet_proiect_stc AS
    FUNCTION exista_angajat(v_nume_ang angajati_stc.nume%TYPE) RETURN BOOLEAN 
    AS v_cnt NUMBER; 
    BEGIN
        SELECT count(*) INTO v_cnt
        FROM ANGAJATI_STC
        WHERE upper(nume) = upper(v_nume_ang);
        
        IF v_cnt > 0 THEN RETURN TRUE;
        ELSE RETURN FALSE;
        END IF;
    END;

/********************************/
    PROCEDURE colectii_ex_proiect (v_numar NUMBER)
    AS
    --procedura afla un tablou_indexat al angajatilor cu cel putin 3 vehicule
        TYPE record_nr_traseu IS RECORD 
            (nr_inmatriculare vehicul_traseu_sofer.nr_inmatriculare%TYPE,
            traseu vehicul_traseu_sofer.cod_traseu%TYPE);
                
        TYPE tablou_imbricat IS TABLE OF record_nr_traseu;
        TYPE tablou_indexat IS TABLE OF tablou_imbricat 
                            INDEX BY angajati_stc.cod_angajat%TYPE;
        TYPE vector IS VARRAY(26) OF angajati_stc.cod_angajat%TYPE; --numar de angajati din baza de date
        ang vector:=vector(26);
        ang_vehicule_indx tablou_indexat;
        recs tablou_imbricat;
        angajat angajati_stc.cod_angajat%TYPE;
        exceptie EXCEPTION;
    BEGIN
        SELECT cod_angajat 
        BULK COLLECT INTO ang
        FROM angajati_stc;
        
        FOR i IN 1..ang.COUNT LOOP  
            recs:= tablou_imbricat();
            SELECT nr_inmatriculare, cod_traseu
            BULK COLLECT INTO recs
            FROM vehicul_traseu_sofer
            WHERE cod_angajat = ang(i);
            
            IF recs.count >=v_numar THEN
                ang_vehicule_indx(ang(i)) := recs;
            END IF;
    
        END LOOP;
        
        IF ang_vehicule_indx.COUNT = 0 THEN
            raise exceptie;
        END IF;
        angajat:= ang_vehicule_indx.FIRST;
        WHILE angajat != ang_vehicule_indx.LAST LOOP  
            DBMS_OUTPUT.PUT_LINE('Cod Angajat: ' || angajat);
            FOR j IN ang_vehicule_indx(angajat).FIRST .. ang_vehicule_indx(angajat).LAST LOOP
                DBMS_OUTPUT.PUT_LINE('  Vehicul: ' || ang_vehicule_indx(angajat)(j).nr_inmatriculare || ', Traseu: ' ||ang_vehicule_indx(angajat)(j).traseu );
            END LOOP;
            angajat := ang_vehicule_indx.NEXT (angajat);
        END LOOP;
        DBMS_OUTPUT.PUT_LINE('Cod Angajat: ' || angajat);
            FOR j IN ang_vehicule_indx(angajat).FIRST .. ang_vehicule_indx(angajat).LAST LOOP
                DBMS_OUTPUT.PUT_LINE('  Vehicul: ' || ang_vehicule_indx(angajat)(j).nr_inmatriculare || ', Traseu: ' ||ang_vehicule_indx(angajat)(j).traseu );
            END LOOP;
        EXCEPTION
            WHEN exceptie THEN
            DBMS_OUTPUT.PUT_LINE('Nu exista astfel de angajati');
    END colectii_ex_proiect;

    /***********************/
    PROCEDURE proiect_lungime_trasee
        (v_nume_ang IN angajati_stc.nume%TYPE)
    AS
        TYPE cursor2 IS REF CURSOR;
        c2 cursor2;
        CURSOR c1 (v_subordonati angajati_stc.cod_angajat%TYPE) IS
                (select distinct s.cod_statie, nume_statie, s.cod_traseu
                from vehicul_traseu_sofer vts join trasee_stc t on (vts.cod_traseu= t.cod_traseu) 
                        join statie_unica_stc s on (s.cod_traseu= t.cod_traseu) 
                        join angajati_stc a on (vts.cod_angajat= a.cod_angajat) 
                        join statii_stc st on (st.cod_statie = s.cod_statie)
                where a.cod_angajat =v_subordonati);
           
    
        statie statie_unica_stc.cod_statie%TYPE;
        nume_statie statii_stc.nume_statie%TYPE;
        cod_traseu trasee_stc.cod_traseu%TYPE;
        
        subo angajati_stc.cod_angajat%TYPE;
        cod_sef angajati_stc.cod_angajat%TYPE;
        lungime_trasee NUMBER;
        ok BOOLEAN;
        exceptie_ang EXCEPTION;
    
    BEGIN
        ok:=exista_angajat(v_nume_ang);
        IF ok=FALSE then raise exceptie_ang; END IF;
        
        SELECT cod_angajat INTO cod_sef
        FROM ANGAJATI_STC
        WHERE upper(nume) = upper(v_nume_ang);
    
        OPEN c2 FOR
            'SELECT cod_angajat
            FROM ANGAJATI_STC
            WHERE cod_sef = :v_cod_sef'
            USING cod_sef;
        
        LOOP
            FETCH c2 INTO subo;
            EXIT WHEN c2%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE('Angajatul: '|| subo);
    
            OPEN c1(subo);
            LOOP
                FETCH c1 INTO statie, nume_statie, cod_traseu;
                EXIT WHEN c1%NOTFOUND;
                DBMS_OUTPUT.PUT_LINE('Statia: ' || statie ||' '||nume_statie|| ', din traseul: ' ||cod_traseu);
            END LOOP;
            IF c1%ROWCOUNT=0 THEN
                DBMS_OUTPUT.PUT_LINE('Acest angajat nu conduce pe niciun traseu');
            ELSE 
                SELECT sum(lungime) INTO lungime_trasee
                FROM trasee_stc WHERE cod_traseu IN
                (
                    select distinct s.cod_traseu
                    from vehicul_traseu_sofer vts join trasee_stc t on (vts.cod_traseu= t.cod_traseu) 
                            join statie_unica_stc s on (s.cod_traseu= t.cod_traseu) 
                            join angajati_stc a on (vts.cod_angajat= a.cod_angajat) 
                            join statii_stc st on (st.cod_statie = s.cod_statie)
                    where a.cod_angajat =subo
                );           
                
                DBMS_OUTPUT.PUT_LINE('Suma lungimilor traseelor parcurse de acest angajat este: ' || lungime_trasee);
            END IF;
            CLOSE c1;
        END LOOP;
        IF c2%ROWCOUNT=0 THEN
            DBMS_OUTPUT.PUT_LINE('Nu am gasit niciun subordonat al lui' || v_nume_ang);
        END IF;
        CLOSE c2;
        EXCEPTION
            WHEN exceptie_ang THEN
                DBMS_OUTPUT.PUT_LINE('Nu am gasit angajat cu numele ' || v_nume_ang);
            WHEN too_many_rows THEN
                DBMS_OUTPUT.PUT_LINE('Prea multi angajati cu numele ' || v_nume_ang);
    END proiect_lungime_trasee;

    /****************************/
    FUNCTION functie_proiect_coduri_postale
 (v_sectie sectii_stc.nume_sectie%TYPE DEFAULT 'autobuz')
        RETURN VARCHAR2 AS
            coduri_postale VARCHAR2(1000);
            niciunCod EXCEPTION;
            sectieGresita EXCEPTION;
            v_count NUMBER;
        BEGIN
            SELECT COUNT(*)
            INTO v_count
            FROM sectii_stc
            WHERE lower(nume_sectie) = lower(v_sectie);
        
            IF v_count = 0 THEN
                RAISE sectieGresita;
            END IF;
        
            FOR coduri IN 
                (SELECT distinct cod_postal 
                 FROM locatii_stc l join filiale_stc f on (l.cod_locatie = f.cod_locatie)
                                    join sectii_stc s on (s.cod_sectie = f.cod_sectie)
                 WHERE lower(v_sectie) = lower(nume_sectie)) LOOP
                    coduri_postale := coduri_postale || coduri.cod_postal || ', ';
                 END LOOP;
                IF coduri_postale IS NOT NULL THEN
                    coduri_postale := RTRIM(coduri_postale, ', ');
                ELSE
                    RAISE niciunCod;
                END IF;
        
            RETURN coduri_postale;
            
            EXCEPTION
            WHEN sectieGresita THEN
                DBMS_OUTPUT.PUT_LINE('Exceptie: Nu exista o sectie cu acest nume: ' || v_sectie);
                RETURN NULL;
            WHEN niciunCod THEN
                DBMS_OUTPUT.PUT_LINE('Exceptie: Nu exista coduri postale pentru sectia ' || v_sectie);
                RETURN NULL;
                
        END functie_proiect_coduri_postale;
    /****************************************/
    FUNCTION este_sofer (v_cod_ang angajati_stc.cod_angajat%TYPE)
        RETURN VARCHAR2 AS rez NUMBER;
        BEGIN
            SELECT count(*) INTO rez
            FROM sofer_stc
            WHERE cod_angajat = v_cod_ang;
            IF rez = 0 THEN
                RETURN 'nu';
            else
                RETURN 'da';
            END IF;
        END este_sofer;
    /**************************/
    PROCEDURE numar_roti_procedura_proiect2 (nume_angajat angajati_stc.nume%TYPE)
        AS
            
            cod_angajat angajati_stc.cod_angajat%TYPE;
            numar_roti NUMBER;
            v_sofer VARCHAR2(2);
            nu_e_sofer EXCEPTION;
        BEGIN
                   
                SELECT cod_angajat INTO cod_angajat
                FROM angajati_stc 
                WHERE upper(nume) = upper(nume_angajat);
                
                v_sofer := este_sofer(cod_angajat);
                DBMS_OUTPUT.PUT_LINE(cod_angajat);
                IF v_sofer = 'nu' THEN RAISE nu_e_sofer; END IF;
                
                        select sum(nr_roti) INTO numar_roti
                        from(
                            select  distinct v.nr_inmatriculare, nr_roti, c.cod_caract, nvl(data_expirare,sysdate+1) exp
                            from vehicul_traseu_sofer v 
                                join vehicule_stc  v2 on (v.nr_inmatriculare= v2.nr_inmatriculare)
                                join tipuri_vehicule_stc tv on (v2.cod_tip_vehicul=tv.cod_tip_vehicul)
                                join caracteristica_tip c on (tv.cod_tip_vehicul=c.cod_tip_vehicul)
                                join caracteristici_stc car on (car.cod_caract=c.cod_caract)
                            where nvl(data_expirare,sysdate+1)>sysdate --verificam ca inca conduce acest vehicul
                            AND cod_angajat = cod_angajat
                        );
                         DBMS_OUTPUT.PUT_LINE('numar roti: ' || numar_roti);  
        
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                DBMS_OUTPUT.PUT_LINE (' no data found: ' ||SQLCODE || ' - ' || SQLERRM);
            WHEN TOO_MANY_ROWS THEN
                DBMS_OUTPUT.PUT_LINE (' too many rows: ' ||SQLCODE || ' - ' || SQLERRM);
            WHEN nu_e_sofer THEN
                 DBMS_OUTPUT.PUT_LINE (' angajatul cautat nu e sofer ' );
        END numar_roti_procedura_proiect2;
        
/************************************/

END pachet_proiect_stc;
/
DECLARE 
    v_nume angajati_stc.nume%TYPE;
    cod_sef angajati_stc.cod_angajat%TYPE;
BEGIN
    v_nume :='Dionys';
    pachet_proiect_stc.proiect_lungime_trasee(v_nume);
END;

/
select * from angajati_stc;
/
/*ex 14 */
CREATE OR REPLACE PACKAGE pachet_proiect_complex_stc AS
    TYPE lista_LOCATII IS TABLE OF locatii_stc.cod_locatie%TYPE;
    
    TYPE record_sectii_locatii IS RECORD (sal angajati_stc.salariu%type, lista_loc lista_LOCATII);
    TYPE t_indexat_sectii IS TABLE OF angajati_stc.salariu%type
            INDEX BY sectii_stc.cod_sectie%TYPE;
    sectii_salariu t_indexat_sectii;
    sectii_salariu_aux t_indexat_sectii;
    salariu_sum angajati_stc.salariu%type;
    TYPE t_indexat_sectii_record IS TABLE OF record_sectii_locatii
            INDEX BY sectii_stc.cod_sectie%TYPE;
    PROCEDURE tabel_record;
    tabel t_indexat_sectii_record;
    FUNCTION sal_sum_pt_sectie (cod_sectie angajati_stc.cod_sectie%TYPE)
        RETURN angajati_stc.salariu%type;
    PROCEDURE afisare_date_sal_sum;
    PROCEDURE initializare_sal_sum;
    CURSOR cursor_sectii IS (select cod_sectie from sectii_stc);
    CURSOR cursor_locatii_per_sectie(v_sectie angajati_stc.cod_sectie%TYPE)
        IS (SELECT cod_locatie FROM angajati_stc WHERE cod_sectie= v_sectie);
    FUNCTION exista_l(l lista_LOCATII, v locatii_stc.cod_locatie%TYPE) RETURN BOOLEAN;
END pachet_proiect_complex_stc;
/
CREATE OR REPLACE PACKAGE BODY pachet_proiect_complex_stc AS
    FUNCTION exista_l(l lista_LOCATII, v locatii_stc.cod_locatie%TYPE) RETURN BOOLEAN
    AS b BOOLEAN;
    BEGIN
        b:=false;
        FOR i in 1..l.last LOOP
            IF l(i) = v THEN b:=true; END IF;
        END LOOP;
        RETURN b;
    END;
    PROCEDURE tabel_record 
    AS
    rec record_sectii_locatii;
     v_cod sectii_stc.cod_sectie%TYPE;
     
    BEGIN
        initializare_sal_sum;
        OPEN cursor_sectii;
        LOOP
            FETCH cursor_sectii INTO v_cod;
            EXIT WHEN cursor_sectii%NOTFOUND;
            rec.sal:=sectii_salariu(v_cod);
            
            SELECT distinct nvl(cod_locatie,'no') BULK COLLECT INTO rec.lista_loc
            FROM angajati_stc WHERE cod_sectie = v_cod AND cod_locatie IS NOT NULL;
            
            tabel(v_cod):=rec;
            
        END LOOP;  
        CLOSE cursor_sectii;
    END tabel_record;
    PROCEDURE afisare_date_sal_sum
    AS
        sectie angajati_stc.cod_sectie%TYPE;
        cnt Number;
        exceptie EXCEPTION;
        nr_sectii NUMBER;
    BEGIN
        cnt := sectii_salariu.COUNT;
        SELECT count(*) INTO nr_sectii from sectii_stc;
        IF cnt <nr_sectii THEN 
            raise exceptie;
        END IF;
        sectie := sectii_salariu.FIRST;
        WHILE sectie!= sectii_salariu.LAST LOOP
            DBMS_OUTPUT.PUT_LINE('Sectia ' || sectie || ' are suma salariilor: '|| sectii_salariu(sectie));
            sectie:= sectii_salariu.NEXT(sectie);
        END LOOP;
        DBMS_OUTPUT.PUT_LINE('Sectia ' || sectie || ' are suma salariilor: '|| sectii_salariu(sectie));
    EXCEPTION
        WHEN exceptie THEN
             DBMS_OUTPUT.PUT_LINE ('Nu sunt toate sectiile completate, mai incercati o data.');
             initializare_sal_sum;
    END afisare_date_sal_sum;
    /********************************/
    FUNCTION sal_sum_pt_sectie (cod_sectie angajati_stc.cod_sectie%TYPE)
        RETURN angajati_stc.salariu%type 
        AS sal_sum angajati_stc.salariu%type; q VARCHAR2(300);
    BEGIN
        q := 'SELECT SUM(salariu) FROM angajati_stc ' || 'WHERE cod_sectie = :v_sectie';
        EXECUTE IMMEDIATE q
        INTO sal_sum
        USING cod_sectie;
        
        sectii_salariu(cod_sectie):=sal_sum;
        RETURN sal_sum;
     END sal_sum_pt_sectie;
     /***************************/
     PROCEDURE initializare_sal_sum AS
        v_cod angajati_stc.cod_sectie%TYPE;
        aux angajati_stc.salariu%TYPE;
    BEGIN
        salariu_sum:=0;
        OPEN cursor_sectii;
        LOOP
            FETCH cursor_sectii INTO v_cod;
            EXIT WHEN cursor_sectii%NOTFOUND;
            aux:=sal_sum_pt_sectie(v_cod);
            salariu_sum:=salariu_sum +aux;
        END LOOP;  
        CLOSE cursor_sectii;
        salariu_sum:= salariu_sum;
     END initializare_sal_sum;
END pachet_proiect_complex_stc;
/
DECLARE
 sec angajati_stc.cod_sectie%TYPE;
 rez NUMBER;
 tabel_rezultat pachet_proiect_complex_stc.t_indexat_sectii_record;
BEGIN
    sec:='S0';
    /*rez := pachet_proiect_complex_stc.sal_mediu_pt_sectie(sec);*/
    
    /*DBMS_OUTPUT.PUT_LINE(rez);  */
    /*pachet_proiect_complex_stc.initializare_sal_mediu;*/
    pachet_proiect_complex_stc.afisare_date_sal_sum;
    /*tabel_rezultat := pachet_proiect_complex_stc.tabel_record;
    DBMS_OUTPUT.PUT_LINE(tabel_rezultat(sec).sal);*/
END;
/
/*sa se creeze unul/ mai multi triggeri care nu permite ca suma salariului in 
sectii cu mai putin de 3 locatii sau cu locatia L0 sa fie 9000, si care verifica ca suma totala a 
salariilor sa nu fie 9001
Sa se afiseze datele inainte de modificare
*/
CREATE OR REPLACE TRIGGER trg_complex_1_stc
BEFORE INSERT OR UPDATE OF salariu ON angajati_stc
DECLARE v sectii_stc.cod_sectie%type;
BEGIN
    OPEN  pachet_proiect_complex_stc.cursor_sectii;
        LOOP
            FETCH  pachet_proiect_complex_stc.cursor_sectii INTO v;
            EXIT WHEN pachet_proiect_complex_stc.cursor_sectii%NOTFOUND;
            pachet_proiect_complex_stc.sectii_salariu_aux(v):=0;
        END LOOP;  
        CLOSE  pachet_proiect_complex_stc.cursor_sectii;
       
     
    pachet_proiect_complex_stc.tabel_record;
    DBMS_OUTPUT.PUT_LINE('INAINTE----------------');
    pachet_proiect_complex_stc.afisare_date_sal_sum;
    
END;
/
CREATE OR REPLACE TRIGGER trg_complex_2_stc
BEFORE INSERT OR UPDATE OF salariu ON angajati_stc
FOR EACH ROW
DECLARE
    b BOOLEAN;
    cnt NUMBER;
    sec sectii_stc.cod_sectie%TYPE;
BEGIN
    sec:= pachet_proiect_complex_stc.tabel.FIRST;
     
    WHILE sec IS NOT NULL LOOP
    DBMS_OUTPUT.PUT_LINE('Inside loop for section ' || sec);
    b:=pachet_proiect_complex_stc.exista_l(pachet_proiect_complex_stc.tabel(sec).lista_loc, 'L0');
        IF b=FALSE THEN
            cnt := 0;
        ELSE
            cnt := pachet_proiect_complex_stc.tabel(sec).lista_loc.COUNT();
        END IF;
        
--         IF cnt IS NOT NULL THEN
--            DBMS_OUTPUT.PUT_LINE(cnt);
--        ELSE
--            DBMS_OUTPUT.PUT_LINE('Count is NULL');
--        END IF;
        DBMS_OUTPUT.PUT_LINE('b: ' ||sys.diutil.bool_to_int(b));
        IF (cnt<3 OR b = TRUE) AND sec = :OLD.cod_sectie THEN
            DBMS_OUTPUT.PUT_LINE('a');
            IF pachet_proiect_complex_stc.tabel(sec).sal - :OLD.salariu + :NEW.salariu>20000 THEN
                RAISE_APPLICATION_ERROR(-20000,'Sectia '||sec||'  depaseste salariul admis.');
                
            null;
            END IF;
            EXIT;
        END IF;
        pachet_proiect_complex_stc.sectii_salariu(sec):=pachet_proiect_complex_stc.tabel(sec).sal - :OLD.salariu + :NEW.salariu;
        sec:=pachet_proiect_complex_stc.tabel.NEXT(sec);
     END LOOP;  
END;
/
UPdate angajati_stc SET salariu = 15000 where cod_angajat='A1';
rollback;
commit;
select * from angajati_stc;
/

/
desc obisnuit_stc;
/
FUNCTION postale_cursor(p_var number) RETURN SYS_REFCURSOR
IS

CURSOR cur(cp_var number) IS
    SELECT * FROM dual ;

BEGIN
    OPEN cur(p_var);
    RETURN cur;
END stuff;
/
FUNCTION functie_proiect_coduri_postale2
    (v_sectie sectii_stc.nume_sectie%TYPE DEFAULT 'autobuz')
RETURN SYS_REFCURSOR AS
    v_count NUMBER;
    my_cursor SYS_REFCURSOR;
BEGIN
    SELECT COUNT(*)
    INTO v_count
    FROM sectii_stc
    WHERE lower(nume_sectie) = lower(v_sectie);

    IF v_count = 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Sectie inexistenta: ' || v_sectie);
    END IF;

    OPEN my_cursor FOR
        SELECT DISTINCT cod_postal 
        FROM locatii_stc l
        JOIN filiale_stc f ON (l.cod_locatie = f.cod_locatie)
        JOIN sectii_stc s ON (s.cod_sectie = f.cod_sectie)
        WHERE lower(v_sectie) = lower(nume_sectie);

    RETURN my_cursor;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Exceptie: Nu exista coduri postale pentru sectia ' || v_sectie);
        RETURN NULL;
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Exceptie: ' || SQLERRM);
        RETURN NULL;
END functie_proiect_coduri_postale2;
/
CREATE OR REPLACE PROCEDURE proiect_lungime_trasee2
        (v_nume_ang IN angajati_stc.nume%TYPE)
AS
    
    CURSOR c2 (v_cod_sef angajati_stc.cod_angajat%TYPE) IS (SELECT cod_angajat
        FROM ANGAJATI_STC
        WHERE cod_sef = v_cod_sef);
    CURSOR c1 (v_subordonati angajati_stc.cod_angajat%TYPE) IS
            (select distinct s.cod_statie, nume_statie, s.cod_traseu
            from vehicul_traseu_sofer vts join trasee_stc t on (vts.cod_traseu= t.cod_traseu) 
                    join statie_unica_stc s on (s.cod_traseu= t.cod_traseu) 
                    join angajati_stc a on (vts.cod_angajat= a.cod_angajat) 
                    join statii_stc st on (st.cod_statie = s.cod_statie)
            where a.cod_angajat =v_subordonati);
       

    statie statie_unica_stc.cod_statie%TYPE;
    nume_statie statii_stc.nume_statie%TYPE;
    cod_traseu trasee_stc.cod_traseu%TYPE;
    
    subo angajati_stc.cod_angajat%TYPE;
    cod_sef angajati_stc.cod_angajat%TYPE;
    lungime_trasee NUMBER;
    ok BOOLEAN;
    exceptie_ang EXCEPTION;

BEGIN
    ok:=exista_angajat(v_nume_ang);
    IF ok=FALSE then raise exceptie_ang; END IF;
    
    SELECT cod_angajat INTO cod_sef
    FROM ANGAJATI_STC
    WHERE upper(nume) = upper(v_nume_ang);

    OPEN c2(cod_sef);
    
    LOOP
		FETCH c2 INTO subo;
		EXIT WHEN c2%NOTFOUND;
		DBMS_OUTPUT.PUT_LINE('Angajatul: '|| subo);

        OPEN c1(subo);
        LOOP
            FETCH c1 INTO statie, nume_statie, cod_traseu;
            EXIT WHEN c1%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE('Statia: ' || statie ||' '||nume_statie|| ', din traseul: ' ||cod_traseu);
        END LOOP;
        IF c1%ROWCOUNT=0 THEN
            DBMS_OUTPUT.PUT_LINE('Acest angajat nu conduce pe niciun traseu');
        ELSE 
            SELECT sum(lungime) INTO lungime_trasee
            FROM trasee_stc WHERE cod_traseu IN
            (
                select distinct s.cod_traseu
                from vehicul_traseu_sofer vts join trasee_stc t on (vts.cod_traseu= t.cod_traseu) 
                        join statie_unica_stc s on (s.cod_traseu= t.cod_traseu) 
                        join angajati_stc a on (vts.cod_angajat= a.cod_angajat) 
                        join statii_stc st on (st.cod_statie = s.cod_statie)
                where a.cod_angajat =subo
            );           
            
            DBMS_OUTPUT.PUT_LINE('Suma lungimilor traseelor parcurse de acest angajat este: ' || lungime_trasee);
        END IF;
        CLOSE c1;
    END LOOP;
    IF c2%ROWCOUNT=0 THEN
        DBMS_OUTPUT.PUT_LINE('Nu am gasit niciun subordonat al lui' || v_nume_ang);
    END IF;
    CLOSE c2;
    EXCEPTION
        WHEN exceptie_ang THEN
            DBMS_OUTPUT.PUT_LINE('Nu am gasit angajat cu numele ' || v_nume_ang);
        WHEN too_many_rows THEN
            DBMS_OUTPUT.PUT_LINE('Prea multi angajati cu numele ' || v_nume_ang);
END;
/
select * from angajati_stc;
/
/*apel ex 7*/
DECLARE 
    v_nume angajati_stc.nume%TYPE;
    cod_sef angajati_stc.cod_angajat%TYPE;
BEGIN
    v_nume :='Dionys';
    proiect_lungime_trasee2(v_nume);
END;
/