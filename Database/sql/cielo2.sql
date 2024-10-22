-- 1. Quante sono le compagnie che operano (sia in arrivo che in partenza) nei diversi
-- aeroporti?
select a.codice, a.nome, count(c.nome) as num_compagnie
from aeroporto a, compagnia c, arrPart ap
where (a.codice = ap.arrivo or a.codice = ap.partenza) and ap.comp = c.nome
group by a.codice;

-- 2. Quanti sono i voli che partono dall’aeroporto ‘HTR’ e hanno una durata di almeno
-- 100 minuti?
select a.codice, count(v.codice) as num_aeroplani
from aeroporto a, Volo v , arrPart ap
where a.codice = 'HTR' and (a.codice = ap.arrivo or a.codice = ap.partenza) and ap.codice = v.codice and v.durataMinuti > 100
group by a.codice;

-- 3. Quanti sono gli aeroporti sui quali opera la compagnia ‘Apitalia’, per ogni nazione
-- nella quale opera?
select l.nazione, count(l.aeroporto) as num_aeroporti
from luogoAeroporto l, arrPart ap, compagnia c
where (l.aeroporto = ap.arrivo or l.aeroporto = ap.partenza) and ap.comp = c.nome and c.nome = 'Apitalia'
group by l.nazione;

-- 4. Qual è la media, il massimo e il minimo della durata dei voli effettuati dalla
-- compagnia ‘MagicFly’?
select cast(avg(v.durataMinuti) as decimal(10,2)) as media, max(v.durataMinuti) as massimo, min(v.durataMinuti) as minimo
from volo v, compagnia c
where v.comp = c.nome and c.nome = 'MagicFly';

-- 5. Qual è l’anno di fondazione della compagnia più vecchia che opera in ognuno degli
-- aeroporti?
select a.codice, a.nome, min(c.annoFondaz)
from aeroporto a, arrPart ap, compagnia c
where (a.codice = ap.arrivo or a.codice = ap.partenza) and ap.comp = c.nome
group by a.codice;

-- 6. Quante sono le nazioni (diverse) raggiungibili da ogni nazione tramite uno o più
-- voli?
select l.nazione, count(distinct l2.nazione) as num_nazioni
from luogoAeroporto l, luogoAeroporto l2, arrPart ap
where l.aeroporto = ap.arrivo and l2.aeroporto = ap.partenza and l.nazione <> l2.nazione
group by l.nazione;

-- 7. Qual è la durata media dei voli che partono da ognuno degli aeroporti?
select a.codice, a.nome, cast(avg(v.durataMinuti) as decimal(10,2)) as media
from aeroporto a, arrPart ap, volo v
where (a.codice = ap.arrivo or a.codice = ap.partenza) and ap.codice = v.codice
group by a.codice;


-- 8. Qual è la durata complessiva dei voli operati da ognuna delle compagnie fondate
-- a partire dal 1950?
select c.nome, sum(v.durataMinuti) as totale
from compagnia c, volo v
where c.nome = v.comp and c.annoFondaz >= 1950
group by c.nome;

-- 9. Quali sono gli aeroporti nei quali operano esattamente due compagnie?
select a.codice, a.nome
from aeroporto a, compagnia c, arrPart ap
where (a.codice = ap.arrivo or a.codice = ap.partenza) and ap.comp = c.nome
group by a.codice
having count(distinct c.nome) = 2; 

-- 10. Quali sono le città con almeno due aeroporti?
select l.citta
from luogoAeroporto l, aeroporto a
where a.codice = l.aeroporto
group by l.citta
having count(a.codice) >= 2;

-- 11. Qual è il nome delle compagnie i cui voli hanno una durata media maggiore di 6
-- ore?
select c.nome
from compagnia c, volo v
where c.nome = v.comp
group by c.nome
having avg(v.durataMinuti) > 6*60;

-- 12. Qual è il nome delle compagnie i cui voli hanno tutti una durata maggiore di 100
-- minuti?
select c.nome
from compagnia c, volo v
where c.nome = v.comp
group by c.nome
having min(v.durataMinuti) > 100;