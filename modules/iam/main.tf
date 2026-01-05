resource "azurerm_role_assignment" "assignments" {
  for_each             = { for a in var.assignments : "${a.scope}-${a.role_definition_name}-${a.principal_id}" => a }
  scope                = each.value.scope
  role_definition_name = each.value.role_definition_name
  principal_id         = each.value.principal_id
}
