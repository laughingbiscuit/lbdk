#!/bin/bash
curl https://api.enterprise.apigee.com/v1/o/$APIGEE_ORG/developers/doctor@example.com/apps/SonicApp -u $APIGEE_USER:$APIGEE_PASS -s | jq -r ".credentials[0].consumerKey"
