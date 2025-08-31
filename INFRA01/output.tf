output "root_output_resource_group_name" {
  description = "Resource Group Name: "
  value = module.module_resource_group.child_output_resource_group_name
}

output "root_output_public_ip" {
  description = "Public IP: "
  value = module.module_public_ip.child_output_public_IP
}

output "root_output_virtual_machine" {
  description = "Virtual Machine Name: "
  value = module.module_virtual_machine.child_output_virtual_machine_name
}

output "root_output_virtual_machine_username" {
  description = "Virtual Machine Name: Username: "
  value = module.module_virtual_machine.child_output_virtual_machine_username
}

output "root_output_virtual_machine_password" {
  description = "Virtual Machine Name: Password: ## ⚠️ For training purpose only. ## ❌ Not recommended to use a hardcoded password in production."
  value = module.module_virtual_machine.child_output_virtual_machine_password
  sensitive = true
}