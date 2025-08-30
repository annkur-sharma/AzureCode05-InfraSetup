variable "child_subnet_name" {
  type        = string
  description = "The name of the subnet"
}

variable "child_subnet_address_prefixes" {
  type        = list(string)
  description = "The address prefixes for the subnet"
}

variable "child_resource_group_name" {
  type = string
  description = "The name of the resource group where the virtual network will be created"
}

variable "child_vnet_name" {
  type = string
  description = "The Azure region where the virtual network will be created"
}