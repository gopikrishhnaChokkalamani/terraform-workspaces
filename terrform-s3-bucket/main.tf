terraform {
  required_version = ">= 0.14.0"
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

module "s3-bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"
  version = "3.7.0"
  bucket = "cgk-s3-bucket-from-terraform"
}