# --------------------------------------
# Load Balancer
# --------------------------------------
resource "azurerm_lb" "child_loadbalancer_frontend" {
  name                = var.child_loadbalancer_name
  location            = var.child_resource_location
  resource_group_name = var.child_resource_group_name
  sku                 = "Standard"

  frontend_ip_configuration {
    name                 = var.child_loadbalancer_frontend_ip_config_name
    public_ip_address_id = data.azurerm_public_ip.get_child_public_ip_loadbalancer_frontend.id
  }
}

# --------------------------------------
# Backend Address Pool
# --------------------------------------
resource "azurerm_lb_backend_address_pool" "child_loadbalancer_backend_pool" {
  name                = var.child_loadbalancer_backend_address_pool_name
  loadbalancer_id     = azurerm_lb.child_loadbalancer_frontend.id
}

# --------------------------------------
# Health Probe
# --------------------------------------
resource "azurerm_lb_probe" "app_probe" {
  name                = "http-probe"
  loadbalancer_id     = azurerm_lb.child_loadbalancer_frontend.id
  protocol            = "Tcp"
  port                = 80
  interval_in_seconds = 5
  number_of_probes    = 2
}

# --------------------------------------
# LB Rule
# --------------------------------------
resource "azurerm_lb_rule" "app_lbrule" {
  name                           = "http-rule"
  loadbalancer_id                = azurerm_lb.child_loadbalancer_frontend.id
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = var.child_loadbalancer_frontend_ip_config_name
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.child_loadbalancer_backend_pool.id]
  probe_id                       = azurerm_lb_probe.app_probe.id
}

# --------------------------------------
# NIC 1 Association with LB Backend Pool
# --------------------------------------
resource "azurerm_network_interface_backend_address_pool_association" "nic1_lb_assoc" {
  network_interface_id    = data.azurerm_network_interface.get_child_network_interface1.id
  ip_configuration_name   = var.child_ip_config_name1
  backend_address_pool_id = azurerm_lb_backend_address_pool.child_loadbalancer_backend_pool.id
}

# --------------------------------------
# NIC 2 Association with LB Backend Pool
# --------------------------------------
resource "azurerm_network_interface_backend_address_pool_association" "nic2_lb_assoc" {
  network_interface_id    = data.azurerm_network_interface.get_child_network_interface2.id
  ip_configuration_name   = var.child_ip_config_name2
  backend_address_pool_id = azurerm_lb_backend_address_pool.child_loadbalancer_backend_pool.id
}