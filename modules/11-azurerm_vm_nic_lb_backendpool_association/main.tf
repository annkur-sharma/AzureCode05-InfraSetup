# --------------------------------------
# NIC Association with LB Backend Pool
# --------------------------------------
resource "azurerm_network_interface_backend_address_pool_association" "nic_lb_assoc" {
  network_interface_id    = data.azurerm_network_interface.get_child_network_interface.id
  ip_configuration_name   = var.child_backend_address_pool_ip_config_name
  backend_address_pool_id = data.azurerm_lb_backend_address_pool.get_child_lb_backend_address_pool.id
}

