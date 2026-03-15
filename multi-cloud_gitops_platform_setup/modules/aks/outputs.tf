# multi-cloud_gitops_platform_setup/modules/aks/outputs.tf

output "cluster_id" {
  value = azurerm_kubernetes_cluster.aks.id
}

output "kube_config" {
  description = "Raw kubeconfig for the cluster"
  value = azurerm_kubernetes_cluster.aks.kube_config_raw
  sensitive = true
}

output "cluster_endpoint" {
  value = azurerm_kubernetes_cluster.aks.kube_config[0].host
}