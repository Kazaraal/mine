# multi-cloud_gitops_platform_setup/environments/aws/main.tf

module "eks_cluster" {
  source = "../../modules/eks"

  aws_region         = var.aws_region
  vpc_cidr           = var.vpc_cidr
  cluster_name       = var.cluster_name
  kubernetes_version = var.kubernetes_version
  node_instance_type = var.node_instance_type
  desired_node_count = var.desired_node_count
  min_node_count     = var.min_node_count
  max_node_count     = var.max_node_count

  tags = {
    Environment = "dev"
    ManagedBy   = "Terraform"
  }
}


# ECR repository for the application
resource "aws_ecr_repository" "app_repo" {
  name                 = "${var.cluster_name}-app-repo"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Environment = "dev"
    ManagedBy   = "Terraform"
  }
}


# Data sources to get authentication info for the EKS cluster
data "aws_eks_cluster" "this" {
  name       = module.eks_cluster.cluster_name
  depends_on = [module.eks_cluster] # ensure cluster is created
}

data "aws_eks_cluster_auth" "this" {
  name = module.eks_cluster.cluster_name
}


# Configure Kubernetes provider to use the EKS cluster
provider "kubernetes" {
  host                   = data.aws_eks_cluster.this.endpoint #aws_eks_cluster.this.endpoint #
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.this.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.this.token
}

provider "helm" {}


# Install ArgoCD using Helm
resource "helm_release" "argocd" {
  name             = "argocd"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  namespace        = "argocd"
  create_namespace = true
  version          = "5.51.4"

  values = [
    yamlencode({
      server = {
        service = {
          type = "LoadBalancer"
        }
        configs = {
          params = {
            "server.insecure" = true
          }
        }
      }
    })
  ]
}


# Password retrieval
resource "null_resource" "get_argocd_password" {
  depends_on = [helm_release.argocd]

  provisioner "local-exec" {
    command = <<-EOT
      echo "Waiting for ArgoCD secret to be created..."
      sleep 30 # Give Kubernetes a moment to create the secret
      kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d > argocd-password.txt
      echo "Password saved to argocd-password.txt"
    EOT
  }

  # Triggers to re-run this provisioner if the Helm release is updated
  triggers = {
    helm_release = helm_release.argocd.id
  }
}

# Output the ArgoCD server URL (if LoadBalancer is used)
output "argocd_server_url" {
  description = "Run this command to get the ArgoCD server LoadBalancer URL"
  value       = "kubectl get svc argocd-server -n argocd -o jsonpath='{.status.loadBalancer.ingress[0].hostname}'"
  depends_on  = [helm_release.argocd]
}


#Output the initial admin password created by the null_resource
output "argocd_initial_secret" {
  description = "Initial ArgoCD admin password (saved locally to argocd-password.txt)"
  value       = fileexists("${path.module}/argocd-password.txt") ? file("${path.module}/argocd-password.txt") : "Password not yet available. Run 'cat argocd-password.txt' after apply finishes."
  depends_on  = [null_resource.get_argocd_password]
}

# Output ecr repository url
output "ecr_repository_url" {
  value = aws_ecr_repository.app_repo.repository_url
}


# Add the EBS CSI Driver Add-on
resource "aws_eks_addon" "ebs_csi" {
  cluster_name = module.eks_cluster.cluster_name
  addon_name   = "aws-ebs-csi-driver"
  depends_on   = [module.eks_cluster] # Ensure cluster exists first
}