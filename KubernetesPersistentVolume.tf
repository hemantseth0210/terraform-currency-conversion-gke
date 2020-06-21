resource "kubernetes_persistent_volume" "mysql-persistent-volume" {
  metadata {
    name = "mysql-persistent-volume"
	namespace = kubernetes_namespace.n.metadata[0].name
  }
  spec {
    capacity = {
      storage = "1Gi"
    }
    access_modes = ["ReadWriteOnce"]
    persistent_volume_source {
      host_path {
	    path = "/mnt/data"
	  }
    }
	storage_class_name = standard
  }
}