remote_state {
  backend = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite"
  }
  config = {
    bucket       = "hovaops-infra-bucket-global"
    key          = "${path_relative_to_include()}/tofu.tfstate"
    region       = "us-east-1"
    encrypt      = true
    
  }
}

generate "providers" {
  path      = "providers.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "aws" {
  region = "us-east-1"
}

provider "kubernetes" {
  config_path    = "~/.kube/config"
  config_context = var.kubeconfig_context
}

provider "helm" {
  kubernetes {
    config_path    = "~/.kube/config"
    config_context = var.kubeconfig_context
  }
}
EOF
}


#Defining Global tags 
locals {

  environment = basename(path_relative_to_include()) 

  global_tags = {
    Project     = "NovaOps"
    ManagedBy   = "DevOps_Team"
    Environment = local.environment
  }
}


