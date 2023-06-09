terraform {
  source = "${get_path_to_repo_root()}/modules/cls"
}

locals {
  env_vars = read_terragrunt_config(find_in_parent_folders("account.hcl"))
  environment = local.env_vars.locals.environment
}

include "root" {
  path = find_in_parent_folders()
}

inputs = {
  logset_name          = "team3-logset"
  logset_tags          = {
    created = "terraform"
  }
  topic_name           = "team3-topic"
  auto_split           = false
  max_split_partitions = 40
  storage_type         = "cold"
  period               = 15
  topic_tags           = {
    created = "terraform"
  }
  rule                 = [{
    full_text = [{
      case_sensitive = false
      tokenizer      = "test"
      contain_z_h    = false
    }]
    key_value = []
    tag       = []
  }]
}