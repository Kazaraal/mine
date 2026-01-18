resource "kubernetes_namespace_v1" "ci_cd" {
  metadata {
    name = "ci-cd-${var.environment}"
    labels = {
      name        = "ci-cd"
      environment = var.environment
    }
  }
}