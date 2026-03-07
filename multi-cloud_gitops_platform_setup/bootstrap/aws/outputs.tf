# multi-cloud_gitops_platform_setup/bootstrap/aws/outputs.tf
output "bucket_name" {
  value = aws_s3_bucket.terraform_state.id
}

output "bucket_arn" {
  value = aws_s3_bucket.terraform_state.arn
}