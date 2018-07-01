#!/bin/sh

URL=$1

RESULT=`curl -sL "$URL"`

rval=$?
if [ $rval != 0 ]; then
  echo "ZBX_NOTSUPPORTED"
  exit 1
fi

echo $RESULT
