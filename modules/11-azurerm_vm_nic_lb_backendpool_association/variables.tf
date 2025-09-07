variable "child_nic_name" {
  description = "The name of the VM NIC."
  type        = string
}

variable "child_resource_group_name" {
  description = "The name of the resource group where the virtual machine will be created."
  type        = string
}

variable "child_loadbalancer_name" {
  description = "The name of the load balancer frontend."
  type        = string
}

variable "child_loadbalancer_backend_address_pool_name" {
  description = "The name of the load balancer backend pool."
  type        = string
}

variable "child_backend_address_pool_ip_config_name" {
  description = "The IP Config of the NIC."
  type        = string
}