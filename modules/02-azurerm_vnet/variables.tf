variable "child_vnet_name" {
  type        = string
  description = "The name of the virtual network"
}

variable "child_vnet_address_space" {
  type        = list(string)
  description = "The address space for the virtual network"
}

variable "child_resource_group_name" {
  type = string
  description = "The name of the resource group where the virtual network will be created"
}

variable "child_resource_location" {
  type = string
  description = "The Azure region where the virtual network will be created"
}