resource "kubernetes_service" "currency-exchange-service" {
  metadata {
    name      = "currency-exchange-service"
    namespace = kubernetes_namespace.n.metadata[0].name
  }
  spec {
    selector = {
      App = kubernetes_deployment.currency-exchange-deployment.spec.0.template.0.metadata[0].labels.App
    }
    port {
      port        = 8100
      target_port = 8000
    }
    type = "ClusterIP"
  }
}

output "currency-exchange-service-ip" {
  value = kubernetes_service.currency-exchange-service.spec[0].cluster_ip
}