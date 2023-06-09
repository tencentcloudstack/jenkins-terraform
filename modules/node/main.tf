# 创建组织
resource "tencentcloud_organization_org_node" "org_node" {
  name           = var.org_node_name
  parent_node_id = var.parent_node_id
  remark         = var.org_node_remark
}