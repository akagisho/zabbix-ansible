#!/usr/bin/env bash

set -e

function GET_LANG {
  local TARGET=$1
  mysql -sN zabbix -e "SELECT lang FROM users WHERE alias='$TARGET'"
}

if [ "`GET_LANG $1`" = "$2" ]; then
  echo "already changed"
  exit
fi

mysql zabbix -e "UPDATE users SET lang='$2' WHERE alias='$1'"

if [ "`GET_LANG $1`" != "$2" ]; then
  echo "cannot change lang"
  exit 1
fi
