variable "child_bastion_name" {
  description = "The name of the bastion."
  type        = string
}

variable "child_resource_group_name" {
  description = "The name of the resource group where the virtual machine will be created."
  type        = string
}

variable "child_resource_location" {
  description = "The Azure region where the virtual machine will be created."
  type        = string
}

variable "child_subnet_name" {
  description = "The name of the subnet."
  type        = string
}

variable "child_public_Ip_name" {
  description = "The name of the Bastion public IP address."
  type        = string
}

variable "child_vnet_name" {
  description = "The name of the virtual network."
  type        = string
}

variable "child_bastion_ip_configuration_name" {
  description = "The name of the Bastion IP Configuration Name."
  type        = string
}