# multi-cloud_gitops_platform_setup/environments/aws/backend.tf
terraform {
  backend "s3" {
    key           = "eks-cluster/terraform.tfstate"
    region        = "eu-west-2"
    encrypt       = true
    use_lockfile  = true  # Enables S3 native locking (Terraform 1.11+)
    # bucket      = provided via -backend-config or file
  }
}

# When initializing the main AWS environment, you'll run:
# cd environments/aws
# terraform init -backend-config="bucket=ken-aws-multi-cloud-tfstate-unique-bucket"

# OR

# Create a file backend.hcl with:
# 'bucket = "ken-aws-multi-cloud-tfstate-unique-bucket"'
# And then use terraform init -backend-config=backend.hcl.