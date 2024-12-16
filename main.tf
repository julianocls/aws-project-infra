terraform {
  required_version = ">= 0.12.25"
}

# Regiao do provider
provider "aws" {
  region = var.region
}