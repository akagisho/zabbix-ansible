#!/bin/sh

HOST=$1

dig @$HOST $HOST A +time=5 +tries=1 > /dev/null 2>&1
echo $?
