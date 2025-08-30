output "child_output_virtual_machine_name" {
  description = "Virtual Machine Name: "
  value = azurerm_linux_virtual_machine.child_virtual_machine.name
}

output "child_output_virtual_machine_username" {
  description = "Virtual Machine Name: Username: "
  value = azurerm_linux_virtual_machine.child_virtual_machine.admin_username
}

output "child_output_virtual_machine_password" {
  description = "Virtual Machine Name: Password: ## ⚠️ For training purpose only. ## ❌ Not recommended to use a hardcoded password in production."
  value = azurerm_linux_virtual_machine.child_virtual_machine.admin_password
}