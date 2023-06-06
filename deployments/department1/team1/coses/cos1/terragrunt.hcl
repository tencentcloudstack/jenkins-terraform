terraform {
  source = "${get_path_to_repo_root()}/modules/cos"
}

locals {
  env_vars = read_terragrunt_config(find_in_parent_folders("account.hcl"))
  environment = local.env_vars.locals.environment
}

include "root" {
  path = find_in_parent_folders()
}

inputs = {
  bucket_name       = "my-tf-bucket"
  bucket_acl        = "private"
  multi_az          = false
}