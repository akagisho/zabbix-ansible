#!/bin/sh

HOST=$1

dig @$HOST $HOST A +time=4 +tries=2 > /dev/null 2>&1
echo $?
