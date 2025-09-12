output "root_output_resource_group_name" {
  description = "Resource Group Name: "
  value = length(module.module_resource_group) > 0 ? module.module_resource_group[0].child_output_resource_group_name : null
}

output "root_output_public_ip1" {
  description = "Bastion Public IP: "
  value = length(module.module_public_ip_bastion) > 0 ? module.module_public_ip_bastion[0].child_output_public_IP : null
}

output "root_output_public_ip2" {
  description = "Load Balancer Public IP: "
  value = length(module.module_public_ip_loadbalancer_frontend) > 0 ? module.module_public_ip_loadbalancer_frontend[0].child_output_public_IP : null
}

output "root_output_virtual_machine1" {
  description = "Virtual Machine Name: "
  value = length(module.module_virtual_machine1) > 0 ? module.module_virtual_machine1[0].child_output_virtual_machine_name : null
}

output "root_output_virtual_machine1_username" {
  description = "Virtual Machine Name: Username: "
  value = length(module.module_virtual_machine1) > 0 ? module.module_virtual_machine1[0].child_output_virtual_machine_username : null
}

output "root_output_virtual_machine1_password" {
  description = "Virtual Machine Name: Password: ## ⚠️ For training purpose only. ## ❌ Not recommended to use a hardcoded password in production."
  value = length(module.module_virtual_machine1) > 0 ? module.module_virtual_machine1[0].child_output_virtual_machine_password : null
  sensitive = true
}

output "root_output_virtual_machine2" {
  description = "Virtual Machine Name: "
  value = length(module.module_virtual_machine2) > 0 ? module.module_virtual_machine2[0].child_output_virtual_machine_name : null
}

output "root_output_virtual_machine2_username" {
  description = "Virtual Machine Name: Username: "
  value = length(module.module_virtual_machine2) > 0 ? module.module_virtual_machine2[0].child_output_virtual_machine_username : null
}

output "root_output_virtual_machine2_password" {
  description = "Virtual Machine Name: Password: ## ⚠️ For training purpose only. ## ❌ Not recommended to use a hardcoded password in production."
  value = length(module.module_virtual_machine2) > 0 ? module.module_virtual_machine2[0].child_output_virtual_machine_password : null
  sensitive = true
}