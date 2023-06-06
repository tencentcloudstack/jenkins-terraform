# 新建子账号
resource "tencentcloud_cam_user" "foo" {
  name                = var.user_name
  remark              = var.remark
  console_login       = true
  use_api             = true
  need_reset_password = var.need_reset_password
  password            = var.password
  phone_num           = var.phone_num
  email               = var.email
  country_code        = "86"
  force_delete        = true
  tags = var.tags
}

resource "tencentcloud_cam_user_policy_attachment" "foo" {
  count = var.policy_id != "" ? 1 : 0
  user_name   = tencentcloud_cam_user.foo.name
  policy_id = var.policy_id
}