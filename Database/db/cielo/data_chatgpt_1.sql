begin transaction;

set constraints all deferred;


INSERT INTO Aeroporto(codice, nome) VALUES
('MXP', 'Milano Malpensa'),
('LAX', 'Los Angeles International Airport'),
('MAD', 'Adolfo Suárez Madrid-Barajas Airport'),
('BCN', 'Barcelona El Prat Airport'),
('AMS', 'Amsterdam Schiphol Airport');

INSERT INTO LuogoAeroporto(aeroporto, citta, nazione) VALUES
('MXP', 'Milano', 'Italy'),
('LAX', 'Los Angeles', 'USA'),
('MAD', 'Madrid', 'Spain'),
('BCN', 'Barcelona', 'Spain'),
('AMS', 'Amsterdam', 'Netherlands');

INSERT INTO Compagnia(nome, annofondaz) VALUES
('FlyItalia', '2000'),
('AirEuropa', '1986'),
('Transatlantic', '1978'),
('SkyTravel', '2010'),
('EuroFly', '1995');


INSERT INTO ArrPart(codice, comp, arrivo, partenza) VALUES
('900', 'FlyItalia', 'MXP', 'FCO'),
('901', 'AirEuropa', 'MAD', 'BCN'),
('902', 'Transatlantic', 'LAX', 'JFK'),
('903', 'SkyTravel', 'AMS', 'FCO'),
('904', 'EuroFly', 'FCO', 'MXP');


INSERT INTO Volo(codice, comp, durataMinuti) VALUES
('900', 'FlyItalia', '80'),
('901', 'AirEuropa', '90'),
('902', 'Transatlantic', '360'),
('903', 'SkyTravel', '120'),
('904', 'EuroFly', '75');



INSERT INTO ArrPart(codice, comp, arrivo, partenza) VALUES
('905', 'MagicFly', 'AMS', 'JFK'),
('906', 'MagicFly', 'LAX', 'CDG'),
('907', 'MagicFly', 'MXP', 'FCO'),
('908', 'MagicFly', 'MAD', 'BCN'),
('909', 'MagicFly', 'BCN', 'AMS');


INSERT INTO Volo(codice, comp, durataMinuti) VALUES
('905', 'MagicFly', '480'),
('906', 'MagicFly', '650'),
('907', 'MagicFly', '80'),
('908', 'MagicFly', '100'),
('909', 'MagicFly', '120');




-- Ennuple per testare la query numero 10

INSERT INTO Volo(codice, comp, durataMinuti) VALUES
('910', 'MagicFly', '150'),  -- Durata del volo da Roma a Londra
('911', 'MagicFly', '420'),  -- Durata del volo da Londra a New York

('912', 'Caimanair', '140'), -- Durata del volo da Roma a Parigi
('913', 'Caimanair', '480'), -- Durata del volo da Parigi a New York

('914', 'Apitalia', '120'),  -- Durata del volo da Roma a Madrid
('915', 'Apitalia', '480');  -- Durata del volo da Madrid a New York


INSERT INTO ArrPart(codice, comp, arrivo, partenza) VALUES
('910', 'MagicFly', 'HTR', 'FCO'),  -- Da Roma Fiumicino a Londra Heathrow
('911', 'MagicFly', 'JFK', 'HTR');  -- Da Londra Heathrow a New York JFK



INSERT INTO ArrPart(codice, comp, arrivo, partenza) VALUES
('912', 'Caimanair', 'CDG', 'CIA'),  -- Da Roma Ciampino a Parigi CDG
('913', 'Caimanair', 'JFK', 'CDG');  -- Da Parigi CDG a New York JFK


INSERT INTO ArrPart(codice, comp, arrivo, partenza) VALUES
('914', 'Apitalia', 'MAD', 'FCO'),  -- Da Roma Fiumicino a Madrid Barajas
('915', 'Apitalia', 'JFK', 'MAD');  -- Da Madrid Barajas a New York JFK



-- Ennuple per testare la query numero 11
INSERT INTO Compagnia(nome, annofondaz) VALUES
('NoYearAir', NULL),   -- Compagnia senza anno di fondazione
('SkyLine', '1995'),   -- Compagnia con anno di fondazione
('OldFly', NULL);      -- Compagnia senza anno di fondazione

-- Voli che partono da FCO e atterrano a JFK, ma con o senza anno di fondazione
INSERT INTO ArrPart(codice, comp, arrivo, partenza) VALUES
('930', 'NoYearAir', 'JFK', 'FCO'),   -- Senza anno di fondazione
('931', 'SkyLine', 'JFK', 'FCO'),     -- Con anno di fondazione
('932', 'OldFly', 'JFK', 'FCO'),      -- Senza anno di fondazione

-- Voli con destinazione diversa da JFK
('933', 'SkyLine', 'CDG', 'FCO'),     -- Anno di fondazione presente, ma non per JFK
('934', 'NoYearAir', 'HTR', 'FCO');   -- Senza anno di fondazione e non JFK


INSERT INTO Volo(codice, comp, durataMinuti) VALUES
('930', 'NoYearAir', '600'),  -- FCO -> JFK, ma senza anno di fondazione
('931', 'SkyLine', '605'),    -- FCO -> JFK, con anno di fondazione
('932', 'OldFly', '600'),     -- FCO -> JFK, senza anno di fondazione
('933', 'SkyLine', '120'),    -- FCO -> CDG, con anno di fondazione (non rilevante per la query)
('934', 'NoYearAir', '150');  -- FCO -> HTR, senza anno di fondazione




commit;