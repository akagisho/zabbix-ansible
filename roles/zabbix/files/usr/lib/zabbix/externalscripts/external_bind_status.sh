#!/bin/sh

cache_seconds=60
[ "$TMPDIR" ] || TMPDIR=/tmp

HOST=$1
TYPE=$2

cache_prefix="external_bind_$HOST"
cache="$TMPDIR/$cache_prefix.cache"
cache_timestamp_check="$TMPDIR/$cache_prefix.ts"
touch -d "@$((`date +%s` - ($cache_seconds - 1)))" "$cache_timestamp_check"

if [ "$cache" -ot "$cache_timestamp_check" ]; then
  tmp=`mktemp $cache.XXXXX`

  curl -s http://$HOST:8053 | xml2 > "$tmp" 2> /dev/null
  rval=${PIPESTATUS[0]}
  if [ "$rval" != 0 ]; then
    echo "ZBX_NOTSUPPORTED"
    exit 1
  fi

  mv "$tmp" "$cache"
fi

grep -A 1 "$TYPE\$" "$cache" | head -2 | tail -1 | cut -d= -f2
