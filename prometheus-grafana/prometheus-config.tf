# prometheus-config.tf

resource "kubernetes_config_map_v1" "prometheus-config" {
    metadata {
      name = "prometheus-config"
      namespace = kubernetes_namespace_v1.monitoring.metadata[0].name
    }

    data = {
      "prometheus.yaml" = <<-EOF
global:
    scrape_interval: 1m

scrape_configs:
    -   job_name: 'nodes'           # single job for all node exporters
        static_configs:
            -   targets:
                -   '$${controller1}:9100'
                -   '$${controller2}:9100'
                -   '$${controller3}:9100'
                -   '$${node1}:9100'
                -   '$${node2}:9100'
      EOF
    }
}