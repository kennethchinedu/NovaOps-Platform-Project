Ingress_controller_setup: 
	helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
	helm repo update
	helm search repo ingress-nginx -l

	helm upgrade --install \
  	ingress-nginx ingress-nginx/ingress-nginx \
  	--namespace ingress-nginx \
 	--set controller.service.type=LoadBalancer \
  	--version 4.6.0 \
  	--create-namespace


install_cert_manager:
	helm repo add jetstack https://charts.jetstack.io
	helm repo update

	helm upgrade --install cert-manager jetstack/cert-manager \
  	--namespace cert-manager \
  	--create-namespace \
  	--set installCRDs=true \
  	--version v1.11.0
	
rancher_installation:
	helm repo add rancher-latest https://releases.rancher.com/server-charts/latest
	helm repo update
	kubectl create namespace cattle-system

	helm upgrade --install rancher rancher-latest/rancher \
  	--namespace cattle-system \
  	--set hostname=rancher.my.org \
  	--set replicas=2 \
  	--set ingress.tls.source=letsEncrypt \
  	