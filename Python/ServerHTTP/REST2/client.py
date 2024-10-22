import json, requests
import sys

base_url = "http://127.0.0.1:8080"


def RichiediDatiCittadino():
    nome = input("inserisci nome cittadino: ")
    cognome = input("inserisci cognome cittadino: ")
    dataNascita = input("inserisci data nascita: ")
    codFiscale = input("Inserisci codice fiscale: ")
    jRequest = {"nome":nome, "cognome":cognome, "data nascita":dataNascita,"codice fiscale":codFiscale }
    return jRequest

def CreaInterfaccia():
    print("\nOperazioni disponibili:")
    print("1. Inserisci cittadino (es. atto di nascita)")
    print("2. Richiedi dati cittadino (es. cert. residenza)")
    print("3. Modifica dati cittadino")
    print("4. Elimina cittadino\n")
    print("5. Exit\n")

sOper = 0
while (sOper != "5"):
    CreaInterfaccia()
    sOper = input("Seleziona operazione: ")
    if sOper=="1":
        api_url = base_url + "/post_cittadino"
        jsonDataRequest = RichiediDatiCittadino()
        try:
            response = requests.post(api_url,json=jsonDataRequest)
            print(response.status_code)
            print(response.headers["Content-Type"])
            data1 = response.json()
            print(data1)
        except:
            print("Problemi di comunicazione con il server, riprova più tardi")

    elif sOper=="2":
        api_url = base_url + "/get_cittadino"
        data = input("Inserisci codice fiscale: ")
        jsonDataRequest = {"codice fiscale: ":data}
        try:
            response = requests.get(api_url, params=jsonDataRequest)
            print(response.status_code)
            print(response.headers["Content-Type"])
            data1 = response.json()
            print(data1)
        except:
            print("Problemi di comunicazione con il server, riprova più tardi")
    