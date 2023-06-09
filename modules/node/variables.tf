# Basic
variable "org_node_name" {
  type        = string
  default     = ""
  description = "Node name."
}

variable "parent_node_id" {
  type        = number
  default     = 0
  description = "Parent node ID."
}

variable "org_node_remark" {
  type        = string
  default     = "Group subsidiary"
  description = "Node notes."
}