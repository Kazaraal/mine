# prometheus-service 

resource "kubernetes_service_v1" "prometheus-svc" {
  metadata {
    name = "prometheus-svc"
    namespace = kubernetes_namespace_v1.monitoring.metadata[0].name
  }

  spec {
    selector = {
      app = "prometheus"
    }

    port {
      port = 9090
      target_port = 9090
      protocol = "http"
    }

    type = "NodePort"
  }
}