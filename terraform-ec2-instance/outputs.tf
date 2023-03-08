output "region" {
  value = var.region
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