#!/bin/bash

###
# Delete all Specifications from a Drupal 8 Apigee Portal
# 
# Usage: ./deleteAllSpecs.sh (<Username> <Password> <URL>)
# E.g. : ./deleteAllSpecs.sh 
#
# Defaults
# Drupal URL : http://localhost:8080
# Drupal User: admin
# Drupal Pass: pass
###

set -e
set -o pipefail
set -u

###
# Get Arguments
###
__dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DRUPAL_USER="${1-admin}"
DRUPAL_PASS="${2-pass}"
DRUPAL_URL="${3-http://localhost:8080}"

###
# Warning Message
###
echo "This script will delete all specifications. Here is 5 seconds to change your mind with Ctrl+C"
sleep 5

###
# Inc Counter and delete until response is 404
###
COUNT=1
while [ $(curl -s -o /dev/null -w "%{http_code}" \
  -X DELETE \
  -u $DRUPAL_USER:$DRUPAL_PASS \
  $DRUPAL_URL/api/$COUNT?_format=json) \
  -ne 404 ]
do
  COUNT=$[$COUNT+1]
done

echo "Deleted docs for $[$COUNT-1] APIs"
