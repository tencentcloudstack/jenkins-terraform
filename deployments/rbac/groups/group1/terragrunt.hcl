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

dependency "basic_with_cvm" {
  config_path = "../../policies/basic_with_cvm"
  mock_outputs = {
    policy_id = "xxxxxx"
  }
}

dependency "user1" {
  config_path = "../../users/user1"
  mock_outputs = {
    user_id = "xxxxxx"
  }
}

inputs = {
  name       = "group1"
  remark     = "group1 with user1"
  policy_id  = dependency.basic_with_cvm.outputs.policy_id
  user_names = [dependency.user1.outputs.user_id]
}