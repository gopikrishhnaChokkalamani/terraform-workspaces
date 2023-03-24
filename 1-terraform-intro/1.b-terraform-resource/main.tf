terraform {
  required_version = ">= 0.14.0"
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 4.57.1"
    }
  }
  cloud {
    organization = "cgk-personal"
    workspaces {
      name = "terraform-simple-ec2-resource"
    }
  }
}

provider "aws" {
  region = var.region
}

variable "region" {
  description = "AWS region"
  default = "us-east-1"
}

resource "aws_instance" "dev" {
  ami = "ami-006dcf34c09e50022"
  instance_type = "t3.micro"
  tags = {
    Name = "terraform-instance-ec2"
  }
}