select * from clienti;

--in tabelul clienti addaugam o coloana de tip rec(tip_1) care contine un tabel indexat de tip lista_facturi(tip_2) care contine elemente de tip id_factura.facturi%TYPE(tip_3);
--tipul rec retine id_client si o lista de facturi ale clientului respectiv
/
create table clienti_cco (
id_client number(10) primary key,
telefon varchar(20),
email varchar(50),
tip varchar(20),
oras varchar(30),
data_nasterii date,
data_modificarii date
);
insert into clienti_cco 
select * from clienti;
select * from clienti_cco;
desc facturi;
/
CREATE OR REPLACE TYPE lista_facturi1 
AS VARRAY(100) OF NUMBER(20);
/
CREATE OR REPLACE TYPE rec1 AS OBJECT (
    id_client NUMBER(20),
    camp1 lista_facturi1
);
/
ALTER TABLE clienti_cco 
ADD listaFacturi rec1;
/
select * from clienti_cco;
/
DECLARE 
 n NUMBER;
 l lista_facturi1;
 listaFact rec1;
BEGIN
 n:=(select count(*) from (SELECT id_factura
                                    FROM facturi
                                     WHERE id_client=1));
 FOR i IN 1..n LOOP
    l(i):=(SELECT id_factura 
          FROM (SELECT id_factura
                FROM facturi
                WHERE id_client=1)
            WHERE rownum=i);
                                
 END LOOP;
 listaFact :=rec1(1, lista_facturi1(l));

 UPDATE clienti_cco
 SET listaFacturi = listaFact
 WHERE id_client=1;
END;
/
DECLARE 
 n NUMBER;
 l lista_facturi1;
 listaFact rec1;
BEGIN
 n:=4;
 l(1):=1;
 l(2):=2;
 l(3):=6;
 l(4):=7;
              
 listaFact :=rec1(1, lista_facturi1(l));

 UPDATE clienti_cco
 SET listaFacturi = listaFact
 WHERE id_client=1;
END;
