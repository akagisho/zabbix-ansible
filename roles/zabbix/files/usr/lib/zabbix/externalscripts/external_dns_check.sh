#!/bin/sh

HOST=$1
DOMAIN=$2
TYPE=$3

[ -z "$DOMAIN" ] && DOMAIN=$HOST
[ -z "$TYPE" ] && TYPE="A"

dig @$HOST $DOMAIN $TYPE +time=4 +tries=2 > /dev/null 2>&1
echo $?
