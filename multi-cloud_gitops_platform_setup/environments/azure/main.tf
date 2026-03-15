# multi-cloud_gitops_platform_setup/environments/azure/main.tf

module "aks_cluster" {
  source = "../../modules/aks"

  location = var.location
  resource_group_name = var.resource_group_name
  cluster_name = var.cluster_name
  kubernetes_version = var.kubernetes_version
  node_count = var.node_count
  node_vm_size = var.node_vm_size

  tags = {
    Environment = "dev"
    ManagedBy = "Terraform"
  }
}