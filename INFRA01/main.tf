resource "random_string" "root_random_string" {
  length  = 8
  upper   = false
  lower   = true
  numeric = true
  special = false
}

module "module_resource_group" {
  source                    = "../modules/01-azurerm_resource_group"
  child_resource_group_name = "${var.root_resource_group_name}-${local.formatted_user_prefix}"
  child_resource_location   = var.root_resource_location
}

module "module_virtual_network" {
  depends_on                = [module.module_resource_group]
  source                    = "../modules/02-azurerm_vnet"
  child_resource_group_name = "${var.root_resource_group_name}-${local.formatted_user_prefix}"
  child_resource_location   = var.root_resource_location
  child_vnet_name           = "${local.formatted_user_prefix}-${var.root_vnet_name}"
  child_vnet_address_space  = var.root_vnet_address_space
}

# Subnet for Virtual Machine
module "module_subnet" {
  depends_on                    = [module.module_virtual_network]
  source                        = "../modules/03-azurerm_subnet"
  child_resource_group_name     = "${var.root_resource_group_name}-${local.formatted_user_prefix}"
  child_vnet_name               = "${local.formatted_user_prefix}-${var.root_vnet_name}"
  child_subnet_name             = "${local.formatted_user_prefix}-${var.root_subnet_name}"
  child_subnet_address_prefixes = var.root_subnet_address_prefixes
}

# Subnet for Bastion
module "module_subnet_bastion" {
  depends_on                    = [module.module_virtual_network]
  source                        = "../modules/03-azurerm_subnet"
  child_resource_group_name     = "${var.root_resource_group_name}-${local.formatted_user_prefix}"
  child_vnet_name               = "${local.formatted_user_prefix}-${var.root_vnet_name}"
  child_subnet_name             = var.root_subnet_name_bastion
  child_subnet_address_prefixes = var.root_subnet_address_prefixes_bastion
}

# NSG for Virtual Machine
module "module_nsg" {
  depends_on                = [module.module_subnet]
  source                    = "../modules/04-azurerm_nsg"
  child_resource_group_name = "${var.root_resource_group_name}-${local.formatted_user_prefix}"
  child_nsg_name            = "${local.formatted_user_prefix}-${var.root_nsg_name}"
  child_resource_location   = var.root_resource_location
}

# Public IP for Bastion
module "module_public_ip_bastion" {
  depends_on                = [module.module_nsg]
  source                    = "../modules/05-azurerm_public_ip"
  child_resource_group_name = "${var.root_resource_group_name}-${local.formatted_user_prefix}"
  child_public_Ip_name      = "${local.formatted_user_prefix}-${var.root_bastion_public_ip_name}"
  child_resource_location   = var.root_resource_location
}

# Public IP for Load Balancer Frontend
module "module_public_ip_loadbalancer_frontend" {
  depends_on                = [module.module_nsg]
  source                    = "../modules/05-azurerm_public_ip"
  child_resource_group_name = "${var.root_resource_group_name}-${local.formatted_user_prefix}"
  child_public_Ip_name      = "${local.formatted_user_prefix}-${var.root_loadbalancer_public_ip_name}"
  child_resource_location   = var.root_resource_location
}

# NIC for Virtual Machine
module "module_nic" {
  depends_on                = [module.module_nsg]
  source                    = "../modules/06-azurerm_nic"
  child_resource_group_name = "${var.root_resource_group_name}-${local.formatted_user_prefix}"
  child_resource_location   = var.root_resource_location
  child_nic_name            = "${local.formatted_user_prefix}-${var.root_nic_name}"
  child_ip_config_name      = "${local.formatted_user_prefix}-${var.root_ip_config_name}"
  # child_public_Ip_name      = "${local.formatted_user_prefix}-${var.root_public_Ip_name}"
  child_subnet_name = "${local.formatted_user_prefix}-${var.root_subnet_name}"
  child_vnet_name   = "${local.formatted_user_prefix}-${var.root_vnet_name}"
}

# NSG-NIC association for Virtual Machine
module "module_nic_nsg_association" {
  depends_on                = [module.module_nic]
  source                    = "../modules/07-azurerm_nic_nsg_association"
  child_resource_group_name = "${var.root_resource_group_name}-${local.formatted_user_prefix}"
  child_nic_name            = "${local.formatted_user_prefix}-${var.root_nic_name}"
  child_nsg_name            = "${local.formatted_user_prefix}-${var.root_nsg_name}"
}

# Virtual Machine with Private IP
module "module_virtual_machine" {
  depends_on                     = [module.module_nic_nsg_association]
  source                         = "../modules/08-azurerm_virtual_machine"
  child_resource_group_name      = "${var.root_resource_group_name}-${local.formatted_user_prefix}"
  child_resource_location        = var.root_resource_location
  child_virtual_machine_name     = "${local.formatted_user_prefix}-${var.root_virtual_machine_name}"
  child_virtual_machine_username = "${local.formatted_user_prefix}-${var.root_virtual_machine_username}"
  child_virtual_machine_password = "${local.formatted_user_prefix}-${var.root_virtual_machine_password}"
  child_nic_name                 = "${local.formatted_user_prefix}-${var.root_nic_name}"
}

# Bastion with Public IP
module "module_bastion_host" {
  depends_on                          = [module.module_public_ip_bastion]
  source                              = "../modules/09-azurerm-bastion"
  child_bastion_ip_configuration_name = var.root_bastion_ip_configuration_name
  child_bastion_name                  = "${local.formatted_user_prefix}-${var.root_bastion_name}"
  child_public_Ip_name                = "${local.formatted_user_prefix}-${var.root_bastion_public_ip_name}"
  child_resource_group_name           = "${var.root_resource_group_name}-${local.formatted_user_prefix}"
  child_resource_location             = var.root_resource_location
  child_subnet_name                   = var.root_subnet_name_bastion
  child_vnet_name                     = "${local.formatted_user_prefix}-${var.root_vnet_name}"
}

# Load Balancer Frontend with Public IP
module "module_loadbalancer_frontend" {
  depends_on                                   = [module.module_public_ip_bastion]
  source                                       = "../modules/10-azurerm_loadbalancer"
  child_loadbalancer_frontend_ip_config_name   = "${local.formatted_user_prefix}-${var.root_loadbalancer_frontend_ip_config_name}"
  child_loadbalancer_name                      = "${local.formatted_user_prefix}-${var.root_loadbalancer_frontend_name}"
  child_public_Ip_name_loadbalancer_frontend   = "${local.formatted_user_prefix}-${var.root_loadbalancer_public_ip_name}"
  child_resource_group_name                    = "${var.root_resource_group_name}-${local.formatted_user_prefix}"
  child_resource_location                      = var.root_resource_location
  child_loadbalancer_backend_address_pool_name = "${local.formatted_user_prefix}-${var.root_loadbalancer_backend_address_pool_name}"
  child_nic_name                               = "${local.formatted_user_prefix}-${var.root_nic_name}"
}
