output "region" {
  value = var.region
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