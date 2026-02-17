resource "kubernetes_deployment_v1" "grafana-deployment" {
  metadata {
    name = "grafana-deployment"
    namespace = kubernetes_namespace_v1.monitoring.metadata[0].name
    labels = {
      app = "grafana"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "grafana"
      }
    }

    template {
      metadata {
        labels = {
          app = "grafana"
        }
      }

      spec {
        container {
          name = "grafana"
          image = "grafana/grafana:nightly"

          port {
            name = "http"
            container_port = 3000
          }

          env {
            name = "GF_SECURITY_ADMIN_PASSWORD"
            value = "admin"    # change in production
          }

          volume_mount {
            name = "datasource"
            mount_path = "/etc/grafana/provisioning/datasources"
          }

          volume_mount {
            name = "data"
            mount_path = "/var/lib/grafana"
          }
        }

        volume {
          name = "datasource"
          config_map {
            name = kubernetes_config_map_v1.grafana_datasource.metadata[0].name
          }
        }

        volume {
          name = "data"
          persistent_volume_claim {
            claim_name = kubernetes_persistent_volume_claim_v1.grafana-pvc.metadata[0].name
          }
        }
      }
    }
  }
}
