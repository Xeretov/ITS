from flask import Flask, json, request
from myjson import JsonSerialize,JsonDeserialize
import sys

# lListaCampil = ["nome", "cognome", "data nascita", "codice fiscale"]
# if campoRicevutoDalClient in lListaCampi:
    


# sFile = "./prova.json"
# myDict = {"nome":"Mario", "cognome":"Rossi"}
# iRet = JsonSerialize(myDict,sFile)
# if iRet==0:
#     print("Operazione terminata correttamente")
# elif iRet==1:
#     print("Errore: Dati Errati, atteso dizionario, preso "+str(type(myDict)))
# elif iRet==2:
#     print("Errore: path del file non trovato, path("+sFile+")")
# sys.exit()



sFileAnagrafe= "./anagrafe.json"
api = Flask(__name__)

@api.route('/post_cittadino', methods=['POST'])
def GestisciAddCittadino():
    #prendi i dati della richiesta
    content_type = request.headers.get('Content-Type')
    print("Ricevuta chiamata " + content_type)
    if content_type=="application/json":
        jRequest = request.json
        sCodiceFiscale = jRequest["codice fiscale"]
        print("Ricevuto " + sCodiceFiscale)
        #carichiamo l'anagrafe
        dAnagrafe = JsonDeserialize(sFileAnagrafe)
        if sCodiceFiscale not in dAnagrafe:
            dAnagrafe[sCodiceFiscale] = jRequest
            JsonSerialize(dAnagrafe,sFileAnagrafe)
            jResponse = {"Error":"000", "Msg": "ok"}
            return json.dumps(jResponse),200
        else:
            jResponse = {"Error":"001", "Msg": "codice fiscale gia presente in anagrafe"}
            return json.dumps(jResponse),200
    else:
        return "Errore, formato non riconosciuto",401
    #controlla che il cittadino non è gia presente in anagrafe
    #rispondi

@api.route('/get_cittadino', methods=['GET'])
def GestisciGetCittadino():
    print("Ricevuta chiamata")
    sCodiceFiscale = request.args.get("codice fiscale")
    dAnagrafe = JsonDeserialize(sFileAnagrafe)
    if sCodiceFiscale in dAnagrafe:
        cittadino = dAnagrafe[sCodiceFiscale]
        return json.dumps(cittadino),200
    else:
        jResponse = {"Error":"002", "Msg":"codice fiscale non trovato"}
        return json.dumps(jResponse),200



api.run(host="127.0.0.1", port=8080)