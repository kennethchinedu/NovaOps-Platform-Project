#  Ingress-NGINX Controller
resource "helm_release" "nginx_ingress" {
  name             = "ingress-nginx"
  repository       = "https://kubernetes.github.io/ingress-nginx"
  chart            = "ingress-nginx"
  namespace        = "inginx-system"
  
  create_namespace = true

  set = [ {
    name  = "controller.service.type"
    value = "LoadBalancer"
  } ]
  
}

#  Cert-Manager
resource "helm_release" "cert_manager" {
  name             = "cert-manager"
  repository       = "https://charts.jetstack.io"
  chart            = "cert-manager"
  namespace        = "cert-manager"
  create_namespace = true

  set = [ {
    name  = "installCRDs"
    value = "true"
  }
  ]
  
}

#Argocd
resource "helm_release" "argocd" {
  name             = "argocd"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  namespace        = "argocd"
  create_namespace = true
}


# # Rancher
# resource "helm_release" "rancher" {
#   name             = "rancher"
#   repository       = "https://releases.rancher.com/server-charts/latest"
#   chart            = "rancher"
#   namespace        = "cattle-system"
#   create_namespace = true

#   set =[ {
#     name  = "hostname"
#     value = "acb8d0f2e478547e0a0b5e14c4b4f72c-1734230420.us-east-1.elb.amazonaws.com"
#   }
#   , {
#     name  = "ingress.tls.source"
#     value = "rancher"
#     }
#   ]


#   depends_on = [ helm_release.cert_manager ]
# }