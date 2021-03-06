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
    #progress_deadline_seconds = 60
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
          image = "mysql:5.6"
          name  = "mysql"
		  
		  
          port {
            container_port = 3306
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
		  
		  env {
			 name = "MYSQL_DATABASE"
             value = "currency_db"
		  }
		  
		  env {
		     name = "MYSQL_USER"
             value_from {
                secret_key_ref {
				  key  = "MYSQL_USER"
                  name = "mysql-secret" 
                }   				
              }
		  }
		  
		  env {
		     name = "MYSQL_PASSWORD"
             value_from {
                secret_key_ref {
				  key  = "MYSQL_PASSWORD"
                  name = "mysql-secret" 
                }   				
              }
		  }
		  
		  #command = ["mysqld --default-authentication-plugin=mysql_native_password --skip-mysqlx"]
		  
		  volume_mount {
		    name = "mysql-persistent-storage"
			mount_path = "/var/lib/mysql"
		  }
		  
		  volume_mount {
		    name = "mysql-initdb"
			mount_path = "/docker-entrypoint-initdb.d"
		  }
		
        }
		
		volume {
		  name = "mysql-persistent-storage"
          persistent_volume_claim {
		    claim_name = kubernetes_persistent_volume_claim.mysql-persistent-volume-claim.metadata.0.name
		  }
		}
		
		volume {
		  name = "mysql-initdb"
          config_map {
		    name = "mysql-config"
		  }
		}
      } 
    } 
  }
}