resource "azurerm_public_ip" "child_public_ip" {
  name                = var.child_public_Ip_name
  resource_group_name = var.child_resource_group_name
  location            = var.child_resource_location
  allocation_method   = "Static"
}


