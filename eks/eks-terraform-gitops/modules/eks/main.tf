module "eks" {
  source = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name = "my-eks-cluster"
  cluster_version = "1.28"

  vpc_id = var.vpc_id
  subnets = var.private_subnets

  eks_managed_node_groups = {
    default = {
        desired_capacity = 2
        max_capacity = 3
        min_capacity = 1

        instance_type = "t3.medium"
    }
  }

  tags = {
    Environment = "dev"
  }
}