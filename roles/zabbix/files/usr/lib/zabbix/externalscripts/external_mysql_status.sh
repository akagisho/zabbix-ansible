#!/bin/sh

cache_seconds=60
[ "$TMPDIR" ] || TMPDIR=/tmp

HOST=$1
USER=$2
PASS=$3
KEY=$4

cache_prefix="external_mysql_$HOST"
cache="$TMPDIR/$cache_prefix.cache"
cache_timestamp_check="$TMPDIR/$cache_prefix.ts"
touch -d "@$((`date +%s` - ($cache_seconds - 1)))" "$cache_timestamp_check"

if [ "$cache" -ot "$cache_timestamp_check" ]; then
  tmp=`mktemp $cache.XXXXX`

  mysql -sN -h "$HOST" -u "$USER" -p"$PASS" -e "SHOW GLOBAL STATUS; SHOW VARIABLES" > "$tmp"
  rval=$?
  if [ $rval != 0 ]; then
    echo "ZBX_NOTSUPPORTED"
    exit 1
  fi

  mv "$tmp" "$cache"
fi

awk "{if(\$1==\"$KEY\")print \$2}" "$cache"
