output "region" {
  value = var.region
}

output "vpc-azs" {
  value = module.vpc.azs
}

output "vpc-public-subnets" {
  value = module.vpc.public_subnets
}

output "vpc-private-subnets" {
  value = module.vpc.private_subnets
}

output "instance_arn" {
  value = module.ec2-instance.arn
}

output "instance_id" {
  value = module.ec2-instance.id
}

output "instance_public_ip" {
  value = module.ec2-instance.public_ip
}

output "instance_subnet" {
  value = module.vpc.public_subnets[0]
}

output "Message" {
  value = "Go check the AWS Console for custom VPC & EC2 instance inside public subnet"
}

