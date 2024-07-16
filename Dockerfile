FROM python:3.12-slim-bookworm

RUN apt-get clean \
    && apt-get -y update \
	&& apt-get -y  dist-upgrade \
    && apt-get clean

WORKDIR /srv/flask_app
COPY ./requirements.txt /srv/flask_app
RUN python -m pip install --upgrade pip
RUN pip install -r requirements.txt

COPY ./src .
RUN chmod +x ./start.sh

CMD ["./start.sh"]
