variable "child_nic_name" {
  description = "The name of the child NIC to associate with the NSG."
  type        = string
}

variable "child_resource_group_name" {
  description = "The name of the resource group where the NIC is located."
  type        = string
}

variable "child_nsg_name" {
  description = "The name of the Network Security Group to associate with the NIC."
  type        = string
}