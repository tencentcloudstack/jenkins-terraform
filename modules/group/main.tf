# 新建用户组
resource "tencentcloud_cam_group" "foo" {
  name   = var.name
  remark = var.remark
}

# 用户组关联策略
resource "tencentcloud_cam_group_policy_attachment" "foo" {
#  count = var.policy_id != "" ? 1 : 0
  group_id  = tencentcloud_cam_group.foo.id
  policy_id = var.policy_id
  depends_on = [
    tencentcloud_cam_group.foo
  ]
}

# 添加用户到用户组
resource "tencentcloud_cam_group_membership" "foo" {
#  count = length(var.policy_id) > 0 ? 1 : 0
  group_id = tencentcloud_cam_group.foo.id
  user_names = var.user_names
  depends_on = [
    tencentcloud_cam_group_policy_attachment.foo
  ]
}