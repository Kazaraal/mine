# multi-cloud_gitops_platform_setup/environments/aws/argocd/variables.tf

variable "cluster_name" {
  description   = "Name of the EKS cluster"
  type          = string
}