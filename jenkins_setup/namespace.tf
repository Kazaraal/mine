# namespace.tf

resource "kubernetes_namespace_v1" "ci-cd" {
  metadata {
    name    = "ci-cd-${var.environment}"
    labels  = {
      name          = "ci-cd"
      environment   = var.environment
    }
  }
}