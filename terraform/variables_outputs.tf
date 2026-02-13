variable "zitadel_domain" {
  description = "The domain of your Zitadel instance (e.g. login.tuxmart.io)"
  default     = "login.tuxmart.io"
}

variable "insecure" {
  description = "Set to true if using plain HTTP (e.g. localhost without TLS)"
  type        = bool
  default     = false
}

variable "port" {
  description = "Port of the Zitadel instance"
  default     = "443"
}

variable "jwt_profile_file" {
  description = "Path to the JSON key file for the Service User used by Terraform"
  default     = "terraform-key.json"
}

variable "org_id" {
  description = "The ID of the Organization to deploy to. Find this in the Zitadel Console (URL or Settings)."
  type        = string
}

output "project_id" {
  value = zitadel_project.tuxmai_rag.id
}

output "frontend_client_id" {
  description = "Client ID for tuxmai-eda-agent (Frontend/CLI). Use this in your .env"
  value       = zitadel_application_oidc.tuxmai_eda_agent.client_id
  sensitive   = true
}

output "api_client_id" {
  description = "Client ID for tuxmai-rag-api (Backend). Use this as Audience or for Introspection"
  value       = zitadel_application_api.tuxmai_rag_api.client_id
  sensitive   = true
}
