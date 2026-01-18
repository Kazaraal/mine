resource "kubernetes_deployment_v1" "jenkins" {
  metadata {
    name      = "jenkins"
    namespace = kubernetes_namespace_v1.ci_cd.metadata[0].name
    labels = {
      app     = "jenkins"
      version = "lts"
    }
  }

  spec {
    replicas = 1
    strategy {
      type = "Recreate"
    }

    selector {
      match_labels = {
        app = "jenkins"
      }
    }

    template {
      metadata {
        labels = {
          app     = "jenkins"
          version = "lts"
        }
      }

      spec {
        service_account_name = kubernetes_service_account_v1.jenkins.metadata[0].name

        toleration {
          key = "node-role.kubernetes.io/control-plane"
          operator = "Exists"
          effect = "NoSchedule"
        }

        security_context {
          fs_group     = 1000
          run_as_user  = 1000
          run_as_group = 1000
        }

        container {
          name  = "jenkins"
          image = "jenkins/jenkins:latest-jdk25"

          resources {
            requests = {
              cpu    = "500m"
              memory = "2Gi"
            }
            limits = {
              cpu    = "1000m"
              memory = "4Gi"
            }
          }

          port {
            container_port = 8080
            name           = "http"
          }

          port {
            container_port = 50000
            name           = "agent"
          }

          env {
            name  = "JAVA_OPTS"
            value = "-Djenkins.install.runSetupWizard=false -Xmx3072m"
          }

          env {
            name  = "CASC_JENKINS_CONFIG"
            value = "/var/jenkins_home/jenkins.yaml"
          }

          liveness_probe {
            http_get {
              path = "/login"
              port = 8080
            }
            initial_delay_seconds = 120
            period_seconds        = 10
            failure_threshold     = 10
          }

          readiness_probe {
            http_get {
              path = "/login"
              port = 8080
            }
            initial_delay_seconds = 60
            period_seconds        = 10
            failure_threshold     = 10
          }

          startup_probe {
            http_get {
              path = "/login"
              port = 8080
            }
            failure_threshold = 30
            period_seconds    = 10
          }

          volume_mount {
            name       = "jenkins-data"
            mount_path = "/var/jenkins_home"
          }

          volume_mount {
            name       = "jenkins-config"
            mount_path = "/var/jenkins_home/jenkins.yaml"
            sub_path   = "jenkins.yaml"
          }
        }

        volume {
          name = "jenkins-data"
          persistent_volume_claim {
            claim_name = kubernetes_persistent_volume_claim_v1.jenkins-data.metadata[0].name
          }
        }

        volume {
          name = "jenkins-config"
          config_map {
            name = kubernetes_config_map_v1.jenkins-config.metadata[0].name
          }
        }
      }
    }
  }
}