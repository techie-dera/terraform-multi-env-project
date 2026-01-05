resource "azurerm_service_plan" "this" {
  name                = var.plan_name
  location            = var.location
  resource_group_name = var.resource_group_name
  os_type             = "Linux"
  sku_name            = var.plan_sku
  tags                = var.tags
}

resource "azurerm_linux_web_app" "this" {
  name                = var.app_name
  location            = var.location
  resource_group_name = var.resource_group_name
  service_plan_id     = azurerm_service_plan.this.id
  https_only          = true
  tags                = var.tags

  site_config {
    # ✅ UPDATED: configurable (Free F1 must be false)
    always_on = var.always_on

    application_stack {
      dotnet_version = var.dotnet_version
    }
  }

  app_settings = merge(var.app_settings, {
    "APPLICATIONINSIGHTS_CONNECTION_STRING" = var.app_insights_connection_string
  })
}

