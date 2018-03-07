provider "azurerm" {
  subscription_id = "{{subscriptionId}}"
  client_id       = "{{clientId}}"
  client_secret   = "{{clientSecret}}"
  tenant_id       = "{{tenantId}}"
}

terraform {
  backend "azurerm" {
    storage_account_name = "{{back_end_storage_account_name}}"
    container_name       = "{{back_end_container_name}}"
    key                  = "{{back_end_key}}"
    access_key           = "{{back_end_access_key}}"
  }
}

resource "azurerm_resource_group" "MyAppRg" {
  name     = "my-tests-rg"
  location = "North Europe"
}
