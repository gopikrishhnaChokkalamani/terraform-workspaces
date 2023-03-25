output "region" {
  value = var.region
}

output "account_active" {
  value = var.account_active
}

output "account_id" {
  value = var.account_id
}

output "availability_zones" {
  value = var.availability_zones
}

output "docker_ports" {
  value = var.docker_ports
}

// env.tfvars will not be auto picked
// if you enable this it will error, unless you pass the file as -var-file in cli
//output "tfvars_variable" {
//  value = var.tfvars_variable
//}

// terraform.tfvars will be auto picked
output "terraform_tfvars_variable" {
  value = var.terraform_tfvars_variable
}

// global.auto.tfvars will be auto picked
output "global_variable" {
  value = var.global_variable
}