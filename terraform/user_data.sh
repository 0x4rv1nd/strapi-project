#!/bin/bash
apt update -y
apt install docker.io -y
apt install docker-compose -y
systemctl start docker
systemctl enable docker

# clone your repo
cd /home/ubuntu
git clone https://github.com/0x4rv1nd/strapi-terraform-project.git

# go to docker folder
cd strapi-terraform-project/cms

# start Strapi
docker-compose up -d
