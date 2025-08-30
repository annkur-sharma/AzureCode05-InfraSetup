resource "azurerm_network_security_group" "child_nsg" {
  name                = var.child_nsg_name
  location            = var.child_resource_location
  resource_group_name = var.child_resource_group_name

  security_rule {
    name                       = "AllowSSH"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_ranges     = ["22"]
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

