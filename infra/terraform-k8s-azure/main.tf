# --------------------------------
# Providers and Versions
# --------------------------------
terraform {
  # terraform version
  required_version = ">= 1.4.0"
  # required_version = "1.4.4"

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

# todo...