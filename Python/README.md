# Progetti Python

Questa repository contiene diversi progetti Python che coprono varie aree di applicazione.

## 1. Generative AI Web Application

Un'applicazione web per interagire con l'API Generative AI di Google (Gemini).

### Funzionalità
- Creare favole
- Rispondere a domande testuali
- Analizzare immagini e rispondere a domande su di esse

### File principali
- `server.py`: Server Flask per l'applicazione web e gestione delle richieste API
- `client.py`: Modulo per l'interazione con l'API di Google Gemini
- `index.html`: Pagina HTML principale per l'interfaccia utente
- `script.js`: JavaScript per la logica dell'interfaccia utente
- `style.css`: Foglio di stile CSS per l'interfaccia utente

### Struttura del progetto
- `/`: Contiene i file principali del server e del client
- `/templates`: Contiene i file HTML per il frontend
- `/static`: Contiene i file JS e CSS per il frontend
- `/uploads`: Directory per le immagini caricate dagli utenti

### Caratteristiche principali
- Interfaccia web responsive con Flask
- Caricamento e analisi di immagini direttamente dal browser
- Visualizzazione dei risultati con scrolling assistito
- Gestione dinamica del form basata sulla selezione dell'utente
- Integrazione seamless con l'API di Google Gemini

## 2. Server HTTP Flask

Un'applicazione web basic basata su Flask.

### Funzionalità
- Registrazione utenti
- Pagine di conferma registrazione

### File principali
- `server.py`
- Templates HTML in `/templates`

## 3. API REST

Un'implementazione di API REST per la gestione di dati di cittadini.

### Funzionalità
- Operazioni CRUD complete
- Autenticazione basata su token
- Validazione dei dati in ingresso

### File principali
- `server.py`: Server API principale
- `client.py`: Client per il test delle API

### Caratteristiche principali
- Utilizzo di Flask-RESTful per la creazione di API
- Implementazione di JWT per l'autenticazione
- Gestione degli errori e risposte HTTP appropriate

## 4. Sniffer di Rete

Uno sniffer di rete per l'analisi del traffico di rete.

### Funzionalità
- Cattura e analisi dei pacchetti di rete
- Supporto per protocolli comuni (TCP, UDP, ICMP)
- Visualizzazione dettagliata delle informazioni dei pacchetti

### File principali
- `sniffer.py`: Script principale per lo sniffing di rete

### Caratteristiche principali
- Utilizzo della libreria Scapy per la manipolazione dei pacchetti
- Supporto per la cattura di pacchetti su diverse interfacce di rete
- Analisi dettagliata dei headers dei pacchetti

## 5. Cerca Stringa

Uno script per la ricerca di stringhe in file e directory.

### Funzionalità
- Ricerca ricorsiva in directory
- Supporto per vari tipi di file (testo, PDF, DOC)
- Ricerca sia nei nomi dei file che nel contenuto

### File principali
- `cerca.py`: Script principale per la ricerca

### Caratteristiche principali
- Utilizzo di `os.walk()` per la navigazione ricorsiva delle directory
- Integrazione con PyPDF2 per la lettura di file PDF
- Gestione di diversi tipi di file e codifiche

## 6. Python_JSON

Uno script per lavorare con dati JSON in Python.

### Funzionalità
- Serializzazione di dati in formato JSON
- Deserializzazione di dati da file JSON
- Stampa formattata di dizionari JSON
- Validazione di dati JSON contro uno schema

### File principali
- `esercizio.py`: Script principale con funzioni per manipolare dati JSON

### Caratteristiche principali
- Utilizzo della libreria `json` per operazioni JSON
- Implementazione di una funzione ricorsiva per la stampa formattata
- Uso di `jsonschema` per la validazione dei dati

## 7. DockerApp

Un'applicazione Docker per eseguire script Python in container.

### Funzionalità
- Esecuzione di script Python in ambiente containerizzato
- Utilizzo di Docker Compose per gestire servizi multipli

### File principali
- `Dockerfile`: Configurazione per costruire l'immagine Docker
- `docker-compose.yml`: Configurazione per orchestrare i servizi
- `myapp.py`, `app1.py`, `app2.py`: Script Python di esempio

### Caratteristiche principali
- Utilizzo di immagine base Python Alpine
- Configurazione di servizi MongoDB e Mongo Express
- Gestione di volumi e reti Docker
