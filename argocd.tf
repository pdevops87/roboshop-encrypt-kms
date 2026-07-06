resource "helm_release" "argocd" {
  depends_on = [null_resource.kube-config, helm_release.nginx-ingress]
  name       = "argocd"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"

  # Dynamic array of maps for parameter overrides
  set {
    name  = "server.ingress.enabled"
    value = "true"
  }
  set {
    name  = "server.ingress.ingressClassName"
    value = "nginx"
  }
  set {
    name  = "global.domain"
    value = "argocd-${var.env}.pdevops87.online"
  }

  # 1. FIXED: Tells ArgoCD to process internal traffic strictly as plain HTTP
  set {
    name  = "configs.params.server\\.insecure"
    value = "true"
  }

  # 2. FIXED: Uses the correct F5 NGINX Annotation for SSL redirect behaviors
  set {
    name  = "server.ingress.annotations.nginx\\.org/redirect-to-https"
    value = "true"
  }

  set {
    name  = "server.ingress.hosts[0]"
    value = "argocd-${var.env}.pdevops87.online"
  }
  set {
    name  = "server.ingress.paths[0]"
    value = "/"
  }
}
