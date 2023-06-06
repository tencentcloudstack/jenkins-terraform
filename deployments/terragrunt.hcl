locals {
  env_vars = read_terragrunt_config(find_in_parent_folders("account.hcl"))
  secret_id = get_env("${local.env_vars.locals.secret_id_env}")
  secret_key = get_env("${local.env_vars.locals.secret_key_env}")
}

remote_state {
  backend = "cos"
  config = {
    region = "ap-guangzhou"
    bucket = "keep-terragrunt1-1308919341"
    prefix = "terraform-${path_relative_to_include()}/state"
    secret_id = "${local.secret_id}"
    secret_key = "${local.secret_key}"
  }
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "tencentcloud" {
    region = "ap-guangzhou"
    secret_id = "${local.secret_id}"
    secret_key = "${local.secret_key}"
}
EOF
}