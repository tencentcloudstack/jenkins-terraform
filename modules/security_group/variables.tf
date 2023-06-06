variable "name" {
  type        = string
  default     = "terraform-iac"
  description = "security group name."
}

variable "ingress" {
  type        = list(string)
  default     = [
    "DROP#0.0.0.0/0#ALL#ALL",
  ]
  description = "ingress."
}

variable "egress" {
  type        = list(string)
  default     = [
    "ACCEPT#0.0.0.0/0#ALL#ALL",
  ]
  description = "egress."
}