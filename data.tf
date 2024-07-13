data "aws_secretsmanager_secret_version" "repo_key" {
  secret_id = "carlo/repo-key"
}


data "kubernetes_secret" "argo_default_password" {
  depends_on = [ helm_release.argoCD ]
  metadata {
    name = "argocd-initial-admin-secret"
    namespace = "argocd"
  }
}