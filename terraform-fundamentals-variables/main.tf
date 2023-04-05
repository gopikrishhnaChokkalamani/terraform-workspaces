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
      name = "terraform-variables"
    }
  }
}

provider "aws" {
  region = var.region
}