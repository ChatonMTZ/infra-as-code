provider "azurerm" {
  subscription_id = "${var.subscriptionId}"
  client_id       = "${var.clientId}"
  client_secret   = "${var.clientSecret}"
  tenant_id       = "${var.tenantId}"
}

resource "azurerm_resource_group" "MyAppRg" {
  name     = "my-tests-rg"
  location = "North Europe"
}
