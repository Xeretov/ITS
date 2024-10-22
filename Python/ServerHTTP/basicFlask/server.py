from logging import FileHandler,WARNING
from flask import Flask, render_template, request
api = Flask("__name__", template_folder="./templates")
utenti = [["mariorossi@gamil.com","mariorossi85","baubau66",0]]

@api.route('/', methods=['GET'])
def index():
    return render_template('index.html')

@api.route('/regok', methods=['GET'])
def regok():
    return render_template("reg_ok.html")

@api.route('/regko', methods=['GET'])
def regko():
    return render_template("reg_ko.html")

@api.route('/registrati', methods=['POST'])
def registrati():
    utente=[]
    utente.append(request.args.get('email'))
    utente.append(request.args.get('cf'))
    utente.append(request.args.get('passw'))
    utente.append(0)
    if utente in utenti:
        return render_template('reg_ok.html')
    else:
        return render_template('reg_ko.html')

api.run(host="0.0.0.0", port=8085)
