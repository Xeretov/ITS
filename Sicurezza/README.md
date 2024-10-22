# Progetti di Sicurezza Informatica

Questa repository contiene diversi progetti e script relativi alla sicurezza informatica e alla crittografia.

## Struttura del Progetto

- `/cypher`: Contiene script per la crittografia
- `/email`: Contiene script e note relative alla sicurezza delle email
- `/keys`: Contiene vari file di chiavi e dati crittografati

## Descrizione dei Progetti

### Crittografia (/cypher)

1. `cifrato.py`: Implementa la cifratura e decifratura AES in modalità ECB.
   - Funzioni: `encrypt()`, `decrypt()`
   - Utilizza la libreria PyCryptodome

2. `asimmetrica.py`: Implementa la crittografia asimmetrica RSA.
   - Funzioni: `encrypt_message()`, `decrypt_message()`
   - Utilizza chiavi RSA generate o importate

### Email (/email)

1. `program.py`: Script per l'invio di email usando SMTP.
   - Utilizza la libreria `smtplib` di Python
   - Configurato per l'uso con Gmail

2. `lez1.txt`: Note sulla sicurezza informatica, inclusi concetti come:
   - Triade CIA (Confidentiality, Integrity, Availability)
   - GDPR
   - Tipi di minacce e attacchi comuni

### Chiavi e Dati Crittografati (/keys)

Contiene vari file relativi a operazioni crittografiche:
- Chiavi pubbliche e private
- File crittografati e decrittati
- Hash di dati
- Firme digitali

## Utilizzo

Per utilizzare gli script di crittografia:

1. Assicurarsi di avere Python installato
2. Installare le dipendenze necessarie (es. `pip install pycryptodome`)
3. Eseguire gli script dalla riga di comando

Per l'invio di email, configurare le credenziali SMTP appropriate in `program.py`.

