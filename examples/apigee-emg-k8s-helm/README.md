Apigee Edge Microgateway with Helm and K8s
---

## Prerequisites

Run `gcloud init` to authenticate with GCP and set the environment variables
```
export APIGEE_ORG=
export APIGEE_ENV=
export APIGEE_USER=
export APIGEE_PASS=

```

## Create and access your cluster

See [here](https://cloud.google.com/kubernetes-engine/docs/how-to/creating-a-cluster)

```
gcloud container clusters create emg-demo
gcloud container clusters get-credentials emg-demo
```

## Setup Helm and Enable the correct service account

See [here](https://helm.sh/docs/using_helm/)

```
helm init
kubectl create serviceaccount --namespace kube-system tiller
kubectl create clusterrolebinding tiller-cluster-rule --clusterrole=cluster-admin --serviceaccount=kube-system:tiller
kubectl patch deploy --namespace kube-system tiller-deploy -p '{"spec":{"template":{"spec":{"serviceAccount":"tiller"}}}}'
```

## Install and Initialise Edge Microgateway 

See [here](https://docs.apigee.com/api-platform/microgateway/2.5.x/setting-and-configuring-edge-microgateway)

```
npm install -g edgemicro
edgemicro init
edgemicro configure -o $APIGEE_ORG -e $APIGEE_ENV -u $APIGEE_USER > output.txt
```

This configure command will create a file at $HOME/.edgemicro/{org}-{env}-config.yaml AND print a key and a secret.

You will need these later!

## Create required Apigee Entities

We need a microgateway aware proxy, API Product, Developer App and Developer. 

You can do this in the UI by following these [steps] (https://docs.apigee.com/api-platform/microgateway/2.5.x/setting-and-configuring-edge-microgateway#part2createentitiesonapigeeedge) or you can use the command line.

```
npm run deploy --prefix edgemicro_helm/
apigeetool createProduct -u $APIGEE_USER -p $APIGEE_PASS -o $APIGEE_ORG --approvalType auto --environments test --productName "Edge Micro" --proxies ""
apigeetool createDeveloper -u $APIGEE_USER -p $APIGEE_PASS -o $APIGEE_ORG --firstName Test --lastName User --userName testuser@example.com --email testuser@example.com
apigeetool createApp -u $APIGEE_USER -p $APIGEE_PASS -o $APIGEE_ORG --apiProducts "Edge Micro" --email testuser@example.com --name "My App"
```

## Package Helm Chat

First, edit the properies in values.yml that are prefix with `emg`

Then package it up:

```
helm package emg-chart --debug
```

## Deploy

```
helm install emg-chart-0.1.0.tgz --name emg-helm
```

## Test

```
export POD_NAME=$(kubectl get pods --namespace default -l "app.kubernetes.io/name=emg-chart,app.kubernetes.io/instance=emg-helm" -o jsonpath="{.items[0].metadata.name}")
kubectl port-forward $POD_NAME 8080:8000 &
curl http://localhost:8080/edgemicro_helm/get

```

## Clean Up
```
gcloud container clusters delete emg-demo
```


## Future Enhancements

```

```


Reference:
https://medium.com/@pablorsk/kubernetes-helm-node-hello-world-c97d20437abd
