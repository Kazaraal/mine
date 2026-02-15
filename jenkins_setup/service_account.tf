# service_account.tf

resource "kubernetes_service_account_v1" "jenkins-svc-acc" {
  metadata {
    name        = "jenkins-svc-acc"
    namespace   = kubernetes_namespace_v1.ci-cd.metadata[0].name
  }
}

# role.tf

resource "kubernetes_role_v1" "jenkins-role" {
  metadata {
    name            = "jenkins-role"
    namespace       = kubernetes_namespace_v1.ci-cd.metadata[0].name
  }

  rule {
    api_groups      = [""]
    resources       = ["pods", "pods/log"]
    verbs           = ["create", "delete", "get", "list", "watch"]
  }

  rule {
    api_groups      = ["batch"]
    resources       = ["jobs"]
    verbs           = ["create", "delete", "get", "list", "watch"]
  }

  rule {
    api_groups      = [""]
    resources       = ["secrets"]
    resource_names  = ["reigstry-credentials"]
    verbs           = ["get"]
  }
}

# rolebinding.tf

resource "kubernetes_role_binding_v1" "jenkins-role-binding" {
  metadata {
    name        = "jenkins-role-binding"
    namespace   = kubernetes_namespace_v1.ci-cd.metadata[0].name
  }

  subject {
    kind        = "ServiceAccount"
    name        = kubernetes_service_account_v1.jenkins-svc-acc.metadata[0].name
    namespace   = kubernetes_namespace_v1.ci-cd.metadata[0].name
  }

  role_ref {
    api_group   = "rbac.authorization.k8s.io"
    kind        = "Role"
    name        = kubernetes_role_v1.jenkins-role.metadata[0].name
  }
}