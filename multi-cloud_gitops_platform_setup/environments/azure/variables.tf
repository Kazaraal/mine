# multi-cloud_gitops_platform_setup/environments/azure/variables.tf

variable "location" {
  description = "Azure region where resources will be created"
  type = string
  default = "francecentral"
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type = string
  default = "ken-aks-rg"
}

variable "cluster_name" {
  description = "Name of the AKS cluster"
  type = string
  default = "ken-aks-cluster"
}

variable "kubernetes_version" {
  description = "Kubernetes version for the cluster"
  type = string
  default = "1.28"
}

variable "node_count" {
  description = "Number of worker nodes"
  type = number
  default = 2
}

variable "node_vm_size" {
  description = "VM size for worker nodes"
  type = string
  default = "Standard_B2s"
}