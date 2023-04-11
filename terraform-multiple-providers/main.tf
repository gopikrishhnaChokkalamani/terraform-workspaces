terraform {
  required_version = ">= 0.14.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
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
  region = "us-east-1"
}

provider "aws" {
  alias  = "east-2"
  region = "us-east-2"
}

resource "aws_instance" "dev-east-1" {
  ami           = "ami-006dcf34c09e50022"
  instance_type = "t3.micro"
  tags = {
    Name = "terraform-instance-ec2"
  }
}

resource "aws_instance" "dev-east-2" {
  provider      = aws.east-2
  ami           = "ami-0103f211a154d64a6" // east-1 ami is not available in east-2, so using this ami
  instance_type = "t3.micro"
  tags = {
    Name = "terraform-instance-ec2"
  }
}