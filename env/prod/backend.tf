terraform {
  backend "azurerm" {
    resource_group_name  = "rg-acmepay-tfstate"
    storage_account_name = "REPLACE_WITH_BOOTSTRAP_OUTPUT"
    container_name       = "tfstate"
    key                  = "acmepay-prod.tfstate"
  }
}
