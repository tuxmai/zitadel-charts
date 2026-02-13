# The Project container
resource "zitadel_project" "tuxmai_rag" {
  name                     = "tuxmai-rag"
  org_id                   = var.org_id
  project_role_assertion   = true
  project_role_check       = false
  has_project_check        = false
  private_labeling_setting = "PRIVATE_LABELING_SETTING_ALLOW_LOGIN_USER_RESOURCE_OWNER_POLICY"
}

# -----------------------------------------------------------------------------
# ROLES (As per ADR 001)
# -----------------------------------------------------------------------------

resource "zitadel_project_role" "super_admin" {
  org_id       = var.org_id
  project_id   = zitadel_project.tuxmai_rag.id
  role_key     = "system:super_admin"
  display_name = "System Super Admin"
  group        = "Global System Roles"
}

resource "zitadel_project_role" "tenant_create" {
  org_id       = var.org_id
  project_id   = zitadel_project.tuxmai_rag.id
  role_key     = "tenant:create"
  display_name = "Tenant Creator"
  group        = "Global System Roles"
}

# -----------------------------------------------------------------------------
# APPLICATIONS
# -----------------------------------------------------------------------------

# App 1: The Client (Frontend/CLI)
# Used by users to log in via PKCE
resource "zitadel_application_oidc" "tuxmai_eda_agent" {
  org_id       = zitadel_project.tuxmai_rag.org_id
  project_id   = zitadel_project.tuxmai_rag.id
  name         = "tuxmai-eda-agent"
  
  # App Type: Native (Best for CLI / Device Flow)
  app_type     = "OIDC_APP_TYPE_NATIVE"
  auth_method_type = "OIDC_AUTH_METHOD_TYPE_NONE" # Public Client (No Secret)
  
  grant_types = [
    "OIDC_GRANT_TYPE_AUTHORIZATION_CODE",
    "OIDC_GRANT_TYPE_DEVICE_CODE",
    "OIDC_GRANT_TYPE_REFRESH_TOKEN" # Optional, if you need long-lived sessions
  ]
  
  response_types = [
    "OIDC_RESPONSE_TYPE_CODE"
  ]

  redirect_uris = [
    "http://localhost:3000/api/auth/callback/zitadel",
    "https://rag.tuxmart.io/api/auth/callback/zitadel"
  ]

  post_logout_redirect_uris = [
    "http://localhost:3000",
    "https://rag.tuxmart.io"
  ]
  
  dev_mode = true # Allows http for localhost
  
  # Access Token Type: JWT (Self-contained)
  access_token_type = "OIDC_TOKEN_TYPE_JWT"
  
  id_token_userinfo_assertion = true
  access_token_role_assertion = true # Include roles in the token
}

# App 2: The Resource Server (Backend API)
# Used to identify the API and provide an Audience
resource "zitadel_application_api" "tuxmai_rag_api" {
  org_id           = zitadel_project.tuxmai_rag.org_id
  project_id       = zitadel_project.tuxmai_rag.id
  name             = "tuxmai-rag-api"
  auth_method_type = "API_AUTH_METHOD_TYPE_PRIVATE_KEY_JWT"
}
