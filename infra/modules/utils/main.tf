#  Ingress-NGINX Controller for the utils
resource "helm_release" "nginx_ingress_utils" {
  name             = "ingress-nginx-utils"
  repository       = "https://kubernetes.github.io/ingress-nginx"
  chart            = "ingress-nginx"
  namespace        = "inginx-system-utils"
  
  create_namespace = true

  set = [ {
    name  = "controller.service.type"
    value = "LoadBalancer"
  },
  {
    name  = "controller.ingressClass"
    value = "nginx-utils"
  },
  {
    name  = "controller.ingressClassResource.name"
    value = "nginx-utils"
  }  ]
}

#This loadbalancer is for the application
resource "helm_release" "nginx_ingress_app" {
  name             = "ingress-nginx-app"
  repository       = "https://kubernetes.github.io/ingress-nginx"
  chart            = "ingress-nginx"
  namespace        = "inginx-system-app"
  
  create_namespace = true
  atomic           = true
  replace          = true

  set = [ {
    name  = "controller.service.type"
    value = "LoadBalancer"
  }, {
    name  = "controller.ingressClass"
    value = "nginx-app"
  }, {
    name  = "controller.ingressClassResource.name"
    value = "nginx-app"
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


#Istio
resource "helm_release" "istio_base" {
  name             = "istio-base"
  repository       = "https://istio-release.storage.googleapis.com/charts"
  chart            = "base"
  namespace        = "istio-system"
  create_namespace = true
}

#istiod
resource "helm_release" "istiod" {
  name             = "istiod"
  repository       = "https://istio-release.storage.googleapis.com/charts"
  chart            = "istiod"
  namespace        = "istio-system"
  create_namespace = true

  depends_on = [
    helm_release.istio_base
  ]
}
#istio gateway
resource "helm_release" "istio_gateway" {
  name       = "istio-ingressgateway"
  repository = "https://istio-release.storage.googleapis.com/charts"
  chart      = "gateway"
  namespace  = "istio-system"

  depends_on = [
    helm_release.istiod
  ]

}

#For local testing we will be installing metallb
resource "helm_release" "metallb" {
  name       = "metallb"
  repository = "https://metallb.github.io/metallb"
  chart      = "metallb"
  namespace  = "metallb-system"

  create_namespace = true
}


#Add env in deployment
#  env:
#         - name: ARGOCD_SERVER_BASEHREF
#           value: /argocd

#update configmap
# data:

# # Rancher
# resource "helm_release" "rancher" {
#    name             = "rancher"
#    repository       = "https://releases.rancher.com/server-charts/latest"
#    chart            = "rancher"
#    namespace        = "cattle-system"
#    create_namespace = true

#    set =[ {
#      name  = "hostname"
#      value = "sample-domain.com"
#    }
#    , {
#      name  = "ingress.tls.source"
#      value = "rancher"
#      }
#    ]
#    depends_on = [ helm_release.cert_manager ]
#  }

 