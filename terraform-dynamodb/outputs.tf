output "region" {
  value = var.region
}
output "dynamodb-table-arn" {
  value = module.dynamodb_table.dynamodb_table_arn
}
output "dynamodb-table-id" {
  value = module.dynamodb_table.dynamodb_table_id
}