data "tencentcloud_images" "default" {
  image_type = ["PUBLIC_IMAGE"]
  image_name_regex = "Final"
}

data "tencentcloud_instance_types" "default" {
  filter {
    name   = "zone"
    values = ["ap-guangzhou-7"]
  }
  cpu_core_count = 2
  exclude_sold_out = true
}

resource "tencentcloud_instance" "cvm_instance" {
  instance_name     = var.cvm_name
  availability_zone = "ap-guangzhou-7"
  image_id          = data.tencentcloud_images.default.images.0.image_id
  instance_type     = data.tencentcloud_instance_types.default.instance_types.0.instance_type
  system_disk_type  = var.system_disk_type
  orderly_security_groups   = var.security_groups
  data_disks {
    data_disk_type = var.data_disk_type
    data_disk_size = var.data_disk_size
    delete_with_instance = var.is_delete_with_instance
  }
}