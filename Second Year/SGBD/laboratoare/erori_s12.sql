/*E1. S? se creeze un bloc PL/SQL care afi?eaz? radicalul unei variabile introduse de la tastatur?. S?
se trateze cazul în care valoarea variabilei este negativ?. Gestiunea erorii se va realiza prin
definirea unei excep?ii de c?tre utilizator, respectiv prin captarea erorii interne a sistemului.
Codul ?i mesajul erorii vor fi introduse în tabelul error_***(cod, mesaj).
*/
CREATE TABLE error_cco
(cod NUMBER,
mesaj VARCHAR2(100));
/SET SERVEROUTPUT ON/

select * from error_cco;
/
DECLARE 
  v_numar NUMBER;
  v_radical NUMBER;
  v_cod_eror NUMBER;
  v_mesaj_eror VARCHAR2(100);
  
  EXCEPTION_NEGATIV EXCEPTION;
BEGIN
  v_numar := &p;
  
  IF v_numar < 0 THEN RAISE EXCEPTION_NEGATIV;
  ELSE
    v_radical := SQRT(v_numar);
    DBMS_OUTPUT.PUT_LINE('Radicalul lui ' || v_numar || ' este ' || v_radical);
  END IF;

EXCEPTION
  
  WHEN EXCEPTION_NEGATIV THEN
    v_cod_eror := -20999;
    v_mesaj_eror := 'Eroare: Valoarea introdus? este negativ?.';
    DBMS_OUTPUT.PUT_LINE(v_mesaj_eror);
    INSERT INTO error_cco (cod, mesaj) VALUES (v_cod_eror, v_mesaj_eror);

END;

/
DECLARE
    v_cod NUMBER;
    v_mesaj VARCHAR2(100);
    x NUMBER;
BEGIN
    x:=SQRT(&p);
EXCEPTION
    WHEN NEGATIVE_SQRT THEN
    v_cod := SQLCODE;
    v_mesaj := SUBSTR(SQLERRM,1,100);
    INSERT INTO error_cco
    VALUES (v_cod, v_mesaj);
END;

/
--
--E2. S? se creeze un bloc PL/SQL prin care s? se afi?eze numele salariatului (din tabelul emp_***)
--care câ?tig? un anumit salariu. Valoarea salariului se introduce de la tastatur?. Se va testa
--programul pentru urm?toarele valori: 500, 3000 ?i 5000.
--Dac? interogarea nu întoarce nicio linie, atunci s? se trateze excep?ia ?i s? se afi?eze mesajul
--“nu exista salariati care sa castige acest salariu ”. Dac? interogarea întoarce o singur? linie,
--atunci s? se afi?eze numele salariatului. Dac? interogarea întoarce mai multe linii, atunci s? se
--afi?eze mesajul “exista mai mul?i salariati care castiga acest salariu”.
select * from emp_cco;
/
DECLARE
  v_sal NUMBER := &p;
  v_emp emp_cco.first_name%TYPE;
BEGIN
  
  SELECT first_name INTO v_emp
  FROM emp_cco
  WHERE salary = v_sal;

  DBMS_OUTPUT.PUT_LINE('Numele salariatului care câ?tig? ' || v_sal || ' este: ' || v_emp);

EXCEPTION
 
  WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('Nu exist? salaria?i care s? câ?tige acest salariu');

  WHEN TOO_MANY_ROWS THEN
    DBMS_OUTPUT.PUT_LINE('Exist? mai mul?i salaria?i care câ?tig? acest salariu');

  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Eroare: ' || SQLERRM);
END;
/