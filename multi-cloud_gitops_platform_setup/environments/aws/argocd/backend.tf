# multi-cloud_gitops_platform_setup/environments/aws/argocd/backend.tf
terraform {
  backend "s3" {
    bucket          = "ken-aws-multi-cloud-tfstate-unique-bucket"
    key             = "argocd/terraform.tfstate"
    region          = "eu-west-2"
    encrypt         = true
    use_lockfile    = true
  }
}