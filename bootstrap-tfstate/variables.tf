variable "location" {
  type    = string
  default = "East US"
}

variable "resource_group_name" {
  type    = string
  default = "rg-acmepay-tfstate"
}

variable "storage_account_name_prefix" {
  type        = string
  description = "Prefix for TF state storage account. Must be globally unique once suffix is added."
  default     = "acmepaytfst"
}

variable "container_name" {
  type    = string
  default = "tfstate"
}

variable "tags" {
  type    = map(string)
  default = {
    project = "acmepay"
    managed_by = "terraform"
  }
}

variable "subscription_id" {
  type = string
}
