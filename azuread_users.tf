resource "azuread_user" "users" {
  for_each = { for user in local.users : user.coe_id => user }

  given_name   = each.value.first_name
  surname      = each.value.last_name
  display_name = "${each.value.first_name} ${each.value.last_name}"

  employee_id = each.value.coe_id
  user_principal_name = format("%s@%s",
    each.value.coe_id,
    local.domain_name
  )

  password              = random_password.secret.result
  force_password_change = true
}
