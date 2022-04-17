# terraform {
#     required_providers {
#         aws = {
#           source  = "registry.terraform.io/hashicrop/aws"
#           version = "~> 3.0"
#         }
#     }
# }


provider "aws" {
    region     = "us-east-1"
    access_key = "${var.access_key}"
    secret_key = "${var.secret_key}" 
}

resource  "aws_instance" "ec2_instance" {
  vpc_id      = aws_instance.ec2_instance.id
  ami           = "${var.ami}"
  instance_type = var.instance_type

  tags = {
    Name = "my_instance"
  }
}

resource "aws_vpc" "my_vpc" {
    cidr_block           = "${var.cidr_block}"
    enable_dns_hostnames = true
    tags = {
        Name  = "myvpc"
        Owner = "kishore"
        environment = "prod"
    }
}

resource "aws_internet_gateway" "my_vpcgw" {
    vpc_id = "${aws_vpc.my_vpc.id}"
    tags = {
      "Name" = "myvpc-igw"
    }
} 

resource "aws_subnet" "my_subnet1" {
    vpc_id = aws_vpc.my_vpc.id
    cidr_block = "${var.cidr_block_subnet1}"
    availability_zone = "us-east-1a"
    tags = {
      "Name" = "my_subnet1"
    }
}

resource "aws_subnet" "my_subnet2" {
    vpc_id = aws_vpc.my_vpc.id
    cidr_block = "${var.cidr_block_subnet2}"
    availability_zone = "us-east-1b"
    tags = {
      "Name" = "my_subnet2"
    }
}

resource  "aws_instance" "ec2_instance" {
 # vpc_id      = aws_instance.ec2_instance.id
  ami           = "${var.ami}"
  instance_type = var.instance_type

  tags = {
    Name = "my_instance"
  }
}