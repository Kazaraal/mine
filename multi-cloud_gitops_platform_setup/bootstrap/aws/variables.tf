# multi-cloud_gitops_platform_setup/bootstrap/aws/variables.tf
variable "region" {
  description   = "AWS region"
  type          = string
}

variable "bucket_name" {
  description   = "Globally unique S3 bucket name"
  type          = string
}