include "root" {
  path = find_in_parent_folders("root.hcl")
}

#Defining local tags 
locals {
  service_name = basename(get_terragrunt_dir())
  environment = basename(dirname(get_terragrunt_dir()))
  

  tags_map = {
    Environment = local.environment      # or dynamic from folder
    Project     = "VQualis"
    Service     = local.service_name
    ManagedBy   = get_aws_account_alias()
   
    
  }

}

terraform {
  source = "../../../modules//networking"

  #Getting environment 
  extra_arguments "vars_file" {
    commands = ["apply", "plan", "validate", "destroy"]
    arguments = [
      "-var-file=${get_terragrunt_dir()}/../prod.tfvars"
    ]
  }
}

inputs = {
  tags = local.tags_map
}


