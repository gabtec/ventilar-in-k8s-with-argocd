# --------------------------------
# Providers and Versions
# --------------------------------
terraform {
  # terraform version
  required_version = ">= 1.4.0"
  # required_version = "1.4.4"

  backend "azurerm" {
    # variables can not be used in this block
    resource_group_name  = "tfstate-rg"
    storage_account_name = "tfstate8kkwo"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.51.0"
      # version = "2.66.0"
    }
  }
}

# --------------------------------
# Azure
# --------------------------------
provider "azurerm" {
  features {}
}
