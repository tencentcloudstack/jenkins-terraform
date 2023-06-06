variable "name" {
  type        = string
  default     = ""
  description = "Name of CAM policy."
}

variable "document" {
  type        = string
  default     = ""
  description = "Document of the CAM policy. The syntax refers to CAM POLICY. There are some notes when using this para in terraform: 1. The elements in JSON claimed supporting two types as string and array only support type array; 2. Terraform does not support the root syntax, when it appears, it must be replaced with the uin it stands for."
}

variable "description" {
  type        = string
  default     = ""
  description = "Description of the CAM policy."
}