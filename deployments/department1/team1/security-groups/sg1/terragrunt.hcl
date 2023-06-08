terraform {
  source = "${get_path_to_repo_root()}/modules/security_group"
}

locals {
  env_vars = read_terragrunt_config(find_in_parent_folders("account.hcl"))
  environment = local.env_vars.locals.environment
}

include "root" {
  path = find_in_parent_folders()
}

inputs = {
  name   = "team1-sg"
}