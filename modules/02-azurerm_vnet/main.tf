resource "azurerm_virtual_network" "child_virtual_network" {
  name                = var.child_vnet_name
  location            = var.child_resource_location
  resource_group_name = var.child_resource_group_name
  address_space       = var.child_vnet_address_space
}