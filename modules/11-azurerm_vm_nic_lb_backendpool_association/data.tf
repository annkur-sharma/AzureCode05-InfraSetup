data "azurerm_network_interface" "get_child_network_interface" {
  name                = var.child_nic_name
  resource_group_name = var.child_resource_group_name
}

data "azurerm_lb" "get_child_lb" {
  name                = var.child_loadbalancer_name
  resource_group_name = var.child_resource_group_name
}

data "azurerm_lb_backend_address_pool" "get_child_lb_backend_address_pool" {
  name            = var.child_loadbalancer_backend_address_pool_name
  loadbalancer_id = data.azurerm_lb.get_child_lb.id
}