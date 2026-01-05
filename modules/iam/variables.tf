variable "assignments" {
  type = list(object({
    scope                = string
    role_definition_name = string
    principal_id         = string
  }))
}
