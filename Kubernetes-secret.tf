resource "kubernetes_secret" "mysql-secret" {
  metadata {
    name = "mysql-secret"
	namespace = kubernetes_namespace.n.metadata[0].name
  }

  data = {
    MYSQL_ROOT_PASSWORD: cGFzc3dvcmQ=
    MYSQL_USER: cm9vdA==
    MYSQL_PASSWORD: dGVzdDEyMw==
  }

  type = "Opaque"
}