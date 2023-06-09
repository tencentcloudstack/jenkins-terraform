# jenkins实践
这是一个使用Terraform和Terragrunt进行多账号腾讯云资源管理的Demo项目，供业务结合Jenkins和JFrog完成CI/CD落地。

## 场景描述
1、一个集团（Organization）下，有两个子公司DepartmentA和DepartmentB

2、子公司Department1下有两个团队Team1和Team2， 子公司Department2下有一个团队Team3

3、Team1有创建CVM的权限，Team2有创建CLS的权限，Team3只有基础权限

## 目录结构
```
├─opa-policies           # OPA检查规则
|      ├─security-group
|      |       └deny_ingress_accept_quad_zero_cidr.rego
|      ├─cvm
|      |  └deny_false_delete_with_instance.rego
├─modules                # terraform modules        
|    ├─user                 # cam user module
|    |  ├─main.tf
|    |  ├─outputs.tf
|    |  ├─variables.tf
|    |  └version.tf
|    ├─security_group       # security group module
|    |       ├─main.tf
|    |       ├─outputs.tf
|    |       ├─variables.tf
|    |       └version.tf
|    ├─policy               # cam policy module
|    |   ├─main.tf
|    |   ├─outputs.tf
|    |   ├─variables.tf
|    |   └version.tf
|    ├─node_member          # organization node member
|    |      ├─main.tf
|    |      ├─outputs.tf
|    |      ├─variables.tf
|    |      └version.tf
|    ├─node                 # organization node module
|    |  ├─main.tf
|    |  ├─outputs.tf
|    |  ├─variables.tf
|    |  └version.tf
|    ├─group                # cam group module
|    |   ├─main.tf
|    |   ├─outputs.tf
|    |   ├─variables.tf
|    |   └version.tf
|    ├─cvm                  # cvm module
|    |  ├─main.tf
|    |  ├─outputs.tf
|    |  ├─variables.tf
|    |  └version.tf 
|    ├─cos                  # cos module
|    |  ├─main.tf
|    |  ├─outputs.tf
|    |  ├─variables.tf
|    |  └version.tf
|    ├─cls                  # cls module
|    |  ├─main.tf
|    |  ├─outputs.tf
|    |  ├─variables.tf
|    |  └version.tf
├─deployments               
|      ├─terragrunt.hcl
|      ├─rbac              # 权限控制
|      |  ├─account.hcl
|      |  ├─users
|      |  |   ├─user3
|      |  |   |   └terragrunt.hcl
|      |  |   ├─user2
|      |  |   |   └terragrunt.hcl
|      |  |   ├─user1
|      |  |   |   └terragrunt.hcl
|      |  ├─policies
|      |  |    ├─basic_with_none
|      |  |    |        └terragrunt.hcl
|      |  |    ├─basic_with_cvm
|      |  |    |       └terragrunt.hcl
|      |  |    ├─basic_with_cls
|      |  |    |       └terragrunt.hcl
|      |  ├─groups
|      |  |   ├─group3
|      |  |   |   └terragrunt.hcl
|      |  |   ├─group2
|      |  |   |   └terragrunt.hcl
|      |  |   ├─group1
|      |  |   |   └terragrunt.hcl
|      ├─department2     
|      |      ├─team3       # team3 can create sg
|      |      |   ├─account.hcl
|      |      |   ├─security-groups
|      |      |   |        ├─sg1
|      |      |   |        |  └terragrunt.hcl
|      ├─department1
|      |      ├─team2       # team2 can create cls
|      |      |   ├─account.hcl
|      |      |   ├─clses
|      |      |   |   ├─cls1
|      |      |   |   |  └terragrunt.hcl
|      |      ├─team1       # team1 can create cvm
|      |      |   ├─account.hcl
|      |      |   ├─security-groups
|      |      |   |        ├─sg1
|      |      |   |        |  └terragrunt.hcl
|      |      |   ├─cvms
|      |      |   |  ├─cvm1
|      |      |   |  |  └terragrunt.hcl
```

## 变更规范
1、Rbac变更
* ① 分支规范 ： rbac/add-cvm
* ② 发布Tag规范 ： rbac#online_update

2、云资源变更
*   ① 分支规范 ： team1/add-cvm
*   ② 发布Tag规范 ： team1#online_update
