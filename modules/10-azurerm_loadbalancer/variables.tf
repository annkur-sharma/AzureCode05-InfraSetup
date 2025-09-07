variable "child_resource_group_name" {
  description = "The name of the resource group where the virtual machine will be created."
  type        = string
}

variable "child_resource_location" {
  description = "The Azure region where the virtual machine will be created."
  type        = string
}

variable "child_loadbalancer_name" {
  description = "The name of the load balancer frontend."
  type        = string
}

variable "child_loadbalancer_frontend_ip_config_name" {
  description = "The name of the load balancer frontend IP config."
  type        = string
}

variable "child_public_Ip_name_loadbalancer_frontend" {
  description = "The Public IP name of the load balancer frontend."
  type        = string
}

variable "child_loadbalancer_backend_address_pool_name" {
  description = "The name of the load balancer backend pool."
  type        = string
}

