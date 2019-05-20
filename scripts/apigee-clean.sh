#!/bin/bash
#set -o xtrace
set -e
set -o pipefail 

MGMT_HOST="https://api.enterprise.apigee.net/v1/o/$APIGEE_ORG"

# Get list of API Proxies
PROXIES=$(curl -s -u $APIGEE_USER:$APIGEE_PASS \
  $MGMT_HOST/apis |\
  jq -r '. | join(" ")')


# Get list of Shared Flows
SHAREDFLOWS=$(curl -s -u $APIGEE_USER:$APIGEE_PASS \
  $MGMT_HOST/sharedflows |\
  jq -r '. | join(" ")')

# Get list of Environments
ENVIRONMENTS=$(curl -s -u $APIGEE_USER:$APIGEE_PASS \
  $MGMT_HOST |\
  jq -r '.environments | join(" ")')

# Undeploy all proxies
FORCE="action=undeploy&force=force"
for PROXY in $PROXIES; do
  # Get revisions for each proxy
  REVISIONS=$(curl -u $APIGEE_USER:$APIGEE_PASS \
    $MGMT_HOST/apis/$PROXY |\
    jq -r '.revision | join(" ")')

  for ENV in $ENVIRONMENTS; do
    for REV in $REVISIONS; do
      # Force undeploy
      curl -u $APIGEE_USER:$APIGEE_PASS \
        -XPOST \
        "$MGMT_HOST/apis/$PROXY/revisions/$REV/deployments?$FORCE&env=$ENV" \
        -d ''
    done
  done

  # delete proxies
  curl -u $APIGEE_USER:$APIGEE_PASS \
    -XDELETE \
    "$MGMT_HOST/apis/$PROXY"
done

# shared flows
for FLOW in $SHAREDFLOWS; do
  # get revisions for each shared flow
  F_REVISIONS=$(curl -u $APIGEE_USER:$APIGEE_PASS \
      "$MGMT_HOST/sharedflows/$FLOW" |\
      jq -r '.revision | join(" ")')

  for ENV in $ENVIRONMENTS; do
    for F_REV in $F_REVISIONS; do
      #undeploy shared flow
      curl -u $APIGEE_USER:$APIGEE_PASS \
        -XDELETE \
        "$MGMT_HOST/e/$ENV/sharedflows/$FLOW/revisions/$F_REV/deployments" \
        -d ''
    done
  done

  #delete shared flow
  curl -u $APIGEE_USER:$APIGEE_PASS \
    -XDELETE \
    "$MGMT_HOST/sharedflows/$FLOW" \
    -d ''
done
