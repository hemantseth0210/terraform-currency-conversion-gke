resource "kubernetes_secret" "mysql-secret" {
  metadata {
    name = "mysql-secret"
	namespace = kubernetes_namespace.n.metadata[0].name
  }

  data = {
    MYSQL_ROOT_PASSWORD: cGFzc3dvcmQ= #password
    MYSQL_USER: cm9vdA== #root
    MYSQL_PASSWORD: dGVzdDEyMw== #test123
  }

  type = "Opaque"
}