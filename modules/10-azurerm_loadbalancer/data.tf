data "azurerm_public_ip" "get_child_public_ip_loadbalancer_frontend" {
  name                = var.child_public_Ip_name_loadbalancer_frontend
  resource_group_name = var.child_resource_group_name
}

data "azurerm_network_interface" "get_child_network_interface1" {
  name                = var.child_nic1_name
  resource_group_name = var.child_resource_group_name
}

data "azurerm_network_interface" "get_child_network_interface2" {
  name                = var.child_nic2_name
  resource_group_name = var.child_resource_group_name
}