resource "helm_release" "argocd" {
  depends_on = [null_resource.kube-config, helm_release.nginx-ingress]
  name       = "argocd"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  set = [
    {
      name  = "server.ingress.enabled"
      value = true
    },
    {
      name  = "server.ingress.ingressClassName"
      value = "nginx"
    },
    {
      name  = "global.domain"
      value = "argocd-${var.env}.pdevops87.online"
    },
    {
      name  = "configs.params.server\\.insecure"
      value = true
    },
#     {
#       name  = "server.ingress.annotations.nginx\\.ingress\\.kubernetes\\.io/backend-protocol"
#       value = "HTTP"
#     },
    {
      name  = "server.ingress.hosts[0]"
      value = "argocd-${var.env}.pdevops87.online"
    },
    {
      name  = "server.ingress.paths[0]"
      value = "/"
    },
    {
      name  = "server.ingress.ports.http"
      value = "80"
    }
  ]
}
# by default, when we install argocd through helm chart ingress is disable
# by default argocd protocol is http, but through ingress , protocol is https, so to enable protocol http ----> https
# argocd doesn't have SSL termination, ingress have SSL termination, to route application smoothly through ingress we can config insecure as true