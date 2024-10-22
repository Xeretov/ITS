-- 1. Quanti sono gli strutturati di ogni fascia?
select posizione, count(posizione)
from persona
group by posizione;

-- 2. Quanti sono gli strutturati con stipendio ≥ 40000?
select count(*)
from persona
where stipendio >= 40000;

-- 3. Quanti sono i progetti già finiti che superano il budget di 50000?
select count(*)
from progetto
where budget > 50000 and fine < CURRENT_DATE;

-- 4. Qual è la media, il massimo e il minimo delle ore delle attività relative al progetto
-- ‘Pegasus’ ?
select cast(avg(ap.oreDurata) as decimal(10,2)) as media, max(ap.oreDurata) as massimo, min(ap.oreDurata) as minimo
from attivitaProgetto ap, progetto p
where ap.progetto = p.id and p.nome = 'Pegasus';

-- 5. Quali sono le medie, i massimi e i minimi delle ore giornaliere dedicate al progetto
-- ‘Pegasus’ da ogni singolo docente?
select u.id, u.nome, u.cognome, cast(avg(ap.oreDurata) as decimal(10,2)) as media, max(ap.oreDurata) as massimo, min(ap.oreDurata) as minimo
from attivitaProgetto ap, progetto p, persona u
where ap.progetto = p.id and p.nome = 'Pegasus' and ap.persona = u.id
group by u.id;

-- 6. Qual è il numero totale di ore dedicate alla didattica da ogni docente?
select u.id, u.nome, u.cognome, sum(anp.oreDurata) as ore_didattica
from attivitaNonProgettuale anp, persona u
where anp.tipo = 'Didattica' and anp.persona = u.id
group by u.id;


-- 7. Qual è la media, il massimo e il minimo degli stipendi dei ricercatori?
select cast(avg(stipendio) as decimal(10,2)) as media, max(stipendio) as massimo, min(stipendio) as minimo
from persona
where posizione = 'Ricercatore';

-- 8. Quali sono le medie, i massimi e i minimi degli stipendi dei ricercatori, dei professori
-- associati e dei professori ordinari?
select posizione, cast(avg(stipendio) as decimal(10,2)) as media, max(stipendio) as massimo, min(stipendio) as minimo
from persona
group by posizione;

-- 9. Quante ore ‘Ginevra Riva’ ha dedicato ad ogni progetto nel quale ha lavorato?
select p.id, p.nome, sum(ap.oreDurata) as totale_ore
from progetto p, attivitaProgetto ap, persona u
where ap.persona = u.id and u.nome = 'Ginevra' and u.cognome = 'Riva' and ap.progetto = p.id
group by p.id;

-- 10. Qual è il nome dei progetti su cui lavorano più di due strutturati?
select p.id, p.nome
from progetto p, attivitaProgetto ap, persona u
where ap.persona = u.id and ap.progetto = p.id
group by p.id
having count(u.id)>2;

-- 11. Quali sono i professori associati che hanno lavorato su più di un progetto?
select u.id, u.nome, u.cognome
from persona u, progetto p, attivitaProgetto ap
where ap.persona = u.id and ap.progetto = p.id and posizione = 'Professore Associato'
group by u.id
having count(p.id) > 1;