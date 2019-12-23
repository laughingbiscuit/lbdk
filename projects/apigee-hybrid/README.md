Apigee Hybrid
---

## Setting up Apigee Hybrid

- First we have to make sure a GCP account and Project are set. We can do this
at the same time as initialising our gcloud sdk. We may need to create an 
account and project.

```
gcloud init
```

- Next we need to make sure we have access to the APIs. If we are previewing an
early release, we may need to request access. You can check if your Project has
access:

```
gcloud services list | grep Apigee
```

- Enable the relevant APIs
```
gcloud services enable apigee.googleapis.com
gcloud services enable cloudresourcemanager.googleapis.com
gcloud services enable compute.googleapis.com
```

org:
https://docs.apigee.com/hybrid/precog-provision
