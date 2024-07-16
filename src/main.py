#!/usr/bin/env python

from flask import Flask, render_template, request, redirect, make_response
from ruamel.yaml import YAML
from pathlib import Path
import re

app = Flask(__name__)
config = YAML(typ='safe').load(Path('./config/config.yml'))


@app.errorhandler(404)
def redirect_to_lower(error):
    if request.url.islower():
        return error, 404
    return redirect(request.url.lower(), 308)


@app.route('/mail/config-v1.1.xml', methods=['GET'])
def thunderbird():
    template=render_template('thunderbird.xml', **config)
    response=make_response(template)
    response.headers['Content-Type'] = 'application/xml'
    return response


@app.route('/autodiscover/autodiscover.xml', methods=['POST'])
def outlook():
    email = re.search(r'<EMailAddress>(.+)</EMailAddress>', request.data.decode('UTF8'))
    if email is None:
        return 'Invalid autodiscover XML.', 400
    email = email[1]

    return render_template('outlook.xml', email=email, **config)

if __name__ == '__main__':
   app.run(debug=True, port=5000, host='0.0.0.0')

