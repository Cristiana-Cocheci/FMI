SET SERVEROUTPUT ON
/
CREATE OR REPLACE TYPE tip_orase_cco AS VARRAY(100) OF VARCHAR2(50);
/
CREATE TABLE excursie_cco(
    cod_excursie NUMBER(4), 
    denumire VARCHAR2(20), 
    orase tip_orase_cco,
    status VARCHAR2(10)
);
/
DECLARE
v_vct1 tip_orase_cco:= tip_orase_cco('Bucuresti','Constanta','Brasov');
v_vct2 tip_orase_cco:= tip_orase_cco('Bucuresti','Iasi','timisoara');
v_vct3 tip_orase_cco:= tip_orase_cco('Bucuresti','Londra','Paris');
v_vct4 tip_orase_cco:= tip_orase_cco('Bucuresti','new York');
v_vct5 tip_orase_cco:= tip_orase_cco('Bucuresti');
BEGIN
INSERT INTO excursie_cco VALUES (0,'exc1',v_vct1,'disponibil');
INSERT INTO excursie_cco VALUES (1,'exc2',v_vct2,'disponibil');
INSERT INTO excursie_cco VALUES (2,'exc3',v_vct3,'disponibil');
INSERT INTO excursie_cco VALUES (3,'exc4',v_vct4,'disponibil');
INSERT INTO excursie_cco VALUES (4,'exc5',v_vct5,'anulat');
END;

/--adaugare la final
DECLARE 
v_lista tip_orase_cco;
v_oras VARCHAR2(50):='Daiesti';
v_ex NUMBER(4):=3;
v_lungime NUMBER(4);
BEGIN
SELECT orase
INTO v_lista
FROM excursie_cco
WHERE cod_excursie=v_ex;

v_ex:=v_lista.COUNT +1;
v_lista.extend;
v_lista(v_ex):=v_oras;
FOR j IN v_lista.FIRST..v_lista.LAST loop
DBMS_OUTPUT.PUT_LINE (v_lista(j));
END LOOP;

UPDATE excursie_cco
SET orase = v_lista
WHERE cod_excursie=v_ex;

END;
/
select * from excursie_cco;
commit;
/--pe pozitia 2
DECLARE 
v_lista tip_orase_cco;
v_lista_noua tip_orase_cco:= tip_orase_cco();
v_oras VARCHAR2(50):='Babesti';
v_ex NUMBER(4):=0;
v_lungime NUMBER(4);
BEGIN
SELECT orase
INTO v_lista
FROM excursie_cco
WHERE cod_excursie=v_ex;

FOR j IN v_lista.FIRST..v_lista.LAST loop
    IF j<2 THEN
    v_lista_noua.extend;
    v_lista_noua(j):=v_lista(j);
    END IF;
    IF j = 2 THEN 
    v_lista_noua.extend;
    v_lista_noua(2):=v_oras;
    v_lista_noua.extend;
    v_lista_noua(3):=v_lista(j);
    END IF;
    If j>2 THEN
    v_lista_noua.extend;
    v_lista_noua(j+1):=v_lista(j);
    END IF;
END LOOP;

FOR j IN v_lista_noua.FIRST..v_lista_noua.LAST loop
DBMS_OUTPUT.PUT_LINE (v_lista_noua(j));
END LOOP;

UPDATE excursie_cco
SET orase = v_lista_noua
WHERE cod_excursie=v_ex;

END;

/
--inversare
DECLARE 
v_lista tip_orase_cco;
v_oras1 VARCHAR2(50):='Bucuresti';
v_oras2 VARCHAR2(50):='Paris';
v_ex NUMBER(4):=2;
BEGIN
SELECT orase
INTO v_lista
FROM excursie_cco
WHERE cod_excursie=v_ex;

FOR j IN v_lista.FIRST..v_lista.LAST loop

    IF upper(v_lista(j))=upper(v_oras1) THEN v_lista(j):=v_oras2;
 
    ELSIF upper(v_lista(j))=upper(v_oras2) THEN v_lista(j):=v_oras1;
    END IF;
DBMS_OUTPUT.PUT_LINE (v_lista(j));
END LOOP;

UPDATE excursie_cco
SET orase = v_lista
WHERE cod_excursie=v_ex;

END;
/
--stergere
DECLARE 
v_lista tip_orase_cco;
v_lista_noua tip_orase_cco:= tip_orase_cco();
v_oras VARCHAR2(50):='Bucuresti';
v_ex NUMBER(4):=1;
v_cnt NUMBER(4):=0;
BEGIN
SELECT orase
INTO v_lista
FROM excursie_cco
WHERE cod_excursie=v_ex;

FOR j IN v_lista.FIRST..v_lista.LAST loop
    --indentat de la 1
    IF upper(v_lista(j))!=upper(v_oras) THEN v_cnt:=v_cnt+1; v_lista_noua.extend; v_lista_noua(v_cnt):=v_lista(j);
    END IF;
END LOOP;

FOR j IN v_lista_noua.FIRST..v_lista_noua.LAST loop
DBMS_OUTPUT.PUT_LINE (v_lista_noua(j));
END LOOP;

UPDATE excursie_cco
SET orase = v_lista_noua
WHERE cod_excursie=v_ex;

END;

/
select * from excursie_cco;
commit;
rollback;
/
--c)
DECLARE
v_cod NUMBER:='&p_cod';
v_lista tip_orase_cco;
BEGIN
SELECT orase
INTO v_lista
FROM excursie_cco
WHERE cod_excursie=v_cod;
DBMS_OUTPUT.PUT_LINE('nr orase vizitate: '||v_lista.last);
FOR j IN v_lista.FIRST..v_lista.LAST loop
DBMS_OUTPUT.PUT_LINE (v_lista(j));
END LOOP;
END;
/
desc excursie_cco;
--d
DECLARE
CURSOR coduri_excursii is SELECT cod_excursie from excursie_cco;
v_lista tip_orase_cco;
v_cod NUMBER(4);
BEGIN

OPEN coduri_excursii;
LOOP
        FETCH coduri_excursii INTO v_cod;
        EXIT WHEN coduri_excursii%notfound;
        DBMS_OUTPUT.PUT_LINE('excursie: '||v_cod);
        SELECT orase
        INTO v_lista
        FROM excursie_cco
        WHERE cod_excursie=v_cod;
        DBMS_OUTPUT.PUT_LINE('nr orase vizitate: '||v_lista.last);
        FOR j IN v_lista.FIRST..v_lista.LAST loop
        DBMS_OUTPUT.PUT_LINE (v_lista(j));
        END LOOP;
END LOOP;
CLOSE coduri_excursii;
END;
/
--e
DECLARE
CURSOR coduri_excursii is SELECT cod_excursie from excursie_cco;
v_lista tip_orase_cco;
v_cod NUMBER(4);
v_min NUMBER(6):=10000;
BEGIN

OPEN coduri_excursii;
LOOP
        FETCH coduri_excursii INTO v_cod;
        EXIT WHEN coduri_excursii%notfound;
        SELECT orase
        INTO v_lista
        FROM excursie_cco
        WHERE cod_excursie=v_cod;
        IF v_lista.last<v_min THEN v_min:=v_lista.last;
        END IF;
END LOOP;
CLOSE coduri_excursii;
DBMS_OUTPUT.PUT_LINE('min nr orase vizitate: '||v_min);

OPEN coduri_excursii;
LOOP
        FETCH coduri_excursii INTO v_cod;
        EXIT WHEN coduri_excursii%notfound;
        SELECT orase
        INTO v_lista
        FROM excursie_cco
        WHERE cod_excursie=v_cod;
        IF v_lista.last=v_min THEN 
        UPDATE excursie_cco
        SET status='anulat'
        WHERE cod_excursie=v_cod;
        DBMS_OUTPUT.PUT_LINE('Update status excursie cu cod: '||v_cod);

        END IF;
END LOOP;
CLOSE coduri_excursii;


END;
/
select* from excursie_cco;
commit;