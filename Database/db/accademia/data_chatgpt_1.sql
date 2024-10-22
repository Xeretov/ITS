begin transaction;

set constraints all deferred;

-- Nuove persone
INSERT INTO Persona(id, nome, cognome, posizione, stipendio)
VALUES
('21', 'Luigi', 'Bello', 'Ricercatore', '36000.00'),
('22', 'Marco', 'Gentile', 'Professore Ordinario', '50000.00');

-- Nuovi progetti
INSERT INTO Progetto(id, nome, inizio, fine, budget)
VALUES
('5', 'Project Alpha', '2020-01-01', '2021-12-31', '150000'),
('6', 'Project Beta', '2021-01-01', '2022-12-31', '200000');

-- Nuovi work packages (WP)
INSERT INTO WP(progetto, id, nome, inizio, fine)
VALUES
('5', '0', 'WP1', '2020-01-01', '2020-12-31'),
('6', '0', 'WP1', '2021-01-01', '2021-12-31');

-- Nuove attività progettuali
INSERT INTO AttivitaProgetto(id, persona, progetto, wp, giorno, tipo, oreDurata)
VALUES
('11', '21', '5', '0', '2020-05-15', 'Ricerca e Sviluppo', '8'),
('12', '21', '5', '0', '2020-05-16', 'Ricerca e Sviluppo', '8'),
('13', '22', '6', '0', '2021-06-20', 'Management', '6'),
('14', '22', '6', '0', '2021-06-21', 'Ricerca e Sviluppo', '7');

-- Nuove attività non progettuali
INSERT INTO AttivitaNonProgettuale(id, persona, tipo, giorno, oreDurata)
VALUES
('11', '21', 'Didattica', '2020-05-15', '4'),  -- Si sovrappone con attività progettuale
('12', '21', 'Ricerca', '2020-05-17', '3'),    -- Non si sovrappone
('13', '22', 'Incontro Dipartimentale', '2021-06-21', '4'),  -- Si sovrappone
('14', '22', 'Missione', '2021-06-22', '5');   -- Non si sovrappone


-- Nuove attività progettuali per Luigi Bello (id = 21)
INSERT INTO AttivitaProgetto(id, persona, progetto, wp, giorno, tipo, oreDurata)
VALUES
('15', '21', '5', '0', '2020-07-10', 'Dimostrazione', '6'),
('16', '21', '5', '0', '2020-07-11', 'Management', '8');

-- Nuove attività non progettuali per Luigi Bello (id = 21)
INSERT INTO AttivitaNonProgettuale(id, persona, tipo, giorno, oreDurata)
VALUES
('15', '21', 'Incontro Dipartimentale', '2020-07-10', '4'),  -- Sovrapposizione con 10 luglio 2020
('16', '21', 'Didattica', '2020-07-11', '3');                -- Sovrapposizione con 11 luglio 2020


commit;