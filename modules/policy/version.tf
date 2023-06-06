terraform {
  required_version = ">= 0.12"

  required_providers {
    tencentcloud = {
      source  = "tencentcloudstack/tencentcloud"
      version = ">=1.81.2"
    }
  }
}