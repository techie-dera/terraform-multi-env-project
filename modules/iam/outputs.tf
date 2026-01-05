output "assignment_ids" {
  value = [for ra in azurerm_role_assignment.assignments : ra.id]
}
