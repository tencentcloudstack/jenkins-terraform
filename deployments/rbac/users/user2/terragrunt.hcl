terraform {
  source = "${get_path_to_repo_root()}/modules/user"
}

locals {
  env_vars = read_terragrunt_config(find_in_parent_folders("account.hcl"))
  environment = local.env_vars.locals.environment
}

include "root" {
  path = find_in_parent_folders()
}

inputs = {
  user_name           = "user2"
  remark              = "test"
  need_reset_password = false
  password            = "TF@test123"
  phone_num           = "13470016983"
  email               = "1055482519@qq.com"
}