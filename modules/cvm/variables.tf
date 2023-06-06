variable "cvm_name" {
  type        = string
  default     = ""
  description = "Name of CVM Instance."
}

variable "is_delete_with_instance" {
  type        = bool
  default     = true
  description = "Delete data disk when released cvm instance."
}

variable "data_disk_type" {
  type        = string
  default     = "CLOUD_PREMIUM"
  description = "Data disk type. For more information about limits on different data disk types, see Storage Overview. Valid values: LOCAL_BASIC: local disk, LOCAL_SSD: local SSD disk, LOCAL_NVME: local NVME disk, specified in the InstanceType, LOCAL_PRO: local HDD disk, specified in the InstanceType, CLOUD_BASIC: HDD cloud disk, CLOUD_PREMIUM: Premium Cloud Storage, CLOUD_SSD: SSD, CLOUD_HSSD: Enhanced SSD, CLOUD_TSSD: Tremendous SSD, CLOUD_BSSD: Balanced SSD."
}

variable "data_disk_size" {
  type        = number
  default     = 50
  description = "Size of the data disk, and unit is GB."
}

variable "system_disk_type" {
  type        = string
  default     = "CLOUD_PREMIUM"
  description = "Data disk type. For more information about limits on different data disk types, see Storage Overview. Valid values: LOCAL_BASIC: local disk, LOCAL_SSD: local SSD disk, LOCAL_NVME: local NVME disk, specified in the InstanceType, LOCAL_PRO: local HDD disk, specified in the InstanceType, CLOUD_BASIC: HDD cloud disk, CLOUD_PREMIUM: Premium Cloud Storage, CLOUD_SSD: SSD, CLOUD_HSSD: Enhanced SSD, CLOUD_TSSD: Tremendous SSD, CLOUD_BSSD: Balanced SSD."
}

variable "security_groups" {
  type        = list(string)
  default     = []
  description = "A list of security group IDs to associate with."
}

