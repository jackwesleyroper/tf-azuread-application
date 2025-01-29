output "application_id" {
  value       = azuread_application.application.application_id
  description = "The ID of the Application."
}

output "application_object_id" {
  value       = azuread_application.application.object_id
  description = "The Object ID of the Application."
}

output "service_principal_id" {
  value       = azuread_service_principal.service_principal.id
  description = "The ID of the Service Principal"
}

output "application_password_id" {
  value       = azuread_application_password.application_password.key_id
  description = "The ID of the Application Password"
}

output "key_vault_key_id" {
  value       = azurerm_key_vault_secret.application_secret.id
  description = "The Key Vault Secret ID."
}

output "key_vault_secret_resource_id" {
  value       = azurerm_key_vault_secret.application_secret.resource_id
  description = "The (Versioned) ID for this Key Vault Secret."
}

output "key_vault_secret_versionless_id" {
  value       = azurerm_key_vault_secret.application_secret.versionless_id
  description = "The Base ID of the Key Vault Secret. This property allows other resources to auto-rotate their value when the Key Vault Secret is updated."
}
