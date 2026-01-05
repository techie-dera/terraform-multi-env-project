locals {
  name_prefix = "acmepay-${var.env}"
}

# Random suffixes to avoid global-name collisions (Key Vault + Web App)
resource "random_string" "kv" {
  length  = 6
  upper   = false
  numeric = true
  special = false
}

resource "random_string" "app" {
  length  = 4
  upper   = false
  numeric = true
  special = false
}

module "rg" {
  source   = "../../modules/resource_group"
  name     = "rg-${local.name_prefix}"
  location = var.location
  tags     = var.tags
}

module "monitoring" {
  source              = "../../modules/monitoring"
  resource_group_name = module.rg.name
  location            = module.rg.location
  workspace_name      = "law-${local.name_prefix}"
  appinsights_name    = "appi-${local.name_prefix}"
  retention_in_days   = 30
  tags                = var.tags
}

module "network" {
  source              = "../../modules/network"
  resource_group_name = module.rg.name
  location            = module.rg.location

  vnet_name          = "vnet-${local.name_prefix}"
  vnet_address_space = var.vnet_address_space
  subnets            = var.subnets
  tags               = var.tags
}

module "key_vault" {
  source              = "../../modules/key_vault"
  resource_group_name = module.rg.name
  location            = module.rg.location

  # KV must be globally unique, 3-24 chars, lowercase alphanumeric
  key_vault_name = substr(
    lower("kv${replace(local.name_prefix, "-", "")}${random_string.kv.result}"),
    0,
    24
  )

  tags = var.tags

  purge_protection_enabled      = false
  public_network_access_enabled = true
}

module "sql" {
  source              = "../../modules/sql_database"
  resource_group_name = module.rg.name
  location            = module.rg.location
  tags                = var.tags

  server_name   = "sql-${local.name_prefix}"
  database_name = "sqldb-${local.name_prefix}"
  sku_name      = "Basic"

  admin_username = var.sql_admin_username
  admin_password = var.sql_admin_password

  public_network_access_enabled = true
  allow_azure_services          = true
}

module "app" {
  source              = "../../modules/app_service"
  resource_group_name = module.rg.name
  location            = module.rg.location
  tags                = var.tags

  plan_name = "asp-${local.name_prefix}"
  plan_sku  = "F1"

  # Web App name must be globally unique
  app_name = substr(
    lower("app-${local.name_prefix}-${random_string.app.result}"),
    0,
    60
  )

  dotnet_version = "8.0"

  # Free tier does NOT support Always On
  always_on = false

  app_insights_connection_string = module.monitoring.app_insights_connection_string

  app_settings = {
    "ASPNETCORE_ENVIRONMENT" = var.env
    "SQL_FQDN"               = module.sql.sql_fqdn
    "KEYVAULT_URI"           = module.key_vault.key_vault_uri
  }
}


