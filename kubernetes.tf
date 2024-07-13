resource "helm_release" "argoCD" {
  depends_on = [ module.eks ]
  name       = "argocd"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = "7.3.4"
  namespace  = "argocd"
  create_namespace = true

  values = [
    templatefile("./misc/argocd-values.tpl", { clusterName = var.cluster_name })
  ]
}

resource "kubernetes_secret" "repo-key" {
  depends_on = [ helm_release.argoCD ]
  metadata {
    name = "private-repo"
    namespace = "argocd"
    labels = {
        "argocd.argoproj.io/secret-type": "repository"
    }
  }

  data = {
    type = "git"
    url  = "git@github.com:carlograsso/kube-setup.git"
    sshPrivateKey = data.aws_secretsmanager_secret_version.repo_key.secret_string
  }
}
