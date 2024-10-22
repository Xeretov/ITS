-- 1. Quali sono il nome, la data di inizio e la data di fine dei WP del progetto di nome
-- ‘Pegasus’?
select wp.nome, wp.inizio, wp.fine
from wp, progetto p
where wp.progetto = p.id and p.nome = 'Pegasus';

-- 2. Quali sono il nome, il cognome e la posizione degli strutturati che hanno almeno
-- una attività nel progetto ‘Pegasus’, ordinati per cognome decrescente?
select distinct u.nome, u.cognome, u.posizione
from persona u, progetto p, attivitaProgetto ap
where u.id = ap.persona and ap.progetto = p.id and p.nome = 'Pegasus'
order by u.cognome desc;

-- 3. Quali sono il nome, il cognome e la posizione degli strutturati che hanno più di
-- una attività nel progetto ‘Pegasus’?
select distinct u.nome, u.cognome, u.posizione
from persona u, progetto p, attivitaProgetto ap1, attivitaProgetto ap2
where u.id = ap1.persona and u.id = ap2.persona and ap1.progetto = p.id and ap2.progetto = p.id and p.nome = 'Pegasus' and  ap1.persona = ap2.persona and ap1.id <> ap2.id;

-- 4. Quali sono il nome, il cognome e la posizione dei Professori Ordinari che hanno
-- fatto almeno una assenza per malattia?
select distinct u.nome, u.cognome
from persona u, assenza a
where u.id = a.persona and a.tipo = 'Malattia' and u.posizione = 'Professore Ordinario';

-- 5. Quali sono il nome, il cognome e la posizione dei Professori Ordinari che hanno
-- fatto più di una assenza per malattia?
select distinct u.nome, u.cognome
from persona u, assenza a1, assenza a2
where u.id = a1.persona and u.id = a2.persona and a1.tipo = 'Malattia' and a2.tipo = 'Malattia' and u.posizione = 'Professore Ordinario' and  a1.id <> a2.id;

-- 6. Quali sono il nome, il cognome e la posizione dei Ricercatori che hanno almeno
-- un impegno per didattica?
select distinct u.nome, u.cognome
from persona u, attivitaNonProgettuale anp
where u.id = anp.persona and anp.tipo = 'Didattica';

-- 7. Quali sono il nome, il cognome e la posizione dei Ricercatori che hanno più di un
-- impegno per didattica?
select distinct u.nome, u.cognome
from persona u, attivitaNonProgettuale anp1, attivitaNonProgettuale anp2
where u.id = anp1.persona and anp2.persona = u.id and anp1.tipo = 'Didattica' and anp2.tipo = 'Didattica' and anp1.id <> anp2.id;

-- 8. Quali sono il nome e il cognome degli strutturati che nello stesso giorno hanno sia
-- attività progettuali che attività non progettuali?
select distinct u.nome, u.cognome
from persona u, attivitaProgetto ap, attivitaNonProgettuale anp
where u.id = ap.persona and u.id = anp.persona and ap.giorno = anp.giorno;

-- 9. Quali sono il nome e il cognome degli strutturati che nello stesso giorno hanno sia
-- attività progettuali che attività non progettuali? Si richiede anche di proiettare il
-- giorno, il nome del progetto, il tipo di attività non progettuali e la durata in ore di
-- entrambe le attività.
select distinct u.nome, u.cognome, ap.giorno, p.nome as nome_progetto, ap.oreDurata as h_durata, anp.tipo as attivita_non_progettuale, anp.oreDurata as h_durata
from persona u, attivitaProgetto ap, attivitaNonProgettuale anp, progetto p
where u.id = ap.persona and u.id = anp.persona and ap.giorno = anp.giorno and ap.progetto = p.id;

-- 10. Quali sono il nome e il cognome degli strutturati che nello stesso giorno sono
-- assenti e hanno attività progettuali?
select distinct u.nome, u.cognome
from persona u, attivitaProgetto ap, assenza a
where u.id = ap.persona and u.id = a.persona and a.giorno = ap.giorno;

-- 11. Quali sono il nome e il cognome degli strutturati che nello stesso giorno sono
-- assenti e hanno attività progettuali? Si richiede anche di proiettare il giorno, il
-- nome del progetto, la causa di assenza e la durata in ore della attività progettuale.
select distinct u.nome, u.cognome, a.giorno, p.nome as nome_progetto, ap.oreDurata as h_durata, a.tipo as causa_assenza
from persona u, attivitaProgetto ap, assenza a, progetto p
where u.id = ap.persona and u.id = a.persona and a.giorno = ap.giorno;

-- 12. Quali sono i WP che hanno lo stesso nome, ma appartengono a progetti diversi?
select wp1.nome
from wp wp1, wp wp2
where wp1.progetto <> wp2.progetto and wp1.nome = wp2.nome;