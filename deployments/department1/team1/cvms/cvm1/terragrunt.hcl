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

dependency "sg_cvm1" {
  config_path = "../../security-groups/sg1"
  mock_outputs = {
    security_group_id = "xxxxxx"
  }
}

inputs = {
  cvm_name                = "team1-cvm"
  security_groups         = [dependency.sg_cvm1.outputs.security_group_id]
  is_delete_with_instance = true
}