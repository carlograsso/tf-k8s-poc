apiVersion: argoproj.io/v1alpha1
kind: AppProject
metadata:
  name: infra-${clusterName}
  namespace: argocd
spec:
  destinations:
    - namespace: "*"
      server: https://kubernetes.default.svc
  clusterResourceWhitelist:
    - group: "*"
      kind: "*"
  sourceRepos:
    - git@github.com:carlograsso/kube-setup.git