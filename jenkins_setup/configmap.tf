# configmap.tf

resource "kubernetes_config_map_v1" "jenkins-jcasc" {
  metadata {
    name = "jenkins-jcasc"
    namespace = kubernetes_namespace_v1.ci-cd.metadata[0].name
  }

  data = {
    "jenkins.yaml" = <<-EOT
        jenkins:
            systemMessage: "Jenkins configured via JCasC. UI changes will not persist."

            numExecutors: 0
            mode: EXCLUSIVE

            securityRealm:
                local:
                    allowsSignup: false
                    users:
                        -   id: admin
                            password: admin

            authorizationStrategy:
                loggedInUsersCanDoAnything:
                    allowAnonymousRead: false

            clouds:
              - kubernetes:
                  name: "kubernetes"
                  serverUrl: "https://kubernetes.default.svc"
                  namespace: "ci-cd-dev"

                  jenkinsUrl: "http://jenkins-svc:8080"
                  jenkinsTunnel: "jenkins:50000"
    EOT
  }
}