output "resource_group_name" {
  value = module.rg.name
}

output "location" {
  value = module.rg.location
}

output "key_vault_uri" {
  value = module.key_vault.key_vault_uri
}

output "sql_fqdn" {
  value = module.sql.sql_fqdn
}

output "app_insights_connection_string" {
  value     = module.monitoring.app_insights_connection_string
  sensitive = true
}

output "webapp_hostname" {
  value = module.app.webapp_default_hostname
}

output "webapp_url" {
  value = module.app.webapp_url
}
