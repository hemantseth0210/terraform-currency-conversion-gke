resource "kubernetes_persistent_volume_claim" "mysql-persistent-volume-claim" {
  metadata {
    name = "mysql-persistent-volume-claim"
	namespace = kubernetes_namespace.n.metadata[0].name
  }
  spec {
    access_modes = ["ReadWriteOnce"]
    resources {
      requests = {
        storage = "1Gi"
      }
    }
	storage_class_name = standard
    volume_name = kubernetes_persistent_volume.mysql-persistent-volume.metadata.0.name
  }
}