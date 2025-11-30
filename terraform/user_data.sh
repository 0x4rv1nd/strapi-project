#!/bin/bash
# Update & install Docker
apt update -y
apt install -y docker.io docker-compose git

systemctl start docker
systemctl enable docker

# Clone your Strapi + Docker repo
cd /home/ubuntu
git clone https://github.com/0x4rv1nd/strapi-project.git

# Enter cms folder
cd strapi-project/cms

# Start Strapi using Docker Compose
docker-compose up -d

