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
-- Name: causaassenza; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.causaassenza AS ENUM (
    'Chiusura Universitaria',
    'Maternita',
    'Malattia'
);


ALTER TYPE public.causaassenza OWNER TO postgres;

--
-- Name: denaro; Type: DOMAIN; Schema: public; Owner: postgres
--

CREATE DOMAIN public.denaro AS real
	CONSTRAINT denaro_check CHECK ((VALUE >= (0)::double precision));


ALTER DOMAIN public.denaro OWNER TO postgres;

--
-- Name: lavorononprogettuale; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.lavorononprogettuale AS ENUM (
    'Didattica',
    'Ricerca',
    'Missione',
    'Incontro Dipartimentale',
    'Incontro Accademico',
    'Altro'
);


ALTER TYPE public.lavorononprogettuale OWNER TO postgres;

--
-- Name: lavoroprogetto; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.lavoroprogetto AS ENUM (
    'Ricerca e Sviluppo',
    'Dimostrazione',
    'Management',
    'Altro'
);


ALTER TYPE public.lavoroprogetto OWNER TO postgres;

--
-- Name: numeroore; Type: DOMAIN; Schema: public; Owner: postgres
--

CREATE DOMAIN public.numeroore AS integer
	CONSTRAINT numeroore_check CHECK (((VALUE >= 0) AND (VALUE <= 8)));


ALTER DOMAIN public.numeroore OWNER TO postgres;

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

--
-- Name: strutturato; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.strutturato AS ENUM (
    'Ricercatore',
    'Professore Associato',
    'Professore Ordinario'
);


ALTER TYPE public.strutturato OWNER TO postgres;

--
-- Name: v_attprogetto_data_wp_date(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.v_attprogetto_data_wp_date() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
declare
  wpInizio date;
  wpFine date;
begin
  select inizio into wpInizio 
  from WP 
  where wp.progetto = new.progetto and wp.id = new.wp;
  if new.giorno < wpInizio then
    raise exception 'Errore nell''inserimento o modifica nella tabella AttivitaProgetto (ennupla con valore per il campo id = %): il valore dell''attributo giorno e'' %, mentre il WP comincia il %', new.id, new.giorno, wpInizio;
  end if;
  select fine into wpFine 
  from WP 
  where wp.progetto = new.progetto and wp.id = new.wp;
  if new.giorno > wpFine then
    raise exception 'Errore nell''inserimento o modifica nella tabella AttivitaProgetto (ennupla con valore per il campo id = %): il valore dell''attributo giorno e'' %, mentre il WP termina il %', new.id, new.giorno, wpFine;
  end if;
  return new;
end;
$$;


ALTER FUNCTION public.v_attprogetto_data_wp_date() OWNER TO postgres;

--
-- Name: v_wp_date_progetto_date(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.v_wp_date_progetto_date() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
declare
  progettoInizio date;
  progettoFine date;
begin
  select inizio into progettoInizio 
  from Progetto 
  where id = new.progetto;
  if new.inizio < progettoInizio then
    raise exception 'Il progetto comincia il %', progettoInizio;
  end if;
  select fine into progettoFine 
  from Progetto 
  where id = new.progetto;
  if new.fine > progettoFine then
    raise exception 'Il progetto finisce il %', progettoFine;
  end if;
  return new;
end;
$$;


ALTER FUNCTION public.v_wp_date_progetto_date() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: assenza; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.assenza (
    id public.posinteger NOT NULL,
    persona public.posinteger NOT NULL,
    tipo public.causaassenza NOT NULL,
    giorno date NOT NULL
);


ALTER TABLE public.assenza OWNER TO postgres;

--
-- Name: attivitanonprogettuale; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.attivitanonprogettuale (
    id public.posinteger NOT NULL,
    persona public.posinteger NOT NULL,
    tipo public.lavorononprogettuale NOT NULL,
    giorno date NOT NULL,
    oredurata public.numeroore NOT NULL
);


ALTER TABLE public.attivitanonprogettuale OWNER TO postgres;

--
-- Name: attivitaprogetto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.attivitaprogetto (
    id public.posinteger NOT NULL,
    persona public.posinteger NOT NULL,
    progetto public.posinteger NOT NULL,
    wp public.posinteger NOT NULL,
    giorno date NOT NULL,
    tipo public.lavoroprogetto NOT NULL,
    oredurata public.numeroore NOT NULL
);


ALTER TABLE public.attivitaprogetto OWNER TO postgres;

--
-- Name: persona; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.persona (
    id public.posinteger NOT NULL,
    nome public.stringam NOT NULL,
    cognome public.stringam NOT NULL,
    posizione public.strutturato NOT NULL,
    stipendio public.denaro NOT NULL
);


ALTER TABLE public.persona OWNER TO postgres;

--
-- Name: progetto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.progetto (
    id public.posinteger NOT NULL,
    nome public.stringam NOT NULL,
    inizio date NOT NULL,
    fine date NOT NULL,
    budget public.denaro NOT NULL,
    CONSTRAINT progetto_check CHECK ((inizio < fine))
);


ALTER TABLE public.progetto OWNER TO postgres;

--
-- Name: wp; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.wp (
    progetto public.posinteger NOT NULL,
    id public.posinteger NOT NULL,
    nome public.stringam NOT NULL,
    inizio date NOT NULL,
    fine date NOT NULL,
    CONSTRAINT wp_check CHECK ((inizio < fine))
);


ALTER TABLE public.wp OWNER TO postgres;

--
-- Data for Name: assenza; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.assenza (id, persona, tipo, giorno) FROM stdin;
0	10	Malattia	2011-06-01
1	10	Malattia	2011-06-02
2	10	Malattia	2011-06-03
3	10	Maternita	2011-06-04
4	8	Malattia	2011-07-02
5	19	Chiusura Universitaria	2013-06-29
6	7	Malattia	2012-12-07
7	0	Maternita	2013-10-27
8	17	Chiusura Universitaria	2011-08-15
9	15	Maternita	2010-12-12
10	0	Malattia	2012-04-18
\.


--
-- Data for Name: attivitanonprogettuale; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.attivitanonprogettuale (id, persona, tipo, giorno, oredurata) FROM stdin;
0	8	Incontro Dipartimentale	2011-06-01	4
1	8	Didattica	2011-03-15	8
2	8	Incontro Dipartimentale	2011-06-15	4
3	2	Didattica	2014-04-01	4
4	2	Didattica	2014-04-03	4
5	1	Didattica	2014-04-03	8
6	4	Incontro Accademico	2012-11-25	7
7	7	Missione	2013-07-07	3
8	5	Altro	2012-12-15	6
9	0	Didattica	2012-04-18	4
10	6	Didattica	2011-05-07	7
11	21	Didattica	2020-05-15	4
12	21	Ricerca	2020-05-17	3
13	22	Incontro Dipartimentale	2021-06-21	4
14	22	Missione	2021-06-22	5
15	21	Incontro Dipartimentale	2020-07-10	4
16	21	Didattica	2020-07-11	3
\.


--
-- Data for Name: attivitaprogetto; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.attivitaprogetto (id, persona, progetto, wp, giorno, tipo, oredurata) FROM stdin;
0	0	1	0	2012-04-15	Ricerca e Sviluppo	8
1	0	1	0	2012-04-16	Ricerca e Sviluppo	8
2	0	1	0	2012-04-17	Ricerca e Sviluppo	8
3	0	1	0	2012-04-18	Ricerca e Sviluppo	8
4	8	1	2	2013-03-15	Dimostrazione	8
5	10	1	0	2012-06-03	Ricerca e Sviluppo	8
6	2	1	1	2012-04-22	Dimostrazione	7
7	4	3	1	2013-01-19	Management	6
8	11	3	2	2014-02-15	Altro	5
9	0	3	2	2014-03-08	Ricerca e Sviluppo	6
10	4	2	1	2000-01-19	Management	2
11	21	5	0	2020-05-15	Ricerca e Sviluppo	8
12	21	5	0	2020-05-16	Ricerca e Sviluppo	8
13	22	6	0	2021-06-20	Management	6
14	22	6	0	2021-06-21	Ricerca e Sviluppo	7
15	21	5	0	2020-07-10	Dimostrazione	6
16	21	5	0	2020-07-11	Management	8
\.


--
-- Data for Name: persona; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.persona (id, nome, cognome, posizione, stipendio) FROM stdin;
0	Anna	Bianchi	Ricercatore	45500.3
1	Mario	Rossi	Ricercatore	35500
2	Barbara	Burso	Ricercatore	40442.5
3	Gino	Spada	Ricercatore	35870.9
4	Aurora	Bianchi	Professore Associato	43500.5
5	Guido	Spensierato	Professore Associato	38221
6	Consolata	Ferrari	Professore Associato	29200.1
7	Andrea	Verona	Professore Associato	39002.05
8	Asia	Giordano	Professore Ordinario	45200.1
9	Carlo	Zante	Professore Ordinario	40230
10	Ginevra	Riva	Professore Ordinario	39955
11	Davide	Quadro	Professore Ordinario	36922.1
12	Dario	Basile	Ricercatore	42566
13	Silvia	Donati	Professore Ordinario	38005
14	Fiorella	Martino	Professore Associato	35544.5
15	Leonardo	Vitali	Professore Ordinario	38779.8
16	Paolo	Valentini	Professore Associato	39200
17	Emilio	Greco	Professore Associato	42020
18	Giulia	Costa	Ricercatore	40220
19	Elisa	Longo	Professore Associato	39001
20	Carla	Martinelli	Ricercatore	42030.2
21	Luigi	Bello	Ricercatore	36000
22	Marco	Gentile	Professore Ordinario	50000
\.


--
-- Data for Name: progetto; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.progetto (id, nome, inizio, fine, budget) FROM stdin;
0	Artemide	2000-01-01	2002-12-31	255000
1	Pegasus	2012-01-01	2014-12-31	330000
2	WineSharing	1999-01-01	2003-12-31	998000
3	Simap	2010-02-01	2014-03-17	158000
4	DropDiscovery	2010-09-13	2013-01-20	99000
5	Project Alpha	2020-01-01	2021-12-31	150000
6	Project Beta	2021-01-01	2022-12-31	200000
\.


--
-- Data for Name: wp; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.wp (progetto, id, nome, inizio, fine) FROM stdin;
0	0	WP1	2000-01-01	2000-12-31
0	1	WP2	2001-01-01	2001-12-31
0	2	WP3	2002-01-01	2002-12-31
1	0	WP1	2012-01-01	2012-12-31
1	1	WP2	2012-01-01	2012-12-31
1	2	WP3	2013-01-01	2013-12-31
2	1	Main Activity	1999-01-01	2003-12-31
3	0	State of the Art	2012-01-01	2012-12-31
3	1	Main Research	2013-01-01	2013-12-31
3	2	Dissemination	2014-01-01	2014-03-17
5	0	WP1	2020-01-01	2020-12-31
6	0	WP1	2021-01-01	2021-12-31
\.


--
-- Name: assenza assenza_persona_giorno_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.assenza
    ADD CONSTRAINT assenza_persona_giorno_key UNIQUE (persona, giorno);


--
-- Name: assenza assenza_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.assenza
    ADD CONSTRAINT assenza_pkey PRIMARY KEY (id);


--
-- Name: attivitanonprogettuale attivitanonprogettuale_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.attivitanonprogettuale
    ADD CONSTRAINT attivitanonprogettuale_pkey PRIMARY KEY (id);


--
-- Name: attivitaprogetto attivitaprogetto_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.attivitaprogetto
    ADD CONSTRAINT attivitaprogetto_pkey PRIMARY KEY (id);


--
-- Name: persona persona_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.persona
    ADD CONSTRAINT persona_pkey PRIMARY KEY (id);


--
-- Name: progetto progetto_nome_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.progetto
    ADD CONSTRAINT progetto_nome_key UNIQUE (nome);


--
-- Name: progetto progetto_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.progetto
    ADD CONSTRAINT progetto_pkey PRIMARY KEY (id);


--
-- Name: wp wp_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wp
    ADD CONSTRAINT wp_pkey PRIMARY KEY (progetto, id);


--
-- Name: wp wp_progetto_nome_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wp
    ADD CONSTRAINT wp_progetto_nome_key UNIQUE (progetto, nome);


--
-- Name: attivitaprogetto attprogetto_data_wp_date; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER attprogetto_data_wp_date BEFORE INSERT OR UPDATE ON public.attivitaprogetto FOR EACH ROW EXECUTE FUNCTION public.v_attprogetto_data_wp_date();


--
-- Name: wp wp_dates_within_project_date; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER wp_dates_within_project_date BEFORE INSERT OR UPDATE ON public.wp FOR EACH ROW EXECUTE FUNCTION public.v_wp_date_progetto_date();


--
-- Name: assenza assenza_persona_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.assenza
    ADD CONSTRAINT assenza_persona_fkey FOREIGN KEY (persona) REFERENCES public.persona(id) DEFERRABLE;


--
-- Name: attivitanonprogettuale attivitanonprogettuale_persona_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.attivitanonprogettuale
    ADD CONSTRAINT attivitanonprogettuale_persona_fkey FOREIGN KEY (persona) REFERENCES public.persona(id) DEFERRABLE;


--
-- Name: attivitaprogetto attivitaprogetto_persona_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.attivitaprogetto
    ADD CONSTRAINT attivitaprogetto_persona_fkey FOREIGN KEY (persona) REFERENCES public.persona(id) DEFERRABLE;


--
-- Name: attivitaprogetto attivitaprogetto_progetto_wp_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.attivitaprogetto
    ADD CONSTRAINT attivitaprogetto_progetto_wp_fkey FOREIGN KEY (progetto, wp) REFERENCES public.wp(progetto, id) DEFERRABLE;


--
-- Name: wp wp_progetto_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wp
    ADD CONSTRAINT wp_progetto_fkey FOREIGN KEY (progetto) REFERENCES public.progetto(id) DEFERRABLE;


--
-- PostgreSQL database dump complete
--

