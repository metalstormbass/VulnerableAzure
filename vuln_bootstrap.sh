#!/bin/bash

# Update and download docker
until sudo apt-get update && sudo  apt-get -y install docker.io;do
    sleep 1
done

# Pull Juice Repository
until sudo docker pull webgoat/webgoat-8.0;do
    sleep 1
done

# Start Docker

sudo docker run --rm -it -p 80:80 webgoat/webgoat-8.0



