--EXXERCITII SQL

--13. UPDATE-uri cu subcereri

--1. updatam responsabilii pe angajati cu responsabil fiind responsabil de departament
select * from angajati_stc;
select * from sectii_stc;

UPDATE angajati_stc a
set cod_sef = (select d.responsabil
                from departament_transport_stc d join sectii_stc s on(d.tip_transport=s.tip_transport)
                where s.cod_sectie=a.cod_sectie and cod_angajat!=d.responsabil)
where salariu>8000;

-------------
UPDATE caracteristica_tip
set data_expirare=null where data_expirare=to_date('02-MAY-09');
-----
----2. update filiale
select*from filiale_stc;
UPDATE filiale_stc f
set responsabil = (select responsabil
                  from sectii_stc
                  where cod_sectie= f.cod_sectie);
commit;
-----------------

---3. suprimare date din locatii - stergem locatiile in care nu se gasesc nici filiale nici depouri nici statii
INSERT INTO locatii_stc
VALUES ('L11','Nicaieri','Nicaieri, nr2', '000000');
select * from locatii_stc;

DELETE from locatii_stc
WHERE cod_locatie not in ((select cod_locatie
                          from filiale_stc)
                          union
                          (select cod_locatie
                          from statii_stc)
                          union
                          (select cod_locatie
                          from depouri_stc));



--EX 12

1. Care e suma numarului de locuri ale vehiculelor 
conduse de soferii din subordinea lui Gregorio sau a 
subordonatilor sai directi? Atentie! Caracteristicile trebuie sa fie
actuale, nu unele expirate!

select * from caracteristici_stc;
select * from angajati_stc;

--subordonatii lui gregorio directi + indirecti
select cod_angajat
from angajati_stc
where cod_sef = (
                  select cod_angajat
                  from angajati_stc
                  where upper(nume) like 'GREGORIO'
)
union

select cod_angajat
from angajati_stc
where cod_sef IN (
                    select cod_angajat
                    from angajati_stc
                    where cod_sef = (
                                      select cod_angajat
                                      from angajati_stc
                                      where upper(nume) like 'GREGORIO'
                 )
);

--vehiculele conduse de oamenii de mai sus

---rezolvarea exercitiu!!!!!!
---subcereri nesincronizate in clauza from, nvl, functie pe date (sysdate)
select sum(nr_locuri)
from(
select distinct v.nr_inmatriculare,nr_locuri, c.cod_caract, nvl(data_expirare,sysdate+1) exp
from vehicul_traseu_sofer v join (select cod_angajat
                                from angajati_stc
                                where cod_sef = (
                                                  select cod_angajat
                                                  from angajati_stc
                                                  where upper(nume) like 'GREGORIO'
                                                )
                                                union
                                                
                                                select cod_angajat
                                                from angajati_stc
                                                where cod_sef IN (
                                                                    select cod_angajat
                                                                    from angajati_stc
                                                                    where cod_sef = (
                                                                                      select cod_angajat
                                                                                      from angajati_stc
                                                                                      where upper(nume) like 'GREGORIO'
                                                                                    )
                                                                )
                                ) aux on (v.cod_angajat=aux.cod_angajat)
join vehicule_stc  v2 on (v.nr_inmatriculare= v2.nr_inmatriculare)
join tipuri_vehicule_stc tv on (v2.cod_tip_vehicul=tv.cod_tip_vehicul)
join caracteristica_tip c on (tv.cod_tip_vehicul=c.cod_tip_vehicul)
join caracteristici_stc car on (car.cod_caract=c.cod_caract)
where nvl(data_expirare,sysdate+1)>sysdate
);
------final rez exc 1


------------------------------
select* from vehicul_traseu_sofer;
--lungimea tuturor traseelor care trec printr-o statie
select ss.cod_statie, sum(lungime)
from statie_unica_stc s
join trasee_stc t on (s.cod_traseu= t.cod_traseu)
join statii_stc ss on (s.cod_statie=ss.cod_statie)
group by ss.cod_statie
order by 2 desc;

2. Calculati lungimea tuturor traseeelor care trec prin fiecare statie
frecventata subordonatii directi ai lui Dyonis.
--subcereri sincronizate, ordonari, 1 functie pe siruri (upper)
select cod_statie, (select sum(lungime)
                    from statie_unica_stc s
                    join trasee_stc t on (s.cod_traseu= t.cod_traseu)
                    join statii_stc ss on (s.cod_statie=ss.cod_statie)
                    where ss.cod_statie=statii.cod_statie
                    ) lungime
from (select distinct s.cod_statie from
vehicul_traseu_sofer vts join trasee_stc t on (vts.cod_traseu= t.cod_traseu)
 join statie_unica_stc s  on (s.cod_traseu= t.cod_traseu)
 join angajati_stc a on (vts.cod_angajat= a.cod_angajat)
 where a.cod_angajat in (select cod_angajat
                        from angajati_stc
                        where cod_sef = (select cod_angajat
                                            from angajati_stc a
                                            where upper(nume)='DIONYS'))
                                    ) statii
order by 2 desc;

select cod_angajat
from angajati_stc
where cod_sef = (select cod_angajat
                    from angajati_stc a
                    where upper(nume)='DIONYS');


-------------------------------
3. Pentru fiecare angajat al firmei afisati numarul de ore lucrate pe zi.
Despre soferi se stie ca lucreaza 7 ore pe zi stadard;
-- bloc de cerere, nvl, decode, ordonare
select * from angajati_stc;
select * from filiale_stc;
select * from joburi;

WITH temporar as(
                select a.cod_angajat, a.nume, nvl(j.cod_job,'SOF') cod_job, nvl(j.nume,'sofer') nume_job
                from angajati_stc a left join obisnuit_stc o on (a.cod_angajat=o.cod_angajat)
                                    left join joburi j on (o.cod_job=j.cod_job)
                )

select nume, DECODE (cod_job, 'SOF', 7, 
                (select ore_pe_zi from joburi 
                 where cod_job = temporar.cod_job)) "ore pe zi"
from temporar
order by 2 desc;

4. Media salariilor angajatilor care lucreaza in sectii care au filiale in locatii 
care au in codul postal secventa 99 si in care nu se afla niciun depou.

--grupari de date cu subcereri, functie grup, filtrare la nivel de grup
select cod_sectie, avg(salariu) avg_salarii
from angajati_stc
group by cod_sectie
having cod_sectie in(
                        select cod_sectie
                        from filiale_stc
                        where cod_locatie in (
                                                select cod_locatie 
                                                from locatii_stc l
                                                where cod_postal like '%99%'
                                                and cod_locatie not in 
                                                    (select cod_locatie 
                                                    from depouri_stc)
                                            )
                    );

5. Afisati suma numarului de roti a tipurilor vehiculelor din sistem. Se vor afisa separat sumele pentru vehiculele 
care nu se mai folosesc, fiecare data de expirare separat, iar cele inca actuale impreuna. Vor fi luate in considerare
numai vehiculele care au fost cumparate intr-o luna cu 31 de zile (data de start= data de cumparare).
--caracteristicile care au data strat intr o luna cu 31 de zile
-- doua fct pentru date, case, initcap (fct pe siruri), subcerere sincronizata

select *from caracteristica_tip;
select * from caracteristici_stc;

WITH info_date as (
            select  cod_caract,extract(day from(LAST_DAY(data_start))) ult_zi,    
                        CASE WHEN  data_expirare > (select max(data_start)
                                              from caracteristica_tip
                                              where ct.cod_tip_vehicul=cod_tip_vehicul)
                                            THEN 'something went wrong'
                        WHEN data_expirare <= (select max(data_start)
                                              from caracteristica_tip
                                              where ct.cod_tip_vehicul=cod_tip_vehicul)
                                            THEN to_char(data_expirare)
                        ELSE initcap('inca valabil')
                        END as data_expirare
            from caracteristica_tip ct
            where extract(day from(LAST_DAY(data_start)))=31
)
select sum(nr_roti), data_expirare
from info_date i join caracteristici_stc c on (c.cod_caract= i.cod_caract)
group by data_expirare;


15. 
--top n
1. Afisati primii 10 angajati din firma dupa lungimea numelui. 
select length(nume), nume 
from (
        select length(nume), nume
        from angajati_stc
        --where length(nume)>5
        order by 1 desc
)
where rownum<11;

--division
2. Afisati numele tuturor soferilor care conduc vehicule pe exact aceleasi trasee ca si Waldo.

select a.nume
from vehicul_traseu_sofer v join angajati_stc a on (v.cod_angajat=a.cod_angajat)
where cod_traseu in (  select cod_traseu
                       from vehicul_traseu_sofer vts join angajati_stc a on (vts.cod_angajat=a.cod_angajat)
                       where lower(nume) ='waldo')
and lower(a.nume) !='waldo'
and (select count(*)
     from vehicul_traseu_sofer
     where v.cod_angajat=cod_angajat)= (select count(*)
                                        from
                                           (select cod_traseu
                                           from vehicul_traseu_sofer vts join angajati_stc a on (vts.cod_angajat=a.cod_angajat)
                                           where lower(nume) ='waldo')
                                    );

--outer join pe 4 tabele
3. Afisati numarul de locatii, apoi in cate locatii diferite se afla sectiile, depourile si statiile.

select count(cod_locatie) locatii, count(cod_sectie) sectii, count(cod_depou) depouri, count (cod_statie) statii
from(
        select l.cod_locatie , f.cod_sectie, d.cod_depou, s.cod_statie
        from filiale_stc f right join locatii_stc l on (l.cod_locatie=f.cod_locatie)
                           left join depouri_stc d on (l.cod_locatie=d.cod_locatie)
                           left join statii_stc s on (s.cod_locatie=l.cod_locatie)
    );
    
    
    
    
desc departament_transport_stc;



-----ex 16 optimizare
select nume from
(
select *
from vehicul_traseu_sofer v join angajati_stc a on (v.cod_angajat=a.cod_angajat)
where cod_traseu in (  select cod_traseu
                       from vehicul_traseu_sofer vts join angajati_stc a on (vts.cod_angajat=a.cod_angajat)
                       where lower(nume) ='waldo')
and lower(a.nume) !='waldo'
and (select count(*)
     from vehicul_traseu_sofer
     where v.cod_angajat=cod_angajat)= (select count(*)
                                        from
                                           (select cod_traseu
                                           from vehicul_traseu_sofer vts join angajati_stc a on (vts.cod_angajat=a.cod_angajat)
                                           where lower(nume) ='waldo')
                                    ));
                                    
                                    
select * from trasee_stc;
select * from vehicul_traseu_sofer;


select sum(nr_locuri)
from(
select distinct v.nr_inmatriculare,nr_locuri, c.cod_caract, nvl(data_expirare,sysdate+1) exp
from vehicul_traseu_sofer v join (select cod_angajat
                                from angajati_stc
                                where cod_sef = (
                                                  select cod_angajat
                                                  from angajati_stc
                                                  where upper(nume) like 'GREGORIO'
                                                )
                                                union
                                                
                                                select cod_angajat
                                                from angajati_stc
                                                where cod_sef IN (
                                                                    select cod_angajat
                                                                    from angajati_stc
                                                                    where cod_sef = (
                                                                                      select cod_angajat
                                                                                      from angajati_stc
                                                                                      where upper(nume) like 'GREGORIO'
                                                                                    )
                                                                )
                                ) aux on (v.cod_angajat=aux.cod_angajat)
join vehicule_stc  v2 on (v.nr_inmatriculare= v2.nr_inmatriculare)
join tipuri_vehicule_stc tv on (v2.cod_tip_vehicul=tv.cod_tip_vehicul)
join caracteristica_tip c on (tv.cod_tip_vehicul=c.cod_tip_vehicul)
join caracteristici_stc car on (car.cod_caract=c.cod_caract)
where nvl(data_expirare,sysdate+1)>sysdate
);