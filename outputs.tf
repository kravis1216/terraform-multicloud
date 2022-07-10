output "domain_names" {
  value = data.azuread_domains.aad_domains.domains.*.domain_name
}

/*
output "azuread_users" {
  value = local.users
}
*/

output "azuread_upn_and_password" {
  value     = [for value in azuread_user.users : "UPN: ${value.user_principal_name} INITIAL PASSWORD: ${value.password}"]
  sensitive = true
}
