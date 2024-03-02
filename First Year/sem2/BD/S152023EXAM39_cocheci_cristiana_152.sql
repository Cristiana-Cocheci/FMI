--Cocheci Cristiana 152


1.

SELECT * from turist;
select * from rezervare;
select * from camera;
select * from tarif_camera;
select * from turist_rezervare;
desc turist;
desc camera;

select t.id, prenume, c.id, r.data_rezervare, c.nr_camera, tc.tarif;


        
select distinct t.id "Cod turist", prenume "Prenume turist",c.id "Cod camera", r.data_rezervare "Data rezervare", c.nr_camera "Nr. camera", tc.tarif "Tarif camera"
from turist t join turist_rezervare tr on(t.id=tr.id_turist)
              right join rezervare r on(tr.id_rezervare=r.id)
              join camera c on (r.id_camera=c.id)
              join tarif_camera tc on(c.id= tc.id_camera)
where data_start<=data_rezervare and (data_rezervare+nr_zile)<=data_end
order by 1,2,3,4,5,6;

 --de revenit la 1             
              

2.
select * from turist;

--numar de turisti pe hotel
select denumire, count(distinct (t.id)) nrturisti
from turist t join turist_rezervare tr on(t.id=tr.id_turist)
              join rezervare r on(tr.id_rezervare=r.id)
              join camera c on (r.id_camera=c.id)
              join tarif_camera tc on(c.id= tc.id_camera)
              join hotel h on(c.id_hotel=h.id)
group by h.denumire
order by 2 desc;


---numar maxim de turisti la un hotel
select max(nrturisti)
from (select denumire, count(distinct (t.id)) nrturisti
from turist t join turist_rezervare tr on(t.id=tr.id_turist)
              join rezervare r on(tr.id_rezervare=r.id)
              join camera c on (r.id_camera=c.id)
              join tarif_camera tc on(c.id= tc.id_camera)
              join hotel h on(c.id_hotel=h.id)
group by h.denumire
order by 2 desc);


--cost total al rezervarilor care au durat 1 zi
select sum(tc.tarif), denumire
from hotel h join camera c on (h.id=c.id_hotel)
             join tarif_camera tc on(c.id=tc.id_camera)
             join rezervare r on (r.id_camera=c.id)
where r.nr_zile=1
group by h.denumire;

--rezolvare exercitiu
select id, denumire , (
                        select sum(tc.tarif)
                        from hotel h join camera c on (h.id=c.id_hotel)
                                     join tarif_camera tc on(c.id=tc.id_camera)
                                     join rezervare r on (r.id_camera=c.id)
                        where r.nr_zile=1
                         and h_ext.id=h.id
) "Suma tarif"
from hotel h_ext
where (select count(distinct (t.id)) nrturisti
from turist t join turist_rezervare tr on(t.id=tr.id_turist)
              join rezervare r on(tr.id_rezervare=r.id)
              join camera c on (r.id_camera=c.id)
              join tarif_camera tc on(c.id= tc.id_camera)
              join hotel h on(c.id_hotel=h.id)
where h_ext.denumire=denumire) = (select max(nrturisti)
                                    from (select denumire, count(distinct (t.id)) nrturisti
                                    from turist t join turist_rezervare tr on(t.id=tr.id_turist)
                                                  join rezervare r on(tr.id_rezervare=r.id)
                                                  join camera c on (r.id_camera=c.id)
                                                  join tarif_camera tc on(c.id= tc.id_camera)
                                                  join hotel h on(c.id_hotel=h.id)
                                    group by h.denumire
                                    order by 2 desc));

--hotel cu nr max de turisti
select denumire, count(distinct (t.id)) nrturisti
from turist t join turist_rezervare tr on(t.id=tr.id_turist)
              join rezervare r on(tr.id_rezervare=r.id)
              join camera c on (r.id_camera=c.id)
              join tarif_camera tc on(c.id= tc.id_camera)
              join hotel h on(c.id_hotel=h.id)
group by h.denumire;



3.

--rezervari din iunie-august
select to_char(data_rezervare), r.nr_zile
from turist_rezervare tr join rezervare r on(tr.id_rezervare=r.id)
where to_char(data_rezervare) like '%JUN%'  
    or to_char(data_rezervare) like '%JUL%'
    or to_char(data_rezervare) like '%AUG%';

--rezervari in afara intervalului
select to_char(data_rezervare), r.nr_zile
from turist_rezervare tr join rezervare r on(tr.id_rezervare=r.id)
where to_char(data_rezervare)  not like '%JUN%'  
    and to_char(data_rezervare) not like '%JUL%'
    and to_char(data_rezervare) not like '%AUG%';
    
--turisti cu rezervari in iunie-august
select t.id "Cod turist", prenume "Prenume turist", nume "Nume turist"
from turist t join turist_rezervare tr on(t.id=tr.id_turist)
              join rezervare r on(tr.id_rezervare=r.id)
where r.data_rezervare in (
                            select data_rezervare
                            from turist_rezervare tr join rezervare r on(tr.id_rezervare=r.id)
                            where to_char(data_rezervare) like '%JUN%'  
                                 or to_char(data_rezervare) like '%JUL%'
                                or to_char(data_rezervare) like '%AUG%'
)
minus

--turisti cu rezervari in alte perioade
select t.id "Cod turist", prenume "Prenume turist", nume "Nume turist"
from turist t join turist_rezervare tr on(t.id=tr.id_turist)
              join rezervare r on(tr.id_rezervare=r.id)
where r.data_rezervare in (
                            select data_rezervare
                            from turist_rezervare tr join rezervare r on(tr.id_rezervare=r.id)
                            where to_char(data_rezervare)  not like '%JUN%'  
                                and to_char(data_rezervare) not like '%JUL%'
                                and to_char(data_rezervare) not like '%AUG%'
)
order by 1;

--se putea si cu o functie a carei sintaxa nu mi o aduc aminte, ceva between jun si aug la date

4.
desc turist;

create table numar_rezervari(
    nume VARCHAR2(25),
    prenume VARCHAR(25),
    data_cazare DATE,
    numar_rezervari NUMBER(5)
);

----numar total de rezervari facute de fiecare turist 
select count(r.id)
from turist t join turist_rezervare tr on(t.id=tr.id_turist)
              join rezervare r on(tr.id_rezervare=r.id)
group by nume, prenume;


--date de inserat in tabel
select nume , prenume , data_rezervare , (
                        select count(r.id)
                        from turist t join turist_rezervare tr on(t.id=tr.id_turist)
                                      right join rezervare r on(tr.id_rezervare=r.id)
                        where t_ext.nume=nume and t_ext.prenume=prenume) "numar_rezervari"
from turist t_ext join turist_rezervare tr on(t_ext.id=tr.id_turist)
              join rezervare r on(tr.id_rezervare=r.id)
order by 1,2,3,4;

select * from numar_rezervari;

WITH aux AS 
 (select nume , prenume , data_rezervare , (
                        select count(r.id)
                        from turist t join turist_rezervare tr on(t.id=tr.id_turist)
                                      join rezervare r on(tr.id_rezervare=r.id)
                        where t_ext.nume=nume and t_ext.prenume=prenume) numar_rezervari
from turist t_ext join turist_rezervare tr on(t_ext.id=tr.id_turist)
              join rezervare r on(tr.id_rezervare=r.id)
order by 1,2,3,4);




insert into numar_rezervari (select nume, prenume, data_rezervare, numar_rezervari 
                                    from (select nume , prenume , data_rezervare , (
                                                            select count(r.id)
                                                            from turist t join turist_rezervare tr on(t.id=tr.id_turist)
                                                                          right join rezervare r on(tr.id_rezervare=r.id)
                                                            where t_ext.nume=nume and t_ext.prenume=prenume) numar_rezervari
                                    from turist t_ext join turist_rezervare tr on(t_ext.id=tr.id_turist)
                                                  join rezervare r on(tr.id_rezervare=r.id)
                                    order by 1,2,3,4));




