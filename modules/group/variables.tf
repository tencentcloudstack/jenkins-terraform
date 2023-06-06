variable "name" {
  type        = string
  default     = ""
  description = "Name of CAM group."
}

variable "remark" {
  type        = string
  default     = ""
  description = "Description of the CAM group."
}

variable "policy_id" {
  type        = string
  default     = ""
  description = "ID of the policy."
}

variable "user_names" {
  type        = list(string)
  default     = []
  description = "User name set as ID of the CAM group members."
}