#!/bin/bash
apt-get update
apt-get install -y docker.io
              
systemctl enable docker
systemctl start docker

docker pull nginx
docker run -d -p 8080:80 --name nginx-container nginx