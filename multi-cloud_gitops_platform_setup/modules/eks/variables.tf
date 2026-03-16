# multi-cloud_gitops_platform_setup/modules/eks/variables.tf

variable "aws_region" {
  description   = "AWS region"
  type          = string
  default       = "eu-west-2"
}

variable "vpc_cidr" {
  description   = "CIDR block for the VPC"
  type          = string
  default       = "10.0.0.0/16"
}

variable "cluster_name" {
  description   = "EKS cluster name"
  type          = string
}

variable "kubernetes_version" {
  description   = "Kubernetes version"
  type          = string
}

variable "node_instance_type" {
  description   = "EC2 instance type for worker nodes"
  type          = string
}

variable "desired_node_count" {
  description   = "Desired number of worker nodes"
  type          = string
}

variable "min_node_count" {
  description   = "Minimum number of worker nodes"
  type          = string
}

variable "max_node_count" {
  description   = "Maximum number of worker nodes"
  type          = string
}

variable "tags" {
  description   = "Tags to apply to resources"
  type          = map(string)
  default       = {}
}