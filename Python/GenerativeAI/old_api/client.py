
import json, sys
import requests, subprocess

from myjson import *

import urllib3
urllib3.disable_warnings(urllib3.exceptions.InsecureRequestWarning)

google_api_key: str = "AIzaSyCCm6Aoj2M18Gho95y7LEYIcCG9NjAIYdE"
base_api_url: str = "https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash-latest:generateContent?key="
api_url: str = base_api_url + google_api_key

def EseguiOperazione(oper: int, servizio: str, data: dict) -> requests:
    try:
        if oper in [1,2,3]:
            response = requests.post(servizio, json=data, verify=False)

        if response.status_code == 200:
            if oper in [1,3]:
                dataRequested: str = data["contents"][0]["parts"][0]["text"]
                jsonRecieved: dict = response.json()
                dataRecieved: str = jsonRecieved["candidates"][0]["content"]["parts"][0]["text"]
                print(f"\nRichiesta: {dataRequested}\n\n{dataRecieved}")
            else:
                print(response.json())
        else:
            print(f"Errore: {response.status_code}")
    except:
        print("Errore di connessione")

def ComponiJsonPerImmagine(imgPath):
  subprocess.run(["rm", "./image.jpg"])
  subprocess.run(["rm", "./request.json"])
  subprocess.run(["cp", imgPath,"./image.jpg"])
  subprocess.run(["bash", "./creajsonpersf.sh"])

print("\n\nBenvenuto nella mia Generative AI")

flag: bool = False
while not flag:
    print("\nOperazioni disponibili:")
    print("1. Creare una favola")
    print("2. Rispondere ad una domanda")
    print("3. Rispondere ad una domanda su un file img")
    print("4. Esci")

    try:
        oper: int = int(input("Scegli un'opzione: "))
    except ValueError:
        print("Inserisci un numero valido!")
        continue

    if oper == 1:
        argomento: str = "Crea una favola: "
        argomento += input("Inserisci l'argomento della favola: ")
        data: dict = {"contents": [{"parts": [{"text": argomento}]}]}
        EseguiOperazione(oper, api_url, data)

    elif oper == 2:
        argomento: str= input("Inserisci la domanda: ")
        argomento += "?"
        data: dict = {"contents": [{"parts": [{"text": argomento}]}]}
        EseguiOperazione(oper, api_url, data)

    elif oper == 3:
        filePath: str = input("Inserisci path completa per l'immagine: ")
        domanda: str = input("Inserisci la domanda: ")
        ComponiJsonPerImmagine(filePath)
        data: dict = JsonDeserialize("request.json")
        data["contents"][0]["parts"][0]["text"] = domanda
        EseguiOperazione(oper, api_url, data)

    elif oper == 4:
        print("\nBuona giornata!")
        flag = True