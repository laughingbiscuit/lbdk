# Installing Apigee Edge on a single node (All-In-One)

For installation instructions for the latest version, please visit [here](https://docs.apigee.com/private-cloud/versions).

Prerequisites:
- GCP Account
- Apigee License Key

## Provision Instance
Requirements can be found [here](https://docs.apigee.com/private-cloud/v4.19.01/installation-requirements).

```bash
# create instance
gcloud compute instances create aio --machine-type n1-standard-16 --image-project centos-cloud --image-family centos-7

# try to access it
# gcloud compute ssh $GCLOUD_USER@aio
```

## Update sources and install dependencies
```bash
gcloud compute ssh $GCLOUD_USER@aio --command "sudo yum update -y"
gcloud compute ssh $GCLOUD_USER@aio --command "sudo yum install -y java-1.8.0-openjdk-headless curl yum-utils yum-plugin-priorities"
```

Disable SE Linux
```bash
gcloud compute ssh $GCLOUD_USER@aio --command "sudo setenforce 0"
```

Enable EPEL Repo if required, in my case it was already installed within the image. You can check if this returns anything:
```bash
gcloud compute ssh $GCLOUD_USER@aio --command "yum repolist | grep epel"
```

Install apigee-setup
```bash
gcloud compute ssh $GCLOUD_USER@aio --command "curl https://software.apigee.com/bootstrap_4.19.01.sh -o /tmp/bootstrap_4.19.01.sh"
gcloud compute ssh $GCLOUD_USER@aio --command "sudo bash /tmp/bootstrap_4.19.01.sh apigeeuser=$APIGEE_REPO_USER apigeepassword=$APIGEE_REPO_PASS"
gcloud compute ssh $GCLOUD_USER@aio --command "/opt/apigee/apigee-service/bin/apigee-service apigee-setup install"

```

Ensure license and config files are present
```bash
gcloud compute ssh $GCLOUD_USER@aio --command "echo $APIGEE_LICENSE > /tmp/license.txt"
gcloud compute scp ./aio.conf $GCLOUD_USER@aio:/tmp/aio.conf
```

Run the installer
```bash
gcloud compute ssh $GCLOUD_USER@aio --command "/opt/apigee/apigee-setup/bin/setup.sh -p aio -f /tmp/aio.conf"
```

Verify the install
```
gcloud compute ssh $GCLOUD_USER@aio --command "/opt/apigee/apigee-service/bin/apigee-service apigee-validate install"
gcloud compute ssh $GCLOUD_USER@aio --command "/opt/apigee/apigee-service/bin/apigee-service apigee-validate setup -f /tmp/aio.conf"
```

___Job done!__
