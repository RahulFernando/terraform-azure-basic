terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
  subscription_id = "4921b5f0-14c7-48bb-9954-0b0d779ea309"
}

# Create a resource group
resource "azurerm_resource_group" "terraform-basic" {
  name     = "rahul-terraform-basic"
  location = "East Asia"
}

# Create a storage account
resource "azurerm_storage_account" "terraform-storage" {
  name                     = "terraformrgsa1"
  resource_group_name      = azurerm_resource_group.terraform-basic.name
  location                 = azurerm_resource_group.terraform-basic.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    terraform = true
  }
}

output "terraform_sa_endpoint" {
  value = azurerm_storage_account.terraform-storage.primary_blob_endpoint
}
