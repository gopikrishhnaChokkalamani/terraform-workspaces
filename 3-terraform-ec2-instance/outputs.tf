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

output "s3-bucket-arn" {
  value = module.s3-bucket.s3_bucket_arn
}

output "s3-bucket-domain-name" {
  value = module.s3-bucket.s3_bucket_bucket_domain_name
}

output "s3-bucket-bucket-id" {
  value = module.s3-bucket.s3_bucket_id
}

output "s3-bucket-region" {
  value = module.s3-bucket.s3_bucket_region
}