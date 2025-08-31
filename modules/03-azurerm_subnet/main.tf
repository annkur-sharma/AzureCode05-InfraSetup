resource "azurerm_subnet" "child_subnet" {
  name                 = var.child_subnet_name
  resource_group_name  = var.child_resource_group_name
  virtual_network_name = var.child_vnet_name
  address_prefixes     = var.child_subnet_address_prefixes
}