#!/bin/bash
curl -u $APIGEE_USER:$APIGEE_PASS -H "Content-Type: text/xml" -d '<KeyStore name="myKeystore"/>' https://api.enterprise.apigee.com/v1/o/$APIGEE_ORG/e/$APIGEE_ENV/keystores -v
