resource "kubernetes_config_map_v1" "jenkins-config" {
  metadata {
    name      = "jenkins-config"
    namespace = kubernetes_namespace_v1.ci_cd.metadata[0].name
  }

  data = {
    "jenkins.yaml" = <<-EOT
    jenkins:
      securityRealm:
        local:
          allowsSignup: false
          users:
          - id: "admin"
            password: ${var.jenkins_admin_password}
      authorizationStrategy:
        globalMatrix:
          permissions:
          - "Overall/Administer:admin"
          - "Overall/Read:authenticated"
      clouds:
      - kubernetes:
          name: "kubernetes"
          serverUrl: "https://kubernetes.default"
          namespace: "${kubernetes_namespace_v1.ci_cd.metadata[0].name}"
          credentialsId: "jenkins-service-account"
          jenkinsUrl: "http://jenkins.${kubernetes_namespace_v1.ci_cd.metadata[0].name}.svc.cluster.local:8080"
          podRetention: never
          templates:
          - name: "kaniko"
            label: "kaniko"
            serviceAccount: "kaniko"
            nodeUsageMode: NORMAL
            containers:
            - name: "kaniko"
              image: "ken0k/kaniko-project/executor_debug:1.0"
              command: "cat"
              ttyEnabled: true
              resourceRequestCpu: "500m"
              resourceRequestMemory: "1Gi"
              resourceLimitCpu: "1000m"
              resourceLimitMemory: "2Gi"
              volumeMounts:
              - name: "docker-config"
                mountPath: "/kaniko/.docker"
            volumes:
            - name: "docker-config"
              secret:
                secretName: "dockerhub-secret"
                items:
                - key: ".dockerconfigjson"
                  path: "config.json"
    EOT
  }
}