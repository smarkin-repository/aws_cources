output "terraform_state_name" {
    value = aws_s3_bucket.tfbucket.id
}

output "db_terr_state_lock" {
    value = aws_dynamodb_table.db_terraform_state_lock.id
}