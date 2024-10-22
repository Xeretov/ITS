--
-- PostgreSQL database dump
--

-- Dumped from database version 17.0 (Debian 17.0-1.pgdg120+1)
-- Dumped by pg_dump version 17.0 (Debian 17.0-1.pgdg120+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: codiata; Type: DOMAIN; Schema: public; Owner: postgres
--

CREATE DOMAIN public.codiata AS character(3);


ALTER DOMAIN public.codiata OWNER TO postgres;

--
-- Name: posinteger; Type: DOMAIN; Schema: public; Owner: postgres
--

CREATE DOMAIN public.posinteger AS integer
	CONSTRAINT posinteger_check CHECK ((VALUE >= 0));


ALTER DOMAIN public.posinteger OWNER TO postgres;

--
-- Name: stringam; Type: DOMAIN; Schema: public; Owner: postgres
--

CREATE DOMAIN public.stringam AS character varying(100);


ALTER DOMAIN public.stringam OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: aeroporto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.aeroporto (
    codice public.codiata NOT NULL,
    nome public.stringam NOT NULL
);


ALTER TABLE public.aeroporto OWNER TO postgres;

--
-- Name: arrpart; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.arrpart (
    codice public.posinteger NOT NULL,
    comp public.stringam NOT NULL,
    arrivo public.codiata NOT NULL,
    partenza public.codiata NOT NULL
);


ALTER TABLE public.arrpart OWNER TO postgres;

--
-- Name: compagnia; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.compagnia (
    nome public.stringam NOT NULL,
    annofondaz public.posinteger
);


ALTER TABLE public.compagnia OWNER TO postgres;

--
-- Name: luogoaeroporto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.luogoaeroporto (
    aeroporto public.codiata NOT NULL,
    citta public.stringam NOT NULL,
    nazione public.stringam NOT NULL
);


ALTER TABLE public.luogoaeroporto OWNER TO postgres;

--
-- Name: volo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.volo (
    codice public.posinteger NOT NULL,
    comp public.stringam NOT NULL,
    durataminuti public.posinteger NOT NULL
);


ALTER TABLE public.volo OWNER TO postgres;

--
-- Data for Name: aeroporto; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.aeroporto (codice, nome) FROM stdin;
JFK	JFK Airport
FCO	Aeroporto di Roma Fiumicino
CIA	Aeroporto di Roma Ciampino
CDG	Charles de Gaulle, Aeroport de Paris
HTR	Heathrow Airport, London
MXP	Milano Malpensa
LAX	Los Angeles International Airport
MAD	Adolfo Suárez Madrid-Barajas Airport
BCN	Barcelona El Prat Airport
AMS	Amsterdam Schiphol Airport
\.


--
-- Data for Name: arrpart; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.arrpart (codice, comp, arrivo, partenza) FROM stdin;
132	MagicFly	FCO	JFK
263	Caimanair	FCO	CIA
534	Apitalia	JFK	CIA
1265	Apitalia	CIA	FCO
24	Apitalia	FCO	JFK
133	MagicFly	CDG	HTR
264	Caimanair	HTR	CDG
535	Apitalia	FCO	HTR
134	MagicFly	JFK	FCO
265	Caimanair	JFK	FCO
536	Apitalia	JFK	FCO
900	FlyItalia	MXP	FCO
901	AirEuropa	MAD	BCN
902	Transatlantic	LAX	JFK
903	SkyTravel	AMS	FCO
904	EuroFly	FCO	MXP
905	MagicFly	AMS	JFK
906	MagicFly	LAX	CDG
907	MagicFly	MXP	FCO
908	MagicFly	MAD	BCN
909	MagicFly	BCN	AMS
910	MagicFly	HTR	FCO
911	MagicFly	JFK	HTR
912	Caimanair	CDG	CIA
913	Caimanair	JFK	CDG
914	Apitalia	MAD	FCO
915	Apitalia	JFK	MAD
930	NoYearAir	JFK	FCO
931	SkyLine	JFK	FCO
932	OldFly	JFK	FCO
933	SkyLine	CDG	FCO
934	NoYearAir	HTR	FCO
\.


--
-- Data for Name: compagnia; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.compagnia (nome, annofondaz) FROM stdin;
Caimanair	1954
Apitalia	1900
MagicFly	1990
FlyItalia	2000
AirEuropa	1986
Transatlantic	1978
SkyTravel	2010
EuroFly	1995
NoYearAir	\N
SkyLine	1995
OldFly	\N
\.


--
-- Data for Name: luogoaeroporto; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.luogoaeroporto (aeroporto, citta, nazione) FROM stdin;
JFK	New York	USA
FCO	Roma	Italy
CIA	Roma	Italy
CDG	Paris	France
HTR	London	United Kingdom
MXP	Milano	Italy
LAX	Los Angeles	USA
MAD	Madrid	Spain
BCN	Barcelona	Spain
AMS	Amsterdam	Netherlands
\.


--
-- Data for Name: volo; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.volo (codice, comp, durataminuti) FROM stdin;
132	MagicFly	600
263	Caimanair	382
534	Apitalia	432
1265	Apitalia	382
24	Apitalia	599
133	MagicFly	60
264	Caimanair	60
535	Apitalia	150
134	MagicFly	600
265	Caimanair	601
536	Apitalia	599
900	FlyItalia	80
901	AirEuropa	90
902	Transatlantic	360
903	SkyTravel	120
904	EuroFly	75
905	MagicFly	480
906	MagicFly	650
907	MagicFly	80
908	MagicFly	100
909	MagicFly	120
910	MagicFly	150
911	MagicFly	420
912	Caimanair	140
913	Caimanair	480
914	Apitalia	120
915	Apitalia	480
930	NoYearAir	600
931	SkyLine	605
932	OldFly	600
933	SkyLine	120
934	NoYearAir	150
\.


--
-- Name: aeroporto aeroporto_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.aeroporto
    ADD CONSTRAINT aeroporto_pkey PRIMARY KEY (codice);


--
-- Name: arrpart arrpart_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.arrpart
    ADD CONSTRAINT arrpart_pkey PRIMARY KEY (codice, comp);


--
-- Name: compagnia compagnia_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.compagnia
    ADD CONSTRAINT compagnia_pkey PRIMARY KEY (nome);


--
-- Name: luogoaeroporto luogoaeroporto_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.luogoaeroporto
    ADD CONSTRAINT luogoaeroporto_pkey PRIMARY KEY (aeroporto);


--
-- Name: volo volo_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.volo
    ADD CONSTRAINT volo_pkey PRIMARY KEY (codice, comp);


--
-- Name: aeroporto aeroporto_codice_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.aeroporto
    ADD CONSTRAINT aeroporto_codice_fkey FOREIGN KEY (codice) REFERENCES public.luogoaeroporto(aeroporto) DEFERRABLE;


--
-- Name: arrpart arrpart_arrivo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.arrpart
    ADD CONSTRAINT arrpart_arrivo_fkey FOREIGN KEY (arrivo) REFERENCES public.aeroporto(codice) DEFERRABLE;


--
-- Name: arrpart arrpart_codice_comp_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.arrpart
    ADD CONSTRAINT arrpart_codice_comp_fkey FOREIGN KEY (codice, comp) REFERENCES public.volo(codice, comp) DEFERRABLE;


--
-- Name: arrpart arrpart_partenza_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.arrpart
    ADD CONSTRAINT arrpart_partenza_fkey FOREIGN KEY (partenza) REFERENCES public.aeroporto(codice) DEFERRABLE;


--
-- Name: luogoaeroporto luogoaeroporto_aeroporto_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.luogoaeroporto
    ADD CONSTRAINT luogoaeroporto_aeroporto_fkey FOREIGN KEY (aeroporto) REFERENCES public.aeroporto(codice) DEFERRABLE;


--
-- Name: volo volo_codice_comp_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.volo
    ADD CONSTRAINT volo_codice_comp_fkey FOREIGN KEY (codice, comp) REFERENCES public.arrpart(codice, comp) DEFERRABLE;


--
-- Name: volo volo_comp_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.volo
    ADD CONSTRAINT volo_comp_fkey FOREIGN KEY (comp) REFERENCES public.compagnia(nome) DEFERRABLE;


--
-- PostgreSQL database dump complete
--

