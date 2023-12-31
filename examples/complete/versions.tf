# -------------------------------------------------------------
# Terraform providers
# -------------------------------------------------------------

terraform {
  required_version = ">= 1.4.0, < 2.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.67.0"
    }
  }
}
