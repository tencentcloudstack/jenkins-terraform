package terraform_tencentcloud

import data.lib as l

check01 := "TF_TENCENTCLOUD_02"

deny_ingress_accept_quad_zero_cidr[msg] {
	input.planned_values.root_module.resources

	type := "tencentcloud_security_group_lite_rule"
	sg_rules := [rule |
		some i
		input.planned_values.root_module.resources[i].type == type
		rule := input.planned_values.root_module.resources[i]
	]
	binding_sg_rule := sg_rules[_]
	binding_ingress_rule := binding_sg_rule.values.ingress[_]
	startswith(binding_ingress_rule, "ACCEPT#0.0.0.0/0#")
	msg = sprintf("%s: security group rule(%s) ingress can not accept 0.0.0.0/0 CIDR.", [check02, binding_sg_rule.name])
}