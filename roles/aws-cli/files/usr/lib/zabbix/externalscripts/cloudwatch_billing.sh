#!/bin/sh

SERVICE_NAME=$1

DIMENSIONS=""
if [ ! -z "$SERVICE_NAME" ]; then
  DIMENSIONS=',{"Name":"ServiceName","Value":"'$SERVICE_NAME'"}'
fi

aws cloudwatch get-metric-statistics \
  --output text \
  --region us-east-1 \
  --namespace AWS/Billing \
  --metric-name EstimatedCharges \
  --start-time `date -u -d "1 days ago" +%Y-%m-%dT%TZ` \
  --end-time `date -u +%Y-%m-%dT%TZ` \
  --period 300 \
  --statistics Maximum \
  --dimensions '[{"Name":"Currency","Value":"USD"}'$DIMENSIONS']' \
  | sort -k 3,3 | tail -n 1 | awk '{print $2}'
