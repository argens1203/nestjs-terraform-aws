resource "tls_private_key" "key_pair" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "us-west-2"
}

resource "aws_key_pair" "generated_key" {
  public_key = tls_private_key.key_pair.public_key_openssh
}

resource "aws_instance" "app_server" {
  ami                    = "ami-08d70e59c07c61a3a"
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.generated_key.key_name
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]

  tags = {
    Name = var.instance_name
  }
}

resource "aws_security_group" "allow_ssh" {
  egress = [{
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = []
    protocol         = "-1"
    from_port        = 0
    to_port          = 0
    description      = ""
    prefix_list_ids  = []
    security_groups  = []
    self             = false
  }]
  ingress = [{
    description      = ""
    ipv6_cidr_blocks = []
    prefix_list_ids  = [],
    security_groups  = [],
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"],
    self             = false
  }]
}
