#!/usr/bin/env python

from flask import Flask, render_template, request, redirect, make_response
#from ruamel.yaml import YAML
from pathlib import Path
import re
import os

app = Flask(__name__)
#config = YAML(typ='safe').load(Path('./config/config.yml'))

# Creiamo un dizionario per memorizzare le variabili di ambiente corrispondenti
acf_vars = {key: value for key, value in os.environ.items() if key.startswith('ACF_')}


@app.errorhandler(404)
def redirect_to_lower(error):
    if request.url.islower():
        return error, 404
    return redirect(request.url.lower(), 308)


@app.route('/mail/config-v1.1.xml', methods=['GET'])
def thunderbird():
    #template=render_template('thunderbird.xml', **config)
    template=render_template('thunderbird.xml', **acf_vars)
    response=make_response(template)
    response.headers['Content-Type'] = 'text/xml'
    return response


@app.route('/autodiscover/autodiscover.xml', methods=['POST'])
def outlook():
    email = re.search(r'<EMailAddress>(.+)</EMailAddress>', request.data.decode('UTF8'))
    if email is None:
        return 'Invalid autodiscover XML.', 400
    email = email[1]

    #return render_template('outlook.xml', email=email, **config)
    return render_template('outlook.xml', email=email, **acf_vars)

if __name__ == '__main__':
   # Stampa il dizionario per verificarne il contenuto
   print("Config Variables are:")
   for key, value in acf_vars.items():
        print(f'{key}={value}', flush=True)
   app.run(debug=True, port=5000, host='0.0.0.0')
