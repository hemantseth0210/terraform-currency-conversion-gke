resource "kubernetes_config_map" "mysql-config" {
  metadata {
    name = "mysql-config"
	namespace = kubernetes_namespace.n.metadata[0].name
  }

  data = {
    MYSQL_DATABASE = "currency_db"
    MYSQL_DATASOURCE_URL = "jdbc:mysql://mysql-service/currency_db"
}