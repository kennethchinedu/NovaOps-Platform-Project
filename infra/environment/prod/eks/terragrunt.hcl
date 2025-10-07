include "root" {
  path = find_in_parent_folders("root.hcl")
}

locals {
  service_name = basename(get_terragrunt_dir())
  environment  = basename(dirname(get_terragrunt_dir()))

  tags_map = {
    Environment = local.environment
    Project     = "NovaOps"
    Service     = local.service_name
    ManagedBy   = get_aws_account_alias()
  }
}

dependency "vpc" {
  config_path = "../../../environment/prod/networking"

    mock_outputs = {
    vpc_id       = "vpc-xxxxxx"
    public_sub1  = "subnet-xxxxxx"
    public_sub2  = "subnet-xxxxxx"
    pri_sub1     = "subnet-xxxxxx"
    pri_sub2     = "subnet-xxxxxx"
  }
}

terraform {
  source = "../../../modules/eks"

  extra_arguments "vars_file" {
    commands  = ["apply", "plan", "validate", "destroy"]
    arguments = ["-var-file=${get_terragrunt_dir()}/../prod.tfvars"]
  }
}

inputs = {
  tags       = local.tags_map
  vpc_id     = dependency.vpc.outputs.vpc_id
  public_subnet_ids = [
    dependency.vpc.outputs.public_sub1,
    dependency.vpc.outputs.public_sub2
  ] 
  private_subnet_ids = [
    dependency.vpc.outputs.pri_sub1,
    dependency.vpc.outputs.pri_sub2
  ]
} 
 