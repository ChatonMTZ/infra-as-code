provider "azurerm" {
  subscription_id = "{{subscriptionId}}"
  client_id       = "{{clientId}}"
  client_secret   = "{{clientSecret}}"
  tenant_id       = "{{tenantId}}"
}

terraform {
  backend "azurerm" {
    storage_account_name = "{{backendStorageAccountName}}"
    container_name       = "{{backendContainerName}}"
    key                  = "{{backendKey}}"
    access_key           = "{{backendAccessKey}}"
  }
}

resource "azurerm_resource_group" "MyAppRg" {
  name     = "my-tests-rg"
  location = "North Europe"
}
