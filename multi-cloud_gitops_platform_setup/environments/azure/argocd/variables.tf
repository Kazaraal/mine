# multi-cloud_gitops_platform_setup/environments/azure/argocd/variables.tf

variable "cluster_name" {
  description   = "Name of the AKS cluster"
  type          = string
}

variable "resource_group_name" {
  description   = "Resource group name of the AKS cluster"
  type          = string
}