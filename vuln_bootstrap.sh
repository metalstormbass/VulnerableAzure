#!/bin/bash

# Update and download nginx/uwsgi
until sudo apt-get update && sudo apt install nginx --yes --force-yes;do
    sleep 1
done

#Install Django
until sudo apt install python3-pip --yes --force-yes;do
    sleep 1
done

until sudo pip3 install django ;do
    sleep 1
done

# Pull VulnerableWebApp
cd /home/$name/
dir=/home/$name/

until sudo git clone https://github.com/metalstormbass/VulnerableWebApp.git;do
    sleep 1
done

# Gather IP address

ip_address=$(dig +short myip.opendns.com @resolver1.opendns.com)

# Modify Nginx Config to allow access to Vulnerable Web App


sudo touch /etc/nginx/conf.d/VulnerableWebApp.conf

sudo chmod a+w /etc/nginx/conf.d/VulnerableWebApp.conf

sudo cat <<EOT >> /etc/nginx/conf.d/VulnerableWebApp.conf
server {
  listen 80;
  listen [::]:80;
  server_name $ip_address;
  location / {
      proxy_pass http://localhost:8000/;
  }
}
EOT

sudo service nginx restart
sleep 2
sudo nginx -s reload

sudo python3 $dir/VulnerableWebApp/VulnerableWebApp/manage.py runserver &

