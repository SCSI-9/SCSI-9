#!/usr/bin/env bash

DBUSER=demo1
DBPASSWD=1Q2W3E4r5tzxc@

mysql -u "$DBUSER" -p"$DBPASSWD" -e "SHOW DATABASES"