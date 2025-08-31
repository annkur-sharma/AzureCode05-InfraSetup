resource "azurerm_bastion_host" "child_bastion_host" {
  name                = var.child_bastion_name
  location            = var.child_resource_location
  resource_group_name = var.child_resource_group_name

  ip_configuration {
    name                 = var.child_bastion_ip_configuration_name
    subnet_id            = data.azurerm_subnet.get_child_subnet_id.id
    public_ip_address_id = data.azurerm_public_ip.get_child_public_ip.id
  }
}