# storage.tf

# Storage Class
resource "kubernetes_storage_class_v1" "local-storage-monitoring" {
  metadata {
    name = "local-storage-monitoring"
  }

  storage_provisioner   = "kubernetes.io/no-provisioner"
  reclaim_policy        = "Delete"
  volume_binding_mode   = "Immediate"
}

# Prometheus PV
resource "kubernetes_persistent_volume_v1" "prometheus-pv" {
  metadata {
    name    = "prometheus-pv"
    labels  = {
      type  = "local"
      app   = "prometheus"
    }
  }

  spec {
    persistent_volume_source {
      local {
        path = var.prometheus_data_volume
      }
    }
    capacity    = {
      storage   = "10Gi"
    }
    access_modes                        = ["ReadWriteOnce"]
    persistent_volume_reclaim_policy    = "Delete"
    storage_class_name                  = kubernetes_storage_class_v1.local-storage-monitoring.metadata[0].name
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


# Grafana PV
resource "kubernetes_persistent_volume_v1" "grafana-pv" {
  metadata {
    name    = "grafana-pv"
    labels  = {
      type  = "local"
      app   = "grafana"
    }
  }

  spec {
    persistent_volume_source {
      local {
        path = var.grafana_data_volume
      }
    }
    capacity    = {
      storage   = "10Gi"
    }
    access_modes                        = ["ReadWriteOnce"]
    persistent_volume_reclaim_policy    = "Delete"
    storage_class_name                  = kubernetes_storage_class_v1.local-storage-monitoring.metadata[0].name
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


# Prometheus Persistent Volume Claim
resource "kubernetes_persistent_volume_claim_v1" "prometheus-pvc" {
    metadata {
      name = "prometheus-pvc"
      namespace = kubernetes_namespace_v1.monitoring.metadata[0].name
    }

    spec {
      access_modes = ["ReadWriteOnce"]
      storage_class_name = kubernetes_storage_class_v1.local-storage-monitoring.metadata[0].name
      resources {
        requests = {
          storage = "10Gi"
        }
      }
    }
    wait_until_bound = true
}


# Grafana Persistent Volume Claim
resource "kubernetes_persistent_volume_claim_v1" "grafana-pvc" {
    metadata {
      name = "grafana-pvc"
      namespace = kubernetes_namespace_v1.monitoring.metadata[0].name
    }

    spec {
      access_modes = ["ReadWriteOnce"]
      storage_class_name = kubernetes_storage_class_v1.local-storage-monitoring.metadata[0].name
      resources {
        requests = {
          storage = "10Gi"
        }
      }
    }
    wait_until_bound = true
}