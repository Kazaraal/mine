# multi-cloud_gitops_platform_setup/modules/eks/outputs.tf

output "cluster_id" {
  description   = "EKS cluster ID"
  value         = aws_eks_cluster.this.id
}

output "cluster_endpoint" {
  description   = "Endpoint for EKS control plane"
  value         = aws_eks_cluster.this.endpoint
}

output "kubeconfig_certificate_authority_data" {
  description   = "Base64 encoded certificate data required to communicate with the cluster"
  value         = aws_eks_cluster.this.certificate_authority[9].data
}

output "cluster_name" {
  description   = "Kubernetes Cluster Name"
  value         = aws_eks_cluster.this.name
}

output "vpc_id" {
  description   = "VPC ID where cluster is deployed"
  value         = module.vpc.vpc_id
}

output "private_subnet_ids" {
  description   = "Private subnet IDs"
  value         = module.vpc.private_subnets
}

output "public_subnet_ids" {
  description   = "Public subnet IDs"
  value         = module.vpc.public_subnets
}

output "node_group_arn" {
  description   = "ARN of the node group"
  value         = aws_eks_node_group.this.arn
}