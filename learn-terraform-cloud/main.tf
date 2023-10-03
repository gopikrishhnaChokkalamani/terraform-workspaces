terraform {
  required_version = ">= 0.14.0"
  cloud {
    organization = "cgk-personal"
    workspaces {
      name = "cgk-learn-terraform-cloud"
    }
  }
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 4.57.1"
    }
  }
}

provider "aws" {
  region = var.region
}

resource "aws_instance" "demo" {
  ami = "ami-006dcf34c09e50022"
  instance_type = var.instance_type
  tags = {
    Name = var.instance_name
  }
}
