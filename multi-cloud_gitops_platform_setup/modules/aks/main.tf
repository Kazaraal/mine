# multi-cloud_gitops_platform_setup/modules/aks/main.tf

resource "null_resource" "placeholder" {
  triggers = {
    always_run = timestamp()
  }
}