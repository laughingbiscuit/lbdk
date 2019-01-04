#!/bin/bash
export APIGEE_USER=$(lpass show -u apigee)
export APIGEE_PASS=$(lpass show -p apigee)
export APIGEE_ORG=$(lpass show --notes apigee | grep "o:" | sed 's/o://')
export APIGEE_ENV=$(lpass show --notes apigee | grep "e:" | sed 's/e://')
