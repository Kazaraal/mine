output "jenkins_url" {
  description = "Jenkins Web UI URL"
  value       = "http://${kubernetes_service_v1.jenkins.metadata[0].name}.${kubernetes_namespace_v1.ci_cd.metadata[0].name}.svc.cluster.local:8080"
}

output "jenkins_admin_password" {
  description = "Jenkins admin password"
  value       = var.jenkins_admin_password
  sensitive   = true
}

output "namespace" {
  description = "Kubernetes namespace created"
  value       = kubernetes_namespace_v1.ci_cd.metadata[0].name
}