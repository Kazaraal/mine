# multi-cloud_gitops_platform_setup/environments/azure/argocd/backend.tf

terraform {
  backend "azurerm" {
    resource_group_name     = "ken-terraform-state-rg"
    storage_account_name    = "kenmulticloudtfstate"
    container_name          = "tfstate"
    key                     = "argocd/terraform.tfstate"
  }
}

# ACCESSING AKS IN THE TERMINAL
# The below Merged "ken-aks-cluster" as current context in /home/ken/.kube/config
# az aks get-credentials --resource-group ken-aks-rg --name ken-aks-cluster
# kubectl get nodes
# kubectl get svc argocd-server -n argocd


# AUTHENTICATION
# Fixing the Backend Authentication
# 1. Retrieve the storage account key
# cd /multi-cloud_gitops_platform_setup/bootstrap/azure
# terraform output primary_access_key

# 2. Copy the key value & Set the environment variable (in the terminal where you'll run Terraform):
# export ARM_ACCESS_KEY="your-access-key"

# 3. Modify environments/azure/argocd/backend.tf to use the access key method instead of Azure AD:
# access_key is automatically read from ARM_ACCESS_KEY environment variable
# Now run terraform init
# It should succeed without the 403 error.