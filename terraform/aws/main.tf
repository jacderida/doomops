terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
  backend "s3" {
    bucket = "terraform-doomops"
    key    = "terraform.tfstate"
    region = "eu-west-1"
  }
}

provider "aws" {
  region = "eu-west-1"
}

resource "aws_vpc" "odamex" {
  cidr_block           = "172.16.0.0/16"
  enable_dns_hostnames = true
  tags = {
    Name = "odamex"
  }
}

resource "aws_subnet" "odamex" {
  vpc_id            = aws_vpc.odamex.id
  cidr_block        = "172.16.10.0/24"
  availability_zone = "eu-west-1a"
  tags = {
    Name = "odamex"
  }
}

resource "aws_internet_gateway" "odamex" {
  vpc_id = aws_vpc.odamex.id
  tags = {
    Name = "odamex"
  }
}

resource "aws_route_table" "odamex" {
  vpc_id = aws_vpc.odamex.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.odamex.id
  }
  tags = {
    Name = "odamex"
  }
}

resource "aws_route_table_association" "odamex" {
  subnet_id      = aws_subnet.odamex.id
  route_table_id = aws_route_table.odamex.id
}

resource "aws_network_interface" "odamex" {
  subnet_id   = aws_subnet.odamex.id
  private_ips = ["172.16.10.100"]
  tags = {
    Name = "primary_network_interface"
  }
}

resource "aws_security_group" "odamex" {
  name        = "odamex"
  description = "Allow inbound traffic for Odamex"
  vpc_id      = aws_vpc.odamex.id

  ingress {
    description      = "Odamex"
    from_port        = 10666
    to_port          = 10666
    protocol         = "udp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  ingress {
    description      = "ssh"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "odamex"
  }
}

resource "aws_instance" "odamex" {
  ami                         = "ami-08edbb0e85d6a0a07"
  instance_type               = "t3.medium"
  subnet_id                   = aws_subnet.odamex.id
  key_name                    = "personal"
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.odamex.id]

  tags = {
    Name = "odamex"
  }
}
