data "azurerm_network_interface" "get_child_nic" {
  name                = var.child_nic_name
  resource_group_name = var.child_resource_group_name
}

data "azurerm_network_security_group" "get_child_nsg" {
  name                = var.child_nsg_name
  resource_group_name = var.child_resource_group_name
}