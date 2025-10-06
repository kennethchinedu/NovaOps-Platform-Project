# Enterprise DevOps Infrastructure Project

This repository defines the **infrastructure, deployment, and observability stack** for our enterprise platform.  
It leverages **Terraform + Terragrunt**, **Kubernetes + Istio**, **ArgoCD (GitOps)**, and **Prometheus / Grafana / Loki** for full lifecycle automation and visibility.

---

## 🧭 Overview

This project provides a complete, modular platform for deploying and managing cloud-native workloads across **staging** and **production** environments.

### Key Capabilities
- 🚀 **Infrastructure as Code (IaC)** — Terraform modules orchestrated with Terragrunt  
- ☸️ **Kubernetes Platform Management** — Helm + Istio for service mesh and traffic routing  
- 🔁 **GitOps Deployment** — Continuous delivery with ArgoCD  
- 🌍 **Edge Networking** — Cloudflare for DNS, CDN, SSL, and WAF  
- 📊 **Observability Stack** — Prometheus (metrics), Loki (logs), Grafana (dashboards)  
- 🔐 **Security Modules** — Network policies, IAM, and secret management  

---

## 📁 Repository Structure
.
├── argocd
│ ├── apps/ # ArgoCD App manifests (per-app or per-environment)
│ │ ├── app-frontend-prod.yaml
│ │ └── app-backend-staging.yaml
│ └── projects/
│ ├── project-prod.yaml
│ └── project-staging.yaml
│
├── cloudflare # infra-as-code for edge (Terraform)
│
├── infra
│ ├── environments
│ │ ├── prod
│ │ │ ├── terragrunt.hcl
│ │ │ └── region/
│ │ └── staging
│ │ └── terragrunt.hcl
│ ├── modules
│ │ ├── eks
│ │ ├── global
│ │ ├── security
│ │ └── vpc
│ └── terragrunt # shared terragrunt helpers / remote state config
│
├── istio
│ ├── global/
│ │ ├── destination_rule.yaml
│ │ └── virtual_service.yaml
│ ├── gateways/
│ │ └── gateway.yaml
│ └── apps/
│ ├── frontend/
│ │ └── virtual_service.yaml
│ └── backend/
│ └── destination_rule.yaml
│
├── k8s
│ ├── base # Kustomize base resources
│ │ ├── deployment.yaml
│ │ ├── service.yaml
│ │ ├── ingress.yaml
│ │ ├── service_account.yaml
│ │ └── volume.yaml
│ ├── overlays # Env-specific overlays (kustomize)
│ │ ├── prod
│ │ └── staging
│ └── helm # Helm charts for all microservices
│
├── observability
│ ├── prometheus
│ ├── grafana
│ └── loki
│
├── security
│ ├── opa-policies
│ └── terraform-policies
│
├── ci-cd # GitHub Actions / GitLab Pipelines / scripts
│
├── docs
│ ├── architecture.md
│ └── runbooks/
│
├── makefile
└── README.md