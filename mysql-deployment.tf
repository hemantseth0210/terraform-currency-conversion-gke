resource "kubernetes_deployment" "mysql-deployment" {
  metadata {
    name = "mysql-deployment"
    labels = {
      App = "mysql"
    }
    namespace = kubernetes_namespace.n.metadata[0].name
  }

  spec {
    replicas                  = 1
    progress_deadline_seconds = 60
    selector {
      match_labels = {
        App = "mysql"
      }
    }
	strategy {
	  type = "Recreate"
	}
    template {
      metadata {
        labels = {
          App = "mysql"
        }
      }
      spec {
        container {
          image = "mysql:8.0"
          name  = "mysql"
		  resources {
            limits {
              cpu    = "1"
              memory = "1Gi"
            }
            requests {
              cpu    = "500m"
              memory = "500Mi"
            }
          }
		  
          port {
            container_port = 3306
          }
		  
		  env {
			 name = "MYSQL_DATASOURCE_URL"
             value_from = {
               config_map_key_ref = {
				  key  = "MYSQL_DATASOURCE_URL"
                  name = "mysql-config" 
                }   				
             }
		  }
		  
		  env {
		     name = "MYSQL_ROOT_PASSWORD"
             value_from = {
                secret_key_ref = {
				  key  = "MYSQL_ROOT_PASSWORD"
                  name = "mysql-secret" 
                }   				
              }
		  }
		  
		  env {
		     name = "MYSQL_USER"
             value_from = {
                secret_key_ref = {
				  key  = "MYSQL_USER"
                  name = "mysql-secret" 
                }   				
              }
		  }
		  
		  env {
		     name = "MYSQL_PASSWORD"
             value_from = {
                secret_key_ref = {
				  key  = "MYSQL_PASSWORD"
                  name = "mysql-secret" 
                }   				
              }
		  }
		  

		  volume_mount = [
		    {
		      name = "mysql-persistent-storage"
			  mount_path = "/var/lib/mysql"
		    },
			{
			  name = "mysql-initdb"
			  mount_path = "/docker-entrypoint-initdb.d"
			}
		  ]
        }
		volume = [
		  {
		    name = "mysql-persistent-storage"
            persistent_volume_claim = {
		      claim_name = "${kubernetes_persistent_volume_claim.mysql-persistent-volume-claim.metadata.0.name}"
			}
          },
          {
		    name = "mysql-initdb"
            config_map = {
		      name = "mysql-config"
			}
          } 		  
		]
      } 
    } 
  }
}