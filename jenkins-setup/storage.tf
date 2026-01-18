resource "kubernetes_storage_class_v1" "local-storage" {
  metadata {
    name = "local-storage"
  }

  storage_provisioner = "kubernetes.io/local"
  reclaim_policy = "Delete"
  volume_binding_mode = "Immediate"
}

resource "kubernetes_persistent_volume_v1" "jenkins-pv-volume" {
  metadata {
    name = "jenkins-pv-volume"
    labels = {
      type = "local"
    }
  }

  spec {

    persistent_volume_source {
      local {
        path = "/mnt/mounted_logical_volume"
      }
    }
    capacity = {
      storage = "30Gi"
    }
    storage_class_name = kubernetes_storage_class_v1.local-storage.metadata[0].name
    access_modes       = ["ReadWriteOnce"]
    persistent_volume_reclaim_policy = "Delete"
    node_affinity {
      required {
        node_selector_term {
          match_expressions {
            key      = "kubernetes.io/hostname"
            operator = "In"
            values   = ["node2-hp", "node1-hp"]
          }
        }
      }
    }
  }
}

resource "kubernetes_persistent_volume_claim_v1" "jenkins-data" {
  metadata {
    name      = "jenkins-data"
    namespace = kubernetes_namespace_v1.ci_cd.metadata[0].name
  }

  spec {
    access_modes       = ["ReadWriteOnce"]
    storage_class_name = kubernetes_storage_class_v1.local-storage.metadata[0].name
    resources {
      requests = {
        storage = "10Gi"
      }
    }
  }
  wait_until_bound = true
}