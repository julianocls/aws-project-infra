terraform {
  backend "local" {
    path = "./.terraform_state/terraform.tfstate"
  }
}
