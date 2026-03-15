terraform {
  backend "s3" {
    key = "eks-cluster/terraform.tfstate"
    region = "eu-west-2"
    encrypt = true
    use_lockfile = true  # Enables S3 native locking (Terraform 1.11+)
    # bucket = provided via -backend-config or file
  }
}

# When initializing the main AWS environment, you'll run:
# cd environments/aws
# terraform init -backend-config="bucket=my-multi-cloud-tfstate-unique123"