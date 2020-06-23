resource "kubernetes_deployment" "currency-exchange-deployment" {
  metadata {
    name = "currency-exchange-deployment"
    labels = {
      App = "currency-exchange"
    }
    namespace = kubernetes_namespace.n.metadata[0].name
  }

  spec {
    replicas                  = 2
    progress_deadline_seconds = 60
    selector {
      match_labels = {
        App = "currency-exchange"
      }
    }
    template {
      metadata {
        labels = {
          App = "currency-exchange"
        }
      }
      spec {
        container {
          image = "hemantseth0210/currency-exchange-service:0.0.5"
          name  = "currency-exchange"

          port {
            container_port = 8000
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
		  
		  env {
			 name = "MYSQL_DATASOURCE_URL"
             value_from {
               config_map_key_ref {
				  key  = "MYSQL_DATASOURCE_URL"
                  name = "mysql-config" 
                }   				
             }
		  }
		  
		  env {
		     name = "MYSQL_ROOT_PASSWORD"
             value_from {
                secret_key_ref {
				  key  = "MYSQL_ROOT_PASSWORD"
                  name = "mysql-secret" 
                }   				
              }
		  }
        }
      }
    }
  }
}