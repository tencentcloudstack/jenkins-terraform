variable "region" {
  description = "The topic and logset region."
  type        = string
  default     = ""
}

// logset
variable "logset_name" {
  description = "The logset name."
  type        = string
  default     = ""
}

variable "role_name" {
  description = "If assumer_uin is not empty, it indicates the service provider who creates the logset."
  type        = string
  default     = ""
}

variable "logset_tags" {
  description = "Tag description list."
  type        = map(string)
  default     = {}
}

variable "topic_name" {
  description = "Log topic name."
  type        = string
  default     = ""
}

variable "partition_count" {
  description = "Number of log topic partitions. Default value: 1. Maximum value: 10."
  type        = number
  default     = 1
}

variable "auto_split" {
  description = "Whether to enable automatic split. Default value: true."
  type = bool
  default = true
}

variable "max_split_partitions" {
  description = "Maximum number of partitions to split into for this topic if automatic split is enabled. Default value: 50."
  type = number
  default = 50
}

variable "storage_type" {
  description = "Log topic storage class. Valid values: hot: real-time storage; cold: offline storage. Default value: hot. If cold is passed in, please contact the customer service to add the log topic to the allowlist first."
  type = string
  default = ""
}

variable "period" {
  description = "Lifecycle in days. Value range: 1~366. Default value: 30."
  type = number
  default = 30
}

variable "topic_tags" {
  description = "Tag description list."
  type        = map(string)
  default     = {}
}

variable "index_status" {
  description = "Whether to take effect. Default value: true."
  type = bool
  default = true
}

variable "include_internal_fields" {
  description = "Internal field marker of full-text index. Default value: false. Valid value: false: excluding internal fields; true: including internal fields."
  type = bool
  default = false
}

variable "metadata_flag" {
  description = "Metadata flag. Default value: 0. Valid value: 0: full-text index (including the metadata field with key-value index enabled); 1: full-text index (including all metadata fields); 2: full-text index (excluding metadata fields)."
  type = number
  default = 0
}

variable "rule" {
  type = set(object({
    full_text = list(object({
      case_sensitive = bool
      tokenizer = string
      contain_z_h = bool
    }))



    key_value = list(object({
      case_sensitive=bool
      key_values=list(object({
        key = string
        value=list(object({
          type = string
          tokenizer=string
          sql_flag=bool
          contain_z_h=bool
        }))
      }))
    }))
    tag = list(object({
      case_sensitive=bool
      key_values=list(object({
        key = string
        value=list(object({
          type = string
          tokenizer=string
          sql_flag=bool
          contain_z_h=bool
        }))
      }))
    }))
  }))
  description = "Index rule."
}