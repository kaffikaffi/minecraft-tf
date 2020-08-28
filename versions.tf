terraform {
  required_providers {
    azure = {
      source = "terraform-providers/azure"
    }
    azurerm = {
      source = "hashicorp/azurerm"
    }
    random = {
      source = "hashicorp/random"
    }
  }
  required_version = ">= 0.13"
}
