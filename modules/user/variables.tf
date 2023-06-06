variable "user_name" {
  type        = string
  default     = ""
  description = "Name."
}

variable "remark" {
  type        = string
  default     = ""
  description = "Remark of the CAM user."
}

variable "need_reset_password" {
  type        = bool
  default     = false
  description = "Indicate whether the CAM user need to reset the password when first logins."
}

variable "password" {
  type        = string
  default     = ""
  description = "The password of the CAM user. Password should be at least 8 characters and no more than 32 characters, includes uppercase letters, lowercase letters, numbers and special characters. Only required when."
}

variable "phone_num" {
  type        = string
  default     = ""
  description = "Phone number of the CAM user."
}

variable "email" {
  type        = string
  default     = ""
  description = "Email of the CAM user."
}

variable "tags" {
  type = map(string)
  default = {
    created = "terraform-test"
  }
  description = "A list of tags used to associate different resources."
}

variable "policy_id" {
  type        = string
  default     = ""
  description = "ID of the policy."
}
