# multi-cloud_gitops_platform_setup/modules/eks/main.tf

resource "null_resource" "placeholder" {
  triggers = {
    always_run = timestamp()
  }
}
  data "aws_availability_zones" "available" {
    state = "available"
  }