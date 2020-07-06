#!/bin/bash

# Update and download Nginx
until sudo apt-get update && sudo apt-get -y install nginx;do
    sleep 1
done

# Update and download docker
until sudo  apt-get -y install docker.io;do
    sleep 1
done

# Pull Juice Repository
until sudo docker pull vulnerables/web-dvwa;do
    sleep 1
done

# Start Docker
sudo service nginx stop
sudo docker run --rm -it -p 80:80 vulnerables/web-dvwa



