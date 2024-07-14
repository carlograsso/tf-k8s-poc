apiVersion: argoproj.io/v1alpha1
kind: ApplicationSet
metadata:
  name: infra-${clusterName}
  namespace: argocd
spec:
  generators:
    - git:
        repoURL: git@github.com:carlograsso/kube-setup.git
        revision: main
        directories:
          - path: overlays/${clusterName}/infra/bases/*
  syncPolicy:
    preserveResourcesOnDeletion: true
  template:
    metadata:
      name: ${clusterName}-{{ path.basename }}
    spec:
      syncPolicy:
        automated:
          prune: true
          selfHeal: true
      project: infra-${clusterName}
      source:
        repoURL: git@github.com:carlograsso/kube-setup.git
        targetRevision: main
        path: "{{ path }}"
      destination:
        server: https://kubernetes.default.svc