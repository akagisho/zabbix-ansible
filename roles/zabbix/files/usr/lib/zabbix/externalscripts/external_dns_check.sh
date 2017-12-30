#!/bin/sh

HOST=$1
DOMAIN=$2
TYPE=$3

[ -z "$DOMAIN" ] && DOMAIN=$HOST
[ -z "$TYPE" ] && TYPE="A"

RESULT=`dig @$HOST $DOMAIN $TYPE +time=4 +tries=2 2> /dev/null`

rval=$?
if [ $rval != 0 ]; then
  echo 0
  exit
fi

LF=$(printf '\\\012_')
LF=${LF%_}

echo "$RESULT" \
  | sed 's/, /'"$LF"'/g' \
  | grep ANSWER: \
  | cut -d' ' -f2
