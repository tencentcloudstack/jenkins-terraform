# Basic
variable "node_id" {
  type        = number
  default     = 0
  description = "Node id."
}

variable "org_node_member_name" {
  type        = string
  default     = ""
  description = "Specify available zone of VPC subnet and TKE nodes."
}

variable "org_node_member_permission_ids" {
  type        = list(number)
  default     = [
    1,
    2,
  ]
  description = "Financial management permission IDs.Valid values:- 1: View bill.- 2: Check balance.- 3: Fund transfer.- 4: Combine bill.- 5: Issue an invoice.- 6: Inherit discount.- 7: Pay on behalf.value 1,2 is required."
}

variable "org_node_member_policy_type" {
  type        = string
  default     = "Financial"
  description = "Organization policy type.- Financial: Financial management policy."
}

variable "org_node_member_remark" {
  type        = string
  default     = ""
  description = "member notes."
}