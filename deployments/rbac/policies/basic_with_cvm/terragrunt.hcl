terraform {
  source = "${get_path_to_repo_root()}/modules/policy"
}

locals {
  env_vars = read_terragrunt_config(find_in_parent_folders("account.hcl"))
  environment = local.env_vars.locals.environment
}

include "root" {
  path = find_in_parent_folders()
}

inputs = {
    name = "CVM_RW_ACCESS",
    description = "cvm read and write access policy",
    document = <<EOF
{
  "statement": [
    {
        "effect": "allow",
        "action": [
            "cos:*",
            "tag:*",
            "vpc:*",
            "cam:*",
            "finance:*",
            "cvm:*"
        ],
        "resource": [
            "*"
        ]
    }
  ],
  "version": "2.0"
}
EOF
}