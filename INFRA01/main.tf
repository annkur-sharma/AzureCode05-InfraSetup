variable "enabled_modules" {
  type    = list(string)
  # default = ["resource_group", "vnet", "subnet", "nsg", "vm1_nic1", "vm1_nic1_nsg", "vm1"]
  default = ["resource_group", "vnet", "subnet", "bastion_subnet", "nsg", "bastion_ip", "loadbalancer_ip", "vm1_nic1", "vm1_nic1_nsg", "vm1", "vm2_nic2", "vm2_nic2_nsg", "vm2", "bastion", "loadbalancer", "loadbalancer_vm1_nic1", "loadbalancer_vm2_nic2"]

}

resource "random_string" "root_random_string" {
  length  = 6
  upper   = false
  lower   = true
  numeric = false
  special = false
}

module "module_resource_group" {
  count                     = contains(var.enabled_modules, "resource_group") ? 1 : 0
  source                    = "../modules/01-azurerm_resource_group"
  child_resource_group_name = "${var.root_resource_group_name}-${local.formatted_user_prefix}"
  child_resource_location   = var.root_resource_location
}

module "module_virtual_network" {
  count                     = contains(var.enabled_modules, "vnet") ? 1 : 0
  depends_on                = [module.module_resource_group]
  source                    = "../modules/02-azurerm_vnet"
  child_resource_group_name = "${var.root_resource_group_name}-${local.formatted_user_prefix}"
  child_resource_location   = var.root_resource_location
  child_vnet_name           = "${local.formatted_user_prefix}-${var.root_vnet_name}"
  child_vnet_address_space  = var.root_vnet_address_space
}

# Subnet for Virtual Machine
module "module_subnet" {
  count                         = contains(var.enabled_modules, "subnet") ? 1 : 0
  depends_on                    = [module.module_virtual_network]
  source                        = "../modules/03-azurerm_subnet"
  child_resource_group_name     = "${var.root_resource_group_name}-${local.formatted_user_prefix}"
  child_vnet_name               = "${local.formatted_user_prefix}-${var.root_vnet_name}"
  child_subnet_name             = "${local.formatted_user_prefix}-${var.root_subnet_name}"
  child_subnet_address_prefixes = var.root_subnet_address_prefixes
}

# Subnet for Bastion
module "module_subnet_bastion" {
  count                         = contains(var.enabled_modules, "bastion_subnet") ? 1 : 0
  depends_on                    = [module.module_virtual_network]
  source                        = "../modules/03-azurerm_subnet"
  child_resource_group_name     = "${var.root_resource_group_name}-${local.formatted_user_prefix}"
  child_vnet_name               = "${local.formatted_user_prefix}-${var.root_vnet_name}"
  child_subnet_name             = var.root_subnet_name_bastion
  child_subnet_address_prefixes = var.root_subnet_address_prefixes_bastion
}

# NSG for Virtual Machine 1 and 2
module "module_nsg" {
  count                     = contains(var.enabled_modules, "nsg") ? 1 : 0
  depends_on                = [module.module_subnet]
  source                    = "../modules/04-azurerm_nsg"
  child_resource_group_name = "${var.root_resource_group_name}-${local.formatted_user_prefix}"
  child_nsg_name            = "${local.formatted_user_prefix}-${var.root_nsg_name}"
  child_resource_location   = var.root_resource_location
}

# Public IP for Bastion
module "module_public_ip_bastion" {
  count                     = contains(var.enabled_modules, "bastion_ip") ? 1 : 0
  depends_on                = [module.module_nsg]
  source                    = "../modules/05-azurerm_public_ip"
  child_resource_group_name = "${var.root_resource_group_name}-${local.formatted_user_prefix}"
  child_public_Ip_name      = "${local.formatted_user_prefix}-${var.root_bastion_public_ip_name}"
  child_resource_location   = var.root_resource_location
}

# Public IP for Load Balancer Frontend
module "module_public_ip_loadbalancer_frontend" {
  count                     = contains(var.enabled_modules, "loadbalancer_ip") ? 1 : 0
  depends_on                = [module.module_nsg]
  source                    = "../modules/05-azurerm_public_ip"
  child_resource_group_name = "${var.root_resource_group_name}-${local.formatted_user_prefix}"
  child_public_Ip_name      = "${local.formatted_user_prefix}-${var.root_loadbalancer_public_ip_name}"
  child_resource_location   = var.root_resource_location
}

# NIC for Virtual Machine 1
module "module_nic1" {
  count                     = contains(var.enabled_modules, "vm1_nic1") ? 1 : 0
  depends_on                = [module.module_nsg]
  source                    = "../modules/06-azurerm_nic"
  child_resource_group_name = "${var.root_resource_group_name}-${local.formatted_user_prefix}"
  child_resource_location   = var.root_resource_location
  child_nic_name            = "${local.formatted_user_prefix}-${var.root_nic_name1}"
  child_ip_config_name      = "${local.formatted_user_prefix}-${var.root_ip_config_name1}"
  # child_public_Ip_name    = "${local.formatted_user_prefix}-${var.root_public_Ip_name}"
  child_subnet_name = "${local.formatted_user_prefix}-${var.root_subnet_name}"
  child_vnet_name   = "${local.formatted_user_prefix}-${var.root_vnet_name}"
}

# NSG-NIC association for Virtual Machine 1
module "module_nic_nsg_association1" {
  count                     = contains(var.enabled_modules, "vm1_nic1_nsg") ? 1 : 0
  depends_on                = [module.module_nic1]
  source                    = "../modules/07-azurerm_nic_nsg_association"
  child_resource_group_name = "${var.root_resource_group_name}-${local.formatted_user_prefix}"
  child_nic_name            = "${local.formatted_user_prefix}-${var.root_nic_name1}"
  child_nsg_name            = "${local.formatted_user_prefix}-${var.root_nsg_name}"
}

# Virtual Machine 1 with Private IP
module "module_virtual_machine1" {
  count                          = contains(var.enabled_modules, "vm1") ? 1 : 0
  depends_on                     = [module.module_nic_nsg_association1]
  source                         = "../modules/08-azurerm_virtual_machine"
  child_resource_group_name      = "${var.root_resource_group_name}-${local.formatted_user_prefix}"
  child_resource_location        = var.root_resource_location
  child_virtual_machine_name     = "${local.formatted_user_prefix}-${var.root_virtual_machine_name1}"
  child_virtual_machine_username = "${local.formatted_user_prefix}-${var.root_virtual_machine_username}"
  child_virtual_machine_password = "${local.formatted_user_prefix}-${var.root_virtual_machine_password}"
  child_nic_name                 = "${local.formatted_user_prefix}-${var.root_nic_name1}"
  child_custom_data_file         = var.root_custom_data_file_vm1
}

# NIC 2 for Virtual Machine 2
module "module_nic2" {
  count                     = contains(var.enabled_modules, "vm2_nic2") ? 1 : 0
  depends_on                = [module.module_nsg]
  source                    = "../modules/06-azurerm_nic"
  child_resource_group_name = "${var.root_resource_group_name}-${local.formatted_user_prefix}"
  child_resource_location   = var.root_resource_location
  child_nic_name            = "${local.formatted_user_prefix}-${var.root_nic_name2}"
  child_ip_config_name      = "${local.formatted_user_prefix}-${var.root_ip_config_name2}"
  # child_public_Ip_name    = "${local.formatted_user_prefix}-${var.root_public_Ip_name}"
  child_subnet_name = "${local.formatted_user_prefix}-${var.root_subnet_name}"
  child_vnet_name   = "${local.formatted_user_prefix}-${var.root_vnet_name}"
}

# NSG-NIC association for Virtual Machine 2
module "module_nic_nsg_association2" {
  count                     = contains(var.enabled_modules, "vm2_nic2_nsg") ? 1 : 0
  depends_on                = [module.module_nic2]
  source                    = "../modules/07-azurerm_nic_nsg_association"
  child_resource_group_name = "${var.root_resource_group_name}-${local.formatted_user_prefix}"
  child_nic_name            = "${local.formatted_user_prefix}-${var.root_nic_name2}"
  child_nsg_name            = "${local.formatted_user_prefix}-${var.root_nsg_name}"
}

# Virtual Machine 2 with Private IP
module "module_virtual_machine2" {
  count                          = contains(var.enabled_modules, "vm2") ? 1 : 0
  depends_on                     = [module.module_nic_nsg_association2]
  source                         = "../modules/08-azurerm_virtual_machine"
  child_resource_group_name      = "${var.root_resource_group_name}-${local.formatted_user_prefix}"
  child_resource_location        = var.root_resource_location
  child_virtual_machine_name     = "${local.formatted_user_prefix}-${var.root_virtual_machine_name2}"
  child_virtual_machine_username = "${local.formatted_user_prefix}-${var.root_virtual_machine_username}"
  child_virtual_machine_password = "${local.formatted_user_prefix}-${var.root_virtual_machine_password}"
  child_nic_name                 = "${local.formatted_user_prefix}-${var.root_nic_name2}"
  child_custom_data_file         = var.root_custom_data_file_vm2
}

# Bastion with Public IP
module "module_bastion_host" {
  count                               = contains(var.enabled_modules, "bastion") ? 1 : 0
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
  count                                        = contains(var.enabled_modules, "loadbalancer") ? 1 : 0
  depends_on                                   = [module.module_bastion_host, module.module_public_ip_loadbalancer_frontend]
  source                                       = "../modules/10-azurerm_loadbalancer"
  child_loadbalancer_frontend_ip_config_name   = "${local.formatted_user_prefix}-${var.root_loadbalancer_frontend_ip_config_name}"
  child_loadbalancer_name                      = "${local.formatted_user_prefix}-${var.root_loadbalancer_frontend_name}"
  child_public_Ip_name_loadbalancer_frontend   = "${local.formatted_user_prefix}-${var.root_loadbalancer_public_ip_name}"
  child_resource_group_name                    = "${var.root_resource_group_name}-${local.formatted_user_prefix}"
  child_resource_location                      = var.root_resource_location
  child_loadbalancer_backend_address_pool_name = "${local.formatted_user_prefix}-${var.root_loadbalancer_backend_address_pool_name}"
}

# VM NIC-LB Backend Pool association 1
module "module_vm_nic_lb_backend_address_pool_association1" {
  count                                        = contains(var.enabled_modules, "loadbalancer_vm1_nic1") ? 1 : 0
  depends_on                                   = [module.module_loadbalancer_frontend]
  source                                       = "../modules/11-azurerm_vm_nic_lb_backendpool_association"
  child_nic_name                               = "${local.formatted_user_prefix}-${var.root_nic_name1}"
  child_resource_group_name                    = "${var.root_resource_group_name}-${local.formatted_user_prefix}"
  child_loadbalancer_name                      = "${local.formatted_user_prefix}-${var.root_loadbalancer_frontend_name}"
  child_loadbalancer_backend_address_pool_name = "${local.formatted_user_prefix}-${var.root_loadbalancer_backend_address_pool_name}"
  child_backend_address_pool_ip_config_name    = "${local.formatted_user_prefix}-${var.root_ip_config_name1}"
}

# VM NIC-LB Backend Pool association 2
module "module_vm_nic_lb_backend_address_pool_association2" {
  count                                        = contains(var.enabled_modules, "loadbalancer_vm2_nic2") ? 1 : 0
  depends_on                                   = [module.module_loadbalancer_frontend]
  source                                       = "../modules/11-azurerm_vm_nic_lb_backendpool_association"
  child_nic_name                               = "${local.formatted_user_prefix}-${var.root_nic_name2}"
  child_resource_group_name                    = "${var.root_resource_group_name}-${local.formatted_user_prefix}"
  child_loadbalancer_name                      = "${local.formatted_user_prefix}-${var.root_loadbalancer_frontend_name}"
  child_loadbalancer_backend_address_pool_name = "${local.formatted_user_prefix}-${var.root_loadbalancer_backend_address_pool_name}"
  child_backend_address_pool_ip_config_name    = "${local.formatted_user_prefix}-${var.root_ip_config_name2}"
}
