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

variable "region" {
  description = "AWS region"
  default     = "us-east-1"
}

resource "aws_autoscaling_group" "ec2-nginx-autoscaling-group" {
  max_size = 4
  min_size = 2
  launch_configuration = ""
}

resource "aws_security_group" "sg-0bef2ca92b31c1ddd" {}

resource "aws_launch_template" "lt-0446e801e915311ee" {}

resource "aws_alb_target_group" "ec2-nginx-autoscaling-group-1" {}

resource "aws_alb" "ec2-nginx-autoscaling-group-1" {}

resource "aws_sns_topic" "my-ec2-nginx-webserver" {}