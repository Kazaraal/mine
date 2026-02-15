# deployment.tf

resource "kubernetes_deployment_v1" "jenkins-deployment" {
  metadata {
    name        = "jenkins-deployment"
    namespace   = kubernetes_namespace_v1.ci-cd.metadata[0].name
    labels = {
      app = "jenkins"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "jenkins"
      }
    }

    template {
      metadata {
        labels = {
          app = "jenkins"
        }
      }

      spec {
        service_account_name = kubernetes_service_account_v1.jenkins-svc-acc.metadata[0].name

        toleration {
          key       = "node-role.kubernetes.io/control-plane"
          operator  = "Exists"
          effect    = "NoSchedule"
        }

        container {
          name  = "jenkins"
          image = "ken0k/jenkins_with_plugins:1.0.0"

          port {
            name            = "http"
            container_port  = 8080
          }

          port {
            name            = "agent"
            container_port  = 50000
          }

          volume_mount {
            name        = "jenkins-home"
            mount_path  = "/var/jenkins_home"
          }

          volume_mount {
            name        = "jenkins-jcasc"
            mount_path  = "/var/jenkins_home/casc"
            read_only   = true
          }

          resources {
            requests = {
              cpu       = "500m"
              memory    = "1Gi"
            }

            limits = {
              cpu       = "1"
              memory    = "2Gi"
            }
          }

          env {
            name    = "CASC_JENKINS_CONFIG"
            value   = "/var/jenkins_home/casc/jenkins.yaml"
          }
        }

        volume {
          name = "jenkins-home"

          persistent_volume_claim {
            claim_name = kubernetes_persistent_volume_claim_v1.jenkins-data.metadata[0].name
          }
        }

        volume {
          name = "jenkins-jcasc"

          config_map {
            name = kubernetes_config_map_v1.jenkins-jcasc.metadata[0].name
          }
        }
      }
    }
  }
}