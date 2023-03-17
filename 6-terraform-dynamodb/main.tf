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

module "dynamodb_table" {
  source = "terraform-aws-modules/dynamodb-table/aws"
  name = "my-table"
  hash_key = "id"
  attributes = [
    {
      name = "id"
      type = "N"
    },
    {
      name = "name"
      type = "S"
    }
  ]
  tags = {
    Terraform = "true"
    Environment = "staging"
  }
  point_in_time_recovery_enabled = true
  range_key = "name"
}