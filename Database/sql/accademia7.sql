-- 1. Qual è media e deviazione standard degli stipendi per ogni categoria di strutturati?
select posizione, avg(stipendio) as media_stipendio, stddev(stipendio) as deviazione_standard
from persona
group by posizione;

-- 2. Quali sono i ricercatori (tutti gli attributi) con uno stipendio superiore alla media
-- della loro categoria?
with stipendioMedio as (
    select posizione, avg(stipendio) as media_stipendio
    from persona
    where posizione = 'Ricercatore'
    group by posizione
)
select p.*
from persona p
join stipendioMedio m on p.posizione = m.posizione
where p.stipendio > m.media_stipendio and p.posizione = 'Ricercatore';

-- 3. Per ogni categoria di strutturati quante sono le persone con uno stipendio che
-- differisce di al massimo una deviazione standard dalla media della loro categoria?
with statistiche as (
    select posizione, avg(stipendio) as media_stipendio, stddev(stipendio) as deviazione_standard
    from persona
    group by posizione
),
filtro as (
    select p.*, s.media_stipendio, s.deviazione_standard
    from persona p
    join statistiche s on p.posizione = s.posizione
    where abs(p.stipendio - s.media_stipendio) <= s.deviazione_standard
)
select posizione, count(*) as numero_persone
from filtro
group by posizione;

-- 4. Chi sono gli strutturati che hanno lavorato almeno 20 ore complessive in attività
-- progettuali? Restituire tutti i loro dati e il numero di ore lavorate.
select p.*, sum(ap.oreDurata) as ore_lavorate
from persona p
join attivitaProgetto ap on p.id = ap.persona
group by p.id
having sum(ap.oreDurata) >= 20;

-- 5. Quali sono i progetti la cui durata è superiore alla media delle durate di tutti i
-- progetti? Restituire nome dei progetti e loro durata in giorni.
with durateProgetti as(
    select id, nome, fine - inizio as durata
    from progetto
),
mediaDurata as (
    select avg(durata) as media_durata
    from durateProgetti
)
select nome, durata
from durateProgetti
join mediaDurata md on durata > md.media_durata;

-- 6. Quali sono i progetti terminati in data odierna che hanno avuto attività di tipo
-- “Dimostrazione”? Restituire nome di ogni progetto e il numero complessivo delle
-- ore dedicate a tali attività nel progetto.
select p.nome, sum(ap.oreDurata) as ore_dimostrazione
from progetto p
join attivitaProgetto ap on p.id = ap.progetto
where p.fine <= current_date and ap.tipo = 'Dimostrazione'
group by p.nome;

-- 7. Quali sono i professori ordinari che hanno fatto più assenze per malattia
-- del numero di assenze medio per malattia dei professori associati?
-- Restituire id, nome e cognome del professore e il numero di giorni di assenza per malattia.
with assenzeMalattia as (
    select p.id, p.nome, p.cognome, count(*) as num_giorni_assenza
    from persona p
    join assenza a on p.id = a.persona
    where a.tipo = 'Malattia'
    group by p.id
),
mediaAssenzeMalattia as (
    select avg(num_giorni_assenza) as media_assenze
    from assenzeMalattia a
    join persona p on p.id = a.id
    where p.posizione = 'Professore Associato'
)
select p.id, p.nome, p.cognome, a.num_giorni_assenza
from persona p
join assenzeMalattia a on p.id = a.id
join mediaAssenzeMalattia md on a.num_giorni_assenza > md.media_assenze
where p.posizione = 'Professore Ordinario';
