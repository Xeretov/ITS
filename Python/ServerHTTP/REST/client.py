# Gioele Amendola
# 29/09/2024

try:
    import json
except ImportError:
    import simplejson as json
import requests
from requests.auth import HTTPBasicAuth

base_api_url = "https://127.0.0.1:8080/"
username = ""
password = ""
comando = ""

def StampaMenuOperazioni():
    print("\n1. Inserisci cittadino")
    print("2. Leggi dati cittadino")
    print("3. Modifica cittadino")
    print("4. Elimina cittadino")
    print("5. Inserisci credenziali")
    print("\n0. Exit\n")
    comando = input("Inserisci operazione: ")
    return comando
    
def print_dictionary(dData):
    for keys, values in dData.items():
        print(keys + " - " + values)
        
def GetDatiCittadino():
    nome = input("Inserisci nome: ")
    cognome = input("Inserisci cognome: ")
    dataN = input("Inserisci data nascita(dd/mm/yyyy): ")
    codF = input("Inserisci codice fiscale: ")
    datiCittadino = {"nome":nome, "cognome": cognome, "dataNascita":dataN, "codFiscale":codF}
    return datiCittadino

def AcquisisciCredenziali():
    global username,password
    username = input("Inserisci username: ")
    password = input("Inserisci password: ")


while comando != 0:
    print("\n") if not username and not password else print("\nusername: "+username)
    print("Cosa vuoi fare?") 
    comando = StampaMenuOperazioni()
    print("Comando inserito: " + comando)

    # Inserisci cittadino
    if comando=="1":
        api_url = base_api_url + "add_cittadino" # url per l'operazione di inserimento
        jsonDataRequest = GetDatiCittadino()
        response = requests.post(api_url,json=jsonDataRequest,verify=False,auth=HTTPBasicAuth(username,password))
        print(response.status_code)
        print(response.headers["Content-Type"])
        data1 = response.json()
        if (type(response.json()) is dict):
                print_dictionary(response.json())

    # Leggi dati cittadino
    elif comando=="2":
        api_url = base_api_url + "get_cittadino"
        codF = input("Inserisci codice fiscale del cittadino: ")
        jsonDataRequest = {"codFiscale": codF}
        response = requests.get(api_url, params=jsonDataRequest, verify=False, auth=HTTPBasicAuth(username,password))
        print(response.status_code)
        print(response.headers["Content-Type"])
        data1 = response.json()
        if (type(response.json()) is dict):
            print_dictionary(response.json())

    # Modifica cittadino
    elif comando=="3":
        api_url = base_api_url + "mod_cittadino"
        codF = input("Inserisci codice fiscale del cittadino da modificare: ")
        print("\nInserisci i dati del cittadino da modificare (lasciare vuoto se non si vuole modificare): ")
        jsonDataRequest = GetDatiCittadino()
        jsonDataRequest["cercaCod"] = codF
        response = requests.put(api_url,json=jsonDataRequest,verify=False,auth=HTTPBasicAuth(username,password))
        print(response.status_code)
        print(response.headers["Content-Type"])
        data1 = response.json()
        if (type(response.json()) is dict):
            print_dictionary(response.json())

    # Elimina cittadino
    elif comando=="4":
        api_url = base_api_url + "del_cittadino"
        codF = input("Inserisci codice fiscale del cittadino: ")
        jsonDataRequest = {"codFiscale": codF}
        response = requests.delete(api_url, json=jsonDataRequest, verify=False, auth=HTTPBasicAuth(username, password))
        print(response.status_code)
        print(response.headers["Content-Type"])
        data1 = response.json()
        if (type(response.json()) is dict):
            print_dictionary(response.json())

    # Sign in
    elif comando=="5":
        AcquisisciCredenziali()

    # Sign out
    elif comando=="0":
        break
    else:
        print("\nComando non riconosciuto. Riprova.\n\n")


