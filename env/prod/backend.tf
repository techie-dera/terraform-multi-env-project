terraform {
  backend "azurerm" {
    resource_group_name  = "rg-acmepay-tfstate"
    storage_account_name = "acmepaytfst4125k3jwin"
    container_name       = "tfstate"
    key                  = "acmepay-prod.tfstate"
  }
}
