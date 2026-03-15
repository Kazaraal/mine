# multi-cloud_gitops_platform_setup/environments/aws/providers.tf

terraform {
  required_version = ">= 1.14"
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 5.0"
    }
    # We may also need kubernetes and helm providers later for ArgoCD installation

    kubernetes = {
        source = "hashicorp/kubernetes"
        version = "~> 2.23"
    }
    helm = {
        source = "hashicorp/helm"
        version = "~> 2.12"
    }
  }
}

provider "aws" {
  region = var.aws_region
  # Authentication is handled via AWS CLI environment variables, ~/.aws/credentials, or IAM role.
  # No explicit keys needed here.
}