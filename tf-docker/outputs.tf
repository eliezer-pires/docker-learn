output "s3_bucket" {
  value = aws_s3_bucket_versioning.terraform_state.bucket
}

output "dynamodb_table" {
  value = aws_dynamodb_table.terraform_lock.name
}