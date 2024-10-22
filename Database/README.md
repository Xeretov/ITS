# Navigazione repository
 - `db` : contiene i dati per creare i database passo dopo passo
 - `dumps` : contiene i vari dumps fatti una volta creati i database
 - `sql` : contiene le varie query create (es. `accademia5.sql`, `cielo1.sql`)
# Progetti di Database

Questo repository contiene diversi progetti di database, inclusi schemi, dati e query SQL per diversi scenari. I progetti principali sono:

1. Accademia
2. Cielo
3. Officine

## Struttura del Progetto

Ogni progetto tipicamente include i seguenti componenti:

- `domains-tables.sql`: Definisce i domini e le tabelle per lo schema del database.
- `data.sql`: Contiene i dati iniziali per popolare le tabelle.
- `constraints.sql`: Definisce vincoli e trigger aggiuntivi per il database.
- `data_chatgpt_x.sql`: Dati aggiuntivi generati per scopi di test.
- Vari file SQL con query (es. `accademia5.sql`, `cielo1.sql`, ecc.)

## Configurazione e Utilizzo

1. Assicurarsi di avere PostgreSQL installato e in esecuzione.
2. Creare un nuovo database per ogni progetto.
3. Aggiungere `domains-tables.sql` nel database per creare lo schema.
4. Aggiungere `constraints.sql` nel database per creare vincoli e trigger aggiuntivi.
5. Aggiungere `data.sql` e `data_chatgpt_x.sql` per popolare le tabelle con i dati iniziali.
6. È possibile quindi eseguire vari file di query per testare ed esplorare il database.

## Istruzioni per Docker e PostgreSQL


0. Assicurarsi che i container siano nello stato "Running" con il comando
    ```bash
    docker ps -a
    ```
    Entrambi i container `postgres_container` e `pgadmin_container` devono mostrare lo status `UP x minutes/hours`.


1. Aprire una bash nel container postgres con il comando
    ```bash
    docker exec -it postgres_container bash
    ```

2. Aprire l'interfaccia da linea di comando di postgres col comando
    ```bash
	psql -U postgres
    ```

3. Connettersi al database `nome_database` creato in precedenza
    ```psql
	\c nome_database
    ```

	deve essere visualizzato il messaggio 'You are now connected to database `nome_database` as user "postgres"'.<br>
	E il prompt sul terminale deve essere:
    ```psql
    nome_database=#
    ```

4. Lavorare a piacimento sul db.

5. Quando si è terminato, uscire da postgres con il comando '\q'
	Il prompt sul terminale deve essere
    ```bash
    root@dc8aec56e051:/#
    ```
    o simile.
6. Effettuare il dump del db su file
    ```bash
	pg_dump -U postgres nome_database > nome_database.sql
    ```
	Questo comando crea un file 'nome_database.sql' nella directory corrente.

7. Aprire un nuovo terminale (nell'host, <b>NON</b> nel container), posizionarsi nella cartella dove si vuole salvare il file di dump del database.

8. Copiare il file di dump dal container all'host:
    ```bash
	docker cp postgres_container:/nome_database.sql .
    ```
	<b>ATTENZIONE</b>: il punto alla fine del comando è il percorso verso il quale si vuole copiare il file, in questo caso la directory corrente.

9. Per copiare un file di dump dall'host al container, basta copiare nella direzione opposta (in questo esempio, si copia dalla directory corrente alla directory '/data' nel container):
    ```bash
	docker cp ./nome_database.sql postgres_container:/data/
    ```

10. Per ripristinare un database da un file di dump, eseguire il seguente comando (nel container):
    ```bash
	psql nome_database < nome_database.sql
    ```
	<b>NOTA</b>: un database con il nome `nome_database` deve già esistere.

Per informazioni dettagliate sul dump e il restore di database, vedere la documentazione sul sito ufficiale di Postgres:

https://www.postgresql.org/docs/current/backup-dump.html

## Panoramica dei Progetti

### Accademia

Questo progetto modella un ambiente accademico, includendo:
- Persone (ricercatori, professori associati, professori ordinari)
- Progetti e Work Package
- Attività Progettuali e Non Progettuali
- Assenze

### Cielo

Questo progetto modella un sistema di compagnie aeree, includendo:
- Aeroporti e le loro ubicazioni
- Compagnie aeree
- Voli e rotte

### Officine

Questo progetto sembra modellare un sistema di officine per riparazioni di veicoli, includendo:
- Tipi e modelli di veicoli
- Lavori di riparazione
- Personale e gestione

## Interrogazione dei Database

Ogni progetto include diversi file SQL con query di esempio. Questi dimostrano varie operazioni e attività di recupero dati specifiche per ogni schema di database.
