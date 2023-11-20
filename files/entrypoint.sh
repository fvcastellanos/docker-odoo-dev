#!/bin/bash

set -e

/usr/bin/python3 -m debugpy --listen 0.0.0.0:8888 /usr/bin/odoo -c /etc/odoo/odoo.conf --db_user $USER --db_password $PASSWORD --db_host $HOST --db_port $PORT --dev all



