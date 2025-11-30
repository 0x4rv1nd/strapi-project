#!/bin/bash

apt update -y
apt install -y docker.io docker-compose git

systemctl start docker
systemctl enable docker


cd /home/ubuntu
git clone https://github.com/0x4rv1nd/strapi-project.git

cd strapi-project/cms

docker-compose up -d

