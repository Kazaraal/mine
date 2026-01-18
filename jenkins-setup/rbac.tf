# Service Account for Jenkins (with permissions to create pods)
resource "kubernetes_service_account_v1" "jenkins" {
  metadata {
    name      = "jenkins"
    namespace = kubernetes_namespace_v1.ci_cd.metadata[0].name
  }
}

# Role for Jenkins to manage pods in it's namespace
resource "kubernetes_role_v1" "jenkins-role" {
  metadata {
    name      = "jenkins-role"
    namespace = kubernetes_namespace_v1.ci_cd.metadata[0].name
  }

  rule {
    api_groups = [""]
    resources  = ["pods", "pods/exec", "pods/log", "pods/attach", "secrets", "configmaps"]
    verbs      = ["create", "delete", "get", "list", "patch", "update", "watch"]
  }

  rule {
    api_groups = [""]
    resources  = ["events"]
    verbs      = ["get", "list", "watch"]
  }
}

# Bind role to service account
resource "kubernetes_role_binding_v1" "jenkins-role-binding" {
  metadata {
    name      = "jenkins-role-binding"
    namespace = kubernetes_namespace_v1.ci_cd.metadata[0].name
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "Role"
    name      = kubernetes_role_v1.jenkins-role.metadata[0].name
  }

  subject {
    kind      = "ServiceAccount"
    name      = kubernetes_service_account_v1.jenkins.metadata[0].name
    namespace = kubernetes_namespace_v1.ci_cd.metadata[0].name
  }
}

# Service Account for Kaniko (with minimal permissions)
resource "kubernetes_service_account_v1" "kaniko" {
  metadata {
    name      = "kaniko"
    namespace = kubernetes_namespace_v1.ci_cd.metadata[0].name
  }
}