terraform {
  required_version = ">= 0.14.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.57.1"
    }
  }
}

provider "aws" {
  region = var.region
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.19.0"
  name    = "my-terraform-vpc"
  cidr    = "10.0.0.0/16"
  azs = [
    "us-east-1a",
    "us-east-1b",
  "us-east-1c"]
  public_subnets = [
    "10.0.1.0/24",
    "10.0.2.0/24",
  "10.0.3.0/24"]
  private_subnets = [
    "10.0.101.0/24",
    "10.0.102.0/24",
  "10.0.103.0/24"]
  enable_nat_gateway = true
  enable_vpn_gateway = true
  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

module "security-group" {
  source      = "terraform-aws-modules/security-group/aws"
  version     = "4.17.1"
  name        = "web-server-sg"
  description = "Security group for user-service with custom ports open within VPC, and PostgreSQL publicly open"
  ingress_cidr_blocks = [
  "0.0.0.0/0"]
  ingress_rules = [
    "https-443-tcp",
  "http-80-tcp"]
  ingress_with_cidr_blocks = [
    {
      rule        = "postgresql-tcp"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      description = "ssh"
      cidr_blocks = "0.0.0.0/0"
    }
  ]
  egress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      description = "User-service ports"
      cidr_blocks = "0.0.0.0/0"
    }
  ]
  vpc_id = module.vpc.vpc_id
}

module "ec2-instance" {
  source        = "terraform-aws-modules/ec2-instance/aws"
  version       = "4.3.0"
  create        = true
  instance_type = var.instance_type
  name          = var.instance_name
  ami           = var.instance_id
  tags = {
    Name = var.instance_name
  }
  vpc_security_group_ids = [module.security-group.security_group_id]
  subnet_id              = module.vpc.public_subnets[0]
  user_data              = file("ec2_user_data.sh")
}