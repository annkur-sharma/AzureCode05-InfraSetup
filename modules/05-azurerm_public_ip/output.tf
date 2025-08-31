output "child_output_public_IP" {
  description = "Bastion: Public IP: "
  value = azurerm_public_ip.child_public_ip.ip_address
}