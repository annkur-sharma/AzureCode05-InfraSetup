resource "azurerm_network_interface_security_group_association" "child_nic_nsg_association" {
  network_interface_id      = data.azurerm_network_interface.get_child_nic.id
  network_security_group_id = data.azurerm_network_security_group.get_child_nsg.id
}