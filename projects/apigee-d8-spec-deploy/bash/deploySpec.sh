#!/bin/bash


###
# Deploy a Specification to a Drupal 8 Apigee Portal
# 
# Usage: ./deploySpec.sh <Spec> <API Name> <API Desc> (<Username> <Password> <URL>)
# E.g. : ./deploySpec.sh specification.yaml "API Name" "API Description"
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
FILE="${1-}"
SPEC_NAME="${2-}"
SPEC_DESC="${3-}"
DRUPAL_USER="${4-admin}"
DRUPAL_PASS="${5-pass}"
DRUPAL_URL="${6-http://localhost:8080}"

[ -z "$FILE" ] && echo "Please provide filename" && exit 1
[ -z "$SPEC_NAME" ] && echo "Please provide spec name" && exit 1
[ -z "$SPEC_DESC" ] && echo "Please provide spec description" && exit 1

echo "Uploading $FILE as $SPEC_NAME : $SPEC_DESC"

###
# Upload Swagger Specification
###
FILE_ID=$(curl -s \
  -X POST \
  -u $DRUPAL_USER:$DRUPAL_PASS \
  -H 'Content-Type: application/octet-stream' \
  -H "Content-Disposition: file; filename=\"$FILE\"" \
  --data-binary "@$FILE" \
  $DRUPAL_URL/file/upload/apidoc/apidoc/spec?_format=json \
  | jq -r '.fid[0].value')

echo "Uploaded file with ID: $FILE_ID"

###
# Create APIDoc Entity
###
ENTITY_ID=$(curl -s \
  -X POST \
  -u $DRUPAL_USER:$DRUPAL_PASS \
  -H 'Content-Type: application/json' \
  -d "{
    \"name\": [{ \"value\": \"$SPEC_NAME\" }],
    \"description\": [{ \"value\": \"$SPEC_DESC\" }],
    \"spec\": [{ \"target_id\": \"$FILE_ID\" }]
  }" \
  $DRUPAL_URL/entity/apidoc?_format=json \
  | jq -r '.id[0].value')

echo "Created API Doc Entity: $ENTITY_ID"

