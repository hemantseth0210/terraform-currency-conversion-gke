resource "kubernetes_service" "currency-conversion-service" {
  metadata {
    name      = "currency-conversion-service"
    namespace = kubernetes_namespace.n.metadata[0].name
  }
  spec {
    selector = {
      App = kubernetes_deployment.currency-conversion-deployment.spec.0.template.0.metadata[0].labels.App
    }
    port {
      port        = 80
      target_port = 8100
    }
    type = "LoadBalancer"
  }
}

output "lb_ip" {
  value = kubernetes_service.currency-conversion-service.load_balancer_ingress[0].ip
}