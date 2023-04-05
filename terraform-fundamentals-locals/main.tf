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
      name = "terraform-simple-ec2-resource-with-locals-tags-count"
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

variable "created_by" {
  description = "created by"
  default = "ADMIN"
}

variable "variable_tag" {
  default = {
    "region" = "REGION"
  }
}

//Locals Example with tags
//merge function
locals {
  instance_tags = {
    CREATED_BY = var.created_by
    CREATED_ON = formatdate("DD MMM YYYY hh:mm ZZZ", timestamp())
    Name = "terraform-instance-ec2-dev"
  }
  operational_tags = {
    operational_version = "1.0.1"
    operational_stragery = "testing tags and locals"
  }
  ami = "ami-006dcf34c09e50022"
  instance_type = "t3.micro"
  tags = merge(var.variable_tag, local.instance_tags, local.operational_tags)
}

resource "aws_instance" "dev" {
  ami = local.ami
  instance_type = local.instance_type
  tags = merge(local.tags)
}

resource "aws_instance" "test" {
  ami = local.ami
  instance_type = local.instance_type
  count = 4
  tags = {
    Name = "terraform-instance-ec2-test-${count.index}"
  }
}