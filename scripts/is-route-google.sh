#!/bin/sh
set -e

# Check if the registered Organization for every hop of a tcptraceroute
SSH_USER=
SOURCE=
TARGET_IP=

# install tools
#gcloud compute ssh $SSH_USER@$SOURCE --command "sudo apt-get install -y tcptraceroute whois"  --zone $ZONE

# run traceroute
HOPS=`gcloud compute ssh $SSH_USER@$SOURCE --zone $ZONE --command "tcptraceroute $TARGET_IP 443" | awk '{ print $2 }'| sed '/\*/d'`

echo "Route:"

# run whois for each hop
for HOP in $HOPS 
do
  echo -n $HOP" - " 
  whois $HOP | grep 'Organization'
done

echo "Done. "
