FROM python:3.12-slim-bookworm

RUN apt-get clean \
    && apt-get -y update \
    && apt-get -y  dist-upgrade \
    && apt-get clean

RUN apt -y install envsubst \
    && apt -y clean

WORKDIR /autoconfig
COPY ./requirements.txt /autoconfig
RUN python -m pip install --upgrade pip
RUN pip install -r requirements.txt

COPY ./src .
RUN chmod +x ./start.sh

ENV ACF_DOMAIN=example.com
ENV ACF_DESC=Example Corp

ENV ACF_INCOMING=enabled
ENV ACF_INCOMING_TYPE=IMAP
ENV ACF_INCOMING_SERVER=imap.example.com
ENV ACF_INCOMING_PORT=993
ENV ACF_INCOMING_ENC=SSL
ENV ACF_INCOMING_AUTH=password-cleartext 
ENV ACF_INCOMING_UNAME=%EMALADDRESS% 

ENV ACF_OUTGOING=enabled
ENV ACF_OUTGOING_TYPE=SMTP
ENV ACF_OUTGOING_SERVER=smtp.example.com
ENV ACF_OUTGOING_PORT=587
ENV ACF_OUTGOING_ENC=STARTTLS
ENV ACF_OUTGOING_AUTH=password-cleartext 
ENV ACF_OUTGOING_UNAME=%EMALADDRESS% 

ENV ACF_ADDBOOK=enabled
ENV ACF_ADDBOOK_TYPE=carddav
ENV ACF_ADDBOOK_URL=https://www.example.com/remote.php/dav
ENV ACF_ADDBOOK_AUTH=http-basic
ENV ACF_ADDBOOK_UNAME=%EMAILADDRESS%

ENV ACF_CAL=enabled
ENV ACF_CAL_TYPE=caldav
ENV ACF_CAL_URL=https://www.example.com/remote.php/dav
ENV ACF_CAL_AUTH=http-basic
ENV ACF_CAL_UNAME=%EMAILADDRESS%

ENV ACF_WEB=enabled
ENV ACF_WEB_URL=https://webmail.example.com/
ENV ACF_WEB_UNAME=%EMAILADDRESS%
ENV ACF_WEB_UNAME_FIELD=user
ENV ACF_WEB_PASS_FIELD=password

CMD ["./start.sh"]
