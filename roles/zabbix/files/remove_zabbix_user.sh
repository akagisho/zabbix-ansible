#!/usr/bin/env bash

set -e

function EXISTS {
  local TARGET=$1
  EXISTS=`mysql -sN zabbix -e "SELECT alias FROM users WHERE alias='$TARGET'"`
  if [ "$EXISTS" = "" ]; then
    return 1
  fi
  return 0
}

if ! `EXISTS $1`; then
  echo "already removed"
  exit
fi

mysql zabbix -e "DELETE FROM users WHERE alias='$1'"

if `EXISTS $1`; then
  echo "cannot remove $1"
  exit 1
fi
