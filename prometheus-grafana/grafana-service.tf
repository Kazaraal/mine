resource "kubernetes_service_v1" "grafana-svc" {
  metadata {
    name = "grafana-svc"
    namespace = kubernetes_namespace_v1.monitoring.metadata[0].name
  }
  spec {
    selector = {
      app = "grafana"
    }
    port {
      name = "http"
      protocol = "TCP"
      port = 3000
      target_port = 3000
    }
    type = "NodePort"
  }
}
