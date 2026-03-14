# /multi-cloud_gitops_platform_setup/environments/azure

terraform {
  backend "azurerm" {
    key                     = "aks-cluster/terraform.tfstate"
    # resource_group_name   = provided dynamically
    # storage_account_name  = provided dynamically
    # container_name        = provided dynamically
    # access_key            = provided dynamically (or use Azure AD auth)
  }
}

# When initializing, you'll provide the values:
# cd environments/azure
# terraform init \
#   -backend-config="resource_group_name=terraform-state-rg" \
#   -backend-config="storage_account_name=multicloudtfstate12345" \
#   -backend-config="container_name=tfstate" \
#   -backend-config="access_key=..."