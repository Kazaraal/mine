# multi-cloud_gitops_platform_setup/environments/aws/main.tf

module "eks_cluster" {
  source = "../../modules/eks"

  aws_region          = var.aws_region
  cluster_name        = var.cluster_name
  kubernetes_version  = var.kubernetes_version
  node_instance_type  = var.node_instance_type
  desired_node_count  = var.desired_node_count
  min_node_count      = var.min_node_count
  max_node_count      = var.max_node_count

  tags = {
    Environment = "dev"
    ManagedBy   = "Terraform"
  }
}