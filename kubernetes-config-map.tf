resource "kubernetes_config_map" "mysql-config" {
  metadata {
    name = "mysql-config"
	namespace = kubernetes_namespace.n.metadata[0].name
  }

  data = {
    MYSQL_DATABASE = "currency_db"
    MYSQL_DATASOURCE_URL = "jdbc:mysql://mysql-service/currency_db"
    mysql-initdb.sql = <<EOT
	  use currency_db; \n
      CREATE TABLE exchange_value (id bigint(20) NOT NULL, conversion_multiple decimal(19,2) DEFAULT NULL, currency_from varchar(255) DEFAULT NULL, currency_to varchar(255) DEFAULT NULL, PRIMARY KEY (id)); \n
      insert into exchange_value(id, conversion_multiple, currency_from, currency_to) values(10001,65,'USD','INR'); \n
      insert into exchange_value(id, conversion_multiple, currency_from, currency_to) values(10002,75,'EUR','INR'); \n
      insert into exchange_value(id, conversion_multiple, currency_from, currency_to) values(10003,45,'AUD','INR');	\n
	EOT
  }
}