variable "env" {
  type        = string
  description = "Environment name: dev/staging/prod"
}

variable "location" {
  type        = string
  description = "Azure region for resources"
}

variable "tags" {
  type        = map(string)
  description = "Common tags"
  default     = {}
}

# ----------------------------
# Network
# ----------------------------
variable "vnet_address_space" {
  type        = list(string)
  description = "VNet CIDR ranges"
}

variable "subnets" {
  description = "Subnet definitions"
  type = map(object({
    address_prefixes = list(string)
  }))
}

# ----------------------------
# SQL
# ----------------------------
variable "sql_admin_username" {
  type        = string
  description = "SQL admin username (must NOT be 'admin')"
}

variable "sql_admin_password" {
  type        = string
  description = "SQL admin password (complex)"
  sensitive   = true
}

# ----------------------------
# App Service
# ----------------------------
variable "app_plan_sku" {
  type        = string
  description = "App Service Plan SKU (F1/B1/S1/P1v3 etc.)"
  default     = "F1"
}

variable "always_on" {
  type        = bool
  description = "Always On (must be false for Free F1)"
  default     = false
}

variable "dotnet_version" {
  type        = string
  description = ".NET version for Linux Web App"
  default     = "8.0"
}

# Optional: SQL SKU per env if you want it configurable
variable "sql_sku_name" {
  type        = string
  description = "SQL DB SKU"
  default     = "Basic"
}

# Optional: Key Vault access settings per env
variable "kv_public_network_access_enabled" {
  type        = bool
  description = "Allow public network access to Key Vault"
  default     = true
}

variable "kv_purge_protection_enabled" {
  type        = bool
  description = "Key Vault purge protection (recommended true in prod)"
  default     = false
}

