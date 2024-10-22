-- 1. Quali sono i voli (codice e nome della compagnia) la cui durata supera le 3 ore?
select codice as codice_volo, comp
from volo
where durataMinuti > 3*60;

-- 2. Quali sono le compagnie che hanno voli che superano le 3 ore?
select distinct comp
from volo
where durataMinuti > 3*60;

-- 3. Quali sono i voli (codice e nome della compagnia) che partono dall’aeroporto con
-- codice ‘CIA’?
select codice as codice_volo, comp
from arrPart
where partenza = 'CIA';


-- 4. Quali sono le compagnie che hanno voli che arrivano all’aeroporto con codice
-- ‘FCO’?
select comp
from arrPart
where arrivo = 'FCO';

-- 5. Quali sono i voli (codice e nome della compagnia) che partono dall’aeroporto ‘FCO’
-- e arrivano all’aeroporto ‘JFK’?
select codice as codice_volo, comp
from arrPart
where partenza = 'FCO' and arrivo = 'JFK';

--  6. Quali sono le compagnie che hanno voli che partono dall’aeroporto ‘FCO’ e atterrano all’aeroporto ‘JFK’?
select distinct comp
from arrPart
where partenza = 'FCO' and arrivo = 'JFK';

-- 7. Quali sono i nomi delle compagnie che hanno voli diretti dalla città di ‘Roma’ alla
-- città di ‘New York’?
select c.nome
from compagnia c, arrPart ap, luogoAeroporto l, luogoAeroporto l2
where c.nome = ap.comp and ap.partenza = l.aeroporto and l.citta = 'Roma' and ap.arrivo = l2.aeroporto and l2.citta = 'New York';

-- 8. Quali sono gli aeroporti (con codice IATA, nome e luogo) nei quali partono voli
-- della compagnia di nome ‘MagicFly’?
select distinct a.codice as codice_iata, a.nome, l.citta
from aeroporto a, luogoAeroporto l, compagnia c, arrPart ap
where a.codice = l.aeroporto and c.nome = 'MagicFly' and ap.comp = c.nome and (ap.arrivo = a.codice or ap.partenza = a.codice);

-- 9. Quali sono i voli che partono da un qualunque aeroporto della città di ‘Roma’ e
-- atterrano ad un qualunque aeroporto della città di ‘New York’? Restituire: codice
-- del volo, nome della compagnia, e aeroporti di partenza e arrivo.
select ap.codice as codice_volo, c.nome, ap.partenza, ap.arrivo
from aeroporto a, compagnia c, arrPart ap,  luogoAeroporto l1, luogoAeroporto l2
where a.codice = ap.partenza and ap.comp = c.nome and l1.aeroporto = ap.partenza and l1.citta = 'Roma' and ap.arrivo = l2.aeroporto and l2.citta = 'New York';

-- 10. Quali sono i possibili piani di volo con esattamente un cambio (utilizzando solo
-- voli della stessa compagnia) da un qualunque aeroporto della città di ‘Roma’ ad un
-- qualunque aeroporto della città di ‘New York’? Restituire: nome della compagnia,
-- codici dei voli, e aeroporti di partenza, scalo e arrivo.
select c.nome, ap1.codice as codice_volo_1, ap1.partenza, ap1.arrivo as scalo, ap2.codice as codice_volo_2, ap2.arrivo
from compagnia c, arrPart ap1, arrPart ap2, luogoAeroporto l1, luogoAeroporto l2
where ap1.partenza = l1.aeroporto and l1.citta = 'Roma' and ap1.arrivo = ap2.partenza and ap2.arrivo = l2.aeroporto and l2.citta = 'New York';

-- 11. Quali sono le compagnie che hanno voli che partono dall’aeroporto ‘FCO’, atterrano all’aeroporto ‘JFK’, e di cui si conosce l’anno di fondazione?
select distinct c.nome
from compagnia c, arrPart ap
where c.nome = ap.comp and ap.partenza = 'FCO' and ap.arrivo  = 'JFK' and c.annoFondaz is not null;