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

// this will error out, variables cannot be used as reference in another variable
//variable "hello-world" {
//  default = var.region
//  description = "hello world"
//}

resource "aws_instance" "dev" {
  //ami = "ami-006dcf34c09e50022"
  ami = var.image_id
  instance_type = "t3.micro"
  tags = {
    Name = "terraform-instance-ec2"
  }
  provisioner "local-exec" {
    when = destroy
    command = "echo 'Destroy-time provisioner'"
  }
}

variable "image_id" {
  type = string
  description = "image id"
  validation {
    condition = length(var.image_id) > 4 && substr(var.image_id, 0, 4) == "ami-"
    error_message = "image id should be a valid ami id, starting with ami-"
  }
}

//terraform plan -var='image_id=ami-006dcf34c09e50022'