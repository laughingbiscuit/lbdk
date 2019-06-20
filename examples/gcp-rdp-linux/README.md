# GCP RDP Linux

Sometimes, you need a linux box in a private GCP network that you can RDP into that has a browser installed.

> take a look at https://cloud.google.com/solutions/chrome-desktop-remote-on-compute-engine

Here are some steps!
```bash
# provision the machine
gcloud compute instances create rdp --machine-type n1-standard-4 --image-project debian-cloud --image-family debian-9

# get chrome remote desktop installer
gcloud compute ssh $GCLOUD_USER@rdp --command "wget https://dl.google.com/linux/direct/chrome-remote-desktop_current_amd64.deb"

# update and install
gcloud compute ssh $GCLOUD_USER@rdp --command "sudo apt-get update && sudo dpkg --install chrome-remote-desktop_current_amd64.deb"
gcloud compute ssh $GCLOUD_USER@rdp --command "sudo apt install --assume-yes --fix-broken"

# install x, a desktop environment, a terminal and browser
gcloud compute ssh $GCLOUD_USER@rdp --command "sudo DEBIAN_FRONTEND=noninteractive apt-get install -y xinit lxde chromium git lxde"
```

Navigate to the following in browser for oauth consent
```
https://remotedesktop.corp.google.com/headless
```

Copy the command shown after consenting into an SSH window
```
gcloud compute ssh $GCLOUD_USER@rdp
<PASTE>

```
__Job done__

