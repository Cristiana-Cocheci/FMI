--sistem de transport in comun

CREATE TABLE angajati_stc(
    cod_angajat VARCHAR2(25) primary key,
    nume VARCHAR(25) CONSTRAINT nume_vid NOT NULL,
    data_angajare DATE default sysdate,
    salariu NUMBER(10) default 2500
);


CREATE TABLE joburi(
    cod_job VARCHAR2(25) primary key,
    nume VARCHAR(25) CONSTRAINT numeJob_vid NOT NULL,
    ore_pe_zi NUMBER(2)
);

CREATE TABLE obisnuit_stc(
    cod_angajat VARCHAR2(25) primary key references angajati_stc(cod_angajat),
    cod_job VARCHAR2(25),
    constraint codJob_fk foreign key(cod_job) references joburi (cod_job)
);

CREATE TABLE sofer_stc(
    cod_angajat VARCHAR2(25) primary key references angajati_stc(cod_angajat),
    tip_permis VARCHAR2(25) constraint permis_conducere NOT NULL
);

ALTER TABLE angajati_stc
ADD (cod_sef VARCHAR2(25) REFERENCES angajati_stc(cod_angajat));
desc angajati_stc;

ALTER TABLE sofer_stc
MODIFY tip_permis default 'z-profesionist';

CREATE TABLE departament_transport_stc(
    tip_transport VARCHAR2(25) primary key,
    responsabil VARCHAR2(25) references angajati_stc(cod_angajat)
);
ALTER TABLE departament_transport_stc
ADD (nume_departament VARCHAR(25) NOT NULL);

CREATE TABLE sectii_stc(
    cod_sectie VARCHAR2(25) primary key,
    responsabil VARCHAR2(25) references angajati_stc(cod_angajat),
    tip_transport VARCHAR2(25) references departament_transport_stc(tip_transport)
);
ALTER TABLE sectii_stc
ADD (nume_sectie VARCHAR(25));


CREATE TABLE locatii_stc(
    cod_locatie VARCHAR2(25) primary key,
    nume VARCHAR(25) CONSTRAINT numeLoc_vid UNIQUE,
    adresa VARCHAR(25) UNIQUE,
    cod_postal NUMBER(7)
);

CREATE TABLE filiale_stc(
    cod_sectie VARCHAR2(25) references sectii_stc(cod_sectie),
    cod_locatie VARCHAR2(25) references locatii_stc(cod_locatie),
    responsabil VARCHAR2(25) references angajati_stc(cod_angajat),
    primary key (cod_sectie, cod_locatie)
);
ALTER TABLE angajati_stc
ADD (cod_sectie VARCHAR2(25),
    cod_locatie VARCHAR(25),
    CONSTRAINT fkey_angajati foreign key (cod_sectie, cod_locatie)
    REFERENCES filiale_stc(cod_sectie,cod_locatie));



CREATE TABLE trasee_stc(
    cod_traseu VARCHAR2(25) primary key,
    capat1 VARCHAR(25),
    capat2 VARCHAR(25),
    lungime NUMBER(7),
    cod_sectie VARCHAR2(25) references sectii_stc(cod_sectie)
);

CREATE TABLE depouri_stc(
    cod_depou VARCHAR2(25) primary key,
    nume_depou VARCHAR2(25),
    capacitate NUMBER(5),
    cod_locatie VARCHAR2(25) references locatii_stc(cod_locatie)
);

CREATE TABLE statii_stc(
    cod_statie VARCHAR2(25) primary key,
    nume_statie VARCHAR2(25),
    cod_locatie VARCHAR2(25) references locatii_stc(cod_locatie)
);

CREATE TABLE statie_unica_stc(
    cod_statie VARCHAR2(25) references statii_stc(cod_statie),
    cod_traseu VARCHAR2(25) references trasee_stc(cod_traseu),
    primary key (cod_statie, cod_traseu)
);

ALTER TABLE trasee_stc
ADD CONSTRAINT fkey_capat1 FOREIGN KEY(capat1) REFERENCES statii_stc(cod_statie);
ALTER TABLE trasee_stc
ADD CONSTRAINT fkey_capat2 FOREIGN KEY(capat2) REFERENCES statii_stc(cod_statie);


CREATE TABLE tipuri_vehicule_stc(
    cod_tip_vehicul VARCHAR2(25) primary key,
    nume VARCHAR2(25),
    marca VARCHAR(25)
);

CREATE TABLE caracteristici_stc(
    cod_caract NUMBER(3) primary key,
    nr_locuri NUMBER(3),
    nr_roti NUMBER(2),
    combustibil NUMBER(3),
    seria VARCHAR2(10),
    model VARCHAR2(10),
    an DATE default sysdate
);
ALTER TABLE caracteristici_stc
DROP COLUMN combustibil;

ALTER TABLE caracteristici_stc
ADD combustibil VARCHAR(25) default 'benzina';

ALTER TABLE caracteristici_stc
MODIFY model VARCHAR(25);

CREATE TABLE caracteristica_tip(
    cod_caract NUMBER(3) references caracteristici_stc(cod_caract),
    cod_tip_vehicul VARCHAR2(25) references tipuri_vehicule_stc(cod_tip_vehicul),
    data_start DATE,
    data_expirare DATE,
    primary key (cod_caract, cod_tip_vehicul, data_start)
);

CREATE TABLE vehicule_stc(
    nr_inmatriculare VARCHAR2(10) primary key,
    cod_tip_vehicul VARCHAR2(25) references tipuri_vehicule_stc(cod_tip_vehicul)
);

ALTER TABLE vehicule_stc
ADD (cod_depou VARCHAR2(25) REFERENCES depouri_stc(cod_depou));
desc vehicule_stc;


CREATE TABLE vehicul_traseu_sofer(
    cod_angajat VARCHAR2(25) references sofer_stc(cod_angajat),
    nr_inmatriculare VARCHAR2(10) references vehicule_stc(nr_inmatriculare),
    cod_traseu VARCHAR2(25) references trasee_stc(cod_traseu),
    primary key (nr_inmatriculare, cod_traseu, cod_angajat)
);




--inserare

--joburi
desc joburi;

INSERT INTO joburi
VALUES ('J0','Contabil',8);
INSERT INTO joburi
VALUES ('J1','Asistent_HR',6);
INSERT INTO joburi
VALUES ('J2','Programator',6);
INSERT INTO joburi
VALUES ('J3','Project_Manager',10);
INSERT INTO joburi
VALUES ('J4','Consultant',2);
INSERT INTO joburi
VALUES ('J5','Tehnician Securitate',5);
INSERT INTO joburi
VALUES ('J6','Mecanic auto',8);


commit;
select * from joburi;

--departamente
desc departament_transport_stc;
INSERT INTO departament_transport_stc (tip_transport, nume_departament)
VALUES ('DT0','Terestru_auto');
INSERT INTO departament_transport_stc (tip_transport, nume_departament)
VALUES ('DT1','Tren');
INSERT INTO departament_transport_stc (tip_transport, nume_departament)
VALUES ('DT2','Subteran');
INSERT INTO departament_transport_stc (tip_transport, nume_departament)
VALUES ('DT3','Nautic');
INSERT INTO departament_transport_stc (tip_transport, nume_departament)
VALUES ('DT4','Aerian');

commit;
select* from departament_transport_stc;

--sectii
desc sectii_stc;

INSERT INTO sectii_stc (cod_sectie, tip_transport, nume_sectie)
VALUES ('S0', 'DT0', 'autobuz');
INSERT INTO sectii_stc (cod_sectie, tip_transport, nume_sectie)
VALUES ('S1', 'DT0', 'troleibuz');
INSERT INTO sectii_stc (cod_sectie, tip_transport, nume_sectie)
VALUES ('S2', 'DT0', 'microbuz');
INSERT INTO sectii_stc (cod_sectie, tip_transport, nume_sectie)
VALUES ('S3', 'DT1', 'tren');
INSERT INTO sectii_stc (cod_sectie, tip_transport, nume_sectie)
VALUES ('S4', 'DT1', 'tramvai');
INSERT INTO sectii_stc (cod_sectie, tip_transport, nume_sectie)
VALUES ('S5', 'DT2', 'metrou');
INSERT INTO sectii_stc (cod_sectie, tip_transport, nume_sectie)
VALUES ('S6', 'DT2', 'metrou expres');
INSERT INTO sectii_stc (cod_sectie, tip_transport, nume_sectie)
VALUES ('S7', 'DT3', 'vaporas');
INSERT INTO sectii_stc (cod_sectie, tip_transport, nume_sectie)
VALUES ('S8', 'DT3', 'barca');
INSERT INTO sectii_stc (cod_sectie, tip_transport, nume_sectie)
VALUES ('S9', 'DT3', 'gondola');
INSERT INTO sectii_stc (cod_sectie, tip_transport, nume_sectie)
VALUES ('S10', 'DT3', 'hidrobicicleta');
INSERT INTO sectii_stc (cod_sectie, tip_transport, nume_sectie)
VALUES ('S11', 'DT4', 'parapanta');
INSERT INTO sectii_stc (cod_sectie, tip_transport, nume_sectie)
VALUES ('S12', 'DT4', 'elicopter');


select * from sectii_stc;
where tip_transport ='DT3';
commit;


--locatie

desc locatii_stc;
INSERT INTO locatii_stc
VALUES ('L0','Crangasi','Str. Ceahlaul, nr 3', '060371');
INSERT INTO locatii_stc
VALUES ('L1','Serban','Calea Serban Voda, nr 288', '040223');
INSERT INTO locatii_stc
VALUES ('L2','Manolescu','Str. Manolescu Grig, nr 2', '011234');
INSERT INTO locatii_stc
VALUES ('L3','Herastrau','Blv. Regele Mihai I', '015449');
INSERT INTO locatii_stc
VALUES ('L4','Vianu','Str. Arh. Ion Mincu', '018772');
INSERT INTO locatii_stc
VALUES ('L5','Gara de Nord','Blv. Dinicu Golescu', '060388');
INSERT INTO locatii_stc
VALUES ('L6','Dambovita','Splaiul Independentei', '025466');
INSERT INTO locatii_stc
VALUES ('L7','Aeroport Baneasa','Sos. Bucuresti-Ploiesti', '012211');
INSERT INTO locatii_stc
VALUES ('L8','Pantelimon','Str. Campului, nr 99', '039928');
INSERT INTO locatii_stc
VALUES ('L9','Aparatorii Patriei','Str. Dumitru Dumitru', '0552134');
INSERT INTO locatii_stc
VALUES ('L10','Parcul Sebastian','Calea 13 Septembrie, nr 4', '059912');


select * from locatii_stc;
commit;

--depouri
INSERT INTO depouri_stc
VALUES ('D0','Crangasi',302,'L0');
INSERT INTO depouri_stc
VALUES ('D1','Parcul Sebastian',700,'L10');
INSERT INTO depouri_stc
VALUES ('D2','Gara de nord',50,'L5');
INSERT INTO depouri_stc
VALUES ('D3','Herastrau',147,'L3');
INSERT INTO depouri_stc
VALUES ('D4','Aeroport Baneasa',45,'L7');

select* from depouri_stc;

--statii
desc statii_stc;
INSERT INTO statii_stc
VALUES ('St0','Crangasi','L0');
INSERT INTO statii_stc
VALUES ('St1','Serban','L1');
INSERT INTO statii_stc
VALUES ('St2','Manolescu','L2');
INSERT INTO statii_stc
VALUES ('St3','Herastrau','L3');
INSERT INTO statii_stc
VALUES ('St4','Vianu','L4');
INSERT INTO statii_stc
VALUES ('St5','Gara de Nord','L5');
INSERT INTO statii_stc
VALUES ('St6','Dambovita','L6');
INSERT INTO statii_stc
VALUES ('St7','Aeroport Baneasa','L7');

select * from sectii_stc;
commit;

--trasee
desc trasee_stc;

INSERT INTO trasee_stc
VALUES ('T0','St0','St7', 13, 'S0');
INSERT INTO trasee_stc
VALUES ('T1','St5','St7', 10, 'S2');
INSERT INTO trasee_stc
VALUES ('T2','St4','St3', 4, 'S4');
INSERT INTO trasee_stc
VALUES ('T3','St3','St6', 15, 'S7');
INSERT INTO trasee_stc
VALUES ('T4','St1','St2', 25, 'S6');
INSERT INTO trasee_stc
VALUES ('T5','St1','St7', 20, 'S12');

select *from trasee_stc;

--filiale
desc filiale_stc;

INSERT INTO filiale_stc (cod_sectie, cod_locatie)
VALUES ('S0','L0');
INSERT INTO filiale_stc (cod_sectie, cod_locatie)
VALUES ('S0','L1');
INSERT INTO filiale_stc (cod_sectie, cod_locatie)
VALUES ('S1','L3');
INSERT INTO filiale_stc (cod_sectie, cod_locatie)
VALUES ('S1','L5');
INSERT INTO filiale_stc (cod_sectie, cod_locatie)
VALUES ('S1','L6');
INSERT INTO filiale_stc (cod_sectie, cod_locatie)
VALUES ('S2','L8');
INSERT INTO filiale_stc (cod_sectie, cod_locatie)
VALUES ('S2','L9');
INSERT INTO filiale_stc (cod_sectie, cod_locatie)
VALUES ('S10','L10');
INSERT INTO filiale_stc (cod_sectie, cod_locatie)
VALUES ('S10','L7');
INSERT INTO filiale_stc (cod_sectie, cod_locatie)
VALUES ('S8','L4');
INSERT INTO filiale_stc (cod_sectie, cod_locatie)
VALUES ('S8','L8');

select * from filiale_stc;
commit;

--statie unica
desc statie_unica_stc;

INSERT INTO statie_unica_stc
VALUES ('St0','T0');
INSERT INTO statie_unica_stc
VALUES ('St0','T0');
INSERT INTO statie_unica_stc
VALUES ('St1','T0');
INSERT INTO statie_unica_stc
VALUES ('St1','T1');
INSERT INTO statie_unica_stc
VALUES ('St2','T4');
INSERT INTO statie_unica_stc
VALUES ('St2','T6');
INSERT INTO statie_unica_stc
VALUES ('St2','T5');
INSERT INTO statie_unica_stc
VALUES ('St3','T3');
INSERT INTO statie_unica_stc
VALUES ('St4','T3');
INSERT INTO statie_unica_stc
VALUES ('St5','T1');
INSERT INTO statie_unica_stc
VALUES ('St6','T0');

select * from statie_unica_stc;


--caracteristici

desc caracteristici_stc;
INSERT INTO caracteristici_stc (cod_caract, nr_locuri, nr_roti, seria, model, an)
VALUES (100,40,4,'rx33','infinitybus',TO_DATE('17/dec/2015', 'DD/MON/YYYY'));
INSERT INTO caracteristici_stc (cod_caract, nr_locuri, nr_roti, seria, model, an)
VALUES (101,45,4,'rx34','infinitybus2',TO_DATE('17/dec/2023', 'DD/MON/YYYY'));
INSERT INTO caracteristici_stc (cod_caract, nr_locuri, nr_roti, seria, model, an)
VALUES (102,20,4,'qqq0','legendtrolley',TO_DATE('12/mar/2005', 'DD/MON/YYYY'));
INSERT INTO caracteristici_stc (cod_caract, nr_locuri, nr_roti, seria, model, an, combustibil)
VALUES (103,3,0,'5005','hydra',TO_DATE('1/jan/2010', 'DD/MON/YYYY'), 'fara');
INSERT INTO caracteristici_stc (cod_caract, nr_locuri, nr_roti, seria, model, an, combustibil)
VALUES (104,6,0,'po21','hydra',TO_DATE('17/aug/2008', 'DD/MON/YYYY'), 'fara');
INSERT INTO caracteristici_stc (cod_caract, nr_locuri, nr_roti, seria, model, an,combustibil)
VALUES (105,4,3,'aero','eagleland',TO_DATE('28/may/2020', 'DD/MON/YYYY'), 'diesel');
INSERT INTO caracteristici_stc (cod_caract, nr_locuri, nr_roti, seria, model, an,combustibil)
VALUES (106,50,16,'rr41','railmonster',TO_DATE('2/may/2001', 'DD/MON/YYYY'), 'electric');
INSERT INTO caracteristici_stc (cod_caract, nr_locuri, nr_roti, seria, model, an,combustibil)
VALUES (107,50,16,'rr4i1','railmonster',TO_DATE('2/may/2001', 'DD/MON/YYYY'), 'electric');



commit;
select *from caracteristici_stc;

--tipuri vehicule

desc tipuri_vehicule_stc;

INSERT INTO tipuri_vehicule_stc
VALUES('TV0','autobuz','bus2000');
INSERT INTO tipuri_vehicule_stc
VALUES('TV1','troleibuz','bus2000');
INSERT INTO tipuri_vehicule_stc
VALUES('TV2','tramvai','rail++');
INSERT INTO tipuri_vehicule_stc
VALUES('TV3','caiac','hidrofun');
INSERT INTO tipuri_vehicule_stc
VALUES('TV4','barca','hidrofun');
INSERT INTO tipuri_vehicule_stc
VALUES('TV5','elicopter','The Bold Eagle');
INSERT INTO tipuri_vehicule_stc
VALUES('TV6','tren','rail++');
INSERT INTO tipuri_vehicule_stc
VALUES('TV7','metrou','rail++');
INSERT INTO tipuri_vehicule_stc
VALUES('TV8','microbuz','bus2000');

select * from tipuri_vehicule_stc;
commit;

--caracteristica_tip
desc caracteristica_tip;

INSERT INTO caracteristica_tip
VALUES (100,'TV0',TO_DATE('17/dec/2015', 'DD/MON/YYYY'),TO_DATE('16/dec/2023', 'DD/MON/YYYY'));
INSERT INTO caracteristica_tip (cod_caract, cod_tip_vehicul, data_start)
VALUES (101,'TV0',TO_DATE('17/dec/2023', 'DD/MON/YYYY'));
INSERT INTO caracteristica_tip
VALUES (107,'TV7',TO_DATE('2/may/2001', 'DD/MON/YYYY'),TO_DATE('2/may/2003', 'DD/MON/YYYY'));
INSERT INTO caracteristica_tip
VALUES (106,'TV7',TO_DATE('3/may/2003', 'DD/MON/YYYY'),TO_DATE('1/may/2005', 'DD/MON/YYYY'));
INSERT INTO caracteristica_tip
VALUES (107,'TV7',TO_DATE('2/may/2005', 'DD/MON/YYYY'),TO_DATE('2/may/2009', 'DD/MON/YYYY'));
INSERT INTO caracteristica_tip(cod_caract, cod_tip_vehicul, data_start)
VALUES (107,'TV6',TO_DATE('3/may/2001', 'DD/MON/YYYY'));
INSERT INTO caracteristica_tip(cod_caract, cod_tip_vehicul, data_start)
VALUES (102,'TV1',TO_DATE('12/mar/2005', 'DD/MON/YYYY'));
INSERT INTO caracteristica_tip(cod_caract, cod_tip_vehicul, data_start)
VALUES (107,'TV2',TO_DATE('3/may/2001', 'DD/MON/YYYY'));
INSERT INTO caracteristica_tip(cod_caract, cod_tip_vehicul, data_start)
VALUES (103,'TV3',TO_DATE('1/jan/2010', 'DD/MON/YYYY'));
INSERT INTO caracteristica_tip(cod_caract, cod_tip_vehicul, data_start)
VALUES (104,'TV4',TO_DATE('17/aug/2008', 'DD/MON/YYYY'));

INSERT INTO caracteristica_tip(cod_caract, cod_tip_vehicul, data_start)
VALUES (105,'TV5',TO_DATE('28/may/2020', 'DD/MON/YYYY'));
INSERT INTO caracteristica_tip(cod_caract, cod_tip_vehicul, data_start)
VALUES (100,'TV8',TO_DATE('17/dec/2015', 'DD/MON/YYYY'));


select *from caracteristica_tip;

--vehicule
desc vehicule_stc;
INSERT INTO vehicule_stc
VALUES ('B-45-BUS','TV0','D0');
INSERT INTO vehicule_stc
VALUES ('B-46-BUS','TV0','D0');
INSERT INTO vehicule_stc
VALUES ('B-03-TRO','TV1','D0');
INSERT INTO vehicule_stc
VALUES ('B-04-TRO','TV1','D0');
INSERT INTO vehicule_stc
VALUES ('B-41-RAM','TV2','D1');
INSERT INTO vehicule_stc
VALUES ('B-11-RAM','TV2','D1');
INSERT INTO vehicule_stc
VALUES ('B-00-CAY','TV3','D3');
INSERT INTO vehicule_stc
VALUES ('B-01-CAY','TV3','D3');
INSERT INTO vehicule_stc
VALUES ('B-02-CAY','TV3','D3');
INSERT INTO vehicule_stc
VALUES ('B-04-CAY','TV3','D3');
INSERT INTO vehicule_stc
VALUES ('B-00-BAR','TV4','D3');
INSERT INTO vehicule_stc
VALUES ('B-01-BAR','TV4','D3');
INSERT INTO vehicule_stc
VALUES ('B-0-HELL','TV5','D4');
INSERT INTO vehicule_stc
VALUES ('B-1-HELL','TV5','D4');
INSERT INTO vehicule_stc
VALUES ('B-3-HELL','TV5','D4');
INSERT INTO vehicule_stc
VALUES ('B-99-REN','TV6','D2');
INSERT INTO vehicule_stc
VALUES ('B-97-REN','TV6','D2');
INSERT INTO vehicule_stc
VALUES ('B-92-REN','TV6','D2');
INSERT INTO vehicule_stc
VALUES ('B-30-MTR','TV7','D2');
INSERT INTO vehicule_stc
VALUES ('B-31-MTR','TV7','D2');
INSERT INTO vehicule_stc
VALUES ('B-66-MIC','TV8','D0');
COMMIT;
SELECT * FROM vehicule_stc;

--angajati

desc angajati_stc;
select *from angajati_stc;

INSERT INTO angajati_stc (cod_angajat,nume,data_angajare,salariu, cod_sectie)
VALUES ('A0','Augustus',to_date('12/dec/1990','dd/mon/yyyy'), 10000,'S0');
INSERT INTO angajati_stc (cod_angajat,nume,data_angajare,salariu, cod_sectie)
VALUES ('A1','Bartolomeu',to_date('12/dec/1990','dd/mon/yyyy'), 10000,'S1');
INSERT INTO angajati_stc (cod_angajat,nume,data_angajare,salariu, cod_sectie)
VALUES ('A2','Cicero',to_date('12/dec/1990','dd/mon/yyyy'), 10000,'S2');
INSERT INTO angajati_stc (cod_angajat,nume,data_angajare,salariu, cod_sectie)
VALUES ('A3','Dionys',to_date('12/dec/1990','dd/mon/yyyy'), 10000,'S3');
INSERT INTO angajati_stc (cod_angajat,nume,data_angajare,salariu, cod_sectie)
VALUES ('A4','Elena',to_date('12/dec/1990','dd/mon/yyyy'), 10000,'S4');
INSERT INTO angajati_stc (cod_angajat,nume,data_angajare,salariu, cod_sectie)
VALUES ('A5','Faust',to_date('12/dec/1990','dd/mon/yyyy'), 10000,'S5');
INSERT INTO angajati_stc (cod_angajat,nume,data_angajare,salariu, cod_sectie)
VALUES ('A6','Gregorio',to_date('12/dec/1990','dd/mon/yyyy'), 10000,'S6');
INSERT INTO angajati_stc (cod_angajat,nume,data_angajare,salariu, cod_sectie)
VALUES ('A7','Heracle',to_date('12/dec/1990','dd/mon/yyyy'), 10000,'S7');
INSERT INTO angajati_stc (cod_angajat,nume,data_angajare,salariu, cod_sectie)
VALUES ('A8','Iulius',to_date('12/dec/1990','dd/mon/yyyy'), 10000,'S8');
INSERT INTO angajati_stc (cod_angajat,nume,data_angajare,salariu, cod_sectie)
VALUES ('A9','Juna',to_date('12/dec/1990','dd/mon/yyyy'), 10000,'S9');
INSERT INTO angajati_stc (cod_angajat,nume,data_angajare,salariu, cod_sectie)
VALUES ('A10','Klaus',to_date('12/dec/1990','dd/mon/yyyy'), 10000,'S10');
INSERT INTO angajati_stc (cod_angajat,nume,data_angajare,salariu, cod_sectie)
VALUES ('A11','Lucretia',to_date('12/dec/1990','dd/mon/yyyy'), 10000,'S11');
INSERT INTO angajati_stc (cod_angajat,nume,data_angajare,salariu, cod_sectie)
VALUES ('A12','Manolo',to_date('12/dec/1990','dd/mon/yyyy'), 10000,'S12');

INSERT INTO angajati_stc 
VALUES ('A13','Nero',to_date('12/dec/1995','dd/mon/yyyy'), 8000,'A0','S0');
INSERT INTO angajati_stc 
VALUES ('A14','Ophelia',to_date('12/dec/1995','dd/mon/yyyy'), 8000,'A1','S1');
INSERT INTO angajati_stc 
VALUES ('A15','Patrocle',to_date('12/dec/1995','dd/mon/yyyy'), 8000,'A2','S2');
INSERT INTO angajati_stc 
VALUES ('A16','Quince',to_date('12/dec/1995','dd/mon/yyyy'), 8000,'A3','S3');
INSERT INTO angajati_stc 
VALUES ('A17','Ruth',to_date('12/dec/1995','dd/mon/yyyy'), 8000,'A4','S4');
INSERT INTO angajati_stc 
VALUES ('A18','Santos',to_date('12/dec/1995','dd/mon/yyyy'), 8000,'A5','S5');
INSERT INTO angajati_stc 
VALUES ('A19','Tremaine',to_date('12/dec/1995','dd/mon/yyyy'), 8000,'A6','S6');
INSERT INTO angajati_stc 
VALUES ('A20','Ulise',to_date('12/dec/1995','dd/mon/yyyy'), 8000,'A7','S7');
INSERT INTO angajati_stc 
VALUES ('A21','Venetia',to_date('12/dec/1995','dd/mon/yyyy'), 8000,'A8','S8');
INSERT INTO angajati_stc 
VALUES ('A22','Waldo',to_date('12/dec/1995','dd/mon/yyyy'), 8000,'A9','S9');
INSERT INTO angajati_stc 
VALUES ('A23','Xenia',to_date('12/dec/1995','dd/mon/yyyy'), 8000,'A10','S10');
INSERT INTO angajati_stc 
VALUES ('A24','Yuri',to_date('12/dec/1995','dd/mon/yyyy'), 8000,'A11','S11');
INSERT INTO angajati_stc 
VALUES ('A25','Zenobia',to_date('12/dec/1995','dd/mon/yyyy'), 8000,'A12','S12');


UPDATE angajati_stc
SET cod_sectie = 'S0', cod_locatie= 'L0'
where cod_angajat='A0';
UPDATE angajati_stc
SET cod_sectie = 'S1', cod_locatie= 'L3'
where cod_angajat='A1';
UPDATE angajati_stc
SET cod_sectie = 'S2', cod_locatie= 'L8'
where cod_angajat='A2';
UPDATE angajati_stc
SET cod_sectie = 'S3'
where cod_angajat='A3';
UPDATE angajati_stc
SET cod_sectie = 'S4'
where cod_angajat='A4';
UPDATE angajati_stc
SET cod_sectie = 'S5'
where cod_angajat='A5';
UPDATE angajati_stc
SET cod_sectie = 'S6'
where cod_angajat='A6';
UPDATE angajati_stc
SET cod_sectie = 'S7'
where cod_angajat='A7';
UPDATE angajati_stc
SET cod_sectie = 'S8', cod_locatie= 'L4'
where cod_angajat='A8';
UPDATE angajati_stc
SET cod_sectie = 'S9'
where cod_angajat='A9';
UPDATE angajati_stc
SET cod_sectie = 'S10', cod_locatie= 'L10'
where cod_angajat='A10';
UPDATE angajati_stc
SET cod_sectie = 'S11'
where cod_angajat='A11';
UPDATE angajati_stc
SET cod_sectie = 'S12'
where cod_angajat='A12';
UPDATE angajati_stc
SET cod_sectie = 'S0', cod_locatie= 'L1'
where cod_angajat='A13';
UPDATE angajati_stc
SET cod_sectie = 'S1', cod_locatie= 'L6'
where cod_angajat='A14';
UPDATE angajati_stc
SET cod_sectie = 'S2', cod_locatie= 'L9'
where cod_angajat='A15';
UPDATE angajati_stc
SET cod_sectie = 'S3'
where cod_angajat='A16';
UPDATE angajati_stc
SET cod_sectie = 'S4'
where cod_angajat='A17';
UPDATE angajati_stc
SET cod_sectie = 'S5'
where cod_angajat='A18';
UPDATE angajati_stc
SET cod_sectie = 'S6'
where cod_angajat='A19';
UPDATE angajati_stc
SET cod_sectie = 'S7'
where cod_angajat='A20';
UPDATE angajati_stc
SET cod_sectie = 'S8', cod_locatie= 'L8'
where cod_angajat='A21';
UPDATE angajati_stc
SET cod_sectie = 'S9'
where cod_angajat='A22';
UPDATE angajati_stc
SET cod_sectie = 'S10', cod_locatie= 'L7'
where cod_angajat='A23';
UPDATE angajati_stc
SET cod_sectie = 'S11'
where cod_angajat='A24';
UPDATE angajati_stc
SET cod_sectie = 'S12'
where cod_angajat='A25';
UPDATE angajati_stc
SET cod_sectie = 'S13'
where cod_angajat='A26';
commit;

UPDATE sectii_stc
SET responsabil='A0'
where cod_sectie='S0';
UPDATE sectii_stc
SET responsabil='A1'
where cod_sectie='S1';
UPDATE sectii_stc
SET responsabil='A2'
where cod_sectie='S2';
UPDATE sectii_stc
SET responsabil='A3'
where cod_sectie='S3';
UPDATE sectii_stc
SET responsabil='A4'
where cod_sectie='S4';
UPDATE sectii_stc
SET responsabil='A5'
where cod_sectie='S5';
UPDATE sectii_stc
SET responsabil='A6'
where cod_sectie='S6';
UPDATE sectii_stc
SET responsabil='A7'
where cod_sectie='S7';
UPDATE sectii_stc
SET responsabil='A8'
where cod_sectie='S8';
UPDATE sectii_stc
SET responsabil='A9'
where cod_sectie='S9';
UPDATE sectii_stc
SET responsabil='A10'
where cod_sectie='S10';
UPDATE sectii_stc
SET responsabil='A11'
where cod_sectie='S11';
UPDATE sectii_stc
SET responsabil='A12'
where cod_sectie='S12';

select * from sectii_stc;
commit;

select * from departament_transport_stc;
commit;

UPDATE departament_transport_stc
SET responsabil='A0'
WHERE tip_transport='DT0';
UPDATE departament_transport_stc
SET responsabil='A3'
WHERE tip_transport='DT1';
UPDATE departament_transport_stc
SET responsabil='A6'
WHERE tip_transport='DT2';
UPDATE departament_transport_stc
SET responsabil='A9'
WHERE tip_transport='DT3';
UPDATE departament_transport_stc
SET responsabil='A12'
WHERE tip_transport='DT4';

--updatam responsabilii pe angajati cu responsabil fiind responsabil de departament
select * from angajati_stc;
select * from sectii_stc;

UPDATE angajati_stc a
set cod_sef = (select d.responsabil
                from departament_transport_stc d join sectii_stc s on(d.tip_transport=s.tip_transport)
                where s.cod_sectie=a.cod_sectie and cod_angajat!=d.responsabil)
where salariu>8000;

select * from sofer_stc;
desc sofer_stc;
INSERT INTO sofer_stc (cod_angajat)
        SELECT cod_angajat 
        from angajati_stc
        WHERE salariu=8000
;

----sectii
----update filiale
select*from filiale_stc;
UPDATE filiale_stc f
set responsabil = (select responsabil
                  from sectii_stc
                  where cod_sectie= f.cod_sectie);
commit;
-----------------
desc obisnuit_stc;

select * from OBISNUIT_STC;
INSERT INTO obisnuit_stc
VALUES ('A0','J3');
INSERT INTO obisnuit_stc
VALUES ('A1','J1');
INSERT INTO obisnuit_stc
VALUES ('A2','J2');
INSERT INTO obisnuit_stc
VALUES ('A3','J3');
INSERT INTO obisnuit_stc
VALUES ('A4','J1');
INSERT INTO obisnuit_stc
VALUES ('A5','J5');
INSERT INTO obisnuit_stc
VALUES ('A6','J3');
INSERT INTO obisnuit_stc
VALUES ('A7','J6');
INSERT INTO obisnuit_stc
VALUES ('A8','J1');
INSERT INTO obisnuit_stc
VALUES ('A9','J3');
INSERT INTO obisnuit_stc
VALUES ('A10','J4');
INSERT INTO obisnuit_stc
VALUES ('A11','J0');
INSERT INTO obisnuit_stc
VALUES ('A12','J3');


DESC vehicul_traseu_sofer;
select * from vehicul_TRASEU_SOFER;

INSERT INTO vehicul_traseu_sofer
VALUES ('A13','B-45-BUS','T0');
INSERT INTO vehicul_traseu_sofer
VALUES ('A13','B-46-BUS','T0');
INSERT INTO vehicul_traseu_sofer
VALUES ('A14','B-04-TRO','T0');
INSERT INTO vehicul_traseu_sofer
VALUES ('A14','B-04-TRO','T5');
INSERT INTO vehicul_traseu_sofer
VALUES ('A15','B-66-MIC','T3');
INSERT INTO vehicul_traseu_sofer
VALUES ('A16','B-99-REN','T4');
INSERT INTO vehicul_traseu_sofer
VALUES ('A16','B-99-REN','T3');
INSERT INTO vehicul_traseu_sofer
VALUES ('A16','B-92-REN','T1');
INSERT INTO vehicul_traseu_sofer
VALUES ('A16','B-97-REN','T4');
INSERT INTO vehicul_traseu_sofer
VALUES ('A17','B-41-RAM','T0');
INSERT INTO vehicul_traseu_sofer
VALUES ('A18','B-30-MTR','T2');
INSERT INTO vehicul_traseu_sofer
VALUES ('A19','B-31-MTR','T2');
INSERT INTO vehicul_traseu_sofer
VALUES ('A19','B-30-MTR','T2');
INSERT INTO vehicul_traseu_sofer
VALUES ('A20','B-00-BAR','T4');
INSERT INTO vehicul_traseu_sofer
VALUES ('A21','B-01-BAR','T4');
INSERT INTO vehicul_traseu_sofer
VALUES ('A22','B-00-CAY','T2');
INSERT INTO vehicul_traseu_sofer
VALUES ('A23','B-00-CAY','T2');
INSERT INTO vehicul_traseu_sofer
VALUES ('A23','B-04-CAY','T2');
INSERT INTO vehicul_traseu_sofer
VALUES ('A24','B-0-HELL','T5');
INSERT INTO vehicul_traseu_sofer
VALUES ('A25','B-1-HELL','T5');
INSERT INTO vehicul_traseu_sofer
VALUES ('A25','B-3-HELL','T3');

COMMIT;

UPDATE caracteristica_tip
set data_expirare=null where data_expirare=to_date('02-MAY-09');
