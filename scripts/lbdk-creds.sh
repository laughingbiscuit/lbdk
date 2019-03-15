#!/bin/bash
export APIGEE_USER=$(lpass show -u apigee)
export APIGEE_PASS=$(lpass show -p apigee)
export APIGEE_ORG=$(lpass show --notes apigee | grep "o:" | sed 's/o://')
export APIGEE_ENV=$(lpass show --notes apigee | grep "e:" | sed 's/e://')
export LINODE_CLI_TOKEN=$(lpass show --notes linode)
export CLOUDSDK_CORE_ACCOUNT=$(lpass show -u gcloud)
export CLOUDSDK_CORE_PROJECT=$(lpass show --notes gcloud | grep "p:" | sed 's/p://')
export GCLOUD_USER=$(lpass show --notes gcloud | grep 'u:' | sed 's/u://')
