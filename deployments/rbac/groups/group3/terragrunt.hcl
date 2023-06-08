terraform {
  source = "${get_path_to_repo_root()}/modules/group"
}

locals {
  env_vars = read_terragrunt_config(find_in_parent_folders("account.hcl"))
  environment = local.env_vars.locals.environment
}

include "root" {
  path = find_in_parent_folders()
}

dependency "basic_with_none" {
  config_path = "../../policies/basic_with_none"
  mock_outputs = {
    policy_id = "xxxxxx"
  }
}

dependency "user3" {
  config_path = "../../users/user3"
  mock_outputs = {
    user_id = "xxxxxx"
  }
}

inputs = {
  name       = "group3"
  remark     = "group3 with user3"
  policy_id  = dependency.basic_with_none.outputs.policy_id
  user_names = [dependency.user3.outputs.user_id]
}