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

module "autoscaling" {
  source  = "terraform-aws-modules/autoscaling/aws"
  version = "6.10.0"
  name = "nginx-autoscaling-group"
  instance_name = "nginx-webserver"
  min_size = 2
  max_size = 3
  availability_zones = ["us-east-1a", "us-east-1b"]
  launch_template_name        = "nginx-autoscaling-group-launch-template"
  launch_template_description = "Launch template example"
  image_id          = "ami-08a52ddb321b32a8c"
  instance_type     = "t2.micro"
  user_data = "${base64encode(file("user-data.sh"))}"
  security_groups = [module.security-group.security_group_id]
  //load_balancers = [module.alb.lb_id]
  target_group_arns = [module.alb.target_group_arns[0]]
}

module "security-group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "4.17.1"
  name = "web-server-sg"
  description = "Security group for user-service with custom ports open within VPC, and PostgreSQL publicly open"
  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules            = ["https-443-tcp", "http-80-tcp"]
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
}

module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "8.4.0"
  name = "my-alb"
  load_balancer_type = "application"
  subnets = ["subnet-d3e09fb4", "subnet-e30d48cd"]
  vpc_id = "vpc-2a52d950"
  security_groups = [module.security-group.security_group_id]
  target_groups = [
    {
      name             = "alb-target-group"
      backend_protocol = "HTTP"
      backend_port     = 80
      target_type      = "instance"
      health_check = {
        enabled             = true
        interval            = 30
        path                = "/"
        port                = "traffic-port"
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 6
        protocol            = "HTTP"
        matcher             = "200"
      }
    }
  ]
  http_tcp_listeners = [
    {
      port        = 80
      protocol    = "HTTP"
      action_type = "forward"
      forward = {
        target_groups = [
          {
            target_group_index = 0
            weight             = 100
          },
        ]
      }
    }
    ]
}