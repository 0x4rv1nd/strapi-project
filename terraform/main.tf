provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "strapi_server" {
  ami           = "ami-06a0b4e3b7eb7a300" # Ubuntu 22.04 LTS (Free-tier eligible)
  instance_type = "t2.micro"              # FREE TIER INSTANCE
  key_name      = "strapi-key"            # Your EC2 SSH key

  # This runs Docker + Strapi automatically
  user_data = file("${path.module}/user_data.sh")

  vpc_security_group_ids = [aws_security_group.strapi_sg.id]

  tags = {
    Name = "strapi-free-tier"
  }
}

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
    description = "Strapi Admin Panel"
    from_port   = 1337
    to_port     = 1337
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "public_ip" {
  description = "Strapi public IP"
  value       = aws_instance.strapi_server.public_ip
}
