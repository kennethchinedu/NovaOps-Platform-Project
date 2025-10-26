#  Ingress-NGINX Controller
resource "helm_release" "nginx_ingress" {
  name             = "ingress-nginx"
  repository       = "https://kubernetes.github.io/ingress-nginx"
  chart            = "ingress-nginx"
  namespace        = "inginx-system"
  
  create_namespace = true

  set  {
    name  = "controller.service.type"
    value = "LoadBalancer"
  }
  
}

#  Cert-Manager
resource "helm_release" "cert_manager" {
  name             = "cert-manager"
  repository       = "https://charts.jetstack.io"
  chart            = "cert-manager"
  namespace        = "cert-manager"
  create_namespace = true

  set  {
    name  = "installCRDs"
    value = "true"
  }
  
}

# Rancher
resource "helm_release" "rancher" {
  name             = "rancher"
  repository       = "https://releases.rancher.com/server-charts/latest"
  chart            = "rancher"
  namespace        = "cattle-system"
  create_namespace = true

  set  {
    name  = "hostname"
    value = ""
    
  }

  #Disabling default service and setting up ours
  set  {
    name  = "service.enabled"
    value = "false"
    
  }

  set {
    name = "ingress.enabled"
    value = "false"
  }

  set {
    name  = "service.ports.http"
    value = "8080"
  }

  set {
    name  = "service.ports.https"
    value = "8443"
  }

}