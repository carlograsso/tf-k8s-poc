module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version

  cluster_endpoint_public_access  = true

  cluster_addons = {
    coredns                = {}
    kube-proxy             = {}
    vpc-cni                = {}
  }

  vpc_id                   = var.vpc_id
  subnet_ids               = var.subnet_ids

  eks_managed_node_groups = {
    demo = {
      ami_type       = "AL2023_x86_64_STANDARD"
      instance_types = ["t3.medium"]

      min_size     = 0
      max_size     = 1
      desired_size = 1
    }
  }

  enable_cluster_creator_admin_permissions = true
}

resource "aws_secretsmanager_secret" "argocd" {
  depends_on = [ helm_release.argoCD ]
  name = "carlo/argocd-${var.cluster_name}"
}

resource "aws_secretsmanager_secret_version" "argocdDefaultPassword" {
  secret_id     = aws_secretsmanager_secret.argocd.id
  secret_string = data.kubernetes_secret.argo_default_password.data["password"]
}