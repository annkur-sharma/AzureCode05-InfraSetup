data "azurerm_subnet" "get_child_subnet_id" {
  name                 = var.child_subnet_name
  virtual_network_name = var.child_vnet_name
  resource_group_name  = var.child_resource_group_name
}

data "azurerm_public_ip" "get_child_public_ip" {
  name                = var.child_public_Ip_name
  resource_group_name = var.child_resource_group_name
}