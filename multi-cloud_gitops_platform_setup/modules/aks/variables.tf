# multi-cloud_gitops_platform_setup/modules/aks/variables.tf

variable "location" {
  description   = "Azure region"
  type          = string
}

variable "resource_group_name" {
  description   = "Resource group name"
  type          = string
}

variable "cluster_name" {
  description   = "AKS cluster name"
  type          = string
}

variable "kubernetes_version" {
  description   = "Kubernetes version"
  type          = string
}

variable "node_count" {
  description   = "Number of worker nodes"
  type          = number
}

variable "node_vm_size" {
  description   = "VM size for worker nodes"
  type          = string
}

variable "tags" {
  description   = "Tags to apply to resources"
  type          = map(string)
  default       = {}
}