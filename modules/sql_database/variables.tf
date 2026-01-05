variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "server_name" {
  type = string
}

variable "database_name" {
  type = string
}

variable "sku_name" {
  type    = string
  default = "Basic"
}

variable "admin_username" {
  type = string
}

variable "admin_password" {
  type      = string
  sensitive = true
}

variable "public_network_access_enabled" {
  type    = bool
  default = true
}

variable "allow_azure_services" {
  type    = bool
  default = true
}
