# Gioele Amendola
# 29/09/2024

from flask import Flask, json, request, render_template
import base64


# Creazione dell'applicazione Flask
api = Flask(__name__)

@api.route('/', methods=['GET'])
def index():
    return render_template('index.html')

if __name__ == '__main__':
    api.run(host="127.0.0.1", port=8085, ssl_context='adhoc')
