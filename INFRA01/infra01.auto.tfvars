## ✅ Update this with your own subscription ID.
main_provider_subscription_id = "00000000-0000-0000-00000000"

## ✅ Update this with your own Azure region.
root_resource_location        = "East US"

## ✅ Update this with your own VNet address space.
root_vnet_address_space       = ["46.87.0.0/24"]

## ✅ Update this with your own subnet address prefixes.
root_subnet_address_prefixes  = ["46.87.0.0/28"]

######################################################################################

## ⚠️ Do not update this value. User Prefix is automatically added to the name.
root_resource_group_name      = "rg"

## ⚠️ Do not update this value. User Prefix is automatically added to the name.
root_vnet_name                = "VNet" 

## ⚠️ Do not update this value. User Prefix is automatically added to the name.
root_subnet_name              = "Subnet" 

## ⚠️ Do not update this value. User Prefix is automatically added to the name.
root_nsg_name                 = "NSG"

## ⚠️ Do not update this value. User Prefix is automatically added to the name.
root_public_Ip_name           = "PublicIP"

## ⚠️ Do not update this value. User Prefix is automatically added to the name.
root_nic_name                 = "NIC"

## ⚠️ Do not update this value. User Prefix is automatically added to the name.
root_ip_config_name           = "IPConfig"

## ⚠️ Do not update this value. User Prefix is automatically added to the name.
root_virtual_machine_name     = "VM"

## ⚠️ For training purpose only.   ##	❌ Not recommended to use a hardcoded username in production.
## ⚠️ Do not update this value. User Prefix is automatically added.
root_virtual_machine_username = "User1"

## ⚠️ For training purpose only.   ##	❌ Not recommended to use a hardcoded password in production.
## ⚠️ Do not update this value. User Prefix is automatically added.
root_virtual_machine_password = "Pass1@" 
