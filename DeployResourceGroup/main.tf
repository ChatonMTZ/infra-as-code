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

resource "azurerm_resource_group" "AppRg" {
  name     = "app-${var.environment}-rg"
  location = "${var.location}"
}

resource "azurerm_app_service_plan" "AppServicePlan" {
  name                = "app-${var.environment}-sp"
  resource_group_name = "${azurerm_resource_group.AppRg.name}"
  location            = "${var.location}"
  kind                = "Windows"

  sku {
    tier     = "${var.appServiceTier}"
    size     = "${var.appServiceSize}"
    capacity = "${var.appServiceCapacity}"
  }
}

resource "azurerm_app_service" "AppService" {
  name                = "app-${var.environment}-as"
  location            = "${var.location}"
  resource_group_name = "${azurerm_resource_group.AppRg.name}"
  app_service_plan_id = "${azurerm_app_service_plan.AppServicePlan.id}"

  site_config {
    dotnet_framework_version = "v4.0"
  }

  client_affinity_enabled = "false"
}
