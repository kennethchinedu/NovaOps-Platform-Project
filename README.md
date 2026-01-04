# Enterprise DevOps Infrastructure Project

This repository defines the **infrastructure, deployment, and observability stack** for our enterprise platform.  

---

## 🧭 Overview

This project provides a complete, modular platform for deploying and managing cloud-native workloads across **staging** and **production** environments.

### Key Capabilities
- 🚀 **Infrastructure as Code (IaC)** — Terraform modules orchestrated with Terragrunt  
- ☸️ **Kubernetes Platform Management** — Helm + Istio for service mesh and traffic routing  
- 🔁 **GitOps Deployment** — Continuous delivery with ArgoCD  
- 🌍 **Edge Networking** — Cloudflare for DNS, CDN, SSL, and WAF  
- 📊 **Observability Stack** — Prometheus (metrics), Loki (logs), Grafana (dashboards) Kiali (Mesh monitoring)  
- 🔐 **Security Modules** — Network policies, IAM, and secret management  

---

## 🧩 Repository Structure

```bash
.
├── README.md
├── argocd
│   ├── apps
│   │   └── us-east-1
│   │       └── app.yaml
│   ├── global
│   │   ├── applicationset.yaml
│   │   ├── clusters.yaml
│   │   ├── sa_and_roles.yaml
│   │   └── secrets.yaml
│   └── projects
│       └── us-east-1.yaml
├── infra
│   ├── environment
│   │   ├── prod
│   │   │   ├── eks
│   │   │   │   └── terragrunt.hcl
│   │   │   ├── firewalls
│   │   │   ├── networking
│   │   │   │   └── terragrunt.hcl
│   │   │   ├── prod.tfvars
│   │   │   └── utils
│   │   │       └── terragrunt.hcl
│   │   ├── root.hcl
│   │   └── staging
│   ├── modules
│   │   ├── eks
│   │   │   ├── main.tf
│   │   │   ├── output.tf
│   │   │   └── variables.tf
│   │   ├── global
│   │   ├── networking
│   │   │   ├── main.tf
│   │   │   ├── output.tf
│   │   │   └── variables.tf
│   │   ├── security
│   │   └── utils
│   │       ├── README.md
│   │       ├── main.tf
│   │       └── varables.tf
│   └── terragrunt
├── istio
│   ├── destinaton_rule.yaml
│   ├── gateway.yaml
│   ├── mlts.yaml
│   └── virtual_service.yaml
├── k8s
│   ├── base
│   │   ├── deployment.yaml
│   │   ├── service.yaml
│   │   └── volume.yaml
│   └── boutique-app
│       ├── Chart.yaml
│       ├── charts
│       ├── sa.yaml
│       ├── templates
│       │   ├── NOTES.txt
│       │   ├── _helpers.tpl
│       │   ├── deployment.yaml
│       │   ├── hpa.yaml
│       │   ├── ingress.yaml
│       │   ├── service.yaml
│       │   ├── serviceaccount.yaml
│       │   └── tests
│       │       └── test-connection.yaml
│       └── values.yaml
├── k8s1.png
├── metallb
│   └── metal-config.yaml
└── vagrantfile

```

---


1. Provision infrastructure:

```bash

cd infra/environment/prod/each-module
#create a prod.tfvars using the example file
terragrunt apply

# Deploy ArgoCD applications

kubectl apply -f argocd/projects/
kubectl apply -f argocd/global/

# Deploy frontend Helm chart
helm install app k8s/boutique-app -f k8s/boutique-app/values.yaml

# Verify Istio routes
kubectl get virtualservice,destinationrule -n default

```