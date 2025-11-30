provider "aws" {
  region = "ap-south-1"  # Mumbai, free-tier friendly
}

# Security group for SSH + Strapi
resource "aws_security_group" "strapi_sg" {
  name        = "strapi-free-tier-sg"
  description = "Allow SSH + Strapi"
  
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Strapi"
    from_port   = 1337
    to_port     = 1337
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# EC2 instance
resource "aws_instance" "strapi_server" {
  ami           = "ami-0f5ee92e2d63afc18"  # Ubuntu 22.04 LTS, free-tier
  instance_type = "t3.micro"               # FREE-TIER
  key_name      = "strapi-key"             # Your SSH key in AWS

  user_data = file("${path.module}/user_data.sh")
  vpc_security_group_ids = [aws_security_group.strapi_sg.id]

  tags = {
    Name = "strapi-free-tier"
  }
}
