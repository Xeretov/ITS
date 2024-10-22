# Gioele Amendola
# 29/09/2024

from flask import Flask, json, request
import base64

# Utenti che possono accedere al server e modificare o leggere i dati
utenti = [
    ["mario","passwd123", "rw"],
    ["carlo","pass456","r"],
    ["luca","passwd789", "rw"],
    ["giulia","pass012","r"],
    ["francesco","passwd345", "r"],
    ["sofia","pass678","r"],
    ["andrea","passwd901", "r"],
    ["martina","pass234","r"],
    ["simone","passwd567", "rw"],
    ["chiara","pass890","r"],
    ["lorenzo","passwd123", "r"]
]

# Lista di dizionari che contengono i dati dei cittadini
cittadini = [
    {"nome": "Alessandro", "cognome": "Rossi", "dataNascita": "15/07/1995","codFiscale":"rssldr95l15h5678"},
    {"nome": "Francesca", "cognome": "Bianchi", "dataNascita": "28/02/1990","codFiscale":"bncfrc90f28h9012"},
    {"nome": "Matteo", "cognome": "Verdi", "dataNascita": "12/01/1992","codFiscale":"vrdmtt92m12h3456"},
    {"nome": "Sofia", "cognome": "Esposito", "dataNascita": "25/06/1998","codFiscale":"spssfo98f25h7890"},
    {"nome": "Lorenzo", "cognome": "Ferrari", "dataNascita": "03/09/1996","codFiscale":"frrlrn96m03h1111"},
    {"nome": "Giulia", "cognome": "Romano", "dataNascita": "18/11/1994","codFiscale":"rmngli94f18h2222"},
    {"nome": "Andrea", "cognome": "Costa", "dataNascita": "08/05/1991","codFiscale":"cstndr91m08h3333"},
    {"nome": "Martina", "cognome": "Marino", "dataNascita": "22/03/1993","codFiscale":"mrnmrt93f22h4444"},
    {"nome": "Simone", "cognome": "Moretti", "dataNascita": "01/02/1997","codFiscale":"mrtsmn97m01h5555"},
    {"nome": "Chiara", "cognome": "De Luca", "dataNascita": "10/08/1999","codFiscale":"dlcchr99f10h6666"}
]

# Creazione dell'applicazione Flask
api = Flask(__name__)

# Funzione che permette di inserire un cittadino
@api.route('/add_cittadino', methods=['POST'])
def add_cittadino():
    if check_utente_permesso('w'):
        content_type = request.headers.get('Content-Type')
        if (content_type == 'application/json'): # Controlla se l'utente da aggiungere sia in formato JSON (dizionario)
            jsonReq = request.json
            print(jsonReq)
            cittadini.append(jsonReq) # Aggiungo il nuovo cittadino
            jsonResp = {"Esito":"200", "Msg":"ok"} # Risposta in formato JSON
            return json.dumps(jsonResp)
        else:
            return 'Content-Type not supported!' # Risposta se il contenuto non è in formato JSON
    else:
        return json.dumps({"Esito": "403", "Msg": "Permesso negato"}) # Risposta se l'utente non ha i permessi adatti

# Funzione che permette di modificare i dati dei cittadini (basandosi sul codice fiscale)
@api.route('/mod_cittadino', methods=['PUT'])
def mod_cittadino():
    if check_utente_permesso('w'):
        content_type = request.headers.get('Content-Type')
        if (content_type == 'application/json'):
            jsonReq = request.json
            print(jsonReq)
            for cittadino in cittadini:
                if cittadino['codFiscale'] == jsonReq['cercaCod']:
                    del jsonReq['cercaCod']
                    for x in jsonReq:
                        cittadino[x] = jsonReq[x] if jsonReq[x] else cittadino[x]
                    jsonResp = {"Esito":"200", "Msg":"ok"}
                    return json.dumps(jsonResp)
            jsonResp = {"Esito":"404", "Msg":"Cittadino non trovato"}
            return json.dumps(jsonResp)
        else:
            return 'Content-Type not supported!'
    else:
        return json.dumps({"Esito": "403", "Msg": "Permesso negato"})

# Funzione che permette di leggere i dati dei cittadini (basdandosi sul codice fiscale)
@api.route('/get_cittadino', methods=['GET'])
def get_cittadino():
    if check_utente_permesso('r'):
        codF = request.args.get('codFiscale')
        for cittadino in cittadini:
            if cittadino['codFiscale'] == codF:
                return json.dumps(cittadino)
        return json.dumps({"Esito": "404", "Msg": "Cittadino non trovato"})
    else:
        return json.dumps({"Esito": "403", "Msg": "Permesso negato"})

# Funzione che permette di eliminare un cittadino (basandosi sul codice fiscale)
@api.route('/del_cittadino', methods=['DELETE'])
def del_cittadino():
    if check_utente_permesso('w'):
        content_type = request.headers.get('Content-Type')
        if (content_type == 'application/json'):
            jsonReq = request.json
            print(jsonReq)
            for i, cittadino in enumerate(cittadini):
                if cittadino['codFiscale'] == jsonReq['codFiscale']:
                    del cittadini[i]
                    return json.dumps({"Esito":"200", "Msg":"ok"})
            return json.dumps({"Esito":"404", "Msg":"Cittadino non trovato"})
        else:
            return 'Content-Type not supported!'
    else:
        return json.dumps({"Esito": "403", "Msg": "Permesso negato"})

# Funzione che controlla se un utente esiste ed ha un determinato permesso
def check_utente_permesso(permesso):
    auth = request.headers.get('Authorization')
    auth = auth[6:]
    security_data = base64.b64decode(auth).decode('utf-8')
    username, password = security_data.split(':')
    for utente in utenti:
        if utente[0] == username and utente[1] == password:
            if permesso in utente[2]:
                return True
    return False

if __name__ == '__main__':
    api.run(host="127.0.0.1", port=8080, ssl_context='adhoc')
