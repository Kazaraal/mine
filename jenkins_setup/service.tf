# service.tf

resource "kubernetes_service_v1" "jenkins-svc" {
  metadata {
    name        = "jenkins-svc"
    namespace   = kubernetes_namespace_v1.ci-cd.metadata[0].name
  }

  spec {
    selector = {
      app = "jenkins"
    }

    port {
      name          = "http"
      port          = 8080
      target_port   = 8080
      node_port     = 30080
    }

    port {
      name          = "agent"
      port          = 50000
      target_port   = 50000
      node_port     = 30050
    }

    type = "NodePort"
  }
}