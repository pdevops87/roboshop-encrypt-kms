# roboshop-encrypt-kms


[ User types: http://pdevops87.online ]
│
▼
[ AWS Load Balancer (Passes plain HTTP through Port 80) ]
│
▼
[ NGINX Ingress Controller ] ◄─── Reads: "ssl-redirect: true"
│
└─► (Sends a redirect command back to user's browser)
│
[ User's browser automatically upgrades to: https://... ]
│
▼
[ AWS Load Balancer ]        ◄─── Reads your ACM Certificate & Decrypts traffic safely!
│
▼
[ Argo CD Pod (HTTP) ]       ◄─── Receives clean traffic




kubectl rollout restart deployment ingress-nginx-controller -n ingress-nginx


resource "helm_release" "argocd" 
depends_on = [null_resource.kube-config, helm_release.nginx-ingress]
name       = "argocd"
repository = "https://argoproj.github.io/argo-helm"
chart      = "argo-cd"

# Dynamic array of maps for parameter overrides
set {
name  = "server.ingress.enabled"
value = "true"
},
{
name  = "server.ingress.ingressClassName"
value = "nginx"
},
{
name  = "global.domain"
value = "argocd-$var.env}.pdevops87.online"
},

# 1. FIXED: Tells ArgoCD to process internal traffic strictly as plain HTTP
{
name  = "configs.params.server\\.insecure"
value = "true"
},

# 2. FIXED: Uses the correct F5 NGINX Annotation for SSL redirect behaviors
{
name  = "server.ingress.annotations.nginx\\.org/redirect-to-https"
value = "true"
},

{
name  = "server.ingress.hosts[0]"
value = "argocd-$var.env}.pdevops87.online"
},
{
name  = "server.ingress.paths[0]"
value = "/"
}
}

