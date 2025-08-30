resource "azurerm_network_interface" "child_network_interface" {
  name                = var.child_nic_name
  location            = var.child_resource_location
  resource_group_name = var.child_resource_group_name

  ip_configuration {
    name                          = var.child_ip_config_name
    subnet_id                     = data.azurerm_subnet.get_child_subnet_id.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = data.azurerm_public_ip.get_child_public_ip.id
  }
}





