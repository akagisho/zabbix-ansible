#!/bin/sh

HOST=$1
USER=$2
PASS=$3
KEY=$4

mysql -N -h "$HOST" -u "$USER" -p"$PASS" -e "SHOW GLOBAL STATUS WHERE Variable_name='$KEY';" | awk '{print $2}'
