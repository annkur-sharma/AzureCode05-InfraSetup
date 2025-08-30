resource "azurerm_linux_virtual_machine" "child_virtual_machine" {
  name                = var.child_virtual_machine_name
  resource_group_name = var.child_resource_group_name
  location            = var.child_resource_location
  size                = "Standard_F2"
  admin_username      = var.child_virtual_machine_username ## ⚠️ For training purpose only.   ##	❌ Not recommended to use a hardcoded username in production.
  # Use a Azure Key Vault in production environments.
  admin_password = var.child_virtual_machine_password ## ⚠️ For training purpose only.   ##	❌ Not recommended to use a hardcoded password in production.
  # Use a Azure Key Vault in production environments.
  disable_password_authentication = false
  network_interface_ids = [
    data.azurerm_network_interface.get_child_nic.id
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}



