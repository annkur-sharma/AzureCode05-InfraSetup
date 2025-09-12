## ✅ Update this with your own subscription ID.
main_provider_subscription_id = "8b10287d-12d6-41e3-b62c-33457c006e96"

## ✅ Update this with your own Azure region.
root_resource_location = "Australia East"

## ✅ Update this with your own VNet address space.
root_vnet_address_space = ["10.250.0.0/16"]

## ✅ Update this with your own subnet address prefixes.
root_subnet_address_prefixes = ["10.250.0.0/24"]

## ✅ Update this with your own subnet address prefixes. ⚠️ Azure Bastion Subnet mask must be at least a /26.
root_subnet_address_prefixes_bastion = ["10.250.1.0/26"]

######################################################################################

## ⚠️ Do not update this value. User Prefix is automatically added to the name.
root_resource_group_name = "rg"

## ⚠️ Do not update this value. User Prefix is automatically added to the name.
root_vnet_name = "VNet"

## ⚠️ Do not update this value. User Prefix is automatically added to the name.
root_subnet_name = "Subnet"

## ⚠️ Do not update this value. User Prefix is automatically added to the name.
root_nsg_name = "NSG"

## ⚠️ Do not update this value. User Prefix is automatically added to the name.
root_bastion_public_ip_name = "BastionIP"

## ⚠️ Do not update this value. User Prefix is automatically added to the name.
root_nic_name1 = "NIC1"

## ⚠️ Do not update this value. User Prefix is automatically added to the name.
root_nic_name2 = "NIC2"

## ⚠️ Do not update this value. User Prefix is automatically added to the name.
root_ip_config_name1 = "NIC1IPConfig"

## ⚠️ Do not update this value. User Prefix is automatically added to the name.
root_ip_config_name2 = "NIC2IPConfig"

## ⚠️ Do not update this value. User Prefix is automatically added to the name.
root_virtual_machine_name1 = "VM1"

## ⚠️ Do not update this value. User Prefix is automatically added to the name.
root_virtual_machine_name2 = "VM2"

## ⚠️ For training purpose only.   ##	❌ Not recommended to use a hardcoded username in production.
## ⚠️ Do not update this value. User Prefix is automatically added.
root_virtual_machine_username = "User1"

## ⚠️ For training purpose only.   ##	❌ Not recommended to use a hardcoded password in production.
## ⚠️ Do not update this value. User Prefix is automatically added.
root_virtual_machine_password = "Pass1@"

## ❌ Do not update this value.
root_custom_data_file = "scripts/init.sh"

## ❌ Do not update this value. The Subnet used for the Bastion Host must have the name 'AzureBastionSubnet' and the subnet mask must be at least a /26.
root_subnet_name_bastion = "AzureBastionSubnet"

## ❌ Do not update this value. 
root_bastion_ip_configuration_name = "AzureBastionIPConfig"

## ❌ Do not update this value. 
root_bastion_name = "Bastion"

## ⚠️ Do not update this value. User Prefix is automatically added to the name.
root_loadbalancer_public_ip_name = "LBIP"

## ⚠️ Do not update this value. User Prefix is automatically added to the name.
root_loadbalancer_frontend_name = "LBName"

## ⚠️ Do not update this value. User Prefix is automatically added to the name.
root_loadbalancer_frontend_ip_config_name = "LBIPConfig"

## ⚠️ Do not update this value. User Prefix is automatically added to the name.
root_loadbalancer_backend_address_pool_name = "LBbackpool"