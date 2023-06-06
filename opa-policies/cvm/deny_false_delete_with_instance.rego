package terraform_tencentcloud

import data.lib as l

check01 := "TF_TENCENTCLOUD_01"

deny_false_delete_with_instance[msg] {
	input.planned_values.root_module.resources

	type := "tencentcloud_instance"
	cvms := [cvm |
		some i
		input.planned_values.root_module.resources[i].type == type
		cvm := input.planned_values.root_module.resources[i]
	]
	binding_cvm := cvms[_]
	binding_cvm.values.data_disks
	binding_data_disk := binding_cvm.values.data_disks[_]
	not binding_data_disk.delete_with_instance == true
	msg = sprintf("%s: cvm data disks not set delete_with_instance equal true %s.", [check01, binding_cvm.name])
}