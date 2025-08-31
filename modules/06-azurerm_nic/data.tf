data "azurerm_subnet" "get_child_subnet_id" {
  name                 = var.child_subnet_name
  virtual_network_name = var.child_vnet_name
  resource_group_name  = var.child_resource_group_name
}