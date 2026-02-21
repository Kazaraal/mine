# prometheus-deployment.tf

resource "kubernetes_deployment_v1" "prometheus" {
  metadata {
    name = "prometheus"
    namespace = kubernetes_namespace_v1.monitoring.metadata[0].name
    labels = {
      app = "prometheus"
    }
  }

  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "prometheus"
      }
    }

    template {
      metadata {
        labels = {
          app = "prometheus"
        }
      }

      spec {
        security_context {
          fs_group = 1000   # Prometheus' group ID
        }
        container {
          name = "prometheus"
          image = "prom/prometheus:v3.5.1"

          args = [
            "--config.file=/etc/prometheus/prometheus.yaml",
            "--storage.tsdb.path=/prometheus",
            "--web.enable-lifecycle",
          ]

          port {
            container_port = 9090
            name = "http"
          }

          volume_mount {
            name = "config"
            mount_path = "/etc/prometheus"
          }

          volume_mount {
            name = "data"
            mount_path = "/prometheus"
          }
        }

        volume {
          name = "config"
          config_map {
            name = kubernetes_config_map_v1.prometheus-config.metadata[0].name
          }
        }

        volume {
          name = "data"
          persistent_volume_claim {
            claim_name = kubernetes_persistent_volume_claim_v1.prometheus-pvc.metadata[0].name
          }
        }
      }
    }
  }
}