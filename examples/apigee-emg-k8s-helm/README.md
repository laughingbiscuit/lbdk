Apigee Edge Microgateway with Helm and K8s
---

## Create and access your cluster
```
gcloud container clusters create emg-demo
gcloud container clusters get-credentials emg-demo
```

## Create and Expose the Deployment
```
kubectl run hello-server --image gcr.io/google-samples/hello-app:1.0 --port 8080
kubectl expose deployment hello-server --type LoadBalancer --port 80 --target-port 8080
```

## Setup Helm
https://medium.com/@pablorsk/kubernetes-helm-node-hello-world-c97d20437abd
```
helm init
```

## Inspect and Test

```
# wait for it to come up
kubectl get service hello-server -w
# make a request to the service
curl http://$(kubectl get service hello-server -o json | jq '.status.loadBalancer.ingress[0].ip' -r)
```

## Clean Up
```
kubectl delete service hello-service
gcloud container clusters delete emg-demo
```

