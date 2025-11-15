# Ingress_controller_setup: 
# 	helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
# 	helm repo update
# 	helm search repo ingress-nginx -l

# 	helm upgrade --install \
#   	ingress-nginx ingress-nginx/ingress-nginx \
#   	--namespace ingress-nginx \
#  	--set controller.service.type=LoadBalancer \
#   	--version 4.6.0 \
#   	--create-namespace


# install_cert_manager:
# 	helm repo add jetstack https://charts.jetstack.io
# 	helm repo update

# 	helm upgrade --install cert-manager jetstack/cert-manager \
#   	--namespace cert-manager \
#   	--create-namespace \
#   	--set installCRDs=true \
#   	--version v1.11.0
	
# rancher_installation:
# 	helm repo add rancher-latest https://releases.rancher.com/server-charts/latest
# 	helm repo update
# 	kubectl create namespace cattle-system

# 	helm upgrade --install rancher rancher-latest/rancher \
#   	--namespace cattle-system \
#   	--set hostname=rancher.my.org \
#   	--set replicas=2 \
#   	--set ingress.tls.source=letsEncrypt \
  	


# Setting up local cluster and nodes using kubeadm

disable_swapoff:
	sudo swapoff -a
    sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab


network_config:
	cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
	net.bridge.bridge-nf-call-iptables  = 1
	net.bridge.bridge-nf-call-ip6tables = 1
	net.ipv4.ip_forward                 = 1
	EOF

	sudo sysctl --system

containerd:
	sudo apt update -y
	sudo apt install -y containerd
	sudo mkdir -p /etc/containerd
	sudo containerd config default | sudo tee /etc/containerd/config.toml
	sudo systemctl restart containerd
	sudo systemctl enable containerd

install_kubernates:
	sudo apt-get update
	sudo apt-get install -y apt-transport-https ca-certificates curl

	curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.30/deb/Release.key | \
  	sudo gpg --dearmor -o /usr/share/keyrings/kubernetes-archive-keyring.gpg

	echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] \
	https://pkgs.k8s.io/core:/stable:/v1.30/deb/ /" | \
  	sudo tee /etc/apt/sources.list.d/kubernetes.list

	sudo apt-get update
	sudo apt-get install -y kubelet kubeadm kubectl
	sudo apt-mark hold kubelet kubeadm kubectl

initiaize_kubeadm:
	sudo kubeadm init --apiserver-advertise-address=<ip> --pod-network-cidr=10.244.0.0/16

join:
	Then you can join any number of worker nodes by running the following on each as root:

kubeadm join 10.0.2.15:6443 --token hx7do9.r2tw4rq2ozmo0yta \
	--discovery-token-ca-cert-hash sha256:f4d6b1475c6ea7f8b2828f883a394ed37fef503912171a1afbd1667c9c496242 