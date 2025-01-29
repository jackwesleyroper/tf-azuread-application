# Application
resource "azuread_application" "application" {
  display_name = var.application_display_name

  dynamic "required_resource_access" {
    for_each = var.required_resource_access

    content {
      resource_app_id = required_resource_access.value.resource_app_id

      dynamic "resource_access" {
        for_each = required_resource_access.value.resource_access

        content {
          id   = resource_access.value.id
          type = resource_access.value.type
        }
      }
    }
  }

  dynamic "web" {
    for_each = var.web

    content {
      homepage_url  = web.value.homepage_url
      logout_url    = web.value.homepage_url
      redirect_uris = web.value.homepage_url

      dynamic "implicit_grant" {
        for_each = web.value.implicit_grant

        content {
          access_token_issuance_enabled = implicit_grant.value.access_token_issuance_enabled
          id_token_issuance_enabled     = implicit_grant.value.id_token_issuance_enabled
        }
      }
    }
  }
}

# Service Principal
resource "azuread_service_principal" "service_principal" {
  depends_on                   = [azuread_application.application]
  application_id               = azuread_application.application.application_id
  app_role_assignment_required = var.app_role_assignment_required
}

# Application Password
resource "time_rotating" "application_password_time_rotating" {
  rotation_days = var.secret_rotation_days
}

resource "azuread_application_password" "application_password" {
  depends_on            = [azuread_application.application]
  application_object_id = azuread_application.application.object_id

  rotate_when_changed = {
    rotation = time_rotating.application_password_time_rotating.id
  }
}

resource "azurerm_key_vault_secret" "application_secret" {
  depends_on   = [azuread_application_password.application_password]
  name         = var.key_vault_secret_name
  value        = azuread_application_password.application_password.value
  key_vault_id = var.key_vault_id
}