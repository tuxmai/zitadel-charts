terraform {
  required_providers {
    zitadel = {
      source  = "zitadel/zitadel"
      version = ">= 1.0.0"
    }
  }
}

provider "zitadel" {
  domain           = var.zitadel_domain
  insecure         = var.insecure
  port             = "443"
  jwt_profile_file = var.jwt_profile_file
}
