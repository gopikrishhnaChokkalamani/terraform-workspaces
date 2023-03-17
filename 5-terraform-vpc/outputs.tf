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