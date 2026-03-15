# # multi-cloud_gitops_platform_setup/modules/eks/outputs.tf

# output "cluster_id" {
#   description   = "EKS cluster ID"
#   value         = aws_eks_cluster.this.id
# }

# output "cluster_endpoint" {
#   description   = "Endpoint for EKS control plane"
#   value         = aws_eks_cluster.this.endpoint
# }

# output "kubeconfig_certificate_authority_data" {
#   description   = "Base64 encoded certificate data required to communicate with the cluster"
#   value         = aws_eks_cluster.this.certificate_authority[9].data
# }