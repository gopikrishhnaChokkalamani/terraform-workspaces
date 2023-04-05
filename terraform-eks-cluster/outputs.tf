output "region" {
  value = var.region
}

output "cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "cluster_security_group" {
  value = module.eks.cluster_security_group_id
}

output "cluster_name" {
  value = module.eks.cluster_name
}