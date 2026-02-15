# storage.tf

# Storage Class
resource "kubernetes_storage_class_v1" "local-storage" {
  metadata {
    name = "local-storage"
  }

  storage_provisioner   = "kubernetes.io/no-provisioner"
  reclaim_policy        = "Delete"
  volume_binding_mode   = "Immediate"
}


# Persistent Volume
resource "kubernetes_persistent_volume_v1" "jenkins-pv-volume" {
  metadata {
    name    = "jenkins-pv-volume"
    labels  = {
      type  = "local"
    }
  }

  spec {
    persistent_volume_source {
      local {
        path = var.mounted_logical_volume
      }
    }
    capacity    = {
      storage   = var.pv_storage_size
    }
    storage_class_name                  = kubernetes_storage_class_v1.local-storage.metadata[0].name
    access_modes                        = ["ReadWriteOnce"]
    persistent_volume_reclaim_policy    = "Delete"
    node_affinity {
      required {
        node_selector_term {
          match_expressions {
            key         = "kubernetes.io/hostname"
            operator    = "In"
            values      = ["node1-hp", "node2-hp"]
          }
        }
      }
    }
  }
}


# Persistent Volume Claim
resource "kubernetes_persistent_volume_claim_v1" "jenkins-data" {
  metadata {
    name      = "jenkins-data"
    namespace = kubernetes_namespace_v1.ci-cd.metadata[0].name
  }

  spec {
    access_modes        = ["ReadWriteOnce"]
    storage_class_name  = kubernetes_storage_class_v1.local-storage.metadata[0].name
    resources {
      requests = {
        storage = var.pvc_storage_size
      }
    }
  }
  wait_until_bound = true
}