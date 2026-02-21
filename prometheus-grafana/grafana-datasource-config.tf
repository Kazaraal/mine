resource "kubernetes_config_map_v1" "grafana-datasource" {
  metadata {
    name = "grafana-datasource"
    namespace = kubernetes_namespace_v1.monitoring.metadata[0].name
    labels = {
      app = "grafana"
    }
  }

  data = {
    "datasource.yaml" = <<-EOF
apiVersion: 1

datasources:
  -  name: Prometheus
     type: prometheus
     access: proxy
     url: http://prometheus-svc:9090
     isDefault: true
EOF
  }
}
