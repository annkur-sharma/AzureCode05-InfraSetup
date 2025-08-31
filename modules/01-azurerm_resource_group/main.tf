resource "azurerm_resource_group" "child_resource_group" {
  name     = var.child_resource_group_name
  location = var.child_resource_location
}