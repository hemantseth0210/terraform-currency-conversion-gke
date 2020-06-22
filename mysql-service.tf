resource "kubernetes_service" "mysql-service" {
  metadata {
    name      = "mysql-service"
    namespace = kubernetes_namespace.n.metadata[0].name
  }
  spec {
    selector = {
      App = kubernetes_deployment.mysql-deployment.spec.0.template.0.metadata[0].labels.App
    }
    port {
      port        = 80
	  target_port = 3306
    }
    #cluster_ip = "None"
	type = "LoadBalancer"
  }
}