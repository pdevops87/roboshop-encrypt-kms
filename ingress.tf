resource "helm_release" "nginx-ingress" {

  depends_on = [null_resource.kube-config]
  name       = "nginx-ingress"
  repository = "oci://ghcr.io/nginxinc/charts"
  chart      = "nginx-ingress"
  values     = [file("ingress_values.yaml")]

  set = [
    {
      name  = "controller.metrics.enabled"
      value = true
    },
    {
      name  = "controller.podAnnotations.prometheus\\.io/port"
      value = 10254
    },
    {
      name  = "controller.podAnnotations.prometheus\\.io/scrape"
      value = true
    },
    {
      name  = "controller.service.type"
      value = "LoadBalancer"
    }
  ]

}


# * controller.podAnnotations.prometheus\\.io/port=10254
# * controller.podAnnotations.prometheus\\.op/scrape=true

#  latest version for nginx ingress controller : oci://ghcr.io/nginxinc/charts/nginx-ingress
# chartName: nginx-ingress