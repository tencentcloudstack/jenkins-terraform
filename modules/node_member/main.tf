# 添加子公司账号
resource "tencentcloud_organization_org_member" "org_member" {
  name            = var.org_node_member_name
  node_id         = var.node_id
  permission_ids  = var.org_node_member_permission_ids
  policy_type     = var.org_node_member_policy_type
  remark          = var.org_node_member_remark
}