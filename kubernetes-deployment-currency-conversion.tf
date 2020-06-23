resource "kubernetes_deployment" "currency-conversion-deployment" {
  metadata {
    name = "currency-conversion-deployment"
    labels = {
      App = "currency-conversion"
    }
    namespace = kubernetes_namespace.n.metadata[0].name
  }

  spec {
    replicas                  = 2
    progress_deadline_seconds = 60
    selector {
      match_labels = {
        App = "currency-conversion"
      }
    }
    template {
      metadata {
        labels = {
          App = "currency-conversion"
        }
      }
      spec {
        container {
          image = "hemantseth0210/currency-conversion-service:0.0.5"
          name  = "currency-conversion"
        
          env {
            name  = "CURRENCY_EXCHANGE_SERVICE_URL"
            value = "http://currency-exchange-service:8000"
          }

          port {
            container_port = 8100
          }

          resources {
            limits {
              cpu    = "0.2"
              memory = "2562Mi"
            }
            requests {
              cpu    = "0.1"
              memory = "50Mi"
            }
          }
        }
      }
    }
  }
}