output "child_output_resource_group_name" {
  description = "Resource Group Name: "
  value = azurerm_resource_group.child_resource_group.name
}