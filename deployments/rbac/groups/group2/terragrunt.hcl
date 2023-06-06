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

dependency "basic_with_cls" {
  config_path = "../../policies/basic_with_cls"
  mock_outputs = {
    policy_id = "xxxxxx"
  }
}

dependency "user2" {
  config_path = "../../users/user2"
  mock_outputs = {
    user_id = "xxxxxx"
  }
}

inputs = {
  name       = "group2"
  remark     = "group2 with user2"
  policy_id  = dependency.basic_with_cls.outputs.policy_id
  user_names = [dependency.user2.outputs.user_id]
}