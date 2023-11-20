FROM odoo:17.0

USER root

COPY ./requirements.txt /requirements.txt
COPY ./files/entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh && \
    pip3 install -r /requirements.txt && \
    rm requirements.txt
