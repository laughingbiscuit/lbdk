Installing Apigee Kickstart on a VM
---


- Provision a Centos Server
```
gcloud compute instances create portal --machine-type n1-standard-16 --image-project centos-cloud --image-family centos-7
```

ssh into the machine and run the following
```
sudo yum update -y
sudo yum -y install http://rpms.remirepo.net/enterprise/remi-release-7.rpm 
sudo yum -y install epel-release yum-utils
sudo yum-config-manager --disable remi-php54
sudo yum-config-manager --enable remi-php73
sudo yum -y install php php-cli php-fpm php-mysqlnd php-zip php-devel php-gd php-mcrypt php-mbstring php-curl php-xml php-pear php-bcmath php-json curl git unzip sqlite3
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php -r "if (hash_file('sha384', 'composer-setup.php') === '48e3236262b34d30969dca3c37281b3b4bbe3221bda826ac6a9a62d6444cdb0dcd0615698a5cbe587c3f0fe57a54d8f5') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
php composer-setup.php
php -r "unlink('composer-setup.php');"
sudo mv composer.phar /usr/bin/composer
sudo chmod +x /usr/bin/composer
sudo composer create-project apigee/devportal-kickstart-project:8.x-dev portal --no-interaction
sudo sed -i 's/DocumentRoot .*/DocumentRoot \/var\/www\/portal\/web/' /etc/httpd/conf/httpd.conf
sudo httpd -k restart
```
Navigate to http://(vm IP/DNS name) to complete the installation using the UI


