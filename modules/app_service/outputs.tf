output "webapp_default_hostname" {
  description = "Default hostname of the Linux Web App"
  value       = azurerm_linux_web_app.this.default_hostname
}

output "webapp_url" {
  description = "HTTPS URL of the Linux Web App"
  value       = "https://${azurerm_linux_web_app.this.default_hostname}"
}
