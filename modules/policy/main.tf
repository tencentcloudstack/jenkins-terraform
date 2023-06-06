# 创建策略
resource "tencentcloud_cam_policy" "foo" {
  name        = var.name
  document    = var.document
  description = var.description
}