#!/bin/sh

ARGS=""
while getopts n:r:d:m:s: OPT; do
  case $OPT in
    n) ARGS="$ARGS --namespace=$OPTARG" ;;
    r) ARGS="$ARGS --region=$OPTARG" ;;
    d) ARGS="$ARGS --dimensions=$OPTARG" ;;
    m) ARGS="$ARGS --metric-name=$OPTARG" ;;
    s) ARGS="$ARGS --statistics=$OPTARG" ;;
  esac
done

aws cloudwatch get-metric-statistics \
  $ARGS \
  --output text \
  --start-time `date -u -d "5 minutes ago" +%Y-%m-%dT%TZ` \
  --end-time `date -u +%Y-%m-%dT%TZ` \
  --period 300 \
  | sort -k 3,3 | tail -n 1 | awk '{print $2}'
