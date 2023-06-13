terraform {
  source = "${get_path_to_repo_root()}/modules/cvm"
}

locals {
  env_vars = read_terragrunt_config(find_in_parent_folders("account.hcl"))
  environment = local.env_vars.locals.environment
}

include "root" {
  path = find_in_parent_folders()
}

dependency "team3_cvm_sg" {
  config_path = "../../security-groups/sg2"
  mock_outputs = {
    security_group_id = "xxxxxx"
  }
}

inputs = {
  cvm_name                = "team3-cvm"
  security_groups         = [dependency.team3_cvm_sg.outputs.security_group_id]
  is_delete_with_instance = true
}